Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C036C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F216620647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F216620647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbeGZTRL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:17:11 -0400
Received: from mailoutvs8.siol.net ([185.57.226.199]:46184 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731262AbeGZTRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:17:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 258C6521804;
        Thu, 26 Jul 2018 19:59:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id d_ES4ujSnhWW; Thu, 26 Jul 2018 19:59:13 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 92A9552190D;
        Thu, 26 Jul 2018 19:59:13 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id E44B65217FE;
        Thu, 26 Jul 2018 19:59:12 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v3.1 06/10] dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO[0-1] macros
Date:   Thu, 26 Jul 2018 19:59:12 +0200
Message-ID: <4645023.F7YpVDaJQ2@jernej-laptop>
In-Reply-To: <20180726171257.6688-7-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io> <20180726171257.6688-7-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 26. julij 2018 ob 19:12:53 CEST je Icenowy Zheng napisal(a):
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Allwinner A64 has two clock parents PLL_VIDEO0 and PLL_VIDEO1.
> 
> Include these macros on dt-bindings so-that the same can be
> used while defining CCU clock phadles.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes for v3.1:
> - none
> Changes for v3:
> - collect Rob r-w-b tag
> Changes for v2:
> - new patch
> 
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h
> b/include/dt-bindings/clock/sun50i-a64-ccu.h index
> d66432c6e675..d1d7d5b7d06a 100644
> --- a/include/dt-bindings/clock/sun50i-a64-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
> @@ -43,7 +43,9 @@
>  #ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
>  #define _DT_BINDINGS_CLK_SUN50I_A64_H_
> 
> +#define CLK_PLL_VIDEO0		7
>  #define CLK_PLL_PERIPH0		11
> +#define CLK_PLL_VIDEO1		15
> 
>  #define CLK_BUS_MIPI_DSI	28
>  #define CLK_BUS_CE		29

You should remove above definitions from drivers/clk/sunxi-ng/ccu-sun50i-a64.h

Best regards,
Jernej



