Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BF4206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQMdbn5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfAHRTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:19:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38910 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:19:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so5205982qtl.5;
        Tue, 08 Jan 2019 09:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zplKx1pfGZ8c+9v30UiaiTbVBnfaG0IO/0UOn5cMnYA=;
        b=bQMdbn5m66MGOz9EA8tf3BrJiNLgSf+0LPOUdBDppx6Sg+S/PxNpZOhyUpFUy1MmIO
         FhronGFqEbc1tdWVm+06DXTcSFbQuw3REFf9IDvey+NVLef4LlLY8aTKnKe86/cf2kTf
         KI3tHYazNIirt+pRIFGpvZEANFugzbq6nkWdXE65X2Ufd4e5BZkM+sxRDuL3/GzK8urq
         7J8s8WRatk3ZFpkyxmxJ43omlq1hB/mqGFVH06GzV52AokONpj0bVfCpEyomgkmJf7IW
         jG6OGxluJ6wL8TnRaujxqbCXb4K6MyhDjNlNSMxPuBg48VNSHeZesF+sQ7nsQ09eqHvE
         OiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zplKx1pfGZ8c+9v30UiaiTbVBnfaG0IO/0UOn5cMnYA=;
        b=ZK5NifTKIG/nYFPAO69UOFXSyBBIdRTQX8hxJjrZsQFLktSvzaSHox95i/j/pLwhfw
         FaTLKwZb9eI01uGzWWcqakwCy0J/fPnz63hk8O+UgG/MeVW/sSHxjb8Vwrptqq4+7Lf5
         Pvj8HuJAvA95GrRnc/b3l3gvLfC6PoyIazn03OM5Lt5+NMQSQ1RO36GLqrz2QsEheTcM
         Ue/7iHxLdNaI/vvwSbjSn1e6TxgDsMkeC+m/ErEoCaHQef17xUhb47wasJYjpUvcLhqN
         R7rUN8rLA1xPFflcVUUDmo1ARIpTsVvORjSjfZvd+bkqrAT+ho+6CU1eWXjnlV4WXLAm
         opKQ==
X-Gm-Message-State: AJcUukeyLPgGVnheb9MzUTUHcxJfdO3Iderwzw9Ik1gevawLLdGEs+Cg
        +nMrfhzPjDBbsrpvG/6Xq6LYYHBHfT5LEQ/gW70=
X-Google-Smtp-Source: ALg8bN5a2S8ng4/rSSt5/6cklydNeSpq3ktBczvGZZLVXzNyjtNRY14z5QrrCY8F7wZyv1ZIIu/a1EUwSycO+VRGmwE=
X-Received: by 2002:a0c:a8e3:: with SMTP id h35mr2514330qvc.92.1546967953606;
 Tue, 08 Jan 2019 09:19:13 -0800 (PST)
MIME-Version: 1.0
References: <20181213120944.30967-1-enric.balletbo@collabora.com>
 <20181213222000.GA12302@amd> <2fcfc863-3218-55e8-2a0f-75d7cb2d55db@collabora.com>
In-Reply-To: <2fcfc863-3218-55e8-2a0f-75d7cb2d55db@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 8 Jan 2019 18:19:02 +0100
Message-ID: <CAFqH_53E1ori_b69XkpAafaAZKZE3GzbN5eFvU9FbUTgjHbi+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] power: supply: add input voltage limit property
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sameer Nanda <snanda@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dt., 18 de des. 2018 a les 17:32:
>
> Hi Pavel,
>
> On 13/12/18 23:20, Pavel Machek wrote:
> > Hi!
> >
> >> This is part of the Pixel C's thermal management strategy to effectively
> >> limit the input power to 5V 3A when the screen is on. When the screen is
> >> on, the display, the CPU, and the GPU all contribute more heat to the
> >> system than while the screen is off, and we made a tradeoff to throttle
> >> the charger in order to give more of the thermal budget to those other
> >> components.
> >>
> >> So there's nothing fundamentally broken about the hardware that would
> >> cause the Pixel C to malfunction if we were charging at 9V or 12V instead
> >> of 5V when the screen is on, ie if userspace doesn't change this.
> >>
> >> What would happen is that you wouldn't meet Google's skin temperature
> >> targets on the system if the charger was allowed to run at 9V or 12V with
> >> the screen on.
> >>
> >> For folks hacking on Pixel Cs (which is now outside of Google's official
> >> support window for Android) and customizing their own kernel and userspace
> >> this would be acceptable, but we wanted to expose this feature in the
> >> power supply properties because the feature does exist in the Emedded
> >> Controller firmware of the Pixel C and all of Google's Chromebooks with
> >> USB-C made since 2015 in case someone running an up to date kernel wanted
> >> to limit the charging power for thermal or other reasons.
> >>
> >> This patch exposes a new property, similar to input current limit, to
> >> re-configure the maximum voltage from the external supply at runtime
> >> based on system-level knowledge or user input.
> >
> > Could we get power input limit, instead?
> >
>
> I'm open but I have some concerns, so lets discuss a bit about it :)
>
> According to the USB PD 2.0 specs if we limit the source at 15W we can get 5V/3A
> or 9V/1.67A, if I am not mistaken the higher voltage caused problem since the
> conversion to lower internal voltages generated more heat, so in this case
> 9V/1.67A is not a valid value for us (maybe someone from ChromeOS can confirm
> this?).
>
> There is also the USB Power Delivery Specification revision 3.0, who defines a
> programmable power supply protocol that allows granular control over VBUS power
> in 20 mV steps to facilitate constant current or constant voltage charging. So,
> maybe we might be interested on set a specific constant current or a specific
> contant voltage. I think that in this case would be interesting have the
> possibility to set voltage or current. What do you think?
>

