Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB59C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D3B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="MkQnhPDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D3B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeICGme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:42:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45655 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeICGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:42:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so16187552wrb.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Q8uJs07XYgjHltub3lryIofOhA0pHaonZ9vzlsI0yU=;
        b=MkQnhPDLNWpy/OVulnYR+CcjytKh/OnM51vNGgZLISYyZi+lZRUMZMj8uuHHgjF9K2
         gcUJItEGEy2Z7M5I0MyH5XsGT3rWZh5e5EgzZx4LcOeARm0/GyKk/vnxCjFYiLjK0Mjq
         fgovKF2+sPLZ0TSldYEkffsYUZyiHL+EOfhsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Q8uJs07XYgjHltub3lryIofOhA0pHaonZ9vzlsI0yU=;
        b=Y4L2GTfmWXiwd0W3G6WmCsg91z1EnUDWATiDSBw8v5q342tjGD4l5eL1CvU2XvkEqh
         Jss9G/iRI5hRpezI5a6wY040H31QcavOxSDO3aRZcPGONqOIi0kYCe67Ugzf5SE0IBbt
         6Ia9x1m6ZnBvhIfrmkorn7+h2Zi8ODDL/2CYuWb/rlKawH0DIjTAdDmP7gm4xmfpLjUR
         o1qPFpLcFOZMZB2MVCGmWO/0zgaPpydO0QNZ9BpIolva+hUqdaj4OnyRGMFDEX0+yuSL
         L9+hMEhIDMFi2UBaG9IJEtdpu+b/0SY0eedyWnfJ2qsH2vGSTU9DN/vNXQyXzk8T0pEF
         IdGg==
X-Gm-Message-State: APzg51AOaw96eHiLoq37XaPAeulJVxht5OW0CQerUeRUzaL9EjSb/qtb
        nUQoshYV2wUooJJIp8kSmcMG03AuTeIU/lrxWN4zog==
X-Google-Smtp-Source: ANB0VdZrk8roQHBGMM+IC5PToCmKMbIkB8bp7QmYbw58cuhrkINl+ULcy7/v9HJNZ9ZjKkzBKGPfURyM0cK43TfcG70=
X-Received: by 2002:adf:edd2:: with SMTP id v18-v6mr18474724wro.39.1535941474347;
 Sun, 02 Sep 2018 19:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180902064601.183036-1-alexander.levin@microsoft.com> <20180902064601.183036-69-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-69-alexander.levin@microsoft.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Mon, 3 Sep 2018 07:54:23 +0530
Message-ID: <CAFZiPx0kNtJriot9ACK8ZWfjJA7+sL5++Up6a57KNohqr9tGVg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 069/131] PCI: mobiveil: Fix struct
 mobiveil_pcie.pcie_reg_base address type
To:     Alexander.Levin@microsoft.com
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Subrahmanya Lingappa

Thanks.

On Sun, Sep 2, 2018 at 6:34 PM Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
>
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> [ Upstream commit af3f606e0bbb6d811c50b7b90fe324b07fb7cab8 ]
>
> The field pcie_reg_base in struct mobiveil_pcie represents a physical
> address so it should be of phys_addr_t type rather than void __iomem*;
> this results in the following compilation  warnings:
>
> drivers/pci/controller/pcie-mobiveil.c: In function
> 'mobiveil_pcie_parse_dt':
> drivers/pci/controller/pcie-mobiveil.c:326:22: warning: assignment makes
> pointer from integer without a cast [-Wint-conversion]
>   pcie->pcie_reg_base = res->start;
>                       ^
> drivers/pci/controller/pcie-mobiveil.c: In function
> 'mobiveil_pcie_enable_msi':
> drivers/pci/controller/pcie-mobiveil.c:485:25: warning: initialization
> makes integer from pointer without a cast [-Wint-conversion]
>   phys_addr_t msg_addr = pcie->pcie_reg_base;
>                          ^~~~
> drivers/pci/controller/pcie-mobiveil.c: In function
> 'mobiveil_compose_msi_msg':
> drivers/pci/controller/pcie-mobiveil.c:640:21: warning: initialization
> makes integer from pointer without a cast [-Wint-conversion]
>   phys_addr_t addr = pcie->pcie_reg_base + (data->hwirq * sizeof(int));
>
> Fix the type and with it the compilation warnings.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
> driver")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 2c81be37b010..a939e8d31735 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -132,7 +132,7 @@ struct mobiveil_pcie {
>         void __iomem *config_axi_slave_base;    /* endpoint config base */
>         void __iomem *csr_axi_slave_base;       /* root port config base */
>         void __iomem *apb_csr_base;     /* MSI register base */
> -       void __iomem *pcie_reg_base;    /* Physical PCIe Controller Base */
> +       phys_addr_t pcie_reg_base;      /* Physical PCIe Controller Base */
>         struct irq_domain *intx_domain;
>         raw_spinlock_t intx_mask_lock;
>         int irq;
> --
> 2.17.1
