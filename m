Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE4C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91A120020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVN3rl64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91A120020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeFTU56 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:57:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35625 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeFTU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:57:57 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so1387618lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xx/ehL8fy/t4ymEOYTThRAQrpQ+hwb/Wv9n8i0S9Yo8=;
        b=aVN3rl64bLivDbMdM8y6yasxM241LL7SWDIMvpWBNH7OLYAabbYGYs2MtzmZce0lRq
         MUSPvYrJZawdryf1r2XB3WodlfcAlV8jpu7p60AGeSOyC+0jXkwlxGDSglpdpGhDownV
         NP9GfDw5k6DQ7QkMmbYHMs/ZlKiWnnheIsUeFRcTiLYN/426DxbO5hkRjMtWMwNJfFNx
         na6lSSCJhWzu3cAapj9ENc2LL6TPgw5LPZj5ypTD18TVyXZcf2yZY0ceZQMfm+mxIGPo
         kmKeSOErlqhCjKaC4sdddCsHvwb4jXbCD6H0XxLjooPm/5EsTgAQM8B8kL2mXh+JlKNT
         uxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xx/ehL8fy/t4ymEOYTThRAQrpQ+hwb/Wv9n8i0S9Yo8=;
        b=GkA7NimyH/crsD5A/3r8ggWt6UdLbyD/qKeSHLW+S8acvwp+YG786POi8C3HKvWidq
         pMueUb+J8MNH46njGgfkptJezVvxyqKHCWKKieikOo+qanj6QVI6UY4sQnAUyOb0HAn2
         Ci2p23VtcN8ENnyREmDLlNM0g9PPsGJ110x8jjKfpEemzCMs24+g3QFA+Pyo78w6HGDJ
         TLIXdJzxjNNtmuHwVyxnc34PBeMlhBxiE5uItXOJjlpVoaEL2n0vtXmCfMV6uiRZ+k0E
         /KkhWbCYwBbHaQI0DfC21YNvQIFJpmM/KlrFO0r0615qxshRjxPHMZshTbVJY/dMwmZr
         TIUA==
X-Gm-Message-State: APt69E213KiMgvk9bI0ut6gc/hD368SREH/r8WNDENyf0p8xUlnQy6N7
        10MZYTHyOlUNozxAXfEjWb9BmYbPi6f+keTT8Bw=
X-Google-Smtp-Source: ADUXVKK98LdyW012fyUqNHjb7PReq8mbkoZ1mXW9cEkHyJz/s/kVjxRzb8MGs2Lh3a4alyJWoRx44p5ocweuqXrcafk=
X-Received: by 2002:a19:ccc6:: with SMTP id c189-v6mr4896001lfg.88.1529528275538;
 Wed, 20 Jun 2018 13:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHSBOUtysO1Mj6stn1_wQ95s7mH5LuKD_Yd-4YZr7m7rCDkSQ@mail.gmail.com>
 <20180605004354.247410-1-egranata@google.com> <20180618063534.GG31141@dell>
