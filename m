Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE4CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C167320663
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C167320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeK0MWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:22:03 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17481 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727544AbeK0MWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:22:02 -0500
X-UUID: 52a126d2f8154c6b93421f23819ffbcf-20181127
X-UUID: 52a126d2f8154c6b93421f23819ffbcf-20181127
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1326945117; Tue, 27 Nov 2018 09:25:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 27 Nov
 2018 09:25:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 27 Nov 2018 09:25:45 +0800
Message-ID: <1543281946.3753.2.camel@mhfsdcap03>
Subject: Re: [PATCH 4/9] iommu: mtk_iommu: make it explicitly non-modular
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 27 Nov 2018 09:25:46 +0800
In-Reply-To: <1543271498-28966-5-git-send-email-paul.gortmaker@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
         <1543271498-28966-5-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 17:31 -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config MTK_IOMMU_V1
> drivers/iommu/Kconfig:  bool "MTK IOMMU Version 1 (M4U gen1) Support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init was not even used by this driver, the init ordering
> remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Honghui Zhang <honghui.zhang@mediatek.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 27867b862d7a..5fbf3cecb87f 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -1,4 +1,6 @@
>  /*
> + * IOMMU API for MTK architected m4u v1 implementations
> + *
>   * Copyright (c) 2015-2016 MediaTek Inc.
>   * Author: Honghui Zhang <honghui.zhang@mediatek.com>
>   *
> @@ -35,7 +37,7 @@
>  #include <linux/spinlock.h>
>  #include <asm/barrier.h>
>  #include <asm/dma-iommu.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <soc/mediatek/smi.h>
>  #include "mtk_iommu.h"
> @@ -704,15 +706,4 @@ static int __init m4u_init(void)
>  {
>  	return platform_driver_register(&mtk_iommu_driver);
>  }
> -
> -static void __exit m4u_exit(void)
> -{
> -	return platform_driver_unregister(&mtk_iommu_driver);
> -}
> -
>  subsys_initcall(m4u_init);
> -module_exit(m4u_exit);
> -
> -MODULE_DESCRIPTION("IOMMU API for MTK architected m4u v1 implementations");
> -MODULE_AUTHOR("Honghui Zhang <honghui.zhang@mediatek.com>");
> -MODULE_LICENSE("GPL v2");

Hi, Paul,
Thanks for your patch.

I would like the patch tile be:
iommu/mediatek: make it explicitly non-modular

except that,

Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>


