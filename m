Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97983C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BBE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BBE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeLJDUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 22:20:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:65338 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeLJDUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 22:20:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 19:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="106187326"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.164.250])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2018 19:20:19 -0800
Message-ID: <0f9d668e8ed77ef17ba029e15b52fa817e49dbdb.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: fixes incorrect error handling
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     bianpan2016@163.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Sun, 09 Dec 2018 19:20:18 -0800
In-Reply-To: <nycvar.YFH.7.76.1812092144440.17216@cbobk.fhfr.pm>
References: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
         <CAO-hwJJDhtNqy6gc9OJ+rHnJimrQeAoxxkay5XnfXjxMtvEufQ@mail.gmail.com>
         <nycvar.YFH.7.76.1812092144440.17216@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-09 at 21:45 +0100, Jiri Kosina wrote:
> On Fri, 7 Dec 2018, Benjamin Tissoires wrote:
> 
> > > The memory chunk allocated by hid_allocate_device() should be
> > > released
> > > by hid_destroy_device(), not kfree().
> > > 
> > > Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
> > > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > > ---
> > >  drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c
> > > b/drivers/hid/intel-ish-hid/ishtp-hid.c
> > > index cd23903..e918d78 100644
> > > --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> > > +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> > > @@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
> > >  err_hid_device:
> > >         kfree(hid_data);
> > >  err_hid_data:
> > > -       kfree(hid);
> > > +       hid_destroy_device(hid);
> > 
> > Looks good to me. Srinivas, any comments?
> > FWIW:
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > Jiri, do you think we should send this one as 4.20/fixes material
> > or
> > wait for 4.21?
> 
> Given that this has been around since 4.9, I wouldn't be devastated
> if it 
> lands only in next merge window. So I'd just put it to 4.20/fixes and
> wait 
> for other more serious trigger for sending that to Linus eventually.
> 
Agree.

Thanks,
Srinivas

> Thanks,
> 

