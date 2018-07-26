Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE33C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AE620846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AE620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeGZC3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:29:05 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52534 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeGZC3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:29:04 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0D83F9F929;
        Thu, 26 Jul 2018 01:14:40 +0000 (UTC)
Message-ID: <8520892860b672631ffc99f6318c2aeba251dc2e.camel@aosc.io>
Subject: Re: [PATCH v2 1/3] dt-binding: mmc: sunxi: add H6 compatible (with
 A64 fallback)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 26 Jul 2018 09:14:26 +0800
In-Reply-To: <20180719042810.6546-2-icenowy@aosc.io>
References: <20180719042810.6546-1-icenowy@aosc.io>
         <20180719042810.6546-2-icenowy@aosc.io>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-07-19四的 12:28 +0800，Icenowy Zheng写道：
> The MMC controllers on H6 is similar to the ones on A64, but with
> some
> new features.
> 
> Add compatible strings for them (with the A64 compatible strings as
> fallback, in order to make them to work with A64 drivers).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Add A64 fallback.
> 
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> index 132e0007d7d6..e9cb3ec5e502 100644
> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -16,6 +16,8 @@ Required properties:
>     * "allwinner,sun9i-a80-mmc"
>     * "allwinner,sun50i-a64-emmc"
>     * "allwinner,sun50i-a64-mmc"
> +   * "allwinner,sun50i-h6-emmc", "allwinner.sun50i-a64-emmc"
> +   * "allwinner,sun50i-h6-mmc", "allwinner.sun50i-a64-mmc"

BTW it seems that the driver performs quite bad on H6 when dealing it
as an A64.

I get 1.5MB/s on a card, although the card can reach 20MB/s read speed
(testing on BSP).

>   - reg : mmc controller base registers
>   - clocks : a list with 4 phandle + clock specifier pairs
>   - clock-names : must contain "ahb", "mmc", "output" and "sample"

