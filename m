Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B309ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087202098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087202098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeIQT4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:56:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeIQT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:56:07 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 92B2EEA3;
        Mon, 17 Sep 2018 14:28:31 +0000 (UTC)
Date:   Mon, 17 Sep 2018 16:28:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     KY Srinivasan <kys@microsoft.com>
Cc:     "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
 operation was requested
Message-ID: <20180917142828.GA31799@kroah.com>
References: <20180917041352.11402-1-kys@linuxonhyperv.com>
 <20180917041455.11455-1-kys@linuxonhyperv.com>
 <20180917041455.11455-2-kys@linuxonhyperv.com>
 <20180917045613.GA25435@kroah.com>
 <MW2PR2101MB11138F9E55814399F152859FA01E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB11138F9E55814399F152859FA01E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:16:48PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Sunday, September 16, 2018 9:56 PM
> > To: KY Srinivasan <kys@microsoft.com>
> > Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; Stephen
> > Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> > <Michael.H.Kelley@microsoft.com>; vkuznets <vkuznets@redhat.com>
> > Subject: Re: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
> > operation was requested
> > 
> > On Mon, Sep 17, 2018 at 04:14:55AM +0000, kys@linuxonhyperv.com wrote:
> > > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> > >
> > > 'error' variable is left uninitialized in case we see an unknown operation.
> > > As we don't immediately return and proceed to pwrite() we need to set it
> > > to something, HV_E_FAIL sounds good enough.
> > >
> > > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > ---
> > >  tools/hv/hv_fcopy_daemon.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > No need to backport for stable?
> Thanks for pointing this out. Should I resubmit with the stable tag?

I can do it... :)

