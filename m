Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0B2C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D1F21D69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxO31moF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D1F21D69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeHIPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:51:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39619 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHIPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:51:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id w14-v6so2562818plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/zX9LLbulyf4tILJ9npe5ESwtXih8ZBeMBP1v/2P9A0=;
        b=oxO31moFX0vGVtDUp4Rgk9/tEuDN0Vo8iSDyyd1SlpZITqw8dWpUAAfAyY6/H872ou
         tDDcTj/sTmC1vy+zX7g9ej9Shz5yQdczR74pmTFfxoP6HQsy+JVWiMjYNj6uuBiIRKuo
         dFJV7N1qwaT8ZBwZxqQXp2P245HD6kSzBh0gsyn2/QIY4h927tvf0CBVhu8vCQDTSJg+
         qq8y3+FpLHl9C0C2T6GKiM3bN5h33w9O43ZIogW4WtvqKVDzrFMjWbhOdQswEf41qgWh
         gxmh+zp2GpWQ8m2sjTA5SVwKN+ECWtUhaoTdb10ygG7FI0uKoxeQpeH/5lJv8dpSGkVJ
         FExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/zX9LLbulyf4tILJ9npe5ESwtXih8ZBeMBP1v/2P9A0=;
        b=rCwkYKvbvqGUjLMdQVq+ZDPOs65w4QtLDf5hXH5zauEh7wskTuIaViziVwqTbdyycm
         6KJ6IYnb7cCbo7tgRkrkqD6grVJ8puKRPWQm7UL9B1NWHypmh0Vsef0SmDnpJawDoMQG
         jT0ZcvYalSpF5YZa7mX5Uwbn3DR1drfCvzP9GDScMJ4zhSH5Tk3ZPPXFLKIXelEPqnt6
         Homv5gjQSUXCM4WwovjBA9ODmJQL7KGcO5w1g+ASDXqyzjTkGERI1ObUyLlfa7Su2Oj2
         tyTeia0ktbzcKlsjVmsDHnr6T9sw/c8XYL0iVKsnIWuSVUiKYJnwuWQGSebs8qjHFJcV
         p06w==
X-Gm-Message-State: AOUpUlE5TPogmkg97qxsIlA7dv3gF1qdCvQEtgQ0GXhjC+DtksEVxf2L
        HIFpNtZ1Ae/+zn7/vx+2Oos=
X-Google-Smtp-Source: AA+uWPyH6+rozU+16HiuUoUlmS9ZbpggeDBv60GNX52ECL48RoW8eEZpBDZQBLKnD0GWaCTPJOmkEw==
X-Received: by 2002:a17:902:654b:: with SMTP id d11-v6mr2099915pln.8.1533821174587;
        Thu, 09 Aug 2018 06:26:14 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x184-v6sm9779054pfd.169.2018.08.09.06.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 06:26:13 -0700 (PDT)
Date:   Thu, 9 Aug 2018 06:26:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
Message-ID: <20180809132612.GA31058@roeck-us.net>
References: <20180803195344.22271-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180803195344.22271-1-palmer@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 12:53:44PM -0700, Palmer Dabbelt wrote:
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

Fails to build riscv:allnoconfig.

CC      arch/riscv/kernel/syscall_table.o
./arch/riscv/include/uapi/asm/syscalls.h:29:36: error:
‘sys_riscv_flush_icache’ undeclared here (not in a function); did you mean ‘__NR_riscv_flush_icache’?

Guenter

> ---
>  arch/riscv/include/uapi/asm/syscalls.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/syscalls.h
> index 818655b0d535..882a6aa09a33 100644
> --- a/arch/riscv/include/uapi/asm/syscalls.h
> +++ b/arch/riscv/include/uapi/asm/syscalls.h
> @@ -1,10 +1,11 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2017 SiFive
> + * Copyright (C) 2017-2018 SiFive
>   */
>  
> -#ifndef _ASM__UAPI__SYSCALLS_H
> -#define _ASM__UAPI__SYSCALLS_H
> +/* There is explicitly no include guard here because this file is expected to
> + * be included multiple times in order to define the syscall macros via
> + * __SYSCALL. */
>  
>  /*
>   * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
> @@ -20,7 +21,7 @@
>   * caller.  We don't currently do anything with the address range, that's just
>   * in there for forwards compatibility.
>   */
> +#ifndef __NR_riscv_flush_icache
>  #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
> -__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> -
>  #endif
> +__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
