Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4CBC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAAE222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvdD+8Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbfBMKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:31:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41172 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfBMKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:31:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id k15so960944pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8r5W3HAqd4GKzo/gRuthqEG3molhLNHlb9/GIutEIY=;
        b=MvdD+8VmIBcI4PxNx8ZPRKQZrz5mZArnmva91bI9068MZhVPCsPHiZkHLHG2047i3v
         YOczJuzrS8UlMglmOLlkDV3kLG2/figJvWgnq+6EaLub9l4UCDVWTfj9zt2jpPYcM+kG
         8VSL+LTSPArgUbdL2NhvqYgBbsxj2if3SE2zfYkbwCJKDnetNHRWOhKPdBFcrOQHsIUt
         TBdt9HcIOdEBUL+S1I45sZVUSAWZ3EDye6OkgUg3J3tgwgqClpOhuAvoqTXrXE2Olt8N
         RpkBI2GNB5De5TOko1blseiVbsrNytgD+fyB4A4pZeBfbHOYhDrCw1o6+Eose9z2ozv1
         w9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8r5W3HAqd4GKzo/gRuthqEG3molhLNHlb9/GIutEIY=;
        b=ldPaAA/cmM0n6BTvpj0+fJikomebowzdicC5jZJbhpVny1aRA1qMeLRKOpPEYl7PcT
         /9xu81SF4YLCFYMDuRWHSx0UDPFyoSKnQEFWJD2sHEtJ9NueFwbSiKVnPm7L3QMjwYco
         AeMfz075GYOeT9Y13jjxnt13TLpBZew4qjHIDja/orlhDKMdg3R8VbaGPS/orBtciR8W
         c2z7vBVZdS3rU+yY8FPUiVZb1wKFUf3aYmLGkTEHwovdxOkDJX08RF0eYMyiPKLR+eXW
         sqb+WBdtyWBdp1phVzLejHCo9rCvRo8q793ghusmQ+FWwemUQMmz/PAcNBotCCd154YB
         /qaw==
X-Gm-Message-State: AHQUAubPpfUG/CICqMzPYVWL3qL0K4rcu7vfDiJBVowrBT4hx0r8GWfA
        YMcy9yQDhFFux7q+oTcZZdGgPovs1URpqeCgA/VnDpVVo0U=
X-Google-Smtp-Source: AHgI3IbjizM1m1lUCGjp7gt8xkWeV+CNl7FBkMPIDRzrQqjnZljOs/zZGhyLEK4CTlt1Bvt+M1VC0GvSz3kQQKhXSUs=
X-Received: by 2002:a17:902:8304:: with SMTP id bd4mr8737048plb.329.1550053878971;
 Wed, 13 Feb 2019 02:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20190213020550.82453-1-cai@lca.pw>
In-Reply-To: <20190213020550.82453-1-cai@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 13 Feb 2019 11:31:07 +0100
Message-ID: <CAAeHK+w-EWDivYTNiUAeSUVZVGOpUyxbbcC8_nMM1=CcpsJ9Ug@mail.gmail.com>
Subject: Re: [PATCH] slub: untag object before slab end
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:06 AM Qian Cai <cai@lca.pw> wrote:
>
> get_freepointer() could return NULL if there is no more free objects in
> the slab. However, it could return a tagged pointer (like
> 0x2200000000000000) with KASAN_SW_TAGS which would escape the NULL
> object checking in check_valid_pointer() and trigger errors below, so
> untag the object before checking for a NULL object there.

I think this solution is just masking the issue. get_freepointer()
shouldn't return tagged NULLs. Apparently when we save a freelist
pointer, the object where the pointer gets written is tagged
differently, than this same object when the pointer gets read. I found
one case where this happens (the last patch out my 5 patch series),
but apparently there are more.

