Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88296C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4678C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOrUYhwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfB0XFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:05:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35681 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0XFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:05:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id p48so21406139qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 15:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOEO9k3N2MKIqd9s5kKG14zoG/XKVgG5kByloqDGFFo=;
        b=AOrUYhwTeV9drcj7kwy3FTGs4ndSs4gr6UtfsuRBM+wQFH6v1jsX1T8ymQNSmaYA/8
         7nuCwSXqboXawdw7OOiWZccktleQSwcivO9iDyHaiGWMqWLviatluZ/qk+ob304sDzEg
         uBe/QRIwy3bAclsiDWX+pt+Zx+9CBe3DoNl5iY+5SBlpDf2PsqhiRKXCqVsrsuhG7VZD
         +NEs8bKPHAl4+bKcn9ydgrK3h/U+B70jntKigLiFhJR5ucvWLGRapDKOtTO+/b2qOs2m
         yNiiBJIGvPa2DhKDqeWpWdzNGsxrn9NflDHp8xUMbTU2URlMunTD3ZCTnkgrL/7o/b4P
         aTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOEO9k3N2MKIqd9s5kKG14zoG/XKVgG5kByloqDGFFo=;
        b=mJE8X6muNbji0Q+1uAFbD6mBDFbp4L5DQgB9zIHwHkAE+EmnvNMehrpzY80MiGAjsu
         ZTET+FoZUVWN/7GUfrWTCKXeztCUKwEqqlLbNno1kZtYDzMRwqnKBURtrw6+VP0Otsxf
         YwTbfRTEaa0a2rQClpGQ12PseHnhB8eJo1VXOd6mtEP27ANzIMcNNOoK0HBOYkodFB+F
         mwQaYuUFv6rAWqIxYYhTNFi3qYApIQzoDTcnyKnI2LpZvBMX6zGp3bvpwtLVJQyXMesQ
         A1STqIiTAtxX8mqiE/BCsjzYOZts6S+bdm4T1rAp3eVjVXnAiXVzUm6+rM3vvCsOudEu
         Cjqw==
X-Gm-Message-State: AHQUAuaKb6iA4O4QSLlMy9p+qWwWhaus80zibpDHUQ8LPONsbW4LnloG
        kYwuWULF6P5eK2/jRtgbiuZz1c9/DKrs0BdrIng=
X-Google-Smtp-Source: AHgI3IYkBk5FHQbGeUkg/104w8l04qX6WRVAB34bXZdztwNtNuKaFlktRonSAjENRQZb2DANeKLn0FRVbKWJxcynfIk=
X-Received: by 2002:ac8:312c:: with SMTP id g41mr3929762qtb.22.1551308747110;
 Wed, 27 Feb 2019 15:05:47 -0800 (PST)
MIME-Version: 1.0
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CABXOdTdprS1OL534XQq8yHTFDzXdWWODq3VGrSEHYe2wmV5zfg@mail.gmail.com>
 <CAK+PMK67rWZarOV31n=yYbRMq3wo9vDyMTQ93PFZ7PRUMS66Ng@mail.gmail.com>
 <CABXOdTdbev2nKNjocqxOyPcGOU8zbWpQ7uALWZdEHL0CXkYDgA@mail.gmail.com>
 <CAK+PMK5U4YRtJNUbsQu3ARJFxwai7W=DjPfjuX_AZMFcUZ-c_A@mail.gmail.com>
 <39dc9be2-808e-4800-b4bb-605d5bf94e12@collabora.com> <CAK+PMK4ov8jJh7wZoTErikuztf=eOruG8xYt6umjt35f9EaGaA@mail.gmail.com>
 <3959820e-cf43-2370-7cea-7afd01b2933c@collabora.com> <CAMHSBOXF_PtSTpcnVcJE7bMRA85TCqZdJL3Md4Z_Cd4Djjkw1A@mail.gmail.com>
