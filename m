Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD85C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F9C20863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="em/Dl6hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F9C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeK2I4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbeK2I4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:56:09 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90AE120832;
        Wed, 28 Nov 2018 21:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543441985;
        bh=SyMfEb5GF7TrDfz3nZ2cU8PjdmgxB3r0lmBlclsLdes=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=em/Dl6hrPyBVCi0seg1GERvE5p/HJqZxIxBX00LqcmetKw4IfAvbYzekL4h3G7q6w
         uuPcB5Yb+mm3ne9SmZ6XcfZqwGgvej1kj1W25cHViRoAqylhuSvlZwBmGVAmfx1fe9
         WexMhJ+n57MhPpoTbtiSO9yNmMff+6UWGg/AxNgM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mesih Kilinc <mesihkilinc@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <6fa817af55c7a54cb6ce91710378aafe1369c744.1543131714.git.mesihkilinc@gmail.com>
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <6fa817af55c7a54cb6ce91710378aafe1369c744.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <154344198484.88331.1207175109618819774@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH v4 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Date:   Wed, 28 Nov 2018 13:53:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mesih Kilinc (2018-11-24 23:43:16)
> diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi=
-ng/ccu-suniv-f1c100s.c
> new file mode 100644
> index 0000000..d933dba
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> @@ -0,0 +1,536 @@
> +/*
> + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: GPL-2.0

Echoing Rob. Goes on first line.

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h b/drivers/clk/sunxi=
-ng/ccu-suniv-f1c100s.h
> new file mode 100644
> index 0000000..1da687a
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: GPL-2.0+

ditto.
