Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE3C676C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE8120841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bY8Axdia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE8120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJHSly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:41:54 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:33530 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJHSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:41:53 -0400
Received: by mail-io1-f53.google.com with SMTP id l25-v6so15581251ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GRNv+NbwItdcpewFicYjHnB35wh2lsONd5BAt+z6qKA=;
        b=bY8Axdia8SGAqrmsUTMD3aJyiOGmVctL9VCGubGYHrILhZbmOd+T6zq4eccCRp1NKG
         ucUTzuEkPJth+PGYkQnm4O0i5q9ERvsVxyDkcpIh3ysd9LSOdSwYkHqv48p9eP/mWQR6
         Kic7gmk4rjsd8MR8l463Vjfb4X43o1tGBdTng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GRNv+NbwItdcpewFicYjHnB35wh2lsONd5BAt+z6qKA=;
        b=oJNWWaae1fESzOGYJeZT3tnjW8vrkwFuWR31KQ6uD6KLP/nFF+LBE6bNV8FR/hRmpR
         QddnHJkSSkZ1IlLqSd0jjuI5wJThS9WATwXhxfrsmNmMfKLT8WHX6C34SqU5KuuHoaif
         +Oa3xSCF+cmoyOrBaluZw2vwxWeVkllZQmO/cvy8vu0KeGK1/Etl/xQmn9CZ8nROmUp6
         7sFYs8uXocC/mKDNakJyXdXCjClCFQikwu9glelOCtzahUhYTrRkRJJiuCTk2ojJYeq3
         xOMaFE6z2kYT8OnPI36bgGRhaoNuhQwp6NimnO/ifmpVKfgJflQ8xeUZRGdvSZH2IvtF
         dYNg==
X-Gm-Message-State: ABuFfoiVjmIrJuAMsExuO4PpPpaA1CrkNNCisw2N8e6s1tnWWuqZ/DK+
        wTDlvUKD7OErdSdDmmBNzUNpDBsczPe5KosYh5ebcw==
X-Google-Smtp-Source: ACcGV61tSvL5wGn+rBqk9amSJHqo4JcLx5mdScswlvcaVtX+/67VPSy0oA9SU1WQqqwhDgYxBS/l+952oyMsvLUThS4=
X-Received: by 2002:a6b:8fcb:: with SMTP id r194-v6mr4579060iod.266.1538998236288;
 Mon, 08 Oct 2018 04:30:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 04:29:55 -0700 (PDT)
In-Reply-To: <20181004111451.9539-2-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-2-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Oct 2018 13:29:55 +0200
Message-ID: <CAPDyKFpHJBebps9Z36MMykfXFWnn3bPZOf2=K8aA2OTXa8W7nQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: am654-mmc-phy: Document new phy bindings
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> +Host controller node:
> +
> +                       sdhci1: sdhci@0 {
> +                               compatible = "ti,am654-sdhci-5.1";
> +                               reg = <0x0 0x1000>;
> +                               power-domains = <&k3_pds 48>;
> +                               clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
> +                               clock-names = "clk_ahb", "clk_xin";
> +                               interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +                               clock-output-names = "mmc_cardclck";

mmc_cardclk

> +                               #clock-cells = <0>;
> +                               phys=<&mmc_phy1>;
> +                               phy-names = "phy_arasan";
> +                               status = "disabled";
> +                       };
> --
> 2.18.0
>

Besides the nitpick and the comments from Andrew, this looks good to me.

Kind regards
Uffe
