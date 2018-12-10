Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD51C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8333B2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="p6LNJNBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8333B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeLJVPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:15:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46246 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbeLJVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:15:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so10204125oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmfXkwZqZ8454+4AD1KW78pBtI/dlmk0QivD0ZP/W2w=;
        b=p6LNJNBK5fMekPrXHJIfoG9ghAxJAJbbm9UL+ahsX4ribFO9/FIXvy2TfyAmCy6HW7
         h7pklIT9F6t6Gg3L0vQ1FXIE+xUz/Yz1COGC8lSsyPFLOiWW98Zx5CnK7AQlqj4Zvb4n
         8wsc+PlS0RvZ5dNQDoRxLNB22Bknin4f2Na+T18vbQu1lj+1qXGSMfWQA6EqIttlnntv
         LrxPAfpWbtNZ9FsvW7Iii+hJSdSI2Xlx/onlvvtrcX9WovdVRAuw+CK+u4Kj2j0klTqH
         CIA63vOFBNCDlFsQKfqI3FLg+7qFN+fhqOFNZlqQ3xM1PfGCpwvORM3cL9SvIBbBmwT8
         57VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmfXkwZqZ8454+4AD1KW78pBtI/dlmk0QivD0ZP/W2w=;
        b=d9uGQZhRNkQDiDILZruvWfmccDp0mquJ28ISjhCQKmyUpPBjctSE4E3+jlktFRUtlc
         CMdNu5AK6iMWd5UmDswoxVIztYnDL8V9O+ldZVKrQGnpJj9byzrog0sZUyJvDLr2xUYu
         OUQ4Sr3XbGh8WZMC/s1n0NQN9RAB6ddw+5tmj3vAkSyDhMldLoetYCbwlgUjBckOadIV
         X1h7M4qmnLtglwET8Mu4xuRLP+kqvyQiSPLJJqsGfXUbitsDOFB2X6HRMwWPsYf8kwQ2
         JtSWtDt9JlDiaRl+B90kH+cwKEIwjOzCf8Oj2y+zuOdMAk39trS4/CxdN6CIrscyU1VC
         qaCQ==
X-Gm-Message-State: AA+aEWYFhL6w6hnguUDPg9bZ20uFGhRim0DGDdQ5j2gBJxegsnxZjCMc
        BU5eaiGobwSk67thDpHUdB36LXjnIIPjduOOtBhudg==
X-Google-Smtp-Source: AFSGD/WNQZ94XAVvGLKPggfvoVFOBtZH5Q6PwSKtOjwebE+pI5CNjXI1S41e3t9sWwHlC73El/+7LLT4FYlZwMMUhgg=
X-Received: by 2002:aca:b804:: with SMTP id i4mr8060294oif.280.1544476528966;
 Mon, 10 Dec 2018 13:15:28 -0800 (PST)
MIME-Version: 1.0
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com>
 <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
 <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com> <bd92d0a3ff60097bf4424ff4c556a5369e66da6d.camel@linux.intel.com>
