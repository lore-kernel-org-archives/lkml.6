Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3705410-1527677444-2-17154183178218742528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527677444; b=JFEyRk/nnBYmUSvt45X1WiI9pOClu0F0gFL2Q1xKWcrHcx6W/r
    Y2u9ya+f9tQ//twkh0wZ+IRTK+cjzqb0cJtBwrUeXmAgTCEvH7uQ0hqt9QtWwTqk
    JoGmUvPVKC+IMONPdCpNbS6TijeYtFfBc0/UpeP0JVdbZHVAfcAHjIfcCXkoDZy3
    czbeF+/1k6nes2WxFgv0mFzMG7xTrPs6K6id7KIPp5g5+gP41AZH7yqBx9UscFNl
    VlwK+mY4WTf51kQhUbuyR0YrwFzVH5Sa3QLRD1NbOti3rgbOV2i/QQRa+yE7u/nc
    qz+2bxM7DPaNz33dggTFQbyRrGGy4v1VykDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527677444; bh=qv0mIP++xq62UEslXisq8lmQNJFFTO
    iA5BB9+pIWlvA=; b=CWhL6VhLLrZE8bgS+Ts0f2PjZgBnRWuLtRmh1sVns8k/25
    qf8PS2rNGnprlSM5rf754gpZ0nU255ynppri24t3opx85Dw5/K94rAc6u7KpxoD6
    S4th26+/6zVMEmUQ8zQbwj6zY6Vz1zy08smWH8675jSRc4iHUg2otUKTxm241huD
    gDl5UpJREmIXzE1Y38iWWrnuvKCcE8Zg/TXvkM/I6nOUCjMWjt0zz3ARC7GVHjzz
    IQTCnzVQa1eSG0RnQr1GVAl08njHejpb7/PLVSqglAMnWdAssvLTvGhjJXz1SexE
    kZjsLTlfoYdhd1byKbJZ0eZfAOkdquQhk4swgKTw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM0S0f2vViUhFF0PURBTznnMdaBxkVebYlG5v2b7Sx7+p7RoHfB33MM1q21OuQZ+V9TG5Pf0NJn57RMkZTPur6w8FRF4yd2nqh1e73CAQNcjWV2DDeyu
    CY36pxwXwiCYgrOiQjqUNuosd6tbvhh7NT1AotiYug/IzmR+fZqUw7gz1MzNgtiewcENgCzT3ITHFntcx5mzKjKjbSsrLctZxpDeqNzqigfEeOEQH6kgJRIT
    vl2Vdow7TBNDyDhK4ddJ/g==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=LzkEGVOH4XMo8DHQWuUA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeE3Kuk (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 06:50:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:34894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbeE3Kuj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 06:50:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="scan'208";a="43913396"
Date: Wed, 30 May 2018 13:50:34 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180530105034.GA14905@linux.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
 <20180523131616.GD363@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 01:48:17PM +0000, Winkler, Tomas wrote:
> 
> > On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas wrote:
> > > >
> > > > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > > > > New wrappers are added tpm_cmd_ready() and tpm_go_idle()
> > wrappers
> > > > > to streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag
> > is
> > > > abused
> > > > > to resolve tpm spaces recursive calls to tpm_transmit().
> > > >
> > > > This looks good and all but I don't think we want to abuse anything
> > > > in the driver code, do we?
> > >
> > > It's not abuse just the flag UNLOCKED is not really named correctly I
> > > think this has to be backported so wanted to do less invasive change.
> > 
> > It should be renamed anyway and possible merge conflicts are not hard to
> > sort out in this change. Can you rename it as SPACE?
> 
> Not sure, I believe UNLOCKED is still better name than SPACE, I'm not sure this is 
> Do you also want to remove TPM_TRANSMIT_RAW? 
> clk_enable is handling its own anti recursion counter 'data->clkrun_enabled' 
> but it should be all handled under one flag I guess.
> 
> > Right, and even without rename this will probably cause merge conflicts at
> > least in v4.4 an v4.9 since in-kernel RM landed in v4.12, so not much gain not
> > do the rename :-)
> 
> I belive we should do minimal change and the big cleanup after that.
> Not sure, I believe UNLOCKED is still better name than SPACE even it wasn't the original intention.  
> No the SPACE is the issue, but any recursion call into tpm_transmit. A bigger change is needed
> and rename to SPACE would be just another intermediat change.
> 
> Please reconsider.
> 
> Thanks
> Tomas 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
