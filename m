Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E799CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C3C20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C3C20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKTAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:06:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38170 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeKTAGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:06:48 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gOjpP-0007lj-KQ; Mon, 19 Nov 2018 14:43:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: fix ID of 8ch clock of I2S1 for rk3328
Date:   Mon, 19 Nov 2018 14:43:03 +0100
Message-ID: <12656761.yaB328pSP6@phil>
In-Reply-To: <20181118041802.11660-1-katsuhiro@katsuster.net>
References: <20181118041802.11660-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 18. November 2018, 05:18:02 CET schrieb Katsuhiro Suzuki:
> This patch fixes mistakes in HCLK_I2S1_8CH for running I2S1
> successfully.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  include/dt-bindings/clock/rk3328-cru.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
> index a82a0109faff..bcaa4559ab1b 100644
> --- a/include/dt-bindings/clock/rk3328-cru.h
> +++ b/include/dt-bindings/clock/rk3328-cru.h
> @@ -172,13 +172,14 @@
>  #define PCLK_HDCP		232
>  #define PCLK_DCF		233
>  #define PCLK_SARADC		234
> +#define PCLK_ACODECPHY		235

I've dropped this unrelated change and applied the
real id fix from the rest of the patch for 4.21


Thanks
Heiko


