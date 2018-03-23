Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbeCWMou convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:44:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35910 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752244AbeCWMos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:44:48 -0400
Date: Fri, 23 Mar 2018 12:44:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] staging: iio: ad7746: Remove unused defines
Message-ID: <20180323134433.00001530@huawei.com>
In-Reply-To: <1521642539-4845-6-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1521642539-4845-6-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:28:53 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Hmm. This sort of patch is always a trade off between
clearing out unused code and the fact that the defines
sometimes provide useful information even when not
actually used.

> ---
>  drivers/staging/iio/cdc/ad7746.c | 16 ----------------
>  drivers/staging/iio/cdc/ad7746.h |  5 -----
>  2 files changed, 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 57623db..cba8cd1 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -25,7 +25,6 @@
>   * AD7746 Register Definition
>   */
>  
> -#define AD7746_REG_STATUS		0
>  #define AD7746_REG_CAP_DATA_HIGH	1
>  #define AD7746_REG_VT_DATA_HIGH		4
>  #define AD7746_REG_CAP_SETUP		7
> @@ -38,17 +37,10 @@
>  #define AD7746_REG_CAP_GAINH		15
>  #define AD7746_REG_VOLT_GAINH		17
>  
> -/* Status Register Bit Designations (AD7746_REG_STATUS) */
> -#define AD7746_STATUS_EXCERR		BIT(3)
> -#define AD7746_STATUS_RDY		BIT(2)
> -#define AD7746_STATUS_RDYVT		BIT(1)
> -#define AD7746_STATUS_RDYCAP		BIT(0)
> -
Hmm. My gut feeling is the driver really should be reading this
register... Ah well.  Perhaps it can go in the meantime.

>  /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
>  #define AD7746_CAPSETUP_CAPEN		BIT(7)
>  #define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
>  #define AD7746_CAPSETUP_CAPDIFF		BIT(5)
> -#define AD7746_CAPSETUP_CACHOP		BIT(0)
Don't remove definitions of 'parts' of a register.
It is odd to only have some parts described.

>  
>  /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
>  #define AD7746_VTSETUP_VTEN		(1 << 7)
> @@ -56,13 +48,8 @@
>  #define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
>  #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
>  #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
> -#define AD7746_VTSETUP_EXTREF		BIT(4)
> -#define AD7746_VTSETUP_VTSHORT		BIT(1)
> -#define AD7746_VTSETUP_VTCHOP		BIT(0)
Same comment, keep these as odd to not know if the rest of the register
is used etc...
>  
>  /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
> -#define AD7746_EXCSETUP_CLKCTRL		BIT(7)
> -#define AD7746_EXCSETUP_EXCON		BIT(6)
>  #define AD7746_EXCSETUP_EXCB		BIT(5)
>  #define AD7746_EXCSETUP_NEXCB		BIT(4)
>  #define AD7746_EXCSETUP_EXCA		BIT(3)
> @@ -74,10 +61,7 @@
>  #define AD7746_CONF_CAPFS_SHIFT		3
>  #define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
>  #define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
> -#define AD7746_CONF_MODE_IDLE		(0 << 0)
> -#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
>  #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
> -#define AD7746_CONF_MODE_PWRDN		(3 << 0)
This is really nasty.  Some particular values may not be used
in the driver (and they should be - for example we should power
down on remove).  Don't remove their definitions.
>  #define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
>  #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
>  
> diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
> index ea8572d..2fbcee8 100644
> --- a/drivers/staging/iio/cdc/ad7746.h
> +++ b/drivers/staging/iio/cdc/ad7746.h
> @@ -13,11 +13,6 @@
>   * TODO: struct ad7746_platform_data needs to go into include/linux/iio
>   */
>  
> -#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
> -#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
> -#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
> -#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
This is used...  If you wanted to use the platform data you would
need these to fill it.

Jonathan
> -
>  struct ad7746_platform_data {
>  	unsigned char exclvl;	/*Excitation Voltage Level */
>  	bool exca_en;		/* enables EXCA pin as the excitation output */
