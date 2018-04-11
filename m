Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2881586-1523467606-2-6160339738531178388
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523467606; b=ienJTAnoNumAxz61XLGjvfJzOAemWeCXw6KKvRGUfP7m79EjOE
    oaLCE0c1qdmMgMxotCw7mXVyfFbvFQkKLds3w4lBa0BH2yfDHpKNcaRR+YkN2QmW
    qMi3CfQpmlY8iam9SlendkAM0+qYwXlZWDm2zQm8UYXG/I+nDPUqVp9j4wmidCi0
    +p+v0CC1R1JVaZGzsIzGQKqCx2CSJ620gexMaq7iIs2Lu5oiviQdwLqqYJE8RVQW
    OUMTLEvxgIeHD4At8MSpC5V35bImELJgeljSR0CUj8kZM4lYFwFlfdviti43c905
    S56Yk5LVgNb7VpfUKKhvSEoeGjxaCBhQTV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523467606; bh=+kG32+9+Y8fEwyAnfi01gYl6YQqAlg
    leDMGQyX95SKE=; b=AW2M4KkrWeaKsOOW3P/eUAZag73kOJNx0/tYTQ40ckjbkR
    nVMhh3iQUYTiLFBnqRWufJMR3wY+5lb9IqdiCty7LcmYaI+Z6x2EGxDQE1550eUN
    HgEPYyqSVYXdB0Pp5cHILrG5ygJ8uuHVod+90PBTB7dpQ3uRHVgW+QO4kMYaRB17
    ghoDo5fVGf0XeBNBrUiO1+ogK3L2b+l+D60k27XZHE18lCyictmwjPfU0gUfQ2rf
    ueUDLl0rcZlyWXgCb+EZ2dvkXMb7VhquBYKZW+xkL8ulLdlbJshS5th8JuB9t7se
    KpSveLuRK/BriqISmnzx2WvbE6okAnPl/hjEZ6Vw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=buaEq46v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IEzT6Hsb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=buaEq46v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IEzT6Hsb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHn5na1SkwVN1iMfxh5/yAVe53jAfWrzwJuVhlKxFCwkWLLwzRrJWoYgxAW0Wh6GsWRzBk/u+Bzj6H0LIpmbnqnVDwTQjMQv96i7+1y2fUx/15MffUWK
    rveuk1Eisgw7b/0HwdCQklrscJHYOdr2isna4Sguu45PdJH8csJhKKLcOoxQEUqLporbnHWiEIjePWWIOuqakFgZHHqUQfSzbgMWjCGnbtTRJrY50dXgJgGb
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=DFuB5R5a5QQA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=a82mNqcrrigP4_w5aFwA:9 a=CjuIK1q_8ugA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDKR0m (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:26:42 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35316 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeDKR0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 13:26:14 -0400
X-Google-Smtp-Source: AIpwx4+HFyWNkITufgCztV3iziSUYHoGiOal056y8VygZuSxJ1tGfrLT6mHB/H4OXPK/mmOH1ALGyA==
Date: Wed, 11 Apr 2018 10:26:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/138] 4.14.34-stable review
Message-ID: <20180411172611.GA27459@roeck-us.net>
References: <20180410212902.121524696@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 12:23:10AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.34 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 12 21:28:20 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
