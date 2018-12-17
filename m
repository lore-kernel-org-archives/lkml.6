Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740FCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3368320675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X318bGEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbeLQQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:15:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35029 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeLQQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:15:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so14705134qtc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1cDL3aDf2apX1LCAjFnOp0h5wzOiJFoFkFgB9EaFTY=;
        b=X318bGEqsKb+6X/gWeAYtDqK87GdIPJl1RXHE9Cugztm+XN77FaFGBYEhB0c+mIy3w
         68XVINRWzjLYtDDwo9+auCLWIdYyMcXJvr0GWdVeW9Mf8ipUaLnPUqWCU2//wzr9uNSM
         ktSbOZIhhfNFxTdZt9vYb9TBwby2tbS6/3anvc3j3l+BWzyZH09mRfuKenQwy6XP8ssc
         iV9t/cZ367/NgwOVDaIdOd1nzT3umdrxz3LW0+0YOQ5J8ibGj0+8b8N8t+jvLjB3gjxS
         VRefqJA/XeLvNyZVItUMIHEYX7aQllGkgoBJ+uVD/Y6yw5+7iBao0Da5gpmnSuG5y/vP
         1uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1cDL3aDf2apX1LCAjFnOp0h5wzOiJFoFkFgB9EaFTY=;
        b=qh9mnYvaY+uGVsl+YPM5ZAS3N+bTimFmyVIJHWlIFUEFUq+GSOzsFoJV80OqNG//ll
         /SNL59C/k4VQ+fT4LprHm4gqCNRaNUHXn50WJYLguN/Am5l4vMDifW6h85Qwwe7tZ5ty
         Woe+3K0rnG8ORUVhwW1nsSzZccESVuB5tRfX87IKsnYewj+qSNet9oLOViX+JbJ/P6On
         gSFMNYh2Awe2/ZFRdZ9nuCVjl8zI3t6TVMsNhNuOZkRbfkaAhQJqumrfmG1S9Zekg/4o
         +ufBpF1kHWcOuo+x6T7cMGg8hF91utPWeu8468gOD50r5TEJJU6naJDgtvsDXikGcrhb
         u+fw==
X-Gm-Message-State: AA+aEWbeUASaaUx9OZtiUHwa6Zhymc75DNNP6owE+jt5ki1dXR71OwhF
        RKl6b4weMSxmVxJs5L4How+heagVcYah7ehetVY=
X-Google-Smtp-Source: AFSGD/WGIZe6Nq8swsd93t8JNEsIX+IfoI/2I23ke8MeGWvH24vkNLzq23O8QV1ZjjbJsUwSFlehR7fBenwRPOgqpMc=
X-Received: by 2002:ac8:203:: with SMTP id k3mr14453481qtg.64.1545063346022;
 Mon, 17 Dec 2018 08:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 17 Dec 2018 17:15:34 +0100
Message-ID: <CAFqH_53rYRzZMVbK4fKyuGX5mOuJ0cT_SWtHC6tv8i=LZMt8GQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] cros_ec: Add support for Wilco EC
To:     Nick Crews <ncrews@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Many thanks for sending this upstream. Adding Guenter as also might be
interested and some few questions regarding the driver structure.

