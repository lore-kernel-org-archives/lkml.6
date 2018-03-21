Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3946841-1521635348-2-3419219113752896575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521635347; b=eOejLDsJEIbkpPaiUzfWFIklKK97+CwONUkQchDINM/Iqap
    Bnx5agsWTlNCNFRT0h4XCUXbX8SBk7XpIcN8t7+aLXo0U+mQAd4qphHu1fMO1lut
    LG6Jwn9CFE6VzLhMGlLr9LS3BX632hpzpt7HMC6Ia6XaqMvNmXhOgIEfglq3/wm7
    /LSJ+uTBL5IkK6iJOvma3GyXXJGr29bpPRseclny76YQCV0yD0el3+ft3xK8R7bR
    dP2zr3Aygk0auV7aCFrvt4HnB/hzLb0AabQogqfr0aCjFeumCd5SLnuscEFOcCz1
    awecI3HMukakywIZwv1J8oGNmHYi52xWPXIqU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521635347; bh=Wy3UpCnXeFSABLcR2gv2FQRrQO
    w1cck3i7vpiieliYY=; b=bvqTPUAX111cOv8oBYOPpJdAMS6S74xtCt9ERnRaRL
    GiHQL1FY5kvrKyBdpb/dq5JQ+/R+bpU+epKr4+xM7srNQEAA9H7qnLtBEn452ZUx
    Er66uJe4U0BtshKgXjiCevUOFIHzrbe8pcfHwfm1KnjX+0Ys73cHNVZqnpPJ8GEV
    NPYT+xkYLVtJDNgrOq64YYUIZ6U/ig7Oi4PwFfprRXmJDpSTyKC2F8ZPKeCLqoSm
    drfP3iF9KZI2G0BIPZf7INkYu5Y5G6eC/DOM5yTv1pbEWOuLeEJphXEv9JAXVSlI
    SgBFX103PxZXwXBTgOOLWSyc8R9ThqGCXbXLkagKoR7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCUM3G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 08:29:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeCUM3F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 08:29:05 -0400
Date: Wed, 21 Mar 2018 13:29:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
Message-ID: <20180321122904.GA1860@kroah.com>
References: <20180319180734.976730813@linuxfoundation.org>
 <20180320161139.GB671@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320161139.GB671@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 09:11:39AM -0700, Guenter Roeck wrote:
> On Mon, Mar 19, 2018 at 07:07:58PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.12 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
> > Anything received after that time might be too late.
> >
> 
> For v4.15.11-53-g3c07abd:
> 
> Build results:
> 	total: 147 pass: 147 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Thanks for testing these and letting me know.

greg k-h
