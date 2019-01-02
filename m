Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B08C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9AE2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjimZ5JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfABGpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:45:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36487 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfABGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:45:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so17391248qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 22:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DknPEgHGtV9sxl6oqvh8azwyDNJTjMFL9IBJEqToBQ=;
        b=IjimZ5JQU7rivfGCW0oUWGsb/zTa9FyOUiPqdMEq7AsCmw2yFoGaDrt+TKN6fRJMF9
         wW05zZrOzjoRuijKPApT8EeB5crLi6HLPgCpJCM0jo99l2vEbLRFEHr6iRyr1db3QA0h
         IFZ8/e4bwn1CleFIe0u3AjhDDV96+5XcuFs5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DknPEgHGtV9sxl6oqvh8azwyDNJTjMFL9IBJEqToBQ=;
        b=DpepxULn0g4uCZ7ehXT9cEj0ZsoCvRuRAY+Kleni52LcunGEik/usVduZmLN4SASMX
         FJr6fLUp3uONwuGfwsj0h38H2ccqlsRYe4i0E6HpYqCg9rEiZiK4urzW/ZQ7gDoth59U
         NlLgNhrDh6ZNyYdISzty2c3XNzHtUbNo1Phkfk+U1M0ZBPXNDzsyKckBg8R8rvY5kSbA
         xRwNTZaBWvxoZLP+QlJtjoxK45msuu6w+Lx21F7mCbJRNfr2hsNk8kBtxVh0cyu9dVJK
         oPltw+9RynXb6s2Ipe3lgV+zgUoK7EeZv7sCQlXHXEH7w4sbp5mPgKOW6OjG9Ir/t3z7
         SDqA==
X-Gm-Message-State: AJcUukel0y6OpqzN8cwfOUuQWKbf/fv3UhA57Mdwr8TK8PQu/idOJXWC
        7oruOCICCrFwLmDWthuydmQ/6yc2bRb/PsIrKtveEg==
X-Google-Smtp-Source: ALg8bN7VJrPHEC7yPjuJ2MpVpAG9hdRMkl5PxtBTXAqzpAY9wmiZ/cFwvRFptN4sYuQs/lWUdtiNmbypze4Pj5ZP2C8=
X-Received: by 2002:a37:5107:: with SMTP id f7mr40928211qkb.124.1546411541502;
 Tue, 01 Jan 2019 22:45:41 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 2 Jan 2019 14:45:30 +0800
Message-ID: <CANMq1KAZumH0=iLFgi7=P2mCE4B=7nw_FW9ir4Dwp4M3f8Ukjg@mail.gmail.com>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        youlin.pei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 11:58 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> range) register while mt2712 have. Move it into the plat_data.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 ++-
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8d8ab21..2913ddb 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                          upper_32_bits(data->protect_base);
>         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>
> -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
>                 /*
>                  * If 4GB mode is enabled, the validate PA range is from
>                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .m4u_plat     = M4U_MT2712,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .vld_pa_rng   = true,
>         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b46aeaa..a8c5d1e 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
>         bool                reset_axi;
> +       bool                vld_pa_rng;

Since this is not a register name, maybe we can use something more
readable, like valid_pa_range?

(or at the very least describe it in a comment in the struct?)

>         unsigned char       larbid_remap[MTK_LARB_NR_MAX];
>  };
>
> --
> 1.9.1
>
