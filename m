Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195B9C4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12E2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QrMmENJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBBQsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:48:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36025 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:48:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so9215658wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=/E5cseiCf2VM6go13DtJ3Cj3nH7FX5EvWBwvS1pknUI=;
        b=QrMmENJRGEIBYdxjRsjbis576AVFShyezLUjyCSc53smhH/C0DAqCHF7siuJmpY8+7
         mqrSE3WDbyiZx6DSI3N9KccNY5woGuibjrsIWv8c3FdDD5iY1xTrfv4Ls4+yDyc05OjV
         1ruETTQnChwgPZF9AOEqi9KDNdG7YRnKnKrr7RHWCnGxysXn/gnIMgetNzEbFu/YaUnp
         Qjb9Gh2GQ+CEOpDjXe/2ff4DHY3shXDyE5xKXH/rdVrcUq/VRNIJu0zQzCRlluBPEwuP
         RX8QlQfhKGnUEpdJ0i+uSrGfCcQdMnGz6Rsxjkf0QNLBy32eLjHmgsLkG+8t13vxEiaV
         iVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=/E5cseiCf2VM6go13DtJ3Cj3nH7FX5EvWBwvS1pknUI=;
        b=HDY3d6Dflb/zVwDMFxFZofO4HyTbItNdOAs6bQIcM/edkAx6/5ZMmLkJ1EHbJd1kCp
         U731LplOUvcDN8XPu4tO2eLsxfI4orVnRf0gqXgBEJV2vZilaIm1yutWRbm2Wyes5bho
         Rg0VnQTeDTIyTTawG1HUxKRtAa0kCeTd1XAg4vRkjwl+RXaJ5IYcqvMjDDRsnD39XKII
         K/sC3izDDWNpb1/st+E6U9vfgxf2rMmGe0fOhU/6z65p+LrHHwyFgBLuEHz1QfrELCjs
         eB6KkSM4N8L6n2b9QL3nqUXsgPnBWYaOZwLW1g+Ozhc8FFPvNY/d6L4evl7/Zol3DcOE
         g9lQ==
X-Gm-Message-State: AHQUAuZeyj0u7Rqe0REYQfifW6QvzXMDbyoX+AJS1ddf01E6pGwg0YkY
        qDmoub0iGLT8PJ2g5lQwbc8HdQ==
X-Google-Smtp-Source: AHgI3Ib3J5KjmLUBVR6Z/IE1P7jTdJKc1XMJyuL8ut3ezKO14F7qT7W9I/gad4AzcctVmoKIhPRKOA==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr6529365wmi.57.1549126081536;
        Sat, 02 Feb 2019 08:48:01 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([151.216.141.110])
        by smtp.gmail.com with ESMTPSA id 202sm9071110wmt.8.2019.02.02.08.48.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 08:48:00 -0800 (PST)
Message-ID: <5C55C9BE.9080404@baylibre.com>
Date:   Sat, 02 Feb 2019 17:47:58 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] clk: meson: rework drivers dependencies
References: <20190201125841.26785-1-jbrunet@baylibre.com>
In-Reply-To: <20190201125841.26785-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 01/02/2019 13:58, Jerome Brunet a écrit :
> The goal of this patchset to clean-up the dependencies between
> the controllers and the different clock drivers provided in the meson
> directory. The expected result is that each controllers can pick the
> the clock drivers they need, without necessarily pulling everything.
> 
> This is becoming important as we are adding more and more controllers
> to support new amlogic SoC.
> 
> Patch 1 and 2 are out of the meson directory but have been acked by
> Stephen.
> 
> Changes since v1 [0]:
>  * Squashed patch 4 to 14
>  * Sort Makefile alphanumerically
> 
> [0]: https://lkml.kernel.org/r/20190128180430.28689-1-jbrunet@baylibre.com
> 
> Jerome Brunet (4):
>   clk: export some clk_hw function symbols for module drivers
>   clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
>   clk: meson: axg-audio does not require syscon
>   clk: meson: rework and clean drivers dependencies
> 
>  drivers/clk/Makefile                          |   2 +-
>  drivers/clk/clk.c                             |   3 +
>  drivers/clk/meson/Kconfig                     |  84 +++++++---
>  drivers/clk/meson/Makefile                    |  27 ++--
>  drivers/clk/meson/axg-aoclk.c                 |   4 +-
>  drivers/clk/meson/axg-audio.c                 |   5 +-
>  drivers/clk/meson/axg.c                       |   5 +-
>  drivers/clk/meson/clk-dualdiv.c               |  10 +-
>  drivers/clk/meson/clk-dualdiv.h               |  33 ++++
>  drivers/clk/meson/clk-input.c                 |   7 +-
>  drivers/clk/meson/clk-input.h                 |  19 +++
>  drivers/clk/meson/clk-mpll.c                  |  12 +-
>  drivers/clk/meson/clk-mpll.h                  |  30 ++++
>  drivers/clk/meson/clk-phase.c                 |  75 ++++++++-
>  drivers/clk/meson/clk-phase.h                 |  26 ++++
>  drivers/clk/meson/clk-pll.c                   |  13 +-
>  drivers/clk/meson/clk-pll.h                   |  43 ++++++
>  drivers/clk/meson/clk-regmap.c                |   5 +
>  drivers/clk/meson/clk-regmap.h                |  15 ++
>  drivers/clk/meson/clk-triphase.c              |  68 --------
>  drivers/clk/meson/clkc.h                      | 146 ------------------
>  drivers/clk/meson/gxbb-aoclk.c                |   4 +-
>  drivers/clk/meson/gxbb.c                      |   5 +-
>  drivers/clk/meson/meson-aoclk.c               |   2 +
>  drivers/clk/meson/meson-aoclk.h               |   5 +-
>  drivers/clk/meson/meson8b.c                   |   3 +-
>  drivers/clk/meson/parm.h                      |  46 ++++++
>  drivers/clk/meson/sclk-div.c                  |  10 +-
>  .../clk/meson/{clkc-audio.h => sclk-div.h}    |  16 +-
>  drivers/clk/meson/vid-pll-div.c               |  10 +-
>  drivers/clk/meson/vid-pll-div.h               |  20 +++
>  31 files changed, 470 insertions(+), 283 deletions(-)
>  create mode 100644 drivers/clk/meson/clk-dualdiv.h
>  create mode 100644 drivers/clk/meson/clk-input.h
>  create mode 100644 drivers/clk/meson/clk-mpll.h
>  create mode 100644 drivers/clk/meson/clk-phase.h
>  create mode 100644 drivers/clk/meson/clk-pll.h
>  delete mode 100644 drivers/clk/meson/clk-triphase.c
>  delete mode 100644 drivers/clk/meson/clkc.h
>  create mode 100644 drivers/clk/meson/parm.h
>  rename drivers/clk/meson/{clkc-audio.h => sclk-div.h} (54%)
>  create mode 100644 drivers/clk/meson/vid-pll-div.h
> 

Applied to next/drivers for Linux 5.1-rc1

Neil
