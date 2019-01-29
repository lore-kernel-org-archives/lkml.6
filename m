Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA17C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC912085B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8DOYMNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfA2Nd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:33:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42486 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfA2Nd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:33:59 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so16283936ioa.9;
        Tue, 29 Jan 2019 05:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2pqcBcqDNXAnnXz1IaPEeQZksuwsUmzPuVbz+IoagQ=;
        b=p8DOYMNsDgVJVNuNO+TtZV5A93c2/nSv565C5EV+HkruOrTe0/aUXiVtggsifT01NA
         H0bNgR/UZhkO1gRfNjX1cvmFA2OdCVJLTg/PGS0ZIO9DFJP1Rg72gdLoJvSaLincfXIx
         feLHquMEbZFC7ir2BM0ywmQAs7w/cHm2Xy6y/XAbxlIYSE4ARA4RU7Hf+umLii4bwooz
         WXeeYqyCCGWElx1tD5lU93QpoLU2KHdSZnW/v0hdidqSr7v6JiQtF0Da1DgCbctslwAp
         b5t4RbvB/J3OoT9VprnE63dtA0Uyxzm6QSrlfqDjI56mkhB81szGuwzRGWwgGcPif4SK
         hVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2pqcBcqDNXAnnXz1IaPEeQZksuwsUmzPuVbz+IoagQ=;
        b=lJBdgTtvsNsixAI04FCOahYqnf/SqO8fJs1qiarMj2LnQNV9rKCGGzMu4G+zE8l54q
         jh4k1ZXkb7RiGuSX8PAM6F0C9kz2M/HMEkgXRVroM32UsvlMSAKFFZmg6VGZDAK3lqqz
         aWi6ly4mMRBS5M0BXVgg4vMhWYar4ONFuLCzt6EeMOOS0vbPaEwPfvbicz/+GdxFQdXP
         8v+txczTbIedX6o2rvvMeC7uDlg/BFln7xXp5fc/VPNXlvOXbfh4p857vnr8mvFNnY4Y
         sAWdDDs2QIKzxcB6Av4FHMMS/DVjxSXsJSBgdhvoMi+I9Gg2Y5/ltmpZyuBATUZsJliB
         G9FA==
X-Gm-Message-State: AHQUAuauPYeB1vCR06BAdC7pxpMtg33Xu4koBSPF3EFVCjIaNekNdUHJ
        PrteG6rJO2Wt56Kb+GQXaXd9ALizGdvCl2SDofE=
X-Google-Smtp-Source: AHgI3IbYmPbjj1tXWvE/Qm+Gu2BodCojv4ETq6GWxUE3af81mO7MyG75rLSuvU0jaW1sYM2OMF2yt+CgVAsHoBq45P4=
X-Received: by 2002:a5d:870b:: with SMTP id u11mr14957629iom.168.1548768837943;
 Tue, 29 Jan 2019 05:33:57 -0800 (PST)
MIME-Version: 1.0
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
 <bd942195-4f1c-1a39-283f-610354308f45@nvidia.com> <CAFUUQHM88kVh0ov1G30Sz9WQKJRY4p78hBMporL1xU=aY_tNCA@mail.gmail.com>
 <e1ebcd02-2d25-a6b7-081b-578878be15b4@nvidia.com>
In-Reply-To: <e1ebcd02-2d25-a6b7-081b-578878be15b4@nvidia.com>
From:   Billy Laws <blaws05@gmail.com>
Date:   Tue, 29 Jan 2019 13:33:46 +0000
Message-ID: <CAFUUQHN=mge+RFWssYJDc9PiVGo5XtcZLwjek-xNbxmFX0tPUA@mail.gmail.com>
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

It does, see this article
https://blog.quendi.moe/2018/07/03/en-debugging-nintendo-switch-linux-power-management-battery-desync-edition/


