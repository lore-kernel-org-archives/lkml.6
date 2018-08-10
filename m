Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BF1C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7517A223AA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUAZb26K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7517A223AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHJDDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:03:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55659 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeHJDDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:03:36 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so492420itj.5;
        Thu, 09 Aug 2018 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KTDIyw9de+g8O/ayVeCriIX9Ednpv8OVfO3SEe/FPTw=;
        b=ZUAZb26KegmOtmEbZzqSeiTfUqHqTqK6iV/XRedb4DXpQ65tJMRSD5BKAybModedN2
         IqMLFFBCY6Hoii3GooYH58n0DvDqD1Io68zRlavaf02Tebl8QAQyghoH90qbK6fGB0uC
         OVEXgeAU7TAxIQc9gFAksHjqC2kuTWjIsH6XrAT4vUt5+sf2XKqXcxE21qRuIabCUxyt
         1TnMv6YDAMl3admFBDLBG5h7r7aLB3z5hbn63dG7EB3UwViw7/ljnHrnr66AXEyJIq9i
         f4OLo/+j/G+BWFiuFvCFyU/Ldff+qZU6ImK89Cyw9RVmgaJEfxJRo6Y9H+9ucJeJOQtW
         33vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KTDIyw9de+g8O/ayVeCriIX9Ednpv8OVfO3SEe/FPTw=;
        b=JC0VNbtrGmwJilSubGaBZWjKpGiotVkIhNm63Foit9UX/HILsofg1NuA21P/B/MrBo
         6omRaOFsU5qgCs/dx9d/lDdQIuKXBSyn+malx1CrhnNEn30O4+coA1KfMchlKyaZrcF/
         Rl5DRSn7w4DycQVDyalS5xqRXyPF0MBbg8vg51yP4TLfY3J/tKGeUEV7XY4UwbPJyiN/
         FhQkdUjf/s3od5Qih4WWa2YPiSUIVUrufTIC8PT1zYg1+RlHsQ2Fk+l7LdKY7yyzA8Ui
         Z98ahcyzhtVMu4ZainAJzuyB4X4IdMfi79UxLubGVm257qdRsA5jiz3DdRFs/V6JD2gp
         tcjA==
X-Gm-Message-State: AOUpUlHXkO1vCeZvDz+xsqRlRrOyz2yVr7TKZ7mb32Xb3r5jIYq4qFA9
        TpgeHV7eNqZPwKV8+TCRb267Y+oykgHRUVRnlMU=
X-Google-Smtp-Source: AA+uWPxWu/HdOanKRfn8kck67yy6Dn4X18AKKsB/XgyophpPT8mxonbdQtiFNeytK6VH/rS0oQtBVNswepCOYo5kdrA=
X-Received: by 2002:a02:ba85:: with SMTP id g5-v6mr3968307jao.6.1533861374181;
 Thu, 09 Aug 2018 17:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <1531796756-16982-1-git-send-email-zong@andestech.com>