In-Reply-To: <CAMHSBOXF_PtSTpcnVcJE7bMRA85TCqZdJL3Md4Z_Cd4Djjkw1A@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Feb 2019 00:05:35 +0100
Message-ID: <CAFqH_53CF2rOVt8G=amQXC2_0mNXZw2m8_kvkM2wMjx6GyWSaQ@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jett Rink <jettrink@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        andriy.shevchenko@intel.com, Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dc., 27 de
febr. 2019 a les 19:37:
>
> On Wed, Feb 27, 2019 at 10:08 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Jett,
> >
> > Many thanks for the explanation.
> >
> > On 27/2/19 16:13, Jett Rink wrote:
> > > The diagram you provided is correct.
> > >
> > > The ISH device is a MCU that can run general purpose code that is
> > > located on the SoC. Typically the ISH collects sensor data and
> > > processes it before giving it to the AP. The ISH HW can run any RTOS,
> > > and in this scenario we are choosing to run the ECOS RTOS. In doing
> > > so, we have access to the standard cros_ec command interface for
> > > communication between the AP and ISH. This is helpful because we have
> > > sensors drivers (Cros EC IIO Sensors) that depend on the cros_ec
> > > command interface.
> > >
> > > The idea behind using a different sysfs path was to ensure that there
> > > weren't any unintended consequences by adding a cros_ec device when
> > > the ISH doesn't support most of the EC type tasks. Here are a few
> > > examples:
> > >  - Mosys tool is specifically trying to talk with an EC:
> > > https://chromium.googlesource.com/chromiumos/platform/mosys/+/152a306a82009cd6ca68760b0902fc03781e0d5d/platform/daisy/ec.c#41
> > >  - The ectool is specifically trying to talk with an EC:
> > > https://chromium.googlesource.com/chromiumos/platform/ec/+/a3c27b39fa69f280a3728a5cf24de57a5d3ccb0d/util/ectool.c#8546
> That's the default, we can override the name with --name option.
> > >
> > > At least on active project, there has already been confusion that the
> > > normal ectool program doesn't work because the EC on the system is 3rd
> > > party and does not support the normal cros_ec interface. This
> > > confusion would compound if the ISH started presenting the cros_ec
> > > interface and the ectool started talking to the ISH instead of the 3rd
> > > party EC. Maybe we just need to modify ectool to make that situation
> > > less confusing, but this is an example of the cross over using the
> > > cros_ish device name is trying to avoid.
> > >
> >
> > IMHO the problem with names is that is not really scalable, right now, we have
> >
> > /sys/class/chromeos/cros_ec
> > /dev/cros_ec
> >
> > and
> >
> > /sys/class/chromeos/cros_pd
> > /dev/cros_pd
> >
> > but looks like, apart from this, we will have
> >
> > /sys/class/chromeos/cros_ish
> > /dev/cros_ish
> >
> > And a lot more: cros_fp, cros_tp, cros_scp, etc
> >
> >
> > I was thinking in a solution more scalable where all the cros-ec are enumerated
> > by an index, so is more generic. So in a system with 2 cros-ec you'll have
> >
> > /sys/class/chromeos/cros_ec0
> > /dev/cros_ec0
> >
> > /sys/class/chromeos/cros_ec1
> > /dev/cros_ec1
> >
> > ...
> >
> > In such case, from userspace point of view, when you open the device you can
> > send the EC_CMD_GET_FEATURES and know which EC is under the device.
> >
> > One of the problems I see is that some old ECs (cros_pd I guess) doesn't
> > implement that command, in such case maybe we can continue using the name to
> > differentiate from other ECs.
> >
> > I'm unsure yet of the impact of this change though, so I'd like to listen
> > Guenter and Benson opinions here :)
>
> You're right, the cros_ names are based on what the EC provides.
> cros_ec for generic EC, fp, tp for fingerprint, touch pad
> respectively.
> ish is for standalone sensor hub [it does not have to be Intel Sensor Hub].
>

Thanks for the explanation. I didn't know that and I assumed the 'i'
was for 'intel', maybe would be good call cros_ssh or cros_sh to avoid
confusion?

> ChromeOS user space tool are using the cros_XX names directly, like
> biod is using cros_fp.
>
> I agree the number of standalone EC in the system is increasing, but
> it is still bounded.

Let me ask another question :)

I understand different names based on what the EC provides. Is this
also the case for the cros_scp? In other words, will cros_ec and
cros_scp co-exist and provide different functionalities than ec, fp,
tp or standalone sensor hub?

Thanks,
Enric

