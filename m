Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F13C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01BC2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gh7u3TN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01BC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeH2Noo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:44:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46078 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2Noo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:44:44 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so8001526oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9a7lUEbXTjwMgOCV9bB64zBe17Mkn092sQB9NT2hLHA=;
        b=gh7u3TN3zrsvbRhW3JQfG+5+++gfYEa9YRflkyfWeOMpbiTPZ1qkHXxW+fE1xG4JOY
         UKa09uT9+FPFRBSuh0Zmb8MRp2GATK2BTWcvT3shvGoR6YuBE20vwj1J7nP7xUNO0DwM
         xPf+L3lfjseZa672gIgqmTI/lDyaQNv9gVcWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9a7lUEbXTjwMgOCV9bB64zBe17Mkn092sQB9NT2hLHA=;
        b=fCtAe1Lq+kc7jZKkv6ni7niar6dTSchYfcHwqnl6hetLLgeIjucKc+B11NOAwXootN
         YR+s+PPuddFozSMUy2zSpN3LH+eT80Mpt4qUQHbE6YdiKICFXEsPJ/KMcX4u5iXzthTR
         kHKEz0wQktg3BHv4I6pkpzIvwxeCliD9gSdUcjzRKWTvm41GGygn5NujACOOP9iakzob
         RFLQGiYbogH0RrfoV3NzqTiGQQK6QkkP4Tx47VnFzrOHSdqlCmrdWxPKOSnuxu6aNH6o
         ru6eXpMnMZt/6LCO6M10aZNdWcxBV9lWDqokmMlUWIb8ulq5f76SxIpOYEK87HDvnZrf
         zsOA==
X-Gm-Message-State: APzg51C7eFTOtYOAu6SvMzVa868pxpWZOmn7sVWXJDCHNT8hMZSgOu4y
        +1qjAdLRFggmHIW0HKyBS8iH85uQMQ/wRQ17nXKjMdvy9do=
X-Google-Smtp-Source: ANB0VdYiMzxA/2kybE1X3aOlO0m8/GS3ACAXQFUVZxW9PK7JeamsNP/x86AdwewInmrvNXpSRnevrji28A6Z2ABFmoI=
X-Received: by 2002:aca:5b57:: with SMTP id p84-v6mr2012601oib.109.1535536118524;
 Wed, 29 Aug 2018 02:48:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:29:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 02:48:37 -0700 (PDT)
In-Reply-To: <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com> <20180824201227.GB17146@amd>
 <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com> <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
 <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 29 Aug 2018 17:48:37 +0800
