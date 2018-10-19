Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6048ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AD621479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWesi3Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AD621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJST4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:56:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40806 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJST4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:56:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id b4-v6so37846118qtc.7;
        Fri, 19 Oct 2018 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OYeKVybDJxpBWjokZ6ezZUIG4m6mBvzEAu4w17rNTQ=;
        b=HWesi3Qyz3oo4B2gsr2QE6Lzmbf7A0KV50XMarG8txiFtLA+gtKRbB6crjtt2zsrTJ
         FK3Zk5O0bxeRQcJsf9Fjcc9aVF/gHAVK0AoUwdhlNpbynhpuFTlkVL2i0TxRyhA2MOij
         uomL+/nuq/TXNG9ug5gq2YPQTX/PxX/qDfMmLvfTI45WRWgx9ZcxfzajUu/BboqB0MaP
         vtgheEr3PvMUwaWAAGwT+QDbRvsxnCI/PzcBdMrhL4NbZrXMEMi3G3NgHowxaSIGG5ia
         6LKkiY8d4LAKGWV7L9MF3Hc+4RBPLh4+FjKV9DGZGDcDlvfxKIyDyoZhJ+GXIbHldObE
         mtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OYeKVybDJxpBWjokZ6ezZUIG4m6mBvzEAu4w17rNTQ=;
        b=Jzh2/j+CR0azTZtSvlAjxiyJcWwTEzJG8U37cKlY9EeThJjvbko7kQgGlDNDzp6MCT
         6b7htyPM/3U0v1onCIwjP9Adp2soKCu38riiL1H+6SpF8nLsBlQ2zi0duvyNXNqyGBxP
         lwK5GNlyV8eV1LtKqvaxtyzOQrr1UG4waI3RJ8HYwFTNMGhywYnS4ZVG99PoQNa3eQ50
         25wl5w0Y4SaFf4gxCjCn/h1eMEgjbuUYVwpqamzA09uSdkZAZk32Euxm+txBbbEMcoHk
         fD4000yPTUt61/WpQKfM2yiNR+1glaOXnIq+8m1YjXnxVj59qbxxdQyFkOid0Pa7AwW5
         LdMQ==
X-Gm-Message-State: ABuFfojSG1/05HgL20MB61ynCmPrfux1viGxzNiFp1qTR8xAY5bw/4gU
        cOOuWgEa4SY1WUIXJ3mRhXJ60450epB+rLaq0zM=
X-Google-Smtp-Source: ACcGV610AZzRsoysgJjN4NzN7hreVg9Llzt2vB/fSl5SQzUvo6u5TfYGw86E1EuVkV2WubNGy2Srr3QZ6qDM2SCbFv8=
X-Received: by 2002:a0c:819c:: with SMTP id 28mr34737302qvd.7.1539949847632;
 Fri, 19 Oct 2018 04:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180816084104.434-1-jian-hong@endlessm.com> <20180927085009.4190-1-jian-hong@endlessm.com>
In-Reply-To: <20180927085009.4190-1-jian-hong@endlessm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 14:50:36 +0300
Message-ID: <CAHp75VeqVXh8LsAppBmNJCbjL6T4g6ZhS=PSQbNqigrmKwbsdw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Simplify the keyboard brightness
 updating process
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:52 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> The original asus-wmi queues a work which calls the ACPI/WMI methods to
> update the keyboard LED brightness.  Similar drivers - acer-wmi,
> dell-wmi-led just call the ACPI/WMI methods directly without workqueues.
>
> This patch simplifies the keyboard brightness updating process which
> calls the kbd_led_update function directly without workqueue in
> asus-wmi.
>

Okay, this wasn't get any comment so far and my brief reading of the
call chain doesn't give me any objections.
I'm about to push this to accepted queue (for-next) since it was
already enough time passed in reviewing and testing queue.

Thanks!

> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2d6e272315a8..9441cce636e6 100644
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
> @@ -2310,7 +2304,7 @@ static int asus_hotk_resume(struct device *device)
>         struct asus_wmi *asus = dev_get_drvdata(device);
>
>         if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
> -               queue_work(asus->led_workqueue, &asus->kbd_led_work);
> +               kbd_led_update(asus);
>
>         return 0;
>  }
> @@ -2346,7 +2340,7 @@ static int asus_hotk_restore(struct device *device)
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


-- 
With Best Regards,
Andy Shevchenko
