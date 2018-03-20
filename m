Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeCTNS5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:18:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34585 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeCTNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:18:54 -0400
X-Google-Smtp-Source: AG47ELsjoXPklmb/xDxAzd5BEsAZ0uV+wytHaKJk40RDCYNGqNRKawKh++PeY2BKeuk9QUt1Cj1tBQ==
Subject: Re: [PATCH 1/3] i2c: mux: pca9541: use the BIT macro
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>,
        joel@jms.id.au, linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-2-peda@axentia.se>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9bbbe799-da7c-8e3c-7fe5-af5923e92255@roeck-us.net>
Date: Tue, 20 Mar 2018 06:18:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320093200.19179-2-peda@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 02:31 AM, Peter Rosin wrote:
> Because it looks nice!
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/i2c/muxes/i2c-mux-pca9541.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index 6a39adaf433f..ad168125d23d 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -16,6 +16,7 @@
>    * warranty of any kind, whether express or implied.
>    */
>   
> +#include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/i2c.h>
> @@ -43,20 +44,20 @@
>   #define PCA9541_CONTROL		0x01
>   #define PCA9541_ISTAT		0x02
>   
> -#define PCA9541_CTL_MYBUS	(1 << 0)
> -#define PCA9541_CTL_NMYBUS	(1 << 1)
> -#define PCA9541_CTL_BUSON	(1 << 2)
> -#define PCA9541_CTL_NBUSON	(1 << 3)
> -#define PCA9541_CTL_BUSINIT	(1 << 4)
> -#define PCA9541_CTL_TESTON	(1 << 6)
> -#define PCA9541_CTL_NTESTON	(1 << 7)
> -
> -#define PCA9541_ISTAT_INTIN	(1 << 0)
> -#define PCA9541_ISTAT_BUSINIT	(1 << 1)
> -#define PCA9541_ISTAT_BUSOK	(1 << 2)
> -#define PCA9541_ISTAT_BUSLOST	(1 << 3)
> -#define PCA9541_ISTAT_MYTEST	(1 << 6)
> -#define PCA9541_ISTAT_NMYTEST	(1 << 7)
> +#define PCA9541_CTL_MYBUS	BIT(0)
> +#define PCA9541_CTL_NMYBUS	BIT(1)
> +#define PCA9541_CTL_BUSON	BIT(2)
> +#define PCA9541_CTL_NBUSON	BIT(3)
> +#define PCA9541_CTL_BUSINIT	BIT(4)
> +#define PCA9541_CTL_TESTON	BIT(6)
> +#define PCA9541_CTL_NTESTON	BIT(7)
> +
> +#define PCA9541_ISTAT_INTIN	BIT(0)
> +#define PCA9541_ISTAT_BUSINIT	BIT(1)
> +#define PCA9541_ISTAT_BUSOK	BIT(2)
> +#define PCA9541_ISTAT_BUSLOST	BIT(3)
> +#define PCA9541_ISTAT_MYTEST	BIT(6)
> +#define PCA9541_ISTAT_NMYTEST	BIT(7)
>   
>   #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
>   #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
> 
