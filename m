Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C4C21939
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMlYaSQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeLUQjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:39:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42606 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLUQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:39:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so5271742lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77hOC+aRarRpZO88sL6E8aKzVRukop1Y6dKNN3+Oiks=;
        b=dMlYaSQyqiCpp/L5zi86Ze9KJNfFp2U8E28Xx4UiS7T/DEIPH4rvy+KJD5O+6cedp1
         V195qWcJUpOTbdUzdKy166xHWRyDI3RmhuoGGttLn7pQ1120ZbG0K7LMO47u/4EK5C+q
         LKHRTbwtcrazFcAk9pPngbYSaENWuV2qvHopQICXVJ6V6QtVlnrR+5ok7UVNmLR6G2UH
         4bitAhNaqKNk/AGyrwdkJFhla3pDyhx6EA4b+611NQ1T13/xnedZVaaHYKrVo7Ofxy8o
         sbJL/jHiGgRpbHm9UtYlYB1Qqd0YcY4T7jK+n3GiuF0KZUJUPHBitr+xDiIXcpt3MFEr
         js0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77hOC+aRarRpZO88sL6E8aKzVRukop1Y6dKNN3+Oiks=;
        b=s8N3O6e5FkG0t0f2qUVfiJt18AbrI8HXDDsRGx2Vo8EaIbZmhoNkvXFt/S0L1is6QP
         SwZoZdgFhJfN3Ipsji82gOPurxanwaUwrzJgBDXsxy4KZmzfs7GRHW1/D2gph8yoeZBU
         cy7P5bVGyUSc2bGznx7yfLYIytNJxJRmyuAJwPqXSXGRnt9R7nV896UhGthEEgwDmn6P
         G/My6FN+gCP8hF8AOcohs/HrhaAv02hSBAr++c4QQqTnOC8XsRUKgZE/rNcc6pAiUZgu
         CcvwfRT64q7HKBVq4xH9CqcWcBmJzq6hClKMwx7q+v4VlrwPz0oF4V4+GQfXVKliKX51
         piPA==
X-Gm-Message-State: AA+aEWapFcA25w8jSO7XMyGj8zOO+YmuB+DRrWna4Z+wdNzeMoG+jGNz
        l4R0pVpbzxUcpRMn0e0pPAOJhMGnuwGT/oTDftKNtK193/Q=
X-Google-Smtp-Source: ALg8bN7llGC5UqQ8EbOYvbykSwEEJLnRZTPtHpX4aehaGAJ3FVqBPPecaHtbd/vPWSFxjFPe92TDObgwNPxCpxiX/sA=
X-Received: by 2002:a2e:9655:: with SMTP id z21-v6mr2280994ljh.136.1545410351201;
 Fri, 21 Dec 2018 08:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20181221133909.18794-1-christian@brauner.io> <20181221135509.GA30679@kroah.com>
 <20181221141241.gnxoiw7t5ajwcd6d@brauner.io> <20181221153758.GB14584@kroah.com>
 <20181221155918.b3sgv2adx5i74r6i@brauner.io> <20181221163316.GA8517@kroah.com>
