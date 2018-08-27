Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81835C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78F208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb9PCCrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E78F208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeH1Cwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:52:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37996 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1Cwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:52:37 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so855472ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cf/rSBBS1MuOh5Ce3AnoaoD2UFE1tPMZV6K+zD1OOZw=;
        b=Mb9PCCrYiqMD85Mqr8GrTZ881/BdqWrXqtSmdNywozrsgyUATJB066+HLrT0ZlaCk2
         m3TLPl2B3v7l5efNWahhakIGTWTKMDqeRCjqBflKllU/8kEnZoq53sAzi0tQTbDLtbTN
         X2FjGH6R7C1xfW+fuIlchwgzLelXwAffa+9Qn3ncKC4YbFMsLoath28Zwyt/OUxGwnUj
         WiDdG3t4XBqDN1vCzQT7KuZpakBOzdkwMYERxo+VHdppxdwqr2l0UutP1dzWfxbJKGxe
         LXQ7MD6dABeOqKYEg4F2BZg1jSdFFR5XauDV0/kT+3+sjjpZwo5rN8FaDGfqdHm5nEch
         RI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cf/rSBBS1MuOh5Ce3AnoaoD2UFE1tPMZV6K+zD1OOZw=;
        b=niwNseDDw+VcbD0Dt5iHp0cAHqmLjsRdmpp/d8P41JjbHOaigBwhcNFkoeQULZnia+
         09qVi2DZAjtUWGZ/S/719kcmScTBNgqLKqpfocJbNP0AJjP+LYwx9slUDSK+mSOxXy0r
         uXFhvKZ0t26/5F/0c1sRAGOhW7JeWWFkzjquiR8WF5icXWCCh178sD7VQLrMYBvkS7Fd
         KSJptouCfaVH7Bqrqq2t84ylZPTBJyxJjKK0+C2atbUlmvhcq1CmFztsin5FW6p0fATg
         bvorkkc70x5gYLcF/VY7fv5mwLU4ZQlYSWEPZs/tgW+fBSzNlxjS10bof6Dg4yQlJQ1D
         V83g==
X-Gm-Message-State: APzg51BR8iKTqIWb6q397CgTVK6o/lqh4K9+uZwBEkZpmr96k9L/kutz
        rEwyIU+RGQSUThWL3iDYAO4A25oNn/qsvOoK2zM=
X-Google-Smtp-Source: ANB0VdYM36U7Tc6AXl+FkYEVGM5zEcsXLQZEWoR9MKd9h4HzuBLdbwbD4VRj5IQASEWKbU1joweFoQAkBd4cZrJEaWk=
X-Received: by 2002:a24:d6d3:: with SMTP id o202-v6mr8323743itg.115.1535411033571;
 Mon, 27 Aug 2018 16:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
 <1533537589-7202-2-git-send-email-Anson.Huang@nxp.com> <CAHQ1cqGA37RNoo3KcESCOFeYZxAQCOFkuQQhRPRKCTp=gKLdKQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqGA37RNoo3KcESCOFeYZxAQCOFkuQQhRPRKCTp=gKLdKQ@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 27 Aug 2018 16:03:42 -0700
Message-ID: <CAHQ1cqEy0hQg3ByZVx4tW7f6cifzU++ptrV40TcH01GsKmHP3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for
 other i.MX platforms
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 3:51 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> On Sun, Aug 5, 2018 at 11:45 PM Anson Huang <Anson.Huang@nxp.com> wrote:
> >
> > i.MX8MQ and i.MX8MM share same gpc module with i.MX7D, they
> > can reuse gpcv2 pgc driver for power domain control, this
> > patch renames all functions and structure definitions started
> > with "imx7" to "imx", and check machine type to pass platform
> > specific power domain data for power domain driver, thus make
> > gpcv2 pgc driver more generic for i.MX platforms.
> >
>
> Just for the sake of

Oops, forgot to type out the question I had about i.MX8MQ GPC in
general. I've noticed that vendor tree for i.MX8MQ has a separate
driver for GPC that relies on code in ARM Trusted Firmware binary blob
to do the actual switching. Do you by any chances know the relation
between this code and the driver I describe? Are they mutually
exclusive or complimentary (I assume the former)? Will the ATF-based
driver be eventually deprecated?

Thanks,
Andrey Smirnov

