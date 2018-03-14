Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCNQjT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:39:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34280 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCNQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:39:17 -0400
X-Google-Smtp-Source: AG47ELvPJvMnZZlGVe6ZQwl6Q16rR5Lz1VmxjufFgqwEWn0GZS8TxhOTwzrxMyXcyvYDAIDkcdMldw==
Date: Wed, 14 Mar 2018 09:39:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [RESEND PATCH] Input: joystick/analog - Use get_cycles() on PPC
Message-ID: <20180314163913.GC18065@dtor-ws>
References: <20180314111752.1748-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314111752.1748-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 10:17:52PM +1100, Michael Ellerman wrote:
> The analog joystick driver spits a warning at us:
> 
>   drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
>   not defined for this architecture.
> 
> PPC has get_cycles() so use that.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied, thank you.

> ---
>  drivers/input/joystick/analog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> This is the third resend, I'll take it via the powerpc tree if no one else
> does.
> 
> cheers
> 
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index c868a878c84f..a942c4ccd2af 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -163,7 +163,7 @@ static unsigned int get_time_pit(void)
>  #define GET_TIME(x)	do { x = (unsigned int)rdtsc(); } while (0)
>  #define DELTA(x,y)	((y)-(x))
>  #define TIME_NAME	"TSC"
> -#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
> +#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_PPC) || defined(CONFIG_RISCV) || defined(CONFIG_TILE)
>  #define GET_TIME(x)	do { x = get_cycles(); } while (0)
>  #define DELTA(x,y)	((y)-(x))
>  #define TIME_NAME	"get_cycles"
> -- 
> 2.14.1
> 

-- 
Dmitry
