Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DE8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+Al0yne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5238A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeLCOYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:24:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42972 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeLCOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:24:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so7372218qka.9;
        Mon, 03 Dec 2018 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUGyUsm3rzw01NLBPeQx46UrX4siDrBLy6gilqKPK5E=;
        b=r+Al0yne0DAyqfb0H46++4MxQYXIPzib1xZ+xQc+nO1FoINa+CPlbbtpad6Q83AZ1/
         q/8l419bNL8ozJDjM6lVMgTV14KRS8xb9inAFa8xlUrZSG2WkVVp4pb0Py7PIRtcR8HO
         Gp9ermDwaFL/JFXqLfWEexUjOGRFrRcDrSgufOodR3ZGBxXke5ZisfYy1lNSBH9kka9N
         7T1k79zoWPcyXU84Qxv/9NmXGDK0w8SYwXz/hcTMa8X3Zo5UzhwH97AmIZIvhxlRE8a9
         Qd9Xefn+FD1ljFhUi6qFjX7UNFJZA/98CDSpkZYfxGbzjpD488NQUHVGRehpm2wMNzCi
         ydug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUGyUsm3rzw01NLBPeQx46UrX4siDrBLy6gilqKPK5E=;
        b=UFkJUBnqL+O7/yy0k/AUR6KjX4D5reOZlwY2r8B+ew3yve5XxyV3xLIDwyk39DGkQm
         WEHPL9VqkiA3bxdHa/6k2+U35jiqCdrIQjaqhs8gfoOltwpVmTl95NVI9KLu5dqZ0tyI
         ze6amNA0lC0QI2c+pup1eU958aA/yEjvmfFmmRR0cmpEFNPeF/lB7uVv09JxxUjueKD8
         Q9aLcYfok5bf9cVPhat18Wwuq11cTf/EYw6JInZ0aCAK4L/SR7e8FTjOtLszlmNK5A/P
         jV1ZH7nzIcLyVx1sEy+5vBdcaO+PWo5/E4STFdNnDRMCkCRJxeKK7O6aZf7PA+3JIH53
         R4aw==
X-Gm-Message-State: AA+aEWbd8T3bXfCzaAV5cSNnDrFgeTM3abfrRnSGAhDYN/UzuIoaXuYn
        5is1cVKlz1iXEyL1VxWx7FK0DEsNyNc291gCqKc=
X-Google-Smtp-Source: AFSGD/U7pepVD6CYevBegpq/jcrXnBIMRHBuwZzdbTQeK6RXg75dXQMa7kSVelWc+zhkC5SGDiPY9s97P9+qdJb199A=
X-Received: by 2002:a37:4792:: with SMTP id u140mr15358453qka.301.1543846985215;
 Mon, 03 Dec 2018 06:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20181129235742.14332-1-ayman.bagabas@gmail.com> <20181129235742.14332-3-ayman.bagabas@gmail.com>
In-Reply-To: <20181129235742.14332-3-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 16:22:53 +0200
Message-ID: <CAHp75Vfxhp1unN6GhfidNbVSjZDKv3c8KuFpHq2aMdPPcWgXzA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] x86: add support for Huawei WMI hotkeys.
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 1:58 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:

> +static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
> +               enum led_brightness brightness)
> +{
> +       struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev->dev->parent);
> +       acpi_status status;
> +       union acpi_object args[3];
> +       struct acpi_object_list arg_list = {
> +               .pointer = args,
> +               .count = ARRAY_SIZE(args),
> +       };
> +
> +       args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;

> +       args[0].integer.value = 0;
> +       args[1].integer.value = 0x04;
> +       args[2].integer.value = brightness ? 1 : 0;
> +
> +       if (strcmp(priv->acpi_method, "WPIN") == 0) {
> +               args[0].integer.value = 1;
> +               args[2].integer.value = brightness ? 0 : 1;
> +       }

I would rather still see explicit settings for the other method as
well. Something like:

if (strcmp(...)) {
} else if (strcmp(...)) {
} else {
return -EINVAL;
}

