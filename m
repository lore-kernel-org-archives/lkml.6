Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563A3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB8420851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="oo/IImU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB8420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeK1JeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:34:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38419 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1JeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:34:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so17429264otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDb8IRomtYSFYvdALaPQaOUCHgFitoGW+sYJ7rxvUvY=;
        b=oo/IImU5U8oawTROP8EtzxQko85lFJioG5iunSSiO9vO2Whi4VYSQd/du/09Z7sqs2
         uySCINuO+MuO4Am7+uUvUiXPWVpksBtYq2acTbkZIghOJkeyNksVdvxHxF/Xu1UPjptY
         7JOnyocSDviYocW/7MHVKHd3TLHsPd8PcW64FZ7yv3jhJ6KAcpKfcg8lRhumt6MkP12d
         QbSUFy3kFSpy7xed3jQNtad4D/4G6dSzxeBcfRvpUnga9UL5WbBwkNy/WjBbn9emGBkD
         yujGRrvho7ThUdCa24qKRRc0UWBtwnFeASmnCEtPaACfdbWnLE1bMk83e4SdzZPwVIG6
         7Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDb8IRomtYSFYvdALaPQaOUCHgFitoGW+sYJ7rxvUvY=;
        b=UzEDzZmuQaliefyBSOQDHl8mmR2T3N6jpaRibO9aWVDsxJDOkyvVouuYRSyuiBEx97
         eOpHsUEPtMD6oqMlKNQk+Zh/lP71Z0NGB4bA6HpR8NM3F/FPXll0J5m1Bp8ej3XJgUEC
         omZh94LQSAmmoZGltRIO0urTkpl57l9THQde0R2V+bnWJn8XUNvgnwZK4CBglIRaNMcZ
         VrJ6MLRQYpJeiAd8ENpfwhRqu0pq1Qm13Ze8P7jGfNDP3CCkwJTyxudhEN4qeVVTZC+K
         HRfPxj1zJDJur3qTfwvfhDpYjgXL9lQ+mpyFBRmqG53YzYTLFKJMhIX26S+REd9uR529
         Drqg==
X-Gm-Message-State: AA+aEWZu4SQADgW5p0hgL4CZVUlCTmhdUrdriayqAhcuhg0yy/+H7TLI
        lyornpqGVieqIj2NDIvCRAv5TUuxVntLfbkTZmQhFw==
X-Google-Smtp-Source: AFSGD/VLRK+MrzkCAY0mW+Pe+iEy8qSSRHJeL+TQba6vProSGgnQAV7Gt/C5+rP8j7WCztyaZcLTr4BlWQLF/p6MnWg=
X-Received: by 2002:a9d:f07:: with SMTP id 7mr18433017ott.353.1543358097406;
 Tue, 27 Nov 2018 14:34:57 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com>
 <2031cf4705d76dd4d0f722a600a6a106cce2ba41.camel@linux.intel.com>
 <CAPcyv4gWwsYOeXVNDoDy4v=SU6bRyBG1fgSu84y64jGApaJ91g@mail.gmail.com>
 <1543350780.185366.81.camel@acm.org> <CAPcyv4hya0ASfVue6GH3ZXKJOzytQXDqtEWxvrEdCTcb545tYg@mail.gmail.com>
 <1543353746.185366.90.camel@acm.org>
In-Reply-To: <1543353746.185366.90.camel@acm.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Nov 2018 14:34:46 -0800
Message-ID: <CAPcyv4jdqm5O11A4ieiLwhBYVAOGbWE7t_Orrdau3WMvLQAqKw@mail.gmail.com>
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
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 1:22 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2018-11-27 at 12:50 -0800, Dan Williams wrote:
> > Thanks Bart, so tying this back to Alex's patches, does the ordering
> > problem that Alex's patches solve impact the SCSI case? I'm looking
> > for something like "SCSI depends on asynchronous probing and without
> > 'driver core: Establish clear order of operations for deferred probe
> > and remove' probing is often needlessly serialized". I.e. does it
> > suffer from the same platform problem that libnvdimm ran into where
> > it's local async probing implementation was hindered by the driver
> > core?
>
> (+Martin)
>
> Hi Dan,
>
> Patch 6/9 reduces the time needed to scan SCSI LUNs significantly. The only
> way to realize that speedup is by enabling more concurrency. That's why I
> think that patch 6/9 is a significant driver core improvement.

Perfect, Alex, with that added to the 6/9 changelog and moving to
device_private for the async state tracking you can add my
Reviewed-by.
