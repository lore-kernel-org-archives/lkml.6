Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1828CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D998D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUv4qxDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfA2Hga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:36:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37996 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfA2Hg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:36:29 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so15777611ioj.5;
        Mon, 28 Jan 2019 23:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d73E7jU3nBjf12kLdQETTgLJsTcEsxIjiL8Z7y2pKf4=;
        b=MUv4qxDFkQ0+pfHZnSuLbMZCvmKxFSbYNOrRxWq/gIymVD95K7Wt002H7/0ZsR3CHr
         ADrlPXSzbZSZ0tuPZeSsTfU3DTK2kQDxU8VOC7mssUWFc15vRaMkuANLNfBhXhzm2x5n
         VE4kqgaY2So5ha+CoyU3gwHrGknzS8QNUMU5xlhkVl+yidHyNdkEO8aB9PB873QsUr+9
         cxx+emyyDWCw6uwoGpffnYB/hNGdX5DII04VTkQLBkcb6cTHtYQCbOABP03D81AqXP0m
         VUJCGFrfIJAYX/M+oCVBQneTJE2M3DUAjmnCA6p0J+TTs90/krYNBi6AQ+b1+zveaU4B
         eoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d73E7jU3nBjf12kLdQETTgLJsTcEsxIjiL8Z7y2pKf4=;
        b=edOU/Kr/mae//AbsMP5aNfqg0xtTkUQ5Rox9pQil9njCLvlnznuH9JQ9FKBY9dw3ky
         iy+SF/qqAT/A1r/i0PJEkSz4CPrDE3qdfEHzyLpB315Z9wFfV5JVC+D8XSVzV9mPmT2P
         xgCyFgAbEZzohtLBX1MpwfqhBIsdk/d3aGJ3HazoYzUYsN69NqbBRatqJ7zv4RkBcprT
         mUSg9JWreJ+7Wz9nRHFkkN5CgjCJD8tuWk7+3BXeVsKwa7sp4KG/iq3lEbkFYSs8Hn5g
         /HhTVtABgDXPozn0CfRr7IdLLr3QIebAtb+CbzbULERs0vdyHdvkY53E4LHC3IjMLdEw
         vYkw==
X-Gm-Message-State: AJcUukeResl8aC72UJQ75Uw2SPN7Gir3UfDMMK3vXXee7GKIWjFplBR6
        /aZVpT/xEARDBJ+GJK4cWL3KVKpCMSTHM9QqmZY=
X-Google-Smtp-Source: ALg8bN4WU2YSsQE7gUkF+DnhpYqJbOdQIIPpJ/oBvdtTXbKsjaZ8gC/yB15uQuK2xPp9uwOql0CEwMhoikuSu1MRPsQ=
X-Received: by 2002:a6b:1490:: with SMTP id 138mr15405340iou.103.1548747388405;
 Mon, 28 Jan 2019 23:36:28 -0800 (PST)
MIME-Version: 1.0
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com> <bd942195-4f1c-1a39-283f-610354308f45@nvidia.com>
In-Reply-To: <bd942195-4f1c-1a39-283f-610354308f45@nvidia.com>
From:   Billy Laws <blaws05@gmail.com>
Date:   Tue, 29 Jan 2019 07:36:15 +0000
Message-ID: <CAFUUQHM88kVh0ov1G30Sz9WQKJRY4p78hBMporL1xU=aY_tNCA@mail.gmail.com>
Subject: Re: [2/2] mfd: max77620: Add low battery monitor support
To:     Mark Zhang <markz@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, that's fine with me, will send then this gets accepted. Two
other things: you should probably set the reg to 0 if the property
isn't specified as regmap_add_irqchip sets it to 0xff (basically all
enabled on highest limit), and you haven't updated the dt-bindings.

On Tue, Jan 29, 2019 at 6:52 AM Mark Zhang <markz@nvidia.com> wrote:
>
> On 1/27/2019 10:54 PM, Billy Laws wrote:
> >  >This patch adds PMIC configurations for low-battery
> >  >monitoring by handling max77620 register CNFGGLBL1.
> >  >
> > It might be an idea to add lbhyst configuration here and support using
> > custom lbdac values to specify a different cutoff point.
>
> Yeah this patch doesn't have support to program LBHYST & LBDAC because
> according to our experiences, we don't have requirement to modify them
> when low battery monitor support added.
>
> I think we can create a new patch to support these 2 fields in the future
> when we really need them. Or you can create a patch if you have requirement
> for them, is this OK to you Billy?
>
> Mark
>
> >
> > See: https://datasheetspdf.com/pdf-file/924230/Maxim/MAX8698C/1  pg 46
> >  >Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> >  >Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> >  >Signed-off-by: Mark Zhang <markz@nvidia.com>
> >  >---
> >  > drivers/mfd/max77620.c | 57 +++++++++++++++++++++++++++++++++++++++++-
> >  > 1 file changed, 56 insertions(+), 1 deletion(-)
> >  >
> >  >diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> >  >index f58143103185..9e50d145afd8 100644
> >  >--- a/drivers/mfd/max77620.c
> >  >+++ b/drivers/mfd/max77620.c
> >  >@@ -474,6 +474,57 @@ static int
> > max77620_init_backup_battery_charging(struct max77620_chip *chip)
> >  >  return ret;
> >  > }
> >  >
> >  >+static int max77620_init_low_battery_monitor(struct max77620_chip *chip)
> >  >+{
> >  >+ struct device *dev = chip->dev;
> >  >+ struct device_node *np;
> >  >+ bool pval;
> >  >+ u8 mask = 0;
> >  >+ u8 val = 0;
> >  >+ int ret;
> >  >+
> >  >+ np = of_get_child_by_name(dev->of_node, "low-battery-monitor");
> >  >+ if (!np) {
> >  >+ dev_info(dev, "Low battery monitoring support disabled\n");
> >  >+ return 0;
> >  >+ }
> >  >+
> >  >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-enable");
> >  >+ if (pval) {
> >  >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
> >  >+ val |= MAX77620_CNFGGLBL1_LBDAC_EN;
> >  >+ }
> >  >+
> >  >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-disable");
> >  >+ if (pval)
> >  >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
> >  >+
> >  >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-enable");
> >  >+ if (pval) {
> >  >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
> >  >+ val |= MAX77620_CNFGGLBL1_MPPLD;
> >  >+ }
> >  >+
> >  >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-disable");
> >  >+ if (pval)
> >  >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
> >  >+
> >  >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-enable");
> >  >+ if (pval) {
> >  >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
> >  >+ val |= MAX77620_CNFGGLBL1_LBRSTEN;
> >  >+ }
> >  >+
> >  >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-disable");
> >  >+ if (pval)
> >  >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
> >  >+
> >  >+ ret = regmap_update_bits(chip->rmap, MAX77620_REG_CNFGGLBL1, mask, val);
> >  >+ if (ret < 0)
> >  >+ dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
> >  >+ return ret;
> >  >+}
> >  >+
> >  > static int max77620_read_es_version(struct max77620_chip *chip)
> >  > {
> >  >  unsigned int val;
> >  >@@ -563,7 +614,11 @@ static int max77620_probe(struct i2c_client *client,
> >  >  if (ret < 0)
> >  >  return ret;
> >  >
> >  >- ret =  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
> >  >+ ret = max77620_init_low_battery_monitor(chip);
> >  >+ if (ret < 0)
> >  >+ return ret;
> >  >+
> >  >+ ret = devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
> >  >      mfd_cells, n_mfd_cells, NULL, 0,
> >  >      regmap_irq_get_domain(chip->top_irq_data));
> >  >  if (ret < 0) {
> >
