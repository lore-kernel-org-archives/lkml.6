Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97FAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAAD2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfAaIqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:46:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:6854 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfAaIqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:46:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 00:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="142996204"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2019 00:46:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 31 Jan 2019 10:46:05 +0200
Date:   Thu, 31 Jan 2019 10:46:05 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        badhri@google.com, Adam.Thomson.Opensource@diasemi.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Correct the PPS out_volt calculation
Message-ID: <20190131084605.GN7262@kuha.fi.intel.com>
References: <20190130031353.100228-1-kyletso@google.com>
 <20190131073125.GM7262@kuha.fi.intel.com>
 <20190131080100.GA16000@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131080100.GA16000@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 09:01:00AM +0100, Greg KH wrote:
> On Thu, Jan 31, 2019 at 09:31:25AM +0200, Heikki Krogerus wrote:
> > On Wed, Jan 30, 2019 at 11:13:53AM +0800, Kyle Tso wrote:
> > > When Sink negotiates PPS, the voltage range of selected PPS APDO might
> > > not cover the previous voltage (out_volt). If the previous out_volt is
> > > lower than the new min_volt, the output voltage in RDO might be set to
> > > an invalid value. For instance, supposed that the previous voltage is
> > > 5V, and the new voltage range in the APDO is 7V-12V. Then the output
> > > voltage in the RDO should not be set to 5V which is lower than the
> > > possible min_volt 7V.
> > > 
> > > Fix this by choosing the maximal value between the previous voltage and
> > > the new min_volt first. And ensure that this value will not exceed the
> > > new max_volt. The new out_volt will fall within the new voltage range
> > > while being the closest value compared to the previous out_volt.
> > > 
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> > 
> > Fixes: c710d0bb76ff0 ("usb: typec: tcpm: Extend the matching rules on PPS APDO selection")
> > Cc: stable...
> 
> No need for stable, as c710d0bb76ff ("usb: typec: tcpm: Extend the
> matching rules on PPS APDO selection") only showed up in 5.0-rc1.
> 
> Note, no need for the extra digit on your sha1 listing, here's the
> recommended way to show this:
> 	git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"

OK. Thanks for the hint!

Cheers,

-- 
heikki
