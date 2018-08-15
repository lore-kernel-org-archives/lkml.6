Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546152168D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="wg7WLDzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546152168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeHOMZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:25:45 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52528 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbeHOMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:25:45 -0400
Received: by mail-it0-f66.google.com with SMTP id d9-v6so1103043itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j10g/9hdmbcfbxgN4Ztv/O+25sNNyQ3QXkmXzs1A36Y=;
        b=wg7WLDzKIIfvDZ8LScq4o+txonifPVmXdSU/o9swF0n4ns1Igd19nW3ZrTwGnOYXr+
         hU0s3TNThsdcLNTEmxjaXBHUZfzwj13dSiL4ob23PWLGOM1yC4UybsrZlWlaeshe7DUR
         PK3yQJsn3XisNv/aXugrktevnU/mkVCQrQsaTUemxF1pugsuTUb3pzyZmOhIkWFd1YW7
         wTvg6S1veMvqkhWNUzSgyqzJdxZlUjoRV7MEJd4CitU3p6bvWVZLXahb9w9sDswRAuj5
         yZx+9nYoGhO0YSTGKeGf14ZvLa3pOVAWaQdugDq+NN3iy7y+kS1Euibcl+J32CF97CrZ
         W4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j10g/9hdmbcfbxgN4Ztv/O+25sNNyQ3QXkmXzs1A36Y=;
        b=pWOX+7qW8ZSCANdZuxKrPNtxxo6KSMUnDbgFnHVuzdIkvU5gQgaO+n1PZWmrqobcEP
         msRS+DCD7a6BcMzn/W72LX5ebQNuNvaVI+ZHVQ2nTMB/ug/k73lXwC1+deZUGqxJ0R5k
         QwaybCTaaG2JtzlKyqUx0c9obSf817MgdXWnAtRi+H4tck+dZw/+84qS244ngMK2q+Lo
         apq7crzOLmtJM2nLBfTDS51QCGrFohkJEq6aDvjoQSHQNsbXstrTATP+GuVoNdV/ktDI
         KCxnHsNY/cUoEniYLyAEPpJkoT7EZlBO0ZkSqLRsvbveWKM8Exk3u3GIHSSmpZqPnFIX
         JtyA==
X-Gm-Message-State: AOUpUlERm8/frIvdo5HMfNgycUf2sxdPdxsBhWcW8+BWy1Ojjd5kxvf0
        wFnaU62IylGFLrxDoYm1dtn+b+eEY7IyxvAwK0cSUQ==
X-Google-Smtp-Source: AA+uWPz6BQHT2UjA0xDpY6w9THXqqy1V35C5PvO/gbfwNUB79OfCkkhEnxtn3CzqcL9tssxzM/6vKgJ5gnHt5cK3ZxY=
X-Received: by 2002:a02:5f92:: with SMTP id x18-v6mr21407279jad.22.1534325659134;
 Wed, 15 Aug 2018 02:34:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8704:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 02:34:18
 -0700 (PDT)
In-Reply-To: <CAHp75VcvaJVuM=TL2AJaC=y5B9GRVbXO0DczfHWs+i03OJRXcw@mail.gmail.com>
References: <20180620144645.2084-1-chiu@endlessm.com> <CAB4CAwdCixoGj9t=1Nvcc52kAjmcMWobKt11pRa0vNyLdeA_rg@mail.gmail.com>
 <CAHp75VcvaJVuM=TL2AJaC=y5B9GRVbXO0DczfHWs+i03OJRXcw@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 15 Aug 2018 17:34:18 +0800
Message-ID: <CAB4CAwedViX=U0DJNsZeUhJinQ1UBQ3KVTuhRJO7ni-xvqbJ3Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 8:10 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 27, 2018 at 1:27 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> On Wed, Jun 20, 2018 at 10:46 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>> Make asus-wmi notify on hotkey kbd brightness changes, listen for
>>> brightness events and update the brightness directly in the driver.
>>> Create new do_kbd_led_set function for in-driver update, and leave
>>> kbd_led_set for original led_classdev call path.
>>>
>>> Update the brightness by led_classdev_notify_brightness_hw_changed.
>>> This will allow userspace to monitor (poll) for brightness changes
>>> on the LED without reporting via input keymapping.
>
> LGTM, I'm about to push it to my review and testing queue, so, we will
> have 1 day or so time to gather objections if any.
> Thanks!
>

Gentle ping. How's the review so far? Maybe need more time for more info?

Chris

>>>
>>> Signed-off-by: Chris Chiu <chiu@endlessm.com>
>>> ---
>>>  drivers/platform/x86/asus-wmi.c | 26 ++++++++++++++++++++++----
>>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>> index 1f6e68f0b646..f2b9037f6ded 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -460,6 +460,7 @@ static void kbd_led_update(struct work_struct *work)
>>>                 ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
>>>
>>>         asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
>>> +       led_classdev_notify_brightness_hw_changed(&asus->kbd_led, asus->kbd_led_wk);
>>>  }
>>>
>>>  static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
>>> @@ -490,15 +491,16 @@ static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
>>>         return retval;
>>>  }
>>>
>>> -static void kbd_led_set(struct led_classdev *led_cdev,
>>> -                       enum led_brightness value)
>>> +static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
>>>  {
>>>         struct asus_wmi *asus;
>>> +       int max_level;
>>>
>>>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>>> +       max_level = asus->kbd_led.max_brightness;
>>>
>>> -       if (value > asus->kbd_led.max_brightness)
>>> -               value = asus->kbd_led.max_brightness;
>>> +       if (value > max_level)
>>> +               value = max_level;
>>>         else if (value < 0)
>>>                 value = 0;
>>>
>>> @@ -506,6 +508,12 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>>>         queue_work(asus->led_workqueue, &asus->kbd_led_work);
>>>  }
>>>
>>> +static void kbd_led_set(struct led_classdev *led_cdev,
>>> +                       enum led_brightness value)
>>> +{
>>> +       do_kbd_led_set(led_cdev, value);
>>> +}
>>> +
>>>  static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
>>>  {
>>>         struct asus_wmi *asus;
>>> @@ -656,6 +664,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>>>
>>>                 asus->kbd_led_wk = led_val;
>>>                 asus->kbd_led.name = "asus::kbd_backlight";
>>> +               asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
>>>                 asus->kbd_led.brightness_set = kbd_led_set;
>>>                 asus->kbd_led.brightness_get = kbd_led_get;
>>>                 asus->kbd_led.max_brightness = 3;
>>> @@ -1745,6 +1754,15 @@ static void asus_wmi_notify(u32 value, void *context)
>>>                 }
>>>         }
>>>
>>> +       if (code == NOTIFY_KBD_BRTUP) {
>>> +               do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
>>> +               goto exit;
>>> +       }
>>> +       if (code == NOTIFY_KBD_BRTDWN) {
>>> +               do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
>>> +               goto exit;
>>> +       }
>>> +
>>>         if (is_display_toggle(code) &&
>>>             asus->driver->quirks->no_display_toggle)
>>>                 goto exit;
>>> --
>>> 2.11.0
>>>
>>
>> Gentle ping. Any comment for the v3 patch?
>>
>> Chris
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
