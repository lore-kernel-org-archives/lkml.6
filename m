Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-296820-1518790794-3-9425468296635763330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518790793; b=HGlRpTCT4n8OcwOtPj2wHy24LojIibbo/Y5jtePMCkJPeyf
    nDI2UxDsn0e9ApqBT9sU9ECXp3ofoaLSOc6Mffke6b9Y37OlSBBZqezp713qFUID
    1O1RFoREZ8RfVPWAgWKKiC/sKYltmoWaE3hCl8xgvLR1m6i047ti8Rnok+UYGuDa
    K7XwYoK2v+sdywRo/bO0T51Ar+aIZlgI/bwmpwtFxA2NSegK0/jcSEZMouWIqw+q
    W3JDajkBYsa6K5jI457CgrKbJ9JXMze1F0S1errHh+J990/Itsd0AQv6/+gmFH9G
    c3ofHzqUf5cKSigIemU6MySTTSVtckRxkORHErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518790793; bh=qstVd0SnRGtteodkXrgZlCw/hVdQ9jrVOCZYuVT7kMI=; b=Z
    dw2k5G6pbVljQljhDjghkOeuXFwAYdZxMmqO0aw6vzdqwdg7WERx6qjHpDElukwy
    a4A90F9SJP+rcBqSGty9KGvHu+Zf7l7/eYDBCk0wvoa3RcN6+oOmUq+LArnMa4Q5
    pZ1mQaMJzON1SPZtJtO1JgsWAfL2VlmBc38pEUor2UYVa1ViWIYrIzOULYyke3BK
    BCF6tJBV1Z8AeZSM7M+irCuiSzcQVjpV902W1rsmgABH2SZd88GgvKtfKaRTSwbz
    lNZd9DcGaYFCZsSDYaUVNd10r2vrEAGMoSgt6EUcN2uJshFXnJpP5W/exLOWW1Qa
    tP21IPwlkDZB2+r1fKDSg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ULblHSaG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aou4P8Ws;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ULblHSaG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aou4P8Ws;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034045AbeBPOTu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:19:50 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45442 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033347AbeBPOTt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 09:19:49 -0500
X-Google-Smtp-Source: AH8x224Bin7gENMiSqEmzpy5SPO6m1waMaAUB/ahcthiLbI/ajEqKxfB5ZGXoXquF8ith3EyBfg0Mw==
Subject: Re: [PATCH 4.9 00/88] 4.9.82-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180215151222.437136975@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cb0f5a5e-05ac-c52d-9334-40bbfc87a245@roeck-us.net>
Date: Fri, 16 Feb 2018 06:19:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 07:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.82 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 17 15:11:46 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 137 fail: 8
Failed builds:
	arm:allmodconfig
	powerpc:defconfig
	powerpc:allmodconfig
	powerpc:ppc64e_defconfig
	powerpc:cell_defconfig
	powerpc:maple_defconfig
	powerpc:ppc6xx_defconfig
	powerpc:mpc83xx_defconfig
Qemu test results:
	total: 126 pass: 119 fail: 7
Failed tests:
	powerpc:mpc8544ds:mpc85xx_defconfig
	powerpc:mpc8544ds:mpc85xx_smp_defconfig
	powerpc:mac99:ppc64_book3s_defconfig:nosmp
	powerpc:mac99:ppc64_book3s_defconfig:smp4
	powerpc:pseries:pseries_defconfig
	powerpc:mpc8544ds:ppc64_e5500_defconfig:nosmp
	powerpc:mpc8544ds:ppc64_e5500_defconfig:smp

Build failures:

Building arm:allmodconfig ... failed
--------------
Error log:

drivers/clocksource/timer-stm32.c: In function 'stm32_clockevent_init':
drivers/clocksource/timer-stm32.c:191:2: error: implicit declaration of function 'kfree'

Building powerpc:defconfig ... failed
Building powerpc:allmodconfig ... failed
Building powerpc:ppc64e_defconfig ... failed
Building powerpc:cell_defconfig ... failed
Building powerpc:maple_defconfig ... failed
--------------
Error log:
arch/powerpc/kernel/entry_64.S: Assembler messages:
arch/powerpc/kernel/entry_64.S:260: Error: unrecognized opcode: `rfi_to_user'
arch/powerpc/kernel/entry_64.S:270: Error: unrecognized opcode: `rfi_to_kernel'
arch/powerpc/kernel/entry_64.S:885: Error: unrecognized opcode: `rfi_to_user'
build/arch/powerpc/kernel/entry_64.S:900: Error: unrecognized opcode: `rfi_to_kernel'

Building powerpc:ppc6xx_defconfig ... failed
Building powerpc:mpc83xx_defconfig ... failed
--------------
Error log:
drivers/crypto/talitos.c: In function 'talitos_sg_map':
drivers/crypto/talitos.c:1131:3: error: too many arguments to function 'to_talitos_ptr'

Details are available at http://kerneltests.org/builders.

Guenter
