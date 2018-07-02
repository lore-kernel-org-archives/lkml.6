Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C763AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061225CB2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfDS+7JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8061225CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965454AbeGBLFu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964823AbeGBLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:05:43 -0400
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com [209.85.128.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADC225CD7;
        Mon,  2 Jul 2018 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530529542;
        bh=ErKZImU6dbn/ks/kMkioE7OOTFttVv2roR2cPsb123A=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RfDS+7JCfMDm67xPMSZEu/7frbXvzEjzscv1vGqYmzkIuE4K3W4HqRZG7JUahlQPH
         XlXOQDdhCQWxUpCji537PtzeJ5rsw7X6uC+rCY57IqIRE0eCqZVGqF1dK6Eqf9g8c/
         uqEE4VuVClxCIwgfxV56LL2H+7wQHr8ZPeQnTQqs=
Received: by mail-wr0-f178.google.com with SMTP id p1-v6so15111772wrs.9;
        Mon, 02 Jul 2018 04:05:42 -0700 (PDT)
X-Gm-Message-State: APt69E0XBgrUbjOlhcrN/hsCWJO/bFbIer66v3j0TTy4nQbRp9YJWjJa
        U6TJflGvsFczQBrIXWwqATAwmZSvaQNVI1wYlrI=
X-Google-Smtp-Source: AAOMgpdjxdUnRdxcaRiODwvMOkceFyQGW5AJuM4Zd29cdSOfSyatXsabC8QhNNjP7XFdxZE02x5v7Cd0H9Urc37z99E=
X-Received: by 2002:adf:f3d2:: with SMTP id g18-v6mr18478907wrp.279.1530529540695;
 Mon, 02 Jul 2018 04:05:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 04:05:40 -0700 (PDT)
In-Reply-To: <20180702102201.13461-3-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com> <20180702102201.13461-3-enric.balletbo@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 2 Jul 2018 13:05:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd51yU8-zObXszc4zJpHsGtMNFTsbQsQdKBFg=k22xZLA@mail.gmail.com>
Message-ID: <CAJKOXPd51yU8-zObXszc4zJpHsGtMNFTsbQsQdKBFg=k22xZLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm/arm64: configs: Remove the MFD_ prefix for
 MFD_CROS_EC_I2C/SPI symbols.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, Guenter Roeck <groeck@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anand Moon <linux.amoon@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tony Lindgren <tony@atomide.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 July 2018 at 12:22, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> The cros-ec I2C and SPI transport drivers have been moved from MFD
> subsystem to platform/chrome, at the same time, the config symbol has
> been renamed and lost the MFD_ prefix, so update all configs to the new
> config symbol name.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  arch/arm/configs/exynos_defconfig   | 4 ++--
>  arch/arm/configs/multi_v7_defconfig | 4 ++--
>  arch/arm/configs/pxa_defconfig      | 4 ++--
>  arch/arm64/configs/defconfig        | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Since you put in one patch multiple defconfigs belonging to multiple
maintainers, I assume you are pushing this through arm-soc or Russell.
In such case, for Exynos boards:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
