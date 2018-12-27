Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8010CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C753218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9nG7PED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbeL0Jkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:40:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40733 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbeL0Jkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 04:40:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so15789487lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 01:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfoDasoKz+2oMgPjB2uHwd7CyoIoqHS4xZY1x0XkzK8=;
        b=D9nG7PEDex/PBjAvuHIRISwAT0MNoWe9bTtyQth0SfFeeO68nT6/0Yn0m3/FUlWM6f
         Z6MbtysyuK+E12VYyqz3woVXNb402A7ahist7XlvKpOmHPi0ccUuM+lHbMQ1Vuvm3RNX
         lWFtYcSrrOOMZZU41ns2SZk9LLnstLGy42DNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfoDasoKz+2oMgPjB2uHwd7CyoIoqHS4xZY1x0XkzK8=;
        b=WVttGlcIZ/9do+I/DM+82DHM0/SGsxOdxjECFll21g7Et7IH4IcwsuFjpqv0R5FZGP
         iVlGYxB060K088IO158rNeGTs5oG0oHZvGQMaoV1ikUtIoUkCii1etqlPWLSmlfSkRlR
         otisF4Fzt0g5zrh9oNIJlUBmYtsVXsIzaZJ9RPfsIUu5Dc+bY7bcMNIHdnlFd7UbfgWd
         ib8TZYaT3D4MmVPVKywKpsHbFfoHcxZJSxXkmxtSjET6Dz7V/r017xAYXobMZSj/+t8h
         vPTqb5XTlVBBozQ2NuC7HgnJpjs5UPhvaXldGoaJhG6BkWyy7+lvO75VhaS0aulYEOTM
         J6ZQ==
X-Gm-Message-State: AJcUukc5sXr/Gd4Iw4VWRI0URcWVAqTI672ZCDh7SyDTGsMlHCnfutSZ
        kxG5B4qwC5fiRoD3wsi7LrqAMSI9GPCH7HYuV/J24A==
X-Google-Smtp-Source: ALg8bN6jZpSVdUegCLMi0fZDYHt98Epf7JPdYxjpYpB4purrey5l+E+bKS8kJMW/WipEqkoxgC7tRncuZmlTaOgBW1E=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr13309263ljk.4.1545903631051;
 Thu, 27 Dec 2018 01:40:31 -0800 (PST)
MIME-Version: 1.0
References: <1545548891-24671-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1545548891-24671-1-git-send-email-abel.vesa@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Dec 2018 10:40:19 +0100
Message-ID: <CACRpkdb6zubc0w+scQ7uaC9WmPLM3Y4kR70Lwb09A2nJ6hj1Cw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: Break dependency on SOC_IMX8MQ for i.MX8MQ
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 8:08 AM Abel Vesa <abel.vesa@nxp.com> wrote:

> The CONFIG_SOC_IMX8MQ will go away, so the dependency can be based on
> ARCH_MXC && ARM64.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Patch applied with Dong's and Fabio's ACKs.

Yours,
Linus Walleij