In-Reply-To: <1531796756-16982-1-git-send-email-zong@andestech.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Fri, 10 Aug 2018 08:36:03 +0800
Message-ID: <CA+ZOyahU_D616x_PjB=6tzDagWJOf_=bgFOUSx2t2Q3HcNEB5g@mail.gmail.com>
Subject: Re: [PATCH] module: Add the print format of Elf_Addr for 32/64-bit compatibly
To:     Zong Li <zong@andestech.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        arnd@arndb.de, schwab@suse.de, hch@infradead.org,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zong Li <zong@andestech.com> =E6=96=BC 2018=E5=B9=B47=E6=9C=8817=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Use a similar way like fixed width integer types in inttypes.h.
>
> For the ELF, the Elf32_Addr is int type and Elf64_Addr is long long
> type. It is opposite to definition of inttypes.h, so the Elf_Addr cannot
> re-use the header.
>
> In many architectures, the module loader only print the message of
> module name and relocation type except the address information. We can
> print the address correctly without compile warning by using PRIdEA,
> PRIxEA and so on.
>
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/kernel/module.c   | 13 +++++++------
>  include/asm-generic/module.h |  9 +++++++++
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 3303ed2cd419..d839528e491a 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -16,11 +16,12 @@
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/moduleloader.h>
> +#include <asm-generic/module.h>
>
>  static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_A=
ddr v)
>  {
>         if (v !=3D (u32)v) {
> -               pr_err("%s: value %016llx out of range for 32-bit field\n=
",
> +               pr_err("%s: value %016" PRIxEA "out of range for 32-bit f=
ield\n",
>                        me->name, v);
>                 return -EINVAL;
>         }
> @@ -101,7 +102,7 @@ static int apply_r_riscv_pcrel_hi20_rela(struct modul=
e *me, u32 *location,
>
>         if (offset !=3D (s32)offset) {
>                 pr_err(
> -                 "%s: target %016llx can not be addressed by the 32-bit =
offset from PC =3D %p\n",
> +                 "%s: target %016" PRIxEA "can not be addressed by the 3=
2-bit offset from PC =3D %p\n",
>                   me->name, v, location);
>                 return -EINVAL;
>         }
> @@ -143,7 +144,7 @@ static int apply_r_riscv_hi20_rela(struct module *me,=
 u32 *location,
>
>         if (IS_ENABLED(CMODEL_MEDLOW)) {
>                 pr_err(
> -                 "%s: target %016llx can not be addressed by the 32-bit =
offset from PC =3D %p\n",
> +                 "%s: target %016" PRIxEA "can not be addressed by the 3=
2-bit offset from PC =3D %p\n",
>                   me->name, v, location);
>                 return -EINVAL;
>         }
> @@ -187,7 +188,7 @@ static int apply_r_riscv_got_hi20_rela(struct module =
*me, u32 *location,
>                 offset =3D (void *)offset - (void *)location;
>         } else {
>                 pr_err(
> -                 "%s: can not generate the GOT entry for symbol =3D %016=
llx from PC =3D %p\n",
> +                 "%s: can not generate the GOT entry for symbol =3D %016=
" PRIxEA "from PC =3D %p\n",
>                   me->name, v, location);
>                 return -EINVAL;
>         }
> @@ -211,7 +212,7 @@ static int apply_r_riscv_call_plt_rela(struct module =
*me, u32 *location,
>                         offset =3D (void *)offset - (void *)location;
>                 } else {
>                         pr_err(
> -                         "%s: target %016llx can not be addressed by the=
 32-bit offset from PC =3D %p\n",
> +                         "%s: target %016" PRIxEA "can not be addressed =
by the 32-bit offset from PC =3D %p\n",
>                           me->name, v, location);
>                         return -EINVAL;
>                 }
> @@ -233,7 +234,7 @@ static int apply_r_riscv_call_rela(struct module *me,=
 u32 *location,
>
>         if (offset !=3D fill_v) {
>                 pr_err(
> -                 "%s: target %016llx can not be addressed by the 32-bit =
offset from PC =3D %p\n",
> +                 "%s: target %016" PRIxEA "can not be addressed by the 3=
2-bit offset from PC =3D %p\n",
>                   me->name, v, location);
>                 return -EINVAL;
>         }
> diff --git a/include/asm-generic/module.h b/include/asm-generic/module.h
> index 98e1541b72b7..d358f2414e5e 100644
> --- a/include/asm-generic/module.h
> +++ b/include/asm-generic/module.h
> @@ -27,6 +27,7 @@ struct mod_arch_specific
>  #endif
>  #define ELF_R_TYPE(X)  ELF64_R_TYPE(X)
>  #define ELF_R_SYM(X)   ELF64_R_SYM(X)
> +#define ELF_ADDR_PREFIX "ll"
>
>  #else /* CONFIG_64BIT */
>
> @@ -44,6 +45,14 @@ struct mod_arch_specific
>  #endif
>  #define ELF_R_TYPE(X)  ELF32_R_TYPE(X)
>  #define ELF_R_SYM(X)   ELF32_R_SYM(X)
> +#define ELF_ADDR_PREFIX
>  #endif
>
> +#define PRIdEA ELF_ADDR_PREFIX "d" /* signed decimal */
> +#define PRIiEA ELF_ADDR_PREFIX "i" /* signed decimal */
> +#define PRIuEA ELF_ADDR_PREFIX "u" /* unsigned decimal */
> +#define PRIoEA ELF_ADDR_PREFIX "o" /* unsigned octal */
> +#define PRIxEA ELF_ADDR_PREFIX "x" /* unsigned lowercase hexadecimal */
> +#define PRIXEA ELF_ADDR_PREFIX "X" /* unsigned uppercase hexadecimal */
> +
>  #endif /* __ASM_GENERIC_MODULE_H */
> --
> 2.16.1
>

ping
