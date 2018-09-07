Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79838C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FB2205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9xzXpH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FB2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeIGH1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:27:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43359 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIGH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:27:49 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so24551839oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g9AoT/1qXgt/tYW75whqAoTN6TSGgbvP+JwgRQq0p/Y=;
        b=U9xzXpH7KuTCNoddTBhmicptJW1P/g+i9ChcNwjnurrDL6alNPD5cY9eTMwmB+AgRK
         AyUQkeTfBauBAs2bNX4javS6vTjERZ4NJDpKWjVfhRdu9Rfv6VQs4qBb+xJwo4ge1HWo
         1C8oFpsIp2ce46D0SMkFcO66waoNsr5WQDHNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g9AoT/1qXgt/tYW75whqAoTN6TSGgbvP+JwgRQq0p/Y=;
        b=NrjO48xsk52Mh37zB/tyub607dNTBRHfPssjFZD0s4ACVpQaCeTLlueZ6Vu8olh8Th
         HqdYKtgkzqln2nVwJJkfx6dbeIggJNuJBZYWpXF8JX//oFNdJsE+atc5jDruOJzrB8Ne
         0NGS20uHHnf+QuqjGNCKKLRRsNdY7ZX3ZwrbxjIYN2vprBeKXCZgzCpr8oKDS0o+Mrt1
         5IzLFxH4J32Bi82T4eHP1RrmR2ieOciekMTS6JtEUMWcr6QQHLt7qRvdaY7+/snry06f
         B0MSV4fUjTOojqUuLCbqkLHZiIMLHmyqQJsWJ08IBGKn0FJlQ1Bfs30VJ85srLLKZviH
         abjw==
X-Gm-Message-State: APzg51C/x0/gXa9YT4L9GFgayYlAxgSszzlN1Bumudlz5OJedQ2ACH3c
        dbCKiR8YXmZSLZKC4QFbtrFEruAtbiUUSShR6Mz8sQ==
X-Google-Smtp-Source: ANB0VdZWv6tx9nnhg0L2sFyGR1QNqcLAxsd2nwhqUSBtowyxacTOYxxNIcldaky3Ib1SKCe+2R1GgZ3f1xYvnwzxO4I=
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr6278315oih.161.1536288554602;
 Thu, 06 Sep 2018 19:49:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 19:49:14 -0700 (PDT)
In-Reply-To: <ae29d9b4-e5f8-a00d-df74-fb20328e4634@gmail.com>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536200860.git.baolin.wang@linaro.org>
 <975a9570c75fb4469c0cef55cc9ed42266f933af.1536200860.git.baolin.wang@linaro.org>
 <ae29d9b4-e5f8-a00d-df74-fb20328e4634@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 7 Sep 2018 10:49:14 +0800
