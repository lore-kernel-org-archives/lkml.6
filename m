Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5040BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A32082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1uR/+mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfBDSyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:54:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51676 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbfBDSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:54:17 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so2358536ite.1;
        Mon, 04 Feb 2019 10:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhDsBmAWjWfL0oOpE7PsCA+chMU/0p+OBJ8CCTWr+Yk=;
        b=o1uR/+mH25KqAsRDooVgfxKjhvx39dSrICkh6DrYE4Og/rjLQcg/mpMpY717gPO/ZM
         CVxa87QXECxl+w4PY1xo0/ndvvUNhqo5wR4wOzEnx0MSCNvUP6EEtV0RG/bNwDS4Uj0G
         JCLiv6iS1AqFjRkHXYYycI2jEV2ARqaxjx+Iu9zPNfT+zYdO4HNiVQ3G5V9OenaVoWZ4
         32fWAkTN14M4RSCsQVQODUF8x0+O8kci636GZ6tOyPEy4330/RWYP7jA3v1vJ2+cGpff
         ZmJHT9eqBtRozZxyOgXzBV7+cXN466MM2mLwU8p+xJMnz0cTVoEB2fhiCDQ02aEPN/rZ
         hlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhDsBmAWjWfL0oOpE7PsCA+chMU/0p+OBJ8CCTWr+Yk=;
        b=rtxkt5aGVZP47SwNDYiFIAKQFyysUre8bZrwYdnaZbneyPEJI1nwoEH+NkbMhBTVn1
         09TtQJmwqV8cDnxS6JSm9DOXck4qMuVpHNWavl5uyz/bvJ2XkKlPTOLQ2gPqnIa8sY5b
         m17KixYK0k0NGISsEWRZlgESJ3BxumcJ2mcUVYqwSd2eolrN53qmGnzOXZYTSao/XKXd
         ipN/Odpi50hHkPKdwGG++pPCg+3+pbz13JgZdeUCDmb0EsspxNxXF1R8XHl8AWo2wtON
         h34nnCZH79tunVS6hgZuQYIvQyoktiqPoJbjpM9NfsxnYUvRiZwDOGrjpeyYo+jXvPEO
         szZw==
X-Gm-Message-State: AHQUAuauloORr97r1Wjfu/N2wIudCE0Qr40czhiNZMEcwM0jf0MSVH+r
        voNur9/TpXmOH3H9KdBbRu9P5g3nT3XU9VT6XKk=
X-Google-Smtp-Source: AHgI3IbJbCD0h93XHl135FZ6AMNaoP8F9QInyBS3uvhy8aKejb8Zhy6eZfH87+V7xGiCE/xX6qHHyMfQHkzvk3UPLGg=
X-Received: by 2002:a5d:87d8:: with SMTP id q24mr473699ios.89.1549306456232;
 Mon, 04 Feb 2019 10:54:16 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+aUy-3F43ECZACEps4c3GcbqCne9XFV8q7G8Dm8afn6kA@mail.gmail.com>
 <20190204174856.GA10769@mini-arch>
In-Reply-To: <20190204174856.GA10769@mini-arch>
From:   Y Song <ys114321@gmail.com>
Date:   Mon, 4 Feb 2019 10:53:40 -0800
Message-ID: <CAH3MdRWHr4N8jei8jxDppXjmw-Nw=puNDLbu1dQOFQHxfU2onA@mail.gmail.com>
Subject: Re: bpf: BPF_PROG_TEST_RUN leads to unkillable process
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, songliubraving@fb.com,
        Yonghong Song <yhs@fb.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 9:49 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 02/01, Dmitry Vyukov wrote:
