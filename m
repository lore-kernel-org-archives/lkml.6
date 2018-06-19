Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83988C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317AC204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obc7aUMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317AC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757306AbeFSNbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:31:10 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33137 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeFSNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:31:07 -0400
Received: by mail-pf0-f176.google.com with SMTP id b17-v6so9954414pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AlaE0cDoxiS1M0trZN7M0/SQHhDIIle46DuHrhzcqa8=;
        b=obc7aUMVFSIr3gHQL16UbAH/02gWqs56B6vxZxmLxtTRFo6dHu1IZjU5MsA/eY7XJb
         qe4aVvccX0NGVvWcxnY/7aAbziw1JH4ysIGLkKsm4PHqnT2odTlH4DCZOrsHsULlSw04
         8zU3OzETylc8kD/dfl5UDTvN1KhR4RnV7vpFwhuKG+6ZSJtzb/Ant1toJLwUOBIBdLvr
         uN4ivWrNstUI1bDrYmIr1z+zM918t+1Xbdjg5d+bdM6OCx4EkF6+hvYMeNgUEBzN2F8k
         GWRdPUZthpZQeBSz1zY90Xs+ArQ+uykmP3iFVgZYHM16ELrOKCtAIh0WBWhyGSW6I7gS
         e/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AlaE0cDoxiS1M0trZN7M0/SQHhDIIle46DuHrhzcqa8=;
        b=X0ELvaZmW15TYozmOiDSBsnNUrdrou74CAEjnYmYjs5uDCzCH10UZnkmqOKSND/jFT
         NiSg3zTqIIewJH7hZMIa9fLOaTyD7uBeHjp3jTXbDyd3MaERT/I8Pidi7Z2/4L5Z0ouQ
         /3wO1sOghUFfTqY9RvCVsOVNXc4yUpyNIpIBFHdy3r64xKRAF5Qmr0w57AuK7QcMrhPH
         1gF6TfXrH5j6JaLiUUON5zO1/mieMGN6adKdrQ2fj2PvKd7dRynMz6CNDzue62OC46B6
         KQReFiVquq5SwLBZ+Kg5lbnAlrox1j5pqdLhBz/crkB4Az6N/dMR1gTcF+68rQSSdGzp
         HJlg==
X-Gm-Message-State: APt69E2C9XQIDUPOC/29VOdWeIr8s+8EiyviVNoBhDjxbXbSM9/lvNVC
        L6r/fRjEpyD/krHgtn2h6seBmUP9taeML4l0MQljgA==
X-Google-Smtp-Source: ADUXVKInW9kt/eMGYSVi5n8C3IcjVE48UjlKoepWA1M2Fe8vG3pqTQHRZ7BF4Sea2lZUcgEsixcMuPVkC7bs6j7e5BA=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr18368962pfe.114.1529415066435;
 Tue, 19 Jun 2018 06:31:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 06:30:45
 -0700 (PDT)
In-Reply-To: <CAHmME9r=+91YtujYqsBwf52VkCdPMD8VXJED_AsR42H5h9--mA@mail.gmail.com>
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
 <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
 <CALvZod5ZrxjZjJjAV_iH6hgq9pY2QEuFjNi+qvPSzob5Vighjg@mail.gmail.com> <CAHmME9r=+91YtujYqsBwf52VkCdPMD8VXJED_AsR42H5h9--mA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 15:30:45 +0200
Message-ID: <CACT4Y+b+9HK8Ti_iXA1DcHDeTR+Cj-xaQ+kQpvc7xPNafk5tkw@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:25 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, Jun 19, 2018 at 7:06 AM Shakeel Butt <shakeelb@google.com> wrote:
>> Currently refcnt in your
>> code can underflow, through it does not seem like the selftest will
>> cause the underflow but still you should fix it.
>
> Indeed, and if this happened this would be a bug in the caller, not
> the ratelimiter itself, kind of like lock imbalances; however it's
> easy to mitigate this by just replacing that atomic64_dec_return with
> atomic64_dec_if_positive, so I'll do that. Thanks for the suggestion.

Since I already looked at the code, if init and uninit can be called
concurrently, I think there is a prominent race condition between init
and uninit: a concurrent uninit can run concurrnetly with the next
init and this will totally mess things up.

