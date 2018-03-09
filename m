Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCIIPd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:15:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54855 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCIIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:15:31 -0500
X-Google-Smtp-Source: AG47ELt0sMXt364yzsCfBukUpujk14ZpfTbeguijcWdFi8WIVYoSFRe1JLCuQUhzs2gsznFR5ItP5Q==
Date: Fri, 9 Mar 2018 08:15:28 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
        alexandre.belloni@bootlin.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/4] mfd: syscon: Set name of regmap_config
Message-ID: <20180309081528.shgirroytqjtlx3d@dell>
References: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
 <20180309015146.8297-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180309015146.8297-2-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Mar 2018, Jeffy Chen wrote:

> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> Modify commit message.
> 
>  drivers/mfd/syscon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index fc9ba0ea4e44..b6d05cd934e6 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -110,6 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
>  	syscon_config.reg_stride = reg_io_width;
>  	syscon_config.val_bits = reg_io_width * 8;
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
> +	syscon_config.name = of_node_full_name(np);

It's difficult to review, since we cannot see what's happening with
the rest of the patch set.  Would you mind re-sending the whole set to
all parties please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