In-Reply-To: <bd92d0a3ff60097bf4424ff4c556a5369e66da6d.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Dec 2018 13:15:16 -0800
Message-ID: <CAPcyv4jDG_2VwFr4oDGCURFrA=B0Bs2HGN9exLE47vDj0P3_8A@mail.gmail.com>
Subject: Re: [driver-core PATCH v8 2/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
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

On Mon, Dec 10, 2018 at 12:58 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-12-10 at 11:43 -0800, Dan Williams wrote:
> > On Mon, Dec 10, 2018 at 11:35 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > On Mon, 2018-12-10 at 10:58 -0800, Dan Williams wrote:
> > > > On Wed, Dec 5, 2018 at 9:25 AM Alexander Duyck
> > > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > >
> > > > > Add an additional bit flag to the device struct named "dead".
> > > > >
> > > > > This additional flag provides a guarantee that when a device_del is
> > > > > executed on a given interface an async worker will not attempt to attach
> > > > > the driver following the earlier device_del call. Previously this
> > > > > guarantee was not present and could result in the device_del call
> > > > > attempting to remove a driver from an interface only to have the async
> > > > > worker attempt to probe the driver later when it finally completes the
> > > > > asynchronous probe call.
> > > > >
> > > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > ---
> > > > >  drivers/base/core.c    |   11 +++++++++++
> > > > >  drivers/base/dd.c      |    8 ++++++--
> > > > >  include/linux/device.h |    5 +++++
> > > > >  3 files changed, 22 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > index f3e6ca4170b4..70358327303b 100644
> > > > > --- a/drivers/base/core.c
> > > > > +++ b/drivers/base/core.c
> > > > > @@ -2075,6 +2075,17 @@ void device_del(struct device *dev)
> > > > >         struct kobject *glue_dir = NULL;
> > > > >         struct class_interface *class_intf;
> > > > >
> > > > > +       /*
> > > > > +        * Hold the device lock and set the "dead" flag to guarantee that
> > > > > +        * the update behavior is consistent with the other bitfields near
> > > > > +        * it and that we cannot have an asynchronous probe routine trying
> > > > > +        * to run while we are tearing out the bus/class/sysfs from
> > > > > +        * underneath the device.
> > > > > +        */
> > > > > +       device_lock(dev);
> > > > > +       dev->dead = true;
> > > > > +       device_unlock(dev);
> > > > > +
> > > > >         /* Notify clients of device removal.  This call must come
> > > > >          * before dpm_sysfs_remove().
> > > > >          */
> > > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > > index 88713f182086..3bb8c3e0f3da 100644
> > > > > --- a/drivers/base/dd.c
> > > > > +++ b/drivers/base/dd.c
> > > > > @@ -774,6 +774,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> > > > >
> > > > >         device_lock(dev);
> > > > >
> > > > > +       /* device is or has been removed from the bus, just bail out */
> > > > > +       if (dev->dead)
> > > > > +               goto out_unlock;
> > > > > +
> > > >
> > > > What do you think about moving this check into
> > > > __device_attach_driver() alongside all the other checks? That way we
> > > > also get ->dead checking through the __device_attach() path.
> > >
> > > I'm not really sure that is the best spot to do that. Part of the
> > > reason being that by placing it where I did we avoid messing with the
> > > runtime power management for the parent if it was already powered off.
> >
> > ...but this already a rare event and the parent shouldn't otherwise be
> > bothered by a spurious pm_runtime wakeup event.
> >
> > > If anything I would say we could probably look at pulling the check out
> > > and placing the driver check in __device_attach_async_helper since from
> > > what I can tell the check is actually redundant in the non-async path
> > > anyway since __device_attach already had taken the device lock and
> > > checked dev->driver prior to calling __device_attach_driver.
> > >
> > > > ...and after that maybe it could be made a common helper
> > > > (dev_driver_checks()?) shared between __device_attach_driver() and
> > > > __driver_attach() to reduce some duplication.
> > >
> > > I'm not sure consolidating it into a function would really be worth the
> > > extra effort. It would essentially just obfuscate the checks and I am
> > > not sure you really save much with:
> > >         if (dev_driver_checks(dev))
> > > vs:
> > >         if (!dev->dead && !dev->driver)
> > >
> > > By the time you create the function and replace the few spots that are
> > > making these checks you would end up most likely adding more complexity
> > > to the kernel rather than reducing it any.
> >
> > No, I was talking about removing this duplication in
> > __device_attach_driver() and __driver_attach():
> >
> >         if (ret == 0) {
> >                 /* no match */
> >                 return 0;
> >         } else if (ret == -EPROBE_DEFER) {
> >                 dev_dbg(dev, "Device match requests probe deferral\n");
> >                 driver_deferred_probe_add(dev);
>
> Is this bit of code correct? Seems like there should be a return here
> doesn't it?

It does look odd, but I think it's ok as the driver is expected to
have its probe routine called multiple times and return -EPROBE_DEFER
if it's not ready yet.

> I just double checked and this is what is in the kernel too.

Yeah, I just copy-pasted it, but it might deserve a comment that the
fallthrough / no return is on purpose.

> >         } else if (ret < 0) {
> >                 dev_dbg(dev, "Bus failed to match device: %d", ret);
> >                 return ret;
> >         } /* ret > 0 means positive match */
> >
> > ...and lead in with a dev->dead check.
>
> I would think that we would want to check for dev->dead before we even
> call driver_match_device. That way we don't have the match function
> crawling around a device that is being disassembled. Is that what you
> were referring to?

I wasn't too concerned about optimizing the case where the probe path
loses the race with device_del().

> Also the context for the two functions seems to be a bit different. In
> the case of __device_attach_driver the device_lock is already held. In
> __driver_attach the lock on the device isn't taken until after a match
> has been found.

Yes, I was only pattern matching when looking at the context of where
dev->dead is checked in __driver_attach() and wondering why it was
checked outside of __device_attach_driver()
