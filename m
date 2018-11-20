Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED01C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB15208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FXqay7+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB15208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbeKTX1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:27:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44848 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbeKTX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:27:01 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so1257992iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xYww56glHmaqUL8qZwdpmKo2GlLlA/fHeoehGWFaO20=;
        b=FXqay7+RZ1GkCiRG9Dlt5vAptFUKowYFmmfoSnIQxCOHGe1jiJrMLoWNCqWO1oNo7q
         ArrU/bx2O6IHCSTVznGfKZY82LtEqFhP9LWvQ/hctZLfHlwcZNOzW1zsQ9edJCKTBE/R
         HGfRT5KOeGsVPR4IMzcODiRfI1zeXEaCrTEk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xYww56glHmaqUL8qZwdpmKo2GlLlA/fHeoehGWFaO20=;
        b=BJgr/ZutRr9kYeK8rV7w4BqdUlAx/t2T4BcNIx0MAEifrIrcpLqRjc+Vhh2uimy3OC
         Dt1VVtOuxELLgLRIxfCX2lPCEjanEKxZARZClc6k7ry2kstdN4eMEobfYwQKOiSXRmT2
         UIT4AAL8KOSttUl7aQML7WyLn4vyNthVCqqmLzCtdWSbPzUwE0yQz2A9JatI02GYrPSM
         YgvVy5OzvPSe1UrLHdAL9wiN4ZZcJ+BigWWYJxAgbV8Yd//OhpkFRMTw2NXLGSqPGyOo
         fhULSE6Tr0QZtNTtT7s/u3z4SIM4gpbaIuXpVfz9xJFzInfmqJgdcQVsjsMRWbZmPaBM
         oOOQ==
X-Gm-Message-State: AA+aEWZQaFHQd83v8Mkd3HtKMZHHKxEmmDjTmuQLbaNvlfiQe1k6B359
        9FI6ihl/pyYJ8ZQWqvTrmCGkHYVsWRy1XSdZDCQkXw==
X-Google-Smtp-Source: AFSGD/Uc38AWvkmrf4tppr5zqcJ2JMwL5DvvNYVOnGggL7N/uKGIKg/6RtbLAc3em7sbw3zQ69ue64MXrCimP7DPEU0=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr1456405iou.252.1542718680170;
 Tue, 20 Nov 2018 04:58:00 -0800 (PST)
MIME-Version: 1.0
References: <1540887490-28316-1-git-send-email-yong.deng@magewell.com> <CAMty3ZAprBAxAm+=1kpFsbhV3XGvmQ8XEW+6mOcsV5iaR3xNyQ@mail.gmail.com>
In-Reply-To: <CAMty3ZAprBAxAm+=1kpFsbhV3XGvmQ8XEW+6mOcsV5iaR3xNyQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 20 Nov 2018 18:27:48 +0530
Message-ID: <CAMty3ZBa3XwQ-0CDYb69qny2MiaCfx1RiQZvQ+WhkoSonU5CbA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v12 2/2] media: V3s: Add support for
 Allwinner CSI.
To:     Yong Deng <yong.deng@magewell.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        davem@davemloft.net, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        laurent.pinchart@ideasonboard.com, geert@linux-m68k.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        jacopo+renesas@jmondi.org, tglx@linutronix.de,
        todor.tomov@linaro.org, linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 5:38 PM Jagan Teki <jagan@amarulasolutions.com> wro=
te:
>
> On Tue, Oct 30, 2018 at 1:49 PM Yong Deng <yong.deng@magewell.com> wrote:
> >
> > Allwinner V3s SoC features a CSI module with parallel interface.
> >
> > This patch implement a v4l2 framework driver for it.
> >
> > Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
> > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> > ---
> >  MAINTAINERS                                        |   8 +
> >  drivers/media/platform/Kconfig                     |   1 +
> >  drivers/media/platform/Makefile                    |   2 +
> >  drivers/media/platform/sunxi/sun6i-csi/Kconfig     |   9 +
> >  drivers/media/platform/sunxi/sun6i-csi/Makefile    |   3 +
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 915 +++++++++++++=
++++++++
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h | 135 +++
> >  .../media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h | 196 +++++
> >  .../media/platform/sunxi/sun6i-csi/sun6i_video.c   | 678 +++++++++++++=
++
> >  .../media/platform/sunxi/sun6i-csi/sun6i_video.h   |  38 +
> >  10 files changed, 1985 insertions(+)
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/Kconfig
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/Makefile
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_re=
g.h
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.=
c
> >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.=
h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 23021e0df5d7..42d73b35ed3e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3900,6 +3900,14 @@ M:       Jaya Kumar <jayakumar.alsa@gmail.com>
> >  S:     Maintained
> >  F:     sound/pci/cs5535audio/
> >
> > +CSI DRIVERS FOR ALLWINNER V3s
> > +M:     Yong Deng <yong.deng@magewell.com>
> > +L:     linux-media@vger.kernel.org
> > +T:     git git://linuxtv.org/media_tree.git
> > +S:     Maintained
> > +F:     drivers/media/platform/sunxi/sun6i-csi/
> > +F:     Documentation/devicetree/bindings/media/sun6i-csi.txt
> > +
> >  CW1200 WLAN driver
> >  M:     Solomon Peachy <pizza@shaftnet.org>
> >  S:     Maintained
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kc=
onfig
> > index 0edacfb01f3a..be6626ed0ec8 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -138,6 +138,7 @@ source "drivers/media/platform/am437x/Kconfig"
> >  source "drivers/media/platform/xilinx/Kconfig"
> >  source "drivers/media/platform/rcar-vin/Kconfig"
> >  source "drivers/media/platform/atmel/Kconfig"
> > +source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
>
> [snip]
>
> > +
> > +       return 0;
> > +}
> > +
> > +static int sun6i_subdev_notify_complete(struct v4l2_async_notifier *no=
tifier)
> > +{
> > +       struct sun6i_csi *csi =3D container_of(notifier, struct sun6i_c=
si,
> > +                                            notifier);
> > +       struct v4l2_device *v4l2_dev =3D &csi->v4l2_dev;
> > +       struct v4l2_subdev *sd;
> > +       int ret;
> > +
> > +       dev_dbg(csi->dev, "notify complete, all subdevs registered\n");
> > +
> > +       if (notifier->num_subdevs !=3D 1)
>
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c: In function
> =E2=80=98sun6i_subdev_notify_complete=E2=80=99:
> drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:646:14: error:
> =E2=80=98struct v4l2_async_notifier=E2=80=99 has no member named =E2=80=
=98num_subdevs=E2=80=99

This build issues on linux-next, let me know you have next version
changes for this, thanks.
