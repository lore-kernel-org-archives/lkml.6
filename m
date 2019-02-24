Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629A5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D6D20652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="q85QtieL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfBXTku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:40:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41180 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfBXTkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:40:49 -0500
Received: by mail-oi1-f193.google.com with SMTP id e7so5618649oia.8;
        Sun, 24 Feb 2019 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lLS7Eq3OMW3HLFIEHd7HCsdWAS76ih1fieUstK9xb0=;
        b=q85QtieLdl8MuHe6sabxOP+87uHLP0EfDOrGpEUjcuN4iNEf8qZt12KH6oL3tijIuw
         hg8qFbXyjS0XlyPJMa4vSCYS/KN1jYgHi5/MUAhsmRT5GORkftgEIs2SjwpLmouK6vk8
         NUtQmnrUGWhzgeK8mjijT7sWhSx8pLq7XqfgZ6O7/RNvbLh9ao29Gzu1+08H6uhhn0hF
         Com8KzoEv00uW4iKIyJYqrHX2mUNlPRvMioi7EPko7bRM2OebyYrh3R2uHJGQTlw6JPF
         OsF5/lB7qkFPDv8aBFAPBN8FASiIPk9wIjuSXjBHcfTSuBrsRF44nQ34bzqdzrf8WhG+
         Gohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lLS7Eq3OMW3HLFIEHd7HCsdWAS76ih1fieUstK9xb0=;
        b=JaLK5i3iaFk3nDX6Q5rhCNga7wWkCFw2deeNm9c2OD8Fe+IADLpPFy/FOdFR73HG3B
         eJLA70YTiP/b9cY5xeE3qKBIcRRwqn4gOvwNlq05cCmBA8BEWXfdRnFSK23KFnxEuXzX
         NK5Aze8gJrLHvJUmhTsFpIOvLoPYZywpd73CZlUovAxz0Jc+RHyoxgGPw8hm1sDf1t6L
         6myKnEN55Jwn7mwrodrOD+P5EouAC2FtoGmULdwL99COHOdD2umhIqOc1AKXWoCpV/cM
         5D92oczS7rQUjz35pt/xmXeAtbgatsLW5Y0rHxYiINbIHDz4r6JJ25ochgKebvgRugut
         wGIA==
X-Gm-Message-State: AHQUAuY2+CRW5d+ZsvpQl5NF6T8rMxG0dT1L/gKOZCGQvv+xK4N1aTWn
        ajdmcvpptEFhyJYCkYlSPuHg0QOhpCdeP714YfA2Iffg
X-Google-Smtp-Source: AHgI3IYsoPfO0Zfqmpdy/kVkQl70w8ybav3C9zxzpYyTna3eo9dZmNjtAScxwNiCtFVQktyARcUm1dikJkE7x+bBPlM=
X-Received: by 2002:aca:bc0b:: with SMTP id m11mr8694088oif.41.1551037248237;
 Sun, 24 Feb 2019 11:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com> <20190212151413.24632-7-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 24 Feb 2019 20:40:37 +0100
Message-ID: <CAFBinCA7yRpxG8WMvE0BBXdmcYCBV0EPb6nLQBevxZ0iy7-ZtA@mail.gmail.com>
Subject: Re: [PATCH 6/8] phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Feb 12, 2019 at 4:16 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds support for the shared USB3 + PCIE PHY found in the
> Amlogic G12A SoC Family.
>
> It supports USB3 Host mode or PCIE 2.0 mode, depending on the layout of
> the board.
>
> Selection is done by the #phy-cells, making the mode static and exclusive.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/phy/amlogic/Kconfig                   |  12 +
>  drivers/phy/amlogic/Makefile                  |   1 +
>  .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 414 ++++++++++++++++++
>  3 files changed, 427 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 78d6e194dce9..7ccb9a756aba 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -48,3 +48,15 @@ config PHY_MESON_G12A_USB2
>           Enable this to support the Meson USB2 PHYs found in Meson
>           G12A SoCs.
>           If unsure, say N.
> +
> +config PHY_MESON_G12A_USB3_PCIE
> +       tristate "Meson G12A USB3+PCIE Combo PHY drivers"
nit-pick: s/drivers/driver/

