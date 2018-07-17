Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3F4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96EF208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zok+z77y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96EF208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbeGQM1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:27:08 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42458 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbeGQM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:27:08 -0400
Received: by mail-ua0-f196.google.com with SMTP id w7-v6so471315uan.9;
        Tue, 17 Jul 2018 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VcyY5bNhPqNiJOLsmcLVEFfrqVl3klrh7MTk9oYxeYQ=;
        b=Zok+z77yEch/vtaBwykWsl39Kb74/7kKhCcp8hLgUY9x8FrNHV6Kl7PKNd4GxRnilo
         g8Acu5NEQ/CY76RsUBVtIk1hRtTPHec38zmvVI40BTMLKiTpr5nlEDLA+9ItDk1PpkUY
         U/1lR6ytsDcv0ezM9e+NRMhJi/Ms5XtAvTHac5o1HiaFCdEYf8r3r9NwzxAEqkYfSglF
         /KWoAi7QXLqFrJ2dyz+im/6VMtyf35a9fLQh/yfPw9YH9Ke9PDfuN1JvF5Lfjg8v4P2z
         GuqrPwfsG5c9x538XluKRua6WTO71mC0HKSO4VTMxpA2+xWCT4pe+zjbY33RQ/Yf71Ii
         sXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcyY5bNhPqNiJOLsmcLVEFfrqVl3klrh7MTk9oYxeYQ=;
        b=MWThU3WE2AC2jV8/G/KTuHR+TRN7E3Kdt1oWsdrLq7UnXJH+S3EWoee7XTM9jPoXhh
         5jdfpREHanXEdLdVgkuTsWRZxxljroWR1rhRcyYZ+k0I2DjNXkyD6JtGjM4jQNrodsEo
         FRnyXF6vyezsHzdyZ10FD6EDmSGo4BcKbgyFE/caw5PNeccxhtTSZF6P5V6KJOUVdUQn
         NafnTd2vGX3cbVI5L/1l4rfKeKxXC1M7qrXZVjW3MtOsx4VeNgFAYtOkClNqofEtWvTL
         4Q6DQweemn0RlWD4fnf/djJkmkmhRJ/PpVs6eqpr6lwa8tfHT/Q85sJjZGnUNOcDtQMY
         URaA==
X-Gm-Message-State: AOUpUlHwFlTcU13xJVWU4rjWUF4RFgtrCh8jhmhgMm62WYZuxVbvJbv1
        oxqDmtsmuPdEAFvlSNDCK0XQfoVRKYMelKf2xBw=
X-Google-Smtp-Source: AAOMgpfRlkRLx3afqbTIzl0ec3XzKGxGRAkXxWa7nTJsYf9s5G7k+vqWJxyjH0J8yRB6Wq/RyeWCfLBx9o/jHQBqXPE=
X-Received: by 2002:ab0:10cc:: with SMTP id x12-v6mr782099uab.55.1531828490342;
 Tue, 17 Jul 2018 04:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-5-lyude@redhat.com>
 <CACO55tv9B+GNM=nhpH1UfeWd9F1x5nTp+vHSuJ-TsuzRFK_AEA@mail.gmail.com>
In-Reply-To: <CACO55tv9B+GNM=nhpH1UfeWd9F1x5nTp+vHSuJ-TsuzRFK_AEA@mail.gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Tue, 17 Jul 2018 21:54:37 +1000
Message-ID: <CACAvsv4Rg32Fhq-4yOBWhUooWE+WzG5fQzvN+jYn4Uruc5kDLw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 4/5] drm/nouveau: Grab RPM ref when i2c bus is
 in use
To:     Karol Herbst <kherbst@redhat.com>
Cc:     lyude@redhat.com, Dave Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 at 20:18, Karol Herbst <kherbst@redhat.com> wrote:
>
> mhh, we shouldn't call to Linux APIs from within of nvkm. Rather gaurd
> the Linux glue code to the i2c stuff instead, but this is all done
> from inside of nvkm. I think we should move it out into
> drm/nouveau/nouveau_i2c.c and do the handling there.
Huh?  No, this is completely fine.

>
> On Tue, Jul 17, 2018 at 1:59 AM, Lyude Paul <lyude@redhat.com> wrote:
> > The i2c bus can be both accessed by DRM itself, along with any of it's
> > devnodes (/sys/class/i2c). So, we need to make sure that all codepaths
> > using the i2c bus keep the GPU resumed.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Karol Herbst <karolherbst@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
> > index 807a2b67bd64..1de48c990b80 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
> > @@ -119,18 +119,28 @@ nvkm_i2c_bus_release(struct nvkm_i2c_bus *bus)
> >         BUS_TRACE(bus, "release");
> >         nvkm_i2c_pad_release(pad);
> >         mutex_unlock(&bus->mutex);
> > +       pm_runtime_put_autosuspend(pad->i2c->subdev.device->dev);
> >  }
> >
> >  int
> >  nvkm_i2c_bus_acquire(struct nvkm_i2c_bus *bus)
> >  {
> >         struct nvkm_i2c_pad *pad = bus->pad;
> > +       struct device *dev = pad->i2c->subdev.device->dev;
> >         int ret;
> > +
> >         BUS_TRACE(bus, "acquire");
> > +
> > +       ret = pm_runtime_get_sync(dev);
> > +       if (ret < 0 && ret != -EACCES)
> > +               return ret;
> > +
> >         mutex_lock(&bus->mutex);
> >         ret = nvkm_i2c_pad_acquire(pad, NVKM_I2C_PAD_I2C);
> > -       if (ret)
> > +       if (ret) {
> >                 mutex_unlock(&bus->mutex);
> > +               pm_runtime_put_autosuspend(dev);
> > +       }
> >         return ret;
> >  }
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > Nouveau mailing list
> > Nouveau@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/nouveau
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
