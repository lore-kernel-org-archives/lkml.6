Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D7D2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BJ7DzHiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D7D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeK0NSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:18:00 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40590 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeK0NR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:17:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so17920786oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yV810+VIwkc6OP/TVRi/b7vXRY9kqYEi0AJb8DideSA=;
        b=BJ7DzHiH8FNoPcySJATqPYhDzDRou1BR3ygexYf32wI6uzn5+uaA3a3wdAmwgmZX1c
         97+xaaNIemh4lrhcuvRA6BjEXXt1vjPTE9KVHZqfQklzLySYWTb4kTpChCTu8p0NAvt7
         n/TeuzaSIJ7zsg5C0SJoQ2r+uhHnG/AbbK5ve6rol1JYyu3TvorZKMQMkAZlvtpy43cs
         04v7cxPwzayZlgxIQQNb6No32uEeS+NSyFZSRQ2ZkhQhXH6CX/OFuUTtgs61y92vE4B3
         yMzHOU4dMICx8HCqQDWO66b0C/E9zky2dKapbpY194r2iix1uUiknE9wWuUEDVWYmibQ
         bizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yV810+VIwkc6OP/TVRi/b7vXRY9kqYEi0AJb8DideSA=;
        b=FiGlPE7aE853VvyoFo5h1G+ZuzVdeMQhlNJuZ6SCs9dIrMjBjlbBgABTaJy+O5rx7F
         EztD5SxzcDwuSWVeIl2mxbd1/pGM1dvESNiuhAXJ99doUn92agXP89OHORP7DtH6BhHn
         u/v/NynefD/eu+U00Jwd1lKhOJFxi0797oluR3PI3B2nRFHKYy7BIdE0P9nVQbx9rFC/
         yJ3gVO8URrAxTnlvE21p5ZNuBfMZRe+Oe6DdlNcaPrrRVx94/2IPCsY3CcHb9Pvlawc+
         /65o26KmfEys9VJNqj25yeo1oUYpY4P8a29r8rtbFDyjR8NJfUT2IsM40xJdFdXcqEMj
         wqhw==
X-Gm-Message-State: AA+aEWYqcbudU/BUWNIetd63EIW5grCAInY4u9nUhy23868Qcf3vTyw8
        ieQWSRAOpndEKKT05s32KXiGmhiDgeB91xf35HSWRA==
X-Google-Smtp-Source: AFSGD/VLp50pseK8+YZeANWbiT0+hdjsg0w70iAaXIghTCBBNutn5n7V0giznNXVEMUs1quaZ3sKOgD2m6ZIf6o+0CQ=
X-Received: by 2002:aca:5205:: with SMTP id g5mr1181630oib.149.1543285303914;
 Mon, 26 Nov 2018 18:21:43 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 18:21:33 -0800
Message-ID: <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com>
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

On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Force the device registration for nvdimm devices to be closer to the actual
> device. This is achieved by using either the NUMA node ID of the region, or
> of the parent. By doing this we can have everything above the region based
> on the region, and everything below the region based on the nvdimm bus.
>
> By guaranteeing NUMA locality I see an improvement of as high as 25% for
> per-node init of a system with 12TB of persistent memory.
>

It seems the speed-up is achieved with just patches 1, 2, and 9 from
this series, correct? I wouldn't want to hold up that benefit while
the driver-core bits are debated.

You can add:

    Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...if the series needs to be kept together, but as far as I can see
the workqueue changes enable 2 sub-topics of development and it might
make sense for Tejun to take those first 2 and then Greg and I can
base any follow-up topics on that stable baseline.
