Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3270031-1525808080-2-3572859260621591598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525808079; b=OXNjt+2xn0b4ww00//3dLdgO8+SbiRkivcJrB5XYA5gjgU5smD
    OBxV/HKmbu+kN9uF30ZBmbyv3hYYK554HWoxBJxPV4srdfZZigN3aimff3DDiOTk
    7NTqXgysXTtZPJYOTSkFHDpVjcKQl/sCKv1HdeJZg3rflvOTekct8KjbwlUr2124
    WA0gmDcNiAiwMejV3HXHLjKpVz7ImqFhWuj6NNi4PuedEIJQl4YW+W4fdlaA0cX6
    cc1J415EIz3ISD3puIQ1fOeBS/efKQBJv+mToBh6ARRwBGj8m/A0rUM1RZ1ZWmty
    LwDTAmv0FZJeyrBzo1YzCwfKnuEvLnxrTIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525808079;
    bh=+DHcCDn1hBDea6jHBOq1qaT1N54XJ0pc/yk/P8IDXQc=; b=Y2XX/BY2bxhF
    mMMkq3bdHEaBxn/vgTYGWtzGviQkD3V0Q9OwDdYkzjRI9Bny1rbeqZRtaTX8ryMU
    s1LhBH0uNoagVRiyuJSUlXX8MNDwDv8XdNVltSu4/umua3ULH61cSLrNB9TqOm6a
    aTFpX6P18qPwiu041s09NE+jd6vizZ7g2gOWkyIz0+BWrv0aIJ3F5/eeyhMPJ6Kt
    2/Q66BPhu9h6YUKu4XsklUdfDaIKGQT2FfJakGjUyfFSfQ3g14Jncv6vOqttO8xj
    01V1Q9AwTkRZy3+RRPvwfbw4JptSLHptr1Pa63RKFq64zujsnN71WrEl7ymLWQXe
    Pz0F0Pnt7w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=LIAe5xsj x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=smAdvx42;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=LIAe5xsj x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=smAdvx42;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIwRJpL10LV0fKFXYGPYQvPPp58PLcgAou/Q24pRXFbh8fF80IHii2qOyh2ZA6XTX6ohv8f4956u3wj1/JcL02e7pmamyek+w3DI2qYIYXYgPlzJwVZl
    41OJfoONN0vG3kB2vGjfARHOzlXGcSrhn5XIxAOpXgneaEE6g4zMscXTTz/RavO9X+of8ngfJTh+qN1H2lm3Okswd5/Jlgrz7rwLpm1npiDY+XEGKCLBltir
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=H_xvhQCm9QgA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=-AVHezQZnhy7oiP6nEQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeEHTei (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 15:34:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55611 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755437AbeEHTeh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 15:34:37 -0400
X-Google-Smtp-Source: AB8JxZrDxiz/m0De8yJp/wOCKJwQlVU/AWOlVeF5AHVdCV4DR1iTGqhhV8Kmyfy3sjCIIEhzKVFSuw==
Subject: Re: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ea34ce99-d446-03d2-b38d-d40a22480337@gmail.com>
Date: Tue, 8 May 2018 21:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Uwe,

Thank you for the patch. It looks fine, but please split
the drivers/net/can/led.c related changes into a separate one.

Best regards,
Jacek Anaszewski

On 05/08/2018 12:05 PM, Uwe Kleine-König wrote:
> This allows one to simplify drivers that provide a trigger with a
> non-constant name (e.g. one trigger per device with the trigger name
> depending on the device's name).
> 
> Internally the memory the name member of struct led_trigger points to
> now always allocated dynamically instead of just taken from the caller.
> 
> The function led_trigger_rename_static() must be changed accordingly and
> was renamed to led_trigger_rename() for consistency, with the only user
> adapted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/leds/led-triggers.c | 84 +++++++++++++++++++++++++++----------
>   drivers/net/can/led.c       |  6 +--
>   include/linux/leds.h        | 30 +++++++------
>   3 files changed, 81 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
> index 431123b048a2..5d8bb504b07b 100644
> --- a/drivers/leds/led-triggers.c
> +++ b/drivers/leds/led-triggers.c
> @@ -175,18 +175,34 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
>   }
>   EXPORT_SYMBOL_GPL(led_trigger_set_default);
>   
> -void led_trigger_rename_static(const char *name, struct led_trigger *trig)
> +int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...)
>   {
> -	/* new name must be on a temporary string to prevent races */
> -	BUG_ON(name == trig->name);
> +	const char *prevname;
> +	const char *newname;
> +	va_list args;
> +
> +	if (!trig)
> +		return 0;
> +
> +	va_start(args, fmt);
> +	newname = kvasprintf_const(GFP_KERNEL, fmt, args);
> +	va_end(args);
> +
> +	if (!newname) {
> +		pr_err("Failed to allocate new name for trigger %s\n", trig->name);
> +		return -ENOMEM;
> +	}
>   
>   	down_write(&triggers_list_lock);
> -	/* this assumes that trig->name was originaly allocated to
> -	 * non constant storage */
> -	strcpy((char *)trig->name, name);
> +	prevname = trig->name;
> +	trig->name = newname;
>   	up_write(&triggers_list_lock);
> +
> +	kfree_const(prevname);
> +
> +	return 0;
>   }
> -EXPORT_SYMBOL_GPL(led_trigger_rename_static);
> +EXPORT_SYMBOL_GPL(led_trigger_rename);
>   
>   /* LED Trigger Interface */
>   
> @@ -333,34 +349,56 @@ void led_trigger_blink_oneshot(struct led_trigger *trig,
>   }
>   EXPORT_SYMBOL_GPL(led_trigger_blink_oneshot);
>   
> -void led_trigger_register_simple(const char *name, struct led_trigger **tp)
> +int led_trigger_register_format(struct led_trigger **tp, const char *fmt, ...)
>   {
> +	va_list args;
>   	struct led_trigger *trig;
> -	int err;
> +	int err = -ENOMEM;
> +	const char *name;
> +
> +	va_start(args, fmt);
> +	name = kvasprintf_const(GFP_KERNEL, fmt, args);
> +	va_end(args);
>   
>   	trig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
>   
> -	if (trig) {
> -		trig->name = name;
> -		err = led_trigger_register(trig);
> -		if (err < 0) {
> -			kfree(trig);
> -			trig = NULL;
> -			pr_warn("LED trigger %s failed to register (%d)\n",
> -				name, err);
> -		}
> -	} else {
> -		pr_warn("LED trigger %s failed to register (no memory)\n",
> -			name);
> -	}
> +	if (!name || !trig)
> +		goto err;
> +
> +	trig->name = name;
> +
> +	err = led_trigger_register(trig);
> +	if (err < 0)
> +		goto err;
> +
>   	*tp = trig;
> +
> +	return 0;
> +
> +err:
> +	kfree(trig);
> +	kfree_const(name);
> +
> +	*tp = NULL;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(led_trigger_register_format);
> +
> +void led_trigger_register_simple(const char *name, struct led_trigger **tp)
> +{
> +	int ret = led_trigger_register_format(tp, "%s", name);
> +	if (ret < 0)
> +		pr_warn("LED trigger %s failed to register (%d)\n", name, ret);
>   }
>   EXPORT_SYMBOL_GPL(led_trigger_register_simple);
>   
>   void led_trigger_unregister_simple(struct led_trigger *trig)
>   {
> -	if (trig)
> +	if (trig) {
>   		led_trigger_unregister(trig);
> +		kfree_const(trig->name);
> +	}
>   	kfree(trig);
>   }
>   EXPORT_SYMBOL_GPL(led_trigger_unregister_simple);
> diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
> index c1b667675fa1..2d7d1b0d20f9 100644
> --- a/drivers/net/can/led.c
> +++ b/drivers/net/can/led.c
> @@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
>   
>   	if (msg == NETDEV_CHANGENAME) {
>   		snprintf(name, sizeof(name), "%s-tx", netdev->name);
> -		led_trigger_rename_static(name, priv->tx_led_trig);
> +		led_trigger_rename(priv->tx_led_trig, name);
>   
>   		snprintf(name, sizeof(name), "%s-rx", netdev->name);
> -		led_trigger_rename_static(name, priv->rx_led_trig);
> +		led_trigger_rename(priv->rx_led_trig, name);
>   
>   		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
> -		led_trigger_rename_static(name, priv->rxtx_led_trig);
> +		led_trigger_rename(priv->rxtx_led_trig, name);
>   	}
>   
>   	return NOTIFY_DONE;
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index b7e82550e655..e706c28bb35b 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -275,6 +275,8 @@ extern void led_trigger_unregister(struct led_trigger *trigger);
>   extern int devm_led_trigger_register(struct device *dev,
>   				     struct led_trigger *trigger);
>   
> +extern int led_trigger_register_format(struct led_trigger **trigger,
> +				       const char *fmt, ...);
>   extern void led_trigger_register_simple(const char *name,
>   				struct led_trigger **trigger);
>   extern void led_trigger_unregister_simple(struct led_trigger *trigger);
> @@ -298,28 +300,25 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
>   }
>   
>   /**
> - * led_trigger_rename_static - rename a trigger
> - * @name: the new trigger name
> + * led_trigger_rename - rename a trigger
>    * @trig: the LED trigger to rename
> + * @fmt: format string for new name
>    *
> - * Change a LED trigger name by copying the string passed in
> - * name into current trigger name, which MUST be large
> - * enough for the new string.
> - *
> - * Note that name must NOT point to the same string used
> - * during LED registration, as that could lead to races.
> - *
> - * This is meant to be used on triggers with statically
> - * allocated name.
> + * rebaptize the given trigger.
>    */
> -extern void led_trigger_rename_static(const char *name,
> -				      struct led_trigger *trig);
> +extern int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...);
>   
>   #else
>   
>   /* Trigger has no members */
>   struct led_trigger {};
>   
> +static inline int led_trigger_register_format(struct led_trigger **trigger,
> +					      const char *fmt, ...)
> +{
> +	return 0;
> +}
> +
>   /* Trigger inline empty functions */
>   static inline void led_trigger_register_simple(const char *name,
>   					struct led_trigger **trigger) {}
> @@ -342,6 +341,11 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
>   	return NULL;
>   }
>   
> +static inline int led_trigger_rename(struct led_trigger *trig, const char *fmt, ...)
> +{
> +	return 0;
> +}
> +
>   #endif /* CONFIG_LEDS_TRIGGERS */
>   
>   /* Trigger specific functions */
> 
