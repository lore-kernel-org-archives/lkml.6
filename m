Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3751275-1527055309-3-823120420404008248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527055308; b=azAvKED2E8idvwa6vgLIDmmNUWAOnMkuzucB1u/KjsuVKd/n8Z
    fhzuOQzEIau/SoKnkbFc9NMoXFKmqqKEwdNAmzrT6aUkyUVvNSNnLiFSg59XAOaW
    M+qn68pgq/cEBkCucm/VE61U5uOuRcT4WCWeU5Os5s5xocUtX5yAQWzmtRMCO48H
    YoVn5lMK5Kf17tAXtftmry+vI/UND8nuVRYX+kygiI+tLcqALpVtP8f9Hi4YaFH5
    Byg/Y5XG6bGjjvfxO2rYs7YHZqO2fZ4Tm9ALuBrmlVfsUtC43prVsJF28O6yzDul
    elLKxZxHVKPkISw1NFS5ea0wiBbamEGnoxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527055308; bh=xn5WyXxdVckPPxfIBSvC/15Y1fEwuu
    Kyos9qSUT3BTU=; b=mxTxpHqYmJ5hY555LnX/wqbEyqrX/gAbh5iej+BPcSr4a3
    NPM7ZXa+4ufgCOMR3p1H2EdYdBaOxRhKF0vbNi1+IROUejYfKht6qHKxMMRFp8s5
    HeSTk4WVwzP2LjBj/Nwy49LW13GVoDKdr3jYT7py9lvTuHCP0YsNbZKjF0zc+BpA
    qvbpP0x2vuLtI+z/QeTJ98w0bSvBElRFn6mYQubuJ+WkYHLEfJIvFZOgyyLOTRTc
    KCN/+dWmhey2C076X0KQpkqSyWPSqTDB8aBqo7EFpZ7x3DH5tKwVSRCM1pgHNczw
    jDmB39mXBI39ojENhUpQj/uFiFg8wHEO8463uqSQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VFcs+3dK x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=VFcs+3dK x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPXQyWQcv5m9StXnGzWtfI8S38zzONGDLJtm8fDPFQ1SsECBXGnl47/pzu1XTFoH3wsZvw8pNCJfk9DuqQOIQsp5BiQgwGOgLT9iNYO5iDVHiNXRuMP
    Uxc/nN5ROvOFRfflw11cwWZHMLc+ig6Ys/3z/uLyyK72xvmNSZtEiQsXZUJV4+z4sAjK7jtUz6tlc6JXwd7SXE5chZFQMINvGf5mzr4LQBygZyFCJEiVQA5q
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=QwK3zxdBwoPrVwGfhKIA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeEWGBq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 02:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753826AbeEWGBp (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 02:01:45 -0400
Date: Wed, 23 May 2018 08:01:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
Message-ID: <20180523060125.GB13397@kroah.com>
References: <20180521210503.823249477@linuxfoundation.org>
 <7b374b54-7cba-8575-92ad-cfdb8a06b509@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b374b54-7cba-8575-92ad-cfdb8a06b509@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 02:45:00PM -0600, Shuah Khan wrote:
> On 05/21/2018 03:10 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.11 release.
> > There are 110 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue May 22 21:04:14 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.11-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing and letting me know.

greg k-h