>> From high level your code seems fine. Does the issue occur on first
>> try of selftest? Basically I wanted to ask if kmem_cache_destroy of
>> your entry_cache was ever executed
>
> Yes, it is.
>
>> and have you tried to run this
>> selftest multiple time while the system was up.
>
> Interesting, it crashes on the second run of it, when executing
> `KMEM_CACHE(ratelimiter_entry, 0)`. (OOPS is below.)
>
>> As Dmitry already asked, are you using SLAB or SLUB?
>
> SLUB.
>
>> Sorry, I can not really give a definitive answer.
>
> Alright, we'll poke it from both ends, then.
>
> Crash on second run:
> [    1.648240] general protection fault: 0000 [#1] PREEMPT SMP
> DEBUG_PAGEALLOC KASAN
> [    1.648240] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.2 #51
> [    1.648240] RIP: 0010:__lock_acquire+0x9a9/0x3430
> [    1.648240] RSP: 0000:ffff8800003b76a0 EFLAGS: 00010006
> [    1.648240] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    1.648240] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000001
> [    1.648240] RBP: ffff8800003a8000 R08: 0000000000000001 R09: 0000000000000000
> [    1.648240] R10: 0000000000000001 R11: ffffffff828c69e3 R12: 0000000000000001
> [    1.648240] R13: 0000000000000018 R14: 0000000000000000 R15: ffff8800003a8000
> [    1.648240] FS:  0000000000000000(0000) GS:ffff880036400000(0000)
> knlGS:000000000
> [    1.648240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.648240] CR2: 0000000000000000 CR3: 0000000002220001 CR4: 00000000001606b0
> [    1.660020] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.660020] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.660020] Call Trace:
> [    1.660020]  ? _raw_spin_unlock_irqrestore+0x4a/0x90
> [    1.660020]  ? debug_check_no_locks_held+0xb0/0xb0
> [    1.660020]  ? depot_save_stack.cold.2+0x1e/0x1e
> [    1.660020]  ? handle_null_ptr_deref+0x178/0x1f0
> [    1.660020]  ? depot_save_stack.cold.2+0x1e/0x1e
> [    1.660020]  ? _raw_spin_unlock+0x32/0x70
> [    1.660020]  lock_acquire+0xf4/0x240
> [    1.660020]  ? __slab_free.isra.11+0x1db/0x770
> [    1.660020]  ? __slab_free.isra.11+0x1db/0x770
> [    1.660020]  _raw_spin_lock_irqsave+0x4b/0x70
> [    1.660020]  ? __slab_free.isra.11+0x1db/0x770
> [    1.660020]  __slab_free.isra.11+0x1db/0x770
> [    1.660020]  ? __free_pages_ok+0x49a/0xd10
> [    1.660020]  ? mark_held_locks+0xdf/0x1b0
> [    1.660020]  ? _raw_spin_unlock_irqrestore+0x61/0x90
> [    1.660020]  ? qlist_free_all+0x58/0x1c0
> [    1.660020]  qlist_free_all+0x70/0x1c0
> [    1.660020]  ? trace_hardirqs_on_caller+0x3d0/0x630
> [    1.660020]  quarantine_reduce+0x221/0x310
> [    1.660020]  kasan_kmalloc+0x95/0xc0
> [    1.660020]  kmem_cache_alloc+0x167/0x2e0
> [    1.660020]  ? do_one_initcall+0x104/0x232
> [    1.660020]  create_object+0xa7/0xa70
> [    1.660020]  ? kmemleak_disable+0x90/0x90
> [    1.660020]  ? quarantine_reduce+0x207/0x310
> [    1.660020]  ? fs_reclaim_acquire.part.15+0x30/0x30
> [    1.660020]  kmem_cache_alloc_node+0x209/0x340
> [    1.660020]  __kmem_cache_create+0xe6/0x5c0
> [    1.660020]  kmem_cache_create_usercopy+0x1ef/0x380
> [    1.660020]  ? length_mt_init+0x11/0x11
> [    1.660020]  kmem_cache_create+0xd/0x10
> [    1.660020]  ratelimiter_init+0x4a/0x1e0
> [    1.660020]  ratelimiter_selftest+0x13/0x9ec
> [    1.660020]  ? length_mt_init+0x11/0x11
> [    1.660020]  mod_init+0xb/0xa5
> [    1.660020]  do_one_initcall+0x104/0x232
> [    1.660020]  ? start_kernel+0x62c/0x62c
> [    1.660020]  ? up_write+0x78/0x220
> [    1.660020]  ? up_read+0x130/0x130
> [    1.660020]  ? kasan_unpoison_shadow+0x30/0x40
> [    1.660020]  kernel_init_freeable+0x3e8/0x48c
> [    1.660020]  ? rest_init+0x2bf/0x2bf
> [    1.660020]  kernel_init+0x7/0x121
> [    1.660020]  ? rest_init+0x2bf/0x2bf
> [    1.660020]  ret_from_fork+0x24/0x30
> [    1.660020] Code: 81 c4 40 01 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f
> c3 4d 85 ed 0f
> [    1.660020] RIP: __lock_acquire+0x9a9/0x3430 RSP: ffff8800003b76a0
> [    1.660020] ---[ end trace daba3b506c5594e5 ]---
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CAHmME9r%3D%2B91YtujYqsBwf52VkCdPMD8VXJED_AsR42H5h9--mA%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
