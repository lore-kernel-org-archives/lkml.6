Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3823720C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3823720C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbeGQKoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:44:11 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35586 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbeGQKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:44:11 -0400
Received: by mail-wr1-f41.google.com with SMTP id a3-v6so665838wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dE+XDxdSC/f021lj0P0Gu+LhU4Di4/8WmE9CQmSzMyE=;
        b=FysQYIseuK4LH7MChrHfV79jLXzTQWVfgjFn3AyquM99egBa3oriXDL54bZnFHPZah
         YVSgACm4Ex0c3LZWb9pJOIssq9zKFLlgRvXV+nxwhvKBKA6ckw1JrS44mNJvDQXiapoX
         9nWyW6oSaurGSxfsEFSa6itighV8cNQM99fxDkpCoKNTluLBy5DbUqQvfjjCafNy8zmC
         /1I+Ud9uAoFBWD2bdM2IYuMWkqG772xmrxumGUjtcJc+/VxNP1ZlKWp7vgdj+NvTsGYY
         kyOQ47l/RXUUwQigl1kzUSNNRzXcm3v1iAvmL/i2p1wigQtfP2NsbCJafIts0/QsIIeQ
         FqQg==
X-Gm-Message-State: AOUpUlEO5f3o7mkRu/fqi7FDGBiWDSdUkLg8BsnAgdKcvVTjQd9pt2q3
        rl5gTcsQNYYE1rOuTGpq9j/ivprzInp3wWwZgbV+wQ==
X-Google-Smtp-Source: AAOMgpeCDTG+ZSUqFW6IeiVa8L6zNAayjakJpxkslScFt3Kp4uiM2cGPtUVrK3XyI1WANbkWuQK4I7EmLKByf7+2wGA=
X-Received: by 2002:adf:dc8e:: with SMTP id r14-v6mr870041wrj.166.1531822338540;
 Tue, 17 Jul 2018 03:12:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 03:12:18
 -0700 (PDT)
In-Reply-To: <20180717072152.GA16115@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-3-lyude@redhat.com>
 <20180717072152.GA16115@wunner.de>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 17 Jul 2018 12:12:18 +0200
Message-ID: <CACO55ts2bGfH4GmoXUmHK8=-RzK5x3xHq5ji3Nsuyw+nf13e+Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 2/5] drm/nouveau: Grab RPM ref while probing outputs
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <karolherbst@gmail.com>

On Tue, Jul 17, 2018 at 9:21 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Jul 16, 2018 at 07:59:26PM -0400, Lyude Paul wrote:
>> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> @@ -2012,10 +2012,18 @@ nv50_disp_atomic_state_alloc(struct drm_device *dev)
>>       return &atom->state;
>>  }
>>
>> +static void
>> +nouveau_output_poll_changed(struct drm_device *dev)
>> +{
>> +     pm_runtime_get_sync(dev->dev);
>> +     drm_fb_helper_hotplug_event(dev->fb_helper);
>> +     pm_runtime_put_autosuspend(dev->dev);
>> +}
>> +
>>  static const struct drm_mode_config_funcs
>>  nv50_disp_func = {
>>       .fb_create = nouveau_user_framebuffer_create,
>> -     .output_poll_changed = drm_fb_helper_output_poll_changed,
>> +     .output_poll_changed = nouveau_output_poll_changed,
>
> It might make sense to provide a generic DRM helper for this.
> Same for patch 3 in this series.
>
> Thanks,
>
> Lukas
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
