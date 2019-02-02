Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96A2C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC3520856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qlip9jCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfBBRFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:05:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35561 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:05:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so9320523wmt.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=1IqL4YH7JRK6UqQ4jzCJZZjsOuQR5UOkILRC9TNDD6Y=;
        b=Qlip9jCJpYOSk7slxaN+KL7agD3/IAQCgTOU3KDGTIaNhXxqprd57EP8sNvYuwxZc2
         ryXq86fq2GlgbG+GXqNws1nRcTA3rOc8XZGgHJ4n5PYjlOlzFXQltcxJzyKSMxVk/KbV
         fLnLvIAJlazNR3H8httcGVrqhISbj7teZnCU5uRf9L6dG2pzlf+zI9lN3xW/wlyl/9Hw
         t/63wMT5Qg+es4EgNRL6ed+pQ9hIuATOGY0IIZLJ1hP1a0XvHKC3nshYMiHcwLgSasqN
         ViSLqsm2Xvgn2IGrUCKD24GZHbyhvogf6hFsrGOljZG+AYKNBBzjYD5Sgpq1/yuFlZWV
         o3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=1IqL4YH7JRK6UqQ4jzCJZZjsOuQR5UOkILRC9TNDD6Y=;
        b=jttgacgkhaECRjPezOSeeGOQzhVvi+RBGr8clu2FzUZgCzW+CWLDW1aMUSw8W1xX//
         Y8Hdmef6JmOFubTM+s5Q3+TbwLPtPXgEsVLtcn7cgCaT15YhAZiD8SXMVgIwyUfVI6RB
         /XSAnaR81rXH0XKcE1UfCMEHmglcH2riWXI3cQQ57fN9aOXoKqwcdX4wjKgYfSHsvJhB
         IasiMZ1Nja/Wzwvz6mnNXErUc7PSSF7d9riVmFWd3EOsDkQYd2Zo/b6mOLAKhRa6O6Uj
         ICcZbHp3v8sqWjIGdSgHQFJ2gpKsiHuntRYPZheOc1nllGgL0QA78LxO114bFXcMV/Gw
         Rb/A==
X-Gm-Message-State: AHQUAuZbbGMZoNiBilAETjRH5WM2VSmy7ZAJd50V9JnSxzxep8oeE1pU
        1cz4WEO1cKZ3GyR/PW59IrysV1dCzLgJ6g==
X-Google-Smtp-Source: AHgI3Ia9CCQAbf5xrzvNuyXB59dZY/GA1c2gME42bNFXpfH6sUICZwxdrKURnR7zeQlDbPslonrANw==
X-Received: by 2002:a1c:8054:: with SMTP id b81mr6645486wmd.65.1549127122309;
        Sat, 02 Feb 2019 09:05:22 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([151.216.141.110])
        by smtp.gmail.com with ESMTPSA id t18sm3645527wmt.35.2019.02.02.09.05.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 09:05:20 -0800 (PST)
Message-ID: <5C55CDCE.9030502@baylibre.com>
Date:   Sat, 02 Feb 2019 18:05:18 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v6 0/4] clk: meson-g12a: Add EE clock controller driver
References: <20190201145345.6795-1-jbrunet@baylibre.com>
In-Reply-To: <20190201145345.6795-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 01/02/2019 15:53, Jerome Brunet a écrit :
> This purpose of this patchset is to the main clock controller of the
> g12a SoC family
> 
> This patchset depends on the recent rework the meson clock directory [7].
> 
> Changes since v5 [6]:
>  * use clock input driver until something better comes along in CCF
>  * fix pll fractional param size
>  * fix broken gp0 and hifi pll param (<55)
>  * add hdmi pll
>  * fix fdiv2p5
>  * add mpll_50m
>  * fix mpll clock tree (missing fix 2 divider)
>  * add missing sdio clocks
>  * add vpu clocks
>  * add some RO clock gates
>  * rabase on clk-meson tree
> 
> Changes since v4 [5]:
>  * add bypass clock "g12a_ee_core" from DT
>  * fix Kconfig description
>  * change g12a_mpll0_div/g12a_mpll1_div/g12a_mpll2_div/g12a_mpll3_div
>    clock's parent name as fixed_pll_dco
>  * drop CLK_SET_RATE_PARENT flag for pll clock
>  * drop CLK_GET_RATE_NOCACHE flag for pll_dco clock
>  * delete usless note
>  * enable G12A clock driver
> 
> Changes since v3 [4]:
>  * add fixed clocks clk_regmap definition
> 
> Changes since v2 [2]:
>  * fix fixed clock descriptions
>  * fix alignment
>  * add enable bit for plls base on [3] patches
>  * add fixed clock gate bit
> 
> Changes since v1 [1]:
>  * fix typo of 'Everything'.
>  * change the word 'AmLogic' to 'Amlogic'
>  * squash patch 1 and 2.
>  * delete usless message of "Trying obsolete regs".
>  * delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
>  * rebase on top of the "next/drivers" branch, and add g12a clock patch.
>  * add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
>    g12a_sd_emmc_c_clk0_sel.
> 
> [1]: https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu@amlogic.com
> [2]: https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu@amlogic.com
> [3]: https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
> [4]: https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu@amlogic.com
> [5]: https://lkml.kernel.org/r/1541511349-121152-1-git-send-email-jian.hu@amlogic.com
> [6]: https://lkml.kernel.org/r/1543498917-98605-1-git-send-email-jian.hu@amlogic.com
> [7]: https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
> 
> Jerome Brunet (2):
>   clk: meson: pll: update driver for the g12a
>   clk: meson: factorise meson64 peripheral clock controller drivers
> 
> Jian Hu (2):
>   dt-bindings: clk: meson: add g12a periph clock controller bindings
>   clk: meson: g12a: add peripheral clock controller
> 
>  .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
>  drivers/clk/meson/Kconfig                     |   21 +-
>  drivers/clk/meson/Makefile                    |    2 +
>  drivers/clk/meson/axg.c                       |   59 +-
>  drivers/clk/meson/clk-pll.c                   |  203 +-
>  drivers/clk/meson/clk-pll.h                   |   10 +-
>  drivers/clk/meson/clk-regmap.h                |    9 +-
>  drivers/clk/meson/g12a.c                      | 2359 +++++++++++++++++
>  drivers/clk/meson/g12a.h                      |  175 ++
>  drivers/clk/meson/gxbb.c                      |  272 +-
>  drivers/clk/meson/meson-eeclk.c               |   63 +
>  drivers/clk/meson/meson-eeclk.h               |   25 +
>  include/dt-bindings/clock/g12a-clkc.h         |  135 +
>  13 files changed, 3147 insertions(+), 187 deletions(-)
>  create mode 100644 drivers/clk/meson/g12a.c
>  create mode 100644 drivers/clk/meson/g12a.h
>  create mode 100644 drivers/clk/meson/meson-eeclk.c
>  create mode 100644 drivers/clk/meson/meson-eeclk.h
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

I'm applying these to next/drivers for Linux 5.1-rc1, is it necessary to
have a tag for the headers ?

Neil
