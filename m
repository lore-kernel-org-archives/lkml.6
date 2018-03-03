Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520039421; cv=none;
        d=google.com; s=arc-20160816;
        b=zxEYlKd+9nCGFAY+qqL3mGnSMfce6ZFBI+lYodBBlPVxDRFh6hV9dvYFX7pXjlieTb
         jTaRCOeDAvrHKOGa4iAmJMyGlXqUvJEn9XXjZPO5StoGq1Nn3736qESDzubuUHyfNfV/
         lLolswJn4izdmSwWFoXDSo3bg7bo2a3egsjJ41tNORChI1PSFU1tG+J9/Loa3oNFH52A
         91I7Kz5GlJ7Oy0VUeV5p4gY2f+A5QOYSvSDe91yGzLpwRAOODxq0ziVR0dA0iBFZq+h2
         Z5RusbsD4AbPPYrnipyziVxMrYN+dwPM3qk2RHdHG8iyAC7PUQ+SY3WuaMNQb1JO/fwb
         Kfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0QgLOFT/eFmNEKYYR5p1lGYPlVqfIDQNH/JzL6E17FY=;
        b=S1+e0C+PeUE9Ko1PHkylF5u4jQtxIsxXsF6vMGlRkbRJaxhfBhHf9yGJKyeT3HSWB7
         K73bEDqgklZZQXYdvexicOzsKEGc3l/lBNq0MiJ0Jr/w6iR21OkyZRGwK7M8ERBGepE/
         cD5CThwndcwioKA8u4gsQF9fMdAkmOcC72EsT+1OCninf8VL9ZjBLs8Bt9ZL1h7sSCVp
         O2Gk5n/H3laPhU1fmiQj/uONhcTX5ypuIcOGXBQC/UyzRdmEBZKwyqukQUod5pEnoWwu
         DUToaCRcyP+O3J2eIYT4YULRZfNVX7sb+Gi3mQdRAq/1/cTDtJ3dIfIWl0o26g8qTEvq
         A3xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=N/FLXdoC;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=N/FLXdoC;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELunSOrLOpplBlluSMPVs/bR29tN9mN0hkQxKcG1pdgp5/dITF1wI+jH7v1BIqqQIYmF/aY8Ww==
Date: Fri, 2 Mar 2018 17:10:17 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de,
	dtor@google.com, dianders@google.com,
	Guenter Roeck <linux@roeck-us.net>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v3 1/3] Input: gpio-keys - add support for wakeup event
 action
Message-ID: <20180303011016.GA258190@rodete-desktop-imager.corp.google.com>
References: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
 <20180302035102.10084-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302035102.10084-2-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1593876856274361305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeffy,

On Fri, Mar 02, 2018 at 11:51:00AM +0800, Jeffy Chen wrote:
> Add support for specifying event actions to trigger wakeup when using
> the gpio-keys input device as a wakeup source.
> 
> This would allow the device to configure when to wakeup the system. For
> example a gpio-keys input device for pen insert, may only want to wakeup
> the system when ejecting the pen.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> Adding more comments as Brian suggested.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  drivers/input/keyboard/gpio_keys.c     | 39 ++++++++++++++++++++++++++++++++++
>  include/linux/gpio_keys.h              |  2 ++
>  include/uapi/linux/input-event-codes.h |  9 ++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 87e613dc33b8..607f3960c886 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c

...

> @@ -586,6 +606,12 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  
>  		isr = gpio_keys_irq_isr;
>  		irqflags = 0;
> +
> +		/*
> +		 * For IRQ buttons, the irq trigger type for press and release
> +		 * are the same. So we don't need to reconfigure the trigger
> +		 * type for wakeup.
> +		 */

Ah, I think I misunderstood what the (non-GPIO) IRQ-based trigger was
doing. It's just emulating an instantaneous press/release (or, with a
configurable release delay), so there isn't really a way to say "only
wake me on one edge".

So that still doesn't really mean we use the "same" trigger for all
wakeup trigger types. It really just means we can't support any
customization here -- we wake based on whatever the IRQ represents
(which today is probably just EV_ACT_ANY).

I guess it's fine to just ignore the wakeup-trigger-type property here,
but it would also be equally valid to reject it outright I think.

Anyway, that's only a mild complaint. For the whole series:

Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

>  	}
>  
>  	bdata->code = &ddata->keymap[idx];
...
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 53fbae27b280..d7917b0bd438 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -32,6 +32,15 @@
>  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
>  
>  /*
> + * Event action types
> + */
> +#define EV_ACT_ANY			0x00	/* asserted or deasserted */
> +#define EV_ACT_ASSERTED			0x01	/* asserted */
> +#define EV_ACT_DEASSERTED		0x02	/* deasserted */
> +#define EV_ACT_MAX			0x02
> +#define EV_ACT_CNT			(EV_ACT_MAX+1)
> +
> +/*
>   * Event types
>   */
>  
> -- 
> 2.11.0
> 
> 
