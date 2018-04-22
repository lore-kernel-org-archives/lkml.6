Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3391238-1524428044-2-12437811226544585177
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524428043; b=jKo4Kl3F+/H0aRjTcoddFg0q3RwCl5i11N1E/IculscIvKyc0t
    bjeHUcrjWmxjVnLHGJ7KaLH5bLLfYueMz0fvT34EdNbPULrqr/cfgYtaL0x5jgzX
    41OHIZjP7Db2fbwqwkkL8NNT83a+UeJMXNZiDzS8o/y/2uo7STnEUI9rznkfacM9
    j6juSpmdXaviiksNQGhdmn1zIhsvgiDhkbL9fCzFGkDm1c1e0KIgmPZx+3mz9Uaw
    YLMt/EtZyO9uZiy2+8tX4bBc3aXagYfJXt5Wxi/n2DHKQv8CFSwX/cP87qQjgfXr
    XJBPtFkKQAt/NZHeX2u++ILqVsawUKb/HrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524428043;
    bh=ESjuKwU8FmndrDfUgJgKIO4KJXfgQlS/Azxcz4n9Jsc=; b=L4GNGoud3riU
    ziyQOScRIiYjjcezD3P72A1Z56XwvjPu6oGWrkfUk82OQV7c/fhZgZIsN1hHFNmY
    F2bwe64SIz6sPrVXGv3Ap4NjBTyp+YtAeLRGvZfe0nascWcX55NEFHWBdBxbkxg0
    vHogboA7de+BjvBMwFgxlEIWNTTia0g0Rq+3T5sl17yXiOey+njz2H22s7332QzD
    L97SYFr0urjkBovO7weTAaO0Z5ZcCW+QaRALu2j+CsU+HWByxQLMfqCVkdjdteAP
    ZuR4lQpO+xHwvMdA9mGQBtjH1AbsZpC9zsH1GM1Fm83726myCw32n4VnsK5KwEDS
    VI7wxOeIpQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iO18OGQl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WdSQy581;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iO18OGQl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WdSQy581;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOgJQJpRxM4wXHAnRHv8G/KFh4qiwSP0PpGMlVj9spYKcd/rVy616qcLCmuJVbFa1IJDPb9ojK560xMdzLYFrPIRANvglvDQrralhFu0kP1Oy0g/r6T/
    wYRkUicAUDmNnvkyUZoDA1EIq1Oq5icVtSk2YgCkjLuFfi/DKw/tHuavA57IS4VlIK968zOEAHKRVuFoqK+sppmKNXLULxBrkZy2mSp/gWoM7nRvP6CSSYA/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=ubBiOwdqJCjaT3lX-HwA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeDVUN7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 16:13:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42949 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeDVUN5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 16:13:57 -0400
X-Google-Smtp-Source: AIpwx4+RpzbC7I+0i/bbYeXt3C6ycSWSPMjqXts8H82XNYbUAD16EuLtduPQL7naErTmdITkJh9Q4w==
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180422135104.278511750@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9fcfb52c-bac2-bce5-f84d-929f1045b054@roeck-us.net>
Date: Sun, 22 Apr 2018 13:13:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/22/2018 06:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.4 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> Anything received after that time might be too late.
> 


Build results:
	total: 143 pass: 141 fail: 2
Failed builds:
	powerpc:defconfig
	powerpc:allmodconfig
Qemu test results:
	total: 139 pass: 133 fail: 6
Failed tests:
	powerpc:mac99:ppc64_book3s_defconfig:initrd:nosmp
	powerpc:mac99:ppc64_book3s_defconfig:initrd:smp4
	powerpc:mac99:ppc64_book3s_defconfig:rootfs:smp4
	powerpc:pseries:pseries_defconfig:initrd
	powerpc:pseries:pseries_defconfig:rootfs
	powerpc:powernv:powernv_defconfig:initrd

arch/powerpc/platforms/powernv/opal-nvram.c: In function 'opal_nvram_write':
arch/powerpc/platforms/powernv/opal-nvram.c:61:11: error: 'OPAL_BUSY_DELAY_MS'

This problem affects _all_ pending releases.

Guenter
