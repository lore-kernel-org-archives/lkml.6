Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF76C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BFD2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSQTy0Kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfBYExw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:53:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43776 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfBYExw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:53:52 -0500
Received: by mail-io1-f66.google.com with SMTP id y6so6466772ioq.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 20:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sk4dU6rvo+500IaBeXfEVoZHa3YtQSt/I/4mK2ohmhs=;
        b=iSQTy0KldxsBrE6JlYux75WeMBbyC4AS554tzqS4wtBTousBPfYdO0roT6n1leYtN0
         izKk2qiq3MW4/rf9XcuAlP+NNffkwkvljkd5E4Pxs5NZ6qsxCh0V3d1I7z2S+pshnaej
         UnTCKww+hVFXSS3UATzzfETbGY94fsoTTmtRIqYSC4kNXw+BaV+Iul7zCCTMfje0QWF6
         PJf7OSQGhAsNX9Nzx89jrw5VJoqsC+BMFyfVCTlbi3nLkesltNjg+VeNSKTAj/YmFOM8
         qqLDNynDrMKS0jYEDzFfCL0eWzDcPzBUPnVEsI+Pr9iRsshWBSM27ZkotP61f+bkHQkx
         xK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sk4dU6rvo+500IaBeXfEVoZHa3YtQSt/I/4mK2ohmhs=;
        b=FVjIT1AIQfG/BvcAxnEhM538PfPOYrc5NMGRtyYbQ2iyXxXU+VQGChcFLP9L4svRgX
         MRSHPqy4bksThmB7R18ps4jiL9hNvnOIq6mN5g1GWBABAqHTfC1/U5d9qXfcmyM86aeX
         cWIcmgMpyBFEiivyTrg/9JGZyQtKCucbME0bE2zpIvVi14+4PTc0R1Cp05lRQ3pTAPy6
         sugrTirD2gVPU/mSlQotZ8lx61Z61D1ROc8PW/1AkbONyTiLYM0UckNcdQaRxbWtt6wd
         XRcx8dW5deiDEJsY6AklNmlZPT0s8i+Ai0LnJmRQ6Lezn5OxI0TZoXgqc3pz2uEeTIgI
         2F2g==
X-Gm-Message-State: AHQUAuavhvObrYrX7DIRNsg0PoVD+zEY9R2na6rbHs0XiXLyU7sbUIoL
        yuK3SXFgT1Cb6NBQsUhqW8VErOFhWehQ9PqG46k=
X-Google-Smtp-Source: APXvYqzn1qld66YE0luJ+gEU3q/O2VxaPBeryoDjbwfe2UKyCEvobfxa1wwFHdR4X6jUJdr+lVYwavleZkKaM5WrhGM=
X-Received: by 2002:a5d:9b8d:: with SMTP id r13mr83960iom.34.1551070431133;
 Sun, 24 Feb 2019 20:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20190225032619.17070-1-yaohongbo@huawei.com>
In-Reply-To: <20190225032619.17070-1-yaohongbo@huawei.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 24 Feb 2019 20:53:40 -0800
Message-ID: <CABeXuvqOEqN7fRa1pkLKNhNckoUpCoyxKRdieD+UE8DFt+yQ+g@mail.gmail.com>
Subject: Re: [PATCH] time64: Avoid undefined behaviour in timespec64_add()
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 7:13 PM Hongbo Yao <yaohongbo@huawei.com> wrote:
>
> I ran into this:
>         =========================================================================
>         UBSAN: Undefined behaviour in ./include/linux/time64.h:70:2
>         signed integer overflow:
>         1551059291 + 9223372036854775807 cannot be represented in type 'long
>         long int'
>         CPU: 5 PID: 20064 Comm: syz-executor.2 Not tainted 4.19.24 #4
>         Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>         1.10.2-1ubuntu1 04/01/2014
>         Call Trace:
>          __dump_stack lib/dump_stack.c:77 [inline]
>          dump_stack+0xca/0x13e lib/dump_stack.c:113
>          ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
>          handle_overflow+0x193/0x1e2 lib/ubsan.c:190
>          timespec64_add include/linux/time64.h:70 [inline]
>          timekeeping_inject_offset+0x3ed/0x4e0 kernel/time/timekeeping.c:1301
>          do_adjtimex+0x1e5/0x6c0 kernel/time/timekeeping.c:2360
>          __do_sys_clock_adjtime+0x122/0x200 kernel/time/posix-timers.c:1086
>          do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
>         RIP: 0033:0x462eb9
>         Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
>         f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
>         f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>         RSP: 002b:00007f888aa2dc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
>         RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462eb9
>         RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000000
>         RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
>         R10: 0000000000000000 R11: 0000000000000246 R12: 00007f888aa2e6bc
>         R13: 00000000004bcae8 R14: 00000000006f6868 R15: 00000000ffffffff
>         ==========================================================================
>
> Since lhs.tv_sec and rhs.tv_sec are both time64_t, this is a signed
> addition which will cause undefined behaviour on overflow.
>
> The easiest way to avoid the overflow is to cast one of the arguments to
> unsigned (so the addition will be done using unsigned arithmetic).
> This patch doesn't change generated code.
>
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  include/linux/time64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/time64.h b/include/linux/time64.h
> index 05634afba0db..5926bdd4167f 100644
> --- a/include/linux/time64.h
> +++ b/include/linux/time64.h
> @@ -67,7 +67,7 @@ static inline struct timespec64 timespec64_add(struct timespec64 lhs,
>                                                 struct timespec64 rhs)
>  {
>         struct timespec64 ts_delta;
> -       set_normalized_timespec64(&ts_delta, lhs.tv_sec + rhs.tv_sec,
> +       set_normalized_timespec64(&ts_delta, (timeu64_t)lhs.tv_sec + rhs.tv_sec,
>                                 lhs.tv_nsec + rhs.tv_nsec);
>         return ts_delta;
>  }

There is already a timespec64_add_safe() to account for such
overflows. That assumes both the timespec64 values are positive.
But, timekeeping_inject_offset() cannot use that as one of the values
can be negative.

Are you running some kind of a fuzzer that would cause a overflow?
You seem to be adding INT64_MAX here. Maybe the right thing to do is
to add a check at the syscall interface rather than here.

-Deepa
