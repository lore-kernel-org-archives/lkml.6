Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D820873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3D820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeK0Stt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:49:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53502 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeK0Stt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:49:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BD8D620DC4; Tue, 27 Nov 2018 08:52:46 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7082320D2E;
        Tue, 27 Nov 2018 08:52:27 +0100 (CET)
Date:   Tue, 27 Nov 2018 08:52:26 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        thierry.reding@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
Message-ID: <20181127075226.qo3mv3o6etqdjaop@flea>
References: <20181125161859.GA5277@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181125161859.GA5277@arx-s1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> This patch adds Allwinner sun8i pwm binding document.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..7531d85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: Should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: Physical base address and length of the controller's registers
> +  - interrupts: Should contain interrupt.
> +  - clocks: From common clock binding, handle to the parent clock.
> +  - clock-names: Must contain the clock names described just above.

You didn't describe those names in that document.

You seem to have used mux-0 and mux-1 for the clock names. I guess we
don't have to use a name there, we can simply use the position to find
out (as long as it's documented in the binding)

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
