Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253D9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E991A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G96T8zeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfA3S7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:59:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38440 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfA3S7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:59:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so456058lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP/+aa8KV0RdJRkGEOst+CVjF7HcELVsTDtdEZCiVOc=;
        b=G96T8zeUlc0YSCk1AnGOW1QWPsVOFvsMVR8DsvaQszkVPfil3yhlUcF7LDxTwyZw79
         PCjfW+yNkQQ4UBO4Vop5J9s//EJb2NpJttjnjtPdxiFGtGozEQbBW+Rg5Z6/ULy4vgQu
         AL6R56JRJciJPk0iv1WCbwR8wIHWhSguE67MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP/+aa8KV0RdJRkGEOst+CVjF7HcELVsTDtdEZCiVOc=;
        b=oaw6Jn8hOi14mCCW3jvDC2LVp/ev1aiYRvzHAppQlh6CNEomRHRp813E0zYdsszJ+D
         BxAxgwiwr5kc0gNkXObobxWSxdc7g5MOrIgp8FjyhxE/yMiwfOHi2KK4YgJ65EfPoWco
         134PrlZoANGKbhqGKXf7aRf/p1hBheZ+DZfNieh/oIRUQ0+0AAr1Lo1nmGRtcHv8GjqC
         UzOSJKCEVjPq/UUeNd1MHkuVAk+xHby9DipK/z4YRIjGu8N38dDrNww8t6ph6PUV5BgK
         x30OHMmsMHGZ+C+ds9H7Nw1owcgCUcLw2NHvWbudqzW8spO57pMsmkqZ9COnTEZ62fFz
         DSjw==
X-Gm-Message-State: AJcUukeQbdKMFBUA2PRdtIvhsVHCLXM27uKxxm4yot+wLQs1MSLPDnfs
        fwDAS+GgdGLdBULJAA0nQxLAaBJXX8k=
X-Google-Smtp-Source: ALg8bN6HZODGBw/vx58nETjeKIfSm9ojFmwhYA4gCsvYkqBEU0VEaEwAcVR0y1R6elwUdHKAOpKEvg==
X-Received: by 2002:a19:8096:: with SMTP id b144mr23913858lfd.8.1548874760736;
        Wed, 30 Jan 2019 10:59:20 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s17sm473398lfk.9.2019.01.30.10.59.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:59:20 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id n18so455318lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:59:20 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id k123mr24311307lfg.101.1548873105432;
 Wed, 30 Jan 2019 10:31:45 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-14-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:31:09 -0800
X-Gmail-Original-Message-ID: <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
Message-ID: <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/20] iommu/mediatek: Add mt8183 IOMMU support
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
>
> Here list main differences between mt8183 and mt8173/mt2712:
> 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> 6) mt8183 need reset_axi like mt8173.
> 7) the larb-id in smi-common is remapped. M4U should add its larbid_remap.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 15 ++++++++++++---
>  drivers/iommu/mtk_iommu.h |  1 +
>  drivers/memory/mtk-smi.c  | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2913ddb..66e3615 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -36,6 +36,7 @@
>  #include "mtk_iommu.h"
>
>  #define REG_MMU_PT_BASE_ADDR                   0x000
> +#define MMU_PT_ADDR_MASK                       GENMASK(31, 7)
>
>  #define REG_MMU_INVALIDATE                     0x020
>  #define F_ALL_INVLD                            0x2
> @@ -342,7 +343,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>         /* Update the pgtable base address register of the M4U HW */
>         if (!data->m4u_dom) {
>                 data->m4u_dom = dom;
> -               writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> +               writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,

So there aren't any other bits down below 7 that you need, like the
shareable bits?
