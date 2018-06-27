Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6A12634B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="SvfiE/V4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6A12634B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeF0K1s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:27:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33133 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932326AbeF0K1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:27:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id l23-v6so2774824edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zh57SoEo4eDLLVmz5F3SM20dIHo2MFKcc623E9hLygE=;
        b=SvfiE/V4i1Ea/27+dN9sGge2T2MSmdidPKy6gD9YjCiaeDTM4hz2OXhr3AKX4XqHbg
         MATWyic9tYE66MXrIUF8XTTGVNuCB3l+ibofejV4zyxhzPjv2ySwNGbNG52XzLbslcO0
         DzIaK0gMBGAyu+9vqblJ/zX5krV/mIkn3WxiAuZM4htdEdME/+Oqx/Rt5jZ8i5Gybzys
         SBqPrd7sDacMWJ34/dNdP/N+yzOT6bDL/5zsFlSw6xIV8rEqpcxGe5xNPoJ6ruUJt6GA
         gSl+51S+evrxn3Qd/cTRRvbIYjk9XxJVKskK//mlUr/BIGXe5OHHG9Lz3WssAQpQayCl
         FTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zh57SoEo4eDLLVmz5F3SM20dIHo2MFKcc623E9hLygE=;
        b=X3W/+0mqBbigsOmAfZruw2uIvntUF8+o03eRu8F9tJSESUoKA1jXX/z5uJokd/7BU+
         PsaJNUon4o9BDRZvSs81PFvp/Jy62J7rClSMngm/TNuKLwLjqCHQDjMnP+MD8kV1Tdtf
         DoCdrjgkiuxOATynoPqtoVIM0fwKd3znLVKZQYsQm+j7m65cP/ivZUWWT4S5RQrrM/5a
         lEAI+evUxmT1k/TQw06MjyZSLYCW2WNQZZcvrQRpJNNGJwh5AW2VSE32QPjREkN1n0bR
         uJdJsn2U+19DyO/Pckm2znStjX0z6kN5DxQQMwoEs5IRAB94smqhOti+F2IVNJsLWnh6
         ceQQ==
X-Gm-Message-State: APt69E2N1qoj0Nay1T2O2yDuKN21jHAGKxtUITy/ta/fgHFQMPMW0iQn
        lGX5QIbNcTCYwyyHcIhvI3V2oB0PBG+dErUYxOahQA==
X-Google-Smtp-Source: AAOMgpf2R19FPpurKTJ1/9QqodW+kPcFCenc7HcWVp5PI/RNFjGBh4qbPR86F3KX2kmM2LooTCcwWC3WaH3jLB6kONE=
X-Received: by 2002:a50:cc01:: with SMTP id m1-v6mr5150271edi.171.1530095263861;
 Wed, 27 Jun 2018 03:27:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90f9:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 03:27:43
 -0700 (PDT)
In-Reply-To: <20180620144645.2084-1-chiu@endlessm.com>
References: <20180620144645.2084-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 27 Jun 2018 18:27:43 +0800
Message-ID: <CAB4CAwdCixoGj9t=1Nvcc52kAjmcMWobKt11pRa0vNyLdeA_rg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:46 PM, Chris Chiu <chiu@endlessm.com> wrote:
> Make asus-wmi notify on hotkey kbd brightness changes, listen for
> brightness events and update the brightness directly in the driver.
> Create new do_kbd_led_set function for in-driver update, and leave
> kbd_led_set for original led_classdev call path.
>
> Update the brightness by led_classdev_notify_brightness_hw_changed.
> This will allow userspace to monitor (poll) for brightness changes
> on the LED without reporting via input keymapping.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 1f6e68f0b646..f2b9037f6ded 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -460,6 +460,7 @@ static void kbd_led_update(struct work_struct *work)
>                 ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
>
>         asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
> +       led_classdev_notify_brightness_hw_changed(&asus->kbd_led, asus->kbd_led_wk);
>  }
>
>  static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
> @@ -490,15 +491,16 @@ static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
>         return retval;
>  }
>
> -static void kbd_led_set(struct led_classdev *led_cdev,
> -                       enum led_brightness value)
> +static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
>  {
>         struct asus_wmi *asus;
> +       int max_level;
>
>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
> +       max_level = asus->kbd_led.max_brightness;
>
> -       if (value > asus->kbd_led.max_brightness)
> -               value = asus->kbd_led.max_brightness;
> +       if (value > max_level)
> +               value = max_level;
>         else if (value < 0)
>                 value = 0;
>
> @@ -506,6 +508,12 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>         queue_work(asus->led_workqueue, &asus->kbd_led_work);
>  }
>
> +static void kbd_led_set(struct led_classdev *led_cdev,
> +                       enum led_brightness value)
> +{
> +       do_kbd_led_set(led_cdev, value);
> +}
> +
>  static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
>  {
>         struct asus_wmi *asus;
> @@ -656,6 +664,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>
>                 asus->kbd_led_wk = led_val;
>                 asus->kbd_led.name = "asus::kbd_backlight";
> +               asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
>                 asus->kbd_led.brightness_set = kbd_led_set;
>                 asus->kbd_led.brightness_get = kbd_led_get;
>                 asus->kbd_led.max_brightness = 3;
> @@ -1745,6 +1754,15 @@ static void asus_wmi_notify(u32 value, void *context)
>                 }
>         }
>
> +       if (code == NOTIFY_KBD_BRTUP) {
> +               do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
> +               goto exit;
> +       }
> +       if (code == NOTIFY_KBD_BRTDWN) {
> +               do_kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
> +               goto exit;
> +       }
> +
>         if (is_display_toggle(code) &&
>             asus->driver->quirks->no_display_toggle)
>                 goto exit;
> --
> 2.11.0
>

Gentle ping. Any comment for the v3 patch?

Chris
