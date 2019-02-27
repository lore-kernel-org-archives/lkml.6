Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6124C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BC6213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MamOABd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfB0PON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:14:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41991 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0POM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:14:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id u7so10352709qtg.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JDcmVrkO8JJsabsI0QNODvca14ZcDBb8x1GwyLMyjI=;
        b=MamOABd5Jb84EUGzPjfnOpwLrxL0Yku1fIIU4RmXQpVXl04H5K7+FNVSWXQxsYkyFv
         0ogGUtnAZmYRTi66kaXQ2ObljIp1OU0XM6zno0GnE1ZgB5HaxITNwYTUKJLnI+2yHZhQ
         vLYPX4ZliVZwerejYNKO4V8xBEBE/2YgP25T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JDcmVrkO8JJsabsI0QNODvca14ZcDBb8x1GwyLMyjI=;
        b=CsK9qbA18sZGAStHHWVTGD2WXv6WC01H01MGS07dnQen1B48K+M5XEjlsEXzHGoRy9
         2w+XOxIH6hpridPH8m1Gpx6XSdRl0YbcayXQXLBvtAEi0h5fCFMliyOzXocZEnDhKN7W
         +U3r+O4njYPIG7OWitmstIvWUHLixP0adQ5IBo228pwS7m/3xUhcogXTM9v+zP4XDfyc
         6vnolQJQiYaBKdEA5TnFdgI18ft7J3aCy/fVo7hr3NZdlBlDp7sYDJ6bI7dsJCEplo2Q
         g+p1htRaq8jWJXs4htnITNTbRCgMxFsfwGzuB1aPBpHdGMLyLpy9xEV+vCSyzAXqwmI+
         JPiA==
X-Gm-Message-State: AHQUAuZxKlQxdlrSTNCy4H2v25dL0ESSWq33nMqxIU8oxmFK0szdCcA+
        bAX+1He+eeQvdxGrzKyUTANOUGfmQMHHWQ==
X-Google-Smtp-Source: AHgI3IYwt9OevxBDiJJwAdgorwsgKrTbCvmeikHJxL/c65vxA5rFbTyaU4GxgqYbF1Ihggd/TkoLWg==
X-Received: by 2002:ac8:2805:: with SMTP id 5mr2078721qtq.75.1551280450719;
        Wed, 27 Feb 2019 07:14:10 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id z6sm6564247qtb.67.2019.02.27.07.14.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 07:14:09 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id z39so19601667qtz.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:14:09 -0800 (PST)
X-Received: by 2002:ac8:3437:: with SMTP id u52mr2077040qtb.185.1551280449173;
 Wed, 27 Feb 2019 07:14:09 -0800 (PST)
MIME-Version: 1.0
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CABXOdTdprS1OL534XQq8yHTFDzXdWWODq3VGrSEHYe2wmV5zfg@mail.gmail.com>
 <CAK+PMK67rWZarOV31n=yYbRMq3wo9vDyMTQ93PFZ7PRUMS66Ng@mail.gmail.com>
 <CABXOdTdbev2nKNjocqxOyPcGOU8zbWpQ7uALWZdEHL0CXkYDgA@mail.gmail.com>
 <CAK+PMK5U4YRtJNUbsQu3ARJFxwai7W=DjPfjuX_AZMFcUZ-c_A@mail.gmail.com> <39dc9be2-808e-4800-b4bb-605d5bf94e12@collabora.com>
In-Reply-To: <39dc9be2-808e-4800-b4bb-605d5bf94e12@collabora.com>
From:   Jett Rink <jettrink@chromium.org>
Date:   Wed, 27 Feb 2019 08:13:57 -0700
X-Gmail-Original-Message-ID: <CAK+PMK4ov8jJh7wZoTErikuztf=eOruG8xYt6umjt35f9EaGaA@mail.gmail.com>
Message-ID: <CAK+PMK4ov8jJh7wZoTErikuztf=eOruG8xYt6umjt35f9EaGaA@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        andriy.shevchenko@intel.com, Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diagram you provided is correct.

