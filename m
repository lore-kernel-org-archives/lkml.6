Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A18ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7602520673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPpxkuKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7602520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeGRIPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:15:14 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37404 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeGRIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:15:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so6999777oib.4;
        Wed, 18 Jul 2018 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QIi1nNVd+ZW9ksVOv+onXl/YGEjWr2g8jXFH3pZH/0Y=;
        b=ZPpxkuKjMSmn8SgsURQBXEyQh76Icbx8Rg/q4Qe2nAfNYRicB2ulFkV8d+KP6MuecP
         std83c6dopTDN3sdWHiElXe1VCTQuCCjdEGNMp2109B3g4BauroI4oGaJRzKugpYulgO
         0k2HhVgOO5a3uMR4iY8UTuFk4IdlRaDxfk/YLkYmnMKhtpKlfPET7IRHKYHOuK4QzC1u
         5MG3xYhWPOMJKtriQlAcrGeJaKS1t9/F10lujpzlrGShoJBiFIsD8rznFsoJ37IYRss4
         2xz529qb+kSkSP5WnM7Fwx/noMrlivPEZMTlyryu6aodMAXsBnMPMD6YNt+ntQhvCglY
         QFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QIi1nNVd+ZW9ksVOv+onXl/YGEjWr2g8jXFH3pZH/0Y=;
        b=hTHQkj2gLT0LvBDngN9oP3T2krk/OU8C9O3yp53dm/PFCw0RZEDtiHsNIuqOK/HLZj
         cmKwnoLYBZqeGQVxQRKsFWVkIqprIv5tGHhsBllf2Ef7jjKMUbRz6Dy2NfFA9m6BhNyl
         KEKmO5awUk2DMObgG4dQ20tHIqfpnRecAUtJ9xOCQwLloGQKMDJJn5pO95H5wBjGrqDe
         QZZSHrEMR7UJci9bC9xG7ySTrwzpO7vct8cBn7V0kHi0pMlVIbh/GH+ClUCLjJc/QZs2
         e5GH1q9nDogz1u2NGJ80NQmj4Uj/4sojfuaURjn5dtwZfJKzQ1Bw/3NYsoGBGw5JsbG0
         YV4w==
X-Gm-Message-State: AOUpUlGU2COfCrzSLSzpWXbJTpVeyAwWONFqhSB4tYg1/U4W73pY43UG
        NBs3LjKPNWMF12l/1pj+ztRjAnoCMQwmcvLaJXE=
X-Google-Smtp-Source: AAOMgpf6H3xS64A6UP333jMIy2kvcwUfQ9PTqjamPecDkePhsZw+oo9kAi6hBYV15LniII1wStI7bahbtCHhtPWNOlo=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr5051768oif.358.1531899521657;
 Wed, 18 Jul 2018 00:38:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 00:38:41
 -0700 (PDT)
In-Reply-To: <20180717182041.GA18363@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de> <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
 <20180717182041.GA18363@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jul 2018 09:38:41 +0200
X-Google-Sender-Auth: oAy8A0a6jcV3hxOFLTMmzj0MeMg
Message-ID: <CAJZ5v0g8O8J0U8V-gLMe+NnTd3xgZ5_pjr9p2oci7yAfW54B-A@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback recursion
 in suspend/resume paths
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 8:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Tue, Jul 17, 2018 at 12:53:11PM -0400, Lyude Paul wrote:
>> On Tue, 2018-07-17 at 09:16 +0200, Lukas Wunner wrote:
>> > On Mon, Jul 16, 2018 at 07:59:25PM -0400, Lyude Paul wrote:
>> > > In order to fix all of the spots that need to have runtime PM get/puts()
>> > > added, we need to ensure that it's possible for us to call
>> > > pm_runtime_get/put() in any context, regardless of how deep, since
>> > > almost all of the spots that are currently missing refs can potentially
>> > > get called in the runtime suspend/resume path. Otherwise, we'll try to
>> > > resume the GPU as we're trying to resume the GPU (and vice-versa) and
>> > > cause the kernel to deadlock.
>> > >
>> > > With this, it should be safe to call the pm runtime functions in any
>> > > context in nouveau with one condition: any point in the driver that
>> > > calls pm_runtime_get*() cannot hold any locks owned by nouveau that
>> > > would be acquired anywhere inside nouveau_pmops_runtime_resume().
>> > > This includes modesetting locks, i2c bus locks, etc.
>> >
>> > [snip]
>> > > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
>> > > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
>> > > @@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>> > >           return -EBUSY;
>> > >   }
>> > >
>> > > + dev->power.disable_depth++;
>> > > +
>> >
>> > Anyway, if I understand the commit message correctly, you're hitting a
>> > pm_runtime_get_sync() in a code path that itself is called during a
>> > pm_runtime_get_sync().  Could you include stack traces in the commit
>> > message?  My gut feeling is that this patch masks a deeper issue,
>> > e.g. if the runtime_resume code path does in fact directly poll outputs,
>> > that would seem wrong.  Runtime resume should merely make the card
>> > accessible, i.e. reinstate power if necessary, put into PCI_D0,
>> > restore registers, etc.  Output polling should be scheduled
>> > asynchronously.
>>
>> So: the reason that patch was added was mainly for the patches later in the
>> series that add guards around the i2c bus and aux bus, since both of those
>> require that the device be awake for it to work. Currently, the spot where it
>> would recurse is:
>
> Okay, the PCI device is suspending and the nvkm_i2c_aux_acquire()
> wants it in resumed state, so is waiting forever for the device to
> runtime suspend in order to resume it again immediately afterwards.
>
> The deadlock in the stack trace you've posted could be resolved using
> the technique I used in d61a5c106351 by adding the following to
> include/linux/pm_runtime.h:
>
> static inline bool pm_runtime_status_suspending(struct device *dev)
> {
>         return dev->power.runtime_status == RPM_SUSPENDING;
> }
>
> static inline bool is_pm_work(struct device *dev)
> {
>         struct work_struct *work = current_work();
>
>         return work && work->func == dev->power.work;
> }
>
> Then adding this to nvkm_i2c_aux_acquire():
>
>         struct device *dev = pad->i2c->subdev.device->dev;
>
>         if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
>                 ret = pm_runtime_get_sync(dev);
>                 if (ret < 0 && ret != -EACCES)
>                         return ret;
>         }
>
> But here's the catch:  This only works for an *async* runtime suspend.
> It doesn't work for pm_runtime_put_sync(), pm_runtime_suspend() etc,
> because then the runtime suspend is executed in the context of the caller,
> not in the context of dev->power.work.
>
> So it's not a full solution, but hopefully something that gets you
> going.  I'm not really familiar with the code paths leading to
> nvkm_i2c_aux_acquire() to come up with a full solution off the top
> of my head I'm afraid.
>
> Note, it's not sufficient to just check pm_runtime_status_suspending(dev)
> because if the runtime_suspend is carried out concurrently by something
> else, this will return true but it's not guaranteed that the device is
> actually kept awake until the i2c communication has been fully performed.

For the record, I don't quite like this approach as it seems to be
working around a broken dependency graph.

If you need to resume device A from within the runtime resume callback
of device B, then clearly B depends on A and there should be a link
between them.

That said, I do realize that it may be the path of least resistance,
but then I wonder if we can do better than this.

Thanks,
Rafael
