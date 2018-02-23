Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AH8x226r77aGalOftbuNbCFtvfj64lWYZWEoGWc3CavmJgehgnOGiGr0mRqXwb1EDHjZKufy5fP5
ARC-Seal: i=1; a=rsa-sha256; t=1519380277; cv=none;
        d=google.com; s=arc-20160816;
        b=XftQtq1pa5LhVquGKCsL6Usgsf3egLZBwLd2kIlKbBN7JEsZd+CY5MdpOCSTt1dmFT
         Dd91YoBJBTje69tbS/CiHepsCxB0coPX0MHPgTvCFX9ORhuE9ABG8lD0okLSMJFhqsV7
         +m7F7BkqOOYq3+JhlprPaYC/Br+xW3mkLWhzJCXbWLfOM/iw4UjTvwsvrENPEDwfy86t
         TsNjTISTquFB1Ye34jMXKn2DlKgFFpxDuxNFWf5+E1sE1CFnN8MsiW+xwB5CnLbhA3Dm
         YWkQbQxMkzXDv1qgnntgfdkTOjtQ6ZCQsFVlaT/+hmbVXSDzu4ACortWKrv+6Gi+VR3h
         FZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=O1EoxaH7rXWiv4AlIopTsm7Fu9b8UeQ9jQrXZV/J664=;
        b=NuDzWmJcRuoFqSObv1ZL3xZeU7F/VnL78ODzsTVH1JuvqjO1iEDuYUgDIL8/1n04fo
         YJbyXlsxImJzrAwl6mDp0oBsKM0+niX+uxVTI5dV+DHjIjd5Ip76XYtsO3EU3RyFlAIJ
         dLnSR96ACrmL7RtHQmDkcZq6RNqRH7hltPhuENL7skDBf6gRDgcTuyNDFEzDjM/TeZDf
         FSJxcOK73tOjj+htyZlshDJPecgyTEV2EHzy5bQksEQnnOfGL6MrSrQzA22lZeYliREs
         LQq24FWX/kc26SL1BsauynZ4BHVg/z22C7ss1C8XIMHvggwtVxmhUsjkYw9DXk5rJjxG
         DJvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.27 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.27 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: briannorris@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <586a62f527d2c866a7f31826d9fa5d69>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A8FE726.6080903@rock-chips.com>
Date: Fri, 23 Feb 2018 18:04:22 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
CC: linux-kernel@vger.kernel.org, briannorris@google.com,
 dtor@google.com, dianders@google.com,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>,
 stephen lu <lumotuwe@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 linux-input@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com> <20180210110907.5504-2-jeffy.chen@rock-chips.com> <20180212221309.GA66974@ban.mtv.corp.google.com>
In-Reply-To: <20180212221309.GA66974@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1593185694479082207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Brian,

Thanks for your reply.

On 02/13/2018 06:13 AM, Brian Norris wrote:
>> >
>> >  	if (bdata->gpiod) {
>> >+		int active_low = gpiod_is_active_low(bdata->gpiod);
>> >+
>> >  		if (button->debounce_interval) {
>> >  			error = gpiod_set_debounce(bdata->gpiod,
>> >  					button->debounce_interval * 1000);
>> >@@ -568,6 +572,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>> >  		isr = gpio_keys_gpio_isr;
>> >  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>> >
>> >+		switch (button->wakeup_event_action) {
>> >+		case EV_ACT_ASSERTED:
>> >+			bdata->wakeup_trigger_type = active_low ?
>> >+				IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
>> >+			break;
>> >+		case EV_ACT_DEASSERTED:
>> >+			bdata->wakeup_trigger_type = active_low ?
>> >+				IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>> >+			break;
> What about EV_ACT_ANY? And default case? I think for ANY, we're OK
> letting suspend/resume not reconfigure the trigger type, but maybe a
> comment here to note that?
right, will add comment in the next version.
>
>> >+		}
>> >  	} else {
> What about the 'else' case? Shouldn't we try to handle that?
i think the else case is for irq key, which would generate down and up 
events in one irq, so it would use the same trigger type for all these 3 
cases.

i'll add comment in the next version too.
>
> Brian
>