Missatge de Nick Crews <ncrews@google.com> del dia ds., 15 de des.
2018 a les 1:21:
>
> The Chromebook named wilco contains a different Embedded Controller
> than the rest of the chromebook series, and thus the kernel requires
> a different driver than the already existing and generalized
> cros_ec_* drivers. Specifically, this driver adds support for getting
> and setting the RTC on the EC, adding a binary sysfs attribute
> that receives ACPI events from the EC, adding a binary sysfs
> attribute to request telemetry data from the EC (useful for enterprise
> applications), and adding normal sysfs attributes to get/set various
> other properties on the EC. The core of the communication with the EC
> is implemented in wilco_ec_mailbox.c, using a simple byte-level protocol
> with a checksum, transmitted over an eSPI bus. For debugging purposes,
> a raw attribute is also provided which can write/read arbitrary
> bytes to/from the eSPI bus.
>
> We attempted to adhere to the sysfs principles of "one piece of data per
> attribute" as much as possible, and mostly succeded. However, with the
> wilco_ec_adv_power.h attributes, which deal with scheduling power usage,
> we found it most elegant to bundle setting event times for an entire day
> into a single attribute, so at most you are using attributes formatted
> as "%d %d %d %d %d %d". With the telemetry attribute, we had to use a
> binary attribute, instead of the preferable human-readable ascii, in
> order to keep secure the information which is proprietary to the
> enterprise service provider. This opaque binary data will be read and
> sent using a proprietary daemon running on the OS. Finally, the
> "version" attribute returns a formatted result that looks something
> like:
> > cat /sys/bus/platform/devices/GOOG000C\:00/version
> Label        : 95.00.06
> SVN Revision : 5960a.06
> Model Number : 08;8
> Build Date   : 11/29/18
>
> The RTC driver is exposed as a standard RTC class driver with
> read/write functionality.
>
> For event notification, the Wilco EC can return extended events that
> are not handled by standard ACPI objects. These events can
> include hotkeys which map to standard functions like brightness
> controls, or information about EC controlled features like the
> charger or battery. These events are triggered with an
> ACPI Notify(0x90) and the event data buffer is read through an ACPI
> method provided by the BIOS which reads the event buffer from EC RAM.
> These events are then processed, with hotkey events being sent
> to the input subsystem and other events put into a queue which
> can be read by a userspace daemon via a sysfs attribute.
>
> The rest of the attributes are categorized as either "properties" or
> "legacy". "legacy" implies that the attribute existed on the EC before it
> was modified for ChromeOS, and "properties" implies that the attribute
> exposes functionality that was added to the EC specifically for
> ChromeOS. They are mostly boolean flags or percentages.
>
> A full thread of the development of these patches can be found at
> https://chromium-review.googlesource.com/c/1371034. This thread contains
> comments and revisions that could be helpful in understanding how the
> driver arrived at the state it is in now. The thread also contains some
> ChromeOS specific patches that actually enable the driver. If you want
> to test the patch yourself, you would have to install the ChromeOS SDK
> and cherry pick in these patches.
>
> I also wrote some integration tests using the Tast testing framework that
> ChromeOS uses. It would require a full ChromeOS SDK to actually run the
> tests, but the source of the tests, written in Go, are useful for
> understanding what the desired behavior is. You can view the tests here:
> https://chromium-review.googlesource.com/c/1372575
>
> This is still an initial version of the driver, and we are sending it
> upstream for comments now, so that we can incorporate any requested
> changes such that it eventually can be merged. Thank you for your
> comments!
>
>
> Duncan Laurie (6):
>   CHROMIUM: cros_ec: Remove cros_ec dependency in lpc_mec
>   CHROMIUM: wilco_ec: Add new driver for Wilco EC
>   CHROMIUM: wilco_ec: Add sysfs attributes
>   CHROMIUM: wilco_ec: Add support for raw commands in sysfs
>   CHROMIUM: wilco_ec: Add RTC class driver
>   CHROMIUM: wilco_ec: Add event handling
>
> Nick Crews (4):
>   CHROMIUM: wilco_ec: Move legacy attributes to separate file
>   CHROMIUM: wilco_ec: Add EC properties
>   CHROMIUM: wilco_ec: Add peakshift and adv_batt_charging
>   CHROMIUM: wilco_ec: Add binary telemetry attributes
>
>  drivers/platform/chrome/Kconfig               |  24 +-
>  drivers/platform/chrome/Makefile              |   9 +-
>  drivers/platform/chrome/cros_ec_lpc_mec.c     |  54 +-
>  drivers/platform/chrome/cros_ec_lpc_mec.h     |  45 +-
>  drivers/platform/chrome/cros_ec_lpc_reg.c     |  43 +-
>  drivers/platform/chrome/wilco_ec.h            | 180 ++++++
>  drivers/platform/chrome/wilco_ec_adv_power.c  | 533 ++++++++++++++++++
>  drivers/platform/chrome/wilco_ec_adv_power.h  | 193 +++++++
>  drivers/platform/chrome/wilco_ec_event.c      | 343 +++++++++++
>  drivers/platform/chrome/wilco_ec_legacy.c     | 204 +++++++
>  drivers/platform/chrome/wilco_ec_legacy.h     |  96 ++++
>  drivers/platform/chrome/wilco_ec_mailbox.c    | 427 ++++++++++++++
>  drivers/platform/chrome/wilco_ec_properties.c | 327 +++++++++++
>  drivers/platform/chrome/wilco_ec_properties.h | 163 ++++++
>  drivers/platform/chrome/wilco_ec_rtc.c        | 163 ++++++

Shouldn't this go to the RTC subsystem? Not sure if there are more
drivers that can go to a specific subsystem.

>  drivers/platform/chrome/wilco_ec_sysfs.c      | 253 +++++++++
>  drivers/platform/chrome/wilco_ec_sysfs_util.h |  47 ++
>  drivers/platform/chrome/wilco_ec_telemetry.c  |  66 +++
>  drivers/platform/chrome/wilco_ec_telemetry.h  |  42 ++
>  19 files changed, 3153 insertions(+), 59 deletions(-)

Wow, seems that this is going to be big, might make sense add a
wilco_ec subdirectory for all this?

>  create mode 100644 drivers/platform/chrome/wilco_ec.h
>  create mode 100644 drivers/platform/chrome/wilco_ec_adv_power.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_adv_power.h
>  create mode 100644 drivers/platform/chrome/wilco_ec_event.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_legacy.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_legacy.h
>  create mode 100644 drivers/platform/chrome/wilco_ec_mailbox.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_properties.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_properties.h
>  create mode 100644 drivers/platform/chrome/wilco_ec_rtc.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_sysfs.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_sysfs_util.h
>  create mode 100644 drivers/platform/chrome/wilco_ec_telemetry.c
>  create mode 100644 drivers/platform/chrome/wilco_ec_telemetry.h
>
> --
> 2.20.0.405.gbc1bbc6f85-goog
>
Thanks,
  Enric
