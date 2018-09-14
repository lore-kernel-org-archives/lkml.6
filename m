Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF585FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696DE21477
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696DE21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeINUCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:02:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39630 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeINUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:02:04 -0400
Received: by mail-qt0-f193.google.com with SMTP id o15-v6so8942014qtk.6;
        Fri, 14 Sep 2018 07:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9LTvDgdz+2tFx2LW9erCwQ5SwqzE+BUV4EHIMksBgg=;
        b=edSm+7rzJjPqiAoMiVuk5aokPypuFA5VxpmRFVnp/p0gyDKvSpZQ+FqEi3h+XbrqPj
         mNDCP6r2nIn0kuEmAfDCZ9EZy5/W8XY80f8+s5DmiivJA6YRcE208Jrx0RbJcC5T0QEb
         80swzowj1stYDpIYi/vmd15s+pSGL2Pc0zsI/K7kB9rogdfDAms/Nn/5u44n3TS1hlLD
         gGJ305MqMDu8aOILiCbQifCObP0X1k1+/+tJEFofSIun6qU3epUjP4FQh/RGW7wYhKBw
         G6Jq+IpvexjwjI7/KTWVYkFan3neyi4MjzFJJS0D0X4zFlQ0JXjfZGjDV/7hn3697kDn
         7gPg==
X-Gm-Message-State: APzg51BWiQTOY+gAMpS6pKfKANHGCBz1X5lGM+Y/R8OnE6HVZlZEIq+O
        mTU5ST8q1ZoV9667wK/R5zil8ISVl8NeeK2FpQE=
X-Google-Smtp-Source: ANB0VdaZ7zO7zMdMvN5MSHX10Ox5tu7n0qyFONrRm1HFG4afYdOJvBxG8MFcu5UZbn5h69uUNg4yDmrbrIOV986pvVQ=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr8883464qvc.180.1536936432340;
 Fri, 14 Sep 2018 07:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536757532.git.ren_guo@c-sky.com> <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
 <20180914143719.GA27689@guoren-Inspiron-7460>
In-Reply-To: <20180914143719.GA27689@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 16:46:56 +0200
Message-ID: <CAK8P3a0fZYbd4a2nBnExPVXKs-898R9vaCSa4kXyz0qA=rCzZQ@mail.gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 4:37 PM Guo Ren <ren_guo@c-sky.com> wrote:
> On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > One big question for me is what to do about time_t. Deepa and I are
> > in the process of finalizing the system call ABI for 32-bit architectures
> > with 64-bit time_t, but we are not done yet and it won't be complete
> > for 4.20. If you target 4.21, that could be a chance to make csky the
> > first architecture to only need the 64-bit time_t interface, with the
> > corresponding user space changes.
> y2038 is very important and csky32 has the issue. But 4.21 is too late for
> us, we really want to get into kernel.org as soon as possible.
> We could remove 32-bit time_t in future.

Not really: the way we deal with user-visible APIs in the kernel, it's
practically impossible to remove something that was working before,
since there may always be users relying on it. This is why it is so
important that we get the ABI right at the first try.

We can always add new ABIs later, and that's what we're doing with
all the other 32-bit architectures as well: each system call that takes a
32-bit time_t argument also needs to get the corresponding 64-bit
replacement, and then we have to keep them both around.

However, once the 64-bit syscalls are there, you don't need to
use them, so if you merge the glibc port after both csky and
the time64 syscalls are merged upstream, you can choose
to only support the time64 syscalls rather than making it a compile
time decision in each application. If you merge the glibc port
before migrating to 64-bit syscalls, glibc will also have to support
both indefinitely for compatibility with existing binaries.

One level below that, you can of course choose to build
a distro with only 64-bit time_t regardless of whether there
is still support for 32-bit time_t in kernel and glibc or not.

        Arnd
