Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-268172-1518790310-2-7597397799583364043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518790310; b=qRZVsMxy6CI81a4Nc7HWKkn31IgHbPquLh+Omh+T/FcOo5H
    Rvx7XFqVOCzd1Rm2h1hsd8KnO5YgnkqvXQDqyVikQHc/Hx8CtqMiUzRK5Pp7Hfws
    Y8D9auH9DpOKGzi7pFThwXs6lbyqjGXxLv7yfeRtOwps7v/HoCqGzVIRCkzv+yra
    7gOCl80/D4GIwvM2ITrvFUS+qqYk2yuEu9TWFWmN8ZOMBOHkpxm28bvB2ZEn4/OM
    bOc123cERexzcvsKzDNoGoky89rL+QAvmmCHtdjUcmUl0kGmyoYivBgZNpN6VZQ5
    t02v+GXbAOXn5CG5NGflsXOvNkV28Hwi2wnU6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518790310; bh=kSi6VAQqa/K7FmfCMj3ey2oe1F8KA/RcPcI0XqzJRIQ=; b=w
    tKdE82jq/HSICtpmCoESM0tRwhNLOOD0YDzdLttO4Osrc+ZhWjunkC0XSG3/qU8u
    KiFONunHc3MSMCrPgfmA5wP3w9PxhnEQM3O8zzWgXAp4t2cdLoKTeK44hzMh19R8
    B++wxWgbmhNVEtlwhoQwMVGuYL8LGA3vGMwYUz0OQivPdgjpM/zqeL8sfVXnwYtu
    mcJsP0XmzECAK07BUspBrQvyGkqJA1eE+MRvXP+XgJLB4XbbaRK0mN0zOM8UEBiG
    CEkxCDbejo62CmcEi3kvUUHaW7eQlMV3wOGKvQf40gmYh6nh6XMSbMn3D8/IbYvu
    2PEqtAIT5yVqCLny71C5Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jbliuGLC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QvVy0ZXm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jbliuGLC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QvVy0ZXm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033832AbeBPOLs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:11:48 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35827 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033729AbeBPOLr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 09:11:47 -0500
X-Google-Smtp-Source: AH8x224N9YFIIbC7ySeltEQMTIBiMJ32Cf9GSahNqn+EASxS0cXrmUjlGK2BEAJiw7QhZJJSeOr5ig==
Subject: Re: [PATCH 3.18 00/45] 3.18.95-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180215144115.863307741@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1b45b6a-87f4-89db-0652-4bb9924d5b56@roeck-us.net>
Date: Fri, 16 Feb 2018 06:11:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 07:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.95 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 17 14:40:54 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 135 fail: 1
Failed builds:
	arm:axm55xx_defconfig
Qemu test results:
	total: 112 pass: 112 fail: 0

Build failure:

Building arm:axm55xx_defconfig ... failed
--------------
Error log:
arch/arm/kvm/handle_exit.c: In function 'handle_hvc':
arch/arm/kvm/handle_exit.c:48:3: error: implicit declaration of function 'vcpu_set_reg'

Details are available at http://kerneltests.org/builders.

Guenter