In-Reply-To: <20181221163316.GA8517@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 21 Dec 2018 08:38:59 -0800
Message-ID: <CAHRSSEx+gDVW4fKKK8oZNAir9G5icJLyodO8hykv3O0O1jt2FQ@mail.gmail.com>
Subject: Re: [PATCH] binderfs: implement sysctls
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        joel@joelfernandes.org, Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 8:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Dec 21, 2018 at 04:59:19PM +0100, Christian Brauner wrote:
> > On Fri, Dec 21, 2018 at 04:37:58PM +0100, Greg KH wrote:
> > > On Fri, Dec 21, 2018 at 03:12:42PM +0100, Christian Brauner wrote:
> > > > On Fri, Dec 21, 2018 at 02:55:09PM +0100, Greg KH wrote:
> > > > > On Fri, Dec 21, 2018 at 02:39:09PM +0100, Christian Brauner wrote:
> > > > > > This implements three sysctls that have very specific goals:
> > > > >
> > > > > Ick, why?
> > > > >
> > > > > What are these going to be used for?  Who will "control" them?  As you
> > > >
> > > > Only global root in the initial user namespace. See the reasons below. :)
> > > >
> > > > > are putting them in the "global" namespace, that feels like something
> > > > > that binderfs was trying to avoid in the first place.
> > > >
> > > > There are a couple of reason imho:
> > > > - Global root needs a way to restrict how many binder devices can be
> > > >   allocated across all user + ipc namespace pairs.
> > > >   One obvious reason is that otherwise userns root in a non-initial user
> > > >   namespace can allocate a huge number of binder devices (pick a random
> > > >   number say 10.000) and use up a lot of kernel memory.
> > >
> > > Root can do tons of other bad things too, why are you picking on
> >
> > That's global root not userns root though. :) These sysctls are about
> > global root gaining the ability to proactively restrict binder device
> > delegation.
> >
> > > binderfs here?  :)
> > >
> > > >   In addition they can pound on the binder.c code causing a lot of
> > > >   contention for the remaining global lock in there.
> > >
> > > That's the problem of that container, don't let it do that.  Or remove
> > > the global lock :)
> > >
> > > >   We should let global root explicitly restrict non-initial namespaces
> > > >   in this respect. Imho, that's just good security design. :)
> > >
> > > If you do not trust your container enough to have it properly allocate
> > > the correct binder resources, then perhaps you shouldn't be allowing it
> > > to allocate any resources at all?
> >
> > Containers just like VMs get delegated and you might not have control
> > over what is running in there. That's AWS in a nutshell. :) Restricting
> > it by saying "just don't do that" seems not something that is
> > appropriate given the workloads out there in the wild.
> > In general, I do *understand* the reasoning but I think the premise is
> > flawed if we can somewhat trivially make this safe.
> >
> > >
> > > > - The reason for having a number of reserved devices is when the initial
> > > >   binderfs mount needs to bump the number of binder devices after the
> > > >   initial allocation done during say boot (e.g. it could've removed
> > > >   devices and wants to reallocate new ones but all binder minor numbers
> > > >   have been given out or just needs additional devices). By reserving an
> > > >   initial pool of binder devices this can be easily accounted for and
> > > >   future proofs userspace. This is to say: global root in the initial
> > > >   userns + ipcns gets dibs on however many devices it wants. :)
> > >
> > > binder devices do not "come and go" at runtime, you need to set them up
> > > initially and then all is fine.  So there should never be a need for the
> > > "global" instance to need "more" binder devices once it is up and
> > > running.  So I don't see what you are really trying to solve here.
> >
> > That's dismissing a whole range of use-cases where you might allocate
> > and deallocate devices on the fly which this is somewhat designed for.
> > But I guess ok for now.
> >
> > >
> > > You seem to be trying to protect the system from the container you just
> > > gave root to and trusted it with creating its own binder instances.
> > > If you do not trust it to create binder instances then do not allow it
> > > to create binder instances!  :)
> >
> > Again, I get the reasoning but think that this dismisses major
> > real-world use-cases not just for binderfs but for all instances where
> > untrusted workloads are run which both containers and VMs aim to make
> > sure are possible.
> > Note, I mean untrusted not in the sense of necessarily being malicious
> > but just "can't guarantee that things don't blow up in your face".
> >
> > >
> > > > - The fact that we have a single shared pool of binder device minor
> > > >   numbers for all namespaces imho makes it necessary for the global root
> > > >   user in the initial ipc + user namespace to manage device allocation
> > > >   and delegation.
> > >
> > > You are managing the allocation, you are giving who ever asks for one a
> > > device.  If you run out of devices, oops, you run out of devices, that's
> > > it.  Are you really ever going to run out of a major's number of binder
> > > devices?
> >
> > The point is more about someone intentionally trying to do that.
> >
> > >
> > > > The binderfs sysctl stuff is really small code-wise and adds a lot of
> > > > security without any performance impact on the code itself. So we
> > > > actually very strictly adhere to the requirement to not blindly
> > > > sacrifice performance for security. :)
> > >
> > > But you are adding a brand new user/kernel api by emulating one that is
> > > very old and not the best at all, to try to protect from something that
> > > seems like you can't really "protect" from in the first place.
> >
> > Of course we can protect from that. It's about init root never running
> > out of devices. We don't care about non-init-userns running out of
> > devices at all.
> >
> > >
> > > You now have a mis-match of sysctls, ioctls and file operations all
> > > working on the same logical thing.  And all interacting in different and
> > > uncertian ways.  Are you sure that's wise?
> >
> > The sysctl approach is present in other pseudo-filesystems apart from
> > devpts. For example, mqueue.
> >
> > >
> > > If the binderfs code as-is isn't "safe enough" to use without this, then
> > > we need to revisit it before someone starts to use it...
> >
> > *It is safe.* I just don't see a good argument against additional
> > hardening. *But I'm definitely not going to push this patch if it's
> > additional hardening features are used to push the unsound argument that
> > binderfs isn't safe.* :)
>
> Ok, so what you really want is just "limits" to prevent a container from
> doing something really crazy, right?  So, how about a limit of 10 binder
> nodes per container?  Make it a kernel build option so it can be changed
> by a vendor if they really find that is a problem.
>
> Would that solve the issue you are thinking might be here?

We already have CONFIG_ANDROID_BINDER_DEVICES which specifies 3
devices (binder,hwbinder,vndbinder). How about limiting each container
to no more than the number of devices specified there?

>
> thanks,
>
> greg k-h
