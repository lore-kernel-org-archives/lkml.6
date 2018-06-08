Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0D/zBS4EG1v9LwAAmS7hNA
	; Fri, 08 Jun 2018 22:33:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3D3186089E; Fri,  8 Jun 2018 22:33:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="btu2DB+i"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A1C84601C3;
	Fri,  8 Jun 2018 22:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1C84601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeFHWdh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:33:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42734 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeFHWdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:33:36 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so9045859pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=frfIJEP+NRzVrDZfmlheglP3ayxvEKuSbkSIg1XYuE4=;
        b=btu2DB+iw6+Nae5eJQQhILSZe5Msy/8ASEiNAnQEpvecKyjPM6dNMpBU1IZHgObIrt
         yOqhzBrptYrRPcMAA1uqBthMNBqGJ0M+GfhvntHWml4FM7PKoEMi583eqtRa8jREKLZ7
         OAmv3NnYyPqXv3HXS8Dna2irHWIa7hIMcVeqZ1PBxXrCsVcLGHMoGbxzUiISheGUiCqO
         2lSjFmILJAv28j4qAe3UpF1SAMDqvbWRY4A7IlpVgbfGU3OWCHAqIA9L4REy3peRVnTB
         uICJgf1/vn/Y9/3Mb+9aekM1BHNseNLR7jCFwcQ1EVeFnaGA78Xr0nqypFEVJ3AnVSaS
         5w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=frfIJEP+NRzVrDZfmlheglP3ayxvEKuSbkSIg1XYuE4=;
        b=onqm6qzW3ZSPToJyRQvnLHbGeY9w2d5eB2oB7i2B9cdW8USXCrvKLGEzSmgtvAsnA4
         mgLszQ6/bgYYV2P8pL3a9YVLh1pFTeldVLhxUxYIBBlCUP8NtiKyiysHhpV1I0PQmK0s
         fJuAt7MyzIb2kop0fbGdPP7xTRPLkO12ApUKFm6I52LC39E9J6uhJEjNoLjn6PQRH+e2
         1Flegg6lDHw2CC7utYpHhrm8gPDEF/LJWbkRPbMesMD+yAVKEUxNa/xzglY+lE81gybA
         cMQO6qdINaYInQ2aVwwzZdLeQp/J6QdArjDIhBf9r4EqaQ/rrY/JsY4Er7RIf5XitoGQ
         cu3A==
X-Gm-Message-State: APt69E0HJthjG54zdAb7hTh3ehxq/sHTX+bMwNXXGHH3MjoCgofbIfsA
        kNNglKq+MlJ+8kIuQosGSjP6yw==
X-Google-Smtp-Source: ADUXVKJWzMFUhyi2xW/g/OPqJD09gUW/NzD7HpfWqTf7BqmkSeNU1dy84aRoq1NpLBcOUO41UtN4eg==
X-Received: by 2002:a17:902:4101:: with SMTP id e1-v6mr8359229pld.205.1528497215690;
        Fri, 08 Jun 2018 15:33:35 -0700 (PDT)
Received: from localhost ([73.93.152.77])
        by smtp.gmail.com with ESMTPSA id x2-v6sm124917658pfk.113.2018.06.08.15.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:33:35 -0700 (PDT)
Date: Fri, 08 Jun 2018 15:33:35 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Jun 2018 11:57:10 PDT (-0700)
Subject: Re: [PATCH] RISC-V: Handle R_RISCV_32 in modules
In-Reply-To: <mvm7enaki28.fsf@suse.de>
CC: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: schwab@suse.de
Message-ID: <mhng-3f91f2da-55ae-41b8-b5b2-956ea638bed0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018 03:27:27 PDT (-0700), schwab@suse.de wrote:
> With CONFIG_MODVERSIONS=y the R_RISCV_32 relocation is used by the
> __kcrctab section.
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/kernel/module.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 5dddba301d..1d5e9b934b 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -17,6 +17,17 @@
>  #include <linux/errno.h>
>  #include <linux/moduleloader.h>
>
> +static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
> +{
> +	if (v != (u32)v) {

My worry with this kind of check is that it relies on some sort of undefined 
behavior in C and that at some point in the future GCC will just go decide the 
check can never fail.  I checked and GCC doesn't elide these checks now, so I 
might be wrong.

Is this defined to do what it looks like it's doing?

> +		pr_err("%s: value %016llx out of range for 32-bit field\n",
> +		       me->name, v);
> +		return -EINVAL;
> +	}
> +	*location = v;
> +	return 0;
> +}
> +
>  static int apply_r_riscv_64_rela(struct module *me, u32 *location, Elf_Addr v)
>  {
>  	*(u64 *)location = v;
> @@ -265,6 +276,7 @@ static int apply_r_riscv_sub32_rela(struct module *me, u32 *location,
>
>  static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
>  				Elf_Addr v) = {
> +	[R_RISCV_32]			= apply_r_riscv_32_rela,
>  	[R_RISCV_64]			= apply_r_riscv_64_rela,
>  	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
>  	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,

Thanks!
