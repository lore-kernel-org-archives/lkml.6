Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A540FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6830121479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtQ6EHfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfACWov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:44:51 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35321 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfACWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:44:50 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so13875355ywk.2;
        Thu, 03 Jan 2019 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKFfDtyw0jobwE9IpFeHnlj2yY9oKEKBvvvLjdeRxj4=;
        b=QtQ6EHfx+ee/NcNzvKvsiYN5dl/PLMrYR6isRV4w4YN9O7Tktw8s4Fr+PK3R5jGYtf
         XPLx1oniPgdbtil+qG93cDLA9bv5aZd2QTTiPeruk4g9VRrtQGFH4ZZJbcAdh5I/R7D0
         PJRW2XVqLmldFDl0TXT1SRSQE+7JRIlNFIZqOhBIUcoai+iX8EyTtVGGT68DoZ425Q3J
         bKeCj+dYa7240uxBdTV+yiHA9x6QJse8fyeM+a6F2v0vvP1p7gteNu3IlzCo5LZ/9GM5
         fMYEDtAb8OjE5Jdh+94XnOFpE0E+GdmGEUu8uDmEbcuMEPnCeTf4gZD6ed7OsT6g4qSP
         SLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKFfDtyw0jobwE9IpFeHnlj2yY9oKEKBvvvLjdeRxj4=;
        b=bhq2f716LLzFcy8SBNToRtlFrykPMrMXHcZBbJ5NQGVP4zLGiD/B67EtrhON6z0snL
         oYAnhbp/Xc56H7i+SW35Tjz0SP+8JfQ10bysQuOWgeBfCbTrri9zt8egCIPCU0zNFXJb
         oOTKyHb10ZNUB6Ucir+62InZCfBrBPCnS9JzdW7Rlt7a52OG5gW6jQb90PHX8gSFWFnJ
         7o3FpuLTFYDMOi3i/uuSz6kJAmFpqogB8s1N+aGFaam60f5VdLkFVSDyVOhKBmLO5WB3
         TNJVq9yGfMqOaz8WPi4yIIM7d2z87yvh2dQQrMmQgkqVjP/RPEfaWzWaTJh/KJTYwg7l
         CjIA==
X-Gm-Message-State: AA+aEWbqDX0pnFO0Th219PHYj2f1jLji6M+CO7XxOQZPQj/eMIlLUaT/
        4Oe/VgIKW9zW0ZolPwL1fB6zPdQK0pa79AB7v+w=
X-Google-Smtp-Source: AFSGD/Uygz1kpdunO9nD9f1K1Z6mb+fiq0pe0NyETPesgZfVyuDL9L7b8qkrMAQ5wGzdZvPUXEAe5usJ03HOcN8jfF4=
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr50202557ywe.496.1546555488803;
 Thu, 03 Jan 2019 14:44:48 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org> <1546442912-20818-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546442912-20818-3-git-send-email-firoz.khan@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 3 Jan 2019 14:44:37 -0800
Message-ID: <CAMo8Bf+qK=k33boeNOeL69sLC3e-M07QK9ErhYm-byuQ2UnVnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: generate uapi header and syscall table header files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> Unified system call table generation script must be run to
> generate unistd_32.h and syscall_table.h files. This patch
> will have changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> xtensa/Makefile and the generated files against the removed
> files must be identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscall.c file.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/xtensa/kernel/syscalls/Makefile      | 11 ++++++++--
>  arch/xtensa/kernel/syscalls/syscallhdr.sh | 36 -------------------------------
>  arch/xtensa/kernel/syscalls/syscalltbl.sh | 32 ---------------------------
>  3 files changed, 9 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
>  delete mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/xtensa/kernel/syscalls/Makefile b/arch/xtensa/kernel/syscalls/Makefile
> index 659faef..75c7421 100644
> --- a/arch/xtensa/kernel/syscalls/Makefile
> +++ b/arch/xtensa/kernel/syscalls/Makefile
> @@ -6,8 +6,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')       \
>           $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
>
>  syscall := $(srctree)/$(src)/syscall.tbl
> -syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +syshdr := $(srctree)/scripts/syscallhdr.sh
> +sysnr := $(srctree)/scripts/syscallnr.sh
> +systbl := $(srctree)/scripts/syscalltbl.sh
>
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'       \
> @@ -15,6 +16,12 @@ quiet_cmd_syshdr = SYSHDR  $@
>                    '$(syshdr_pfx_$(basetarget))'                \
>                    '$(syshdr_offset_$(basetarget))'
>
> +quiet_cmd_sysnr = SYSNR  $@
> +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'         \
> +                 '$(sysnr_abis_$(basetarget))'                 \
> +                 '$(sysnr_pfx_$(basetarget))'                  \
> +                 '$(sysnr_offset_$(basetarget))'
> +

This patch seems to do more than it says in the description.
Perhaps adding cmd_sysnr needs a separate patch with its
own description?

-- 
Thanks.
-- Max
