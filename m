Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E526DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9015B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="yC8sVFNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9015B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967087AbeFSQq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:46:28 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42238 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966733AbeFSQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:46:24 -0400
Received: by mail-ot0-f193.google.com with SMTP id 92-v6so398959otw.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j8gsnaoKBiHfvgCxLZul91KtUH3bdsRfVVFkqZtZOY8=;
        b=yC8sVFNNE5dGZHsiiYM7ihipQeo5YJyx5ZEtuk7dBv7yTxd8UL/jGwBzZjoGJAD9E3
         0OFZaAkRHEnHrku2xvc0/KYoc2Vk1wyFjDOGAMBRODPDtPhmwofga9zsCRQnIJAuCwqB
         5DKbVY4mE4rhVHBkmMxUSP7C/fJKc88JO5lsxA30mjVKTP+yxsrLYUze/1/uYz4DPMf5
         /eGjTKoE+Pc/6sajtsQ8Krtek+HbKJJ2gBHQ8AWLIzAgAi9OQ3XsPRlYVk/YUaqxr49B
         lrqFg6dHbrh+1CSJ7oXV2Rpa4Qw9YannMZwQcDCIUHqIobpfnVWBG4lxhnz9ULEeMtu+
         QOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j8gsnaoKBiHfvgCxLZul91KtUH3bdsRfVVFkqZtZOY8=;
        b=e5BintRUxyIJkc3ZGRI1m4pUCj3T3xDwjPTxko9mx00L4Ezbuysygz7pFF89B8n7bw
         6ZBqIOqn/sF0ApYukt1HYh5afUWBMDhp0bw303SezvmyPBpFm6xrxguMYOMG+5KqeTuR
         2Nzr68FN0YXBm8K6oOaUhT1V2MoFyJfCOvQGscdJeVBT9IKgqJOjto5wnSwA7+yiTfCE
         JL//LV/hexfXkg1ZbTOAle0FIDLoAd7JxHC/ptmupPqoSpbm+dfjBqwT5YM+L7c7pPkA
         G5ZAsLbd2LRVBYfG7fad8A2hyIScyGVa/uGAfksVEUKslih+MYvlSaSy766f9nQbgSyT
         utEA==
X-Gm-Message-State: APt69E12vrux8D7H7V+1ZjmlCLu4O/BV1GhibhhFUt71Qy5X3UJLvhJJ
        b4WNbma3vfFQeAenunmFWkwsxlVN2eg9HONTgWV+VaTCE1E=
X-Google-Smtp-Source: ADUXVKKiNNLRco0kTxjTNQGPTX9NUwbuLldQ8/iO3z2ZrqQ3XL1V7jhpbpV+3RgCoFs2KyPOZOXbtq7jty/erXmooQ4=
X-Received: by 2002:a9d:2ed3:: with SMTP id w77-v6mr11475079ota.123.1529426783644;
 Tue, 19 Jun 2018 09:46:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:e34:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:46:23 -0700 (PDT)
In-Reply-To: <CAB4CAwdKJiuEiV1CtoyYTZTatRt73BQbRX5kyEtpqNj8STj5-w@mail.gmail.com>
References: <20180611071838.47945-1-chiu@endlessm.com> <CAHp75VdfUO9rS-=nn+Ffe8bMEbCO-0xe8QBVqsJAZVFTMYkNxg@mail.gmail.com>
 <CAB4CAwdKJiuEiV1CtoyYTZTatRt73BQbRX5kyEtpqNj8STj5-w@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 19 Jun 2018 11:46:23 -0500
Message-ID: <CAD8Lp4596OLxc9sw=DwAZ_nHLEOt686xxatqCmSpV0eEWwigjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Chris Chiu <chiu@endlessm.com>
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

Hi,

On Thu, Jun 14, 2018 at 1:58 AM, Chris Chiu <chiu@endlessm.com> wrote:
>
> On Wed, Jun 13, 2018 at 8:49 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 11, 2018 at 10:18 AM, Chris Chiu <chiu@endlessm.com> wrote:
> >> Make asus-wmi notify on hotkey kbd brightness changes, listen for
> >> brightness events and update the brightness directly in the driver.
> >
> >> For this purpose, bound check on brightness in kbd_led_set must be
> >> based on the same data type to prevent illegal value been set.
> >
> >> @@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
> >>
> >>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
> >>
> >> -       if (value > asus->kbd_led.max_brightness)
> >> +       if ((int)value > (int)asus->kbd_led.max_brightness)
> >>                 value = asus->kbd_led.max_brightness;
> >> -       else if (value < 0)
> >> +       else if ((int)value < 0)
> >>                 value = 0;
> >
> > I didn't quite understand this part of the problem.
> > Does it exist in the current code? Can it be split to a separate change?
> >
> > Can we avoid those ugly castings?
> >
>
> I'd like to remove the ugly castings but there's a concern I may need some
> advices. I don't know whether if the bound check logic ever verified before.
> Maybe the value passed via sysfs is already correctly bounded?

The casts come from the underlying need to limit the minumum and
maximum brightness within available bounds, plus difficulties doing
that when you are dealing with an enum data type.

kbd_led_set is a function pointer (from led_classdev.brightness_set)
which has this definition:

void (*brightness_set)(struct led_classdev *led_cdev, enum
led_brightness brightness);

It seems that the compiler has the choice of whether to use a signed
or unsigned type for enums. According to your tests, and a quick test
app below, it seems like gcc is using unsigned.

  #include <stdio.h>
  enum led_brightness { LED_OFF = 0 };
  int main(void) {
    enum led_brightness tmp = -1;
    if (tmp < 0)
      printf("less than zero\n");
    else
      printf("gt zero\n");
  }

This test app prints "gt zero"

led-class.c:brightness_store() uses kstrtoul() so there is no chance
of passing a negative value through this codepath, as you suspected.
But we do need to do something with negative bounds for the code that
you are adding here.

I suggest doing it like this:

static void __kbd_led_set(struct led_classdev *led_cdev, int value)
{
    struct asus_wmi *asus;

    asus = container_of(led_cdev, struct asus_wmi, kbd_led);

    if (value > asus->kbd_led.max_brightness)
        value = asus->kbd_led.max_brightness;
    else if (value < 0)
        value = 0;

    asus->kbd_led_wk = value;
    queue_work(asus->led_workqueue, &asus->kbd_led_work);
}

static void kbd_led_set(struct led_classdev *led_cdev,
            enum led_brightness value)
{
    return __kbd_led_set(led_cdev, value);
}

Now kbd_led_set can continue being a correctly typed function pointer
for led_classdev.brightness_set. And from the code you are adding here
you can call __kbd_led_set directly with signed integer values, and
rely on correct bounds correction without ugly casts.

Andy, what do you think?

Thanks
Daniel
