Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4420C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC0520645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EBkthBG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC0520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeK1GeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:34:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38365 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK1GeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:34:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so16941000otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zt/HPt2I52kAIi43ZeE047SCEvC+Uq20a3Gf9oKeX/Q=;
        b=EBkthBG+jJK0clfkZrz63Rxubl5gaEH5o9umU8B1GIsU9Du1LIosV0tsEU+52t+06E
         3BW35byrDDhlHU7ZTaPoT8YGKnUW0+hhr/+s0HgC9QLytoKcBcT0Lot3jfI+X6nlngUt
         7zC0Wdy66/ync5LeFnYyiBDTQNWBuz6F5xCZAe5bJiwM+laynayh9cQp25UEd0oxpfNy
         05C8++HXE1wp6aViDdfiL3lffqXfdJmOud/yfO+oVl0J60OB/FP4bo6idnWr2SWTQI5o
         W4Ie1XalckYAEWCh+BTpBcvl/cR/Z1mJBNDR0XaQ47CcFiDgMxaYAkcCDxqxBETwFGqN
         kAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt/HPt2I52kAIi43ZeE047SCEvC+Uq20a3Gf9oKeX/Q=;
        b=sNfUsD7tVCtV8ea/imiuV0A01fZgYjm/6z/c/sOzYOezihQzdzC8o/I7JaVC4et+iU
         oyZowIEM/DFv7qOFrfUfwTKHdUm7NTNM0OUoHBS48JiOqHK1lpkAoEkHcr9LfTreEHJM
         buTp/2cjIyVu5OxsFRp94xYYNgefkOAFH6AkIqDsxGUuaWRLpRoCh85oNjFhZAV6RBR8
         859CHipqUZnK+u3odRkH9OfsKw1NpZ+0/5fsadMbCu60J5980JOul+y4/DcdG+sXOcoU
         CsetawUbH8Rpu7UweWeRjRvfLH9uIHKoSl/X+jUrxIJ/kWzke/uNHyD8nXgRY4TBQS/u
         h6zw==
X-Gm-Message-State: AA+aEWbk5n1im9Ljjaq2Dn4k3/aim9c3n8ypE9ERUu8vOLNhmrbb2NO5
        HZc0aajlt8TG/k2tlGvSY8prOi3abwFMJu1C/afbJQ==
X-Google-Smtp-Source: AFSGD/WWmCh8nUJaFTGdY9LheMUQztbPWw2w8YV/WvTOKb7IZ73OG7YEOLr4BGVuPYi9pSh5vGrVqGLz1CIWcy4t3Pc=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr14796999otf.98.1543347307859;
 Tue, 27 Nov 2018 11:35:07 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com> <2031cf4705d76dd4d0f722a600a6a106cce2ba41.camel@linux.intel.com>
In-Reply-To: <2031cf4705d76dd4d0f722a600a6a106cce2ba41.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 11:34:56 -0800
Message-ID: <CAPcyv4gWwsYOeXVNDoDy4v=SU6bRyBG1fgSu84y64jGApaJ91g@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 9/9] libnvdimm: Schedule device
 registration on node local to the device
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

On Tue, Nov 27, 2018 at 10:04 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-11-26 at 18:21 -0800, Dan Williams wrote:
> > On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > Force the device registration for nvdimm devices to be closer to the actual
> > > device. This is achieved by using either the NUMA node ID of the region, or
> > > of the parent. By doing this we can have everything above the region based
> > > on the region, and everything below the region based on the nvdimm bus.
> > >
> > > By guaranteeing NUMA locality I see an improvement of as high as 25% for
> > > per-node init of a system with 12TB of persistent memory.
> > >
> >
> > It seems the speed-up is achieved with just patches 1, 2, and 9 from
> > this series, correct? I wouldn't want to hold up that benefit while
> > the driver-core bits are debated.
>
> Actually patch 6 ends up impacting things for persistent memory as
> well. The problem is that all the async calls to add interfaces only do
> anything if the driver is already loaded. So there are cases such as
> the X86_PMEM_LEGACY_DEVICE case where the memory regions end up still
> being serialized because the devices are added before the driver.

Ok, but is the patch 6 change generally useful outside of the
libnvdimm case? Yes, local hacks like MODULE_SOFTDEP are terrible for
global problems, but what I'm trying to tease out if this change
benefits other async probing subsystems outside of libnvdimm, SCSI
perhaps? Bart can you chime in with the benefits you see so it's clear
to Greg that the driver-core changes are a generic improvement?

> > You can add:
> >
> >     Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...if the series needs to be kept together, but as far as I can see
> > the workqueue changes enable 2 sub-topics of development and it might
> > make sense for Tejun to take those first 2 and then Greg and I can
> > base any follow-up topics on that stable baseline.
>
> I had originally put this out there for Tejun to apply, but him and
> Greg had talked and Greg agreed to apply the set. If it works for you I
> would prefer to just keep it together for now as I don't believe there
> will be too many more revisions of this needed.
>

That works for me.