In-Reply-To: <20180618063534.GG31141@dell>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 20 Jun 2018 13:57:44 -0700
Message-ID: <CAKdAkRSm0kRuNSjGd8rGuvK-k4j8SjCyqDSDjDyKTpP21hNP6Q@mail.gmail.com>
Subject: Re: [PATCH v3] cros_ec: cleanup dependency chain for cros_ec modules
To:     Lee Jones <lee.jones@linaro.org>, egranata@google.com
Cc:     lkml <linux-kernel@vger.kernel.org>, egranata@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 11:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 04 Jun 2018, Enrico Granata wrote:
>
> > From: Enrico Granata <egranata@chromium.org>
> >
> > If one builds the Chrome EC support as modules, there is no explicit
> > dependency chain amongst the several modules (LPC, CHARDEV, CORE, ...)
> >
> > This makes it possible - for instance - to rmmod cros_ec_core, even though
> > cros_ec_dev actively uses it for data transport to the EC chip.
> >
> > This commit makes two changes in an attempt to address this:
> > a) moves cros_ec_proto.c as part of the CORE module; this removes the
> >    possibility of unloading cros_ec_core while cros_ec_dev is using it;
> > b) enables cros_ec_core to explicitly register a runtime dependency on
> >    the kernel module that is using its cmd and pkt transfer functions
> >
> > Series-to: LKML <linux-kernel@vger.kernel.org>
> > Series-cc: gwendal@google.com
> > Signed-off-by: Enrico Granata <egranata@chromium.org>
> > ---
> >  drivers/mfd/Kconfig                              |  1 -
> >  drivers/mfd/Makefile                             |  2 +-
> >  drivers/mfd/cros_ec.c                            | 18 ++++++++++++++++--
> >  drivers/mfd/cros_ec_i2c.c                        |  1 +
> >  drivers/{platform/chrome => mfd}/cros_ec_proto.c |  0
> >  drivers/mfd/cros_ec_spi.c                        |  1 +
> >  drivers/platform/chrome/Kconfig                  |  5 -----
> >  drivers/platform/chrome/Makefile                 |  1 -
> >  drivers/platform/chrome/cros_ec_lpc.c            |  1 +
> >  include/linux/mfd/cros_ec.h                      |  2 ++
> >  10 files changed, 22 insertions(+), 10 deletions(-)
> >  rename drivers/{platform/chrome => mfd}/cros_ec_proto.c (100%)
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index b860eb5aa194..a8daa2072ae6 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -194,7 +194,6 @@ config MFD_CROS_EC
> >       tristate "ChromeOS Embedded Controller"
> >       select MFD_CORE
> >       select CHROME_PLATFORMS
> > -     select CROS_EC_PROTO
> >       depends on X86 || ARM || ARM64 || COMPILE_TEST
> >       help
> >         If you say Y here you get support for the ChromeOS Embedded
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index d9d2cf0d32ef..20537bd27695 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -12,7 +12,7 @@ obj-$(CONFIG_MFD_SM501)             += sm501.o
> >  obj-$(CONFIG_MFD_ASIC3)              += asic3.o tmio_core.o
> >  obj-$(CONFIG_MFD_BCM590XX)   += bcm590xx.o
> >  obj-$(CONFIG_MFD_BD9571MWV)  += bd9571mwv.o
> > -cros_ec_core-objs            := cros_ec.o
> > +cros_ec_core-objs            := cros_ec.o cros_ec_proto.o
> >  cros_ec_core-$(CONFIG_ACPI)  += cros_ec_acpi_gpe.o
> >  obj-$(CONFIG_MFD_CROS_EC)    += cros_ec_core.o
> >  obj-$(CONFIG_MFD_CROS_EC_I2C)        += cros_ec_i2c.o
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index d61024141e2b..9660dc0fc079 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -168,8 +168,19 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >        */
> >       err = cros_ec_sleep_event(ec_dev, 0);
> >       if (err < 0)
> > -             dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
> > -                     err);
> > +             dev_dbg(dev, "Error %d clearing sleep event to ec", err);
>
> This change is unrelated to the patch.
>
> > +     if (ec_dev->xfer_fcn_owner != NULL) {
>
> if (ec_dev->xfer_fcn_owner) ?
>
> > +             err = try_module_get(ec_dev->xfer_fcn_owner);
> > +             if (err < 0) {
>
> This logic is wrong.  try_module_get() returns a bool.

I do not think this is needed at all: the transport drivers (i2c, api)
are using cros_ec_register() provided by cros_ec core, which should
bump up refcount on cros_ec core module preventing it from unloading.
And unloading transport driver should unregister EC instance, stopping
IO.

If cros_ec_dev is not prepared to handle "dead" devices - it is issue
for cros_ec_dev to solve. By the way, it is not solvable my
disallowing module unloading: one can always tear down a device by
manually unbinding driver via sysfs.

Thanks.

-- 
Dmitry
