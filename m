Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3936218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGofCmIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfB0CiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:38:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33739 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfB0CiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:38:15 -0500
Received: by mail-it1-f193.google.com with SMTP id f186so3993079ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HY2Kcq8jzF4/oZcS7u/BPoovRBNx3+sI7Sf8FjSx7xg=;
        b=RGofCmIiimiCFUdsn6EnEgTIS8DuSuhD+x6v2vOeY3m6rwmxnWu7FVhyqJ1bcjBPHU
         jau7tG/Ixzn4KMCvKcMCH1m9QK2VrnBH2NRDEGfjgGeViHDNynpwiT2phwC+3eFOmSfD
         TQ+kTbN5ngKYlZoWyxOZZ7B6LIgjLdNTc4Hl8k6A8szEpjdYBYdIasKUx09xWBg2AOL0
         osF4bsOJaPsTfe1KPS/+oNFV4gm+M34ospccr1gjGDhGPNHKMEZLciqRwH+dcDZZwpgQ
         WhcFDsS1d9ZFTendrb1yIwp1zIfQQ6fDR/KrDAgegZw4BpMC9xMSFvw9Ua80/XGE0Wu3
         9jWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HY2Kcq8jzF4/oZcS7u/BPoovRBNx3+sI7Sf8FjSx7xg=;
        b=nW9mMKfycpa7Tl3IQxA3UPCSMtcVTDVdaqhAkLGw3W8nNRpG4LqisIlzSL059cvK2Y
         UdqkOlHej++Nxm0Giq+7sIsYeyLpTGXsLhDALdyUXyDExL8E43EagcdItpUDuFEbcNBu
         Q8FFR1GcGLcS2KBAFK2pcBUbjw8UcFod4KIPCa35b7EuHxzlEJS7SiAcZ3hp+O7rQY3x
         VVjRq+zaHOmNx6TjyZCZWikhKh26abaDmR9oOmSB+HGVLdpOWGrplc6gVdrbzUMvWu0s
         1rsj4sAraY4p3m0szNiMiJsir+GBiq2irE2/B90ugcg/XHJLJ7SeQwLwRWPDh5nf4yJU
         sNiw==
X-Gm-Message-State: APjAAAUrE8sjXA4ZuA7CSe/DascAX3io2jsG9Owrp6/iozuoVoOSWt0n
        oDUFeTk1KVR2BRyvfRS8x2+pimO3Z8AWUHuBAEU=
X-Google-Smtp-Source: AHgI3IZtSt1W84pJwbbVLIHJNMJKBwjoMWVj2EAJaf7Mrje33+xzOyTmXoQF0AQp3Z3wK0Tq6qHPjAYUXW5hil2B3rw=
X-Received: by 2002:a24:54c5:: with SMTP id t188mr189272ita.58.1551235094230;
 Tue, 26 Feb 2019 18:38:14 -0800 (PST)
MIME-Version: 1.0
References: <1551233212-42022-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1551233212-42022-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 26 Feb 2019 18:38:03 -0800
Message-ID: <CABeXuvoKTeC2e150keLo+z_+3_dykbSiNwVZuHemJSgDovW7Cw@mail.gmail.com>
Subject: Re: [RFC PATCH] posix-cpu-timers: Avoid undefined behaviour in timespec64_to_ns()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 6:07 PM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> When I ran Syzkaller testsuite, I got the following call trace.
> ================================================================================
> UBSAN: Undefined behaviour in ./include/linux/time64.h:120:27
> signed integer overflow:
> 8243129037239968815 * 1000000000 cannot be represented in type 'long long int'
> CPU: 5 PID: 28854 Comm: syz-executor.1 Not tainted 4.19.24 #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xca/0x13e lib/dump_stack.c:113
>  ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
>  handle_overflow+0x193/0x1e2 lib/ubsan.c:190
>  timespec64_to_ns include/linux/time64.h:120 [inline]
>  posix_cpu_timer_set+0x95a/0xb70 kernel/time/posix-cpu-timers.c:687
>  do_timer_settime+0x198/0x2a0 kernel/time/posix-timers.c:892
>  __do_sys_timer_settime kernel/time/posix-timers.c:918 [inline]
>  __se_sys_timer_settime kernel/time/posix-timers.c:904 [inline]
>  __x64_sys_timer_settime+0x18d/0x260 kernel/time/posix-timers.c:904
>  do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x462eb9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f14e4127c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
> RAX: ffffffffffffffda RBX: 000000000073bfa0 RCX: 0000000000462eb9
> RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f14e41286bc
> R13: 00000000004c54cc R14: 0000000000704278 R15: 00000000ffffffff
> ================================================================================
>
> This patch use 'timespec64_to_ktime()' to limit 'tv_sec' to avoid
> overflow.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  kernel/time/posix-cpu-timers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 80f9552..f7e3929 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -684,7 +684,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>          * Install the new reload setting, and
>          * set up the signal and overrun bookkeeping.
>          */
> -       timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
> +       timer->it.cpu.incr = ktime_to_ns(timespec64_to_ktime(new->it_interval));
>         timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
>
>         /*

This seems like a similar bug as the other one
https://lkml.org/lkml/2019/2/24/214. Maybe it makes sense here also to
do some bounds checking when we get the userspace parameter.
This patch just saturates the value.

-Deepa
