Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE382216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOBXVVn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE382216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbeKLQLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:11:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45767 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeKLQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:11:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so6423618ota.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6U+tqLICzGYJyvAoJyRXt8ctDXLaB3KKit/SZjRgoE=;
        b=JOBXVVn7TVzzX5VjiPakncIqGx0mH91BCywaJ5InsQ3tDor4qK63UaYZqG2myz1W6m
         4KA5BJBwZOcJuHEuHOSeR3hzVRIpd30kJr509GtTLieq40ZaGqcGJbwE7+hrO+OYJbSp
         vFKQzSSvDeXmHkVHYnmGAgQwj+txtcJe6o5KMBUZkf826GBLO8ENSxmMMf8HO4M6K8Bx
         FdxRujGFnkJ2VMYTb/83XCmNr9rQq9xXSJVcLYdfc09SMxSh49jYvbwUDnt6JczUut+6
         aVvu6dWbS6fvgCJEfKu8YjEyQbgfxeRyKCLMIZmKfdDh7PV75JBmHr+6jvItDMNP9u50
         /ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6U+tqLICzGYJyvAoJyRXt8ctDXLaB3KKit/SZjRgoE=;
        b=euYncdpGWURfACCfCCqIX3JUIFLjU9rFMaAHOv+Jp7n7JJsDlB1DzUupY+ZhaIWmGH
         6qZ+UbPmPdoJ62PTS9MTstJS7Szl+U0DksFdtYKwjaAowC5flTvcMOYJO/DaY/3Z04Zx
         WsCtHsLf1STdlbPbTUfcnR6kMUdeGv/9FA+uztuiXsNzO3aa13tOEGbCoYv+JzzvDooC
         2OhJLH8itEujQKJe6Qo5cS+Jy+aS5eYVG6d8RUmK8hGb4E7Ijrzl/C4xPn8q8fembere
         eIeBdKtAEHOIcmLd7qDI/ERm5v4KbLOj76nrn+/XWqlXUK2ncQU7MM7M21kTwtXcuSv/
         MnnQ==
X-Gm-Message-State: AGRZ1gI2qu1sLB/c7L5Tgx3Hi4gm0VfQrF8bWc1OesS0qT4vO5ToLA0c
        lq3L/lIVwLsRpXi22DL3buzxum9x/RQCJg8R1sM=
X-Google-Smtp-Source: AJdET5efhSUJ9qFEDZSnIua0x+YB7n8X5WIOSWoWzEktyG4fofHoHLTaobbWsmH58qZ1qu93c/i0yhx6A6iy1yZG+dU=
X-Received: by 2002:a9d:3fb0:: with SMTP id r45mr10728204otc.110.1542003553581;
 Sun, 11 Nov 2018 22:19:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541995312.git.zongbox@gmail.com> <41e8cb18d321244ab7000f7dc0467b6ebc5cab8f.1541995312.git.zongbox@gmail.com>
In-Reply-To: <41e8cb18d321244ab7000f7dc0467b6ebc5cab8f.1541995312.git.zongbox@gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 12 Nov 2018 07:19:02 +0100
Message-ID: <CAEn-LTpXnzSG-rVVvv_2cbxqY2vTchOKn6M0isRBovoq4jpZGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Request stat64 on RV32
To:     zongbox@gmail.com
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong@andestech.com,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 5:10 AM Zong Li <zongbox@gmail.com> wrote:
>
> The stat64 family that is used on 32-bit architectures to replace
> newstat.
>
> Since commit 67314ec7b0250290cc85eaa7a2f88a8ddb9e8547 ("RISC-V: Request
> newstat syscalls"), the RV32 build fail with undeclared 'sys_fstatat64'
>
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/include/asm/unistd.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index eff7aa9..a4aade9 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -18,5 +18,6 @@
>
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_STAT64
>  #include <uapi/asm/unistd.h>
>  #include <uapi/asm/syscalls.h>
> --

See: http://lists.infradead.org/pipermail/linux-riscv/2018-November/002087.html

The plan is not to have old stat syscalls and support statx on
riscv32, which is y2038 safe.

The issue you see is a bug in include/uapi/asm-generic/unistd.h.
Marcin (CC) already sent a patch to Arnd (CC) IIRC. Basically without
__ARCH_WANT_NEW_STAT or __ARCH_WANT_STAT64 two macros are not defined:
__NR3264_fstatat and __NR3264_fstat. Which is later used (without any
guards):

763 #define __NR_newfstatat __NR3264_fstatat
764 #define __NR_fstat __NR3264_fstat
