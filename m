Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0309FC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A1F218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLRNvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:51:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41285 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRNvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:51:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so16286771qtf.8;
        Tue, 18 Dec 2018 05:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAmHWC5m3+BzfvmFaoVDZqSBTTFMzpVyTUIeG9Pxoic=;
        b=KHgNIo3A4F6fppV/PNb61fWojhzGRae4PLpv0uGO6a+kSsQbkDQ+Oz3S1vB/1Tacyb
         9s82VCwGnN+QdetaCCNyPNqCjrgCviVTd9bllmprfmwew6TwZQrey3PfFBhA05pBBJVo
         4WfbBFtAhkQS+/pY0yuAoApfwhc0qzoPbWk8oZx32KGm8zdeVxVRCwuzGU+kYPzoYVPn
         73TH/8YR7qAMqU6Y/j0vB4HJ4FM5lgjfk7ypljGPH9UBhFkhK5YbnFycqpfQmu/76dot
         0GbV1HBb211MpY8q67NgL3G0vWE18YYKRbyra+BqlRDBvH+3+mrTatlHkGCDGaBcdfWf
         rrUA==
X-Gm-Message-State: AA+aEWboJqK+bNa1bE/9NdhCE9uc1DKBOKOXeBrDHuxPOfHBQlzMFDKe
        o3kU54XLC8zUnB9CbxDhQnJAwsyUdFQaf9bmreg=
X-Google-Smtp-Source: AFSGD/XTQcPAIaUGAF/nZ6n7tGNcZaDFf9X/Q/LIIFoOeXyKkIjelnOp+NUCP9WsZURPwXegKJNLGoi/eizllmInz6A=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr16731590qvm.149.1545141108624;
 Tue, 18 Dec 2018 05:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org> <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 14:51:32 +0100
Message-ID: <CAK8P3a3h8upNttd15EfBTAAP_EQEbQ0fsqtjjzYy9QZdzj=jmQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] ARM: Prepare RDA8810PL SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-unisoc@lists.infradead.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, zhao_steven@263.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 4:42 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> --- /dev/null
> +++ b/arch/arm/mach-rda/Kconfig
> @@ -0,0 +1,9 @@
> +menuconfig ARCH_RDA
> +       bool "RDA Micro SoCs"
> +       depends on ARCH_MULTI_V7
> +       select COMMON_CLK
> +       select GENERIC_IRQ_CHIP
> +       select RDA_INTC
> +       select RDA_TIMER
> +       help
> +         This enables support for the RDA Micro 8810PL SoC family.

I would drop the 'COMMON_CLK' and 'GENERIC_IRQ_CHIP' selects here,
as they are implied by ARCH_MULTI_V7.

      Arnd
