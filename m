Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5B9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rfoQyqby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5B9208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeK1Hei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:34:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33536 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeK1Heh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:34:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so21467864otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+l9adJfJvn/S+/QVfIXrlbiImSIuIuSN2cnYdrdxKpU=;
        b=rfoQyqbyJszbbW0CRwugbDlb3jNTb7pjXjuJ0mlGV9+vVymsr2jOVx5s53/QfcVZOa
         sizCfLhjjP156OpjgKc4DmBA0xHbiD7vyBV58MkiL+KqCboSPli2x2rtU/YWczrC7Hqa
         UfSr3KCoFsZUWwqhJQ9vbli6X2OmxX2BkaJwUIOKn8chFdj9DJbvjDL/r2E3wQyGrrwz
         ba5BAbAdLZqe2+S5QFAoE03NGc/470O8to02zUZPYM3KcEdSUC9k8oLqjYt/9bqu7DZ9
         uEHF5/9+3nhLEzWficxjd3eIzDPQPi+/iF07tKwcUNXWcwuRwV5oOfI7K2LpGqaCWth1
         T4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+l9adJfJvn/S+/QVfIXrlbiImSIuIuSN2cnYdrdxKpU=;
        b=A7iRawkiA5yXEWHscNlzxhIUnLV3Qv7FgUd8UBz1oPyk3PCc+XRkRA66klClkdH7fx
         kFA1GDoTCpYbXMniE4JtbR8rWzJgFQ1yUH0jvjCgE6QZqqYcijOe79JtW5/g9Wh+XPVq
         nmcAs/ko3+MN60sJz4GQRjoBuit2p+vcuiEMfxLNVR2M95P4eqotEHaC3aNsbQ1uPB8K
         WXfsA5+zCZWsmm1SAX0cP/mGAbkXwqXi9djhrmo0TAxLdfurO1B0Mwf4n8nEdDjUNw4W
         gTCDKBeRfFnXnN9AvNpF4TYfPKh3k++nCqtZKvX71jj+0XP97fBl3GXyObu7/8ryMYe9
         VWYQ==
X-Gm-Message-State: AA+aEWbP9ci6VqFUfeAsgorlYwWqDKdHekyL/dvj7vK8+gOGtHj3/XzG
        yELvaf4pfyB/nCVUzittsiZKCmoCXTzc+kpEwZE4VA==
X-Google-Smtp-Source: AFSGD/UrLBvklhikkw9Kud9H8Gkm7TBODwU159+dV/3N5G+TyVuLliiJD0qIsQqsl93ACU2cpd/TObm06nBAlr2q58w=
X-Received: by 2002:a9d:f07:: with SMTP id 7mr18207849ott.353.1543350931471;
 Tue, 27 Nov 2018 12:35:31 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4ibARHP1Gji2cZQ704BeiKL26Bh13G58eyB+PjQJSD58w@mail.gmail.com> <ec672fcf5924ef267f35b11c13ddc50c815b1a9f.camel@linux.intel.com>
In-Reply-To: <ec672fcf5924ef267f35b11c13ddc50c815b1a9f.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 12:35:20 -0800
Message-ID: <CAPcyv4gKT1CDA-xVh5LCYEVUeXLB5ktCFqpFhPWzNK7+QbQdvw@mail.gmail.com>
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

On Tue, Nov 27, 2018 at 9:38 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-11-26 at 18:11 -0800, Dan Williams wrote:
> > On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > Move the async_synchronize_full call out of __device_release_driver and
> > > into driver_detach.
> > >
> > > The idea behind this is that the async_synchronize_full call will only
> > > guarantee that any existing async operations are flushed. This doesn't do
> > > anything to guarantee that a hotplug event that may occur while we are
> > > doing the release of the driver will not be asynchronously scheduled.
> > >
> > > By moving this into the driver_detach path we can avoid potential deadlocks
> > > as we aren't holding the device lock at this point and we should not have
> > > the driver we want to flush loaded so the flush will take care of any
> > > asynchronous events the driver we are detaching might have scheduled.
> > >
> >
> > What problem is this patch solving in practice, because if there were
> > drivers issuing async work from probe they would need to be
> > responsible for flushing it themselves. That said it seems broken that
> > the async probing infrastructure takes the device_lock inside
> > async_schedule and then holds the lock when calling
> > async_syncrhonize_full. Is it just luck that this hasn't caused
> > deadlocks in practice?
>
> My understanding is that it has caused some deadlocks. There was
> another patch set that Bart Van Assche had submitted that was
> addressing this. I just tweaked my patch set to address both the issues
> he had seen as well as the performance improvements included in my
> original patch set.

I tried to go find that discussion, but failed. It would help to
report an actual failure rather than a theoretical one.

> > Given that the device_lock is hidden from lockdep I think it would be
> > helpful to have a custom lock_map_acquire() setup, similar to the
> > workqueue core, to try to keep the locking rules enforced /
> > documented.
> >
> > The only documentation I can find for async-probe deadlock avoidance
> > is the comment block in do_init_module() for async_probe_requested.
>
> Would it make sense to just add any lockdep or deadlock documentation
> as a seperate patch? I can work on it but I am not sure it makes sense
> to add to this patch since there is a chance this one will need to be
> backported to stable at some point.

Yes, separate follow-on sounds ok.

> > Stepping back a bit, does this patch have anything to do with the
> > performance improvement, or is it a separate "by the way I also found
> > this" kind of patch?
>
> This is more of a seperate "by the way" type of patch based on the
> discussion Bart and I had about how to best address the issue. There
> may be some improvement since we only call async_synchronize_full once
> and only when we are removing the driver, but I don't think it would be
> very noticable.

Ok, might be worthwhile to submit this at the front of the series as a
fix that has implications for what comes later. The only concern is
whether this fix stands alone. It would seem to make the possibility
of ->remove() racing ->probe() worse, no? Can we make this change
without the new/proposed ->async_probe tracking infrastructure?
