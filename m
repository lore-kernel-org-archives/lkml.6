Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9FFF4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE44204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="DMnBqjBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE44204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935467AbeFMMOR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:14:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38800 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935286AbeFMMOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:14:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so4950719wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5PSUW48DG3tdOwbaOvo1OrlourPZ9dCtz9b/PTwpPbY=;
        b=DMnBqjBI0dhDR3hf9/WxVtILStimnKuKK7vcln8rNTcMJF6Zx3C2j7itCz10Zr89A9
         Lehs1uDya5PnCsVPDBRHt14EoL7TciK+Skc73C/h99SwtJEVDQo4cX9FYzrP7//KELft
         v5mt+kN7kinUveF+3GxkScPk/64QsNsqzUq9Tf5EGtOk0j/pB9ppyrGvTu+zRVZnRE79
         4JflLBHezHqcq8oOu8M+DoEIfNrLMBfqDLOH+xb/LMt7lnjaucJq6xrbwVeXhk6Z7edc
         NynWsMzSyxLxh9sH//R5OR7miDc+awv2tq+tk2wgwhfLyi5WhT56CGzqpmp9tF+Dryt7
         CNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5PSUW48DG3tdOwbaOvo1OrlourPZ9dCtz9b/PTwpPbY=;
        b=cHEyL7QaCNmmMrJlzyvpfb79iur/uPdbAQhzxgQQOsTOymRv2/34qtNy1rUCz0qiuy
         8p0U60e2lmE+mzP3aOS2IzvUsTF1Ynqn+bXvZlCuB9IVR3QK6c+RCdx2Rhrv0DbSSCqt
         UblslG7GTJ5ntdyARlfa9T2wGjQUtgw3GaLA7nf+pwytMz3jr13jNd8NfNpe4VUv1sIE
         vn8+eM4ENP8NvMNTofSOBE4aCj79Twrpyn9q4p466fTbhEBpXQ9vEnJ6/9d9Tf9JlMGu
         DCxRExabo/4QGRJcPO4n4zz7AMVnrdmnjQ1huCZUtLJRzOFzUg2lIY54v2EZEqzXHiK6
         WHOg==
X-Gm-Message-State: APt69E3BlSuAAWYUTPVak5bf7uKpEmQ9vr2nwurvKCl62LuVRZTWlKKf
        EK9KPqERcxoP6GbK5CSlezz4RZYISPfKvOhj6s/eqA==
X-Google-Smtp-Source: ADUXVKI30bFFg75i0NO1zFa4JRsOhlSNsovSReOqh8ywZakFwez8EpWgd6NysAtzV95on2Mkw162C7xmFEuFFvlIS/g=
X-Received: by 2002:a50:90cb:: with SMTP id d11-v6mr3872736eda.54.1528892054261;
 Wed, 13 Jun 2018 05:14:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90d3:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 05:14:13
 -0700 (PDT)
In-Reply-To: <20180611071838.47945-1-chiu@endlessm.com>
References: <20180611071838.47945-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 13 Jun 2018 20:14:13 +0800
Message-ID: <CAB4CAweUHcKY0+dGhoBNd8VqLc=XYbU_a8qpzHX6us4vVBE-KA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Call led hw_changed API on
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

On Mon, Jun 11, 2018 at 3:18 PM, Chris Chiu <chiu@endlessm.com> wrote:
> Make asus-wmi notify on hotkey kbd brightness changes, listen for
> brightness events and update the brightness directly in the driver.
> For this purpose, bound check on brightness in kbd_led_set must be
> based on the same data type to prevent illegal value been set.
>
> Update the brightness by led_classdev_notify_brightness_hw_changed.
> This will allow userspace to monitor (poll) for brightness changes
> on the LED without reporting via input keymapping.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 1f6e68f0b646..a18484f4bae3 100644
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
> @@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>
>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>
> -       if (value > asus->kbd_led.max_brightness)
> +       if ((int)value > (int)asus->kbd_led.max_brightness)
>                 value = asus->kbd_led.max_brightness;
> -       else if (value < 0)
> +       else if ((int)value < 0)
>                 value = 0;
>
>         asus->kbd_led_wk = value;
> @@ -656,6 +657,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>
>                 asus->kbd_led_wk = led_val;
>                 asus->kbd_led.name = "asus::kbd_backlight";
> +               asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
>                 asus->kbd_led.brightness_set = kbd_led_set;
>                 asus->kbd_led.brightness_get = kbd_led_get;
>                 asus->kbd_led.max_brightness = 3;
> @@ -1745,6 +1747,15 @@ static void asus_wmi_notify(u32 value, void *context)
>                 }
>         }
>
> +       if (code == NOTIFY_KBD_BRTUP) {
> +               kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
> +               goto exit;
> +       }
> +       if (code == NOTIFY_KBD_BRTDWN) {
> +               kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
> +               goto exit;
> +       }
> +
>         if (is_display_toggle(code) &&
>             asus->driver->quirks->no_display_toggle)
>                 goto exit;
> --
> 2.11.0
>

Gentle ping. Any suggestions? The v2 is based on the last comment from
Hans, https://lkml.org/lkml/2018/6/5/270. Please let me know if nay. Thanks

Chris