Message-ID: <CAMz4ku+a5QT5CaonW3R6dfKzcpJgyeGLbD5tH-0K1QMLDdQpqQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 29 August 2018 at 04:25, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> On 08/25/2018 09:51 AM, Baolin Wang wrote:
>> On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>> On 08/24/2018 10:12 PM, Pavel Machek wrote:
>>>> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
>>>>> Hi Pavel,
>>>>>
>>>>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>> I think that it would be more flexible if software pattern fallback
>>>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>>>> lead to the situation where LED class devices that support hardware
>>>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>>>> resort to using software pattern engine which will accept far greater
>>>>>>> amount of pattern combinations.
>>>>>>>
>>>>>>> In this case we need to discuss on what basis the decision will be
>>>>>>> made on whether hardware or software engine will be used.
>>>>>>>
>>>>>>> Possible options coming to mind:
>>>>>>> - an interface will be provided to determine max difference between
>>>>>>>   the settings supported by the hardware and the settings requested by
>>>>>>>   the user, that will result in aligning user's setting to the hardware
>>>>>>>   capabilities
>>>>>>> - the above alignment rate will be predefined instead
>>>>>>> - hardware engine will be used only if user requests supported settings
>>>>>>>   on the whole span of the requested pattern
>>>>>>> - in each of the above cases it would be worth to think of the
>>>>>>>   interface to show the scope of the settings supported by hardware
>>>>>>
>>>>>> I'd recommend keeping it simple. We use hardware engine if driver
>>>>>> author thinks pattern is "close enough".
>>>>>
>>>>> The thing is that in the ledtrig-pattern v5 implementation there
>>>>> is no option of using software fallback if pattern_set op
>>>>> is initialized:
>>>>>
>>>>> +    if (led_cdev->pattern_set) {
>>>>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>> +                                         data->npatterns, data->repeat);
>>>>> +    }
>>>>
>>>> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
>>>>
>>>> It pattern_set() returns special error code, it should just continue
>>>> and use software pattern fallback.
>>>
>>> And now we can get back to the issue I was concerned about in the
>>> email you replied to, i.e. what series of [brightness delta_t] tuples
>>> should be written to the pattern file to enable hardware breathing
>>> engine.
>>
>> OK. So now we've made a consensus to use the software pattern fallback
>> if failed to set hardware pattern. How about introduce one interface
>> to convert hardware patterns to software patterns if necessary?
>>
>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
>> b/drivers/leds/trigger/ledtrig-pattern.c
>> index 63b94a2..d46a641 100644
>> --- a/drivers/leds/trigger/ledtrig-pattern.c
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -66,8 +66,15 @@ static int pattern_trig_start_pattern(struct
>> pattern_trig_data *data,
>>                 return 0;
>>
>>         if (led_cdev->pattern_set) {
>> -               return led_cdev->pattern_set(led_cdev, data->patterns,
>> -                                            data->npatterns, data->repeat);
>> +               ret = led_cdev->pattern_set(led_cdev, data->patterns,
>> +                                           data->npatterns, data->repeat);
>> +               if (!ret)
>> +                       return 0;
>> +
>> +               dev_warn(led_cdev->dev, "Failed to set hardware pattern\n");
>> +
>> +               if (led_cdev->pattern_convert)
>> +                       led_cdev->pattern_convert(led_cdev,
>
> I can't see how it could help to assess if hw pattern
> engine can launch given pattern, and with what accuracy.
>
> Instead, I propose to add a means for defining whether the pattern
> to be set is intended for hardware pattern engine or for software
> fallback. It could be either separate sysfs file e.g. hw_pattern,
> or a modifier to the pattern written to the pattern file, e,g,
>
> echo "hw 100 2 200 3 100 2" > pattern
>
> hw format expected by given driver would have to be described
> in the per-driver ABI documentation. All patterns without
> "hw" prefix would enable software pattern engine.

OK. So I did some optimization based on v5 according to suggestion, if
you think this is okay for you, then I will send out the formal v6
patch set.

1. echo "hw 100 2 200 3 100 2" > pattern
Only for hardware pattern, if failed,  we will return error number.

2. echo "100 2 200 3 100 2" > pattern
Will try to set hardware pattern firstly, if failed, will use software
pattern instead.

diff --git a/drivers/leds/trigger/ledtrig-pattern.c
b/drivers/leds/trigger/ledtrig-pattern.c
index 63b94a2..f08e797 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -26,6 +26,7 @@ struct pattern_trig_data {
 	u32 repeat;
 	u32 last_repeat;
 	bool is_indefinite;
+	bool is_hw_pattern;
 	struct timer_list timer;
 };

@@ -62,12 +63,21 @@ static void pattern_trig_timer_function(struct
timer_list *t)
 static int pattern_trig_start_pattern(struct pattern_trig_data *data,
 				      struct led_classdev *led_cdev)
 {
+	int ret;
+
 	if (!data->npatterns)
 		return 0;

 	if (led_cdev->pattern_set) {
-		return led_cdev->pattern_set(led_cdev, data->patterns,
+		ret = led_cdev->pattern_set(led_cdev, data->patterns,
 					     data->npatterns, data->repeat);
+		if (!ret)
+			return 0;
+
+		dev_warn(led_cdev->dev, "Failed to set hardware patterns\n");
+
+		if (data->is_hw_pattern)
+			return ret;
 	}

 	data->curr = data->patterns;
@@ -106,7 +116,7 @@ static ssize_t repeat_store(struct device *dev,
struct device_attribute *attr,
 	if (err)
 		return err;

-	if (!led_cdev->pattern_set)
+	if (!data->is_hw_pattern)
 		del_timer_sync(&data->timer);

 	mutex_lock(&data->lock);
@@ -159,19 +169,32 @@ static ssize_t pattern_store(struct device *dev,
struct device_attribute *attr,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct pattern_trig_data *data = led_cdev->trigger_data;
-	int ccount, cr, offset = 0, err = 0;
+	int ccount, cr, len, offset = 0, err = 0;
+	const char *s;

-	if (!led_cdev->pattern_set)
+	if (!data->is_hw_pattern)
 		del_timer_sync(&data->timer);

 	mutex_lock(&data->lock);

+	s = strstr(buf, "hw");
+	if (s && led_cdev->pattern_set) {
+		data->is_hw_pattern = true;
+		s += strlen("hw");
+		len = strlen(s);
+	} else {
+		data->is_hw_pattern = false;
+		s = buf;
+		len = count;
+	}
+
 	data->npatterns = 0;
-	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
+	while (offset < len - 1 && data->npatterns < MAX_PATTERNS) {
 		cr = 0;
-		ccount = sscanf(buf + offset, "%d %d %n",
+		ccount = sscanf(s + offset, "%d %d %n",
 				&data->patterns[data->npatterns].brightness,
 				&data->patterns[data->npatterns].delta_t, &cr);
 		if (ccount != 2) {
 			data->npatterns = 0;
 			err = -EINVAL;
@@ -232,7 +255,8 @@ static void pattern_trig_deactivate(struct
led_classdev *led_cdev)

 	if (led_cdev->pattern_clear)
 		led_cdev->pattern_clear(led_cdev);
-	else
+
+	if (!data->is_hw_pattern)
 		del_timer_sync(&data->timer);

 	led_set_brightness(led_cdev, LED_OFF);

>
>> data->patterns, &data->npatterns);
>>         }
>>
>>         data->curr = data->patterns;
>> @@ -106,8 +113,7 @@ static ssize_t repeat_store(struct device *dev,
>> struct device_attribute *attr,
>>         if (err)
>>                 return err;
>>
>> -       if (!led_cdev->pattern_set)
>> -               del_timer_sync(&data->timer);
>> +       del_timer_sync(&data->timer);
>>
>>         mutex_lock(&data->lock);
>>
>> @@ -161,8 +167,7 @@ static ssize_t pattern_store(struct device *dev,
>> struct device_attribute *attr,
>>         struct pattern_trig_data *data = led_cdev->trigger_data;
>>         int ccount, cr, offset = 0, err = 0;
>>
>> -       if (!led_cdev->pattern_set)
>> -               del_timer_sync(&data->timer);
>> +       del_timer_sync(&data->timer);
>>
>>         mutex_lock(&data->lock);
>>
>> @@ -232,9 +237,8 @@ static void pattern_trig_deactivate(struct
>> led_classdev *led_cdev)
>>
>>         if (led_cdev->pattern_clear)
>>                 led_cdev->pattern_clear(led_cdev);
>> -       else
>> -               del_timer_sync(&data->timer);
>>
>> +       del_timer_sync(&data->timer);
>>         led_set_brightness(led_cdev, LED_OFF);
>>         kfree(data);
>>         led_cdev->activated = false;
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index 74fc2c6..04f3eaf 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -93,6 +93,8 @@ struct led_classdev {
>>                            struct led_pattern *pattern, int len,
>>                            unsigned int repeat);
>>         int (*pattern_clear)(struct led_classdev *led_cdev);
>> +       int (*pattern_convert)(struct led_classdev *led_cdev,
>> +                              struct led_pattern *pattern, int *len);
>>
>>         struct device           *dev;
>>         const struct attribute_group    **groups;
>>
>
> --
> Best regards,
> Jacek Anaszewski



-- 
Baolin Wang
Best Regards
