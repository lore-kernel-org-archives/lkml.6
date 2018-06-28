Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71737C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1336B25CF1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1336B25CF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeF1Cax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:30:53 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:33988 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeF1Cav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:30:51 -0400
Received: by mail-ed1-f52.google.com with SMTP id q24-v6so4211609edr.1;
        Wed, 27 Jun 2018 19:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sSWtipksin/h0gST8okLMsbtga8J92hh80oIL27fJ7M=;
        b=YZ2t/KHX8jvgTEoe3dRrKVEZnx8E5H6CZQRoaYwZ3uII2KIsAR4C/ZiDyGc0FZpT3A
         MrU6q5Uo07QQBgvoIW+jreXj+H/ELBwtSWDAXLNms54I82EYd76IFuoE+rrNS4D8Li+K
         GLKzHqF/9meKcXBYRsZUg5rjLdKfm2PppfglZQGU9gseN7eV3+IpMAnA71Jq2HCFoxHF
         E7tI3F7Rv2mxy5qU2xt3seHoaU/NKsw8dcKK4Jp0MNfghlhguvHFQMzCv/I6tLWP2lFN
         2xWi6eemWlC3lIkRnnBWjtOEhNUtgl1Dlok83MY1joT76ZVOGo3OGvFZeeOAsLxOg4Im
         j1kA==
X-Gm-Message-State: APt69E2uK2SFGYDuUw9iuEgVk4QQOcUdiE2CgZcI2bg7GyKTUqO1T3v6
        9+fo32mNOU3Li0+uFUz33uRMFbIo
