Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA109C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC3321871
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHWprtkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfBYXzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:55:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44300 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfBYXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:55:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id g2so8236271lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4zKbHDhMsN+Mg7u0glRIUId4HtPnOzdJXLjXBeHdzg=;
        b=OHWprtkORMqk3kKdabHOVWP/Y3RhmlW9snAjiZJfKfl2rYVcSsU1z+ZiO0XpIGJ7p7
         rAbQl+Wz97fdWOmXL2ZHPI0o1G4vZ9X6yozpLEHUy6h4GmN62k4NgA/+Wo0dci4/8Gr2
         qrDCwCrbOy+JLyMuJXexQR8LZ2/ijBPYnyPkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4zKbHDhMsN+Mg7u0glRIUId4HtPnOzdJXLjXBeHdzg=;
        b=q0lfajQymJDt0co0VQ3NA7jvfpvY+MOe7N1ImZtD7BeIz5GupgRzLS9CN9kWJAg7Iv
         nq2Np/GRKdgGaa7BgXebPpsbBR/FckjulHiCFvtOi0WP0R7QPrTJdjwR2ovSQt6EpAcq
         WqKF1vb+yBhjrJkl3//HyeyO57h1+nmM+I+mAphozomADHda7PvP0rk0RAcj0g3VlOxt
         Dva7cmSd/aJrAszd9piHxZCI3PtwM90yFxtzhe70WSbtjNmkdj78GMYh4fr/llnE3ckn
         kUp463wUJunGa1jqPXttwZv3LZ+yJtciCTkpFQfFEUh9UcY/6oZb3GVdhFHhuf1sgDO3
         fODA==
X-Gm-Message-State: AHQUAuY/Ngs4TuqEwtuS9kyAaE1ky590O/Wkpw+jFM/0LTnaqtgvtI5Z
        wveiFTuCsHpU/ezSp4jVYJCFUd+N7uI=
X-Google-Smtp-Source: AHgI3Ibbtx38vsLHiV70ZY+8pIaDhlir7P3+zqcF8b76uTCRQrGhWT29J6LO4CtWS1e5sD+eyfGhQQ==
X-Received: by 2002:ac2:5496:: with SMTP id t22mr11409375lfk.65.1551138903327;
        Mon, 25 Feb 2019 15:55:03 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id x2sm2519898ljj.79.2019.02.25.15.55.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:55:02 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id x206so243820lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:55:01 -0800 (PST)
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr12318394lfc.104.1551138901438;
 Mon, 25 Feb 2019 15:55:01 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:54:25 -0800
X-Gmail-Original-Message-ID: <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
Message-ID: <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU don't have its power-domain. all the consumer connect
> with smi-larb, then connect with smi-common.
>
>         M4U
>          |
>     smi-common
>          |
>   -------------
>   |         |    ...
>   |         |
> larb1     larb2
>   |         |
> vdec       venc
>
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
>
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
>
> This patch adds device_link between the consumer and the larbs.
>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
>  drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 202e41b..735ae8d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>         struct mtk_smi_larb_iommu    *larb_mmu;
>         unsigned int                 larbid, portid;
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +       struct device_link *link;
>         int i;
>
>         for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>                 dev_dbg(dev, "%s iommu port: %d\n",
>                         enable ? "enable" : "disable", portid);
>
> -               if (enable)
> +               if (enable) {
>                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -               else
> +                       /* Link the consumer with the larb device(supplier) */
> +                       link = device_link_add(dev, larb_mmu->dev,
> +                                              DL_FLAG_PM_RUNTIME |
> +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> +                       if (!link) {
> +                               dev_err(dev, "Unable to link %s\n",
> +                                       dev_name(larb_mmu->dev));
> +                               return;

The return is a little odd here, given that you don't return an error
and this function doesn't do anything else. If it's non-fatal that
this link didn't get set up, then remove the return. If it is fatal,
then return an error code.

> +                       }
> +               } else {
>                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +               }
>         }
>  }
>
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 9386aee..022bad9 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>         struct mtk_smi_larb_iommu    *larb_mmu;
>         unsigned int                 larbid, portid;
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +       struct device_link *link;
>         int i;
>
>         for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>                 dev_dbg(dev, "%s iommu port: %d\n",
>                         enable ? "enable" : "disable", portid);
>
> -               if (enable)
> +               if (enable) {
>                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -               else
> +                       link = device_link_add(dev, larb_mmu->dev,
> +                                              DL_FLAG_PM_RUNTIME |
> +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> +                       if (!link) {
> +                               dev_err(dev, "Unable to link %s\n",
> +                                       dev_name(larb_mmu->dev));
> +                               return;

Same for this one.

> +                       }
> +               } else {
>                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +               }
>         }
>  }
>
> --
> 1.9.1
>
