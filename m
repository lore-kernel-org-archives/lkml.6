Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C692CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B921741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rXpUPikK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeL0ERX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 23:17:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33548 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbeL0ERX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 23:17:23 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so13678229ioi.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 20:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCESWc1L3bXPUa7GxzNSYipd+HI9huEQRbmH4ojmiqc=;
        b=rXpUPikKG0nTVOVh2RPsNpb5CEfK5+vEMUUYURHRWVezC2K4eYPPIU2o+NPmLmyC2b
         fx4EtBPwKucVAM+FCm/v6wjyU78spO9XiObkRYLpAAgMi+pRnk9Y8OuhtHYIuAV1ndhd
         8pxFiYte3iTMC3lfyblpr7YrLCsUsKw9s8a5rv+but4gI8wjffFcE0DME9Gd4nAH8jJU
         wSeqiU3IpuOPDUJuft/C6/otFtMKqTL2vIt9CaEF16pzbk545goRltzuwqewwxoAsGrB
         VDaZDz5usQtd3lrUf9cReTp3UmR87Wtye8ByO09mGD3tBu/o4XR2DyVjasg6IQmiVi4g
         T/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCESWc1L3bXPUa7GxzNSYipd+HI9huEQRbmH4ojmiqc=;
        b=XqTOIBXhcy9OPZxvJ52Gxm8fQRfoi5lIGkopW6Fh0UXjxAahlLyEa3qvVSSEZytCCU
         MvwAB2Rx7KYlOKxUeH92nIFNRYHhOX92TOzMCgnc5y79gMAVq9jOgQbJxIYwMJ8VgF0a
         YVtBbq6fEtgIkdqtV8JU4J4Cw0w81Ik5aU/IlpFnE7o6iAtztELJVnTLuHikg7Kc0eDD
         XuNldozDaqnvRmKPKR7VnLGeiCTqVP6f0+vur7tQkp3SNJMv2bnJZp2p4KA3DCo7almx
         VCNA0xAVmVZND9U3JDSS5zQliKac/KM0E9NzVQsTXtX4Qlb2oGKqiefujlJLhy+JC177
         6suA==
X-Gm-Message-State: AJcUukcsq/Dy4NdDIgu604Se5Oyd8IRtmg90Gs8AA5FTTDUXzHDHN+Xi
        sDZOVHMeWTrdYozrnQVxQOc14SsoSCz+/0zZIMijTw==
X-Google-Smtp-Source: ALg8bN56iFsIa3OCzxkzjoM03MTjmhkTJRpJyLEmUTeELW4QtTvSLuBo7tv9QpBn5fsFNGc7frKIzAbbKOVOAkSQ84A=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr16450758iol.155.1545884241356;
 Wed, 26 Dec 2018 20:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20181224224509.GA67077@gmail.com>
In-Reply-To: <20181224224509.GA67077@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 26 Dec 2018 20:17:10 -0800
Message-ID: <CAOesGMjQg2vo2-fbjppumttN1Mz9Ce6VqvK0SkfhdkHPxhP=DQ@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v4.21
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 24, 2018 at 2:45 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> Linus,
>
> Please pull the latest sched-core-for-linus git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus
>
>    # HEAD: 732cd75b8c920d3727e69957b14faa7c2d7c3b75 sched/fair: Select an energy-efficient CPU on task wake-up
>
> The main changes in this cycle were:
>
>  - Introduce "Energy Aware Scheduling" - by Quentin Perret. This is a
>    coherent topology description of CPUs in cooperation with the PM
>    subsystem, with the goal to schedule more energy-efficiently on
>    assymetric SMP platform - such as waking up tasks to the more
>    energy-efficient CPUs first, as long as the system isn't
>    oversubscribed.
>
>    For details of the design, see:
>
>       https://marc.info/?l=linux-kernel&m=153243513908731&w=2
>
>  - Misc cleanups and smaller enhancements.

Looks like my warnings fix never made it in, even after a few pings.

Linus, can you apply directly? Causes warning noise on all !SMP ARM builds:

https://lore.kernel.org/lkml/20181125224105.123568-1-olof@lixom.net/


Thanks,

-Olof



-Olof