Around Xmas are bad dates to start a discussion. I don't want this
patch will be forgotten, so a gentle ping on your thoughts on this :)
(just in case)

Cheers,
 Enric

> Thanks,
>  Enric
>
>
> > That is what you really want, it is more generally useful, and it is
> > what current input limit should have been, in the first place...
> >
> > Thanks,
> >                                                                       Pavel
> >
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> >> ---
> >>
> >> Changes in v3:
> >> - Improve commit log and documentation with Benson comments.
> >>
> >> Changes in v2:
> >> - Document the new property in ABI/testing/sysfs-class-power.
> >> - Add the Reviewed-by Guenter Roeck tag.
> >>
> >>  Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
> >>  Documentation/power/power_supply_class.txt  |  2 ++
> >>  drivers/power/supply/power_supply_sysfs.c   |  1 +
> >>  include/linux/power_supply.h                |  1 +
> >>  4 files changed, 19 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> >> index 5e23e22dce1b..6dee5c105a28 100644
> >> --- a/Documentation/ABI/testing/sysfs-class-power
> >> +++ b/Documentation/ABI/testing/sysfs-class-power
> >> @@ -335,6 +335,21 @@ Description:
> >>              Access: Read, Write
> >>              Valid values: Represented in microamps
> >>
> >> +What:               /sys/class/power_supply/<supply_name>/input_voltage_limit
> >> +Date:               Nov 2018
> >> +Contact:    linux-pm@vger.kernel.org
> >> +Description:
> >> +            This entry configures the incoming VBUS voltage limit currently
> >> +            set in the supply. Normally this is configured based on
> >> +            system-level knowledge or user input (e.g. This is part of the
> >> +            Pixel C's thermal management strategy to effectively limit the
> >> +            input power to 5V when the screen is on to meet Google's skin
> >> +            temperature targets). Note that this feature should not be
> >> +            used for safety critical things.
> >> +
> >> +            Access: Read, Write
> >> +            Valid values: Represented in microvolts
> >> +
> >>  What:               /sys/class/power_supply/<supply_name>/online,
> >>  Date:               May 2007
> >>  Contact:    linux-pm@vger.kernel.org
> >> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
> >> index 300d37896e51..7b4be615b4f8 100644
> >> --- a/Documentation/power/power_supply_class.txt
> >> +++ b/Documentation/power/power_supply_class.txt
> >> @@ -137,6 +137,8 @@ power supply object.
> >>
> >>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
> >>  the current drawn from a charging source.
> >> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicates
> >> +the voltage limit from a charging source.
> >>
> >>  CHARGE_CONTROL_LIMIT - current charge control limit setting
> >>  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
> >> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> >> index dce24f596160..5848742ebb59 100644
> >> --- a/drivers/power/supply/power_supply_sysfs.c
> >> +++ b/drivers/power/supply/power_supply_sysfs.c
> >> @@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] = {
> >>      POWER_SUPPLY_ATTR(charge_control_limit),
> >>      POWER_SUPPLY_ATTR(charge_control_limit_max),
> >>      POWER_SUPPLY_ATTR(input_current_limit),
> >> +    POWER_SUPPLY_ATTR(input_voltage_limit),
> >>      POWER_SUPPLY_ATTR(energy_full_design),
> >>      POWER_SUPPLY_ATTR(energy_empty_design),
> >>      POWER_SUPPLY_ATTR(energy_full),
> >> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> >> index f80769175c56..608ba88e32ee 100644
> >> --- a/include/linux/power_supply.h
> >> +++ b/include/linux/power_supply.h
> >> @@ -122,6 +122,7 @@ enum power_supply_property {
> >>      POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
> >>      POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> >>      POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> >> +    POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
> >>      POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> >>      POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
> >>      POWER_SUPPLY_PROP_ENERGY_FULL,
> >