X-Google-Smtp-Source: AAOMgpeFpV1xlMedEY0tKHI7yyEhpZv+dfBZAIWZbYsnLXm7NZ2k+oj1zziDTCJ8NvdCEXsrT6ZymA==
X-Received: by 2002:a50:ddcb:: with SMTP id x11-v6mr7599519edk.23.1530153049271;
        Wed, 27 Jun 2018 19:30:49 -0700 (PDT)
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id b32-v6sm2941386edd.85.2018.06.27.19.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:30:48 -0700 (PDT)
Received: by mail-wr0-f173.google.com with SMTP id p12-v6so3829970wrn.11;
        Wed, 27 Jun 2018 19:30:47 -0700 (PDT)
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr6937695wrc.19.1530153047475;
 Wed, 27 Jun 2018 19:30:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:30:27
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-20-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-20-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:30:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v66AOfU_Xfz=NjnQ7O8zz7r0k_0Sf2=138oZytXpiCJNxg@mail.gmail.com>
Message-ID: <CAGb2v66AOfU_Xfz=NjnQ7O8zz7r0k_0Sf2=138oZytXpiCJNxg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 19/24] drm/sun4i: Add support for second
 clock parent to DW HDMI PHY clk driver
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Expand HDMI PHY clock driver to support second clock parent.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  4 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     |  3 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 90 ++++++++++++++++------
>  3 files changed, 73 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> index 46a3aa6a53a9..aadbe0a10b0c 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> @@ -99,6 +99,7 @@
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN                BIT(28)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33       BIT(27)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK   BIT(26)
> +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT 26
>  #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN          BIT(25)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)    ((x) << 22)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)     ((x) << 20)
> @@ -190,6 +191,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi);
>  void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
>  const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
>
> -int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
> +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
> +                        bool second_parent);
>
>  #endif /* _SUN8I_DW_HDMI_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> index f0877b3f67e7..aea46b08f127 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -491,7 +491,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
>                         }
>                 }
>
> -               ret = sun8i_phy_clk_create(phy, dev);
> +               ret = sun8i_phy_clk_create(phy, dev,
> +                                          phy->variant->has_second_pll);
>                 if (ret) {
>                         dev_err(dev, "Couldn't create the PHY clock\n");
>                         goto err_put_clk_pll1;
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> index faea449812f8..a4d31fe3abff 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> @@ -22,35 +22,45 @@ static int sun8i_phy_clk_determine_rate(struct clk_hw *hw,
>  {
>         unsigned long rate = req->rate;
>         unsigned long best_rate = 0;
> +       struct clk_hw *best_parent = NULL;
>         struct clk_hw *parent;
>         int best_div = 1;
> -       int i;
> +       int i, p;
>
> -       parent = clk_hw_get_parent(hw);
> -
> -       for (i = 1; i <= 16; i++) {
> -               unsigned long ideal = rate * i;
> -               unsigned long rounded;
> -
> -               rounded = clk_hw_round_rate(parent, ideal);
> +       for (p = 0; p < clk_hw_get_num_parents(hw); p++) {
> +               parent = clk_hw_get_parent_by_index(hw, p);
> +               if (!parent)
> +                       continue;
>
> -               if (rounded == ideal) {
> -                       best_rate = rounded;
> -                       best_div = i;
> -                       break;
> +               for (i = 1; i <= 16; i++) {
> +                       unsigned long ideal = rate * i;
> +                       unsigned long rounded;
> +
> +                       rounded = clk_hw_round_rate(parent, ideal);
> +
> +                       if (rounded == ideal) {
> +                               best_rate = rounded;
> +                               best_div = i;
> +                               best_parent = parent;
> +                               break;
> +                       }
> +
> +                       if (!best_rate ||
> +                           abs(rate - rounded / i) <
> +                           abs(rate - best_rate / best_div)) {
> +                               best_rate = rounded;
> +                               best_div = i;
> +                               best_parent = parent;
> +                       }
>                 }
>
> -               if (!best_rate ||
> -                   abs(rate - rounded / i) <
> -                   abs(rate - best_rate / best_div)) {
> -                       best_rate = rounded;
> -                       best_div = i;
> -               }
> +               if (best_rate / best_div == rate)
> +                       break;
>         }
>
>         req->rate = best_rate / best_div;
>         req->best_parent_rate = best_rate;
> -       req->best_parent_hw = parent;
> +       req->best_parent_hw = best_parent;
>
>         return 0;
>  }
> @@ -95,22 +105,58 @@ static int sun8i_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>         return 0;
>  }
>
> +static u8 sun8i_phy_clk_get_parent(struct clk_hw *hw)
> +{
> +       struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
> +       u32 reg;
> +
> +       regmap_read(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, &reg);
> +       reg = (reg & SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK) >>
> +             SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT;
> +
> +       return reg;
> +}
> +
> +static int sun8i_phy_clk_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
> +
> +       if (index > 1)
> +               return -EINVAL;
> +
> +       regmap_update_bits(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> +                          SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> +                          index << SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT);
> +
> +       return 0;
> +}
> +
>  static const struct clk_ops sun8i_phy_clk_ops = {
>         .determine_rate = sun8i_phy_clk_determine_rate,
>         .recalc_rate    = sun8i_phy_clk_recalc_rate,
>         .set_rate       = sun8i_phy_clk_set_rate,
> +
> +       .get_parent     = sun8i_phy_clk_get_parent,
> +       .set_parent     = sun8i_phy_clk_set_parent,
>  };
>
> -int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
> +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
> +                        bool second_parent)
>  {
>         struct clk_init_data init;
>         struct sun8i_phy_clk *priv;
> -       const char *parents[1];
> +       const char *parents[2];
>
>         parents[0] = __clk_get_name(phy->clk_pll0);
>         if (!parents[0])
>                 return -ENODEV;
>
> +       if (second_parent) {
> +               parents[1] = __clk_get_name(phy->clk_pll1);

Like I mentioned in the TCON TOP patch, you don't actually need a reference
if all you want is just the clock name.

ChenYu

> +               if (!parents[1])
> +                       return -ENODEV;
> +       }
> +
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -118,7 +164,7 @@ int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
>         init.name = "hdmi-phy-clk";
>         init.ops = &sun8i_phy_clk_ops;
>         init.parent_names = parents;
> -       init.num_parents = 1;
> +       init.num_parents = second_parent ? 2 : 1;
>         init.flags = CLK_SET_RATE_PARENT;
>
>         priv->phy = phy;
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
