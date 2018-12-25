Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B3EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3A121848
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZHW/4OC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeLYLv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 06:51:28 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38995 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 06:51:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so10341639qtj.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPDHPbo2gf0hTx7S7PT2m4ixMuzj8dX+0mQ8VulgblE=;
        b=VZHW/4OCnVH9IoTjBVsLirWnvsKZfs7/IZ42xZCiwGU7PI2wRBuTBytIxrKPnbf3A1
         aKV3E78iba0FfO5NgG7P6MLM5/KjjqqzHCdg9agqDdsGtF8I7Waa97AvddOOqseZWkjt
         Otf2NTRULt+IVHDbqPIXby6tfNnLoBPlMEB2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPDHPbo2gf0hTx7S7PT2m4ixMuzj8dX+0mQ8VulgblE=;
        b=EgeWvldTnOWdrG3S9JZutFfG5fD2OwcxDSSkU9uEaFRo5CMlPR/w7rybUPvbv+2gl6
         ksqwAtVcRvu0Vg0zJ13Vqij6YAjHlOA1p4LsEQxjqrLQ6tj6zGKX/FI1Nxhw7GKmLv2d
         L/CZF1kKDJJH2y+lKeFQxSIvSwR6YQmJmvSLu8Q9BD6XXK3O9K3IAedB2EwBv3cNN0rO
         Ejy3jElrmm2KD2fBfVJInxZwASXcdSx/K/v7gku1fCMV6X6Y2P+XNAVvMJN2Tl4X/Ehf
         OTlJWwofat/PwqeKXO59ypu+MU4NJDtPTtRrRt9CVHubAnlcKZgwFTpTHIULPQFVQQts
         pABg==
X-Gm-Message-State: AJcUukfiSkPhTXQ/FqFLvQUV5V0+bGMTIdMU0EHxWNNhcHQFL+rTNLd0
        LoKW2XF12fYwrE5wqHbE6EJ9pVpRjllpVDsGXPr48w==
X-Google-Smtp-Source: ALg8bN6bd6KUW9olgIUGuMhSQ/G0dYVkeMKuX5jFTsLKIafhEcInIDfhB7xRtXbvf6BUdA3qvfj4jk8VqRwg3vl+SDs=
X-Received: by 2002:a0c:d0d7:: with SMTP id b23mr15023403qvh.67.1545738685952;
 Tue, 25 Dec 2018 03:51:25 -0800 (PST)
MIME-Version: 1.0
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com> <1545397111-24183-3-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1545397111-24183-3-git-send-email-qii.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Dec 2018 19:51:14 +0800
Message-ID: <CANMq1KB_GaNr3CKO9OQmpKY5UZNpOKORFhQV3n7SrQNhF+FpQA@mail.gmail.com>
Subject: Re: [PATCH 2/6] i2c: mediatek: speeds is replaced by macros definitions
To:     qii wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Leilk Liu <leilk.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 8:59 PM qii wang <qii.wang@mediatek.com> wrote:
>
> Different speeds have been defined by macros,
> so we use macros definitions.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index a74ef76..7396449 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>
>         control_reg = readw(i2c->base + OFFSET_CONTROL) &
>                         ~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
> -       if ((i2c->speed_hz > 400000) || (left_num >= 1))
> +       if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >= 1))
>                 control_reg |= I2C_CONTROL_RS;
>
>         if (i2c->op == I2C_MASTER_WRRD)
> @@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>         writew(control_reg, i2c->base + OFFSET_CONTROL);
>
>         /* set start condition */
> -       if (i2c->speed_hz <= 100000)
> +       if (i2c->speed_hz <= I2C_DEFAULT_SPEED)
>                 writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
>         else
>                 writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> --
> 1.7.9.5
>
