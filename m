Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852B2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABAD20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izq3EdOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABAD20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeGKJdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:33:47 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38304 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeGKJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:33:47 -0400
Received: by mail-ua0-f196.google.com with SMTP id o11-v6so2172952uak.5;
        Wed, 11 Jul 2018 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=17xYwj2h7YOILVec0d8EmoPBsAaCW7i1nNwINyp1uhA=;
        b=izq3EdOymGS29/Lti6bwsx0o7eGLN0tqOvOgToiHBUizPKPz9c9fB6GlsSiFD41hB/
         tUx2gfVrn1rJQpYuCXwbsJy8zb7DVmIZXpKRCpZ5I65inmzBpDLjO47lOp6cr/uWSr0/
         vVMbp0RSlC3h0z99vFewbb3rNLrsVqJO57v+WycDspyDdHdje1CntFRPcJntcpeuSCTx
         vdaR1wYYklocr9wNs1xDhhe7IL8yjvXK7CNQBcf79/ov9m3EBl7a9X/e0P1nI5PcHWsI
         fZl9+n4cX/x4Qu+dn8EEFxByr785+F9P/mSEKdEMAqsraEA63cD/R68fEq9ZSYZXc8O7
         m68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=17xYwj2h7YOILVec0d8EmoPBsAaCW7i1nNwINyp1uhA=;
        b=Otu8Yb0muxmfduwBN2NRihqojX4DRkgooUo15ljWcFyMrY82zI0mY5V3xpw+tqTgSe
         AndCJ/v20sV08s4I9yBDuQCd5QrnxrTR1BQpfSN9WnRHHFSM2t4oTg96SxHL8qWnWaF5
         lHm/3Wq/60nH4/YEz+va1nXTXk3bCOwhMLNrxQ+coFu/9RGfYO9QmZXV46DBK83ASRZ9
         r7q8M6Gs7EnqS/Pe04HCND6wqeZCZQze1IAd/Kk0mUtHbkCFwM4F2gFVFumTYLkwmsiu
         FTw+5VcSruBDhx9uKvYFT9aN/U0+6EbkoXXRb4WmyII0o5DjUeaekaqSkmawO1FEQrgZ
         wN1g==
X-Gm-Message-State: APt69E10dFEDP2W7n5eS/ecE4mCH7S3CRi5C3fcygkGEsl7PAcJWaOv/
        pp/TsyJs/rrsR0Exn1qurdvlq+oI+q1BFKuFRWo=
X-Google-Smtp-Source: AAOMgpfPSJv06WcZ6bF6ONyoA0nOcv2xKAx7wB7iWPchDgKVYpZCiRAsQnQybcSFMl24FQwygIk1TAfp21j7hRFfnQ8=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr5444612ual.141.1531301422256;
 Wed, 11 Jul 2018 02:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 02:30:21
 -0700 (PDT)
In-Reply-To: <20180711080946.14942-2-songxiaowei@hisilicon.com>
References: <20180711080946.14942-1-songxiaowei@hisilicon.com> <20180711080946.14942-2-songxiaowei@hisilicon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Jul 2018 12:30:21 +0300
Message-ID: <CAHp75VccZtHqpoeWhVa=D=tc_Dj5cX8SXg=vYowWJ_RAiKdiCQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] PCI: kirin: Add MSI support
To:     Xiaowei Song <songxiaowei@hisilicon.com>
Cc:     Wangbinghui <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Yao Chen <chenyao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:09 AM, Xiaowei Song
<songxiaowei@hisilicon.com> wrote:
> Add support for MSI
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Yao Chen <chenyao11@huawei.com>
> ---
>  drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index d2970a009eb5..5352e0c3be82 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -430,6 +430,9 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  {
>         kirin_pcie_establish_link(pp);
>
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               dw_pcie_msi_init(pp);
> +
>         return 0;
>  }
>
> @@ -445,9 +448,34 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>         .host_init = kirin_pcie_host_init,
>  };
>
> +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> +                               struct platform_device *pdev)
> +{
> +       int irq;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               irq = platform_get_irq(pdev, 0);
> +               if (irq < 0) {
> +                       dev_err(&pdev->dev,
> +                               "failed to get MSI IRQ (%d)\n", irq);
> +                       return irq;
> +               }
> +
> +               pci->pp.msi_irq = irq;
> +       }
> +
> +       return 0;
> +}
> +
>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>                                       struct platform_device *pdev)
>  {
> +       int ret;
> +
> +       ret = kirin_pcie_add_msi(pci, pdev);
> +       if (ret)
> +               return ret;
> +
>         pci->pp.ops = &kirin_pcie_host_ops;
>
>         return dw_pcie_host_init(&pci->pp);
> --
> 2.11.GIT
>



-- 
With Best Regards,
Andy Shevchenko
