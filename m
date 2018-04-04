Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeDDMIb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:08:31 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54218 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeDDMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:08:30 -0400
Date: Wed, 04 Apr 2018 13:08:15 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180404114706.15856-1-brgl@bgdev.pl>
References: <20180404114706.15856-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RESEND PATCH] ARM: pxa: stargate2: use device properties for at24 eeprom
To: Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <7799C0F9-ABD5-40D5-83E2-AEC631CBBD1E@jic23.retrosnub.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 April 2018 12:47:06 BST, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>We want to work towards phasing out the at24_platform_data structure.
>There are few users and its contents can be represented using generic
>device properties. Using device properties only will allow us to
>significantly simplify the at24 configuration code.
>
>Remove the at24_platform_data structure and replace it with an array
>of property entries. Drop the byte_len/size property, as the model name
>already implies the EEPROM's size.
>
>Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Looks sensible to me.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Will be a while before I can test but this looks safe enough..
>---
>NOTE: resending with correct e-mail address for Jonathan Cameron.
>
> arch/arm/mach-pxa/stargate2.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/arch/arm/mach-pxa/stargate2.c
>b/arch/arm/mach-pxa/stargate2.c
>index df62bb23dbee..bbea5fa9a140 100644
>--- a/arch/arm/mach-pxa/stargate2.c
>+++ b/arch/arm/mach-pxa/stargate2.c
>@@ -27,11 +27,11 @@
> 
> #include <linux/platform_data/i2c-pxa.h>
> #include <linux/platform_data/pcf857x.h>
>-#include <linux/platform_data/at24.h>
> #include <linux/smc91x.h>
> #include <linux/gpio/machine.h>
> #include <linux/gpio.h>
> #include <linux/leds.h>
>+#include <linux/property.h>
> 
> #include <asm/types.h>
> #include <asm/setup.h>
>@@ -795,9 +795,9 @@ static struct pcf857x_platform_data
>platform_data_pcf857x = {
> 	.context = NULL,
> };
> 
>-static struct at24_platform_data pca9500_eeprom_pdata = {
>-	.byte_len = 256,
>-	.page_size = 4,
>+static const struct property_entry pca9500_eeprom_properties[] = {
>+	PROPERTY_ENTRY_U32("pagesize", 4),
>+	{ }
> };
> 
> /**
>@@ -935,7 +935,7 @@ static struct i2c_board_info __initdata
>stargate2_i2c_board_info[] = {
> 	}, {
> 		.type = "24c02",
> 		.addr = 0x57,
>-		.platform_data = &pca9500_eeprom_pdata,
>+		.properties = pca9500_eeprom_properties,
> 	}, {
> 		.type = "max1238",
> 		.addr = 0x35,

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
