Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789362084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ac7Be+AJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789362084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeLLMkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:40:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33692 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLLMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:40:22 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so13566796itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boR9c9u8Am9Vj/CjpWoSI+S+MS1F9PdDrkQuO529r4k=;
        b=ac7Be+AJyyRqUqNMcUK4dviqeMqymcf54Jx3HCAhkWymdB2GbM1V/MU0tU3tPeeXb/
         MYoDcf7Rg4DgLkYRZxuDYbkqycFhmrbST07Y3zxmiAxHfRLuhIMlwJ9Aolk9r7Ph0rkK
         4rqvvuRlZOv/sOsstu76LhQ6dBGCIS66bBsDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boR9c9u8Am9Vj/CjpWoSI+S+MS1F9PdDrkQuO529r4k=;
        b=Rk9twP/RN9eu2xXEw7l9eWCAplAemqKxUaiCT9kH2wkR4PNqmDiomNHKsgkBsPoCu9
         56rk1NAw8dS6ZBGb8A9x65jsdb4AXhD33GlCroSJ1qYXQWdnJlVjt2q5FO/JUwIf3kyL
         vfv+WwEAGH1X6RSZDjYymv/8y3jrDQZ2EYW5xzQJPdBuxM3+GJInJ1wditf2FS45WqCH
         W/4BYdUAbB5oK9PBTsAty/LWWqllsAMJLgGUVtt2jB/0CYUPcPA1EhIgaYVIy+MyqIlS
         +02Gf51ZgyLWWfgMBgV4PYmrv6LX0im8wXpXp/Lo+aU5ni2EJcncKbJAgDTs9b579HAB
         ahgw==
X-Gm-Message-State: AA+aEWauWwKZzd339RSn1Sst7tqsvoez0wtAl7yX72g+DW9rVjpJX9e5
        206v+m2rG8sn01wbfaNtVDKcgog5IjgjisComuF/MySVsrs=
X-Google-Smtp-Source: AFSGD/VH12xZtTDza5wLZf+blIb/oCJUrhAXWaa/LDyEatIg1RDRs7DBDaCix/CZ1WLFb3o7JHl7s0IY6sATxy80vRQ=
X-Received: by 2002:a24:94cb:: with SMTP id j194mr5670235ite.117.1544618421460;
 Wed, 12 Dec 2018 04:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch> <20181210100634.GA8836@kroah.com>
 <20181210101832.GN21184@phenom.ffwll.local> <20181210102058.GO21184@phenom.ffwll.local>
 <20181212110840.GA21184@phenom.ffwll.local> <20181212111947.GA12685@kroah.com>
In-Reply-To: <20181212111947.GA12685@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 12 Dec 2018 13:40:09 +0100
Message-ID: <CAKMK7uF2wHUw8yvpXeUNvt-UTn0K-TC+O+DwsVd7eo7rJ0KBiw@mail.gmail.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 12, 2018 at 12:08:40PM +0100, Daniel Vetter wrote:
> > On Mon, Dec 10, 2018 at 11:20:58AM +0100, Daniel Vetter wrote:
> > > On Mon, Dec 10, 2018 at 11:18:32AM +0100, Daniel Vetter wrote:
> > > > On Mon, Dec 10, 2018 at 11:06:34AM +0100, Greg Kroah-Hartman wrote:
> > > > > On Mon, Dec 10, 2018 at 09:46:53AM +0100, Daniel Vetter wrote:
> > > > > > Drivers might want to remove some sysfs files, which needs the same
> > > > > > locks and ends up angering lockdep. Relevant snippet of the stack
> > > > > > trace:
> > > > > >
> > > > > >   kernfs_remove_by_name_ns+0x3b/0x80
> > > > > >   bus_remove_driver+0x92/0xa0
> > > > > >   acpi_video_unregister+0x24/0x40
> > > > > >   i915_driver_unload+0x42/0x130 [i915]
> > > > > >   i915_pci_remove+0x19/0x30 [i915]
> > > > > >   pci_device_remove+0x36/0xb0
> > > > > >   device_release_driver_internal+0x185/0x250
> > > > > >   unbind_store+0xaf/0x180
> > > > > >   kernfs_fop_write+0x104/0x190
> > > > > >
> > > > > > I've stumbled over this because some new patches by Ram connect the
> > > > > > snd-hda-intel unload (where we do use sysfs unbind) with the locking
> > > > > > chains in the i915 unload code (but without creating a new loop),
> > > > > > which upset our CI. But the bug is already there and can be easily
> > > > > > reproduced by unbind i915 directly.
> > > > >
> > > > > This is odd, why wouldn't any driver hit this issue?  And why now since
> > > > > you say this is triggerable today?
> > > >
> > > > The above backtrace is triggered by unbinding i915 on current upstream
> > > > kernels. Note: Will crash later on rather badly in the
> > > > fbdev/fbcon/vtconsole hell, but that's separate issue (which can be worked
> > > > around by first unbinding fbcon manually through sysfs).
> > > >
> > > > > I know scsi was doing some strange things like trying to remove the
> > > > > device itself from a sysfs callback on the device, which requires it to
> > > > > just call a different kobject function created just for that type of
> > > > > thing.  Would that also make sense to do here instead of your workqueue?
> > > >
> > > > Note how we blow up on unregistering sw device instances supported by i915
> > > > in entirely different subsystems. I guess most drivers just have sysfs
> > > > files for their own stuff, where this is done as you describe. The problem
> > > > is that there's an awful lot of unrelated stuff hanging off i915.
> > > >
> > > > Or maybe acpi_video is busted, and should be using a different function.
> > > > You haven't said which one, and I have no idea which one it is ...
> > > >
> > > > And in case the context wasn't clear: This is unbinding the i915 pci
> > > > driver which triggers the above lockdep splat recursion.
> > >
> > > btw another option for "fixing" this would be to annotate the mutex_lock
> > > in kernfs_remove_by_name_ns as recursive. Which just shuts up lockdep (and
> > > might hide some real bugs), but would get the job done since there's not
> > > actually a deadlock here. Just lockdep being annoyed.
> >
> > So what's the pick? I can do the typing, but I don't understand all the
> > driver core interactions to know what we should be doing here best.
>
> Sorry for the delay.
>
> Look at sdev_store_delete() in drivers/scsi/scsi_sysfs.c and see if the
> logic there makes sense to do here instead.

This looks interesting, but it doesn't solve the problem. The issue is
_not_ that we remove the same sysfs file as the one we're writing
into. It's that we're removing an entirely unrelated sysfs file, which
will not cause a deadlock per se, but triggers lockdep because it's in
the same locking class (note how the locking recusion is within one
callchain, this would deadlock right away if it's the same file, but
unloading happily continues).

> It still seems odd that removing a sysfs file by writing to a sysfs file
> at the same level really invokes lockdep as I would have thought that
> this path is well-tested by now.

Iirc has been around forever for gpu drivers. Just never bothered to
fix it, because there's much bigger issues in hotunplug for gpu
drivers. Only reason we use unbind in CI is because it's the simplest
way to get userspace off the snd-hda-intel driver (which needs to be
unloaded before i915, if you want to unload that).
-Daniel

>
> thanks,
>
> greg k-h
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
