Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1603081-1521557278-2-6928455614231795594
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521557278; b=OyoRSpHodjK+2DWMZh9dnf78G0JDu0aQEBcuxHprJywU0Ov
    MmdhHokDFhDa82mmww2t1Ypj3TXy9Y4aE9nqLcTPWEywS2U1LB0b3EORw1xE1aMT
    q/80byMCG/xmk1rAUtq0rQ3eMTFLgxxiW0wSsw8anI3nA6oT+6giwuuN6BgzVg3C
    y5zWbtTECVAvYFGBRiGO7MFGZqvNrHkGDozzNVdzoXagxN9jBxf0FHt9fXelnw6K
    5CnHnttOAfVg0aDqsP1PB7KF13A+Kuso+qoOSb2iO002jbA4RlIcWpoz+tpSuDG7
    HcmOQqaP1Amoxi2bEySmElHno5ZbApByT4nD4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521557278; bh=W45VFDXt3n0L7Fc+jAN7NbRMvn
    Mrd6rpe6CDDypUUjU=; b=WdyIk9rBPoOtWY7EIFUsLIaYX6Hk9CDplaDXmQ9WKu
    k9wOCmNK0ziniKfMX/6g9rmf/JILaB6xSF2a5fNVT0KQgqCWHcVBl9TAhafZpi6W
    rPWm2JLvyPgmIDBsuAJ3Ik65fnXL6py0hUp6mkXF8KNT1NGynpWVx3+i+pCJUxIj
    D2g4BF70M9Uu2axmWAeFfnFgki0GH+hzYG5+uQnXkVoKk9I6Cs/gvqbb0AmVPjus
    9IqOHDPy5mu1WxoeKcRehaMNIWy66SZ0LmooKEUF200mKmz7KsskXxbqnC+SbYl0
    +cTCSeQJGGZc1ENSRaSZ+vEdlEu1xy+vv+rTfUy9Fcvw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J+ltqTvN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kiz895q+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J+ltqTvN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kiz895q+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeCTOrz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 10:47:55 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:46390 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTOry (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 10:47:54 -0400
X-Google-Smtp-Source: AG47ELv1cdsVf8uqvBS46O6EplXnsi2ZdVbzJsNXJ+qZcEEVzIUc5mDQWJyQcVzG3j+LxuQ9/p7uXA==
Date: Tue, 20 Mar 2018 07:47:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
Message-ID: <20180320144751.GA16028@roeck-us.net>
References: <20180319171827.899658615@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:05:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.101 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> Anything received after that time might be too late.
>

For v3.18.100-68-g290f46f:

Build results:
	total: 137 pass: 135 fail: 2
Failed builds: 
	arm:allmodconfig 
	arm:omap2plus_defconfig 

arm/mach-omap2/omap_hwmod_7xx_data.c:2109:12: error:
	'HWMOD_CLKDM_NOAUTO' undeclared here

Guenter
