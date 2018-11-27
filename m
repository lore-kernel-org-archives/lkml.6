Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D432C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1DA20851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="doU47Z+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1DA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeK1JZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:25:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38769 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1JZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:25:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so20828160oii.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxd+1FFVU0mIPHpuQMTGYk+p9A/jMX9bkvy6cSCIj8w=;
        b=doU47Z+wM/j8ePE6AiBBvpTmC6WqNL2zHt5+tWQ83NuUFI+9aHMxnFg/vwLVjw1Ef/
         41/TarAEL+aN1cJFD5/cNZQZRS6gGZrB14kkkVJF+ZkCHreJHVUtMu9G+gfG1e3carYN
         OO7K5JfeqKIsksKcOt1atvIlAZZy/UyeH3uuvCHvrSEsSD4C+j/Ft5oII4bQbnFePk8M
         T3zFkEaniXtkeLKZ+m21oXil/FUo1ynK0dfvidsiX0WHngqWcBfIEefKIx3O0Bo0D8/A
         ixebGh2y5j/51T/Tjl6jPUGCn65YNEt37KS5/C7uIY3U0F7gdjXqMOjpyCaqn62nWZ61
         8zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxd+1FFVU0mIPHpuQMTGYk+p9A/jMX9bkvy6cSCIj8w=;
        b=nUbB+1ZDSSFp9Z91jCHKpGp+elY1eAJabVDa/RHYylwe5KFC2NJAutIM1IwY3tOtOB
         FI4WT55/Im12K2vhWeCxZ+OdhPd8VGPWIuoAaSrRhgG0rOHfbW8u3hj27K6uaIH6WMZ4
         i55fNrUeI+KPGbAy2mje5H+mCvIW0DxnuT/di1YELbMNA5VpKq0SvD93n7SKTWnpMl58
         ptpul2QMZjVbdhmbOtk8jbl3gz8IPGHMVGfOpPFmSwtyyA/plmhG1Nnd/5ZyePhMy70n
         ZkMu1SPt3IV/Pbq3L1krWCepRqgWFDaEjc64/y9U+9j1G4BzftWjDBrL3kB0zp7croDf
         vEgA==
X-Gm-Message-State: AGRZ1gLJQRFYA4woZnG7TvLEzCpLAcIH9cDUMQ8WMoPqBXwQaZNYtjXr
        fsoggP/us9a4crcYdRbyLoPH2LZZkm+kJC/Wx2KjUA==
X-Google-Smtp-Source: AJdET5cORYo3FvqXztUVPGcV55ZqGm18vOYLOGAO72joKCkmXHc84FDg2gx0iy0HxRHmQqRqKb2gv5X2i44lox5EX0I=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr18241847oit.235.1543357585218;
 Tue, 27 Nov 2018 14:26:25 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4ibARHP1Gji2cZQ704BeiKL26Bh13G58eyB+PjQJSD58w@mail.gmail.com>
 <ec672fcf5924ef267f35b11c13ddc50c815b1a9f.camel@linux.intel.com>
 <CAPcyv4gKT1CDA-xVh5LCYEVUeXLB5ktCFqpFhPWzNK7+QbQdvw@mail.gmail.com> <e700da0293e8637e56682a4c4c4c37a2929b5efe.camel@linux.intel.com>
