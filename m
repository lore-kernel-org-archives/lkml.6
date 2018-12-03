Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CEDC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF34A214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5duhuq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34A214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeLCWpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbeLCWpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:45:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62BD820864;
        Mon,  3 Dec 2018 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543877134;
        bh=Tv5xntpOFZLjgLVDbFFAyXgVlC5/NfqIbqNPTujsV6s=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=N5duhuq8ug/rks25GN9PUAoJdOlqrnzTa+pX1SIe/aqRJS0NZTFEnc4EA7MHs8lph
         FrYw7DT3kBUrXltShu+tqZbY0NSRwu0Em5TGTFkzSVpkAdl94GMvciZLU13NuyHxp5
         GGPymSABAW/MEs37wqnu/pX9HIviK+vUgWinA9aQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542284312-55418-3-git-send-email-jianxin.pan@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
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
References: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
 <1542284312-55418-3-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <154387713374.88331.16436869339024592009@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/4] clk: meson: add DT documentation for emmc clock controller
Date:   Mon, 03 Dec 2018 14:45:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jianxin Pan (2018-11-15 04:18:30)
> diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bi=
ndings/clock/amlogic,mmc-clkc.h
> new file mode 100644
> index 0000000..162b949
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
> +#define CLKID_MMC_DIV                          1

Why does the define numbering start with 1 instead of 0?

> +#define CLKID_MMC_PHASE_CORE                   2
> +#define CLKID_MMC_PHASE_TX                     3
> +#define CLKID_MMC_PHASE_RX                     4
> +
