Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7505FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0844F2147D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ72ohH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0844F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHYL3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 07:29:41 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43600 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHYL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 07:29:41 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so19171484oib.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w94XvNIDaxuxplSz74v/yiDlfPwGt6W09h8RHLWI2ow=;
        b=bQ72ohH7lqSS0b7sqBFuc13NAUKa8Dgh8gLd3VChuMvvoA2LVLkpFhUdciJ2piiK/w
         93zz+8J+eOZ6hu17A5/jKlTupGE+trCXFY0MYS6fsLdtSekN2SxqOfB/2zwY57BUOR9n
         sekurPV7H2zit7kbH9iro7s1mCnUuyCDrxecs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w94XvNIDaxuxplSz74v/yiDlfPwGt6W09h8RHLWI2ow=;
        b=UA/IFZQa5AD3sub1xU1PVt3wW7HHElpi1Ttudj+OxEJeqSvTCQBSnnQdgepiPbOBST
         Yp/yYGoo5Dmzzl3aCF1hqdF+zjnVHJAtokKLNjwmuZzv3C/+gJpu6NYvHWXoSTzVQMjO
         KHJjKcWevR7T94x3mWLzV+0VFyvyYK381kaOF8wru6yHSuswTTrPiji7FNLWWWqrFJCs
         hhYp+YKBMnZPKDdNxD3K6Lx1fT/1AkdLuF2H7p+kuKcM1y/5MdNAre64+ucHlyrG2QXo
         jzzfrLS/9PFJuWYwlqiS+tuLbP5rr1h2e6RalOfEaZ01BfG5xgy6NSy28phKLef3W9KC
         aJkA==
X-Gm-Message-State: APzg51C9lk8zbNDS7wSErVNofOtfvKVgWIDBE3jtHc8yUFyzHGkZtaTt
        IgxLiWPyL3ON5jDZeFrDdKljE4fbLD23uMB95aRlWw==
X-Google-Smtp-Source: ANB0VdYqYev2ozX5b9s7JJfY2657nbGs8j4lJBi5PRBMtA2Xr6sfBuwGncXzuj3Oa+ogkUY2ck2KtFaWRJk1tyD1Px4=
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr4835681oia.280.1535183494313;
 Sat, 25 Aug 2018 00:51:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:29:0:0:0:0:0 with HTTP; Sat, 25 Aug 2018 00:51:33 -0700 (PDT)
In-Reply-To: <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com> <20180824201227.GB17146@amd> <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sat, 25 Aug 2018 15:51:33 +0800
Message-ID: <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
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

On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> On 08/24/2018 10:12 PM, Pavel Machek wrote:
>> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
>>> Hi Pavel,
>>>
>>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> I think that it would be more flexible if software pattern fallback
>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>> lead to the situation where LED class devices that support hardware
>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>> resort to using software pattern engine which will accept far greater
>>>>> amount of pattern combinations.
>>>>>
>>>>> In this case we need to discuss on what basis the decision will be
>>>>> made on whether hardware or software engine will be used.
>>>>>
>>>>> Possible options coming to mind:
>>>>> - an interface will be provided to determine max difference between
>>>>>   the settings supported by the hardware and the settings requested by
>>>>>   the user, that will result in aligning user's setting to the hardware
>>>>>   capabilities
>>>>> - the above alignment rate will be predefined instead
>>>>> - hardware engine will be used only if user requests supported settings
>>>>>   on the whole span of the requested pattern
>>>>> - in each of the above cases it would be worth to think of the
>>>>>   interface to show the scope of the settings supported by hardware
>>>>
>>>> I'd recommend keeping it simple. We use hardware engine if driver
>>>> author thinks pattern is "close enough".
>>>
>>> The thing is that in the ledtrig-pattern v5 implementation there
>>> is no option of using software fallback if pattern_set op
>>> is initialized:
>>>
>>> +    if (led_cdev->pattern_set) {
>>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
>>> +                                         data->npatterns, data->repeat);
>>> +    }
>>
>> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
>>
>> It pattern_set() returns special error code, it should just continue
>> and use software pattern fallback.
>
> And now we can get back to the issue I was concerned about in the
> email you replied to, i.e. what series of [brightness delta_t] tuples
> should be written to the pattern file to enable hardware breathing
> engine.

OK. So now we've made a consensus to use the software pattern fallback
if failed to set hardware pattern. How about introduce one interface
to convert hardware patterns to software patterns if necessary?

diff --git a/drivers/leds/trigger/ledtrig-pattern.c
b/drivers/leds/trigger/ledtrig-pattern.c
index 63b94a2..d46a641 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -66,8 +66,15 @@ static int pattern_trig_start_pattern(struct
pattern_trig_data *data,
                return 0;

        if (led_cdev->pattern_set) {
-               return led_cdev->pattern_set(led_cdev, data->patterns,
-                                            data->npatterns, data->repeat);
+               ret = led_cdev->pattern_set(led_cdev, data->patterns,
+                                           data->npatterns, data->repeat);
+               if (!ret)
+                       return 0;
+
+               dev_warn(led_cdev->dev, "Failed to set hardware pattern\n");
+
+               if (led_cdev->pattern_convert)
+                       led_cdev->pattern_convert(led_cdev,
data->patterns, &data->npatterns);
        }

        data->curr = data->patterns;
@@ -106,8 +113,7 @@ static ssize_t repeat_store(struct device *dev,
struct device_attribute *attr,
        if (err)
                return err;

-       if (!led_cdev->pattern_set)
-               del_timer_sync(&data->timer);
+       del_timer_sync(&data->timer);

        mutex_lock(&data->lock);

@@ -161,8 +167,7 @@ static ssize_t pattern_store(struct device *dev,
struct device_attribute *attr,
        struct pattern_trig_data *data = led_cdev->trigger_data;
        int ccount, cr, offset = 0, err = 0;

-       if (!led_cdev->pattern_set)
-               del_timer_sync(&data->timer);
+       del_timer_sync(&data->timer);

        mutex_lock(&data->lock);

@@ -232,9 +237,8 @@ static void pattern_trig_deactivate(struct
led_classdev *led_cdev)

        if (led_cdev->pattern_clear)
                led_cdev->pattern_clear(led_cdev);
-       else
-               del_timer_sync(&data->timer);

+       del_timer_sync(&data->timer);
        led_set_brightness(led_cdev, LED_OFF);
        kfree(data);
        led_cdev->activated = false;
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 74fc2c6..04f3eaf 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -93,6 +93,8 @@ struct led_classdev {
                           struct led_pattern *pattern, int len,
                           unsigned int repeat);
        int (*pattern_clear)(struct led_classdev *led_cdev);
+       int (*pattern_convert)(struct led_classdev *led_cdev,
+                              struct led_pattern *pattern, int *len);

        struct device           *dev;
        const struct attribute_group    **groups;
-- 
Baolin Wang
Best Regards
