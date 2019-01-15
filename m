Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4CB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbfAOUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:11:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43401 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389692AbfAOUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:11:57 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjV3v-0005Fh-5N; Tue, 15 Jan 2019 21:11:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjV3t-0004Pm-R1; Tue, 15 Jan 2019 21:11:49 +0100
Date:   Tue, 15 Jan 2019 21:11:49 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20190115201149.ghddnf27s5kqephc@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547194964-16718-2-git-send-email-yash.shah@sifive.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is v3, right? It is helpful to point this out to ease reviewing.

On Fri, Jan 11, 2019 at 01:52:43PM +0530, Yash Shah wrote:
> DT documentation for PWM controller added with updated compatible
> string.

Not sure what was updated here. But assuming this is compared to v2 this
is not a helpful info in the commit log.

> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 0000000..e0fc22a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,37 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently only
> +supports one period for all channels in the PWM. This is set globally in DTS.
> +The period also has significant restrictions on the values it can achieve,
> +which the driver rounds to the nearest achievable frequency.
> +
> +Required properties:
> +- compatible: Please refer to sifive-blocks-ip-versioning.txt

While the description was too verbose in v2, this is too short. You
should at least mention something like "sifive,pwmX" and
"sifive,$cpuname-pwm" (or how ever that scheme works).

> +- reg: physical base address and length of the controller's registers
> +- clocks: Should contain a clock identifier for the PWM's parent clock.
> +- #pwm-cells: Should be 2.
> +  The first cell is the PWM channel number
> +  The second cell is the PWM polarity

I'd drop these two lines and refer to bindings/pwm/pwm.txt instead.

> +- sifive,approx-period-ns: the driver will get as close to this period as it can

As already said for v2: I'd drop "approx-". 

> +- interrupts: one interrupt per PWM channel
> +
> +PWM RTL that corresponds to the IP block version numbers can be found
> +here:
> +
> +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> +
> +Further information on the format of the IP
> +block-specific version numbers can be found in
> +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> +
> +Examples:
> +
> +pwm:  pwm@10020000 {
> +	compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
> +	reg = <0x0 0x10020000 0x0 0x1000>;
> +	clocks = <&tlclk>;
> +	interrupt-parent = <&plic>;
> +	interrupts = <42 43 44 45>;
> +	#pwm-cells = <2>;
> +	sifive,approx-period-ns = <1000000>;
> +};
> -- 
> 1.9.1
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
