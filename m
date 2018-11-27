Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F419AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9BD2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bButDixf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9BD2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeK1Htk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:49:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39321 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1Htk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:49:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id g27so21450197oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6vuob/JAwDUu6O3NeQRsY/QApTXiG1JFzWI6jlQYqY=;
        b=bButDixfi1b8huyC3Ac2fHhs2UmlF4bQqervWW0kXc/xKmaTrfoEBOSMjntlsF1dMa
         6SxTgq+u7DhmXsrJJz6q9124m0piq5AL/AVUB/pJvyqNuskgv/FXlyfetc/c12qOvvTN
         vY4QetxjHeRJ9ZnCRbzogaWfjbnk2wssctlP3A+N2CV0047tbOE58549y35Z40QdkqTL
         BsSe+YaDM/8kGBQGSELnQArXb5kumb7StfCSF5Z7eTTFQWwH5PHHJElMBm/0+LfTJzW/
         empOY9l62+wj2odtwpLSZPCDvcaR8DVDMc/xplObI++nHmjmQ2cBdWFRRxuZNke8qwaL
         YQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6vuob/JAwDUu6O3NeQRsY/QApTXiG1JFzWI6jlQYqY=;
        b=rRnyv3ZG+ELWjeMFyUEwOnQq/no3bU1I7qKSALe+mU2V9mtcXhB+0X22QnQuMF62ad
         YqSCvULb8B4bDj/SVzwQgt4LfVxnwjziNvrllfM5CiAcLq1Bi6YjLXPe2jNRivtYPRTX
         7c0q0pINXDHdQpNP5zWJG0guabPElSUQReW7fjwW8l1C4J3/r/FitogJXdtJbm6hCE2B
         bugZzSwQm3/FZvTsw0pzeoqL1stCKUMo6zqFHuE7LkEvptcdAxOB1vyy/FEFsMMPjKea
         rXhXh/aSi/ps3jhIAb45LsKhFfWl746Y77EoQVHmgDjQS0AyM4NwChIygumJ1EUpQBq+
         67SQ==
X-Gm-Message-State: AA+aEWY0PQDL38HFFUd6daF4rpZKUOOXHXAa69gfVwGwtRexsj1a9wNg
        1QefHxSffiZumHsrpXFwJrM08mG3G4hKZcqktIjHXg==
X-Google-Smtp-Source: AFSGD/X8K64is8ukapAYaouRshOKdJIKY79fUTkXd3HWD3zvFAZ2gAC1vvf1+1TXFsjNyynt6Lx3qlM4ccao92b5V1A=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr14943121otf.98.1543351832094;
 Tue, 27 Nov 2018 12:50:32 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com>
 <2031cf4705d76dd4d0f722a600a6a106cce2ba41.camel@linux.intel.com>
 <CAPcyv4gWwsYOeXVNDoDy4v=SU6bRyBG1fgSu84y64jGApaJ91g@mail.gmail.com> <1543350780.185366.81.camel@acm.org>
In-Reply-To: <1543350780.185366.81.camel@acm.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 12:50:21 -0800
Message-ID: <CAPcyv4hya0ASfVue6GH3ZXKJOzytQXDqtEWxvrEdCTcb545tYg@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 9/9] libnvdimm: Schedule device
 registration on node local to the device
To:     bvanassche@acm.org
Cc:     alexander.h.duyck@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2018-11-27 at 11:34 -0800, Dan Williams wrote:
> > On Tue, Nov 27, 2018 at 10:04 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > On Mon, 2018-11-26 at 18:21 -0800, Dan Williams wrote:
> > > > On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> > > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > >
> > > > > Force the device registration for nvdimm devices to be closer to the actual
> > > > > device. This is achieved by using either the NUMA node ID of the region, or
> > > > > of the parent. By doing this we can have everything above the region based
> > > > > on the region, and everything below the region based on the nvdimm bus.
> > > > >
> > > > > By guaranteeing NUMA locality I see an improvement of as high as 25% for
> > > > > per-node init of a system with 12TB of persistent memory.
> > > > >
> > > >
> > > > It seems the speed-up is achieved with just patches 1, 2, and 9 from
> > > > this series, correct? I wouldn't want to hold up that benefit while
> > > > the driver-core bits are debated.
> > >
> > > Actually patch 6 ends up impacting things for persistent memory as
> > > well. The problem is that all the async calls to add interfaces only do
> > > anything if the driver is already loaded. So there are cases such as
> > > the X86_PMEM_LEGACY_DEVICE case where the memory regions end up still
> > > being serialized because the devices are added before the driver.
> >
> > Ok, but is the patch 6 change generally useful outside of the
> > libnvdimm case? Yes, local hacks like MODULE_SOFTDEP are terrible for
> > global problems, but what I'm trying to tease out if this change
> > benefits other async probing subsystems outside of libnvdimm, SCSI
> > perhaps? Bart can you chime in with the benefits you see so it's clear
> > to Greg that the driver-core changes are a generic improvement?
>
> Hi Dan,
>
> For SCSI asynchronous probing is really important because when scanning SAN
> LUNs there is plenty of potential for concurrency due to the network delay.
>
> I think the following quote provides the information you are looking for:
>
> "This patch reduces the time needed for loading the scsi_debug kernel
> module with parameters delay=0 and max_luns=256 from 0.7s to 0.1s. In
> other words, this specific test runs about seven times faster."
>
> Source: https://www.spinics.net/lists/linux-scsi/msg124457.html

Thanks Bart, so tying this back to Alex's patches, does the ordering
problem that Alex's patches solve impact the SCSI case? I'm looking
for something like "SCSI depends on asynchronous probing and without
'driver core: Establish clear order of operations for deferred probe
and remove' probing is often needlessly serialized". I.e. does it
suffer from the same platform problem that libnvdimm ran into where
it's local async probing implementation was hindered by the driver
core?
