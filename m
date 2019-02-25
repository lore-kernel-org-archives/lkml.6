Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1610A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="iF6Nt54b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbfBYDfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 22:35:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36857 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfBYDfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 22:35:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so8256776wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 19:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzg/QasZL4jzzrPuVbjB9SpdePZwSQI9y9MgCV95T6I=;
        b=iF6Nt54bBd5lpxIvsmhHHR92DIyyr977XxWN/aFRi5RwYaCwOt+QTruISVgsjyWX31
         LBY/X6TMwD2Q6tTeE15N/z0hLXRrKKY/Qja1K5UpyrtMCqNR2TqjpMbKL5xbGR8zjVOQ
         mg/PBUb7/+aoa248IYFtDJeZoGDFVqFiXitOT9owWCtrZr+L24ckl1CPbHTBJQ0+gX/s
         dZv7EUjZMj+mCWWVeEGOeGdX3QZyWUN2PQiHWdroNweeFrHUFLbND39fAF6K3KwzLN+d
         b/eWz8Dmawg6M78yWgPD6dBsEk57G88nMbcv9WsbU/Fmb3HnWnYhth+hTr3dYhpvl6AO
         KANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzg/QasZL4jzzrPuVbjB9SpdePZwSQI9y9MgCV95T6I=;
        b=MPO9KU5YINiucGXLHDIS5tiOmthJFuxITVlKcmsbtRSM1ppGXJVoAXUpQWL6yaHLVd
         TPdX7oB+5Z5q4bjFuIn3tPMrpbj6JpbVXx7DOTqW2DLhhY7SuNNlhLHKHAQJe+5miSQf
         d2gaD/bGWZG7W+jqr4XyWcIniJo5//e3nJh7iUy8cFE9UAlOJuaqckr5NbhUOVpqEzIS
         nUeJ2e1r1MQ0NYvfjSsFnmK6PuMJ8/5UPztGyDHleBuZCIjgbu5SdJaMgzLzjnA6k4Qd
         r5Y49JtTHjYJ8ywSwz7KXk0OYjTohFfhyHP44sZkTAsb4fwZgFT5cJxY45PY30r2X023
         4VTg==
X-Gm-Message-State: AHQUAuakT34e4c7goJZV7l63IPqrpLC88gTIGncQKsKOONjlwHmMlNRr
        aiD/re7du043lJEuTt2g7vI5CDK5jjbbEjvaPNFxAA==
X-Google-Smtp-Source: AHgI3IZyQBSqt7EzRthk2sGISI+/77wf0SuVs8LJ5pdqvcwGQAUQlRc+GEeib2CPS9iVkQKrCcYkQNEsHgrRNABEq+8=
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr11250812wrv.187.1551065728456;
 Sun, 24 Feb 2019 19:35:28 -0800 (PST)
MIME-Version: 1.0
References: <1550864500-13652-1-git-send-email-atish.patra@wdc.com> <1550864500-13652-7-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1550864500-13652-7-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Feb 2019 09:05:17 +0530
Message-ID: <CAAhSdy3a_4sPUgDE8PjsvzpRx-i_mXrecLzjiagp9wZ7oUEVVw@mail.gmail.com>
Subject: Re: [v6 PATCH 6/6] RISC-V: Assign hwcap as per comman capabilities.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 1:11 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, we set hwcap based on first valid hart from DT. This may not
> be correct always as that hart might not be current booting cpu or may
> have a different capability.
>
> Set hwcap as the capabilities supported by all possible harts with "okay"
> status.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index e7a4701f..bc29b010 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <asm/processor.h>
>  #include <asm/hwcap.h>
> +#include <asm/smp.h>
>
>  unsigned long elf_hwcap __read_mostly;
>  #ifdef CONFIG_FPU
> @@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
>
>         elf_hwcap = 0;
>
> -       /*
> -        * We don't support running Linux on hertergenous ISA systems.  For
> -        * now, we just check the ISA of the first "okay" processor.
> -        */
>         for_each_of_cpu_node(node) {
> -               if (riscv_of_processor_hartid(node) >= 0)
> -                       break;
> -       }
> -       if (!node) {
> -               pr_warn("Unable to find \"cpu\" devicetree entry\n");
> -               return;
> -       }
> +               unsigned long this_hwcap = 0;
>
> -       if (of_property_read_string(node, "riscv,isa", &isa)) {
> -               pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> -               of_node_put(node);
> -               return;
> -       }
> -       of_node_put(node);
> +               if (riscv_of_processor_hartid(node) < 0)
> +                       continue;
>
> -       for (i = 0; i < strlen(isa); ++i)
> -               elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> +               if (of_property_read_string(node, "riscv,isa", &isa)) {
> +                       pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> +                       continue;
> +               }
> +
> +               for (i = 0; i < strlen(isa); ++i)
> +                       this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> +
> +               /*
> +                * All "okay" hart should have same isa. Set HWCAP based on
> +                * common capabilities of every "okay" hart, in case they don't
> +                * have.
> +                */
> +               if (elf_hwcap)
> +                       elf_hwcap &= this_hwcap;
> +               else
> +                       elf_hwcap = this_hwcap;
> +       }
>
>         /* We don't support systems with F but without D, so mask those out
>          * here. */
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
