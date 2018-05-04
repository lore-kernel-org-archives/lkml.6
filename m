Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4011366-1525421804-2-6397810019640214550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525421804; b=cCJAkUFG8Mri9MqaFh1IJI1us7n5i3ncQSUravIt+oMVhrhWnd
    G6danfWbw5+c62qkLNukB7XvGWiMEOUB4IhoBpswUUKf3AUv641OuionFt3V7oEt
    vuS+doKfEe9Dht1rDsGATuZrjb8odi8jCv/lLqVKGX1600nxhbaHV6Wg4cJRNnYu
    yHMj+8S+EKtgEo915ZfN55+WYA8YPtm9NluKy41Y5LRJe3xC3/S4P0P5PZA1sRnw
    wBl/vunKLcBmFSddrc2Hwtpjv1Mk5nqJXX7czx90d/mPn97eC5v+NLIaGZOu3SO2
    iUjIp4QYcELl3cdoyeW89l+54tEdxNHesoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525421804; bh=+tYcscdtIVYRCxTfSr7BjywOTEVyhK
    56rhhn0tTHln0=; b=JEWEVPjxu0p/QKVMEasuXFn5Iciv8uosyVFisNMC7LD/v6
    Ux4kN1koWZT97JPcnh48xuOofa3Fw9ZUDy2U/n1IZLChMp7YO3qTDcJ8MjyCIoP+
    VJF5itrfDQJdwc9EKE4nWf0KKun/p/XgGQnA5jeFKs6VdGXs/ISEZApYhekI04p6
    16LKwy5WEQOXWqqWke6qvaGijst4CSpOVNp9lY1Zm72I63a1Yhd589CgjOrqyTAj
    4MD5nkLxSRi5kFlyfhjthDxyknkcR/1LFb6OcC+jO9H35oXnj4CtJtSEWc2sqAUd
    2MomkVo08F8VYLD4BwWvWKcgN1qpX/aoDgxVyWvw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAhr8YbYKwECqkxigna9bM+Wg35GncfTLhKV69sivsJPlW3ID4ZKSa0SFAbs+6NOTy5vMuIYJeMAFv5Iv9m17mU4qbZuF6e5OLq4cDbGEwCbyGV9h1xs
    2d1QHTN3qaPoQP7KcER5NcBj/480c29olN7XSjFaYNznrACpC8695F/MKTQUP5afvKs2tL1crrU4oLgG/U0v0+c0nV2fJjc2DDLqdmxiPyit72UwrRaWMlPP
    NVru/zBedGFg7Z8RK1Xz9g==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=oizDT3At7Xe9AQrWW3IA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeEDIQk (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 04:16:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:41763 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbeEDIQi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 May 2018 04:16:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="52350325"
Date: Fri, 4 May 2018 11:16:34 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: 'Jason Gunthorpe' <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-integrity@vger.kernel.org'" <linux-integrity@vger.kernel.org>,
        "'linux-security-module@vger.kernel.org'"
        <linux-security-module@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Message-ID: <20180504081634.GB6373@linux.intel.com>
References: <5B8DA87D05A7694D9FA63FD143655C1B94252660@hasmsx108.ger.corp.intel.com>
 <4984305eae452b7a72b8a13aa20cecec420df580.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94252945@hasmsx108.ger.corp.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B942627FD@hasmsx108.ger.corp.intel.com>
 <20180424160328.GA5119@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94272F33@hasmsx108.ger.corp.intel.com>
 <20180502133246.GA6091@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B083@hasmsx108.ger.corp.intel.com>
 <20180503063508.GA8702@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B9A6@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9427B9A6@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 06:42:26AM +0000, Winkler, Tomas wrote:
> 
> > >
> > > >
> > > > On Tue, Apr 24, 2018 at 08:04:01PM +0000, Winkler, Tomas wrote:
> > > > > > Subject: Re: [PATCH] tpm: tpm_crb: relinquish locality on error path.
> > > > > >
> > > > > > On Fri, Apr 20, 2018 at 01:19:12PM +0000, Winkler, Tomas wrote:
> > > > > > > > > On Tue, 2018-04-10 at 09:00 +0000, Winkler, Tomas wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sat, 2018-04-07 at 19:12 +0300, Tomas Winkler wrote:
> > > > > > > > > > > > In crb_map_io() function, __crb_request_locality()
> > > > > > > > > > > > is called prior to crb_cmd_ready(), but if one of
> > > > > > > > > > > > the consecutive function fails the flow bails out
> > > > > > > > > > > > instead of trying to relinquish
> > > > > > locality.
> > > > > > > > > > > > This patch adds goto jump to
> > > > > > > > > > > > __crb_relinquish_locality() on the error path.
> > > > > > > > > > > >
> > > > > > > > > > > > Fixes: 888d867df441 (tpm: cmd_ready command can be
> > > > > > > > > > > > issued only after granting
> > > > > > > > > > > > locality)
> > > > > > > > > > > > Signed-off-by: Tomas Winkler
> > > > > > > > > > > > <tomas.winkler@intel.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/char/tpm/tpm_crb.c | 10 +++++++---
> > > > > > > > > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/char/tpm/tpm_crb.c
> > > > > > > > > > > > b/drivers/char/tpm/tpm_crb.c index
> > > > > > > > > > > > 7f78482cd157..34fbc6cb097b
> > > > > > > > > > > > 100644
> > > > > > > > > > > > --- a/drivers/char/tpm/tpm_crb.c
> > > > > > > > > > > > +++ b/drivers/char/tpm/tpm_crb.c
> > > > > > > > > > > > @@ -511,8 +511,10 @@ static int crb_map_io(struct
> > > > > > > > > > > > acpi_device *device, struct crb_priv *priv,
> > > > > > > > > > > >
> > > > > > > > > > > >  	priv->regs_t = crb_map_res(dev, priv, &io_res,
> > > > > > > > > > > > buf-
> > > > > > > > > > > > >control_address,
> > > > > > > > > > > >  				   sizeof(struct crb_regs_tail));
> > > > > > > > > > > > -	if (IS_ERR(priv->regs_t))
> > > > > > > > > > > > -		return PTR_ERR(priv->regs_t);
> > > > > > > > > > > > +	if (IS_ERR(priv->regs_t)) {
> > > > > > > > > > > > +		ret = PTR_ERR(priv->regs_t);
> > > > > > > > > > > > +		goto out_relinquish_locality;
> > > > > > > > > > > > +	}
> > > > > > > > > > > >
> > > > > > > > > > > >  	/*
> > > > > > > > > > > >  	 * PTT HW bug w/a: wake up the device to access
> > @@
> > > > > > > > > > > > -520,7
> > > > > > > > > > > > +522,7
> > > > > > > > > > >
> > > > > > > > > > > @@
> > > > > > > > > > > > static int crb_map_io(struct acpi_device *device,
> > > > > > > > > > > > struct crb_priv *priv,
> > > > > > > > > > > >  	 */
> > > > > > > > > > > >  	ret = crb_cmd_ready(dev, priv);
> > > > > > > > > > > >  	if (ret)
> > > > > > > > > > > > -		return ret;
> > > > > > > > > > > > +		goto out_relinquish_locality;
> > > > > > > > > > > >
> > > > > > > > > > > >  	pa_high = ioread32(&priv->regs_t-
> > >ctrl_cmd_pa_high);
> > > > > > > > > > > >  	pa_low  =
> > > > > > > > > > > > ioread32(&priv->regs_t->ctrl_cmd_pa_low);
> > > > > > > > > > > > @@ -565,6 +567,8 @@ static int crb_map_io(struct
> > > > > > > > > > > > acpi_device *device, struct crb_priv *priv,
> > > > > > > > > > > >
> > > > > > > > > > > >  	crb_go_idle(dev, priv);
> > > > > > > > > > > >
> > > > > > > > > > > > +out_relinquish_locality:
> > > > > > > > > > > > +
> > > > > > > > > > > >  	__crb_relinquish_locality(dev, priv, 0);
> > > > > > > > > > > >
> > > > > > > > > > > >  	return ret;
> > > > > > > > > > >
> > > > > > > > > > > Thanks, please just call it before returning in the error path.
> > > > > > > > > >
> > > > > > > > > > Can you please elaborate why, isn't the centralized
> > > > > > > > > > exiting of functions preferred kernel coding style?
> > > > > > > > > > https://www.kernel.org/doc/html/v4.11/process/coding-sty
> > > > > > > > > > le.h
> > > > > > > > > > tml#
> > > > > > > > > > cent
> > > > > > > > > > ra
> > > > > > > > > > lized-ex
> > > > > > > > > > iting-of-functions
> > > > > > > > >
> > > > > > > > > You exit only from one location (not multiple) and not
> > > > > > > > > from a nested context. Here you just add more complexity by
> > doing this.
> > > > > > > >
> > > > > > > > Where is the complexity ? I see it as a standard way of
> > > > > > > > undoing on
> > > > exit.
> > > > > > > > Tomas
> > > > > > >
> > > > > > > Jarkko, can you please respond.
> > > > > > > Thanks
> > > > > > > Tomas
> > > > > >
> > > > > > I was away for Mon-Wed last week and did not work on TPM for Thu-
> > Fri.
> > > > > >
> > > > > > My earlier comment was incorrect as there are two locations to
> > > > > > exit (not sure how I managed to overlook the patch that way).
> > > > > >
> > > > > > Thus, I have only two very  minor requets:
> > > > > >
> > > > > > * Remove the extra newline (the last line addition in the patch).
> > > > > Okay
> > > > > > * Use just label named out as we have only one exception handler.
> > > > > Cannot do that, as the bail out is prior to cmd_ready request so
> > > > > there is no
> > > > need for go_idle which is under out label.
> > > > > >
> > > > > > I'll move on to testing, and if it it passes, I can do those updates
> > myself.
> > > > > Thanks,  I prefer to resend myself.
> > > > >
> > > > > Tomas
> > > >
> > > > Add my tested-by as it is cosmectic change, thanks.
> > >
> > >
> > > What change exactly? I had impression you've accepted the patch as is?
> > > Thanks
> > > Tomas
> > 
> > Hmm... maybe there is some misunderstandig but I thought you were going
> > to make the updates above yourself and send a revised patch.
> 
> 
> Probably,  if I remember there were to mails going in asynchronous, I've received your tested-by, the second I've sent this answer,
> so I thought you came to the conclusion that there is nothing to change in the patch yourself.
> Frankly I've checked the patch and there are no even extra new lines in my version unless it has scrambled on the way.
> 
> Thanks
> Tomas

The only thing was the label name. That is why I asked if I can
change it by myself instead of you having to send a follow up
patch. Did you send a new one? Did not find it from patchwork.

/Jarkko

