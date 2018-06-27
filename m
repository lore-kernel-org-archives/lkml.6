Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72208C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203D325FBE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEm0jHTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203D325FBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965779AbeF0Qpj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:45:39 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44046 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964817AbeF0Qph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:45:37 -0400
Received: by mail-vk0-f67.google.com with SMTP id x4-v6so1563019vkx.11;
        Wed, 27 Jun 2018 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hwg/78C7lgNMteiGOhYNcnNVSQrmHpoAhhSWcgO/UuQ=;
        b=WEm0jHTMYyqELTD+jAhwDihSqCdwj1DXynqwztE6eM+UzufdXS4OXDuo8ElnOcQmbQ
         0OZBRGmub6HBg7KbMPQovKXVkdrzvZsgb4K7GDsyqoxyY+WJB2B9pC8AdcUYUHB0Xi8c
         3Nzxf2Js5eh0RxC4vreE8NcsZdaHDOdTTQHqIrX+XNFeGK5jAi4OZezO08Y0Sm8TePxb
         KSPuygX1aHIZIWXeEoZhSkRwiZnf6fFb44dg7zsDPMzgQ0oZDUj8Azz9y2KzFiVWZIuA
         3OtjFafHN7LTRwZJvmg1a7RX+M15gPmw0MhjeUwNow7cNIXWFtV3e+IPymD993Q2cYaj
         xG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hwg/78C7lgNMteiGOhYNcnNVSQrmHpoAhhSWcgO/UuQ=;
        b=LU9loWVvrbgExQiSILqYy0buN9EAY1IQj4phvMnDu7YLPhS05FQAFDU1U+PcQhyB+R
         GbR5LCt/1xnnsOe9S6Rn46Nl6ptfUbxd1G1kA9cDzF7k+RuQTFaBsjWMFMUkta2UmMzB
         jBmuViNBnHRn/3m5zPOIF9bpImqs6HSSQmXo00k25jwVMtCQGBcWjYog6Xubj4nbqija
         qGdUSUlYTbI37Jfyrvi5sv11VOG/Nztc6D4PO90wfwQNnk06Luxe7RRnMxL7jHRlXkGi
         8tJ8iIrSWriOr8VbY1ETj7b7TAqj6Lofs6Hx5J6mST+RrAY6BXA7w9D/82NB0JKMXjJ3
         8Tcw==
X-Gm-Message-State: APt69E3tEjBhJ/H9QpYBUNU/JNhDhbDwo2Y6jlg3TMOmgUYfb1pF7mbr
        /OJ4vBd+FGnxeSssKcd3ciUh7IhxfCg/kUkufnw=
X-Google-Smtp-Source: AAOMgpeVTjVrKCetgOyKEnmpU7JIzm5h65+sD23ltEi1rGPKiMkK5TlyBG17ikwagUFSWfuSKLVG5CiGGvO032FuEMs=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr4377817vkd.161.1530117936490;
 Wed, 27 Jun 2018 09:45:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:45:36
 -0700 (PDT)
In-Reply-To: <1530091298-28120-4-git-send-email-honghui.zhang@mediatek.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com> <1530091298-28120-4-git-send-email-honghui.zhang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 19:45:36 +0300
Message-ID: <CAHp75VcHgJrujzqstSc4RWpUbjip1vtJu87HN3uTosoLdOiT3A@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: mediatek: Add system pm support for MT2712 and MT7622
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        yingjoe.chen@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com,
        YT Shen <yt.shen@mediatek.com>, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
>
> The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
> suspend, and all the internal control register will be reset after system
> resume. The PCIe link should be re-established and the related control
> register values should be re-set after system resume.

>  struct mtk_pcie_soc {
>         bool need_fix_class_id;

> +       bool pm_support;

Hmm... Do you really need this flag? Can't runtime PM API tell you this?

>         struct pci_ops *ops;
>         int (*startup)(struct mtk_pcie_port *port);
>         int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -1195,12 +1197,76 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>         return err;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_pcie_suspend_noirq(struct device *dev)

Perhaps __maybe_unused?

> +{
> +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> +       const struct mtk_pcie_soc *soc = pcie->soc;
> +       struct mtk_pcie_port *port;
> +
> +       if (!soc->pm_support)
> +               return 0;
> +

> +       if (list_empty(&pcie->ports))
> +               return 0;

So, if the list is empty you are not suspending for the host?


> +
> +       list_for_each_entry(port, &pcie->ports, list) {
> +               clk_disable_unprepare(port->pipe_ck);
> +               clk_disable_unprepare(port->obff_ck);
> +               clk_disable_unprepare(port->axi_ck);
> +               clk_disable_unprepare(port->aux_ck);
> +               clk_disable_unprepare(port->ahb_ck);
> +               clk_disable_unprepare(port->sys_ck);
> +               phy_power_off(port->phy);
> +               phy_exit(port->phy);
> +       }
> +
> +       mtk_pcie_subsys_powerdown(pcie);
> +
> +       return 0;
> +}
> +
> +static int mtk_pcie_resume_noirq(struct device *dev)
> +{
> +       struct mtk_pcie *pcie = dev_get_drvdata(dev);
> +       const struct mtk_pcie_soc *soc = pcie->soc;
> +       struct mtk_pcie_port *port;
> +
> +       if (!soc->pm_support)
> +               return 0;
> +

> +       if (list_empty(&pcie->ports))
> +               return 0;

No runtime PM for this case?
(It seems now I understand why in previous patch you have a similar check)

> +
> +       if (dev->pm_domain) {
> +               pm_runtime_enable(dev);
> +               pm_runtime_get_sync(dev);
> +       }
> +
> +       clk_prepare_enable(pcie->free_ck);
> +
> +       list_for_each_entry(port, &pcie->ports, list)
> +               mtk_pcie_enable_port(port);
> +

> +       if (list_empty(&pcie->ports))

Hmm... How it would be true if you already bailed out above on the
same condition?

> +               mtk_pcie_subsys_powerdown(pcie);
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> +                                     mtk_pcie_resume_noirq)
> +};
> +
>  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
>         .ops = &mtk_pcie_ops,
>         .startup = mtk_pcie_startup_port,
>  };
>
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> +       .pm_support = true,
>         .ops = &mtk_pcie_ops_v2,
>         .startup = mtk_pcie_startup_port_v2,
>         .setup_irq = mtk_pcie_setup_irq,

No update for .pm ?

> @@ -1208,6 +1274,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
>
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>         .need_fix_class_id = true,
> +       .pm_support = true,
>         .ops = &mtk_pcie_ops_v2,
>         .startup = mtk_pcie_startup_port_v2,
>         .setup_irq = mtk_pcie_setup_irq,
> @@ -1227,6 +1294,7 @@ static struct platform_driver mtk_pcie_driver = {
>                 .name = "mtk-pcie",
>                 .of_match_table = mtk_pcie_ids,
>                 .suppress_bind_attrs = true,
> +               .pm = &mtk_pcie_pm_ops,
>         },
>  };
>  builtin_platform_driver(mtk_pcie_driver);
> --
> 2.6.4
>



-- 
With Best Regards,
Andy Shevchenko
