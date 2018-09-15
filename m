Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F6C4161C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E2B21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQbmcQ9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E2B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIOIMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 04:12:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42513 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIOIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 04:12:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id s188-v6so1123227vss.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcSchzlr5ZtGAg/8Q66D0g7+KhyEozXOxTtB4XaXNcc=;
        b=sQbmcQ9nKQrUdC685regrvFVCyBG2xb5erfPoGh0/3qrD0YEpvq7SY8FwORTWGCILc
         RpBpHy1LONrcmGbLgMTAfKfOKDof1TUmQqsyCslAi82g4JceIXTDotWO9TiwGVVoOD3L
         Me57LOWEvS5L4k49oGVwXDrvRg3qxc7OFrY1g1+RhPI1mS7wnJco8zpsfsjQmGncmxZg
         SyRLTuyBcqPXZle5b+YzePfNdTwcIDr9yn4rT1Bk6Sf6lVHRkFQdpcZ2yj6W/kFpuH2K
         uBPa2+vk4EwJOvxrTIY5QQBCy45HXHTv9A2+vDC+hPPo94ZtoqKeVHUydhPQ3akM7pC8
         5xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcSchzlr5ZtGAg/8Q66D0g7+KhyEozXOxTtB4XaXNcc=;
        b=O9U92fMTTdjtWS09PNSM/pb3met7aMYX3SrwC4swN5n+nosi5GEEQeLV+v+8QwblV4
         0RumkaEE4bAQjknU8f7orcxPdoI3f7sj5qops4yBoaksLBuJVmwb10epM/mZodXmBSQ/
         3pfLohDBDAqPi+DNMrlipwZzxdBW5+pJDeIKl/DfEcMW5jISqp8FNmmv5URppaUXv9Oa
         Y1Ex/qgP2eXdl6md4YUiccPEYlc0y+B+rfVeySQMkxtLHWEpcB9aZ3pYDWXtoBHUNVsX
         KROtS+Uas39Bv13fpmAUEuXpFnYc83XGycixpZD3ncOV6jl/A1Zd7CKICNWXslf5bdfm
         Eh6Q==
X-Gm-Message-State: APzg51DWKteJBWr4zHNsPoDH3hDaG92q6ZG+0685aqo8NYiOhvFOdfDd
        FPReza9FgUy6GbblMOTarnq0505B4DBnmr91yMo=
X-Google-Smtp-Source: ANB0VdbsegDGhkTslzRDZ543U2uwCBBml982LIM5v5C3/PtqI5HOJfY7P4O41MdX4J4dGLhgciWh+qzAqcQ1+syA8bY=
X-Received: by 2002:a67:850f:: with SMTP id h15-v6mr4795064vsd.26.1536980125226;
 Fri, 14 Sep 2018 19:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <CAHbLzkojdPxgrEiPLcJUX9c4muw8eupStJ_0xPnAuFM7g4V1jA@mail.gmail.com>
In-Reply-To: <CAHbLzkojdPxgrEiPLcJUX9c4muw8eupStJ_0xPnAuFM7g4V1jA@mail.gmail.com>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Sat, 15 Sep 2018 08:25:13 +0530
Message-ID: <CAOuPNLgYYhrTf2EPG9C3K6Tqr4OqCehMKhyfFzh9Jz8ryZZbUA@mail.gmail.com>
Subject: Re: KSM not working in 4.9 Kernel
To:     shy828301@gmail.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018, 10:42 pm Yang Shi, <shy828301@gmail.com> wrote:
>
> Hi Pintu,
>
> I recall there are some ksm test cases in LTP. Did you try them out?

No. I haven't seen the LTP test. I will check out now.
But I wonder what is the problem with my test?


> On Fri, Sep 14, 2018 at 7:28 AM Pintu Kumar <pintu.ping@gmail.com> wrote:
> >
> > Hi All,
> >
> > Board: Hikey620 ARM64
> > Kernel: 4.9.20
> >
> > I am trying to verify KSM (Kernel Same Page Merging) functionality on
> > 4.9 Kernel using "mmap" and madvise user space test utility.
> > But to my observation, it seems KSM is not working for me.
> > CONFIG_KSM=y is enabled in kernel.
> > ksm_init is also called during boot up.
> >   443 ?        SN     0:00 [ksmd]
> >
> > ksmd thread is also running.
> >
> > However, when I see the sysfs, no values are written.
> > ~ # grep -H '' /sys/kernel/mm/ksm/*
> > /sys/kernel/mm/ksm/pages_hashed:0
> > /sys/kernel/mm/ksm/pages_scanned:0
> > /sys/kernel/mm/ksm/pages_shared:0
> > /sys/kernel/mm/ksm/pages_sharing:0
> > /sys/kernel/mm/ksm/pages_to_scan:200
> > /sys/kernel/mm/ksm/pages_unshared:0
> > /sys/kernel/mm/ksm/pages_volatile:0
> > /sys/kernel/mm/ksm/run:1
> > /sys/kernel/mm/ksm/sleep_millisecs:1000
> >
> > So, please let me know if I am doing any thing wrong.
> >
> > This is the test utility:
> > int main(int argc, char *argv[])
> > {
> >         int i, n, size;
> >         char *buffer;
> >         void *addr;
> >
> >         n = 100;
> >         size = 100 * getpagesize();
> >         for (i = 0; i < n; i++) {
> >                 buffer = (char *)malloc(size);
> >                 memset(buffer, 0xff, size);
> >                 addr =  mmap(NULL, size,
> >                            PROT_READ | PROT_EXEC | PROT_WRITE,
> > MAP_PRIVATE | MAP_ANONYMOUS,
> >                            -1, 0);
> >                 madvise(addr, size, MADV_MERGEABLE);
> >                 sleep(1);
> >         }
> >         printf("Done....press ^C\n");
> >
> >         pause();
> >
> >         return 0;
> > }
> >
> >
> >
> > Thanks,
> > Pintu
> >
