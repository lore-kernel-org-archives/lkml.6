Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1AC2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1AC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbeGQMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:42:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55966 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbeGQMml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:42:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so1247231wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 05:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aJ3WmcTuIZHUvZFqzzBPMi3u/VRKHjLVLnRKI8s2avU=;
        b=JelZKxlKk6LMRkzDqQ5j0je95RzYDvwIsxVZklL8dSSJag8VBODRaHSeUSjrBht4eY
         8sdPZYQUiN2P/ewqFdgOq0QK/nNPffiCy0wh/qHoqjkUAO7idTcgQy/X+3/hItQppqZJ
         vKmWfLiMGN0vM2qcuHVr1EZLbIwYshRjr+DnsZ9e5nBOp/GqtyrjVT39jjYep5U7X4zI
         9rfDmU9Ky2OSXJE0uzxnQyx2g8FOJMclYhke9nf58TL2FG8Pfk/87Fx8Unf+hnBnwE0Y
         PIG1Ox6aWFN6XGypZx2n9fBD4kY6z+zssBXEEVZK66zGThKMvbrYzqfGnwya6bfwbgLC
         C/UQ==
X-Gm-Message-State: AOUpUlHqJTN+H4zu0j8S59JVw+AWMpdenIbgNB7v28NhWiodVkhXBWDW
        3u4V2qfih1I2xQ+YDtc8si7yvrrAVFybhztq40HB0g==
X-Google-Smtp-Source: AAOMgpelaz+CkJJPvZAchwegiXopI9SBPM7LrfX3p6sjfvkO1+hciSLsm+C+l6w1oHVmX+MmOtUKRera8vMlH5JxBLs=
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr1134413wmf.1.1531829418423;
 Tue, 17 Jul 2018 05:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:10:17
 -0700 (PDT)
In-Reply-To: <CACAvsv4Rg32Fhq-4yOBWhUooWE+WzG5fQzvN+jYn4Uruc5kDLw@mail.gmail.com>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-5-lyude@redhat.com>
 <CACO55tv9B+GNM=nhpH1UfeWd9F1x5nTp+vHSuJ-TsuzRFK_AEA@mail.gmail.com> <CACAvsv4Rg32Fhq-4yOBWhUooWE+WzG5fQzvN+jYn4Uruc5kDLw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 17 Jul 2018 14:10:17 +0200
Message-ID: <CACO55tvMRd8jpmq8-J4eyqzqHeoVgnbRLYEqvYBhrVJ9O9+gXA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 4/5] drm/nouveau: Grab RPM ref when i2c bus is
 in use
To:     Ben Skeggs <skeggsb@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>, Dave Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 1:54 PM, Ben Skeggs <skeggsb@gmail.com> wrote:
> On Tue, 17 Jul 2018 at 20:18, Karol Herbst <kherbst@redhat.com> wrote:
>>
>> mhh, we shouldn't call to Linux APIs from within of nvkm. Rather gaurd
>> the Linux glue code to the i2c stuff instead, but this is all done
>> from inside of nvkm. I think we should move it out into
>> drm/nouveau/nouveau_i2c.c and do the handling there.
> Huh?  No, this is completely fine.
>

okay, then the the two patches adding that guard code is reviewed-by me

>>
>> On Tue, Jul 17, 2018 at 1:59 AM, Lyude Paul <lyude@redhat.com> wrote:
>> > The i2c bus can be both accessed by DRM itself, along with any of it's
>> > devnodes (/sys/class/i2c). So, we need to make sure that all codepaths
>> > using the i2c bus keep the GPU resumed.
>> >
>> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>> > Cc: Karol Herbst <karolherbst@gmail.com>
>> > Cc: stable@vger.kernel.org
>> > ---
>> >  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c | 12 +++++++++++-
>> >  1 file changed, 11 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
>> > index 807a2b67bd64..1de48c990b80 100644
>> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
>> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c
>> > @@ -119,18 +119,28 @@ nvkm_i2c_bus_release(struct nvkm_i2c_bus *bus)
>> >         BUS_TRACE(bus, "release");
>> >         nvkm_i2c_pad_release(pad);
>> >         mutex_unlock(&bus->mutex);
>> > +       pm_runtime_put_autosuspend(pad->i2c->subdev.device->dev);
>> >  }
>> >
>> >  int
>> >  nvkm_i2c_bus_acquire(struct nvkm_i2c_bus *bus)
>> >  {
>> >         struct nvkm_i2c_pad *pad = bus->pad;
>> > +       struct device *dev = pad->i2c->subdev.device->dev;
>> >         int ret;
>> > +
>> >         BUS_TRACE(bus, "acquire");
>> > +
>> > +       ret = pm_runtime_get_sync(dev);
>> > +       if (ret < 0 && ret != -EACCES)
>> > +               return ret;
>> > +
>> >         mutex_lock(&bus->mutex);
>> >         ret = nvkm_i2c_pad_acquire(pad, NVKM_I2C_PAD_I2C);
>> > -       if (ret)
>> > +       if (ret) {
>> >                 mutex_unlock(&bus->mutex);
>> > +               pm_runtime_put_autosuspend(dev);
>> > +       }
>> >         return ret;
>> >  }
>> >
>> > --
>> > 2.17.1
>> >
>> > _______________________________________________
>> > Nouveau mailing list
>> > Nouveau@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/nouveau
>> _______________________________________________
>> Nouveau mailing list
>> Nouveau@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/nouveau
