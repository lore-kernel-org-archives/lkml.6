Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeCHXdx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:33:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44566 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeCHXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:33:51 -0500
X-Google-Smtp-Source: AG47ELumWJdG7Ce8GCKEqR8qwN6Z8XYazdd/tEtBNk6XjKMmPl2SfgvddOJVgSdkpa9Sp+eJvtnwPQ==
Date: Thu, 8 Mar 2018 15:33:48 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042: add Lenovo ThinkPad L460 to i8042 reset
 list
Message-ID: <20180308233348.GA198135@dtor-ws>
References: <3063cecf-a893-6c0e-06cd-dfe325c45e2f@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3063cecf-a893-6c0e-06cd-dfe325c45e2f@secunet.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 05:35:14PM +0100, Dennis Wassenberg wrote:
> Reset i8042 before probing because of insufficient
> BIOS initialisation of the i8042 serial controller.
> This makes synaptics touchpad detection possible.
> Without resetting the synaptics touchpad is not detected
> because there are always NACK messages from AUX port.
> 
> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 6cbbdc6..7755134 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -627,6 +627,13 @@ static inline void i8042_write_command(int val)
>  			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
>  		},
>  	},
> +	{
> +		/* Lenovo ThinkPad L460 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
> +		},
> +	},
>  	{ }
>  };
>  
> -- 
> 1.9.1
> 
> 

-- 
Dmitry