>
> [   35.797667] BUG kmalloc-256 (Not tainted): Freepointer corrupt
> [   35.803584] -----------------------------------------------------------------------------
> [   35.803584]
> [   35.813368] Disabling lock debugging due to kernel taint
> [   35.818766] INFO: Allocated in build_sched_domains+0x28c/0x495c age=92 cpu=0 pid=1
> [   35.826443]  __kmalloc_node+0x4ac/0x508
> [   35.830343]  build_sched_domains+0x28c/0x495c
> [   35.834764]  sched_init_domains+0x184/0x1d8
> [   35.839012]  sched_init_smp+0x38/0xd4
> [   35.842732]  kernel_init_freeable+0x67c/0x1104
> [   35.847243]  kernel_init+0x18/0x2a4
> [   35.850790]  ret_from_fork+0x10/0x18
> [   35.854423] INFO: Freed in destroy_sched_domain+0xa0/0xcc age=11 cpu=0 pid=1
> [   35.861569]  destroy_sched_domain+0xa0/0xcc
> [   35.865814]  cpu_attach_domain+0x304/0xb34
> [   35.869971]  build_sched_domains+0x4654/0x495c
> [   35.874480]  sched_init_domains+0x184/0x1d8
> [   35.878724]  sched_init_smp+0x38/0xd4
> [   35.882443]  kernel_init_freeable+0x67c/0x1104
> [   35.886953]  kernel_init+0x18/0x2a4
> [   35.890495]  ret_from_fork+0x10/0x18
> [   35.894128] INFO: Slab 0x(____ptrval____) objects=85 used=0 fp=0x(____ptrval____) flags=0x7ffffffc000200
> [   35.903733] INFO: Object 0x(____ptrval____) @offset=38528 fp=0x(____ptrval____)
> [   35.903733]
> [   35.912637] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.922155] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.931672] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.941190] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.950707] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.960224] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.969741] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.979258] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [   35.988776] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   35.998206] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.007636] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.017065] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.026494] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.035923] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.045353] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.054783] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.064212] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.073642] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.083071] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.092501] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.101930] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.111359] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.120788] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   36.130218] Object (____ptrval____): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
> [   36.139647] Redzone (____ptrval____): bb bb bb bb bb bb bb bb                          ........
> [   36.148462] Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
> [   36.157979] Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
> [   36.167496] Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
> [   36.177021] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.0.0-rc6+ #41
> [   36.184854] Call trace:
> [   36.187328]  dump_backtrace+0x0/0x450
> [   36.191032]  show_stack+0x20/0x2c
> [   36.194385]  __dump_stack+0x20/0x28
> [   36.197911]  dump_stack+0xa0/0xfc
> [   36.201265]  print_trailer+0x1a8/0x1bc
> [   36.205057]  object_err+0x40/0x50
> [   36.208408]  check_object+0x214/0x2b8
> [   36.212111]  __free_slab+0x9c/0x31c
> [   36.215638]  discard_slab+0x78/0xa8
> [   36.219165]  kfree+0x918/0x980
> [   36.222259]  destroy_sched_domain+0xa0/0xcc
> [   36.226489]  cpu_attach_domain+0x304/0xb34
> [   36.230631]  build_sched_domains+0x4654/0x495c
> [   36.235125]  sched_init_domains+0x184/0x1d8
> [   36.239357]  sched_init_smp+0x38/0xd4
> [   36.243060]  kernel_init_freeable+0x67c/0x1104
> [   36.247555]  kernel_init+0x18/0x2a4
> [   36.251083]  ret_from_fork+0x10/0x18
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> Depends on slub-fix-slab_consistency_checks-kasan_sw_tags.patch.
>
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 4a61959e1887..2fd1cf39914c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -503,11 +503,11 @@ static inline int check_valid_pointer(struct kmem_cache *s,
>  {
>         void *base;
>
> +       object = kasan_reset_tag(object);
>         if (!object)
>                 return 1;
>
>         base = page_address(page);
> -       object = kasan_reset_tag(object);
>         object = restore_red_left(s, object);
>         if (object < base || object >= base + page->objects * s->size ||
>                 (object - base) % s->size) {
> --
> 2.17.2 (Apple Git-113)
>
