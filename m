Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE289C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70F32145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B/L0wwy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70F32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403847AbeKTDRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36287 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390798AbeKTDRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so7287131plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ttZHNaBnbF4lntgoxBzHeh1qXjFVZdLtS6IDRkan10U=;
        b=B/L0wwy+dn5vG7fJT6SsYdHfRWRPp8b15m3T12pcYKj2IKGP2gNyt+NwZglKJRldb3
         4bsOoCOwkcU8ufzTG3flJg44d/ei51J0PbL900IvIbL4JB7T9gCmHc94YMXVh9E5jGP6
         YK7YMDZUkjQl+GcEpF3OOS9nKAXYh9WgLUc+X+k0nRb/b1/cXGakwgNYRDNJAIt+5mLO
         vqEPL3pby20Yf7ppz0lJxMIv/O0KiTFpO9p1N6dT5CH4VsIxKN8tniHAIF7D5jpvKJjm
         aT10/GFiEiUnGAlvjMfwxOVDVSdsBeKsYV5JSSzY4iHWNxCZ84A+9ERQyPbcGcaS8exB
         yyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ttZHNaBnbF4lntgoxBzHeh1qXjFVZdLtS6IDRkan10U=;
        b=atHmk9/HJmI2EwWLLoYmZGX+X+T4qRenQ26WG8spaA+eXBDfPtW06ghjj+gAzQbEVX
         bL9ABC5kZ+uzkOpwSypmr5Bk0n4kDjIRKYHDpR8KOkFqR8QiUQBEbdBnu50fyyTNgjF5
         OouYPzqrhYI1WHtKM/kgbp4dIigWoDhenaMuwQD8aBEl5nSLoxA5WuRttlQOGOYGpPXC
         T9/Dl9e+u1AhrApQoDqQRiHx8yg3WxgNbej3Rf0hpsYac4rzfRwJ8oV7gEw586PrUNmV
         dtyj2s1gROFrjuj2gjVpeJzYYIIqoK60f4hEo5PkQmxQ3UwC+vq8XBIgvRVuPENfNMiI
         +Lug==
X-Gm-Message-State: AGRZ1gLQI92R2s+uuhiXay1tEGRnMclIX3lAIgJGd2BHiMALkL/c767a
        GKMTq8Nm/fqQinG+S89yEzqD2g==
X-Google-Smtp-Source: AJdET5em3zKbfoXv8oC8+p3p6i+9Vhm6QtVoW5kPLxknBqqopSyOoNFN4nTmRHB2EWBH1v/hs98OKg==
X-Received: by 2002:a17:902:6b82:: with SMTP id p2-v6mr23315505plk.50.1542646416393;
        Mon, 19 Nov 2018 08:53:36 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u76-v6sm59747963pfa.176.2018.11.19.08.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 08:53:35 -0800 (PST)
Date:   Mon, 19 Nov 2018 08:53:35 -0800 (PST)
X-Google-Original-Date: Mon, 19 Nov 2018 08:52:10 PST (-0800)
Subject:     Re: [PATCH v2] riscv: add asm/unistd.h UAPI header
In-Reply-To: <CAOesGMhgBxu+L-R5OaEdBjv4jGSY3AnB9LqaKvWKKUgEKBabjw@mail.gmail.com>
CC:     david.abdurachmanov@gmail.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, marcin.juszkiewicz@linaro.org,
        linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Olof Johansson <olof@lixom.net>
Message-ID: <mhng-b667387d-ef0f-45aa-8e22-ed828d410161@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 18:39:45 PST (-0800), Olof Johansson wrote:
> On Thu, Nov 8, 2018 at 11:02 AM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
>>
>> Marcin Juszkiewicz reported issues while generating syscall table for riscv
>> using 4.20-rc1. The patch refactors our unistd.h files to match some other
>> architectures.
>>
>> - Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT only for 64-bit
>> - Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
>> - Adjust kernel asm/unistd.h
>>
>> So now asm/unistd.h UAPI header should show all syscalls for riscv.
>>
>> Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
>> generated asm/unistd.h UAPI header thus user didn't see:
>>
>> - __NR_riscv_flush_icache
>> - __NR_newfstatat
>> - __NR_fstat
>>
>> which are supported by riscv kernel.
>>
>> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Fixes: 67314ec7b025 ("RISC-V: Request newstat syscalls")
>> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
>
> Acked-by: Olof Johansson <olof@lixom,net>
>
> This fixes the 32-bit build error I'm seeing here as well. Palmer, it
> would be nice to have 4.20 compile 32-bit kernels still.
>
> Per builder logs:
> http://arm-soc.lixom.net/buildlogs/mainline/v4.20-rc2-133-g1ce80e0fe98e7/buildall.riscv.rv32_defconfig.log.failed,
> actual errors are:
>
> include/uapi/asm-generic/unistd.h:247:29: error: 'sys_fstatat64'
> undeclared here (not in a function); did you mean 'sys_fstatfs64'?
> include/uapi/asm-generic/unistd.h:249:27: error: 'sys_fstat64'
> undeclared here (not in a function); did you mean 'sys_fstatat64'?

Sorry, I missed the v2 here.  I'll include it as part of this week's PR.
