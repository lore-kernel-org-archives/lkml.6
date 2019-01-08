Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5D220850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wL+AvZqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfAHMBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:01:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51354 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHMBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:01:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so3889537wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 04:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z/joS18OrBx5VzkEUr1UXjVHtJ0iMM9fC/5WEi+jKg=;
        b=wL+AvZquaWVe3+cpWa6p+I7Qq5eeTQRKQgOLuwpVCjMC1pd5/PCHJV2lPQ50Gy+NXJ
         KoRyatQs2KqojE9wsH5bgtbQiY5eF5UgjY7At4k0n2qi2pfnkbMACSnxQ01htM0if6nB
         kezg4lD3DKi7ZQK2LsQgM9kiZmNXQVv39sFiq8OPgVugnP8gL2saqm8d+yd4BOKnAtQf
         O6mJW8kgiAYCB2eE1d1jJYbMwtbOELXEl4K/i+JGrrhZZZiLkkg3WNIP7WVM9ckUbnsk
         XQVweuX30Eruy5yGcg9IdnW8zbxFcn9R2SpFtbiI6RW97vQYO/3YO3i9zZk5oRL+/tF+
         Ck2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z/joS18OrBx5VzkEUr1UXjVHtJ0iMM9fC/5WEi+jKg=;
        b=EAeRnGFBNCJPfqtnyAIr9orTw4+plogl0t/FkQYseTyhY6h2ttoGvZQlICjopIlaUH
         6S1sEOHdvPwsjAEz7m34vh05Q1gZUNy91qT66D61BmcXYjVkrZmfVWcwTLxkENNusEHl
         goKjGJ1qxcGPd70SRmPpwxbTGsMF4esuvTPfOvjPoCda8RjzpNUmHuyf6zoLIL00rQNO
         E95kZhIZ4BLAB5K5dcCbeQ+vYaD+Errx7UBY/XjWiUN4S2SpjiEsipo+SIVmqZsngY8G
         LkC5dIdyCCat7zSEeuNo0Ond2BvpN2rihjxYB7sB6gWLC/n5wkGbfSPURCN3RoV8FmF0
         o8Xw==
X-Gm-Message-State: AJcUukeOfLPYSQphN8wWTxGkiB9d/lF3n0/FERyDWJsz1YzNcPRnDYs7
        4RhrAAQ5k/GHRAbQa9D0G7EAW2u0yv0C2495UgForg==
X-Google-Smtp-Source: ALg8bN4aYf2g6YWDCTVDUmY6Gbu21QIrrBP/U9lgVysYWhr35oABl6RGoIwFWnrB6Rgj7yyrTTmkelU+TASMZy02zAI=
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr1458339wmg.132.1546948909573;
 Tue, 08 Jan 2019 04:01:49 -0800 (PST)
MIME-Version: 1.0
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com> <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Jan 2019 17:31:38 +0530
Message-ID: <CAAhSdy1_5ULea-2JKYeQd8dAPbnZ+OVM-p=iP5RwWbuiZ5NJJw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] RISC-V: Assign hwcap only according to current cpu.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, we set hwcap based on first valid cpu from
> DT. This may not be correct always as that CPU might not
> be current booting cpu.
>
> Set hwcap based on the current cpu instead of first
> valid CPU from DT.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index a6e369ed..ed6122ff 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -43,12 +43,15 @@ void riscv_fill_hwcap(void)
>         elf_hwcap = 0;
>
>         /*
> -        * We don't support running Linux on hertergenous ISA systems.  For
> -        * now, we just check the ISA of the first "okay" processor.
> +        * We don't support running Linux on hertergenous ISA systems.
> +        * But first "okay" processor might not be the boot cpu.
> +        * Check the ISA of boot cpu.
>          */
> -       while ((node = of_find_node_by_type(node, "cpu")))
> -               if (riscv_of_processor_hartid(node) >= 0)
> +       while ((node = of_find_node_by_type(node, "cpu"))) {
> +               if (riscv_of_processor_hartid(node) == boot_cpu_hartid)
>                         break;
> +       }
> +
>         if (!node) {
>                 pr_warning("Unable to find \"cpu\" devicetree entry");
>                 return;
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
