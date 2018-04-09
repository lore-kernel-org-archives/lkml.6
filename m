Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-442848-1523261612-2-3218304918439310862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523261611; b=tz7VXzJP+xLcFUydanwZdST9WrsPpmF+L7ZmbR7R89UhWckVXn
    eBDnXKSfLlZ2/ena898sY2EoJFxy3BnEh/d9Uy8Fqn20SkJ9pXh0qcI7Nr/j7pzV
    PaxCT1u9nVEPPWQNBnpq5m1tnIUdmqT8EYmZMvudQM7bD0EK1kCRqzHgombBm6lD
    Dn6JT1dlbL7ggfzCQLOUXfeeAGtM6RI3f/FqFALhxvfBMxIgXfWbxRrGbEO7t1sp
    IvWD5ibiobJFcc+4NrrgA5ncDDIzduof7eIoA/ugaz/rUpO/y7y5bDb6HzB3PtDP
    pE5OVbdX+Kj+gpo76VaR25fUVNOY77eKXYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523261611; bh=3nUsot4vLRHrx2hcelr6VjbGXIlSmQ
    529p1khtbRyEs=; b=X/YEMxCP2bUJncAqHx+WgwvG9sLUU37pgUyk8v0cBtH09c
    92bDM5CP+5AvQ2V2mnETjZgZTIpLDp3VHSHySuGbEzlkkvlQkOXkiAf449DdvdAs
    eld5URiH8wIs5RuNwc1vEcX+Ri5FmKSDttgCDUK77DMqjgpv2CE68wbX66Fv3mpo
    C5VIEmUfY8w6v2MuuNySn2hXqSVYJf5A+HyvzdmnpvvzTalcJeNMkPLuXEF4nT4q
    nTDgThScBL4hzLnbeIrNpnrODrY46Z1LYC50D0djbv13MV2XVzeX7cwbeyLKDRcy
    icl6VGdfPfd0Zl4nxDH6qPDOsZ9IjqLsvagoJixQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD9ks5W0oZ/CR3OPo3G5EoZIz2DrQlr0CoMTwxDoJQXk4vYrjMGiseBOwp7TYmbpaRX0kZDB0/4ktbj0+dxGGdFo1o5nIWBPSZp2ZFr0wSictN0Lq/Um
    jw8W7WjjNe/uPHHfVsow/PmomWN8xV7QNYazTh3gVWDdWYTBIOLmBPPx2MlQ45dkJacjqoD/nz0R5wByUcBBIyrkPk2SSX5lI7PhSHW+ABccETZetzPPaNWw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=RRRRr2VPVCgA:10
    a=Kd1tUaAdevIA:10 a=0C92_-iM4gzN4pNAeA0A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeDIINa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 04:13:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeDIIN3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 04:13:29 -0400
Date: Mon, 9 Apr 2018 10:13:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/93] 3.18.103-stable review
Message-ID: <20180409081321.GA19082@kroah.com>
References: <20180406084224.918716300@linuxfoundation.org>
 <20180408140726.GB10391@roeck-us.net>
 <20180408151332.GD20010@kroah.com>
 <20180408202618.GA4729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408202618.GA4729@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 10:26:18PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 08, 2018 at 05:13:32PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Apr 08, 2018 at 07:07:26AM -0700, Guenter Roeck wrote:
> > > On Fri, Apr 06, 2018 at 03:22:29PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 3.18.103 release.
> > > > There are 93 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sun Apr  8 08:42:04 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Not full results this time, sorry (my build system is corrupted),
> > 
> > Ah, I was wondering what happened to your web results, sorry about this :(
> > 
> > > but there are various build failures in 3.18.y.
> > > 
> > > drivers/net/ethernet/freescale/fec_main.c: In function 'fec_drv_remove':
> > > drivers/net/ethernet/freescale/fec_main.c:3342:2: error: implicit declaration of function 'pm_runtime_put'
> > 
> > Gotta love how 0-day doesn't catch these :(
> 
> kernel.ci caught it :(
> 
> > I thought I fixed this up for the 4.4.y tree already, let me dig...
> 
> No, I didn't fix this for 4.4.y, that was something else.  Should be
> easy for me to resolve for the next 3.18.y release.

Ok, added the needed .h file.

thanks,

greg k-h
