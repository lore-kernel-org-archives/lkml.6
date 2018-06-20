Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C676C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B31B20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4hpydDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B31B20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754943AbeFTTfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:35:05 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43622 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754667AbeFTTfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:35:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id x13-v6so1007025lff.10;
        Wed, 20 Jun 2018 12:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1TYUX0Ctd870+oAe4u9AOmTinwJeosIUhhRdCGH/peA=;
        b=Z4hpydDmFRqFUzDJXcpcqDO94VOHK+OZNy9L2HMFebU5BqtoCvWZd6T1sV9lj2Xcay
         3NxMBfgEAXK7HyZTRaEiavQg3FnhPT4EXd9w4+4tWa4pBGF/zKo3NeWFhmlIk+k6ow47
         i656r2CPjRLisah5jvv8VAzydbzr48WCvf8CKms8F2a0YT+nlKi9/tMETaF7t94FkMrp
         4Oo+Xxb6ZyZnjf/fcL/SiZgQfisPObxGYJpwkxrk1MDbFyEeOXzZbm8SzD1zJs6ZUsjm
         bLcJnrnBL0ROa3fq6ulHDtVvasYwwocPDD/f7CcmVtELSXR9x/trvEFqFQ+/cvQc0lek
         1UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1TYUX0Ctd870+oAe4u9AOmTinwJeosIUhhRdCGH/peA=;
        b=b0J7wl44SiivC9pPgKaIa5kBkF+vScSr4PEAj/EDwDi+pNMY1eF+AZB0q6bFI7sIbR
         Npy4U12B2gmjkHQYytTZ+VzVLHZHhmcp/BnCue4z8s8Rsiqy6JHeUyx2ogBjjk9sPKsU
         VS1abs8DZ7xrWLpEIxPYTDNZZlcU0ayzMMnLtgm8o4umq1aWeKxIivaB8qrMq2E2F8OH
         t4eWbg1C4FvQ/xcoX91VkrMVPJ2TSd+cACuDNG1NaLt5m8V/Uk2QUM2MyvqgDINGnYq2
         U4R/s2Lct9e/Dg09sHLuaFtTl5pAol2v5C2ZfsJVvn7ZYqPxGyE8iy+I6zUVPz0qi3/I
         Nb4w==
X-Gm-Message-State: APt69E1kPHbXOHO2weJM/DB9tFlXsgG0MeQPPuLnhohFGruf2lAmmGKq
        Yzs/w7gS3cmBAw+5C/hLN+fr3UmC/pneUQtu+R8=
X-Google-Smtp-Source: ADUXVKLFwRKvYxijL1uIEw/CYpHI+MrsQw+cVKr+/hVoMzfrM3rt0hhqX9ooyJw28UTn4LAiTslrqC92cQOapMjt4Xo=
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr14937186ljg.22.1529523301304;
 Wed, 20 Jun 2018 12:35:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:35:00
 -0700 (PDT)
In-Reply-To: <87muvpsa61.fsf@linux.intel.com>
References: <20180620150138.49380-1-arnd@arndb.de> <87r2l1sby0.fsf@linux.intel.com>
 <CAK8P3a1J9j7pz-d+otbJweWgOZZePdaMJEb_sU2GJKi3oYq7Xg@mail.gmail.com> <87muvpsa61.fsf@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 21:35:00 +0200
X-Google-Sender-Auth: 2o9seSztMnOmeazK8jylqnYigTg
Message-ID: <CAK8P3a1Lr2y1SZonodsyUETkc3d_NBOzyOGGv0OFSW=Xo_RVsA@mail.gmail.com>
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Brian Foster <bfoster@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 6:19 PM, Andi Kleen <ak@linux.intel.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> To clarify: current_kernel_time() uses at most millisecond resolution rather
>> than microsecond, as tkr_mono.xtime_nsec only gets updated during the
>> timer tick.
>
> Ah you're right. I remember now: the motivation was to make sure there
> is basically no overhead. In some setups the full gtod can be rather
> slow, particularly if it falls back to some crappy timer.
>
> I think it would be ok if it falls back to jiffies if TSC or a similar
> fast timer doesn't work. But the function you're using likely
> doesn't do that?

My patch as posted just uses ktime_get_coarse_real_ts64(), which
doesn't ever access the hires clocksource, the change is just cosmetic
so far.

The timekeeping and clocksource core code (maintainers added to Cc)
doesn't yet export an API that we can use to determine whether the
clocksource is "fast" or not, but I would expect that we can decide
to add that if needed.

This is also something that definitely changed over the years since
your patch was originally added. Back then, the x86 TSC probably
wasn't reliable enough to depend on it but now I would guess that
very few x86 machines in production use care. On embedded systems,
we used to have all kinds of clocksource drivers with varying
characteristics, but nowadays the embedded market is dominated
by ARMv7VE (Cortex-A7/A15/A17) or ARMv8, which are required
to have a fast clocksource (drivers/clocksource/arm_arch_timer.c),
and a lot of the others have it too (risc-v, modern mips, all ppc32,
most ARM Cortex-A9, ...).
The traditional non-x86 architectures (s390, powerpc, sparc) that
are still being used have of course had low-latency clocksource
access for a much longer time.

This means, we're probably fine with a compile-time option that
distros can choose to enable depending on what classes of hardware
they are targetting, like

struct timespec64 current_time(struct inode *inode)
{
        struct timespec64 now;
        u64 gran = inode->i_sb->s_time_gran;

        if (IS_ENABLED(CONFIG_HIRES_INODE_TIMES) &&
            gran <= NSEC_PER_JIFFY)
                  ktime_get_real_ts64(&now);
        else
                  ktime_get_coarse_real_ts64(&now);

        return timespec64_trunc(now, gran);
}

With that implementation, we could still let file systems choose
to get coarse timestamps by tuning the granularity in the
superblock s_time_gran, which would result in nice round
tv_nsec values that represent the actual accuracy.

Obviously this still needs performance testing on various bits
of real hardware, but I can imagine that the overhead is rather
small on hardware from the past five years.

     Arnd
