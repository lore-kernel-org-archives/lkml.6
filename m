Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D704C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258620880
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0258620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeH2GKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:10:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42518 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2GKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:10:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id l5so130494edw.9;
        Tue, 28 Aug 2018 19:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+eNmlgQ6zlSrxuSDoeEpqOfQ5xTcWvv1X3ErE7gLJA=;
        b=U1bPIrpRENYqxUH04/DL8Bb5dFZBdeqemPIwMoVNh2X2lrxp4pitLFByyXmK9XZvDo
         LL2tDP71B2Ep35TLqWiyn0Ajh3xbNNTxemsuleBrfq2B+rDNV7tNU21Rvj2WtLtGXB1t
         TWyYgdV2wj5Ai7to11jqtwAD5I6A0ruyndT3rHj6vtvXSxetqw2PEGcMtiIXOH79+09R
         uskS1fLC6Jh8ld0XnIG/TONNwgdjkvy+ES0Pqppb0lf/cNmae+9bOmnHyqRHrPMPAAuo
         azE8WA3Lg/ie5bIt4UbjYL7+jvJysQEtqKwzJihgsVWRJNUSEu5Qc8mmRXWYYphP5xYt
         Qt4g==
X-Gm-Message-State: APzg51BBZehpjxQgUv3nuz8csG5JbEMxWoyTmKT+lvIVhU+dubBgj1oK
        pPQva6dOP1e9SyHLqRVh9QGhvwGd
X-Google-Smtp-Source: ANB0VdZogKrQ33etv5SZddU4CbBIxhDNKom5thpuS30VFKSVpEpSXqrVXwZUdMZzGgbwC7UoMtICYA==
X-Received: by 2002:aa7:c60d:: with SMTP id h13-v6mr5391233edq.9.1535508938810;
        Tue, 28 Aug 2018 19:15:38 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id j23-v6sm1221874edh.29.2018.08.28.19.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 19:15:36 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id f21-v6so3670303wmc.5;
        Tue, 28 Aug 2018 19:15:36 -0700 (PDT)
X-Received: by 2002:a1c:5f85:: with SMTP id t127-v6mr2803750wmb.16.1535508935980;
 Tue, 28 Aug 2018 19:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-40-robh@kernel.org>
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 29 Aug 2018 10:15:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Hy-RQiXBhYrcy7FtNnqRUOhwGNZc8jko=FVrDDUH_hQ@mail.gmail.com>
Message-ID: <CAGb2v64Hy-RQiXBhYrcy7FtNnqRUOhwGNZc8jko=FVrDDUH_hQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, aisheng.dong@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, stefan@agner.ch,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>, gregory.clement@bootlin.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        alexandre.belloni@bootlin.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-gpio@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:OMAP2+ SUPPORT" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 9:55 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pinctrl/berlin/berlin.c               |  6 ++--
>  drivers/pinctrl/freescale/pinctrl-imx.c       |  7 ++--
>  drivers/pinctrl/freescale/pinctrl-imx1-core.c | 12 +++----
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  4 +--
>  drivers/pinctrl/meson/pinctrl-meson.c         |  2 +-
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c         |  4 +--
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c     |  6 ++--
>  drivers/pinctrl/pinctrl-at91.c                |  8 ++---
>  drivers/pinctrl/pinctrl-lantiq.c              |  8 ++---
>  drivers/pinctrl/pinctrl-rockchip.c            |  8 ++---
>  drivers/pinctrl/pinctrl-rza1.c                |  8 ++---
>  drivers/pinctrl/pinctrl-single.c              | 32 +++++++++----------
>  drivers/pinctrl/pinctrl-st.c                  |  6 ++--
>  drivers/pinctrl/sirf/pinctrl-atlas7.c         |  4 +--
>  drivers/pinctrl/stm32/pinctrl-stm32.c         |  4 +--
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c         |  8 ++---

For sunxi:

Acked-by: Chen-Yu Tsai <wens@csie.org>
