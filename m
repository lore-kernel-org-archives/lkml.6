Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5664AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012FE20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Zb7DbFyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012FE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeLJTna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:43:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32825 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeLJTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:43:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so10027283oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWbXmtNfJh7V5oDcbfdFWxGL8EBeD9YIn39i34tpgQA=;
        b=Zb7DbFyzhc1cqbKDm6LUfEYkUH4CvpS81D3WaSiO0tRgIRxssqnj/LKQ+mdKhdzY+I
         jL4PO/Q2QEiWzWWAYS5Ku5vtRDTLSSBov5SKAt7ulb+W9oJIhXABHSsD8Q3+KTbjhdPw
         Io/0pN3NqHIOGFs23F2mIgDSU9oMfzoMkV0F/TfrL317NKSoNFsNQfKufGvlHTaxC+xA
         0Hb09VsesjwlayC4zk1rLe4BI1Rq8pj00GV3pvBk2tUBF+NBIOEugtWu4hxhSJQDv+DT
         9U0YZr4hSO8+yRsBhtsLoB48PAUkHMKMcy36n/Q3gNsEXE4yAcvfeGDax/PHLNuk4ui0
         xclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWbXmtNfJh7V5oDcbfdFWxGL8EBeD9YIn39i34tpgQA=;
        b=j2EZXoW52xlsDY42S7HeMA9TTgpdgkxZrhD5F5HeNJWOBRr6x50sf1zuJi/GPpwfeb
         PKnSNBKV5B4zgm+xQB2Qlp4Dcwx9LPmjt+8u9oMXStzOKASDnpNpXAPKNWQdr6nCqMJj
         dNJS6USVVMRlb5VrsiZjxk0MEVL6jzWwW9qWFG9asnuX31pch4W+MSHHx/xmRxqMEgmY
         Siwca1iuLtj4lECh6L2P/J27zIKTdEPoa5a3Ez+BIC1I9AncmexhATU0WseAsvP/Xv94
         lKEEGSrPD7XaKl5BsMu10eDahfLg9b0g8gOZJlaXsYofWiJYzqgijaiSTw+dmjtxR1r6
         GsDg==
X-Gm-Message-State: AA+aEWbuoNY5BhpuXDq2akoG5JHfVCejUBhOEKt3jKB3rgg0qgyO9bqp
        Vi6ub2Oapb0eN1mT0pal+aizUgZnoOJsaB1LrBjBHJd4gVg=
X-Google-Smtp-Source: AFSGD/VgFJaaYtGtqAYo98LhhAf47yGL57Na4/yuyThY9jWQebcQBTTSMbyxtQ/wXUIlWdu5DmCXisM2QhqOzDHF6aY=
X-Received: by 2002:aca:d905:: with SMTP id q5mr8605934oig.0.1544471009304;
 Mon, 10 Dec 2018 11:43:29 -0800 (PST)
MIME-Version: 1.0
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com> <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
In-Reply-To: <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Dec 2018 11:43:17 -0800
Message-ID: <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com>
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

On Mon, Dec 10, 2018 at 11:35 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-12-10 at 10:58 -0800, Dan Williams wrote:
> > On Wed, Dec 5, 2018 at 9:25 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > Add an additional bit flag to the device struct named "dead".
> > >
> > > This additional flag provides a guarantee that when a device_del is
> > > executed on a given interface an async worker will not attempt to attach
> > > the driver following the earlier device_del call. Previously this
> > > guarantee was not present and could result in the device_del call
> > > attempting to remove a driver from an interface only to have the async
> > > worker attempt to probe the driver later when it finally completes the
> > > asynchronous probe call.
> > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > ---
> > >  drivers/base/core.c    |   11 +++++++++++
> > >  drivers/base/dd.c      |    8 ++++++--
> > >  include/linux/device.h |    5 +++++
> > >  3 files changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index f3e6ca4170b4..70358327303b 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -2075,6 +2075,17 @@ void device_del(struct device *dev)
> > >         struct kobject *glue_dir = NULL;
> > >         struct class_interface *class_intf;
> > >
> > > +       /*
> > > +        * Hold the device lock and set the "dead" flag to guarantee that
> > > +        * the update behavior is consistent with the other bitfields near
> > > +        * it and that we cannot have an asynchronous probe routine trying
> > > +        * to run while we are tearing out the bus/class/sysfs from
> > > +        * underneath the device.
> > > +        */
> > > +       device_lock(dev);
> > > +       dev->dead = true;
> > > +       device_unlock(dev);
> > > +
> > >         /* Notify clients of device removal.  This call must come
> > >          * before dpm_sysfs_remove().
> > >          */
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index 88713f182086..3bb8c3e0f3da 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -774,6 +774,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> > >
> > >         device_lock(dev);
> > >
> > > +       /* device is or has been removed from the bus, just bail out */
> > > +       if (dev->dead)
> > > +               goto out_unlock;
> > > +
> >
> > What do you think about moving this check into
> > __device_attach_driver() alongside all the other checks? That way we
> > also get ->dead checking through the __device_attach() path.
>
> I'm not really sure that is the best spot to do that. Part of the
> reason being that by placing it where I did we avoid messing with the
> runtime power management for the parent if it was already powered off.

...but this already a rare event and the parent shouldn't otherwise be
bothered by a spurious pm_runtime wakeup event.

> If anything I would say we could probably look at pulling the check out
> and placing the driver check in __device_attach_async_helper since from
> what I can tell the check is actually redundant in the non-async path
> anyway since __device_attach already had taken the device lock and
> checked dev->driver prior to calling __device_attach_driver.
>
> > ...and after that maybe it could be made a common helper
> > (dev_driver_checks()?) shared between __device_attach_driver() and
> > __driver_attach() to reduce some duplication.
>
> I'm not sure consolidating it into a function would really be worth the
> extra effort. It would essentially just obfuscate the checks and I am
> not sure you really save much with:
>         if (dev_driver_checks(dev))
> vs:
>         if (!dev->dead && !dev->driver)
>
> By the time you create the function and replace the few spots that are
> making these checks you would end up most likely adding more complexity
> to the kernel rather than reducing it any.

No, I was talking about removing this duplication in
__device_attach_driver() and __driver_attach():

        if (ret == 0) {
                /* no match */
                return 0;
        } else if (ret == -EPROBE_DEFER) {
                dev_dbg(dev, "Device match requests probe deferral\n");
                driver_deferred_probe_add(dev);
        } else if (ret < 0) {
                dev_dbg(dev, "Bus failed to match device: %d", ret);
                return ret;
        } /* ret > 0 means positive match */

...and lead in with a dev->dead check.