The ISH device is a MCU that can run general purpose code that is
located on the SoC. Typically the ISH collects sensor data and
processes it before giving it to the AP. The ISH HW can run any RTOS,
and in this scenario we are choosing to run the ECOS RTOS. In doing
so, we have access to the standard cros_ec command interface for
communication between the AP and ISH. This is helpful because we have
sensors drivers (Cros EC IIO Sensors) that depend on the cros_ec
command interface.

The idea behind using a different sysfs path was to ensure that there
weren't any unintended consequences by adding a cros_ec device when
the ISH doesn't support most of the EC type tasks. Here are a few
examples:
 - Mosys tool is specifically trying to talk with an EC:
https://chromium.googlesource.com/chromiumos/platform/mosys/+/152a306a82009cd6ca68760b0902fc03781e0d5d/platform/daisy/ec.c#41
 - The ectool is specifically trying to talk with an EC:
https://chromium.googlesource.com/chromiumos/platform/ec/+/a3c27b39fa69f280a3728a5cf24de57a5d3ccb0d/util/ectool.c#8546

At least on active project, there has already been confusion that the
normal ectool program doesn't work because the EC on the system is 3rd
party and does not support the normal cros_ec interface. This
confusion would compound if the ISH started presenting the cros_ec
interface and the ectool started talking to the ISH instead of the 3rd
party EC. Maybe we just need to modify ectool to make that situation
less confusing, but this is an example of the cross over using the
cros_ish device name is trying to avoid.

At this point though, we will definitely follow the guidance of people
more experienced in kernel design. If using cros_ish as a device name
instead of cros_ec is actually not a good idea, then we can accept
that and move forward and try to see what the fallout is from
userspace tools.

-Jett