> +
> +       status = acpi_evaluate_object(priv->handle, priv->acpi_method, &arg_list, NULL);
> +       if (ACPI_FAILURE(status))
> +               return -ENXIO;
> +
> +       return 0;
> +}
> +
> +static int huawei_wmi_leds_setup(struct wmi_device *wdev)
> +{
> +       struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +       acpi_status status;
> +
> +       // Skip registering LED subsystem if no ACPI method was found.
> +       status = acpi_get_handle(priv->handle, "\\_SB.PCI0.LPCB.EC0", &priv->handle);
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       if (acpi_has_method(priv->handle, "SPIN"))
> +               priv->acpi_method = "SPIN";
> +       else if (acpi_has_method(priv->handle, "WPIN"))
> +               priv->acpi_method = "WPIN";
> +       else
> +               return 0;
> +
> +       priv->cdev.name = "platform::micmute";
> +       priv->cdev.max_brightness = 1;
> +       priv->cdev.brightness_set_blocking = huawei_wmi_micmute_led_set;
> +       priv->cdev.default_trigger = "audio-micmute";
> +       priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +       priv->cdev.dev = &wdev->dev;
> +
> +       return devm_led_classdev_register(&wdev->dev, &priv->cdev);
> +}
> +
> +static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
> +{
> +       struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +       const struct key_entry *key;
> +
> +       /*
> +        * WMI0 uses code 0x80 to indicate a hotkey event.
> +        * The actual key is fetched from the method WQ00.
> +        */
> +       if (code == 0x80) {
> +               acpi_status status;
> +               acpi_handle handle;
> +               unsigned long long result;
> +               union acpi_object args[1];
> +               struct acpi_object_list arg_list = {
> +                       .pointer = args,
> +                       .count = ARRAY_SIZE(args),
> +               };
> +
> +               args[0].type = ACPI_TYPE_INTEGER;
> +               args[0].integer.value = 0;
> +
> +               status = acpi_get_handle(NULL, "\\WMI0", &handle);
> +               if (ACPI_FAILURE(status)) {
> +                       dev_err(&wdev->dev, "Unable to get ACPI handle\n");
> +                       return;
> +               }
> +
> +               status = acpi_evaluate_integer(NULL, "WQ00", &arg_list, &result);
> +               if (ACPI_FAILURE(status)) {
> +                       dev_err(&wdev->dev, "Unable to evaluate ACPI method\n");
> +                       return;
> +               }
> +
> +               code = result;
> +       }
> +
> +       key = sparse_keymap_entry_from_scancode(priv->idev, code);
> +       if (!key) {
> +               dev_info(&wdev->dev, "Unknown key pressed, code: 0x%04x\n", code);
> +               return;
> +       }
> +
> +       sparse_keymap_report_entry(priv->idev, key, 1, true);
> +}
> +
> +static void huawei_wmi_notify(struct wmi_device *wdev,
> +               union acpi_object *obj)
> +{
> +       if (obj->type == ACPI_TYPE_INTEGER)
> +               huawei_wmi_process_key(wdev, obj->integer.value);
> +       else
> +               dev_info(&wdev->dev, "Bad response type %d\n", obj->type);
> +}
> +
> +static int huawei_wmi_input_setup(struct wmi_device *wdev)
> +{
> +       struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> +       int err;
> +
> +       priv->idev = devm_input_allocate_device(&wdev->dev);
> +       if (!priv->idev)
> +               return -ENOMEM;
> +
> +       priv->idev->name = "Huawei WMI hotkeys";
> +       priv->idev->phys = "wmi/input0";
> +       priv->idev->id.bustype = BUS_HOST;
> +       priv->idev->dev.parent = &wdev->dev;
> +
> +       err = sparse_keymap_setup(priv->idev, huawei_wmi_keymap, NULL);
> +       if (err)
> +               return err;
> +
> +       err = input_register_device(priv->idev);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int huawei_wmi_probe(struct wmi_device *wdev)
> +{
> +       struct huawei_wmi_priv *priv;
> +       int err;
> +
> +       priv = devm_kzalloc(&wdev->dev, sizeof(struct huawei_wmi_priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +       dev_set_drvdata(&wdev->dev, priv);
> +
> +       err = huawei_wmi_input_setup(wdev);
> +       if (err)
> +               return err;
> +
> +       err = huawei_wmi_leds_setup(wdev);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static const struct wmi_device_id huawei_wmi_id_table[] = {
> +       { .guid_string = WMI0_EVENT_GUID },
> +       { .guid_string = AMW0_EVENT_GUID },
> +       {  }
> +};
> +
> +static struct wmi_driver huawei_wmi_driver = {
> +       .driver = {
> +               .name = "huawei-wmi",
> +       },
> +       .id_table = huawei_wmi_id_table,
> +       .probe = huawei_wmi_probe,
> +       .notify = huawei_wmi_notify,
> +};
> +
> +static int __init huawei_wmi_init(void)
> +{
> +       if (!(wmi_has_guid(WMI0_EVENT_GUID) || wmi_has_guid(AMW0_EVENT_GUID))) {
> +               pr_debug("Compatible WMI GUID not found\n");
> +               return -ENODEV;
> +       }
> +
> +       return wmi_driver_register(&huawei_wmi_driver);
> +}
> +
> +static void __exit huawei_wmi_exit(void)
> +{
> +       wmi_driver_unregister(&huawei_wmi_driver);
> +}
> +
> +module_init(huawei_wmi_init);
> +module_exit(huawei_wmi_exit);
> +
> +MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
> +MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
> +MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
> +MODULE_DESCRIPTION("Huawei WMI hotkeys");
> +MODULE_LICENSE("GPL v2");
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
