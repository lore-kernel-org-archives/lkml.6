Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B309C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCFE20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="vCGhr+es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCFE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932154AbeFTOku (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:40:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55339 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeFTOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:40:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so124433wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CoCKF8/l3eBYISpKMZqIhCFDbIm0itKWNi9qmfcFMBY=;
        b=vCGhr+esT32LhKhpDxaPO8Vh5kmblk7nuPlO4hUuVBf1SHwfwJKjGFT5toIH7t+5eX
         /K1+11zDuktdUH3SDKN5e/TIvlc8IMtTEypoboft0muuanObeJ/2YmysNzT2jravGy/Z
         l/pC9gbieBm8sgPSLafgeud/kSeRdqG7JUN8ZSoY+7Crl6B3A0MR8/emDbZcDw0+0M98
         8ZGNY1iqMe/fQQHYhSANRfPbsFfxLRsctLDk7EHdAg/90L+oEzugQc2TG34No1NQcLaU
         i1OYisK2DyZ0n2bEzmvlj3Cv+fQIwS91+Y72H8lV4joAqUL8y9zm3gr+hRH20wo590UI
         IVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CoCKF8/l3eBYISpKMZqIhCFDbIm0itKWNi9qmfcFMBY=;
        b=W9D4oVq7a3djp4mIeElHcxC2lugUv1BG3qMji2ym1M34MTTu5TDMjqy3HqsyT7IuGK
         lspPWJDbq9CnkL4dNT3rr7u0pJ0fPYysfZUKOsxC+Bj50anjYI/Gj0MjgO31nWx69jBi
         aFicccgJhHYZ1JhaJu12tR3xZnpkjGXrOQZpTirEzxQfVmJKD1YykT0A0jHapQ0VGpf4
         6RNQIBFb32AHaXvASHsagh2ZD509km04K+c78sdfgURhT3ISzigApkenOYcf2yO5IH2H
         tL1mAoaNf7CSBXt03jQvMs5c7M6+reFNZki7Uco3ahXanK7DdMKeBusy1b0jYO+76nwf
         RrTA==
X-Gm-Message-State: APt69E2C3PLKkVXwBBzYl+T9Yj0FnCDW7meShRpBoYlswxHx7FPUi2pY
        oAZOqMEtEX7EPmSLQHb3SP3zElxQ7pDqR5oko45gY2XJ
X-Google-Smtp-Source: ADUXVKL8nk23Sf3wn1Yt97G2ruCXeey3WWrwIBCIW9FuBs9o35fRUyKobNeHhroemyib6UOo5W8roWBFYypFf9ku1+A=
X-Received: by 2002:a50:f4ba:: with SMTP id s55-v6mr18558115edm.262.1529505647125;
 Wed, 20 Jun 2018 07:40:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90d3:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 07:40:46
 -0700 (PDT)
In-Reply-To: <CAD8Lp4596OLxc9sw=DwAZ_nHLEOt686xxatqCmSpV0eEWwigjQ@mail.gmail.com>
References: <20180611071838.47945-1-chiu@endlessm.com> <CAHp75VdfUO9rS-=nn+Ffe8bMEbCO-0xe8QBVqsJAZVFTMYkNxg@mail.gmail.com>
 <CAB4CAwdKJiuEiV1CtoyYTZTatRt73BQbRX5kyEtpqNj8STj5-w@mail.gmail.com> <CAD8Lp4596OLxc9sw=DwAZ_nHLEOt686xxatqCmSpV0eEWwigjQ@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 20 Jun 2018 22:40:46 +0800
Message-ID: <CAB4CAwd0TSvMdFpuPqyAMwViA=6NcLvo9=rwkF-Mf=zz5si0RQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Daniel Drake <drake@endlessm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:46 AM, Daniel Drake <drake@endlessm.com> wrote:
> Hi,
>
> On Thu, Jun 14, 2018 at 1:58 AM, Chris Chiu <chiu@endlessm.com> wrote:
>>
>> On Wed, Jun 13, 2018 at 8:49 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>> > On Mon, Jun 11, 2018 at 10:18 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> >> Make asus-wmi notify on hotkey kbd brightness changes, listen for
>> >> brightness events and update the brightness directly in the driver.
>> >
>> >> For this purpose, bound check on brightness in kbd_led_set must be
>> >> based on the same data type to prevent illegal value been set.
>> >
>> >> @@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>> >>
>> >>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>> >>
>> >> -       if (value > asus->kbd_led.max_brightness)
>> >> +       if ((int)value > (int)asus->kbd_led.max_brightness)
>> >>                 value = asus->kbd_led.max_brightness;
>> >> -       else if (value < 0)
>> >> +       else if ((int)value < 0)
>> >>                 value = 0;
>> >
>> > I didn't quite understand this part of the problem.
>> > Does it exist in the current code? Can it be split to a separate change?
>> >
>> > Can we avoid those ugly castings?
>> >
>>
>> I'd like to remove the ugly castings but there's a concern I may need some
>> advices. I don't know whether if the bound check logic ever verified before.
>> Maybe the value passed via sysfs is already correctly bounded?
>
> The casts come from the underlying need to limit the minumum and
> maximum brightness within available bounds, plus difficulties doing
> that when you are dealing with an enum data type.
>
> kbd_led_set is a function pointer (from led_classdev.brightness_set)
> which has this definition:
>
> void (*brightness_set)(struct led_classdev *led_cdev, enum
> led_brightness brightness);
>
> It seems that the compiler has the choice of whether to use a signed
> or unsigned type for enums. According to your tests, and a quick test
> app below, it seems like gcc is using unsigned.
>
>   #include <stdio.h>
>   enum led_brightness { LED_OFF = 0 };
>   int main(void) {
>     enum led_brightness tmp = -1;
>     if (tmp < 0)
>       printf("less than zero\n");
>     else
>       printf("gt zero\n");
>   }
>
> This test app prints "gt zero"
>
> led-class.c:brightness_store() uses kstrtoul() so there is no chance
> of passing a negative value through this codepath, as you suspected.
> But we do need to do something with negative bounds for the code that
> you are adding here.
>
> I suggest doing it like this:
>
> static void __kbd_led_set(struct led_classdev *led_cdev, int value)
> {
>     struct asus_wmi *asus;
>
>     asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>
>     if (value > asus->kbd_led.max_brightness)
>         value = asus->kbd_led.max_brightness;

The `value > asus->kbd_led.max_brightness` will still return false here.
So I would modify as follows in v3.
    int max_level = asus->kbd_led.max_brightness;

    if (value > max_level)
        value = max_level;

I've verified there's no regression on led_classdev call path via sysfs.

>     else if (value < 0)
>         value = 0;
>
>     asus->kbd_led_wk = value;
>     queue_work(asus->led_workqueue, &asus->kbd_led_work);
> }
>
> static void kbd_led_set(struct led_classdev *led_cdev,
>             enum led_brightness value)
> {
>     return __kbd_led_set(led_cdev, value);
> }
>
> Now kbd_led_set can continue being a correctly typed function pointer
> for led_classdev.brightness_set. And from the code you are adding here
> you can call __kbd_led_set directly with signed integer values, and
> rely on correct bounds correction without ugly casts.
>
> Andy, what do you think?
>
> Thanks
> Daniel
