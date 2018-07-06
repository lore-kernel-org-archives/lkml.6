Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8882248B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8882248B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933767AbeGFRTX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:19:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41316 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932834AbeGFRTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:19:22 -0400
Received: from p5b127bca.dip0.t-ipconnect.de ([91.18.123.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fbUO0-0001q1-PO; Fri, 06 Jul 2018 19:19:12 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 3/4] clk: rockchip: add support for half divider
Date:   Fri, 06 Jul 2018 19:19:11 +0200
Message-ID: <5208192.saTfdjLqfi@phil>
In-Reply-To: <153089585197.143105.10633953093490493144@swboyd.mtv.corp.google.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com> <1529029011-15021-4-git-send-email-zhangqing@rock-chips.com> <153089585197.143105.10633953093490493144@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Juli 2018, 18:50:51 CEST schrieb Stephen Boyd:
> Quoting Elaine Zhang (2018-06-14 19:16:50)
> > 
> > diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
> > new file mode 100644
> > index 000000000000..fb7a6501e0c1
> > --- /dev/null
> > +++ b/drivers/clk/rockchip/clk-half-divider.c
> > @@ -0,0 +1,230 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
> > + */
> > +
> > +#include <linux/slab.h>
> > +#include <linux/bitops.h>
> > +#include <linux/regmap.h>
> > +#include <linux/clk.h>
> 
> Is this include used?

nope, and so are bitops and regmap as well.
I've amended the commit patch accordingly.


Heiko


