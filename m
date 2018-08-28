Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD8DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C6120846
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdsHCDyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C6120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeH1LvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:51:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50568 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeH1LvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:51:12 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so1427718ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jEO7bLxAdwPhrR8NLyo5OidsoH1xCRVgdhKHDO/K2c=;
        b=ZdsHCDyGM3CFs4GQpq3Sd7nJD5aDjqI+x2oeIWl5dlF2RW5sbciyWyc2Gy0URgBBqG
         aDqQWoLo7QUTdlAXMrQ+xpHm2xU0OCQrPk7dBLHIxxYSWK++bPciJhO+0kRMiHqGWewd
         7KBf4OOh9OVWAWfdRtrcumAXZIbEHS6gLTT7KgZlv33Vsj11ALP0lDFsv4AUeXBfsH4e
         opn3cBx45smRU7k2zn4Y3NdUpvO4EuaM6UgAVAq5kUARBUqXD7l0ZPh5woca3nI3e39q
         uuBg/qH+m6feYDSu+ELXof4ySii9AU6gxNwsbHd6spFXE0w83cH9cjJZFKKWrNZktnpk
         NnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jEO7bLxAdwPhrR8NLyo5OidsoH1xCRVgdhKHDO/K2c=;
        b=nmZKmWxKX6UytLFzI8u8MPSabSVBDTR8yyqjFL2Sf+y/b2gB+HghuDFWhFcZtpifsO
         JfrNCc/K6kiEdhvX7+G3fEZLJ4zA2sg0UPi3+owzZFsYm0VSuBMIWdvRK0nO051hVYE3
         ZtDL3ggR1pCxI4WjFsB3vdENcOv/mRFsP4Xr9CElwzdcZoDgGGDKQn97chXFTspqr+h8
         25FgJvv+zQHHEIbGjOE4uuFNRMzPpFMXanJ1GCrxchIxH4XvUZZUAgJUP152qt3YrEaL
         0re7zOERkhfjkIdYX50xlq2YO1c7ec76exjwIfjRxpg82g4BLIqImbEwRQvzqEw2J6Tg
         BWxA==
X-Gm-Message-State: APzg51CPT2ciumxv2AcYqB8aBuyWy4nThiRunuqySuVxjxWBl+qnGfCf
        s69S12EhBORTn4OsIHJ5rHVm0mel1NBNP5XH//UXK9BH
X-Google-Smtp-Source: ANB0VdbfVeixUgSHci14fks19U3ujq6KJSX+IACkX9NDiFotbc80NScEStwG0dSdZRac/BRkXXXlvSaX4DTraoH3Es0=
X-Received: by 2002:a02:7f0a:: with SMTP id r10-v6mr318266jac.3.1535443244998;
 Tue, 28 Aug 2018 01:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
 <1533537589-7202-2-git-send-email-Anson.Huang@nxp.com> <CAHQ1cqGA37RNoo3KcESCOFeYZxAQCOFkuQQhRPRKCTp=gKLdKQ@mail.gmail.com>
 <DB3PR0402MB39160F15A078B7FE8BF13105F50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39160F15A078B7FE8BF13105F50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 28 Aug 2018 01:00:33 -0700
