Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE6EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5D208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+wd35cV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF5D208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeGIVb2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:31:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41407 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933049AbeGIVbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:31:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id v22-v6so2957244lfe.8;
        Mon, 09 Jul 2018 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kmZ7qRQHqSZd1GrG0lW3437yq1TP/ppTpLXK2iwCtP8=;
        b=F+wd35cVYGuxz/H22puMer/MndpAfMo3C3N+gXgWZB7vdtZpne1ot8xoW0AieaGUM4
         ILdkGyaCzaSN4cNZYVDFibll3Nbxn4yhUQg9L5zozec7iHgXYR6AtFwVplsfLzW/rAIw
         9OJOWnj+1t2kYlar+iYqDBeh0j4IjNVd2DnF2eJrus8/5knnK61mk08s5bEkQdJxceBy
         lOPtM0CHAAnpbRq0wFzbiIFkUTYUwa2iIpQFNCWNqOSvCXy5RnG42NwZqfTQHAa9NTHl
         HPHC6zYs1fU91w/LZJtHM6CxAN5MCnuuCA7j165s/jR4HnIxzCaxrCJ1UbeQh/yZ66wU
         gezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kmZ7qRQHqSZd1GrG0lW3437yq1TP/ppTpLXK2iwCtP8=;
        b=dl+xOp3si4xno0FdroC/7aUchJttU0xs93o1r8uH7fzlNwqy4H1FIgbge1SerQRu4P
         M1vcU1njgVDC1QHLli4kzEExXIHX+US6EaXMFfAfiGkDezleCH8ZMiXJU349rq+PaunJ
         GB8jcxteY0hoYmeBSgWgFZzBAg/BDEpThMuLprQ5t4QyUezdSo+GS7muzQ9o9xOp5Irs
         T0aUcxD3pGk9/t27L1X8XjMOuhTIzStHYsdOXplPcRnXdFSQyFWWlQ4Qf+LABSiyslLD
         HguLIxuX0/BSGdpEYWlT2f+VS6JEwP1Y6KQn8OtEKEAhIIxg/sbmPhktMJMFsjhKfqxM
         Y+xA==
X-Gm-Message-State: APt69E1/EUDScGnDiekQ9kt2576RP3/ZdMdIm6g8gAlw3zsllROR7Vmy
        8whbLRmgfQBjO732l17jF8u6aVB7lSUsq4I8EJI=
X-Google-Smtp-Source: AAOMgpezOBNu8W4sPNxZ0bPbcSWwVU770dx8/ul+BsCaBKhx5CNIwQ+HO5tEV3Hk3hCAYHGaYd7RLAo92DjmHtZ0N24=
X-Received: by 2002:a19:7b08:: with SMTP id w8-v6mr761070lfc.22.1531171882098;
 Mon, 09 Jul 2018 14:31:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 14:31:21 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1807011844470.19761@math.ut.ee>
References: <20180619140229.3615110-1-arnd@arndb.de> <CA+7wUsyN_gru4rW0y3ZzXzYwhfaA=uHKaOG=z5bprnYq6oVfMg@mail.gmail.com>
 <alpine.LRH.2.21.1807011844470.19761@math.ut.ee>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Jul 2018 23:31:21 +0200
X-Google-Sender-Auth: pcpa39DhBENsR_eKzz3Mvd7v7VE
Message-ID: <CAK8P3a29rNtWCcgKeJK57C5CPPi74wc1o1cnPJM=Qe+eMKFYjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
To:     Meelis Roos <mroos@linux.ee>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 5:47 PM, Meelis Roos <mroos@linux.ee> wrote:
> A patch for the subject is now upstream. That made me finally take some
> time to test it on my PowerMac G4. Tha date is OK but I get two warnings
> with backtrace on bootup. Full dmesg below.

Thanks for testing this, and sorry for the slow reply.

> [    4.026490] WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/powermac/time.c:154 pmu_get_time+0x7c/0xc8
> [    4.032261] Modules linked in:
> [    4.037878] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         4.18.0-rc2-00223-g1904148a361a #88
> [    4.043750] NIP:  c0021354 LR: c0021308 CTR: 00000000
> [    4.049585] REGS: ef047cd0 TRAP: 0700   Tainted: G        W          (4.18.0-rc2-00223-g1904148a361a)
> [    4.055572] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 44000222  XER: 20000000
> [    4.061620]
>                GPR00: c0021308 ef047d80 ef048000 00000000 00d7029c 00000004 00000001 0000009c
>                GPR08: 00d70000 00000001 00000200 c06a0000 24000228 00000000 c0004c9c 00000000
>                GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0670000 c0601a38
>                GPR24: 00000008 c0630f18 c062a40c c05fc10c ef047e50 ef273800 ef047e50 ef047e50
> [    4.092393] NIP [c0021354] pmu_get_time+0x7c/0xc8
> [    4.098596] LR [c0021308] pmu_get_time+0x30/0xc8

I don't see how the WARN_ON() triggered unless the PMU time is
actually before 1970.

> [    4.104779] Call Trace:
> [    4.110909] [ef047d80] [c0021308] pmu_get_time+0x30/0xc8 (unreliable)
> [    4.117209] [ef047df0] [c00213e8] pmac_get_rtc_time+0x28/0x40
> [    4.123470] [ef047e00] [c000bc04] rtc_generic_get_time+0x20/0x34
> [    4.129770] [ef047e10] [c03aca34] __rtc_read_time+0x5c/0xe0
> [    4.136060] [ef047e20] [c03acafc] rtc_read_time+0x44/0x7c
> [    4.142356] [ef047e40] [c061e000] rtc_hctosys+0x64/0x11c
> [    4.148616] [ef047ea0] [c0004aa4] do_one_initcall+0x4c/0x1a8
> [    4.154866] [ef047f00] [c06022f0] kernel_init_freeable+0x12c/0x1f4
> [    4.161123] [ef047f30] [c0004cb4] kernel_init+0x18/0x130
> [    4.167359] [ef047f40] [c00121c4] ret_from_kernel_thread+0x14/0x1c
> [    4.173610] Instruction dump:
> [    4.179766] 8941002e 5484c00e 5508801e 88e1002f 7c844214 554a402e 7c845214 7c843a14
> [    4.186076] 7d244810 7d294910 7d2948f8 552907fe <0f090000> 3d2083da 80010074 38210070
> [    4.192388] ---[ end trace 2e01ad9337fe08fd ]---
> [    4.198643] rtc-generic rtc-generic: hctosys: unable to read the hardware clock

The last message here happens exactly in that case as well: tm_year is before
1970:

int rtc_valid_tm(struct rtc_time *tm)
{
        if (tm->tm_year < 70
                || ((unsigned)tm->tm_mon) >= 12
                || tm->tm_mday < 1
                || tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900)
                || ((unsigned)tm->tm_hour) >= 24
                || ((unsigned)tm->tm_min) >= 60
                || ((unsigned)tm->tm_sec) >= 60)
                return -EINVAL;

        return 0;
}

The most likely explanation I have here is that the RTC was indeed set to an
incorrect date, either because of a depleted battery (not unlikely for
a ~15 year
old box) or because it was previously stored incorrectly. You say that the
time is correct, but that could also be the case if the machine is connected to
the network and synchronized using NTP. It should not have gotten the
time from the RTC after that error.

If you have the time to do another test, can you boot the machine with
its network disconnected, see if the warning persists (it may have been
repaired after the correct time got written into the RTC during shutdown),
what the output of 'sudo hwclock' is, and whether anything changes after
you set the correct time using 'hwclock --systohc' and reboot?

         Arnd
