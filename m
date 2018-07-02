Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F3BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD60253D5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9iD5CdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD60253D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeGBMKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:10:06 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43873 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeGBMKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:10:01 -0400
Received: by mail-ua0-f194.google.com with SMTP id x24-v6so3192789ual.10;
        Mon, 02 Jul 2018 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X5ktp69V0SFX6yCr+y5QP6PCip4Qh7LWmQ6lpgq1vgU=;
        b=U9iD5CdCym7e/+QRKyi2YdGEYY6OD9uFTAMzSNtsZNSWKtzvYt237kWAg0ytCYNClA
         1fC2m24tnLMtcLSy8zwB2XGU+QJey+XUCB57Gp3FB3MvKi+2+wVvtbGH5tVxInvbzT8D
         MPXDoo+xUF0AL6rYQ/Vhv/ZlMz52zpbmeq0tM8Xz0C4n7Iu3S47pWkWE1i6RS5h/8M0m
         QS0902rIYaplWZ0Nr5Ht6w/2vklUI85MijOOtsq/+tH2uykuCCn3GzOKSmYe7pYJKwWU
         vQRfQ1KDaoAOfbQiYuxJEJYbUk7u06dEY6DIJqlHpiSrbw6C6r712B3OWA2HdQf+rdGf
         iNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X5ktp69V0SFX6yCr+y5QP6PCip4Qh7LWmQ6lpgq1vgU=;
        b=riQe1Xb0qpoNP44wM5OS0b7ZxAjFAXxoABkpJlyryAHuiusQuA16k0d0JcJEyHN1Xw
         aA21eFE9mVMXO6/VqwU/8ysJ0FoByMM55JK1iE/YreuaBLlpFWLHu5IyWqJJ0ukD0u8A
         yS4LPa+GhwLJFxMICgskDSogFDqrjSBQYiBLl/sgF3DnzQajclX8m2DNM69XEPmrh3QC
         jNYl0QpchCJSKfF/Wh5sj3jgS4PGzrLrWQWx20cA6QomQ0AF/PP2ya8wIjV3Ef/ftFwL
         OTF95scpbNpGCEXhP49Q5mQpNwn623hM4vjwq0npt1QDZpZ/W0jMOuy3PyvnSASIrNAe
         5a0g==
X-Gm-Message-State: APt69E3xskmcTbb8IIZQb7DOuS/3kcTvlQSwti+qxPdmfgy8YI6EnPv0
        vsganQkxp2gYYYOImwsWaAAKb3m7WoAwCt8OAj0=
X-Google-Smtp-Source: AAOMgpcWmpg0R5ayTzBgpvYxSMl/4U1TFUteLLLlKRCVGCCXhC/NEfQN9I4uaqXyPqlLoLPcxrfLZ95mgDOBc9UyQAU=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr7374512ual.141.1530533400905;
 Mon, 02 Jul 2018 05:10:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 05:10:00 -0700 (PDT)
In-Reply-To: <CAB4CAwdCixoGj9t=1Nvcc52kAjmcMWobKt11pRa0vNyLdeA_rg@mail.gmail.com>
References: <20180620144645.2084-1-chiu@endlessm.com> <CAB4CAwdCixoGj9t=1Nvcc52kAjmcMWobKt11pRa0vNyLdeA_rg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 15:10:00 +0300
Message-ID: <CAHp75VcvaJVuM=TL2AJaC=y5B9GRVbXO0DczfHWs+i03OJRXcw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Chris Chiu <chiu@endlessm.com>
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

On Wed, Jun 27, 2018 at 1:27 PM, Chris Chiu <chiu@endlessm.com> wrote:
> On Wed, Jun 20, 2018 at 10:46 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> Make asus-wmi notify on hotkey kbd brightness changes, listen for
>> brightness events and update the brightness directly in the driver.
>> Create new do_kbd_led_set function for in-driver update, and leave
>> kbd_led_set for original led_classdev call path.
>>
>> Update the brightness by led_classdev_notify_brightness_hw_changed.
>> This will allow userspace to monitor (poll) for brightness changes
>> on the LED without reporting via input keymapping.

LGTM, I'm about to push it to my review and testing queue, so, we will
have 1 day or so time to gather objections if any.
Thanks!

>>
>> Signed-off-by: Chris Chiu <chiu@endlessm.com>
>> ---
>>  drivers/platform/x86/asus-wmi.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 1f6e68f0b646..f2b9037f6ded 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -460,6 +460,7 @@ static void kbd_led_update(struct work_struct *work)
>>                 ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
>>
>>         asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
>> +       led_classdev_notify_brightness_hw_changed(&asus->kbd_led, asus->kbd_led_wk);
>>  }
>>
>>  static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
>> @@ -490,15 +491,16 @@ static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
>>         return retval;
>>  }
>>
>> -static void kbd_led_set(struct led_classdev *led_cdev,
>> -                       enum led_brightness value)
>> +static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
>>  {
>>         struct asus_wmi *asus;
>> +       int max_level;
>>
>>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>> +       max_level = asus->kbd_led.max_brightness;
>>
>> -       if (value > asus->kbd_led.max_brightness)
>> -               value = asus->kbd_led.max_brightness;
>> +       if (value > max_level)
>> +               value = max_level;
>>         else if (value < 0)
>>                 value = 0;
>>
>> @@ -506,6 +508,12 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>>         queue_work(asus->led_workqueue, &asus->kbd_led_work);
>>  }
>>
>> +static void kbd_led_set(struct led_classdev *led_cdev,
>> +                       enum led_brightness value)
>> +{
>> +       do_kbd_led_set(led_cdev, value);
>> +}
>> +
>>  static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
>>  {
>>         struct asus_wmi *asus;
>> @@ -656,6 +664,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>>
>>                 asus->kbd_led_wk = led_val;
>>                 asus->kbd_led.name = "asus::kbd_backlight";
>> +               asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
>>                 asus->kbd_led.brightness_set = kbd_led_set;
>>                 asus->kbd_led.brightness_get = kbd_led_get;
>>                 asus->kbd_led.max_brightness = 3;
>> @@ -1745,6 +1754,15 @@ static void asus_wmi_notify(u32 value, void *context)
>>                 }
>>         }
>>
>> +       if (code == NOTIFY_KBD_BRTUP) {
>> +               do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
>> +               goto exit;
>> +       }
>> +       if (code == NOTIFY_KBD_BRTDWN) {
>> +               do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
>> +               goto exit;
>> +       }
>> +
>>         if (is_display_toggle(code) &&
>>             asus->driver->quirks->no_display_toggle)
>>                 goto exit;
>> --
>> 2.11.0
>>
>
> Gentle ping. Any comment for the v3 patch?
>
> Chris



-- 
With Best Regards,
Andy Shevchenko
