Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeBGMKQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:10:16 -0500
Received: from m15-29.126.com ([220.181.15.29]:45520 "EHLO m15-29.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753643AbeBGMKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:10:15 -0500
X-Originating-IP: [171.221.128.103]
Date: Wed, 7 Feb 2018 20:10:03 +0800 (CST)
From: liuxiang <liuxiang_1999@126.com>
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org,
        liu.xiang6@zte.com.cn, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?=E6=9D=A5=E8=87=AAliuxiang=E7=9A=84=E9=82=AE=E4=BB=B6?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2d5c0de4.9028.161702c3d8a.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HcqowAA36pCc7HpapRadAA--.53913W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiZhXjsFpD4p8OogACsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w17CAL3Q024906

Sorry, I can't test these pieces of code now.

On Saturday 27 January 2018 22:25:36 Liu Xiang wrote:
> According to the datasheet, bq27411 is similar to bq27421.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 14 ++++++++++++++
>  include/linux/power/bq27xxx_battery.h  |  3 ++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 51f0961..2de378a 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -410,6 +410,7 @@ enum bq27xxx_reg_index {
>  #define bq27425_regs bq27421_regs
>  #define bq27441_regs bq27421_regs
>  #define bq27621_regs bq27421_regs
> +#define bq27411_regs bq27421_regs
>  
>  static enum power_supply_property bq27000_props[] = {
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -633,6 +634,7 @@ enum bq27xxx_reg_index {
>  #define bq27425_props bq27421_props
>  #define bq27441_props bq27421_props
>  #define bq27621_props bq27421_props
> +#define bq27411_props bq27421_props
>  
>  struct bq27xxx_dm_reg {
>  	u8 subclass_id;
> @@ -716,6 +718,17 @@ enum bq27xxx_dm_reg_id {
>  #define bq27621_dm_regs 0
>  #endif
>  
> +#if 0 /* not yet tested */
> +static struct bq27xxx_dm_reg bq27411_dm_regs[] = {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0, 32767 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2800,  3700 },
> +};
> +#else
> +#define bq27411_dm_regs 0
> +#endif

Can you test it?

I do not think it is a good idea to add dead code into mainline kernel.

> +
> +
>  #define BQ27XXX_O_ZERO	0x00000001
>  #define BQ27XXX_O_OTDC	0x00000002
>  #define BQ27XXX_O_UTOT  0x00000004
> @@ -762,6 +775,7 @@ enum bq27xxx_dm_reg_id {
>  	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
>  	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  };
>  
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index e6187f5..5f48eb0 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -23,10 +23,11 @@ enum bq27xxx_chip {
>  	BQ27546,
>  	BQ27742,
>  	BQ27545, /* bq27545 */
> -	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +	BQ27421, /* bq27421, bq27425, bq27441, bq27621, bq27411 */
>  	BQ27425,
>  	BQ27441,
>  	BQ27621,
> +	BQ27411,
>  };
>  
>  struct bq27xxx_device_info;
