Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A122BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5672C20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P+NpAvTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5672C20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeKLHLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:11:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36695 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeKLHLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 02:11:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id d13-v6so3292611pfo.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4ACm6Uzc4H59VdfPYRJKhXWsdkoS01SqiW1/mSyC0ZA=;
        b=P+NpAvTd2nQNneNfHDrjIwgakcylAKJmk8qD2j+ayfZat2gx3ylCz9nB79OZIP0ejv
         2dI1yAFke5FNjjGWsnd8Gn7t1dSVzT3swfv22Y3w0Aqk58JqvdQZ9wH+Z4DXamxtvMXh
         RY9BYEZutmyKW+fUgnk2z9oN21RwBeU0fTRaGNA/f1YWFPCz0QdRYZSggSJLY+Ca8jMY
         1WCKBoBb+FijPu/AbZdrCHu216bji89oE/ugZdETvViwPJgbtMVAA/VVIFJD07jH9ZLe
         m8YFEBcAnqpdCsEUCUl3vSAceZIYbC6dqzA3psUzcIlQIPEIeyYHdA3TjFpbPVh5lCz/
         3xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4ACm6Uzc4H59VdfPYRJKhXWsdkoS01SqiW1/mSyC0ZA=;
        b=hsKeqrwKy9PxxHyi4o63d71u6dPXe1YpqruZtEHT2zarXJcQLTAiHScG7qSZzKVS4t
         OIQuuRTATYOtnhk+4av+ni3pEeeQonaHDQlB0Zyir7eEhHl5ZX1RxJJCFmH3RHSL92cb
         N1NmBzbF1AZjEsyuC1x1augIZcv+OsU6g4M/lETXgnIQpIF45fCWHqfFtln144ay61qN
         payCITD3sGAw8FF1YXKAp/NuP/tXUP9ZQ9D1pVAN3/3PRt3xTZmVLdfHCCimyuwhfRHS
         asqrliXBk4AI/MaGgb4mfvM3c52W7Qe6ozKnIYQVVzL8cJ6sDgk/hGz/vyIMxUO144SG
         v/hQ==
X-Gm-Message-State: AGRZ1gJEUU/3f+JProxsxX3dbnkhP5BkdsJY2LjMCUpDMU+P8L4vmZtm
        ytDoPOp78Aixi2iU7JZVtXt5gw==
X-Google-Smtp-Source: AJdET5c+Z+E9zcyAWV22Q+Mwz05yjZRUfMQ0EYD/teQJw9PMwU4zvARj8i+GuQC/JSedec3GabGpeA==
X-Received: by 2002:a62:85:: with SMTP id 127-v6mr17404886pfa.24.1541971285447;
        Sun, 11 Nov 2018 13:21:25 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j187-v6sm15853836pfc.43.2018.11.11.13.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 13:21:24 -0800 (PST)
Date:   Sun, 11 Nov 2018 13:21:24 -0800 (PST)
X-Google-Original-Date: Sun, 11 Nov 2018 13:20:33 PST (-0800)
Subject:     Re: [PATCH 12/13 v2] riscv: define syscall_get_arch()
In-Reply-To: <20181109224833.GA2710@altlinux.org>
CC:     luto@kernel.org, lineprinter@altlinux.org,
        david.abdurachmanov@gmail.com, aou@eecs.berkeley.edu,
        paul@paul-moore.com, eparis@redhat.com,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     ldv@altlinux.org
Message-ID: <mhng-11f5dbf6-0aee-4f6e-b184-63536ecc3ac5@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2018 14:48:33 PST (-0800), ldv@altlinux.org wrote:
> syscall_get_arch() is required to be implemented on all architectures
> that use tracehook_report_syscall_entry() in order to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Based-on-patch-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/riscv/include/asm/syscall.h | 10 ++++++++++
>  include/uapi/linux/audit.h       |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index 8d25f8904c00..bba3da6ef157 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -18,6 +18,7 @@
>  #ifndef _ASM_RISCV_SYSCALL_H
>  #define _ASM_RISCV_SYSCALL_H
>
> +#include <uapi/linux/audit.h>
>  #include <linux/sched.h>
>  #include <linux/err.h>
>
> @@ -99,4 +100,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
>  }
>
> +static inline int syscall_get_arch(void)
> +{
> +#ifdef CONFIG_64BIT
> +	return AUDIT_ARCH_RISCV64;
> +#else
> +	return AUDIT_ARCH_RISCV32;
> +#endif
> +}
> +
>  #endif	/* _ASM_RISCV_SYSCALL_H */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index c4c8b131af48..1b199a77a6b9 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -405,6 +405,8 @@ enum {
>  /* do not define AUDIT_ARCH_PPCLE since it is not supported by audit */
>  #define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_RISCV32	(EM_RISCV|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_RISCV64	(EM_RISCV|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_S390		(EM_S390)
>  #define AUDIT_ARCH_S390X	(EM_S390|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_SH		(EM_SH)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
