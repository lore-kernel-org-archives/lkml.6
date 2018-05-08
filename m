Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeEHWcj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:32:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46669 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeEHWch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:32:37 -0400
X-Google-Smtp-Source: AB8JxZpmevKCVj/Y99T64LXDDF5qACk3/JCmZSxXFmXYQRaRc2s91Gr7+uHKLGHS5qAKtJAsGafpwA==
Date: Tue, 8 May 2018 15:32:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] input: as5011: avoid using __set_bit() for
 capabilities
Message-ID: <20180508223234.GB129015@dtor-ws>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
 <20180331112143.18768-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331112143.18768-2-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 01:21:41PM +0200, Marcus Folkesson wrote:
> input_set_capability() and input_set_abs_param() will do it for you.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/as5011.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
> index 005d852a06e9..f051993c568e 100644
> --- a/drivers/input/joystick/as5011.c
> +++ b/drivers/input/joystick/as5011.c
> @@ -269,9 +269,7 @@ static int as5011_probe(struct i2c_client *client,
>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;
>  
> -	__set_bit(EV_KEY, input_dev->evbit);
> -	__set_bit(EV_ABS, input_dev->evbit);
> -	__set_bit(BTN_JOYSTICK, input_dev->keybit);
> +	input_set_capability(input_dev, EV_KEY, BTN_JOYSTICK);
>  
>  	input_set_abs_params(input_dev, ABS_X,
>  		AS5011_MIN_AXIS, AS5011_MAX_AXIS, AS5011_FUZZ, AS5011_FLAT);
> -- 
> 2.16.2
> 

-- 
Dmitry
