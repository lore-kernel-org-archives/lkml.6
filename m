Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27331C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB0D2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="t/aCuOw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB0D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeK0NHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:07:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41899 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeK0NHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:07:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id j21so17893416oii.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AwtV56ql5JD04OQ+vZM5/s6pW7yTnPk+MazFuTHCfg=;
        b=t/aCuOw3rmFLXYEJauHfygwqlGi7Q1CpVTROktXT3r5ekChnQYWwzeDkMIjy8LIRGe
         qCTDLo3vyeUckWYUMPFBez+W9srqiAKdhyUPeviqdRBv1Xj6YRn+5n6UwjeSDG8lHn2m
         9ilQYeY3xhwgDgcforb6/RTGrC/E/yvsYN7o2nHpuzH1FPZ6XWNRPnZxOuXqwHR667Kt
         YqxJx1xMxNvvgiVRWmJMyHaoDi6zzo649vpJcJ7wjOM9SIKyw05V5ZnBMXs6h455BIho
         tvzgQC1ndygmIi7FMOfBCFdCM3uBmo2ORkw8UG5wAfwyzYt+XcZdbJ+7iW5TPSzOP6l0
         CbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AwtV56ql5JD04OQ+vZM5/s6pW7yTnPk+MazFuTHCfg=;
        b=oD4vZWe351Z7CHrdlh5b1OUuqfBJbZfvzb3341yvet/NwtZD6Y4grLiGV0QNSLDL/U
         99tWEIdu7/OcvbdslNAwxxohgWna3gnXC6sOrS+Ybr16sDKSWHmCQpeXPFlNwhHoUlps
         cd0/KhAMcHQOA3uNGg5AxjOZqllj/V3NSaSJRmmDY76Kefdnb8L6vaiYMcWT4XJmTiTd
         Gn7i24HTSAYU0jwA8mWGQ4vn9NPibGU4UYSrvTvLh5d8vCJNISpv3NKd0IVpZ8O7jiNh
         YyMnZqInarQAmW1rFzzsJzNWject+PSiVbK5OPTcIFn0Fp2s11Iud37pGYt187TLPSn8
         ODXg==
X-Gm-Message-State: AA+aEWZPWavzcZAYrEH+Ui/tfLeBQY1tBirWNNhYE++BPmgtFW/57I4S
        wCBjbr7I6EpWAmqjlbK4SVr1XaaQvXSbTnV4B1SgAyIKZEA=
X-Google-Smtp-Source: AFSGD/W4DsyH3qq8NsQbbWqMGAdk3Nu5zGXUP33pBjov7DzaIufW5UenpGvtBKoA5T8g973+NTqRJLk48ENVMIGMPV4=
X-Received: by 2002:aca:5205:: with SMTP id g5mr1164218oib.149.1543284691070;
 Mon, 26 Nov 2018 18:11:31 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 18:11:19 -0800
Message-ID: <CAPcyv4ibARHP1Gji2cZQ704BeiKL26Bh13G58eyB+PjQJSD58w@mail.gmail.com>
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

On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Move the async_synchronize_full call out of __device_release_driver and
> into driver_detach.
>
> The idea behind this is that the async_synchronize_full call will only
> guarantee that any existing async operations are flushed. This doesn't do
> anything to guarantee that a hotplug event that may occur while we are
> doing the release of the driver will not be asynchronously scheduled.
>
> By moving this into the driver_detach path we can avoid potential deadlocks
> as we aren't holding the device lock at this point and we should not have
> the driver we want to flush loaded so the flush will take care of any
> asynchronous events the driver we are detaching might have scheduled.
>

What problem is this patch solving in practice, because if there were
drivers issuing async work from probe they would need to be
responsible for flushing it themselves. That said it seems broken that
the async probing infrastructure takes the device_lock inside
async_schedule and then holds the lock when calling
async_syncrhonize_full. Is it just luck that this hasn't caused
deadlocks in practice?

Given that the device_lock is hidden from lockdep I think it would be
helpful to have a custom lock_map_acquire() setup, similar to the
workqueue core, to try to keep the locking rules enforced /
documented.

The only documentation I can find for async-probe deadlock avoidance
is the comment block in do_init_module() for async_probe_requested.

Stepping back a bit, does this patch have anything to do with the
performance improvement, or is it a separate "by the way I also found
this" kind of patch?
