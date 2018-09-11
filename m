Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC37C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E952E20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="eNKWE6US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E952E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeIKMYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:24:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46503 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:24:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so24428020wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoCk2FDS3cFEhm8ZxV3H9VxZOC3ar1T1bbaE34Y9IsE=;
        b=eNKWE6USkXUFvYMjGV92LvxM6IeBeP4ym5WFEd04aLjzYKKgaUt3SIkFHbfS9Ibfmy
         7oKbfQnk2AnpR10X3mjwruC8/IrCXH22D9HmZkyMyA/QC0KnBHWaKbVcAMWg6tZQU1cJ
         6rKZybS/nDEC5kQ8yBPPQ6ayeHZ6LAc/mTO0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoCk2FDS3cFEhm8ZxV3H9VxZOC3ar1T1bbaE34Y9IsE=;
        b=d2BPOEUBNY5ZgEaCMMOnsQhaqRq9IYT5wrsUTE1g9yR5qxpTh6rI7LLzcie3MDKWv2
         QKctd4hfhHoPu4UdqznfQ1tJitw3JmtYgY9QozOaeIWxMdmCuv2TrwXkSPXURbCfNX7q
         G54JSd2ac3xneI0tSXwmWs8LB1TiV65P/6Rys2WKeT43/ogFXhjCaPjkyJy3PxgY/Qz4
         PO4Fi/Y1WNbYVTOUTy1G5T8XbT+AVqDXeviYGZOcAlk+4ZQv11gO2E4j0Lm6WFjNWL3c
         hraCsXjH3kSZwxdtux7S0SUQCZBebSbcRkvp/Z9JQnf81eassKvQcxt6Ng+2gJjCcXNh
         QTcA==
X-Gm-Message-State: APzg51CONzitDNmyrXal+iLEac9IjdJr+s6I5BUNg7DycosEaNnLYJc7
        FmCkKIKb8ihHvGGLR4/ZzsAyFzOmc30qs2DEPcEyrg==
X-Google-Smtp-Source: ANB0VdZhH08IgTJiYzk4e1tHPnP8TdnQ33VYDfmeQH0IMCGxmQO61aKEBJlpJ84wnwBMbUmurj8PcM8eAEjoEwjATrE=
X-Received: by 2002:adf:f7c4:: with SMTP id a4-v6mr18269096wrq.86.1536650793866;
 Tue, 11 Sep 2018 00:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180829183440.13601-1-robh@kernel.org>
In-Reply-To: <20180829183440.13601-1-robh@kernel.org>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 11 Sep 2018 12:56:24 +0530
Message-ID: <CAFZiPx18GLf5QypztjtMgb0uDF86PG9ky5mj6eOdyHNsqUpirA@mail.gmail.com>
Subject: Re: [PATCH] PCI: remove unnecessary check of device_type == pci
To:     robh@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        Bjorn Helgaas <bhelgaas@google.com>, adouglas@cadence.com,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with regards to : drivers/pci/controller/pcie-mobiveil.c
Acked-by: Subrahmaya Lingappa <l.subrahmanya@mobiveil.co.in>

Thanks.

On Thu, Aug 30, 2018 at 12:04 AM Rob Herring <robh@kernel.org> wrote:
>
> PCI host drivers have already matched on compatible strings, so checking
> device_type is redundant. Also, device_type is considered deprecated for
> FDT though we've still been requiring it for PCI hosts as it is useful
> for finding PCI buses.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alan Douglas <adouglas@cadence.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pci-host-common.c   | 8 --------
>  drivers/pci/controller/pcie-cadence-host.c | 7 -------
>  drivers/pci/controller/pcie-mobiveil.c     | 7 -------
>  drivers/pci/controller/pcie-xilinx-nwl.c   | 9 ---------
>  drivers/pci/controller/pcie-xilinx.c       | 7 -------
>  5 files changed, 38 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d8f10451f273..c742881b5061 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -58,9 +58,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>  int pci_host_common_probe(struct platform_device *pdev,
>                           struct pci_ecam_ops *ops)
>  {
> -       const char *type;
>         struct device *dev = &pdev->dev;
> -       struct device_node *np = dev->of_node;
>         struct pci_host_bridge *bridge;
>         struct pci_config_window *cfg;
>         struct list_head resources;
> @@ -70,12 +68,6 @@ int pci_host_common_probe(struct platform_device *pdev,
>         if (!bridge)
>                 return -ENOMEM;
>
> -       type = of_get_property(np, "device_type", NULL);
> -       if (!type || strcmp(type, "pci")) {
> -               dev_err(dev, "invalid \"device_type\" %s\n", type);
> -               return -EINVAL;
> -       }
> -
>         of_pci_check_probe_only();
>
>         /* Parse and map our Configuration Space windows */
> diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
> index ec394f6a19c8..97e251090b4f 100644
> --- a/drivers/pci/controller/pcie-cadence-host.c
> +++ b/drivers/pci/controller/pcie-cadence-host.c
> @@ -235,7 +235,6 @@ static int cdns_pcie_host_init(struct device *dev,
>
>  static int cdns_pcie_host_probe(struct platform_device *pdev)
>  {
> -       const char *type;
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>         struct pci_host_bridge *bridge;
> @@ -268,12 +267,6 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>         rc->device_id = 0xffff;
>         of_property_read_u16(np, "device-id", &rc->device_id);
>
> -       type = of_get_property(np, "device_type", NULL);
> -       if (!type || strcmp(type, "pci")) {
> -               dev_err(dev, "invalid \"device_type\" %s\n", type);
> -               return -EINVAL;
> -       }
> -
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
>         pcie->reg_base = devm_ioremap_resource(dev, res);
>         if (IS_ERR(pcie->reg_base)) {
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a939e8d31735..77052a0712d0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -301,13 +301,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>         struct platform_device *pdev = pcie->pdev;
>         struct device_node *node = dev->of_node;
>         struct resource *res;
> -       const char *type;
> -
> -       type = of_get_property(node, "device_type", NULL);
> -       if (!type || strcmp(type, "pci")) {
> -               dev_err(dev, "invalid \"device_type\" %s\n", type);
> -               return -EINVAL;
> -       }
>
>         /* map config resource */
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index fb32840ce8e6..81538d77f790 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -777,16 +777,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>                              struct platform_device *pdev)
>  {
>         struct device *dev = pcie->dev;
> -       struct device_node *node = dev->of_node;
>         struct resource *res;
> -       const char *type;
> -
> -       /* Check for device type */
> -       type = of_get_property(node, "device_type", NULL);
> -       if (!type || strcmp(type, "pci")) {
> -               dev_err(dev, "invalid \"device_type\" %s\n", type);
> -               return -EINVAL;
> -       }
>
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
>         pcie->breg_base = devm_ioremap_resource(dev, res);
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 7b1389d8e2a5..9bd1a35cd5d8 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -574,15 +574,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>         struct device *dev = port->dev;
>         struct device_node *node = dev->of_node;
>         struct resource regs;
> -       const char *type;
>         int err;
>
> -       type = of_get_property(node, "device_type", NULL);
> -       if (!type || strcmp(type, "pci")) {
> -               dev_err(dev, "invalid \"device_type\" %s\n", type);
> -               return -EINVAL;
> -       }
> -
>         err = of_address_to_resource(node, 0, &regs);
>         if (err) {
>                 dev_err(dev, "missing \"reg\" property\n");
> --
> 2.17.1
>
