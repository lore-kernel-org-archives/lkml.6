Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1916BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848D720644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf4XPgBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848D720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeH3FGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:06:46 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45497 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3FGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:06:46 -0400
Received: by mail-qk0-f196.google.com with SMTP id z125-v6so4688773qkb.12;
        Wed, 29 Aug 2018 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zb+aH3tKHJiGhBfaGhnjU1IvHHBl9pFfZ9V5li4OvyA=;
        b=jf4XPgBinU/7FtS9o+QK5U/aMjU+zFLaof1PNdCOm3pg5ifbwVQZVahn5NxtM+6ncf
         0SB3t/NgG8dbdyfE7PHI8parAs6bQwWO8vfrakAOdRj7w1xFL13gVkZ3WffL15lDpRlN
         MDcUT8hBvr4yB44SuY4RSZWE8oCkpTfl5d41VL9w1LQoBBnNiLsdYXahWK1RV8MoNj2q
         qrzFJ2S+uRBAddgu95Pcz32CzvUmicjGr4ZbfVrDrul9k1438lCDHvH6ipBz14fc/GoW
         ElJhUvle5NAsDZIHXhssA3jlCMFT4b6tAt9CXUVAjH+cLWtgkwc2e0jLlzEzv/c7dtwh
         +mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zb+aH3tKHJiGhBfaGhnjU1IvHHBl9pFfZ9V5li4OvyA=;
        b=WG/SrtkLpwO2g7vLoaascGqznf3wuy3g0tYmYfVX74+kPNfJbuNX4lz5R7qXwg5Fcr
         vBZ+HQpTqwXZCB0XTFxpAc3OaHXZ+bqCh8iPnUE2hHgqMA2E4x8ZkcBQfUAqqVLMqVHh
         wfxAAshs8EAt9a0qZSJsa9sFs6hEmzyLgEGTsYWtfMgUEhpIxryDmP9v7ncOD06mooOA
         SyjiD528txOTFad3nfhbKcgL8BzMLylVOy1EyCL7CxN9GIPUohSlr+XPp8IiY3Ce4Cz1
         XVb7Vn5oaTQ9A+21kqptXrVsrHzM2NpzvIPYEsmxC9d8CiOtEnufPHxo4RejK45RnL/6
         b+Vg==
X-Gm-Message-State: APzg51AbmTsxnnFb26OMCcBYRb2PbJ5xWu2herI0XDU9ScJu6PMt67s9
        Iir568CHHPNhEjdgxaK7yYNVi1ipw2ZVdl3dfLo=
X-Google-Smtp-Source: ANB0VdZN7G6B7K+eNUvjIDhZG7VmEqu7Ys79/2BAhX1GOLvKW8rT0Zaa0Ozq3hjXicaFH0vZxHvtx58fFacXJpnHois=
X-Received: by 2002:a37:6c87:: with SMTP id h129-v6mr8771372qkc.280.1535591231902;
 Wed, 29 Aug 2018 18:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180830004046.9417-1-mdf@kernel.org> <20180830004046.9417-3-mdf@kernel.org>
