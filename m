Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE722082F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5CVuhy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE722082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeLDQ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:57:48 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45281 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:57:48 -0500
Received: by mail-yb1-f196.google.com with SMTP id f6-v6so7127992ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCS7p2oUjx66hJ77+lGu58JUVmUY8GtbztlPlfo0CmM=;
        b=Y5CVuhy+p/0sP4G5h231KvNTHYU0Jv4vEvxudE0XP8IWmsyJkIM5msQ28kMOgBaP1k
         FDbjomUi2dJYTF6bBzgNburu04Du9T92TnkxgBVefpEFt0SfqDUJ2G+SCKXXk9da8G+3
         Q0qRtWCRMOE1pqunPzh2d/zHW6jkiWcUag6it1N0zqAWTBp3GwhTAeUGSopM92wJ1PGC
         TjUujhu1549+jx8koWluuybgSW4xfdcIVPci8gi1pYWEJTsif4OL26q2urfjnfbDVQ6k
         d7xMHutlYIzKKXtm+BCK2y9COo9CyMyELt7ZNbo3tX4IhQr/Sdzi8PxLh5yUq6Co1ORz
         QYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCS7p2oUjx66hJ77+lGu58JUVmUY8GtbztlPlfo0CmM=;
        b=IDgNlfBUZuG3NPAw3EcE2NTyEp6IoMpWZQjTbxgPmH0LYSvdFfsrEkPhHWSZMgkWJC
         4eO/0dPHwKMgV8TOPs4GpuSWrvHYCmDqK7BqjlAZMPWsRAqUWpx0Dwy7DauZpGGk1Xqm
         1xvjj7vq7QUXN1whtuzp/pMLmB1zpETITOY8TKFr78Qa3NBikKpNOYsIwcZZ6dl34d0u
         MzGzd6jQVBRc/oyxIv1sNBSuKf0aQMsganCioCNsd/80r3ruIMRyibgnMM0Xe+iLwj07
         7kxLR8wgeHOClV7dyAu1rVbBklgFSnH5airqdTruox/GM0oNGCDnKYsQoHV6MsykMr7b
         bdcQ==
X-Gm-Message-State: AA+aEWaUA2dHLWtbLOOpp21HqhqslZDRdhNysZp5ZkfpGrCysMGgQkW4
        Fii6vUsmQQmjFHWLW+NMwH87dTn1tdCZvSZWwdQfSg==
X-Google-Smtp-Source: AFSGD/WRwa3OM7Akz0qL2k0BmK1TtLdrCLZETtSMkKEbwRQhIljltfQdfD8aChFdf03tce2W2QjgS2WLTVS2xurtqX0=
X-Received: by 2002:a5b:74d:: with SMTP id s13mr3418668ybq.414.1543942666472;
 Tue, 04 Dec 2018 08:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-3-enric.balletbo@collabora.com> <20181203103619.GD26661@dell>
 <59c6fa0a-e5d5-0e4a-9393-0c9a8b26332d@collabora.com> <20181204092121.GR26661@dell>
 <8dcf0fb8-697f-8443-68c3-0faae6fe412e@collabora.com>
In-Reply-To: <8dcf0fb8-697f-8443-68c3-0faae6fe412e@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 4 Dec 2018 08:57:35 -0800
Message-ID: <CABXOdTfMC01nmV97x6kKKqavp9qEesXWVYOU3q0ib8hq0_g4+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] mfd / platform: cros_ec: move lightbar attributes
 to its own driver.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 3:52 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Lee,
>
> On 4/12/18 10:21, Lee Jones wrote:
> > On Mon, 03 Dec 2018, Enric Balletbo i Serra wrote:
> >> On 3/12/18 11:36, Lee Jones wrote:
> >>> On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:
> >>>
> >>>> The entire way how cros sysfs attibutes are created is broken.
> >>>> cros_ec_lightbar should be its own driver and its attributes should be
> >>>> associated with a lightbar driver not the mfd driver. In order to retain
> >>>> the path, the lightbar attributes are attached to the cros_class.
> >>>
> >>> I'm not exactly clear on what a lightbar is, but shouldn't it live in
> >>> the appropriate subsystem.  Like LED for example?
> >>>
> >>
> >> The lightbar is a four-color indicator available on some Chromebook, but the
> >> fact that can you can program this lightbar with different sequences, including
> >> user defined sequences makes the device a bit special and very chrome platform
> >> specific. The same happens with the VBC driver.
> >
> > Being Chrome specific doesn't necessarily mean that these drivers
> > shouldn't reside in a proper subsystem.  A lot of drivers in the
> > kernel are only relevant to very specific hardware/platforms.
> >
>
> Agree, and we try to put these drivers in their subsystem when we think it is
> appropriate (we have in rtc, power, iio, keyboard, etc.)
>
> > IMHO code in drivers/platform should pertain only to the core platform
> > itself.  Any drivers for leaf hardware/functionality should be split
> > out into the subsystems, however niche you think they are.
> >
>
> To be honest, I don't have a hard opinion yet on if the drivers/platform should
> pertain only to the core platform itself.
>
> The cros_ec_lightbar.c file already exists in drivers/platform, the patch just
> converts it to a kernel module (only adds few lines). The main purpose of the se
> patches was have cros-ec mfd code and their subdrivers separated instead of
> having crossed calls.
>
> I don't mind to move to another subsystem (I need to discuss with the chromium
> guys and I am still not sure if LED fits very well in this case, I can look in
> more detail) but shouldn't be this a follow up patch?
>

Separate patch, please, if anything.

I would not know which subsystem to move this to, though, and moving
it to misc just for the sake of it would seem odd, since this most
definitely _is_ platform related code. What is platform for if not for
platform specific code ?

> I am also worried on how this could affect the current user interface. Well,
> something to look, right.
>

No ABI changes, please.

Guenter

> Thanks,
>  Enric
>
>
> > I also understand the convenience factor of not having to go through
> > a !Google Maintainer, but this is not a loophole I'm prepared to
> > support. ;)
> >
> >> Other subdevices like, rtc, keyboard, usbpd charger,etc. are already in their
> >> subsystems.
> >>
> >>>> The patch also adds the sysfs documentation.
> >>>>
> >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>> ---
> >>>>
> >>>> Changes in v3:
> >>>> - Removed unneded check for ec_dev.
> >>>>
> >>>> Changes in v2:
> >>>> - Removed the two exported functions to attach/detach to the cros_class.
> >>>> - Use dev_warn instead of dev_err when adding the lightbar.
> >>>>
> >>>>  ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
> >>>>  drivers/mfd/cros_ec_dev.c                     | 24 ++---
> >>>>  drivers/mfd/cros_ec_dev.h                     |  6 --
> >>>>  drivers/platform/chrome/Kconfig               | 10 ++
> >>>>  drivers/platform/chrome/Makefile              |  3 +-
> >>>>  drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
> >>>>  include/linux/mfd/cros_ec.h                   |  1 -
> >>>>  7 files changed, 172 insertions(+), 41 deletions(-)
> >>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
> >>>
> >
