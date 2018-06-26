Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A48C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A6E2650D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwoG22tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A6E2650D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeFZFIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:08:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39900 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeFZFIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:08:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id 18-v6so5264143oiq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 22:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8uIr3Oh/NSxGyYB+8z2Pu8rXkyWRCewAveDkujPCgFY=;
        b=AwoG22tzUsKxEw/NIyfsHzRoGS8kN6mRrQDtb7wmpkiBhjdF5rkdW8KCVD/fKioNNE
         6i7JQpbP1RpBqOlE/6hcYarQwO7YABDaXtu8bpET9i6MFWdZXgSvWaO2CemXVoGkG7OX
         noU5EAQaXPUiE2Zv+hGY3BPDRSAKbSguWX0cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8uIr3Oh/NSxGyYB+8z2Pu8rXkyWRCewAveDkujPCgFY=;
        b=tkAA+6kL1aZkyQH8AidDK3JynnvuqkF6T4vlEPu8klvQNGxHscl2mmTsg9jNWewPa8
         qa+iIzsnPc3YFG3m3B9MyLGmEJerPFFeyxfrEfBe5DFVxpy5d4wgpCFPC1eziYKK1/jp
         j67C3jLy7XGa8EUCF3ygvZ4Y9t1y3gOA+0IsAhXhiws11WZQNlWe8TGSkmpXmT/7Z4cQ
         axQRvwEeAVfeBTsAdAx2kSGGC5iac9+tsZ88imoacd4pCULgu6a7teQtzD/LT9Sob/76
         xD2T+6Zg45VcQNn7gPY4YhIzvdKSJfc2HSyz4oBlfEF13/oWiEAm3EUbHh7OTezQbvbj
         V7KQ==
X-Gm-Message-State: APt69E1O9kDnDJ2zjzwFYKSZl45iVRCdyBFXPT3DEqpbLBujc3ZMijyp
        q4/EjMu0PpqPNFC7RwBNLIC+UlmXSYwqvdvla2Bo2Q==
X-Google-Smtp-Source: ADUXVKLzUEcswsDUEYIgDLMF3ae44V+LZv+dvJmDowUl7U9B2VBhkVcxFG5+garc2Iv8PhUHZeG0AA7LXjMqQLNLdqM=
X-Received: by 2002:aca:686:: with SMTP id 128-v6mr8830725oig.31.1529989683958;
 Mon, 25 Jun 2018 22:08:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 22:08:03
 -0700 (PDT)
In-Reply-To: <20180625121845.GA32505@amd>
References: <046c0cf717cbdfd55dcdc2bb7463642734e2ca4c.1529902636.git.baolin.wang@linaro.org>
 <20180625121845.GA32505@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 26 Jun 2018 13:08:03 +0800
Message-ID: <CAMz4kuKiMrE-z9D3gsSqJU9zCdGz-gakLeSWSLWOL2efTgm-1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-leds@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 25 June 2018 at 20:18, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-06-25 13:03:19, Baolin Wang wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> Some LED controllers have support for autonomously controlling
>> brightness over time, according to some preprogrammed pattern or
>> function.
>>
>> This adds a new optional operator that LED class drivers can implement
>> if they support such functionality as well as a new device attribute to
>> configure the pattern for a given LED.
>
> Thanks for doing this!
>
>> index 5f67f7a..fe90a12 100644
>> --- a/Documentation/ABI/testing/sysfs-class-led
>> +++ b/Documentation/ABI/testing/sysfs-class-led
>> @@ -61,3 +61,19 @@ Description:
>>               gpio and backlight triggers. In case of the backlight trigger,
>>               it is useful when driving a LED which is intended to indicate
>>               a device in a standby like state.
>> +
>> +What: /sys/class/leds/<led>/pattern
>> +Date: June 2018
>> +KernelVersion: 4.18
>> +Description:
>> +     Specify a pattern for the LED, for LED hardware that support
>> +     altering the brightness as a function of time.
>> +
>> +     The pattern is given by a series of tuples, of brightness and
>> +     duration (ms). The LED is expected to traverse the series and
>> +     each brightness value for the specified duration.
>> +
>> +     As LED hardware might have different capabilities and precision
>> +     the requested pattern might be slighly adjusted by the driver
>> +     and the resulting pattern of such operation should be returned
>> +     when this file is read.
>
> I'd add "Duration of 0 means brightness should immediately change to
> new value."

Sure.

>
>> +     struct led_classdev *led_cdev = dev_get_drvdata(dev);
>> +     struct led_pattern *pattern = NULL;
>> +     unsigned long val;
>> +     char *sbegin;
>> +     char *elem;
>> +     char *s;
>> +     int ret, len = 0;
>> +     bool odd = true;
>> +
>> +     s = sbegin = kstrndup(buf, size, GFP_KERNEL);
>> +     if (!s)
>> +             return -ENOMEM;
>> +
>> +     /* Trim trailing newline */
>> +     s[strcspn(s, "\n")] = '\0';
>
> Is substring function best to use here? Will it do the right thing
> when \n is not present?

We always have a '\n' to present the end of the string passed from
userspace. Or anything I missed here?

>
>> +     /* If the remaining string is empty, clear the pattern */
>> +     if (!s[0]) {
>> +             ret = led_cdev->pattern_clear(led_cdev);
>> +             goto out;
>> +     }
>> +
>> +     pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
>> +     if (!pattern) {
>> +             ret = -ENOMEM;
>> +             goto out;
>> +     }
>> +
>> +     /* Parse out the brightness & delta_t touples and check for repeat */
>> +     while ((elem = strsep(&s, " ")) != NULL) {
>> +             ret = kstrtoul(elem, 10, &val);
>> +             if (ret)
>> +                     goto out;
>> +
>> +             if (odd) {
>> +                     pattern[len].brightness = val;
>> +             } else {
>> +                     /* Ensure we don't have any delta_t == 0 */
>> +                     if (!val) {
>> +                             ret = -EINVAL;
>> +                             goto out;
>> +                     }
>
> I believe we should support delta_t of 0 for "change immediately".

OK. Thanks for your comments.

-- 
Baolin Wang
Best Regards