> > Hello,
> >
> > The following program leads to an unkillable process that eats CPU in
> > an infinite loop in BPF_PROG_TEST_RUN syscall. But kernel does not
> > self-detect cpu/rcu/task stalls either. The program contains max
> > number of repetitions, but as far as I see the intention is that it
> > should be killable. I see that bpf_test_run() checks for
> > signal_pending(current), but it does so only if need_resched() is also
> > set. Can need_resched() be not set for prolonged periods of time?
> > /proc/pid/stack is empty, not sure what other info I can provide.
> There is a bunch of places in the kernel where we do the same nested check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/broadcom/tg3.c#n12059
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/hw_random/s390-trng.c#n80
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c#n1049
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/crypto/prng.c#n470
>
> So it's not something unusual we do. OTOH, in the kernel/bpf/verifier.c
> do_check() we do signal_pending() and need_resched() sequentially. In
> theory, it should not hurt to do them in sequence. Any thoughts about
> the patch below? I think we also need to properly return -ERESTARTSYS
> when returning from signal_pending().

I think return value -ERESTARTSYS should be okay.
For the test_run attributes,

        struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
                __u32           prog_fd;
                __u32           retval;
                __u32           data_size_in;   /* input: len of data_in */
                __u32           data_size_out;  /* input/output: len of data_out
                                                 *   returns ENOSPC if data_out
                                                 *   is too small.
                                                 */
                __aligned_u64   data_in;
                __aligned_u64   data_out;
                __u32           repeat;
                __u32           duration;
        } test;

The field data_size_out could be changed during the system call.
But that only happens at bpf_test_finish(). At the time when
-ERESTARTSYS is returned, no attributes have been changed.