On Wed, Feb 27, 2019 at 7:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 26/2/19 18:21, Jett Rink wrote:
> > We are specifically wanting userspace applications to not worry/confuse cros_ish
> > with a normal cros_ec. Adding an attribute instead of changing the path would
> > make it easy for userspace application to forget to check properly before
> > accessing the ish as an EC when it shouldn't.
> >
> > On Mon, Feb 25, 2019 at 4:37 PM Guenter Roeck <groeck@google.com
> > <mailto:groeck@google.com>> wrote:
> >
> >     On Mon, Feb 25, 2019 at 3:22 PM Jett Rink <jettrink@chromium.org
> >     <mailto:jettrink@chromium.org>> wrote:
> >
> >         A cros_ec and cros_ish device could both be present on the same system.
> >         We want to change the device path to ensure that drivers/code further up
> >         the stack does not get confuse the ISH with as an EC.
> >
> >         The ISH device can export a similar sysfs interface as they both use the
> >         same command interface for communication (although they will use
> >         different transport layers). The common cros code will detect certain
> >         EC_FEATURES and enable the correct subsystem based on the level of
> >         functionality the device supports. In the case of the ISH, the sensor
> >         subsystem will be enabled.
> >
> >     Seems to me it would make more sense to handle that difference with a sysfs
> >     attribute (instead of forcing each userspace application to support multiple
> >     sysfs paths).
> >
>
> Is still unclear to me what's that ISH device, so I'd appreciate if you can give
> some more background. Trying to understand the topology, makes sense that block
> diagram to you?
>
>
>        ---------------------------
>       |  User Space Applications  |
>        ---------------------------
>
> ----------------IIO ABI----------------
>
>        -----------------------------
>       |  CrOS EC IIO Sensor Drivers |
>        -----------------------------
>
>        --------------------------
>       |  CrOS EC over ISH Driver |
>        --------------------------
>
> ---------------- OS ------------------
>
>        --------------------------
>       |     CrOS EC Firmware     |
>        --------------------------
>
>        --------------------------
>       | ISH Hardware/Firmware    |
>        --------------------------
>
> So I'm right assuming that this CrOS EC will implement only the sensor features?
>
> And then, the system will have another CrOS EC implementing other features like
> RTC, USBPD-charger, etc?
>
> Apart from the sensors features, will the CrOS EC ISH implement other features?
>
> I'm a bit worried about the increasing way to use a particular name for
> different CrOS EC, actually we have only cros_ec and cros_pd. But in the
> chromeos kernels there is /dev/cros_fp, /dev/cros_tp, /dev/cros_ish,
> /dev/cros_scp and who knows how many more in the future. So I'm wondering if
> wouldn't be better use standard names, i.e /dev/cros_ec0, /dev/cros_ec1, etc. as
> userspace, for those cases, should be able to query the EC_FEATURE_ISH/FP/TP/SCP
> and know against which EC the device is attached.
>
> Cheers,
> Enric
>
> >     Guenter
> >
> >
> >         -Jett
> >
> >         On Sun, Feb 24, 2019 at 4:03 PM Guenter Roeck <groeck@google.com
> >         <mailto:groeck@google.com>> wrote:
> >
> >             On Sun, Feb 24, 2019 at 1:14 AM Rushikesh S Kadam
> >             <rushikesh.s.kadam@intel.com <mailto:rushikesh.s.kadam@intel.com>>
> >             wrote:
> >
> >                 Intel Integrated Sensor Hub (ISH) is also a MCU running EC
> >                 having feature bit EC_FEATURE_ISH. Instantiate it as a special
> >                 CrOS EC device with device name 'cros_ish'.
> >
> >
> >             The type of MCU doesn't really have to be reflected in the sysfs
> >             directory path. cros_ec uses different
> >             MCUs over time.
> >
> >             Will the new path exist in parallel with cros_ec (in other words,
> >             will there also be a stand-alone EC in the same system) ? Does it
> >             have different or the same sysfs attributes as cros_ec ?
> >
> >             Also,, what is the impact on userspace ?
> >
> >             Thanks,
> >             Guenter
> >
> >                 Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com
> >                 <mailto:rushikesh.s.kadam@intel.com>>
> >                 ---
> >                  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
> >                  include/linux/mfd/cros_ec.h          |  1 +
> >                  include/linux/mfd/cros_ec_commands.h |  2 ++
> >                  3 files changed, 13 insertions(+)
> >
> >                 diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> >                 index 2d0fee4..be499b8 100644
> >                 --- a/drivers/mfd/cros_ec_dev.c
> >                 +++ b/drivers/mfd/cros_ec_dev.c
> >                 @@ -414,6 +414,16 @@ static int ec_device_probe(struct
> >                 platform_device *pdev)
> >                         device_initialize(&ec->class_dev);
> >                         cdev_init(&ec->cdev, &fops);
> >
> >                 +       /* check whether this is actually a Intel ISH rather
> >                 than an EC */
> >                 +       if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
> >                 +               dev_info(dev, "Intel ISH MCU detected.\n");
> >                 +               /*
> >                 +                * Help userspace differentiating ECs from ISH MCU,
> >                 +                * regardless of the probing order.
> >                 +                */
> >                 +               ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
> >                 +       }
> >                 +
> >                         /*
> >                          * Add the class device
> >                          * Link to the character device for creating the /dev entry
> >                 diff --git a/include/linux/mfd/cros_ec.h
> >                 b/include/linux/mfd/cros_ec.h
> >                 index de8b588..00c5765 100644
> >                 --- a/include/linux/mfd/cros_ec.h
> >                 +++ b/include/linux/mfd/cros_ec.h
> >                 @@ -24,6 +24,7 @@
> >
> >                  #define CROS_EC_DEV_NAME "cros_ec"
> >                  #define CROS_EC_DEV_PD_NAME "cros_pd"
> >                 +#define CROS_EC_DEV_ISH_NAME "cros_ish"
> >
> >                  /*
> >                   * The EC is unresponsive for a time after a reboot command.  Add a
> >                 diff --git a/include/linux/mfd/cros_ec_commands.h
> >                 b/include/linux/mfd/cros_ec_commands.h
> >                 index fc91082..9276c3c 100644
> >                 --- a/include/linux/mfd/cros_ec_commands.h
> >                 +++ b/include/linux/mfd/cros_ec_commands.h
> >                 @@ -856,6 +856,8 @@ enum ec_feature_code {
> >                         EC_FEATURE_RTC = 27,
> >                         /* EC supports CEC commands */
> >                         EC_FEATURE_CEC = 35,
> >                 +       /* The MCU is an Intel Integrated Sensor Hub */
> >                 +       EC_FEATURE_ISH = 40,
> >                  };
> >
> >                  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> >                 --
> >                 1.9.1
> >
