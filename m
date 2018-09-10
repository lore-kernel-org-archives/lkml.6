Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FBE20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="kmt+dXZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FBE20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeIJNuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:50:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37517 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:50:37 -0400
Received: by mail-io0-f196.google.com with SMTP id v14-v6so25608iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rrfeNYp+2eIrdw1VqVxMpvx/wDqLws+CBQwiZXUyasA=;
        b=kmt+dXZpsjYEEX4juMoDRsw1CNACjd2J+CdRXG6dwwcjHVlfoogo3dGVpLLaxx7SBP
         7A3MORTsQrXHwIanXrUiNpwUk6zBhRQChDHJxYYDbteqU5zvwbH6kJ/baFZZfW+BqnRR
         idCA1DUpYalmjTvhQ0qbJW0VRC+hYelapQW2RgN2wDnwnZ4YMTd6YF5PL+oc1F0+Gboc
         FdT7a/79jiSIBsWs4qRDfyXHacZhlzSfWV+EAOwI2LLT48f+6EgyhqD6+sa8LNKiL2NX
         xVuaJjIPMCNAhZQ038Yoni9sh9Pc/pxHDeh52xNRbZ9cCUEHYQtMLDZ1jzAwtNFKfoFI
         l/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rrfeNYp+2eIrdw1VqVxMpvx/wDqLws+CBQwiZXUyasA=;
        b=f5ePCElvNc5ebv0PlwDEbBH9G0y618p8/xPk3fmirBFF0RlyeMLB0ToTyOybqIASIN
         WizRPOEFSMnebJnOPT+FobFr/hTO4cBYFjpFVIiRAY/88I4QPIJrdvNat1fruE+RNy67
         rwBVlsnM7dUSRLHZAnD0Jzd0G/MmG4ZExiMLgupDxQ1Hkutv8mwiNlNQwyCJVMv1E3jy
         BY+n6zGwnJxXK2t0mhGbtkmDtkdgJn2VmWG9KWPmqQxlhz1IOR7a4Kb10xjqaMc1B1lr
         Ga1GZvR33RwWAgCANOVMVkKm+uqatUjHC0EnAaWty+aVBOSv5OPX6ym3vaxIAtpeJn37
         6Tmw==
X-Gm-Message-State: APzg51BBPv8plixYZz+VhX952RnXJ89z0mB5yQsqtKhu9y1M5OyKOa8+
        6nvt37CB80Bpmeh6BvYebR7JUghNdcCjvFYR9KUU5w==
X-Google-Smtp-Source: ANB0VdaV0Da4OiuNE6LaN30HGHPrvUncehCV/yccTtIuMrSY/OXDxVInl4s3JYWC6IRikvnibaaWcT+1l0hq1VoFqhc=
X-Received: by 2002:a5e:c10b:: with SMTP id v11-v6mr15665548iol.262.1536569856155;
 Mon, 10 Sep 2018 01:57:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:1505:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 01:56:55
 -0700 (PDT)
In-Reply-To: <20180816084104.434-1-jian-hong@endlessm.com>
References: <20180816084104.434-1-jian-hong@endlessm.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Mon, 10 Sep 2018 16:56:55 +0800
Message-ID: <CAPpJ_eeK68jvMQ02hR2i+eP8Xo9YyWWUGYqG7e6dsWP=XTTCyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] platform/x86: asus-wmi: Simplify the keyboard
 brightness updating process
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-16 16:41 GMT+08:00 Jian-Hong Pan <jian-hong@endlessm.com>:
> The original asus-wmi queues a work which calls the ACPI/WMI methods to
> update the keyboard LED brightness.  Similar drivers - acer-wmi,
> dell-wmi-led just call the ACPI/WMI methods directly without workqueues.
>
> This patch simplifies the keyboard brightness updating process which
> calls the kbd_led_update function directly without workqueue in
> asus-wmi.
>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 34dcc1aac4ea..d3d500851a7a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -239,7 +239,6 @@ struct asus_wmi {
>         int lightbar_led_wk;
>         struct workqueue_struct *led_workqueue;
>         struct work_struct tpd_led_work;
> -       struct work_struct kbd_led_work;
>         struct work_struct wlan_led_work;
>         struct work_struct lightbar_led_work;
>
> @@ -456,12 +455,9 @@ static enum led_brightness tpd_led_get(struct led_classdev *led_cdev)
>         return read_tpd_led_state(asus);
>  }
>
> -static void kbd_led_update(struct work_struct *work)
> +static void kbd_led_update(struct asus_wmi *asus)
>  {
>         int ctrl_param = 0;
> -       struct asus_wmi *asus;
> -
> -       asus = container_of(work, struct asus_wmi, kbd_led_work);
>
>         /*
>          * bits 0-2: level
> @@ -516,7 +512,7 @@ static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
>                 value = 0;
>
>         asus->kbd_led_wk = value;
> -       queue_work(asus->led_workqueue, &asus->kbd_led_work);
> +       kbd_led_update(asus);
>  }
>
>  static void kbd_led_set(struct led_classdev *led_cdev,
> @@ -671,8 +667,6 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>
>         led_val = kbd_led_read(asus, NULL, NULL);
>         if (led_val >= 0) {
> -               INIT_WORK(&asus->kbd_led_work, kbd_led_update);
> -
>                 asus->kbd_led_wk = led_val;
>                 asus->kbd_led.name = "asus::kbd_backlight";
>                 asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
> @@ -2314,7 +2308,7 @@ static int asus_hotk_resume(struct device *device)
>         struct asus_wmi *asus = dev_get_drvdata(device);
>
>         if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
> -               queue_work(asus->led_workqueue, &asus->kbd_led_work);
> +               kbd_led_update(asus);
>
>         return 0;
>  }
> @@ -2350,7 +2344,7 @@ static int asus_hotk_restore(struct device *device)
>                 rfkill_set_sw_state(asus->uwb.rfkill, bl);
>         }
>         if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
> -               queue_work(asus->led_workqueue, &asus->kbd_led_work);
> +               kbd_led_update(asus);
>
>         return 0;
>  }
> --
> 2.11.0
>

Just gentle ping.  Any comment for this patch?

Regards,
Jian-Hong Pan
