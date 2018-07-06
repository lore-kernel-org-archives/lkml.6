Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE36C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ABC22BE8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfdTlZPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9ABC22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeGFQuz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933157AbeGFQux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:50:53 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA3222AAB;
        Fri,  6 Jul 2018 16:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530895852;
        bh=IeZ33JSBWKKVQj80YjiucbK7GE9Ii6kw88bghDexbZ0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jfdTlZPkANO0ZZmGHN2GiVtFCoZDdlAnhYCUQkBks/4cZpx9rVPnX5l6WjYK1B0n9
         sNDANRD9XfZlRRu6bxgSSrgOo6KgjfoKMyzsB2LR5OvJKuY1az9MctCPYu23L05QkL
         ANK4wQNM5iy3q6a3fACl5ZWOmRNJqvUtTBiNF3co=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1529029011-15021-4-git-send-email-zhangqing@rock-chips.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
 <1529029011-15021-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <153089585197.143105.10633953093490493144@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/4] clk: rockchip: add support for half divider
Date:   Fri, 06 Jul 2018 09:50:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2018-06-14 19:16:50)
> =

> diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockch=
ip/clk-half-divider.c
> new file mode 100644
> index 000000000000..fb7a6501e0c1
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-half-divider.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include "clk.h"
