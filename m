Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F893C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2BC2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="JQjyNvjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBEGJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:09:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40475 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfBEGJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:09:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so2275081wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdqnK8Sush9EMCE1fFJIyiI9lYcylVQGWUm228F9l+M=;
        b=JQjyNvjZOBil8q9iAorY2tERlu1QjToI85LOozJUiZE+qJke32JsVqqf1J8KJnK2d5
         22xkaKyZapXLrAXCS2memoDt3mTJ+9JJM52z3Tke1Ddcdv1jx9ER28HzN4BZkwY1xHov
         zuqqHkludEn4JXqX0/+4+4WVBOMIMh0/8+NTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdqnK8Sush9EMCE1fFJIyiI9lYcylVQGWUm228F9l+M=;
        b=mnSyCLmYHh1EgLcAbeIILzreznR9bOLhso9GkFwuG4PJoDZk8FZf+qMDTJdrE59pIc
         4k+oABOggNedQHouB73F8FlbDmiZ76QJxkf7AjPZq+PRYn1E9v6hXmNmz52LUB3tI+jd
         FPdTwJSo3dcyfI1hsZP3OttbpfjHc1wHGgN3k20RoRv25GYXV3gtz3BPj0LRh7tUe/Oq
         NUCE5DTZlbJR6RjggSq2zug6PhfXwdOj3u9DL/m9/VfhOvgX5PgG4GinRqDuDMT9wVfG
         KB6NfHrmmMQnFw7GbL6TJ1Kh/4dSNsmpV46FPLt+iIa4x7UCWMsPm1iLnnjY311tufFZ
         WDqw==
X-Gm-Message-State: AHQUAuYBQy6Ynd/pZB9fKz/GxB+nm3HcUmSz2lS9IOHf4RwX1NPwKWjE
        bHShr9/0DCPa7V8jbi7tKoDEzqMUmgKY1HDAaWwyxA==
X-Google-Smtp-Source: AHgI3IZ94KpSa1rFUiP8ICd+DRFXJ3gmTCXEbGLNFKoo2UQqsYqDvegQhzUIXAFmny8CreI3DLHmbWw4VYKyullADL4=
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr2163957wmk.152.1549346979076;
 Mon, 04 Feb 2019 22:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-13-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-13-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:42:13 +0530
Message-ID: <CAFZiPx3wPsO3CkLZD9SxUTkqVZR1fW4qqAtsNxcYHMNVsD82gw@mail.gmail.com>
Subject: Re: [PATCHv3 12/27] PCI: mobiveil: move out the link up waiting from mobiveil_host_init
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Host initial sequence does not depend on PCIe link up, so move it
> to the place just before the enumeration.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 8eee1ab7ee24..c2848c22b466 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -582,15 +582,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>  static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>         u32 value, pab_ctrl, type;
> -       int err;
>         struct resource_entry *win;
>
> -       err = mobiveil_bringup_link(pcie);
> -       if (err) {
> -               dev_info(&pcie->pdev->dev, "link bring-up failed\n");
> -               return err;
> -       }
> -
>         /*
>          * program Bus Master Enable Bit in Command Register in PAB Config
>          * Space
> @@ -662,7 +655,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         /* setup MSI hardware registers */
>         mobiveil_pcie_enable_msi(pcie);
>
> -       return err;
> +       return 0;
>  }
>
>  static void mobiveil_mask_intx_irq(struct irq_data *data)
> @@ -922,6 +915,12 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>         bridge->map_irq = of_irq_parse_and_map_pci;
>         bridge->swizzle_irq = pci_common_swizzle;
>
> +       ret = mobiveil_bringup_link(pcie);
> +       if (ret) {
> +               dev_info(dev, "link bring-up failed\n");
> +               goto error;
> +       }
> +
>         /* setup the kernel resources for the newly added PCIe root bus */
>         ret = pci_scan_root_bus_bridge(bridge);
>         if (ret)
> --
> 2.17.1
>
