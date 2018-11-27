Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5ACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF6920851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pR0oexZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF6920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbeK1FbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:31:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35186 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbeK1FbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:31:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so21076361otj.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYiXsinzg7fl78iL14s9eJAIXIIV7apz9pcc2xrBFMw=;
        b=pR0oexZms3A/B/mXEMhxXBBH1EH7aMTid0ds2pQWZXSAYNW0w9bchtCMSUCmeMZpD7
         szFiog6cG2CcFRLr6oVRZfW9wgVHuWb6+Wq42gMePHG1laeXoNB7aNyOLMR+LTp3yv06
         yZIWdUUFoY3ZwI6O3DMnjppocG1HbeVyQ0ETuNzbJm0uCxcDQi2TmCOArTTGSqsO34t1
         +XzerCyaPtBhRoNexvPLB3yU4fTgVgmQwtlucXFw0jCk5ZO/a6sEDyRYi71cWymYmAyY
         I0GOxTPucJ63YQYEXzFKn6SVbNhHQnMrVl22C0fC+0SQHj2V1giKbdLPXllUbfJjqbDv
         yehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYiXsinzg7fl78iL14s9eJAIXIIV7apz9pcc2xrBFMw=;
        b=aHaF/ckO9dtso15RTGLbnc68V+CYNM2ZR2WbQFU9f0FVB6dFbviHF1SnyLhH7+3aDu
         JNKIj2szb2QvJX/3RNRU4bd72/yoeBnFSdTVvvFfCviszodFIfjxs4C3pCz1H7amaiWD
         4r3RXdHqQJo3/zWZJN89wYPH2hbR5EAIQDvWDwn6tSmlrHxNeGKiUetydkO+AL30JGyJ
         +Ma58dmZeIIZVvZL3ZTvEdZstzd8vGD4NVyAhjzHEUN3EWLeMqZubGMt2OadI5Jadt0N
         bLxPyE4pdiLEqlaWkfbBNvSEEebVOvI5I0CcfpQm9/SjG9mjIqtKaRieMA9l/He3iEPD
         d/uA==
X-Gm-Message-State: AA+aEWZgi10Jt6y4yR8wX6zUpGUK5oOirc+WqoD49gFh+uTkKv0dmyMY
        M/ooF94u77grCnkkeWpBEJXz29Fgry/WXDv0J6kgUw==
X-Google-Smtp-Source: AFSGD/Uw3Hl1an4tiIv6YdRKzSW5dCHIC76wNq5ZqZt6PS+sK5bJnV2Be49sYsW3nrub/8ioC6Z//L4BMwmqFCtlIrU=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr19032171oti.367.1543343553306;
 Tue, 27 Nov 2018 10:32:33 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4g0LNJZ38NKMXsBY+GgmGbHR4VrTM1gkm3m4bg6fOrfsw@mail.gmail.com> <785e7a944b60cd237680075064477efad1e9c39a.camel@linux.intel.com>
In-Reply-To: <785e7a944b60cd237680075064477efad1e9c39a.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 10:32:21 -0800
Message-ID: <CAPcyv4gNR+x=FB=V92M89-WMQe7YburYRwPhEy0jX71U52nFeQ@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 6/9] driver core: Probe devices
 asynchronously instead of the driver
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

On Tue, Nov 27, 2018 at 9:58 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-11-26 at 18:48 -0800, Dan Williams wrote:
> > On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > Probe devices asynchronously instead of the driver. This results in us
> > > seeing the same behavior if the device is registered before the driver or
> > > after. This way we can avoid serializing the initialization should the
> > > driver not be loaded until after the devices have already been added.
> > >
> > > The motivation behind this is that if we have a set of devices that
> > > take a significant amount of time to load we can greatly reduce the time to
> > > load by processing them in parallel instead of one at a time. In addition,
> > > each device can exist on a different node so placing a single thread on one
> > > CPU to initialize all of the devices for a given driver can result in poor
> > > performance on a system with multiple nodes.
> >
> > Do you have numbers on effects of this change individually? Is this
> > change necessary for the libnvdimm init speedup, or is it independent?
>
> It depends on the case. I was using X86_PMEM_LEGACY_DEVICE to spawn a
> couple of 32GB persistent memory devices. I had to use this patch and
> the async_probe option to get them loading in parallel versus serial as
> the driver load order is a bit different.
>
> Basically as long as all the necessary drivers are loaded for libnvdimm
> you are good, however if the device can get probed before the driver is
> loaded you run into issues as the loading will be serialized without
> this patch.

I think we could achieve the same with something like the following:

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 77f188cd8023..66c9827efdb4 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3718,5 +3718,6 @@ static __exit void nfit_exit(void)

 module_init(nfit_init);
 module_exit(nfit_exit);
+MODULE_SOFTDEP("pre: nd_pmem");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");

...to ensure that the pmem driver is loaded and ready to service
devices before they start being discovered.

>
> > > I am using the driver_data member of the device struct to store the driver
> > > pointer while we wait on the deferred probe call. This should be safe to do
> > > as the value will either be set to NULL on a failed probe or driver load
> > > followed by unload, or the driver value itself will be set on a successful
> > > driver load. In addition I have used the async_probe flag to add additional
> > > protection as it will be cleared if someone overwrites the driver_data
> > > member as a part of loading the driver.
> >
> > I would not put it past a device-driver to call dev_get_drvdata()
> > before dev_set_drvdata(), to check "has this device already been
> > initialized". So I don't think it is safe to assume that the core can
> > stash this information in ->driver_data. Why not put this
> > infrastructure in struct device_private?
>
> The data should be cleared before we even get to the probe call so I am
> not sure that is something we would need to worry about.

Yes it "should", but I have the sense that I have seen code that looks
at dev_get_drvdata() != NULL when it really should be looking at
dev->driver. Maybe not in leaf drivers, but bus code.

> As far as why I didn't use device_private, it was mostly just for the
> sake of space savings. I only had to add one bit to an existing
> bitfield to make the async_probe approach work, and the drvdata just
> seemed like the obvious place to put the deferred driver.

It seems device_private already has deferred_probe data, why not async_probe?
