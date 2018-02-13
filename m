Return-Path: <enric.balletbo@collabora.com>
X-Google-Smtp-Source: AH8x226hth56cEt7nDBW9LG00yA75DzMFec/mlkCt4fJd2yFgShRTSvznqE57Ks5dp995kA8j9Rp
ARC-Seal: i=1; a=rsa-sha256; t=1518518448; cv=none;
        d=google.com; s=arc-20160816;
        b=r2e5+diXCXC01Hv144gXDYRoR4H7/1Pr5NF8vtBUcLI9wPufcEdjVLVHqqbrVEQiDV
         Hi96wYAW9JzqL9JmF4Y/rIsqywZl4xp0B5ES+bjcNgaVm5vhQWVezmF8qeZkW7XVmILR
         t9LGOIbEI+FSp9j3v3aKokUItFJBbmBjHO/lkr/4r/y/xwAHkrv9+MIHHi33+KraxaXb
         Xi96bTyV8smKCW7bxgbZyGGvwBf7Oifr50xf8FACcCtRasjrcxBW2ywgHNmt50/O9ODf
         2DugplY4KvhRGg1v1+pllsaA3cG28FKkVbF7sFo+/6lCnJNtpnPO/uPK/x3pWwdpeJC1
         TrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=a9bcCMO9xa7t910zJ98BW6UYW7KC3t7BMmIJ+RUrUK4=;
        b=poDj0rJvqjEZD+za5bQI6McWHjZV584QDCpYeaUSK48Jq7P2vlSiF9xZ5Dm3I2EGJj
         DQZithloYI3yqI83IgIyVK+2D1WWxApTyZzlCBqlZz6kKCcbnAlwxKTpIzXwRaNpc1xr
         ghyswb0y/ycERAlY7YNPletsoeUqenJ5yAegisblWNV60GdnxV0+4rDWfmt+z9iZx8tF
         NsbYjSpkcTkHWaBhN9wsNZ9qaDwCwcTcIrsXZQqnwKy1jOr2GUkaKP8MgP6bJeGHBIye
         gD+nKVLNs7v8jz3PnFKvMsa/YGbq3b3caFksEFOpgCUllUJFgkTRUuWRQCWBd6/olRFb
         NFRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of enric.balletbo@collabora.com designates 46.235.227.227 as permitted sender) smtp.mailfrom=enric.balletbo@collabora.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of enric.balletbo@collabora.com designates 46.235.227.227 as permitted sender) smtp.mailfrom=enric.balletbo@collabora.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.com
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
To: Brian Norris <briannorris@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com,
 dianders@google.com, Thomas Gleixner <tglx@linutronix.de>,
 Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-2-jeffy.chen@rock-chips.com>
 <20180212221309.GA66974@ban.mtv.corp.google.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <059e2aa9-bf94-517d-a132-abe851ec69f7@collabora.com>
Date: Tue, 13 Feb 2018 11:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212221309.GA66974@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1592282000452762919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeffy,