In-Reply-To: <20180830004046.9417-3-mdf@kernel.org>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Wed, 29 Aug 2018 18:07:00 -0700
Message-ID: <CAJYdmeN6d0jsp20x72n8c-=yPoCbcujgH1BhUFYPG-zUr0YfGA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: nixge: Add support for having nixge as subdevice
To:     davem@davemloft.net
Cc:     keescook@chromium.org, f.fainelli@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, alex.williams@ni.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 5:49 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Add support for instantiating nixge as subdevice using
> fixed-link and platform data to configure it.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Hi,
>
> not this patch is still in the early stages,
> and as the rest of this series goes on top of [1].
>
> The actual platform data might still change since
> the parent device driver is still under development.
>
> Thanks for your time,
>
> Moritz
>
>
> [1] https://lkml.org/lkml/2018/8/28/1011
>
> ---
>  drivers/net/ethernet/ni/nixge.c     | 71 ++++++++++++++++++++++++++---
>  include/linux/platform_data/nixge.h | 19 ++++++++
>  2 files changed, 83 insertions(+), 7 deletions(-)
>  create mode 100644 include/linux/platform_data/nixge.h
>
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 670249313ff0..fd8e5b02c459 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -7,6 +7,8 @@
>  #include <linux/etherdevice.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/phy_fixed.h>
> +#include <linux/platform_data/nixge.h>
>  #include <linux/of_address.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
> @@ -167,6 +169,7 @@ struct nixge_priv {
>         /* Connection to PHY device */
>         struct device_node *phy_node;
>         phy_interface_t         phy_mode;
> +       struct phy_device *phydev;
>
>         int link;
>         unsigned int speed;
> @@ -859,15 +862,25 @@ static void nixge_dma_err_handler(unsigned long data)
>  static int nixge_open(struct net_device *ndev)
>  {
>         struct nixge_priv *priv = netdev_priv(ndev);
> -       struct phy_device *phy;
> +       struct phy_device *phy = NULL;
>         int ret;
>
>         nixge_device_reset(ndev);
>
> -       phy = of_phy_connect(ndev, priv->phy_node,
> -                            &nixge_handle_link_change, 0, priv->phy_mode);
> -       if (!phy)
> -               return -ENODEV;
> +       if (priv->dev->of_node) {
> +               phy = of_phy_connect(ndev, priv->phy_node,
> +                                    &nixge_handle_link_change, 0,
> +                                    priv->phy_mode);
> +               if (!phy)
> +                       return -ENODEV;
> +       } else if (priv->phydev) {
> +               ret = phy_connect_direct(ndev, priv->phydev,
> +                                        &nixge_handle_link_change,
> +                                        priv->phy_mode);
> +               if (ret)
> +                       return ret;
> +               phy = priv->phydev;
> +       }
>
>         phy_start(phy);
>
> @@ -1215,10 +1228,41 @@ static int nixge_of_get_phy(struct nixge_priv *priv, struct device_node *np)
>         return 0;
>  }
>
> +static int nixge_pdata_get_phy(struct nixge_priv *priv,
> +                              struct nixge_platform_data *pdata)
> +{
> +       struct phy_device *phy = NULL;
> +
> +       if (!pdata)
> +               return -EINVAL;
> +
> +       if (pdata && pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
> +               struct fixed_phy_status fphy_status = {
> +                       .link = 1,
> +                       .duplex = pdata->phy_duplex,
> +                       .speed = pdata->phy_speed,
> +                       .pause = 0,
> +                       .asym_pause = 0,
> +               };
> +
> +               /* TODO: Pull out GPIO from pdata */
> +               phy = fixed_phy_register(PHY_POLL, &fphy_status, -1,
> +                                        NULL);
> +               if (IS_ERR_OR_NULL(phy)) {
> +                       dev_err(priv->dev,
> +                               "failed to register fixed PHY device\n");
> +                       return -ENODEV;
> +               }
> +       }
> +       priv->phy_mode = pdata->phy_interface;
> +       priv->phydev = phy;
> +
> +       return 0;
> +}
> +
>  static int nixge_mdio_setup(struct nixge_priv *priv, struct device_node *np)
>  {
>         struct mii_bus *bus;
> -       int err;
>
>         bus = devm_mdiobus_alloc(priv->dev);
>         if (!bus)
> @@ -1254,6 +1298,7 @@ static void *nixge_get_nvmem_address(struct device *dev)
>
>  static int nixge_probe(struct platform_device *pdev)
>  {
> +       struct nixge_platform_data *pdata = NULL;
>         struct nixge_priv *priv;
>         struct net_device *ndev;
>         struct resource *dmares;
> @@ -1320,10 +1365,16 @@ static int nixge_probe(struct platform_device *pdev)
>                 err = nixge_of_get_phy(priv, np);
>                 if (err)
>                         goto free_netdev;
> +       } else {
> +               pdata = dev_get_platdata(&pdev->dev);
> +               err = nixge_pdata_get_phy(priv, pdata);
> +               if (err)
> +                       goto free_netdev;
>         }
>
>         /* only if it's not a fixed link, do we care about MDIO at all */
> -       if (priv->phy_node && !of_phy_is_fixed_link(np)) {
> +       if ((priv->phy_node && !of_phy_is_fixed_link(np)) ||
> +           (pdata && pdata->phy_interface != PHY_INTERFACE_MODE_NA)) {

Must've messed up the rebase. Missing a parents. I'll resubmit this
one. Sorry for the noise.
>                 err = nixge_mdio_setup(priv, np);
>                 if (err) {
>                         dev_err(&pdev->dev, "error registering mdio bus");
> @@ -1347,6 +1398,9 @@ static int nixge_probe(struct platform_device *pdev)
>                 of_phy_deregister_fixed_link(np);
>                 of_node_put(np);
>         }
> +
> +       if (priv->phydev && phy_is_pseudo_fixed_link(priv->phydev))
> +               fixed_phy_unregister(priv->phydev);
>  free_netdev:
>         free_netdev(ndev);
>
> @@ -1357,6 +1411,7 @@ static int nixge_remove(struct platform_device *pdev)
>  {
>         struct net_device *ndev = platform_get_drvdata(pdev);
>         struct nixge_priv *priv = netdev_priv(ndev);
> +       struct device_node *np = pdev->dev.of_node;
>
>         unregister_netdev(ndev);
>
> @@ -1365,6 +1420,8 @@ static int nixge_remove(struct platform_device *pdev)
>
>         if (np && of_phy_is_fixed_link(np))
>                 of_phy_deregister_fixed_link(np);
> +       else if (priv->phydev && phy_is_pseudo_fixed_link(priv->phydev))
> +               fixed_phy_unregister(priv->phydev);
>
>         free_netdev(ndev);
>
> diff --git a/include/linux/platform_data/nixge.h b/include/linux/platform_data/nixge.h
> new file mode 100644
> index 000000000000..aa5dd5760074
> --- /dev/null
> +++ b/include/linux/platform_data/nixge.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018 National Instruments Corp.
> + *
> + * Author: Moritz Fischer <mdf@kernel.org>
> + */
> +
> +#ifndef __NIXGE_PDATA_H__
> +#define __NIXGE_PDATA_H__
> +
> +#include <linux/phy.h>
> +
> +struct nixge_platform_data {
> +       phy_interface_t phy_interface;
> +       int phy_speed;
> +       int phy_duplex;
> +};
> +
> +#endif /* __NIXGE_PDATA_H__ */
> +
> --
> 2.18.0
>

Thanks,
Moritz