Message-ID: <CAMz4ku+7TcsQLiTPHB=8EpW7mbk5skd=TEio3HKX0WHEpWYc+g@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] leds: sc27xx: Add pattern_set/clear interfaces
 for LED controller
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 7 September 2018 at 04:16, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> Thank you for the patch. I really appreciate your effort.
>
> I see one more thing I forgot to mention in the previous
> review. Please take a look at my comment to pattern_set().
>
> On 09/06/2018 04:37 AM, Baolin Wang wrote:
>> This patch implements the 'pattern_set'and 'pattern_clear'
>> interfaces to support SC27XX LED breathing mode.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v9:
>>  - Optimize the ABI documentation file.
>>  - Update the brightness value in hardware pattern mode.
>>
>> Changes from v8:
>>  - Optimize the ABI documentation file.
>>
>> Changes from v7:
>>  - Add its own ABI documentation file.
>>
>> Changes from v6:
>>  - None.
>>
>> Changes from v5:
>>  - None.
>>
>> Changes from v4:
>>  - None.
>>
>> Changes from v3:
>>  - None.
>>
>> Changes from v2:
>>  - None.
>>
>> Changes from v1:
>>  - Remove pattern_get interface.
>> ---
>>  .../ABI/testing/sysfs-class-led-driver-sc27xx      |   22 +++++
>>  drivers/leds/leds-sc27xx-bltc.c                    |  103 ++++++++++++++++++++
>>  2 files changed, 125 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> new file mode 100644
>> index 0000000..d8056d5
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>> @@ -0,0 +1,22 @@
>> +What:                /sys/class/leds/<led>/hw_pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a hardware pattern for the SC27XX LED. For the SC27XX
>> +             LED controller, it only supports 4 stages to make a single
>> +             hardware pattern, which is used to configure the rise time,
>> +             high time, fall time and low time for the breathing mode.
>> +
>> +             For the breathing mode, the SC27XX LED only expects one brightness
>> +             for the high stage. To be compatible with the hardware pattern
>> +             format, we should set brightness as 0 for rise stage, fall
>> +             stage and low stage.
>> +
>> +             Min stage duration: 125 ms
>> +             Max stage duration: 31875 ms
>> +
>> +             Since the stage duration step is 125 ms, the duration must be
>> +             a multiplier of 125, like 125ms, 250ms, 375ms, 500ms ... 31875ms.
>> +
>> +             Thus the format of the hardware pattern values should be:
>> +             "0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
>> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
>> index 9d9b7aa..558a325 100644
>> --- a/drivers/leds/leds-sc27xx-bltc.c
>> +++ b/drivers/leds/leds-sc27xx-bltc.c
>> @@ -32,8 +32,15 @@
>>  #define SC27XX_DUTY_MASK     GENMASK(15, 0)
>>  #define SC27XX_MOD_MASK              GENMASK(7, 0)
>>
>> +#define SC27XX_CURVE_SHIFT   8
>> +#define SC27XX_CURVE_L_MASK  GENMASK(7, 0)
>> +#define SC27XX_CURVE_H_MASK  GENMASK(15, 8)
>> +
>>  #define SC27XX_LEDS_OFFSET   0x10
>>  #define SC27XX_LEDS_MAX              3
>> +#define SC27XX_LEDS_PATTERN_CNT      4
>> +/* Stage duration step, in milliseconds */
>> +#define SC27XX_LEDS_STEP     125
>>
>>  struct sc27xx_led {
>>       char name[LED_MAX_NAME_SIZE];
>> @@ -122,6 +129,98 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
>>       return err;
>>  }
>>
>> +static int sc27xx_led_pattern_clear(struct led_classdev *ldev)
>> +{
>> +     struct sc27xx_led *leds = to_sc27xx_led(ldev);
>> +     struct regmap *regmap = leds->priv->regmap;
>> +     u32 base = sc27xx_led_get_offset(leds);
>> +     u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
>> +     u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
>> +     int err;
>> +
>> +     mutex_lock(&leds->priv->lock);
>> +
>> +     /* Reset the rise, high, fall and low time to zero. */
>> +     regmap_write(regmap, base + SC27XX_LEDS_CURVE0, 0);
>> +     regmap_write(regmap, base + SC27XX_LEDS_CURVE1, 0);
>> +
>> +     err = regmap_update_bits(regmap, ctrl_base,
>> +                     (SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
>> +
>> +     ldev->brightness = LED_OFF;
>> +
>> +     mutex_unlock(&leds->priv->lock);
>> +
>> +     return err;
>> +}
>> +
>> +static int sc27xx_led_pattern_set(struct led_classdev *ldev,
>> +                               struct led_pattern *pattern,
>> +                               int len, u32 repeat)
>> +{
>> +     struct sc27xx_led *leds = to_sc27xx_led(ldev);
>> +     u32 base = sc27xx_led_get_offset(leds);
>> +     u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
>> +     u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
>> +     struct regmap *regmap = leds->priv->regmap;
>> +     int err;
>> +
>> +     /*
>> +      * Must contain 4 tuples to configure the rise time, high time, fall
>> +      * time and low time to enable the breathing mode.
>> +      */
>> +     if (len != SC27XX_LEDS_PATTERN_CNT)
>> +             return -EINVAL;
>> +
>> +     mutex_lock(&leds->priv->lock);
>
> Please add below macros at the top of the file and the function
> shown. It will allow to nicely align the value provided by
> the user to the nearest delta_t step. We have similar thing
> in led_class_flash.c (led_clamp_align()), that was adopted from
> v4l2-ctrls.c.
>
> #define SC27XX_DELTA_T_MIN SC27XX_LEDS_STEP
> #define SC27XX_DELTA_T_MAX (SC27XX_LEDS_STEP * 255)
>
> static void sc27xx_led_clamp_align_delta_t(u32 *delta_t)
> {
>         u32 v, offset, t = *delta_t;
>
>         v = t + SC27XX_LEDS_STEP / 2;
>         v = clamp(v, SC27XX_DELTA_T_MIN, SC27XX_DELTA_T_MAX);
>         offset = v - SC27XX_DELTA_T_MIN;
>         offset = SC27XX_LEDS_STEP * (offset / SC27XX_LEDS_STEP);
>         *delta_t = SC27XX_DELTA_T_MIN + offset;
> }
>
> Then call the function for each delta_t before writing it to the device:
>
> sc27xx_led_clamp_align_delta_t(&pattern[0].delta_t);
> sc27xx_led_clamp_align_delta_t(&pattern[1].delta_t);
> sc27xx_led_clamp_align_delta_t(&pattern[2].delta_t);
> sc27xx_led_clamp_align_delta_t(&pattern[3].delta_t);

That's a good point. Will add in next version.

>
> Also, regarding PATCH v8 1/2, please change the types of properties
> in struct led_pattern as follows:
>
> +struct led_pattern {
> +       u32 delta_t;
> +       enum led_brightness brightness;
> +};

Sure. Thanks for your comments.

-- 
Baolin Wang
Best Regards
