Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E64C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E2521839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544966422;
	bh=V+MtuD+4yvb8DnRWhxcyTlYPxR/MwCtd1AnNw6pXV58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bMbo1mITYy2Xpen0a8abFnyYQgWR0Vb6rU8n0shmPGVY6Mrb8/wI1ntDbcYh0Qq1N
	 ih4O7wI5dEV93oHRIni/yi2FCVUruibGDYNXAnQhUHNcY+IqJs19wRHnmEvAje+gd4
	 SnkgxFhDJdoBmPsKtSVuEZbfXy5BmxshaIi2dX/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeLPNUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:20:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbeLPNUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:20:21 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD977217F9;
        Sun, 16 Dec 2018 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544966420;
        bh=V+MtuD+4yvb8DnRWhxcyTlYPxR/MwCtd1AnNw6pXV58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UK8bw3FeTos5Bc1eaX7eWrePWVH0dT7VTrjm/uF5f7mgfuSL3cndtiUzdyaRSWeQA
         fZqwfioU2LJB7Y90WuOLNi8zUDu+yw7aWgbothLPAmigy/GlqXyBlgfXy4OCV1n/dL
         AR+BnI4lpkliJJXHWIndwtgq3iNjkODRG8+t4+e0=
Date:   Sun, 16 Dec 2018 13:20:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Andreas Brauchli <a.brauchli@elementarea.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: Re: [PATCH v3 1/3] iio: Add modifiers for ethanol and H2 gases
Message-ID: <20181216132003.0fef8896@archlinux>
In-Reply-To: <CAJCx=g=ut+mWUfW=H3AorQiWXSpSd_GgyzV1F4CBatSKhh6qHA@mail.gmail.com>
References: <20181213144323.24820-2-andreas.brauchli@sensirion.com>
        <CAJCx=g=ut+mWUfW=H3AorQiWXSpSd_GgyzV1F4CBatSKhh6qHA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 10:06:39 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Thu, Dec 13, 2018 at 6:44 AM Andreas Brauchli
> <a.brauchli@elementarea.net> wrote:
> >
> > Add ethanol and H2 gas modifiers:
> > * IIO_MOD_ETHANOL  
> 
> Was going to ask why this wasn't a chemical formula like the rest of
> the modifiers, but C2H6O would be a bit wordy/unclear :).
> 
> > * IIO_MOD_H2
> >  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

There was a bit of fuzz due to crossing with the particle sensor.
Note that it changed the enum numbers so you'll need to rebuild
your own tools against the new version of the header.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> > Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
> >  include/uapi/linux/iio/types.h          | 2 ++
> >  tools/iio/iio_event_monitor.c           | 4 ++++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 8127a08e366d..6d64521bf565 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1554,6 +1554,10 @@ What:            /sys/bus/iio/devices/iio:deviceX/in_concentration_raw
> >  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
> >  What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
> >  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
> >  What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
> >  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
> >  KernelVersion: 4.3
> > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > index 92baabc103ac..04a6649fa442 100644
> > --- a/include/uapi/linux/iio/types.h
> > +++ b/include/uapi/linux/iio/types.h
> > @@ -87,6 +87,8 @@ enum iio_modifier {
> >         IIO_MOD_VOC,
> >         IIO_MOD_LIGHT_UV,
> >         IIO_MOD_LIGHT_DUV,
> > +       IIO_MOD_ETHANOL,
> > +       IIO_MOD_H2,
> >  };
> >
> >  enum iio_event_type {
> > diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> > index ac2de6b7e89f..f29c885f4b28 100644
> > --- a/tools/iio/iio_event_monitor.c
> > +++ b/tools/iio/iio_event_monitor.c
> > @@ -114,6 +114,8 @@ static const char * const iio_modifier_names[] = {
> >         [IIO_MOD_I] = "i",
> >         [IIO_MOD_Q] = "q",
> >         [IIO_MOD_CO2] = "co2",
> > +       [IIO_MOD_ETHANOL] = "ethanol",
> > +       [IIO_MOD_H2] = "h2",
> >         [IIO_MOD_VOC] = "voc",
> >  };
> >
> > @@ -199,6 +201,8 @@ static bool event_is_known(struct iio_event_data *event)
> >         case IIO_MOD_I:
> >         case IIO_MOD_Q:
> >         case IIO_MOD_CO2:
> > +       case IIO_MOD_ETHANOL:
> > +       case IIO_MOD_H2:
> >         case IIO_MOD_VOC:
> >                 break;
> >         default:
> > --
> > 2.17.1
> >  

