Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C70C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DA92064A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsG7XPwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DA92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeLEOYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:24:39 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45061 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeLEOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:24:39 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so7135019uam.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uCIeG7sBnASqCzvyLV/gHpV16Vx6IMI9GaXxGzmgSA=;
        b=jsG7XPwTT8XlvZCzB7A8VlAQ7SuJ+ZRrkTt7Yo6MuKnK47w3eitewbr0FIYV2ldt8K
         1QWiL5KeX0JMd6OXyQRslQwbwTGWWcE5UunbUyBQ566aZG1boB0yh+58nZX07eXBNu//
         q+sRjkM54A8YBbmUajdj6NC2T0YbNY3obh1TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uCIeG7sBnASqCzvyLV/gHpV16Vx6IMI9GaXxGzmgSA=;
        b=gK71c3G1LivlfelOq57T7NuYj4RIh0gXP2FC1pu8HBamqJqzknAd12nSKLRYbDypwD
         fUbkYlcSqZe/eYPWcSXZxWUWGcYoXbnyMwUXMxLGCv6DhqK3DO+Y+SwWqGK1i5hYUYQw
         DEIXwr50HRdptMoq3bjB6phfeFzNSD3f7UA1WyAsT5P8uF8wh9XJICl4qp45Og4MaGmC
         5HptAzouOpVtFSwOlP2pwCjP0Vm6Y4nyZ8l+ItYQK2N+uR21vXOaDc3FeLiMS6JZxiuz
         AXrAO2IoxQlOEVp7UChkHB3PO4D3/lpPQelOruBtk9HJS827S471nO7a+EQl3309QnQ3
         vYrg==
X-Gm-Message-State: AA+aEWZbpbYh6LhuB+IAXPGskQ/ttbovVVITqm6m/04ifz3LL6t1ij+Z
        LjfczZDpntXoJlPS6Z8lKBFvf+HPJbC8wIv7BY/SLw==
X-Google-Smtp-Source: AFSGD/XWprS0KuzDishFKLZCQvZRWpVTF1U7TzhocEBZ9iRJm8Rzk3N2ruVLl4PJPn0yGB5Ik7w1iyWIfbfRjxKibvE=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr11454574uan.107.1544019878263;
 Wed, 05 Dec 2018 06:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20181128223428.177313-1-evgreen@chromium.org> <20181128223428.177313-2-evgreen@chromium.org>
In-Reply-To: <20181128223428.177313-2-evgreen@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 15:24:02 +0100
Message-ID: <CAPDyKFp5Bsp4Mhkkj+tMOn22BhtaS+m_o2Aeo25iyGQJAgOPbw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 23:34, Evan Green <evgreen@chromium.org> wrote:
>
> In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
> one register region required.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index b72871ac90cb2..da4edb146a983 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,7 +25,7 @@ Required properties:
>
>  - reg: Base address and length of the register in the following order:
>         - Host controller register map (required)
> -       - SD Core register map (required)
> +       - SD Core register map (required for msm-v4 and below)
>  - interrupts: Should contain an interrupt-specifiers for the interrupts:
>         - Host controller interrupt (required)
>  - pinctrl-names: Should contain only one value - "default".
> --
> 2.18.1
>
