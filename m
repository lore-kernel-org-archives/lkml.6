Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934325AbeCGWyO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:54:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56676 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933858AbeCGWyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:54:12 -0500
Date: Wed, 7 Mar 2018 23:54:11 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, arnd@arndb.de, broonie@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/3] rtc: Use time64_t to save range_max of RTC
Message-ID: <20180307225411.GA20370@piout.net>
References: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/02/2018 at 16:33:56 +0800, Baolin Wang wrote:
> We need use rtc->range_max to valid if the time values are valid,
> and the time values are saved by time64_t type. So change the
> rtc->range_max to time64_t type for comparison correctly.
> 

I'm not applying this one because the described issue will never happen
as negative times are forbidden by the rtc subsystem.

I've applied the two following patches

> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  include/linux/rtc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index bdfc0c4..8560282 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -152,7 +152,7 @@ struct rtc_device {
>  	struct bin_attribute *nvram;
>  
>  	time64_t range_min;
> -	timeu64_t range_max;
> +	time64_t range_max;
>  
>  #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
>  	struct work_struct uie_task;
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
