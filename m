Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A42C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F9E2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhzLAC8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfA3TWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:22:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35180 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387554AbfA3TWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:22:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so608791ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xexnQxVTr0JWe6DMyf7KO14a0l6N+WxdulLMNHMHrpc=;
        b=mhzLAC8fG3PFzHNIiR53TJOj6/vdE+TDDmJ71ouQsTiIkIoPW71qH7yeYs/xA3iDiX
         Czvz2WgAUaBOub83O0lMCp+3c1NZxCjAMZ+XMgzpYBQx94HVmJvm/Nxhb/Qxn3PjbMD5
         axw1m8o1zkBLq/aEOgbaqRCf0BVtjeiWuq6jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xexnQxVTr0JWe6DMyf7KO14a0l6N+WxdulLMNHMHrpc=;
        b=quH+QzEJGZOugDnRiXOTC+P7JzHwTbj1ovgl6qUnkG+W+Ke1r1PuL+kYFK7zATUpec
         kBYj/6NGKGV5OYnnFwpuzD1O6GOdMPDzcBx/e7W0j9ohEWhVe+Ws3kd5IemeDX3sR995
         QQPS/p2aytyjp8nYxegjnIGOV4m6CX6ktK3LSybv80S2dGqpDNEXnRcZqWJeqqHdrohY
         dKRapyx4UdQ2msklgLiWNaAb8j5IJSD+lq8gGTsIjnAqCw2zhczi33wFk1i40N8A093d
         vjKIi8LPBJSJ1IkfFDbbHrYZF46CxCAxJc0Tjsg6x5WHOqC1AzslgXdxI4TY8zRb12St
         ITlA==
X-Gm-Message-State: AJcUukczYnXlMFgKObSeiKHqhitzqOWzgQShm1oA7pVTFac2Xr4THdIk
        4KhpOjlJUNs4ern2g7gyn7zm8EpcEOo=
X-Google-Smtp-Source: ALg8bN4UmyOEdq8+8EwMVW4wlYkMFznyT8njC8telWiEOMZ0xBpKwkuRxKhktGbLF01xwtC9BnMb5A==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr27751402ljj.61.1548876138461;
        Wed, 30 Jan 2019 11:22:18 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id v17-v6sm409952ljg.32.2019.01.30.11.22.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:22:17 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v1-v6so621729ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:22:16 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr26585860ljc.97.1548876135969;
 Wed, 30 Jan 2019 11:22:15 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-18-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-18-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 11:11:39 -0800
X-Gmail-Original-Message-ID: <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
Message-ID: <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] memory: mtk-smi: Get rid of need_larbid
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
> The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> It's no need to parse it again in SMI driver. Only clean some codes.
> This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> and mt8183.
>
> After this patch, the "mediatek,larb-id" only be needed for mt2712
> which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> in which the larbs in the "mediatek,larbs" always are ordered.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 08cf40d..10e6493 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
>  };
>
>  struct mtk_smi_larb_gen {
> -       bool need_larbid;
>         int port_in_larb[MTK_LARB_NR_MAX + 1];
>         void (*config_port)(struct device *);
>         unsigned int larb_direct_to_common_mask;
> @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
>         struct mtk_smi_iommu *smi_iommu = data;
>         unsigned int         i;
>
> -       if (larb->larb_gen->need_larbid) {
> -               larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> -               return 0;
> -       }
> -
> -       /*
> -        * If there is no larbid property, Loop to find the corresponding
> -        * iommu information.
> -        */
> -       for (i = 0; i < smi_iommu->larb_nr; i++) {
> +       for (i = 0; i < MTK_LARB_NR_MAX; i++) {

Looks like this was the only use of mtk_smi_iommu.larb_nr. Should we
remove that now?
