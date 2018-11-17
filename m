Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353B120989
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="x8B41Iyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353B120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbeKQMy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:54:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37956 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbeKQMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:54:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2-v6so21152790edi.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 18:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK55K10od5KYXUDhRkOOQG4qCOgAE6VjlwueDIfT6eE=;
        b=x8B41IyqwkR+8JIku9ErRUCcujMhepzC/abYbKH23pqdpBn+js3qL+qnaZZo6+BhX3
         h9ma14kxxPc9tMriWk776mL4cAK2e+o/LEpzjG7ed/FewyKZ+D/DKBATLkvLZNr3S2Zs
         Tqjalqs35PO+YhgIaF7/eWkroXKUw0txp+b79GPtJ/G67VG9ZXKnCH9SILU2tZf/Sd3c
         6jp5UjuRTxPfcS+3zH2EP0vrsB7+aPWVgaXOSpCyRkt7tc9fwdoocOUZs+Rnvr2ENW+s
         i6DPzjKRiS+xWx34Ub3jpQr2snImC4jmrIJZO644goWi1GekpTZPc7PoHZCgNgsQWTHc
         6eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK55K10od5KYXUDhRkOOQG4qCOgAE6VjlwueDIfT6eE=;
        b=ZoSeljRX2ImJDOXbHcTCbdVRvEyJToxRae0lNM3BWuPuzprA4cgEYi5FozI5h6xkFN
         dRhXnApXVf/iXpSwCSGnKv7J9+DukIJ17yhjS1yH5DKfL/B4QBnqBNpDVS9YoNPFWW27
         LxvTDgAJrdHu+eOz4EB6rsiQYJTfeiVjXrw6mbA5NqdKvaQXtzvpBRPO4XDBqVuNKj8j
         Q5vUA7Ba//xy46BXysGRtgI6fCmiYzcE6pYzbW+5PfjssY+dkdTh9AGEykAGcI65RhLp
         tBynqykgInpRxKtpWGNOJnQXmEE+G6WVjOFOumsj4Itg0W6u/kkGCY+ul1Z+b1k3eqPH
         6zyw==
X-Gm-Message-State: AGRZ1gJ5jj6zNrNyQKrWhn34//ZQNHdIcHC4V7Ohup4J+91PXmr6y8o6
        Cc4lFehqmtoLdWhUzxpgePaHBFakACMGVFDMLO3izg==
X-Google-Smtp-Source: AJdET5cKorbgQ61H/+F6Jrw4kmXqbASvSbu+gyYqO0Xk5gvvO6TRn/jKC47N3/5oi5l3Hg8nGfcYhnSmWl2ekXSyK8k=
X-Received: by 2002:a50:9977:: with SMTP id l52mr11142793edb.277.1542422397183;
 Fri, 16 Nov 2018 18:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20181108190239.29633-1-david.abdurachmanov@gmail.com>
In-Reply-To: <20181108190239.29633-1-david.abdurachmanov@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 16 Nov 2018 18:39:45 -0800
Message-ID: <CAOesGMhgBxu+L-R5OaEdBjv4jGSY3AnB9LqaKvWKKUgEKBabjw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add asm/unistd.h UAPI header
To:     david.abdurachmanov@gmail.com
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, marcin.juszkiewicz@linaro.org,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 11:02 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> Marcin Juszkiewicz reported issues while generating syscall table for riscv
> using 4.20-rc1. The patch refactors our unistd.h files to match some other
> architectures.
>
> - Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT only for 64-bit
> - Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
> - Adjust kernel asm/unistd.h
>
> So now asm/unistd.h UAPI header should show all syscalls for riscv.
>
> Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
> generated asm/unistd.h UAPI header thus user didn't see:
>
> - __NR_riscv_flush_icache
> - __NR_newfstatat
> - __NR_fstat
>
> which are supported by riscv kernel.
>
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: 67314ec7b025 ("RISC-V: Request newstat syscalls")
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>

Acked-by: Olof Johansson <olof@lixom,net>

This fixes the 32-bit build error I'm seeing here as well. Palmer, it
would be nice to have 4.20 compile 32-bit kernels still.

Per builder logs:
http://arm-soc.lixom.net/buildlogs/mainline/v4.20-rc2-133-g1ce80e0fe98e7/buildall.riscv.rv32_defconfig.log.failed,
actual errors are:

include/uapi/asm-generic/unistd.h:247:29: error: 'sys_fstatat64'
undeclared here (not in a function); did you mean 'sys_fstatfs64'?
include/uapi/asm-generic/unistd.h:249:27: error: 'sys_fstat64'
undeclared here (not in a function); did you mean 'sys_fstatat64'?


-Olof
