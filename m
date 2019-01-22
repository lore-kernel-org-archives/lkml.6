Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B347C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A3B2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yq5cItPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfAVJ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:27:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33135 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfAVJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:27:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so26506621wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 01:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cCrh+YVCx19BBdNeVg2dvCiCwiOMhaRj8KLLP1LDVlo=;
        b=yq5cItPKxIiEzJNtwONqID9UHnBdJme1bbcLuLE+Kp9q8t7aU7LgALgLHG0TlCZIvV
         QUzw9U/Afu1EAxgoMpfVAXlrMbNbSzA4V8YsMl2Jygxkhh1NTdc5mqFVdgHi1NDi8Ap/
         BRYaCO2+PtN+gUNk4lauEucshHw5YkxKeUgpnVbnvoHrltGT8O960GhIv455Dxkr/Wpq
         8zqLkgbH4cGToDug7zbDIhEhRT4OohO+uuNM0UryAs4qq/c6eiQDM+hIDZc10v/jApdp
         Jugjh0/TvrSHnTXzetMz+sYFIdes+UrNM+Nv/noB3HTcs9Dt7Hj+lFv0fc7ZN0zgdfZT
         B4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cCrh+YVCx19BBdNeVg2dvCiCwiOMhaRj8KLLP1LDVlo=;
        b=Uo3hlYgxGMo+AlffuiNbv+W+WsuoCsttDS7CJFc8p9NVCdD/2deiDLO4sgYA4OSmld
         9WQpq9PHuOXmH7jxlCmiHlUGgJ5lXJxF6dMJk6lLuVhqekwVVGm9gtxmsYRygiYQvJoZ
         Lr2kJEfc1af7isBjBsbMbi0Q1m0uinmWxoLAU/mJKSOGERO6LX2eC9flVl5ezlF9DPDt
         yItYCDdREFXLnityL2oQXt6fgTxPH4BjdXUb5Ky7T+eGEp1eDu+47D204Qmv1rI2WgJ4
         LsUUsjgQuGHGvqZ7ufGsLaR1wN13s65veiR+JnM3RqiL7PbxUQ0MMEeTONeqELaqUeS7
         hUrg==
X-Gm-Message-State: AJcUuke1L2AjsPTI2NJC4X+4USukXkejXT5ex8zSVKslyJl4GGeX6tAg
        A6BPAJkbSWeXNwjCarnyW/zqkw==
X-Google-Smtp-Source: ALg8bN5ccmnAT9QO4I7OWHxkPXb9UZomGvZL3zjWSy9IO9sP7kQtrzYCuOl96VyhyTq78SSVSc/blA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr31474975wru.222.1548149241112;
        Tue, 22 Jan 2019 01:27:21 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id y145sm38786336wmd.30.2019.01.22.01.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:27:20 -0800 (PST)
Message-ID: <8d9b2f76823396c9caad15943d564e147c06193d.camel@baylibre.com>
Subject: Re: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock
 controller
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Jan 2019 10:27:17 +0100
In-Reply-To: <1546955444-7549-4-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
         <1546955444-7549-4-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 21:50 +0800, Jianxin Pan wrote:
> From: Yixun Lan <yixun.lan@amlogic.com>
> 
> Document the MMC sub clock controller driver, the potential consumer
> of this driver is MMC or NAND. Also add four clock bindings IDs which
> provided by this driver.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../devicetree/bindings/clock/amlogic,mmc-clkc.txt | 39
> ++++++++++++++++++++++
>  include/dt-bindings/clock/amlogic,mmc-clkc.h       | 17 ++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-
> clkc.txt
>  create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> new file mode 100644
> index 0000000..0f518e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> @@ -0,0 +1,39 @@
> +* Amlogic MMC Sub Clock Controller Driver
> +
> +The Amlogic MMC clock controller generates and supplies clock to support
> +MMC and NAND controller
> +
> +Required Properties:
> +
> +- compatible: should be:
> +		"amlogic,gx-mmc-clkc"
> +		"amlogic,axg-mmc-clkc"

nitpick, missing is something to tell that only one is required, not both
for example `should be one of the following`

> +
> +- #clock-cells: should be 1.
> +- clocks: phandles to clocks corresponding to the clock-names property
> +- clock-names: list of parent clock names
> +	- "clkin0", "clkin1"
> +
> +- reg: address of emmc sub clock register
> +
> +Example: Clock controller node:
> +
> +sd_mmc_c_clkc: clock-controller@7000 {
> +	compatible = "amlogic,axg-mmc-clkc", "syscon";
> +	reg = <0x0 0x7000 0x0 0x4>;
> +	#clock-cells = <1>;
> +
> +	clock-names = "clkin0", "clkin1";
> +	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
> +		 <&clkc CLKID_FCLK_DIV2>;
> +};
> +
> +sd_emmc_b_clkc: clock-controller@5000 {
> +	compatible = "amlogic,axg-mmc-clkc", "syscon";
> +	reg = <0x0 0x5000 0x0 0x4>;
> +
> +	#clock-cells = <1>;
> +	clock-names = "clkin0", "clkin1";
> +	clocks = <&clkc CLKID_SD_EMMC_B_CLK0>,
> +		 <&clkc CLKID_FCLK_DIV2>;
> +};
> diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-
> bindings/clock/amlogic,mmc-clkc.h
> new file mode 100644
> index 0000000..34a3c56
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Meson MMC sub clock tree IDs
> + *
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#ifndef __MMC_CLKC_H
> +#define __MMC_CLKC_H
> +
> +#define CLKID_MMC_DIV		0
> +#define CLKID_MMC_PHASE_CORE	1
> +#define CLKID_MMC_PHASE_TX	2
> +#define CLKID_MMC_PHASE_RX	3
> +
> +#endif