>
> --
>
> From ce360c909ce4f3caf8eb69f2ad5ce0d3eee1515d Mon Sep 17 00:00:00 2001
> Message-Id: <ce360c909ce4f3caf8eb69f2ad5ce0d3eee1515d.1549302207.git.sdf@google.com>
> From: Stanislav Fomichev <sdf@google.com>
> Date: Mon, 4 Feb 2019 09:17:37 -0800
> Subject: [PATCH bpf] bpf/test_run: properly handle signal_pending
>
> Syzbot found out that running BPF_PROG_TEST_RUN with repeat=0xffffffff
> makes process unkillable. Let's move signal_pending out of need_resched
> and properly return -ERESTARTSYS to the userspace.
>
> In the kernel/bpf/verifier.c do_check() we do:
>         if (signal_pending())
>                 ...
>         if (need_resched())
>                 ...
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  net/bpf/test_run.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index fa2644d276ef..a891c60cf248 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -28,12 +28,13 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
>         return ret;
>  }
>
> -static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
> -                       u32 *time)
> +static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
> +                       u32 *retval, u32 *time)
>  {
>         struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
>         enum bpf_cgroup_storage_type stype;
>         u64 time_start, time_spent = 0;
> +       int ret = 0;
>         u32 i;
>
>         for_each_cgroup_storage_type(stype) {
> @@ -50,10 +51,12 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
>                 repeat = 1;
>         time_start = ktime_get_ns();
>         for (i = 0; i < repeat; i++) {
> -               *ret = bpf_test_run_one(prog, ctx, storage);
> +               *retval = bpf_test_run_one(prog, ctx, storage);
> +               if (signal_pending(current)) {
> +                       ret = -ERESTARTSYS;
> +                       break;
> +               }
>                 if (need_resched()) {
> -                       if (signal_pending(current))
> -                               break;
>                         time_spent += ktime_get_ns() - time_start;
>                         cond_resched();
>                         time_start = ktime_get_ns();
> @@ -66,7 +69,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *ret,
>         for_each_cgroup_storage_type(stype)
>                 bpf_cgroup_storage_free(storage[stype]);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int bpf_test_finish(const union bpf_attr *kattr,
>
> >
> > Tested is on upstream commit 4aa9fc2a435abe95a1e8d7f8c7b3d6356514b37a.
> > Config is attached.
> >
> > FTR, generated from the following syzkaller program:
> >
> > r1 = bpf$PROG_LOAD(0x5, &(0x7f0000000080)={0x3, 0x3,
> > &(0x7f0000001fd8)=@framed={{0xffffff85, 0x0, 0x0, 0x0, 0x13, 0x5}},
> > &(0x7f0000000000)='\x00', 0x5, 0x487, &(0x7f000000cf3d)=""/195}, 0x48)
> > bpf$BPF_PROG_TEST_RUN(0xa, &(0x7f0000000200)={r1, 0x0, 0xe, 0x0,
> > &(0x7f0000000100)="8557147d6187677523fea28c88a8", 0x0,
> > 0xfffffffffffffffe}, 0x28)
> >
> >
> > // autogenerated by syzkaller (https://github.com/google/syzkaller)
> > #define _GNU_SOURCE
> > #include <endian.h>
> > #include <stdint.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/syscall.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> >
> > int main(void)
> > {
> >   syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
> >   long res = 0;
> >   *(uint32_t*)0x20000080 = 3;
> >   *(uint32_t*)0x20000084 = 3;
> >   *(uint64_t*)0x20000088 = 0x20001fd8;
> >   *(uint8_t*)0x20001fd8 = 0x85;
> >   *(uint8_t*)0x20001fd9 = 0x44;
> >   *(uint16_t*)0x20001fda = 0;
> >   *(uint32_t*)0x20001fdc = 0x13;
> >   *(uint8_t*)0x20001fe0 = 5;
> >   *(uint8_t*)0x20001fe1 = 0;
> >   *(uint16_t*)0x20001fe2 = 0;
> >   *(uint32_t*)0x20001fe4 = 0;
> >   *(uint8_t*)0x20001fe8 = 0x95;
> >   *(uint8_t*)0x20001fe9 = 0;
> >   *(uint16_t*)0x20001fea = 0;
> >   *(uint32_t*)0x20001fec = 0;
> >   *(uint64_t*)0x20000090 = 0x20000000;
> >   memcpy((void*)0x20000000, "\000", 1);
> >   *(uint32_t*)0x20000098 = 5;
> >   *(uint32_t*)0x2000009c = 0x487;
> >   *(uint64_t*)0x200000a0 = 0x2000cf3d;
> >   *(uint32_t*)0x200000a8 = 0;
> >   *(uint32_t*)0x200000ac = 0;
> >   *(uint8_t*)0x200000b0 = 0;
> >   *(uint8_t*)0x200000b1 = 0;
> >   *(uint8_t*)0x200000b2 = 0;
> >   *(uint8_t*)0x200000b3 = 0;
> >   *(uint8_t*)0x200000b4 = 0;
> >   *(uint8_t*)0x200000b5 = 0;
> >   *(uint8_t*)0x200000b6 = 0;
> >   *(uint8_t*)0x200000b7 = 0;
> >   *(uint8_t*)0x200000b8 = 0;
> >   *(uint8_t*)0x200000b9 = 0;
> >   *(uint8_t*)0x200000ba = 0;
> >   *(uint8_t*)0x200000bb = 0;
> >   *(uint8_t*)0x200000bc = 0;
> >   *(uint8_t*)0x200000bd = 0;
> >   *(uint8_t*)0x200000be = 0;
> >   *(uint8_t*)0x200000bf = 0;
> >   *(uint32_t*)0x200000c0 = 0;
> >   *(uint32_t*)0x200000c4 = 0;
> >   int fd = syscall(__NR_bpf, 5, 0x20000080, 0x48);
> >   *(uint32_t*)0x20000200 = fd;
> >   *(uint32_t*)0x20000204 = 0;
> >   *(uint32_t*)0x20000208 = 0xe;
> >   *(uint32_t*)0x2000020c = 0;
> >   *(uint64_t*)0x20000210 = 0x20000100;
> >   memcpy((void*)0x20000100,
> >          "\x85\x57\x14\x7d\x61\x87\x67\x75\x23\xfe\xa2\x8c\x88\xa8", 14);
> >   *(uint64_t*)0x20000218 = 0;
> >   *(uint32_t*)0x20000220 = 0xfffffffe;
> >   *(uint32_t*)0x20000224 = 0;
> >   syscall(__NR_bpf, 0xa, 0x20000200, 0x28);
> >   return 0;
> > }
>
>
