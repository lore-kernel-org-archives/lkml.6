Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF18DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857442506C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857442506C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeGBLQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:16:13 -0400
Received: from muru.com ([72.249.23.125]:49520 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753155AbeGBLQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:16:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 92F408047;
        Mon,  2 Jul 2018 11:19:03 +0000 (UTC)
Date:   Mon, 2 Jul 2018 04:16:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc:     nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk,
        kaloz@openwrt.org, khalasa@piap.pl, aaro.koskinen@iki.fi,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com,
        gregory.clement@free-electrons.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, marek.vasut@gmail.com,
        slapin@ossfans.org, jic23@cam.ac.uk, kgene@kernel.org,
        krzk@kernel.org, ralf@linux-mips.org, ysato@users.sourceforge.jp,
        dalias@libc.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/11 v2] ARM: OMAP1: constify gpio_led
Message-ID: <20180702111605.GS112168@atomide.com>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
 <c00efa8371f63d6b888590ea66767c832088cd1a.1514267721.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c00efa8371f63d6b888590ea66767c832088cd1a.1514267721.git.arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arvind Yadav <arvind.yadav.cs@gmail.com> [171225 22:40]:
> gpio_led are not supposed to change at runtime.
> struct gpio_led_platform_data working with const gpio_led
> provided by <linux/leds.h>. So mark the non-const structs
> as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>               The GPIO LED driver can be built as a module, it can
>               be loaded after the init sections have gone away.
>               So removed '__initconst'.

Sorry just noticed I still have this one tagged and it's still
pending.. Applying into omap-for-v4.19/omap1.

Regards,

Tony


>  arch/arm/mach-omap1/board-h2.c        | 2 +-
>  arch/arm/mach-omap1/board-h3.c        | 2 +-
>  arch/arm/mach-omap1/board-htcherald.c | 2 +-
>  arch/arm/mach-omap1/board-osk.c       | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
> index ab51f85..9aeb8ad 100644
> --- a/arch/arm/mach-omap1/board-h2.c
> +++ b/arch/arm/mach-omap1/board-h2.c
> @@ -274,7 +274,7 @@ static struct platform_device h2_kp_device = {
>  	.resource	= h2_kp_resources,
>  };
>  
> -static struct gpio_led h2_gpio_led_pins[] = {
> +static const struct gpio_led h2_gpio_led_pins[] = {
>  	{
>  		.name		= "h2:red",
>  		.default_trigger = "heartbeat",
> diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
> index ad339f5..2edcd63 100644
> --- a/arch/arm/mach-omap1/board-h3.c
> +++ b/arch/arm/mach-omap1/board-h3.c
> @@ -326,7 +326,7 @@ static struct spi_board_info h3_spi_board_info[] __initdata = {
>  	},
>  };
>  
> -static struct gpio_led h3_gpio_led_pins[] = {
> +static const struct gpio_led h3_gpio_led_pins[] = {
>  	{
>  		.name		= "h3:red",
>  		.default_trigger = "heartbeat",
> diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
> index 67d4669..e6a79fd 100644
> --- a/arch/arm/mach-omap1/board-htcherald.c
> +++ b/arch/arm/mach-omap1/board-htcherald.c
> @@ -292,7 +292,7 @@ static struct platform_device herald_gpiokeys_device = {
>  };
>  
>  /* LEDs for the Herald.  These connect to the HTCPLD GPIO device. */
> -static struct gpio_led gpio_leds[] = {
> +static const struct gpio_led gpio_leds[] = {
>  	{"dpad",        NULL, HTCPLD_GPIO_LED_DPAD,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
>  	{"kbd",         NULL, HTCPLD_GPIO_LED_KBD,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
>  	{"vibrate",     NULL, HTCPLD_GPIO_LED_VIBRATE,     0, 0, LEDS_GPIO_DEFSTATE_OFF},
> diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
> index c66372e..e2277b5 100644
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -167,7 +167,7 @@ static struct platform_device *osk5912_devices[] __initdata = {
>  	&osk5912_cf_device,
>  };
>  
> -static struct gpio_led tps_leds[] = {
> +static const struct gpio_led tps_leds[] = {
>  	/* NOTE:  D9 and D2 have hardware blink support.
>  	 * Also, D9 requires non-battery power.
>  	 */
> @@ -385,7 +385,7 @@ static struct platform_device osk5912_lcd_device = {
>  	.id		= -1,
>  };
>  
> -static struct gpio_led mistral_gpio_led_pins[] = {
> +static const struct gpio_led mistral_gpio_led_pins[] = {
>  	{
>  		.name		= "mistral:red",
>  		.default_trigger = "heartbeat",
> -- 
> 2.7.4
> 
