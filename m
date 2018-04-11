Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2932816-1523467650-2-6079098874127508093
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
    1523467649; b=h7qaSxc4wXw1ATQln9hw5/MVeM32xWCHcuPjol8bKPoC/lUdWu
    S0/j5o01s/NmRxsiPdyrw2oC8OoBz93EB/iMYIqQS2Mectbgiqf4MahcTIS8VH6c
    lpU2bGr2HLyCXpq47kDdi6FiOky/PFe+Yde2qxqtHf+os2ult/amUKCufXstZom/
    WhQr0Ya5BhTMN/00OQb11HZK/mF1TIzRTM6WYEJDz58Jsv3VFbaf2bo4Y99EUc3/
    U3sRZGFDZnVt90XpgaeuUyzv+gAM0AfBLzUgv4ni4lU/pDhHpWKjieuwOxIDvlxR
    gUI/Tczc7QEQLMvqUPBgOabb6ZkYYfqtpQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523467649; bh=ZbDGhGk2EvkIZSRzJWqqWwXUU+pAGI
    pEZRDkYxOIxGc=; b=JnLLijNVgYHwLNmcdyWcqySP/UDvHXxvkPIz8q4l3xoHWr
    7C4NcDg5zHdWpx6iL/i+/ZJiEYuIN2mVCy/PWzb+3hKG61sLCbSfsg49142EXEJr
    KzJvyj+bGFS1ZdqKW03xm7jCk3E7club3BVEmpx01L7Q1mLIyw6mvu9AY9nL0Brv
    MLDd93p34xGUV5Oa5w0ks9ytYL8bT3qgm8tG6dgeCDVl0qUAswYxvyPrOA3CKqxa
    dFCCYCoghwXMTdcLEwkQiAXcOB0MFUtQX3FPw431jx4tb9YHxOQwPjYHHLOTLL+q
    +SS/N5oOyK85hgVVxq9+3sEhgSHgLoHDPdu5EUCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F4tZ4cl1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TQn40Azf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F4tZ4cl1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TQn40Azf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGqQ+RsqmJtb7Shckfg2TSUzJnV00SMiJdaBFWywDOr5CFKweoVwJr3axyr1r89nQUVxMyi6zPDyqUHrcnDFtlhwuN4mdm/Vke9y//p4kemlSzfA6/Y/
    GrfP4oV/QfZ7sTdM77NdvxknKX0UMDoRt+623T9YhYu/vkPFbf88MP5hpyIMcNJAHk6FYiThJeJzv8FdjSAJuh3egXB/Rldw0uv+uSrml8kRsulKg2g7v12c
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=QQrbzgpHJRgA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=DVHRodg5v2k42cNmqGIA:9 a=CjuIK1q_8ugA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeDKR11 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:27:27 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:46146 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDKR10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 13:27:26 -0400
X-Google-Smtp-Source: AIpwx4+fauCnxPLW2tW/nHJ1ab45US1KP7sE9khl8Igv2c6aOX0CFC6sBGjj8veKdXZdGr2Ilzg+yA==
Date: Wed, 11 Apr 2018 10:27:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/18] 4.16.2-stable review
Message-ID: <20180411172724.GC27459@roeck-us.net>
References: <20180410212758.564682823@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 12:23:35AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.2 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Apr 12 21:27:41 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 142 pass: 142 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
