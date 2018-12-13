Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2999C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793F220879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544717925;
	bh=6gsTu0BOVM6bc1y3s4f2F9ZOfomBhxovJiSFUEK8Ppo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EUQkcX3T1qUj5lv3Kw5HgiZ/Hj/QB9cgoEAMgdqAEGx9M5xwv2U8Ut0tKY7LOiIDr
	 mNispyhxspuOzBYVkQNId+zgf3aVSyuLrOTwdRWB1k1aw/6POh4VcF2ZkT8vrov/rO
	 OStlcZodl251FAJZ6g9a4J3lL80hgJk7bPtKA/Lg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793F220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbeLMQSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:18:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43586 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:18:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so2051284oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJBrH2QhbieiejWYRdO+nAzDS+f3TMMfbklK9XVEN5U=;
        b=QJ3pvo+z/SQUwGFU04LJ1Ej+3O6CL+Z5JhEgqkJxxXJKYhmBo73eUPfGeKYAuUbcdS
         7wv3oWzraqfO5VhLWI+gbxvG2LgoquaX7n++FU1zuMf3UFqRFZ4hz1D8DwRkfH+iYyAs
         zybZflGJCsf7fQEb1tNYQ3h/DmafudVBAsyZlj90q4lnqct/PQbCtvbQBQOk5EpWikEk
         vjIMDUj0VoJUHJD/0jPLe6ANA4vb3N3Zuk+rdg6fpn5Lg4M3EnRK7VcrCxTkb9opddEX
         Y1bhIEiAPoPT6cbRT8yyK0XRzZEjddsYkr2DcqcOq+sigRN7f7XA8OBsngj6Xfr7QnIW
         4Pfg==
X-Gm-Message-State: AA+aEWZd+dhhuoaMl+2HcSxks5pmHmAHkBcn0YqZxBy+SwzlZ+EFC/bN
        c1b7Pp1FkEK0zPHKeYJwQMIG+5j0mcvPprCfu5k=
X-Google-Smtp-Source: AFSGD/WX+AqiXIaMev9It6zUNLyVZtOXZwmwjEpP20C9ts1gi/tmiQWcdGmOLA+CTE4Foaj3bbeyqjsgpK85Yzh6nog=
X-Received: by 2002:aca:195:: with SMTP id 143mr3034418oib.322.1544717922685;
 Thu, 13 Dec 2018 08:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch> <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
 <20181213095814.GC21184@phenom.ffwll.local> <CAJZ5v0iWshem3kuurF53gutVJ8jFm_caAbetK2CiSCpyc6ReeQ@mail.gmail.com>
 <CAKMK7uF7noCEgwE0QYZWQFx-OPxipAF1MojUZ8KTo_SXfQW8+w@mail.gmail.com>
In-Reply-To: <CAKMK7uF7noCEgwE0QYZWQFx-OPxipAF1MojUZ8KTo_SXfQW8+w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 17:18:29 +0100
Message-ID: <CAJZ5v0g+-R8tbbJscL-3s23UPhyNX1v1Lj3aC=QdUBzdSCrspw@mail.gmail.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 1:36 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Thu, Dec 13, 2018 at 11:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Dec 13, 2018 at 10:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Thu, Dec 13, 2018 at 10:38:14AM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Dec 10, 2018 at 9:47 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > > > >
> > > > > Drivers might want to remove some sysfs files, which needs the same
> > > > > locks and ends up angering lockdep. Relevant snippet of the stack
> > > > > trace:
> > > > >
> > > > >   kernfs_remove_by_name_ns+0x3b/0x80
> > > > >   bus_remove_driver+0x92/0xa0
> > > > >   acpi_video_unregister+0x24/0x40
> > > > >   i915_driver_unload+0x42/0x130 [i915]
> > > > >   i915_pci_remove+0x19/0x30 [i915]
> > > > >   pci_device_remove+0x36/0xb0
> > > > >   device_release_driver_internal+0x185/0x250
> > > > >   unbind_store+0xaf/0x180
> > > > >   kernfs_fop_write+0x104/0x190
> > > >
> > > > Is the acpi_bus_unregister_driver() in acpi_video_unregister() the
> > > > source of the lockdep unhappiness?
> > >
> > > Yeah I guess I cut out too much of the lockdep splat. It complains about
> > > kernfs_fop_write and kernfs_remove_by_name_ns acquiring the same lock
> > > class. It's ofc not the same lock, so no real deadlock. Getting the
> > > device_release_driver outside of the callchain under kernfs_fop_write,
> > > which this patch does, "fixes" it. For "fixes" = shut up lockdep.
> >
> > OK, so the problem really is that the operation is started via sysfs
> > which means that this code is running under a lock already.
> >
> > Which lock does lockdep complain about, exactly?
>
> mutex_lock(&of->mutex);

OK (I thought so)

> > > Other options:
> > > - Anotate the recursion with the usual lockdep annotations. Potentially
> > >   results in lockdep not catching real deadlocks (you can still have other
> > >   loops closing the deadlock, maybe through some subsystem/bus lock).
> > >
> > > - Rewrite kernfs_fop_write to drop the lock (optionally, for callbacks
> > >   that know what they're doing), which should be fine if we refcount
> > >   everything properly (bus, driver & device).
> > >
> > > - Also note that probably the same bug exists on the bind sysfs interface,
> > >   but we don't use that, so I don't care :-)
> > >
> > > - Most of these issues are never visible in normal usage, since normally
> > >   driver bind/unbind is done from a kthread or model_load/unload, neither
> > >   of which is running in the context of that kernfs mutex kernfs_fop_write
> > >   holds. That's why I think the task work is the best solution, since it
> > >   changes the locking context of the unbind sysfs to match the locking
> > >   context of module unload and hotunplug.
> >
> > I think that using a task work here makes sense.  There is a drawback,
> > which is that the original sysfs write will not wait for the driver to
> > actually be released before returning to user space AFAICS, but that
> > probably isn't a big deal.
>
> This would happen with a normal work_struct, which runs on some other
> thread eventually. That added asynonchrouns execution uncovered lots
> of bugs in our CI (fbcon isn't solid, let's put it that way). Hence
> the task work, which will be run before the syscall returns to
> userspace, but outside of anything else. Was originally created to
> avoid locking inversion on the final fput, where the same "must
> complete before returning to userspace, but outside of any other
> locking context" issue was causing trouble.

I didn't realize that it would run completely before returning to user
space, thanks for pointing this out.

This isn't an issue then.

> > Also please note that the patch changes the code flow slightly,
> > because passing a non-NULL parent pointer to
> > device_release_driver_internal() potentially has side effects, but
> > that should not be a big deal either.
>
> I can do the old code exactly, but afaict the non-NULL parent just
> takes care of the parent bus locking for us, instead of hand-rolling
> it in the caller. But if I missed something, I can easily undo that
> part.

It is different if device links are present, but I'm not worried about
that case honestly. :-)

> > > Unfortunately that trick doesn't work for the bind sysfs file, since that way we can't thread the errno value back to userspace.
> >
> > Right.  That is unless we wait for the operation to complete and check
> > the error left behind by it.  That should be doable, but somewhat
> > complicated.
>
> For real deadlocks this doesn't fix anything, it just hides it from
> lockdep. cross-release lockdep would still complain. If we want to fix
> the bind side _and_ keep reporting the errno from the driver's bind
> function, then we need to rework kernfs to and add a callback which
> doesn't hold the mutex. Should be doable, just a pile more work.

It should be possible to store the error in a variable and export that
via a separate attribute for user space to inspect.  That would be a
significant I/F change, however.

Cheers,
Rafael