On 12/02/18 23:13, Brian Norris wrote:
> Hi Jeffy,
> 
> On Sat, Feb 10, 2018 at 07:09:05PM +0800, Jeffy Chen wrote:
>> Add support for specifying event actions to trigger wakeup when using
>> the gpio-keys input device as a wakeup source.
>>
>> This would allow the device to configure when to wakeup the system. For
>> example a gpio-keys input device for pen insert, may only want to wakeup
>> the system when ejecting the pen.
>>
>> Suggested-by: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> Specify wakeup event action instead of irq trigger type as Brian
>> suggested.
>>
>>  drivers/input/keyboard/gpio_keys.c     | 27 +++++++++++++++++++++++++++
>>  include/linux/gpio_keys.h              |  2 ++
>>  include/uapi/linux/input-event-codes.h |  9 +++++++++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>> index 87e613dc33b8..5c57339d3999 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -45,6 +45,8 @@ struct gpio_button_data {
>>  	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
>>  
>>  	unsigned int irq;
>> +	unsigned int irq_trigger_type;
>> +	unsigned int wakeup_trigger_type;
>>  	spinlock_t lock;
>>  	bool disabled;
>>  	bool key_pressed;
>> @@ -540,6 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>>  	}
>>  
>>  	if (bdata->gpiod) {
>> +		int active_low = gpiod_is_active_low(bdata->gpiod);
>> +
>>  		if (button->debounce_interval) {
>>  			error = gpiod_set_debounce(bdata->gpiod,
>>  					button->debounce_interval * 1000);
>> @@ -568,6 +572,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>>  		isr = gpio_keys_gpio_isr;
>>  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>>  
>> +		switch (button->wakeup_event_action) {
>> +		case EV_ACT_ASSERTED:
>> +			bdata->wakeup_trigger_type = active_low ?
>> +				IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
>> +			break;
>> +		case EV_ACT_DEASSERTED:
>> +			bdata->wakeup_trigger_type = active_low ?
>> +				IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>> +			break;
> 
> What about EV_ACT_ANY? And default case? I think for ANY, we're OK
> letting suspend/resume not reconfigure the trigger type, but maybe a
> comment here to note that?
> 
>> +		}
>>  	} else {
> 
> What about the 'else' case? Shouldn't we try to handle that?
> 
> Brian
> 
>>  		if (!button->irq) {
>>  			dev_err(dev, "Found button without gpio or irq\n");
>> @@ -618,6 +632,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>>  		return error;
>>  	}
>>  
>> +	bdata->irq_trigger_type = irq_get_trigger_type(bdata->irq);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -718,6 +734,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>>  			/* legacy name */
>>  			fwnode_property_read_bool(child, "gpio-key,wakeup");
>>  
>> +		fwnode_property_read_u32(child, "wakeup-event-action",
>> +					 &button->wakeup_event_action);
>> +
>>  		button->can_disable =
>>  			fwnode_property_read_bool(child, "linux,can-disable");
>>  
>> @@ -854,6 +873,10 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
>>  	if (device_may_wakeup(dev)) {
>>  		for (i = 0; i < ddata->pdata->nbuttons; i++) {
>>  			struct gpio_button_data *bdata = &ddata->data[i];
>> +
>> +			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
>> +				irq_set_irq_type(bdata->irq,
>> +						 bdata->wakeup_trigger_type);
>>  			if (bdata->button->wakeup)
>>  				enable_irq_wake(bdata->irq);
>>  			bdata->suspended = true;
>> @@ -878,6 +901,10 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
>>  	if (device_may_wakeup(dev)) {
>>  		for (i = 0; i < ddata->pdata->nbuttons; i++) {
>>  			struct gpio_button_data *bdata = &ddata->data[i];
>> +
>> +			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
>> +				irq_set_irq_type(bdata->irq,
>> +						 bdata->irq_trigger_type);
>>  			if (bdata->button->wakeup)
>>  				disable_irq_wake(bdata->irq);
>>  			bdata->suspended = false;
>> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
>> index d06bf77400f1..7160df54a6fe 100644
>> --- a/include/linux/gpio_keys.h
>> +++ b/include/linux/gpio_keys.h
>> @@ -13,6 +13,7 @@ struct device;
>>   * @desc:		label that will be attached to button's gpio
>>   * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
>>   * @wakeup:		configure the button as a wake-up source
>> + * @wakeup_event_action:	event action to trigger wakeup
>>   * @debounce_interval:	debounce ticks interval in msecs
>>   * @can_disable:	%true indicates that userspace is allowed to
>>   *			disable button via sysfs
>> @@ -26,6 +27,7 @@ struct gpio_keys_button {
>>  	const char *desc;
>>  	unsigned int type;
>>  	int wakeup;
>> +	int wakeup_event_action;
>>  	int debounce_interval;
>>  	bool can_disable;
>>  	int value;
>> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
>> index 53fbae27b280..d7917b0bd438 100644
>> --- a/include/uapi/linux/input-event-codes.h
>> +++ b/include/uapi/linux/input-event-codes.h
>> @@ -32,6 +32,15 @@
>>  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
>>  
>>  /*
>> + * Event action types
>> + */
>> +#define EV_ACT_ANY			0x00	/* asserted or deasserted */
>> +#define EV_ACT_ASSERTED			0x01	/* asserted */
>> +#define EV_ACT_DEASSERTED		0x02	/* deasserted */
>> +#define EV_ACT_MAX			0x02
>> +#define EV_ACT_CNT			(EV_ACT_MAX+1)
>> +
>> +/*
>>   * Event types
>>   */
>>  
>> -- 
>> 2.11.0
>>
>>

Not sure if you were aware but there is also some discussion related to this,
maybe we can join the efforts?

v1: https://patchwork.kernel.org/patch/10208261/
v2: https://patchwork.kernel.org/patch/10211147/

Best regards,
 Enric
