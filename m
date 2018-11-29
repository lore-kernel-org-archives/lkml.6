Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A621C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D491820863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="htVvF+WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D491820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeK2Lur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:50:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeK2Lur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:50:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C07732081C;
        Thu, 29 Nov 2018 00:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543452436;
        bh=3bmjfX+IssBus0ETq95xNW2VUL6kwvDTe0Zd4cVleF4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=htVvF+WT/LuQ9d5V2GsQnAsEzdsFfduyWKL8UQqwX5cu0cO4+TorRa01/a1eflnj5
         qoFHhFcaSDwOuAxsO0NtFtn9AyNQMcycEItI3yBdb6xUo+sQtnEIxMS5ApWO2QoUJZ
         ND+KGyWkBcUngtarLVHcv0j0cQMjIQgwsBvOBXKw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mesih Kilinc <mesihkilinc@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
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
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
Message-ID: <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Date:   Wed, 28 Nov 2018 16:47:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mesih Kilinc (2018-11-28 14:33:23)
> diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi=
-ng/ccu-suniv-f1c100s.c
> new file mode 100644
> index 0000000..d4bc1b8
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> @@ -0,0 +1,541 @@
> +/*
> + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: GPL-2.0

Please fix this location.

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

Ditto.

> + */
> +
