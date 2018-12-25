Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75272C07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368B1218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KEfh6oir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeLYEPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 23:15:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44730 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeLYEPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 23:15:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so7755886qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 20:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fLaJ9WArwsfvNaLAZ8iEKft++hOrau5AV7vS/wxgZw=;
        b=KEfh6oirEOs7YwLIvfEoKJ/f9+ivNg3AZXMEeU2TqFQ8v0JH+X3GVJ3W4sLKttZnsR
         oZLgO3MLwpJi/+CwDQKnbTmMG7H1nNZqZ2VWPvG/3Cr1fLSOS/hPoQO1rGUS54s2ldhF
         kxlRMFULW4cZw4oNaCWnbu0O0cQIVldWdjImQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fLaJ9WArwsfvNaLAZ8iEKft++hOrau5AV7vS/wxgZw=;
        b=B8I2m6GYz4zk4mxSgRpz/oxPu2vHBWoIBqV09bOSZ774O9TVgnv0uxgMZotA4OzJgh
         TW5L8Hq7hJGb/PYTq17GBDKr9f1X0deyPBGGPrIRzwlpJjrmzFFy+2v8x+W4BPqjhz2/
         PjvxqgOBgx0jvrpqDlAXK6+tic5RBgJpzeNzm7KQVABsYfyM/JmQec6jUePpi9xUhe9T
         4stbZRzOutnR3EzwvLdDrkDm0KG+Snlc3AyRNSDyNhyU6vXav7Jzi08HHJqx+pi3nCj1
         qFVy/AJq3aZt5X5HuDUcZNX1hnP6zn6nXcuBrHDeWZu/F06CGvt+xHwB45QilsyPf6pN
         ej3Q==
X-Gm-Message-State: AJcUukcPs8vBe3EF5nCTsMrvDdaZU8MnIHj80d3Zb0TMwIrhGPVP/5uT
        QGbO8Ic6in6IYTX+cAMuqMhn6raMKRt6B+EnG0SNWA==
X-Google-Smtp-Source: ALg8bN5QE7B8DqfMGmo68JsdDxoWuPqrpXJeDayRTJjMK0XXZGW+9ZHVpZ9L4OWdnouJENVHWbG7S5BLpDuYy4p9SQg=
X-Received: by 2002:a37:7885:: with SMTP id t127mr14062107qkc.323.1545711353630;
 Mon, 24 Dec 2018 20:15:53 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com> <1545638931-24938-11-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-11-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Dec 2018 12:15:42 +0800
Message-ID: <CANMq1KC_JwVfvFd46_gP_wK_QNO0LTZOcwRAbotF6MghYivJYw@mail.gmail.com>
Subject: Re: [PATCH 10/18] drm/mediatek: add gmc_bits for ovl private data
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 6:53 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch add gmc_bits for ovl private data
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 28d1911..afb313c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -39,7 +39,9 @@
>  #define DISP_REG_OVL_ADDR_MT8173               0x0f40
>  #define DISP_REG_OVL_ADDR(ovl, n)              ((ovl)->data->addr + 0x20 * (n))
>
> -#define        OVL_RDMA_MEM_GMC        0x40402020
> +#define GMC_THRESHOLD_BITS     16
> +#define GMC_THRESHOLD_HIGH     ((1 << GMC_THRESHOLD_BITS) / 4)
> +#define GMC_THRESHOLD_LOW      ((1 << GMC_THRESHOLD_BITS) / 8)
>
>  #define OVL_CON_BYTE_SWAP      BIT(24)
>  #define OVL_CON_MTX_YUV_TO_RGB (6 << 16)
> @@ -57,6 +59,7 @@
>
>  struct mtk_disp_ovl_data {
>         unsigned int addr;
> +       unsigned int gmc_bits;
>         bool fmt_rgb565_is_0;
>  };
>
> @@ -140,9 +143,23 @@ static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
>  {
>         unsigned int reg;
> +       unsigned int gmc_thrshd_l;
> +       unsigned int gmc_thrshd_h;
> +       unsigned int gmc_value;
> +       struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
>
>         writel(0x1, comp->regs + DISP_REG_OVL_RDMA_CTRL(idx));
> -       writel(OVL_RDMA_MEM_GMC, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
> +
> +       gmc_thrshd_l = GMC_THRESHOLD_LOW >>
> +                     (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> +       gmc_thrshd_h = GMC_THRESHOLD_HIGH >>
> +                     (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> +       if (ovl->data->gmc_bits == 10)
> +               gmc_value = gmc_thrshd_h | gmc_thrshd_h << 16;

I don't really get what this does, but is it intentional that you
don't use gmc_thrshd_l here?

Also, if you only ever use 8 or 10 bits gmc, maybe it's easier to
hard-code the 2 values?
if (ovl->data->gmc_bits == 10)
  gmc_value = OVL_RDMA_MEM_GMC_10BIT;
else
  gmc_value = OVL_RDMA_MEM_GMC_8BIT; //0x40402020

> +       else
> +               gmc_value = gmc_thrshd_l | gmc_thrshd_l << 8 |
> +                           gmc_thrshd_h << 16 | gmc_thrshd_h << 24;
> +       writel(gmc_value, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
>
>         reg = readl(comp->regs + DISP_REG_OVL_SRC_CON);
>         reg = reg | BIT(idx);
> @@ -324,11 +341,13 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>
>  static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>         .addr = DISP_REG_OVL_ADDR_MT2701,
> +       .gmc_bits = 8,
>         .fmt_rgb565_is_0 = false,
>  };
>
>  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>         .addr = DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits = 8,
>         .fmt_rgb565_is_0 = true,
>  };
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
