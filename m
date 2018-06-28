Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99063C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5388027037
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5388027037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbeF1H3t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:29:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36684 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933896AbeF1H3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:29:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EB74420714; Thu, 28 Jun 2018 09:29:46 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id B413A20703;
        Thu, 28 Jun 2018 09:29:36 +0200 (CEST)
Date:   Thu, 28 Jun 2018 09:29:36 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: replace VMLINUX_SYMBOL_STR() with string literal
Message-ID: <20180628092936.6c4a097c@bbrezillon>
In-Reply-To: <1529768142-9989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529768142-9989-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2018 00:35:42 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> With the special case handling for Blackfin and Metag was removed by
> commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
> underscore"), VMLINUX_SYMBOL_STR() can be replaced with string literal.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied.

Thanks,

Boris

> ---
> 
>  drivers/mtd/chips/gen_probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
> index b57ceea..879bebf 100644
> --- a/drivers/mtd/chips/gen_probe.c
> +++ b/drivers/mtd/chips/gen_probe.c
> @@ -202,10 +202,10 @@ static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map,
>  	struct cfi_private *cfi = map->fldrv_priv;
>  	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
>  #ifdef CONFIG_MODULES
> -	char probename[sizeof(VMLINUX_SYMBOL_STR(cfi_cmdset_%4.4X))];
> +	char probename[sizeof("cfi_cmdset_%4.4X")];
>  	cfi_cmdset_fn_t *probe_function;
>  
> -	sprintf(probename, VMLINUX_SYMBOL_STR(cfi_cmdset_%4.4X), type);
> +	sprintf(probename, "cfi_cmdset_%4.4X", type);
>  
>  	probe_function = __symbol_get(probename);
>  	if (!probe_function) {