Message-ID: <CAHQ1cqGMCxGhsuf=jUOjqqPc46iTT2WKV0xBsrYfdhooBicGGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for
 other i.MX platforms
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:28 AM Anson Huang <anson.huang@nxp.com> wrote:
>
>
>
> Anson Huang
> Best Regards!
>
>
> > -----Original Message-----
> > From: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Sent: Tuesday, August 28, 2018 6:51 AM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> > Estevam <fabio.estevam@nxp.com>; linux-arm-kernel
> > <linux-arm-kernel@lists.infradead.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for
> > other i.MX platforms
> >
> > On Sun, Aug 5, 2018 at 11:45 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > i.MX8MQ and i.MX8MM share same gpc module with i.MX7D, they can reuse
> > > gpcv2 pgc driver for power domain control, this patch renames all
> > > functions and structure definitions started with "imx7" to "imx", and
> > > check machine type to pass platform specific power domain data for
> > > power domain driver, thus make
> > > gpcv2 pgc driver more generic for i.MX platforms.
> > >
> >
> > Just for the sake of
> >
> >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  drivers/soc/imx/gpcv2.c | 68
> > > +++++++++++++++++++++++++++++--------------------
> > >  1 file changed, 40 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c index
> > > 0e31465..0e33cb5 100644
> > > --- a/drivers/soc/imx/gpcv2.c
> > > +++ b/drivers/soc/imx/gpcv2.c
> > > @@ -53,7 +53,7 @@
> > >
> > >  #define GPC_PGC_CTRL_PCR               BIT(0)
> > >
> > > -struct imx7_pgc_domain {
> > > +struct imx_pgc_domain {
> > >         struct generic_pm_domain genpd;
> > >         struct regmap *regmap;
> > >         struct regulator *regulator;
> > > @@ -69,11 +69,11 @@ struct imx7_pgc_domain {
> > >         struct device *dev;
> > >  };
> > >
> > > -static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain
> > > *genpd,
> > > +static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
> > >                                       bool on)  {
> > > -       struct imx7_pgc_domain *domain = container_of(genpd,
> > > -                                                     struct
> > imx7_pgc_domain,
> > > +       struct imx_pgc_domain *domain = container_of(genpd,
> > > +                                                     struct
> > > + imx_pgc_domain,
> > >                                                       genpd);
> > >         unsigned int offset = on ?
> > >                 GPC_PU_PGC_SW_PUP_REQ :
> > GPC_PU_PGC_SW_PDN_REQ; @@
> > > -150,17 +150,17 @@ static int imx7_gpc_pu_pgc_sw_pxx_req(struct
> > generic_pm_domain *genpd,
> > >         return ret;
> > >  }
> > >
> > > -static int imx7_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain
> > > *genpd)
> > > +static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
> > >  {
> > > -       return imx7_gpc_pu_pgc_sw_pxx_req(genpd, true);
> > > +       return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
> > >  }
> > >
> > > -static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain
> > > *genpd)
> > > +static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
> > >  {
> > > -       return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
> > > +       return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
> > >  }
> > >
> > > -static const struct imx7_pgc_domain imx7_pgc_domains[] = {
> > > +static const struct imx_pgc_domain imx7_pgc_domains[] = {
> > >         [IMX7_POWER_DOMAIN_MIPI_PHY] = {
> > >                 .genpd = {
> > >                         .name      = "mipi-phy",
> > > @@ -198,9 +198,9 @@ static const struct imx7_pgc_domain
> > imx7_pgc_domains[] = {
> > >         },
> > >  };
> > >
> > > -static int imx7_pgc_domain_probe(struct platform_device *pdev)
> > > +static int imx_pgc_domain_probe(struct platform_device *pdev)
> > >  {
> > > -       struct imx7_pgc_domain *domain = pdev->dev.platform_data;
> > > +       struct imx_pgc_domain *domain = pdev->dev.platform_data;
> > >         int ret;
> > >
> > >         domain->dev = &pdev->dev;
> > > @@ -233,9 +233,9 @@ static int imx7_pgc_domain_probe(struct
> > platform_device *pdev)
> > >         return ret;
> > >  }
> > >
> > > -static int imx7_pgc_domain_remove(struct platform_device *pdev)
> > > +static int imx_pgc_domain_remove(struct platform_device *pdev)
> > >  {
> > > -       struct imx7_pgc_domain *domain = pdev->dev.platform_data;
> > > +       struct imx_pgc_domain *domain = pdev->dev.platform_data;
> > >
> > >         of_genpd_del_provider(domain->dev->of_node);
> > >         pm_genpd_remove(&domain->genpd); @@ -243,23 +243,24 @@
> > static
> > > int imx7_pgc_domain_remove(struct platform_device *pdev)
> > >         return 0;
> > >  }
> > >
> > > -static const struct platform_device_id imx7_pgc_domain_id[] = {
> > > -       { "imx7-pgc-domain", },
> > > +static const struct platform_device_id imx_pgc_domain_id[] = {
> > > +       { "imx-pgc-domain", },
> > >         { },
> > >  };
> > >
> > > -static struct platform_driver imx7_pgc_domain_driver = {
> > > +static struct platform_driver imx_pgc_domain_driver = {
> > >         .driver = {
> > > -               .name = "imx7-pgc",
> > > +               .name = "imx-pgc",
> > >         },
> > > -       .probe    = imx7_pgc_domain_probe,
> > > -       .remove   = imx7_pgc_domain_remove,
> > > -       .id_table = imx7_pgc_domain_id,
> > > +       .probe    = imx_pgc_domain_probe,
> > > +       .remove   = imx_pgc_domain_remove,
> > > +       .id_table = imx_pgc_domain_id,
> > >  };
> > > -builtin_platform_driver(imx7_pgc_domain_driver)
> > > +builtin_platform_driver(imx_pgc_domain_driver)
> > >
> > >  static int imx_gpcv2_probe(struct platform_device *pdev)  {
> > > +       static const struct imx_pgc_domain *imx_pgc_domains;
> > >         static const struct regmap_range yes_ranges[] = {
> > >                 regmap_reg_range(GPC_LPCR_A_CORE_BSC,
> > >                                  GPC_M4_PU_PDN_FLG), @@
> > -287,6 +288,7
> > > @@ static int imx_gpcv2_probe(struct platform_device *pdev)
> > >         struct regmap *regmap;
> > >         struct resource *res;
> > >         void __iomem *base;
> > > +       int pgc_max_index;
> > >         int ret;
> > >
> > >         pgc_np = of_get_child_by_name(dev->of_node, "pgc"); @@ -307,9
> > > +309,19 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
> > >                 return ret;
> > >         }
> > >
> > > +       if (of_machine_is_compatible("fsl,imx7d")) {
> > > +               pgc_max_index = ARRAY_SIZE(imx7_pgc_domains);
> > > +               imx_pgc_domains = imx7_pgc_domains;
> > > +       }
> >
> > Is there any reason to do this explicit call to
> > of_machine_is_compatible() as opposed to passing necessary data via .data in
> > imx_gpcv2_dt_ids[]? The latter seems like a more straightforward way of
> > passing variant specific driver info
>
> The reason of NOT using .data is that currently gpcv2 driver uses a structure array
> of imx7_pgc_domains[] which has no fixed length, the .data can ONLY pass the pointer
> of the starting address of imx7_pgc_domains[], and we need to know the array size of
> imx7_pgc_domains, how can we know it if we ONLY got the starting address of this array
> passed from .data. Please advise, thanks.
>

Unless I am missing something, you should be able to do something like:

struct imx_pgc_domain_data {
    struct imx_pgc_domain *domains;
    size_t domains_num;
};

const struct imx_pgc_domain_data imx7_pgc_domain_data = {
    .domains = imx7_pgc_domains,
    .domains_num = ARRAY_SIZE(imx7_pgc_domains),
};

and then just pass imx7_pgc_domain_data via .data. That's a pretty
common idiom in kernel driver.

Thanks,
Andrey Smirnov
