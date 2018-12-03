Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5BDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417FA20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea8Zh87J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417FA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeLCMUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:20:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35099 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLCMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:20:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so5442688wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 04:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OzA+3GaaikIL6wv3q3MdMGfegRkRGor8XZDTMohQWx4=;
        b=ea8Zh87Jym6k2fqcstUYxCuciNIPimhX8g4B0MElxgMAq3stT+z+LCki2UbBChwBRE
         jhbJU9TlZ24RkzlDgN/hMVGbXNrD1gPH/b4SEfG0u7m7j3saX+YsU6XsDp6059agy9fg
         l7s7eBx85YiNUHP2mOuJRkA1KwFAQ3A0eU928=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OzA+3GaaikIL6wv3q3MdMGfegRkRGor8XZDTMohQWx4=;
        b=PHdN4hZ0ethdt2nkCSfCvECWnlQRjOljhTh/GjcsGQeciaGz0HMCqYj3snvxCaqZ+8
         6ND/XgfUubCzEZ92qbjRpjVSThAQLvbxy8qTCV7wl926NOMhWb+pf8eBwc5rhIJosIac
         AQne0PLePGywyR5cYswqaC2B2GcpPiahCmq6t8YxHAwZ2MoA9666FPD/UBY1AAakDE/A
         tyWZchE01LLWDZbdmGJG4O4dLuguXK6i05TgY0x3cnuMdiYp527X3aZw99w40j6C8iGm
         +N+NXID9enIWeRFrjGPPZKyxKWWBqZO54SKgAnkBuJGtwRaozQuaLR9aSCaqZRQ1FtD3
         i5FQ==
X-Gm-Message-State: AA+aEWajdQ3yguHLPvFFKDeIBDD2u5QPISyVumo4vi9X1OH8pfn32k/u
        7nn9FE0XnzuJmgCgxCF013Ysgg==
X-Google-Smtp-Source: AFSGD/Ubj58mbWiG4F1lV87M8767muODU3LyeDsnIxQw+fiLFQL9Bm6raOAL8E1O+SGccTwNxz9Bug==
X-Received: by 2002:a1c:c7cd:: with SMTP id x196mr8015596wmf.12.1543839593878;
        Mon, 03 Dec 2018 04:19:53 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id 129sm6454794wmd.18.2018.12.03.04.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:19:53 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:19:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/9] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <20181203121951.GP26661@dell>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Series add bd71837/bd71837 PMIC clock support + managed interfaces

[...]

> Matti Vaittinen (9):
>   clkdev: add managed clkdev lookup registration
>   clk: of_clk - add managed provider registrations
>   clk: clk-max77686: Clean clkdev lookup leak and use devm
>   clk: clk-st: avoid clkdev lookup leak at remove
>   clk: clk-hi655x: Free of_provider at remove
>   clk: rk808: use managed version of of_provider registration
>   clk: clk-twl6040: Free of_provider at remove
>   clk: apcs-msm8916: simplify probe cleanup by using devm
>   clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock
> 
>  Documentation/driver-model/devres.txt |   2 +
>  drivers/clk/Kconfig                   |   7 ++
>  drivers/clk/Makefile                  |   1 +
>  drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
>  drivers/clk/clk-hi655x.c              |   4 +-
>  drivers/clk/clk-max77686.c            |  29 ++------
>  drivers/clk/clk-rk808.c               |  15 +---
>  drivers/clk/clk-twl6040.c             |   5 +-
>  drivers/clk/clk.c                     |  65 ++++++++++++++---
>  drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++-------
>  drivers/clk/qcom/apcs-msm8916.c       |   5 +-
>  drivers/clk/x86/clk-st.c              |   3 +-
>  include/linux/clk-provider.h          |  11 +++
>  include/linux/clkdev.h                |   4 ++
>  14 files changed, 325 insertions(+), 79 deletions(-)
>  create mode 100644 drivers/clk/clk-bd718x7.c

You've send me a cover letter and no patches.

I suggest that I should not be on the addressee list at all for this.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