On Tue, Jan 29, 2019 at 9:03 AM Mark Zhang <markz@nvidia.com> wrote:
>
> On 1/29/2019 3:36 PM, Billy Laws wrote:
> > Sure, that's fine with me, will send then this gets accepted. Two
> > other things: you should probably set the reg to 0 if the property
> > isn't specified as regmap_add_irqchip sets it to 0xff (basically all
> > enabled on highest limit), and you haven't updated the dt-bindings.
>
> Billy, v2 is out, dt-bindings patches are added.
> But after a second thought, I don't think regmap_add_irqchip might set
> registers to 0xff. I mean, for 2 registers which this patch set touches,
> they're not IRQ registers(mask/status/...), so regmap_add_irqchip should
> not touch them so I didn't make changes to driver codes in v2.
>
> Mark
>
> >
> > On Tue, Jan 29, 2019 at 6:52 AM Mark Zhang <markz@nvidia.com> wrote:
> >>
> >> On 1/27/2019 10:54 PM, Billy Laws wrote:
> >>>  >This patch adds PMIC configurations for low-battery
> >>>  >monitoring by handling max77620 register CNFGGLBL1.
> >>>  >
> >>> It might be an idea to add lbhyst configuration here and support using
> >>> custom lbdac values to specify a different cutoff point.
> >>
> >> Yeah this patch doesn't have support to program LBHYST & LBDAC because
> >> according to our experiences, we don't have requirement to modify them
> >> when low battery monitor support added.
> >>
> >> I think we can create a new patch to support these 2 fields in the future
> >> when we really need them. Or you can create a patch if you have requirement
> >> for them, is this OK to you Billy?
> >>
> >> Mark
> >>
> >>>
> >>> See: https://datasheetspdf.com/pdf-file/924230/Maxim/MAX8698C/1  pg 46
> >>>  >Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> >>>  >Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> >>>  >Signed-off-by: Mark Zhang <markz@nvidia.com>
> >>>  >---
> >>>  > drivers/mfd/max77620.c | 57 +++++++++++++++++++++++++++++++++++++++++-
> >>>  > 1 file changed, 56 insertions(+), 1 deletion(-)
> >>>  >
> >>>  >diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> >>>  >index f58143103185..9e50d145afd8 100644
> >>>  >--- a/drivers/mfd/max77620.c
> >>>  >+++ b/drivers/mfd/max77620.c
> >>>  >@@ -474,6 +474,57 @@ static int
> >>> max77620_init_backup_battery_charging(struct max77620_chip *chip)
> >>>  >  return ret;
> >>>  > }
> >>>  >
> >>>  >+static int max77620_init_low_battery_monitor(struct max77620_chip *chip)
> >>>  >+{
> >>>  >+ struct device *dev = chip->dev;
> >>>  >+ struct device_node *np;
> >>>  >+ bool pval;
> >>>  >+ u8 mask = 0;
> >>>  >+ u8 val = 0;
> >>>  >+ int ret;
> >>>  >+
> >>>  >+ np = of_get_child_by_name(dev->of_node, "low-battery-monitor");
> >>>  >+ if (!np) {
> >>>  >+ dev_info(dev, "Low battery monitoring support disabled\n");
> >>>  >+ return 0;
> >>>  >+ }
> >>>  >+
> >>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-enable");
> >>>  >+ if (pval) {
> >>>  >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
> >>>  >+ val |= MAX77620_CNFGGLBL1_LBDAC_EN;
> >>>  >+ }
> >>>  >+
> >>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-disable");
> >>>  >+ if (pval)
> >>>  >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
> >>>  >+
> >>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-enable");
> >>>  >+ if (pval) {
> >>>  >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
> >>>  >+ val |= MAX77620_CNFGGLBL1_MPPLD;
> >>>  >+ }
> >>>  >+
> >>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-disable");
> >>>  >+ if (pval)
> >>>  >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
> >>>  >+
> >>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-enable");
> >>>  >+ if (pval) {
> >>>  >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
> >>>  >+ val |= MAX77620_CNFGGLBL1_LBRSTEN;
> >>>  >+ }
> >>>  >+
> >>>  >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-disable");
> >>>  >+ if (pval)
> >>>  >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
> >>>  >+
> >>>  >+ ret = regmap_update_bits(chip->rmap, MAX77620_REG_CNFGGLBL1, mask, val);
> >>>  >+ if (ret < 0)
> >>>  >+ dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
> >>>  >+ return ret;
> >>>  >+}
> >>>  >+
> >>>  > static int max77620_read_es_version(struct max77620_chip *chip)
> >>>  > {
> >>>  >  unsigned int val;
> >>>  >@@ -563,7 +614,11 @@ static int max77620_probe(struct i2c_client *client,
> >>>  >  if (ret < 0)
> >>>  >  return ret;
> >>>  >
> >>>  >- ret =  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
> >>>  >+ ret = max77620_init_low_battery_monitor(chip);
> >>>  >+ if (ret < 0)
> >>>  >+ return ret;
> >>>  >+
> >>>  >+ ret = devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
> >>>  >      mfd_cells, n_mfd_cells, NULL, 0,
> >>>  >      regmap_irq_get_domain(chip->top_irq_data));
> >>>  >  if (ret < 0) {
> >>>