In-Reply-To: <e700da0293e8637e56682a4c4c4c37a2929b5efe.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 14:26:13 -0800
Message-ID: <CAPcyv4ige6rMf24UCsFG+41FZ4rPb1PHPGKAX_Ttj2MoNYgqgQ@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 4/9] driver core: Move async_synchronize_full
 call
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 1:36 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Tue, 2018-11-27 at 12:35 -0800, Dan Williams wrote:
> > On Tue, Nov 27, 2018 at 9:38 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > On Mon, 2018-11-26 at 18:11 -0800, Dan Williams wrote:
> > > > On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> > > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > >
> > > > > Move the async_synchronize_full call out of __device_release_driver and
> > > > > into driver_detach.
> > > > >
> > > > > The idea behind this is that the async_synchronize_full call will only
> > > > > guarantee that any existing async operations are flushed. This doesn't do
> > > > > anything to guarantee that a hotplug event that may occur while we are
> > > > > doing the release of the driver will not be asynchronously scheduled.
> > > > >
> > > > > By moving this into the driver_detach path we can avoid potential deadlocks
> > > > > as we aren't holding the device lock at this point and we should not have
> > > > > the driver we want to flush loaded so the flush will take care of any
> > > > > asynchronous events the driver we are detaching might have scheduled.
> > > > >
> > > >
> > > > What problem is this patch solving in practice, because if there were
> > > > drivers issuing async work from probe they would need to be
> > > > responsible for flushing it themselves. That said it seems broken that
> > > > the async probing infrastructure takes the device_lock inside
> > > > async_schedule and then holds the lock when calling
> > > > async_syncrhonize_full. Is it just luck that this hasn't caused
> > > > deadlocks in practice?
> > >
> > > My understanding is that it has caused some deadlocks. There was
> > > another patch set that Bart Van Assche had submitted that was
> > > addressing this. I just tweaked my patch set to address both the issues
> > > he had seen as well as the performance improvements included in my
> > > original patch set.
> >
> > I tried to go find that discussion, but failed. It would help to
> > report an actual failure rather than a theoretical one.
>
> His patch set can be found at:
> https://patchwork.kernel.org/project/linux-scsi/list/?series=32209&state=*
>
> Your comments can be found in patch 3 on how his set and mine were
> similar, and patch 4 in his set is what I am replacing with patch 4 in
> this set.

Thanks, yeah this little backstory should be summarized / linked in
the patch description for the async scanning ordering change so it's a
chorus of reports about the deficiencies of the current driver-core
implementation.

> Actually just looking at it I should probably pull in his "fixes" tag.

Perhaps also ask Dmitry to re-ack this new one that includes the early sync.

>
> > > > Given that the device_lock is hidden from lockdep I think it would be
> > > > helpful to have a custom lock_map_acquire() setup, similar to the
> > > > workqueue core, to try to keep the locking rules enforced /
> > > > documented.
> > > >
> > > > The only documentation I can find for async-probe deadlock avoidance
> > > > is the comment block in do_init_module() for async_probe_requested.
> > >
> > > Would it make sense to just add any lockdep or deadlock documentation
> > > as a seperate patch? I can work on it but I am not sure it makes sense
> > > to add to this patch since there is a chance this one will need to be
> > > backported to stable at some point.
> >
> > Yes, separate follow-on sounds ok.
> >
> > > > Stepping back a bit, does this patch have anything to do with the
> > > > performance improvement, or is it a separate "by the way I also found
> > > > this" kind of patch?
> > >
> > > This is more of a seperate "by the way" type of patch based on the
> > > discussion Bart and I had about how to best address the issue. There
> > > may be some improvement since we only call async_synchronize_full once
> > > and only when we are removing the driver, but I don't think it would be
> > > very noticable.
> >
> > Ok, might be worthwhile to submit this at the front of the series as a
> > fix that has implications for what comes later. The only concern is
> > whether this fix stands alone. It would seem to make the possibility
> > of ->remove() racing ->probe() worse, no? Can we make this change
> > without the new/proposed ->async_probe tracking infrastructure?
>
> Yeah, I might move this up to patch 1 of the set since this is a fix.
>
> There end up being a ton of bugs in the way this was originally
> handled. So for example if I am not mistaken you only hit the flush if
> we find the dev->driver is already set to the driver we are removing.
> By moving it to where I did and changing the check so that it is based
> on the driver we are removing we can guarantee that we force the flush
> at before we start walking the driver->p->klist_devices list which
> isn't populated until after a device is probed.
>
> As far as ->remove racing with ->probe I don't see this change making
> it any worse than it was. The same race is still there that was there
> before. The only difference is that we don't have the false sense of
> security from having a flush there that doesn't do anything.
>

Ok, makes sense, you can add my Reviewed-by to that resend, because
the fact that the probe takes the device_lock() in the async run queue
and the remove path takes the device_lock() and then flushes the async
run queue is an obvious deadlock.
