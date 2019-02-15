Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78073C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C25C21917
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D095tI5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbfBOHWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:22:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38326 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfBOHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:22:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so5154880qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 23:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqBKu3DuRzErOdiT3HUQunhHLvGpzpttpmGGCZ1xIAI=;
        b=D095tI5c/AiUUREQp5uoGFDxONAKWbXtmZCEUmVzy6wHZpKx+QzgU2S5Q6G/DmLbVU
         FQBKXIuDebLl/XZsJxUIP/qXffyC8ndCooC8l9aVWWKXy/b7ZBcuwo4EU5ewZBs0JxRc
         Ur/7N3xEJ5zgiPHMj+GO+4smkMyjSv73v/1o+rpSLXtLyeP53meSoTKZ7mIE4hJbSrTm
         8ULMhVIXZeJeHTBN13vWwihqRd8S+gN2+4J5YgkxwdXFgbZzIdgEv813WRGXj0NwykaY
         E4flOxUc8+KRD4lFmW7etsKL+qiDmn3NkDXqkD38RfQzMiqYr87XpJvw1fjeCQp6S8pt
         6yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqBKu3DuRzErOdiT3HUQunhHLvGpzpttpmGGCZ1xIAI=;
        b=fP0MQ5SXXUlYeTecYvJIRRlGWeeT7brUYjk6cT+I0iZuCUUiVYdls/Qi9yVslmURK7
         7+rSl2DtuCH0tJ4Y3C0ifbympfbh/i4xB+I0ZpH27hDjhwtpeywgQxj2MDc5o3gs3EHL
         9tq+taFMJGXuLJdzXJqJgDG4LY/K9oRCMXo+V8y7BJtCoilUrTYAq08H/532NggU8wmR
         E9pEXu2bZNqgaTfkPUZrr0mL2Ps9qOwzK/RXh9cKdiNEh6JSghlsrMz3O0FBAiMWo+Tt
         wF0YzRNoE2wy0de4SB6u3JNCBYQD2TfMRHhTzzyeLMak32xIXCLY/aEPsJMhaZ5lkLV9
         U32g==
X-Gm-Message-State: AHQUAuYpHJT49/Tgsi7IWmWw60/fThyzCc0CqohwcJ9oppG1MZOeANCD
        HZ8O0PaxI/iM0AOV0a9o5UzPniXsiLI8kNKt6xk=
X-Google-Smtp-Source: AHgI3IbmS7CKDB9PlXXGVfNKgK5mqxrC1osdG2voZp3D5Pw64K+HcXXWWs4+RNiPZKKyFnV+JYh5w3XptSKOPhTI5hg=
X-Received: by 2002:a37:474b:: with SMTP id u72mr5804112qka.106.1550215330010;
 Thu, 14 Feb 2019 23:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20190211070040.4569-1-jbroadus@gmail.com> <nycvar.YFH.7.76.1902140036400.11598@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1902140036400.11598@cbobk.fhfr.pm>
From:   james broadus <jbroadus@gmail.com>
Date:   Thu, 14 Feb 2019 23:21:58 -0800
Message-ID: <CAKgEEwteam5TCWAUtgQKxQpTzTk3+_DktmqwxZTLa=w3xt5i8Q@mail.gmail.com>
Subject: Re: [PATCH] Fix resume for ELAN2097 touchscreen.
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:37 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sun, 10 Feb 2019, Jim Broadus wrote:
>
> > Commit 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system resume")
> > fixes the resume behavior of several devices. However, this breaks the
> > resume on the ELAN2097, used on Dell Inspiron laptops, with the same flood
> > of messages:
> >
> > [27009.817110] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
> > [27009.818867] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
> > [27009.820623] i2c_hid i2c-ELAN2097:00: i2c_hid_get_input: incomplete report (67/65535)
> >
> > This change adds a new I2C_HID_QUIRK_RESET_AFTER_RESUME and replaces the
> > original reset behavior for this device.
> >
> > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
>
> This should be fixed in hid.git#for-5.1/i2c-hid already by commit
> 1475af255e18f. Could you please confirm that?
>

Hi Jiri. That change mutes the log messages, but I'm still counting around
35000 interrupts per second after resume and touch does not work. With the
reset, the device works properly.

Jim

> > ---
> >  drivers/hid/hid-ids.h              |  1 +
> >  drivers/hid/i2c-hid/i2c-hid-core.c | 20 ++++++++++++++------
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 24f846d67478..38cc7033712a 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -387,6 +387,7 @@
> >  #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W      0x0401
> >  #define USB_DEVICE_ID_HP_X2          0x074d
> >  #define USB_DEVICE_ID_HP_X2_10_COVER 0x0755
> > +#define USB_DEVICE_ID_ELAN2097               0x2504
> >
> >  #define USB_VENDOR_ID_ELECOM         0x056e
> >  #define USB_DEVICE_ID_ELECOM_BM084   0x0061
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> > index c5edfa966343..fdbad29b4406 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -50,6 +50,7 @@
> >  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET     BIT(1)
> >  #define I2C_HID_QUIRK_NO_RUNTIME_PM          BIT(2)
> >  #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP              BIT(3)
> > +#define I2C_HID_QUIRK_RESET_AFTER_RESUME     BIT(4)
> >
> >  /* flags */
> >  #define I2C_HID_STARTED              0
> > @@ -181,6 +182,8 @@ static const struct i2c_hid_quirks {
> >               I2C_HID_QUIRK_NO_RUNTIME_PM },
> >       { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
> >               I2C_HID_QUIRK_NO_RUNTIME_PM },
> > +     { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN2097,
> > +              I2C_HID_QUIRK_RESET_AFTER_RESUME },
> >       { 0, 0 }
> >  };
> >
> > @@ -1279,12 +1282,17 @@ static int i2c_hid_resume(struct device *dev)
> >
> >       enable_irq(client->irq);
> >
> > -     /* Instead of resetting device, simply powers the device on. This
> > -      * solves "incomplete reports" on Raydium devices 2386:3118 and
> > -      * 2386:4B33 and fixes various SIS touchscreens no longer sending
> > -      * data after a suspend/resume.
> > -      */
> > -     ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> > +     if (ihid->quirks & I2C_HID_QUIRK_RESET_AFTER_RESUME) {
> > +             ret = i2c_hid_hwreset(client);
> > +     } else {
> > +             /* Instead of resetting device, simply powers the device on.
> > +              * This solves "incomplete reports" on Raydium devices 2386:3118
> > +              * and 2386:4B33 and fixes various SIS touchscreens no longer
> > +              * sending data after a suspend/resume.
> > +              */
> > +             ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> > +     }
> > +
> >       if (ret)
> >               return ret;
> >
> > --
> > 2.20.1
> >
>
> --
> Jiri Kosina
> SUSE Labs
>
