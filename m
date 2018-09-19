Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7AAECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80BC208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyhEram6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80BC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeITCsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:48:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35102 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731858AbeITCsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:48:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so3281200pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vt8lHSnfNfWry2xfu2KIPuEYO2di1zWqrH/y4g39hMI=;
        b=uyhEram6z+tIDl4JMUcL5+0BX+QIq8Y+TCWYkv/eGI3FcVCg1Qb+fEhQ02lmbLGHSq
         mHiGUW3YHd4ycnfMIMj3jtdaIzQ5rsn048NFRfLvg9f/6KLmjXXnV3AcZX/r9NFjS2A5
         Ab0z0++HJybIK3NFXpfNCs7t7CdmQs6HZaPwgmJQC0yyVi3AbJaqu8XXZi+QYt8byb5V
         NccG/Eth2aEJpk2QpL8RNJAa0Zmp8xvAhReyXnDchmFAN9U/4NILmECs+TR90qvzNJP0
         4LPFzL3lrbuP9AqFDbu8AHhL5qBHbsvXjH7EK8ZU35V6tDbpYUnLERz5714hvpjXvjc1
         1tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vt8lHSnfNfWry2xfu2KIPuEYO2di1zWqrH/y4g39hMI=;
        b=f0c4GzH0JDuDKgwBU8r4jf8DXYEzZgRc7O4se3ZJscGY+Hk+MtNgtGd0eXmlQYX97U
         3D9pX1kSSY986yIvQeKiGU08hnXvE5FkwX8ys29khpsoGi1BHjxj8ZX8wr5hkbk7M/eO
         /cmO43QbDZr+0kk+pqL29pdjmZzJg/u0wUhn3FKRZ4Jc68uoXshwWD6ewynFzzFBVX7O
         NCheTxtmdIHJqbMywBqYFXpntqkjKJiJdF/mHtQ39/3i6f3ueuU80bSrtWXF2b68g7g4
         byu4hzSj/fQ8QMM9iN9gaEv2AmxvFGTalw+2/c4HdChsKV9bJMFghDeE/UR7Ezt0ADBJ
         3dNg==
X-Gm-Message-State: APzg51DifUjgLSLi+ObWyXwhLTbireG2iIkXq6yq+DS7Yh6URu7N8pW3
        g3eQi06bKfVMVKDh4d2lfthHI1VPMRqJ8YfjK/wo7g==
X-Google-Smtp-Source: ANB0VdYhYNMz8tb0sne1nkj08P2ij43pTUk6H1rucziXD8avTC2Dppnhow79xHydYHAJiuOw4uik525zi4Q5IeLqoSI=
X-Received: by 2002:a62:1815:: with SMTP id 21-v6mr37399036pfy.227.1537391300813;
 Wed, 19 Sep 2018 14:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180919185341.31298-1-natechancellor@gmail.com>
In-Reply-To: <20180919185341.31298-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Sep 2018 14:08:08 -0700
Message-ID: <CAKwvOdkeM3sj8M-LzTQd9M9-sM_K6n6FTz=TrNHd-3xPwg_VNw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: kirin: Fix section mismatch warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:55 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> the function kirin_pcie_probe() to the function
> .init.text:kirin_add_pcie_port()
> The function kirin_pcie_probe() references
> the function __init kirin_add_pcie_port().
> This is often because kirin_pcie_probe lacks a __init
> annotation or the annotation of kirin_add_pcie_port is wrong.
>
> Add the __init annotation to both kirin_pcie_probe and
> kirin_pcie_add_msi then use builtin_platform_driver_probe
> instead of builtin_platform_driver + .probe to avoid a section
> mismatch warning with kirin_pcie_driver.
>
> Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> Instead of removing the annotation on kirin_add_pcie_port, add it to
> kirin_pcie_add_msi and kirin_pcie_probe. To avoid a warning with this
> configuration, use builtin_platform_driver_probe.
>
>  drivers/pci/controller/dwc/pcie-kirin.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 5352e0c3be82..f64fed12de51 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -448,8 +448,8 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>         .host_init = kirin_pcie_host_init,
>  };
>
> -static int kirin_pcie_add_msi(struct dw_pcie *pci,
> -                               struct platform_device *pdev)
> +static int __init kirin_pcie_add_msi(struct dw_pcie *pci,
> +                                    struct platform_device *pdev)
>  {
>         int irq;
>
> @@ -481,7 +481,7 @@ static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>         return dw_pcie_host_init(&pci->pp);
>  }
>
> -static int kirin_pcie_probe(struct platform_device *pdev)
> +static int __init kirin_pcie_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct kirin_pcie *kirin_pcie;
> @@ -533,11 +533,10 @@ static const struct of_device_id kirin_pcie_match[] = {
>  };
>
>  static struct platform_driver kirin_pcie_driver = {
> -       .probe                  = kirin_pcie_probe,
>         .driver                 = {
>                 .name                   = "kirin-pcie",
>                 .of_match_table = kirin_pcie_match,
>                 .suppress_bind_attrs = true,
>         },
>  };
> -builtin_platform_driver(kirin_pcie_driver);
> +builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);

It would be good to get additional review from someone who knows more
about driver callback lifecycles, but I think this is the correct fix.
Thanks Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