> +       default ARCH_MESON
> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
> +       depends on USB_SUPPORT
> +       select GENERIC_PHY
> +       select REGMAP_MMIO
> +       help
> +         Enable this to support the Meson USB3 + PCIE Combi PHY found
> +         in Meson G12A SoCs.
> +         If unsure, say N.
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 7d4d10f5a6b3..fdd008e1b19b 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -2,3 +2,4 @@ obj-$(CONFIG_PHY_MESON8B_USB2)          += phy-meson8b-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB2)       += phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB2)      += phy-meson-g12a-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)       += phy-meson-gxl-usb3.o
> +obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE) += phy-meson-g12a-usb3-pcie.o
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> new file mode 100644
> index 000000000000..59eae98928e9
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> @@ -0,0 +1,414 @@
[...]
> +static int phy_g12a_usb3_init(struct phy *phy)
> +{
> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +       int data, ret;
> +
> +       /* Switch PHY to USB3 */
> +       regmap_update_bits(priv->regmap, PHY_R0,
> +                          PHY_R0_PCIE_USB3_SWITCH,
> +                          PHY_R0_PCIE_USB3_SWITCH);
> +
> +       /*
> +        * WORKAROUND: There is SSPHY suspend bug due to
> +        * which USB enumerates
> +        * in HS mode instead of SS mode. Workaround it by asserting
> +        * LANE0.TX_ALT_BLOCK.EN_ALT_BUS to enable TX to use alt bus
> +        * mode
> +        */
> +       ret = regmap_update_bits(priv->regmap_cr, 0x102d, BIT(7), BIT(7));
does the datasheet have names for these registers / bits? it if does
then it would be great if you could introduce #defines for them

> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_update_bits(priv->regmap_cr, 0x1010, 0xff0, 20);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Fix RX Equalization setting as follows
> +        * LANE0.RX_OVRD_IN_HI. RX_EQ_EN set to 0
> +        * LANE0.RX_OVRD_IN_HI.RX_EQ_EN_OVRD set to 1
> +        * LANE0.RX_OVRD_IN_HI.RX_EQ set to 3
> +        * LANE0.RX_OVRD_IN_HI.RX_EQ_OVRD set to 1
> +        */
> +       ret = regmap_read(priv->regmap_cr, 0x1006, &data);
> +       if (ret)
> +               return ret;
> +
> +       data &= ~BIT(6);
> +       data |= BIT(7);
> +       data &= ~(0x7 << 8);
> +       data |= (0x3 << 8);
> +       data |= (1 << 11);
> +       ret = regmap_write(priv->regmap_cr, 0x1006, data);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Set EQ and TX launch amplitudes as follows
> +        * LANE0.TX_OVRD_DRV_LO.PREEMPH set to 22
> +        * LANE0.TX_OVRD_DRV_LO.AMPLITUDE set to 127
> +        * LANE0.TX_OVRD_DRV_LO.EN set to 1.
> +        */
> +       ret = regmap_read(priv->regmap_cr, 0x1002, &data);
> +       if (ret)
> +               return ret;
> +
> +       data &= ~0x3f80;
> +       data |= (0x16 << 7);
> +       data &= ~0x7f;
> +       data |= (0x7f | BIT(14));
> +       ret = regmap_write(priv->regmap_cr, 0x1002, data);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * MPLL_LOOP_CTL.PROP_CNTRL = 8
> +        */
why a multi-line comment here? "Switch PHY to USB3" above uses a
single-line comment

> +       ret = regmap_update_bits(priv->regmap_cr, 0x30, 0xf << 4, 8 << 4);
> +       if (ret)
> +               return ret;
> +
> +       regmap_update_bits(priv->regmap, PHY_R2,
> +                       PHY_R2_PHY_TX_VBOOST_LVL,
> +                       FIELD_PREP(PHY_R2_PHY_TX_VBOOST_LVL, 0x4));
> +
> +       regmap_update_bits(priv->regmap, PHY_R1,
> +                       PHY_R1_PHY_LOS_BIAS | PHY_R1_PHY_LOS_LEVEL,
> +                       FIELD_PREP(PHY_R1_PHY_LOS_BIAS, 4) |
> +                       FIELD_PREP(PHY_R1_PHY_LOS_LEVEL, 9));
> +
> +       return 0;
> +}
> +
> +static int phy_g12a_usb3_pcie_init(struct phy *phy)
> +{
> +       struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
> +       int ret;
> +
> +       ret = reset_control_reset(priv->reset);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->mode == PHY_TYPE_USB3)
> +               return phy_g12a_usb3_init(phy);
> +
> +       /* Power UP PCIE */
> +       regmap_update_bits(priv->regmap, PHY_R0,
> +                          PHY_R0_PCIE_POWER_STATE,
> +                          FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
do we also need this for USB mode?
also do we need to change the PHY_R2 register values
(PHY_R2_PHY_TX_VBOOST_LVL for example) for PCIe, for example if the
bootloader initialized the PHY in USB3 mode while the board actually
exposes a PCIe port?


Regards
Martin
