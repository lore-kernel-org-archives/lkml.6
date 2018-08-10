Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8822C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D082223FE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9sFyPLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D082223FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeHJQhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:37:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42038 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHJQhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:37:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so4456883pgp.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VKSr1XWQ/gAPkObZAAA6FEmoXD0MAQE+StNOKXjfFdA=;
        b=q9sFyPLDo3efRcuOHXEWdqBD5khAdbnb50KpNc3bWz823BGkVTU+STmkHwhefb5ivj
         pwKe7edQCfc/8ZOM73CGU0c7l2rE+wzNDI3Cou2G0OmHQPS8CV+iFRI8Oy1LlZt+10VX
         rGm9oMPIaT1S8V5zIX4z8UI8mm5RanfrF+xN8uWSx64bp5/GMCfRhckNp2x6rOJkt+uL
         7hPVdC/pVh1A1HfzBBqv/yhL12dNGO+rW49tXH3RDAouI26KgzrINOpRZ0JMTS3bE8Af
         SAttkjFHMWy/HFCzj8DIjdlOj4MUpQ6et71Rmcv9T8pqnlrh6AqWjXZxAD2ahsypKxZL
         h5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VKSr1XWQ/gAPkObZAAA6FEmoXD0MAQE+StNOKXjfFdA=;
        b=hh3Vgtv6IqtjuoiBSFeN+bVZ3WSObn40dO1tO3Ww8CCJDM7shjoEjUrthbr+b1SzRh
         bDkyYUc6J8JBJhNwXh9rCTaO6ToRtyT2q2yeFRrmUR81F+e2w+DQ9DtNOTN5TXzNu3ET
         qUdi11CoHn1Z3OM3j2QiZmZ+wp7omsNSEe4lRWVhmRa3icq7ChyDd4tqTsfTUeKqxsWR
         Q9BDZJSC3GUsWvrsOHWO1ALuu1bPaUHjWf8EiAA5HLZhrijw3E/5L0/LQjbfhMvLU1Sr
         n2Ixm0yjpnOEYWMkF2EVkf8kfBL586FxoW1dKj7lvXWMSgKIAViZB/NQLurK7YjTNirp
         zI9A==
X-Gm-Message-State: AOUpUlG/RXQog2lGQvUaiPydK6+M2+HZPyCqnxny4LjDyUA8aivTesMa
        pMUGt4lGuWss2HQhJhjIlI8=
X-Google-Smtp-Source: AA+uWPzYnWs01NFLhZJdq/ViNgIh7bC1Wucuuir5TFQNojTDDBKL+0zRK74jG+a4+so5TzPxdMteww==
X-Received: by 2002:a63:d04f:: with SMTP id s15-v6mr6848842pgi.42.1533910070792;
        Fri, 10 Aug 2018 07:07:50 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w72-v6sm18171316pfa.26.2018.08.10.07.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:07:50 -0700 (PDT)
Date:   Fri, 10 Aug 2018 07:07:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        tklauser@distanz.ch, Arnd Bergmann <arnd@arndb.de>,
        Andrew Waterman <andrew@sifive.com>,
        linux@dominikbrodowski.net, dan.carpenter@oracle.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH v3 2/2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
Message-ID: <20180810140749.GB13061@roeck-us.net>
References: <20180809221952.24260-1-palmer@sifive.com>
 <20180809221952.24260-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809221952.24260-3-palmer@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 03:19:52PM -0700, Palmer Dabbelt wrote:
> This file is expected to be included multiple times in the same file in
> order to allow the __SYSCALL macro to generate system call tables.  With
> a global include guard we end up missing __NR_riscv_flush_icache in the
> syscall table, which results in icache flushes that escape the vDSO call
> to not actually do anything.
> 
> The fix is to move to per-#define include guards, which allows the
> system call tables to actually be populated.  Thanks to Macrus Comstedt
> for finding and fixing the bug!
> 
> I also went ahead and fixed the SPDX header to use a //-style comment,
> which I've been told is the canonical way to do it.
> 
> Cc: Marcus Comstedt <marcus@mc.pp.se>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/riscv/include/asm/unistd.h        |  5 +++++
>  arch/riscv/include/uapi/asm/syscalls.h | 15 +++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index 080fb28061de..0caea01d5cca 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -11,6 +11,11 @@
>   *   GNU General Public License for more details.
>   */
>  
> +/*
> + * There is explicitly no include guard here because this file is expected to
> + * be included multiple times.  See uapi/asm/syscalls.h for more info.
> + */
> +
>  #define __ARCH_WANT_SYS_CLONE
>  #include <uapi/asm/unistd.h>
>  #include <uapi/asm/syscalls.h>
> diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/syscalls.h
> index 818655b0d535..690beb002d1d 100644
> --- a/arch/riscv/include/uapi/asm/syscalls.h
> +++ b/arch/riscv/include/uapi/asm/syscalls.h
> @@ -1,10 +1,13 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2017 SiFive
> + * Copyright (C) 2017-2018 SiFive
>   */
>  
> -#ifndef _ASM__UAPI__SYSCALLS_H
> -#define _ASM__UAPI__SYSCALLS_H
> +/*
> + * There is explicitly no include guard here because this file is expected to
> + * be included multiple times in order to define the syscall macros via
> + * __SYSCALL.
> + */
>  
>  /*
>   * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
> @@ -20,7 +23,7 @@
>   * caller.  We don't currently do anything with the address range, that's just
>   * in there for forwards compatibility.
>   */
> +#ifndef __NR_riscv_flush_icache
>  #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
> -__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> -
>  #endif
> +__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> -- 
> 2.16.4
> 