> Gwendal.
>
>
>
> >
> > Will this solution work for you? Do you see any problem?
> >
> >
> > > At this point though, we will definitely follow the guidance of people
> > > more experienced in kernel design. If using cros_ish as a device name
> > > instead of cros_ec is actually not a good idea, then we can accept
> > > that and move forward and try to see what the fallout is from
> > > userspace tools.
> > >
> > > -Jett
> > >
> > >
> > > On Wed, Feb 27, 2019 at 7:22 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On 26/2/19 18:21, Jett Rink wrote:
> > >>> We are specifically wanting userspace applications to not worry/confuse cros_ish
> > >>> with a normal cros_ec. Adding an attribute instead of changing the path would
> > >>> make it easy for userspace application to forget to check properly before
> > >>> accessing the ish as an EC when it shouldn't.
> > >>>
> > >>> On Mon, Feb 25, 2019 at 4:37 PM Guenter Roeck <groeck@google.com
> > >>> <mailto:groeck@google.com>> wrote:
> > >>>
> > >>>     On Mon, Feb 25, 2019 at 3:22 PM Jett Rink <jettrink@chromium.org
> > >>>     <mailto:jettrink@chromium.org>> wrote:
> > >>>
> > >>>         A cros_ec and cros_ish device could both be present on the same system.
> > >>>         We want to change the device path to ensure that drivers/code further up
> > >>>         the stack does not get confuse the ISH with as an EC.
> > >>>
> > >>>         The ISH device can export a similar sysfs interface as they both use the
> > >>>         same command interface for communication (although they will use
> > >>>         different transport layers). The common cros code will detect certain
> > >>>         EC_FEATURES and enable the correct subsystem based on the level of
> > >>>         functionality the device supports. In the case of the ISH, the sensor
> > >>>         subsystem will be enabled.
> > >>>
> > >>>     Seems to me it would make more sense to handle that difference with a sysfs
> > >>>     attribute (instead of forcing each userspace application to support multiple
> > >>>     sysfs paths).
> > >>>
> > >>
> > >> Is still unclear to me what's that ISH device, so I'd appreciate if you can give
> > >> some more background. Trying to understand the topology, makes sense that block
> > >> diagram to you?
> > >>
> > >>
> > >>        ---------------------------
> > >>       |  User Space Applications  |
> > >>        ---------------------------
> > >>
> > >> ----------------IIO ABI----------------
> > >>
> > >>        -----------------------------
> > >>       |  CrOS EC IIO Sensor Drivers |
> > >>        -----------------------------
> > >>
> > >>        --------------------------
> > >>       |  CrOS EC over ISH Driver |
> > >>        --------------------------
> > >>
> > >> ---------------- OS ------------------
> > >>
> > >>        --------------------------
> > >>       |     CrOS EC Firmware     |
> > >>        --------------------------
> > >>
> > >>        --------------------------
> > >>       | ISH Hardware/Firmware    |
> > >>        --------------------------
> > >>
> > >> So I'm right assuming that this CrOS EC will implement only the sensor features?
> > >>
> > >> And then, the system will have another CrOS EC implementing other features like
> > >> RTC, USBPD-charger, etc?
> > >>
> > >> Apart from the sensors features, will the CrOS EC ISH implement other features?
> > >>
> > >> I'm a bit worried about the increasing way to use a particular name for
> > >> different CrOS EC, actually we have only cros_ec and cros_pd. But in the
> > >> chromeos kernels there is /dev/cros_fp, /dev/cros_tp, /dev/cros_ish,
> > >> /dev/cros_scp and who knows how many more in the future. So I'm wondering if
> > >> wouldn't be better use standard names, i.e /dev/cros_ec0, /dev/cros_ec1, etc. as
> > >> userspace, for those cases, should be able to query the EC_FEATURE_ISH/FP/TP/SCP
> > >> and know against which EC the device is attached.
> > >>
> > >> Cheers,
> > >> Enric
> > >>
> > >>>     Guenter
> > >>>
> > >>>
> > >>>         -Jett
> > >>>
> > >>>         On Sun, Feb 24, 2019 at 4:03 PM Guenter Roeck <groeck@google.com
> > >>>         <mailto:groeck@google.com>> wrote:
> > >>>
> > >>>             On Sun, Feb 24, 2019 at 1:14 AM Rushikesh S Kadam
> > >>>             <rushikesh.s.kadam@intel.com <mailto:rushikesh.s.kadam@intel.com>>
> > >>>             wrote:
> > >>>
> > >>>                 Intel Integrated Sensor Hub (ISH) is also a MCU running EC
> > >>>                 having feature bit EC_FEATURE_ISH. Instantiate it as a special
> > >>>                 CrOS EC device with device name 'cros_ish'.
> > >>>
> > >>>
> > >>>             The type of MCU doesn't really have to be reflected in the sysfs
> > >>>             directory path. cros_ec uses different
> > >>>             MCUs over time.
> > >>>
> > >>>             Will the new path exist in parallel with cros_ec (in other words,
> > >>>             will there also be a stand-alone EC in the same system) ? Does it
> > >>>             have different or the same sysfs attributes as cros_ec ?
> > >>>
> > >>>             Also,, what is the impact on userspace ?
> > >>>
> > >>>             Thanks,
> > >>>             Guenter
> > >>>
> > >>>                 Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com
> > >>>                 <mailto:rushikesh.s.kadam@intel.com>>
> > >>>                 ---
> > >>>                  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
> > >>>                  include/linux/mfd/cros_ec.h          |  1 +
> > >>>                  include/linux/mfd/cros_ec_commands.h |  2 ++
> > >>>                  3 files changed, 13 insertions(+)
> > >>>
> > >>>                 diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > >>>                 index 2d0fee4..be499b8 100644
> > >>>                 --- a/drivers/mfd/cros_ec_dev.c
> > >>>                 +++ b/drivers/mfd/cros_ec_dev.c
> > >>>                 @@ -414,6 +414,16 @@ static int ec_device_probe(struct
> > >>>                 platform_device *pdev)
> > >>>                         device_initialize(&ec->class_dev);
> > >>>                         cdev_init(&ec->cdev, &fops);
> > >>>
> > >>>                 +       /* check whether this is actually a Intel ISH rather
> > >>>                 than an EC */
> > >>>                 +       if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
> > >>>                 +               dev_info(dev, "Intel ISH MCU detected.\n");
> > >>>                 +               /*
> > >>>                 +                * Help userspace differentiating ECs from ISH MCU,
> > >>>                 +                * regardless of the probing order.
> > >>>                 +                */
> > >>>                 +               ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
> > >>>                 +       }
> > >>>                 +
> > >>>                         /*
> > >>>                          * Add the class device
> > >>>                          * Link to the character device for creating the /dev entry
> > >>>                 diff --git a/include/linux/mfd/cros_ec.h
> > >>>                 b/include/linux/mfd/cros_ec.h
> > >>>                 index de8b588..00c5765 100644
> > >>>                 --- a/include/linux/mfd/cros_ec.h
> > >>>                 +++ b/include/linux/mfd/cros_ec.h
> > >>>                 @@ -24,6 +24,7 @@
> > >>>
> > >>>                  #define CROS_EC_DEV_NAME "cros_ec"
> > >>>                  #define CROS_EC_DEV_PD_NAME "cros_pd"
> > >>>                 +#define CROS_EC_DEV_ISH_NAME "cros_ish"
> > >>>
> > >>>                  /*
> > >>>                   * The EC is unresponsive for a time after a reboot command.  Add a
> > >>>                 diff --git a/include/linux/mfd/cros_ec_commands.h
> > >>>                 b/include/linux/mfd/cros_ec_commands.h
> > >>>                 index fc91082..9276c3c 100644
> > >>>                 --- a/include/linux/mfd/cros_ec_commands.h
> > >>>                 +++ b/include/linux/mfd/cros_ec_commands.h
> > >>>                 @@ -856,6 +856,8 @@ enum ec_feature_code {
> > >>>                         EC_FEATURE_RTC = 27,
> > >>>                         /* EC supports CEC commands */
> > >>>                         EC_FEATURE_CEC = 35,
> > >>>                 +       /* The MCU is an Intel Integrated Sensor Hub */
> > >>>                 +       EC_FEATURE_ISH = 40,
> > >>>                  };
> > >>>
> > >>>                  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> > >>>                 --
> > >>>                 1.9.1
> > >>>
