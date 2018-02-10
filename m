Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-91218-1518277618-2-13693587416865791005
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
    t=1518277617; b=lHUOCUNocTNZh8m02+7M/+XzGkcSODg72w0s3QFqKFn0h4K
    pUhFv/O3tiuqzCRGD5/HVLpM/d1zkqToa9VBQUwTAt/9qzt1EvEpN0H6VDUackwL
    l1Y+8Li1yTO6ggxMW3DUELolxtjitp/4PvWl1PKy4JliU/zV4Eki+t/2VEJx+3Wm
    2VDb41hASTNcCNKmhQRYLw/ZQZjUZhfbOplmnGknirifenDqapXEy6C6/9fffU0I
    GdE2gcVev/qeJd5R5xdNjYZfEhxmbX9fDooANYkc8RkzJv7hvAZrEWxI3SFMvwXz
    9QgURS/OhE2dmKWEiBgl+ezewOutbF3o5iHbV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518277617; bh=GSzNEfxV7q3xDhW7ldX+XO56B/s6Hv4YzuS9JaVxaxk=; b=F
    UL8TGqrgcwtuBqavfjAi8Qs+EmFOSegxcfqPeReCBRKNtDOvV6/K6aOYvyhvYmXG
    G+VvzSJVvj87hGJ5Ub4cPtUhOFJ4SI+5qbsMhcDyxUOc9uS9+7NND0kkCPU5iTr1
    n7jS1FcribqyG7bskOhgHNUmX78FAhQKLXpXk3oXaJ/nn8NkzaslhEk80CApQewP
    Yf4T6u0fohKkMtKPVWz97NaGWJj8YVgysj/Z1Wa/aE/M6QO+eJ8Y6lbLEIT87Fcz
    0oucx1nEtK9McLY5c5XdRmnBvKDp0eyHpq+gLzh0K69zSVF35mXKfTtFcdtzeOYO
    9DOiWwPvaKxZefWGcEQRg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hSdH9gJs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FR2iLON3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hSdH9gJs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FR2iLON3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeBJPqy (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 10:46:54 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:35209 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBJPqx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 10:46:53 -0500
X-Google-Smtp-Source: AH8x225NNOcMTqCNK76KCO5iqNpeAqJ7DXH0TpzrB7443C7tDjzWDJeAI99LK8yKHETpKDipTsbHiA==
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180209133931.211869118@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
Date: Sat, 10 Feb 2018 07:46:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 05:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.81 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 11 13:39:04 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 140 fail: 5
Failed builds:
	powerpc:defconfig
	powerpc:allmodconfig
	powerpc:ppc64e_defconfig
	powerpc:cell_defconfig
	powerpc:maple_defconfig
Qemu test results:
	total: 118 pass: 113 fail: 5
Failed tests:
	powerpc:mac99:ppc64_book3s_defconfig:nosmp
	powerpc:mac99:ppc64_book3s_defconfig:smp4
	powerpc:pseries:pseries_defconfig
	powerpc:mpc8544ds:ppc64_e5500_defconfig:nosmp
	powerpc:mpc8544ds:ppc64_e5500_defconfig:smp

All builds and tests fail with the following error.

arch/powerpc/kernel/setup_64.c:41:25: fatal error: asm/debugfs.h: No such file or directory

For older kernels, the backport of 236003e6b5443c4 ("powerpc/64s: Allow control of RFI
flush via debugfs") should include linux/debugfs.h, not asm/debugfs.h.

4.4.y-queue is affected as well.

Guenter
