Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11713C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92EE2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Hm0bigXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92EE2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeI1JKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 05:10:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34888 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1JKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 05:10:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id m11-v6so4074031oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zVxyYD2BJDPT96bhHR+Phf4ssRThIcfmrvwv59HVuA=;
        b=Hm0bigXgFLC7zMH4akhhFXeLRVHXZoKBD4wB8rVcQIxZhlHum2iwiM3Sv4wrnTs50M
         fMcZevZTNECaOgDA2iJj4w6/Y38th8fay/amSRYXa/9rrod1iWr3Pe+STfl+agJpYv1M
         wtqC54SIltnRwuCo6BDGIQrU2ApuOjysyzIM5AraTQO6W62JvZ99m8bPV5NUqxeQ35dA
         wbnwssIVvqu3FGoU+mJuh6ic3gXIwluTwJVNeLNr1JNDmLNB+juJaVydOhZkqArowhGc
         LM9rbZBnx5J6ukhDRvymSB0UPK4qyCJL6XN46tRd2KAEGcus783cNlWUNOdhr6oa5ewB
         FKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zVxyYD2BJDPT96bhHR+Phf4ssRThIcfmrvwv59HVuA=;
        b=ZHs2oR1MqLeTibgLJY32ddZZMPQxbRbM+i9NDH8DRYqWncJUD7eFc6GG1cbsc0XHDe
         PZFSWTax2atVQDUL3A6Frzkq0F9zMZ89Xn7DQCOq5Lm0gqRX+CJFgyfBbMtb45QIL+O6
         mshEJ1KuHpQ30fcOs2QO/jigLGLDCQnPC8v0p5ARwM9O4botn+q9fvHd4goMgLZWqFfk
         +5wGqFGqEpR7Xh3ethkX29oboQEkcXMEtokVaYaOprWTHQJ6R/l2N63z7XXaG7t+UHU9
         Hbg3XHJbT3FQKy4fC0hyZJ4geI5bCa+tNgrQNTUw5N3exTMapQ13dElRQGg9sH/7JXxd
         PV/A==
X-Gm-Message-State: ABuFfogSXPE0RdIhIYsaUweH+V1ZFo7i72DbNvUpMJuR5n15fHAPdSBE
        /EJJW2yW9nelANsLab57eg/GslLHCt68wEn3V0gvoQ==
X-Google-Smtp-Source: ACcGV638/l55rqN4GqnAESazVLvULRwD5HUHEGBR7oPcb3pbVdY5D3ohVMDpEYfoIM6B61LKuYElD4EYveHsBwmnzq4=
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr4244533oih.246.1538102932990;
 Thu, 27 Sep 2018 19:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215149.13512.51991.stgit@localhost.localdomain> <CAPcyv4h5U4Fph52H80QodBRXK+PjS6Zw_6qK2+DXtr=qZT7Gzw@mail.gmail.com>
 <021d55fb-9f6a-0b52-3513-e9c5493bd7d7@linux.intel.com>
In-Reply-To: <021d55fb-9f6a-0b52-3513-e9c5493bd7d7@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Sep 2018 19:48:42 -0700
Message-ID: <CAPcyv4hQJo9HvCw70p+Qnpcg40x=mOsnLvsd1asGc0GD8EP6Sg@mail.gmail.com>
Subject: Re: [RFC workqueue/driver-core PATCH 3/5] driver core: Probe devices
 asynchronously instead of the driver
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:31 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
>
>
> On 9/26/2018 5:48 PM, Dan Williams wrote:
> > On Wed, Sep 26, 2018 at 2:51 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> >>
> >> This change makes it so that we probe devices asynchronously instead of the
> >> driver. This results in us seeing the same behavior if the device is
> >> registered before the driver or after. This way we can avoid serializing
> >> the initialization should the driver not be loaded until after the devices
> >> have already been added.
> >>
> >> The motivation behind this is that if we have a set of devices that
> >> take a significant amount of time to load we can greatly reduce the time to
> >> load by processing them in parallel instead of one at a time. In addition,
> >> each device can exist on a different node so placing a single thread on one
> >> CPU to initialize all of the devices for a given driver can result in poor
> >> performance on a system with multiple nodes.
> >>
> >> One issue I can see with this patch is that I am using the
> >> dev_set/get_drvdata functions to store the driver in the device while I am
> >> waiting on the asynchronous init to complete. For now I am protecting it by
> >> using the lack of a dev->driver and the device lock.
> >>
> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > [..]
> >> @@ -891,6 +914,25 @@ static int __driver_attach(struct device *dev, void *data)
> >>                  return ret;
> >>          } /* ret > 0 means positive match */
> >>
> >> +       if (driver_allows_async_probing(drv)) {
> >> +               /*
> >> +                * Instead of probing the device synchronously we will
> >> +                * probe it asynchronously to allow for more parallelism.
> >> +                *
> >> +                * We only take the device lock here in order to guarantee
> >> +                * that the dev->driver and driver_data fields are protected
> >> +                */
> >> +               dev_dbg(dev, "scheduling asynchronous probe\n");
> >> +               device_lock(dev);
> >> +               if (!dev->driver) {
> >> +                       get_device(dev);
> >> +                       dev_set_drvdata(dev, drv);
> >> +                       async_schedule(__driver_attach_async_helper, dev);
> >
> > I'm not sure async drivers / sub-systems are ready for their devices
> > to show up in parallel. While userspace should not be relying on
> > kernel device names, people get upset when devices change kernel names
> > from one boot to the next, and I can see this change leading to that
> > scenario.
>
> The thing is the current async behavior already does this if the driver
> is loaded before the device is added. All I am doing is making the
> behavior with the driver loaded first the standard instead of letting it
> work the other way around. This way we get consistent behavior.

Ok, I can see the consistency argument. It's still a behavior change
that needs testing. Configurations that have been living with the
default of synchronous probing of the devices on the bus for a later
arriving driver might be surprised.

That said, I was confusing async probing with device registration in
my thinking, so some of the discovery order / naming concerns may not
be as bad as I was imagining. Sub-systems that would be broken by this
behavior change would already be broken if a driver is built-in vs
module.

So, consider this, an Acked-by.

> > If a driver / sub-system wants more parallelism than what
> > driver_allows_async_probing() provides it should do it locally, for
> > example, like libata does.
>
> So where I actually saw this was with the pmem legacy setup I had. After
> doing all the work to parallelize things in the driver it had no effect.
> That was because the nd_pmem driver wasn't loaded yet so all the
> device_add calls did is add the device but didn't attach the nd_pmem
> driver. Then when the driver loaded it serialized the probe calls
> resulting in it taking twice as long as it needed to in order to
> initialize the memory.
>
> This seems to affect standard persistent memory as well. The only
> difference is that instead of probing the device on the first pass we
> kick it back and reprobe it in nd_pmem_probe/nd_pfn_probe in order to
> set the correct personality and that in turn allows us to asynchronously
> reschedule the work on the correct CPU and deserialize it.

I don't see any problems with this series with the nvdimm unit tests,
but note those tests do not check for discovery order / naming
discrepancies.