>
>
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/soc/imx/gpcv2.c | 68 +++++++++++++++++++++++++++++--------------------
> >  1 file changed, 40 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index 0e31465..0e33cb5 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -53,7 +53,7 @@
> >
> >  #define GPC_PGC_CTRL_PCR               BIT(0)
> >
> > -struct imx7_pgc_domain {
> > +struct imx_pgc_domain {
> >         struct generic_pm_domain genpd;
> >         struct regmap *regmap;
> >         struct regulator *regulator;
> > @@ -69,11 +69,11 @@ struct imx7_pgc_domain {
> >         struct device *dev;
> >  };
> >
> > -static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
> > +static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
> >                                       bool on)
> >  {
> > -       struct imx7_pgc_domain *domain = container_of(genpd,
> > -                                                     struct imx7_pgc_domain,
> > +       struct imx_pgc_domain *domain = container_of(genpd,
> > +                                                     struct imx_pgc_domain,
> >                                                       genpd);
> >         unsigned int offset = on ?
> >                 GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
> > @@ -150,17 +150,17 @@ static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
> >         return ret;
> >  }
> >
> > -static int imx7_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
> > +static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
> >  {
> > -       return imx7_gpc_pu_pgc_sw_pxx_req(genpd, true);
> > +       return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
> >  }
> >
> > -static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
> > +static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
> >  {
> > -       return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
> > +       return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
> >  }
> >
> > -static const struct imx7_pgc_domain imx7_pgc_domains[] = {
> > +static const struct imx_pgc_domain imx7_pgc_domains[] = {
> >         [IMX7_POWER_DOMAIN_MIPI_PHY] = {
> >                 .genpd = {
> >                         .name      = "mipi-phy",
> > @@ -198,9 +198,9 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
> >         },
> >  };
> >
> > -static int imx7_pgc_domain_probe(struct platform_device *pdev)
> > +static int imx_pgc_domain_probe(struct platform_device *pdev)
> >  {
> > -       struct imx7_pgc_domain *domain = pdev->dev.platform_data;
> > +       struct imx_pgc_domain *domain = pdev->dev.platform_data;
> >         int ret;
> >
> >         domain->dev = &pdev->dev;
> > @@ -233,9 +233,9 @@ static int imx7_pgc_domain_probe(struct platform_device *pdev)
> >         return ret;
> >  }
> >
> > -static int imx7_pgc_domain_remove(struct platform_device *pdev)
> > +static int imx_pgc_domain_remove(struct platform_device *pdev)
> >  {
> > -       struct imx7_pgc_domain *domain = pdev->dev.platform_data;
> > +       struct imx_pgc_domain *domain = pdev->dev.platform_data;
> >
> >         of_genpd_del_provider(domain->dev->of_node);
> >         pm_genpd_remove(&domain->genpd);
> > @@ -243,23 +243,24 @@ static int imx7_pgc_domain_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -static const struct platform_device_id imx7_pgc_domain_id[] = {
> > -       { "imx7-pgc-domain", },
> > +static const struct platform_device_id imx_pgc_domain_id[] = {
> > +       { "imx-pgc-domain", },
> >         { },
> >  };
> >
> > -static struct platform_driver imx7_pgc_domain_driver = {
> > +static struct platform_driver imx_pgc_domain_driver = {
> >         .driver = {
> > -               .name = "imx7-pgc",
> > +               .name = "imx-pgc",
> >         },
> > -       .probe    = imx7_pgc_domain_probe,
> > -       .remove   = imx7_pgc_domain_remove,
> > -       .id_table = imx7_pgc_domain_id,
> > +       .probe    = imx_pgc_domain_probe,
> > +       .remove   = imx_pgc_domain_remove,
> > +       .id_table = imx_pgc_domain_id,
> >  };
> > -builtin_platform_driver(imx7_pgc_domain_driver)
> > +builtin_platform_driver(imx_pgc_domain_driver)
> >
> >  static int imx_gpcv2_probe(struct platform_device *pdev)
> >  {
> > +       static const struct imx_pgc_domain *imx_pgc_domains;
> >         static const struct regmap_range yes_ranges[] = {
> >                 regmap_reg_range(GPC_LPCR_A_CORE_BSC,
> >                                  GPC_M4_PU_PDN_FLG),
> > @@ -287,6 +288,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
> >         struct regmap *regmap;
> >         struct resource *res;
> >         void __iomem *base;
> > +       int pgc_max_index;
> >         int ret;
> >
> >         pgc_np = of_get_child_by_name(dev->of_node, "pgc");
> > @@ -307,9 +309,19 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
> >                 return ret;
> >         }
> >
> > +       if (of_machine_is_compatible("fsl,imx7d")) {
> > +               pgc_max_index = ARRAY_SIZE(imx7_pgc_domains);
> > +               imx_pgc_domains = imx7_pgc_domains;
> > +       }
>
> Is there any reason to do this explicit call to
> of_machine_is_compatible() as opposed to passing necessary data via
> .data in imx_gpcv2_dt_ids[]? The latter seems like a more
> straightforward way of passing variant specific driver info
>
> > +
> > +       if (!imx_pgc_domains) {
> > +               dev_err(&pdev->dev, "no device match found\n");
> > +               return -ENODEV;
> > +       }
>
> And doing so would also allow you to drop the check above.
>
> Other that this seems like a reasonable change:
>
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Thanks,
> Andrey Smirnov
