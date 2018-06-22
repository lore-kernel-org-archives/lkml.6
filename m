Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D67C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0123F9F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu4NQT8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE0123F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeFVJnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:43:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42580 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeFVJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:43:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id c10-v6so2739978pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VIbHO1n8Ck+tsnNQ3bM9bs9ZRj12A8qeyH4fAyNytms=;
        b=iu4NQT8M0ElCkvvy6iQzRe+gjeGqyzO/i1BEnOQ5VMib7MV7r0zXoieneaI3GRPR39
         o+To/bio9q9iXM6fb55mYnH+BPlM6K/9qHJnbnYEocrJktLCFofGY2Z/fB4bmi6NDpgD
         Yj58gh8vtCuWGS0TmMmN4ll/tGRKaIdZWuXdoYLEigLBeOq/5cDeDhZSMJDfmyOYCMe3
         7VISftUympM5Dzsh7DBmT4zjjAbS6DDLSj17/Vpi+Yf0/qrIPSJMzx09d+qDgjpk7gRJ
         fK549tATIBJUq0TH3UMrzgshE5QwFmL3U49DXm+Q1ecdrvibS/bS3QowlVH5B2sz4vL/
         E18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VIbHO1n8Ck+tsnNQ3bM9bs9ZRj12A8qeyH4fAyNytms=;
        b=Bl2r2Ekql1icbPVQWuGBGBKp98qSMjo4No4be4YheY7SZN3bWeGmyNIerB997nJPlJ
         ACeCiECoCeDxiinhOd857oayNBaQe33VhP6ijHqt8SoPVE7xQ4EIyABCAyBjZLR2Yf8h
         vIFG6wJauK0SiNnKZxlSyUId14v4oehkFso2F93QvmUhH8xMTAUfXAPNAeWSMw0Tw9GM
         0sZVDNtuj3ss4YRSixTbX5OHMlFsZzl56tJLgnzbU+yNmlZdflokIp6WENIvvX/SRnFH
         VIVGrZZYVsln8DFI6CEU1abdaySC76V41gLeZcYGZy/MBMBQnP/qdE/u/Sn+lWaYW6t2
         MEuQ==
X-Gm-Message-State: APt69E2R86/coFHGf0GuHqKeTHIX/q8wiGsBObXXbN+s4xX6gT0fgSjo
        HG5+34Ce0WRASVfIEhRcwKYvnYdvg7StLLsP1tn/zQ==
X-Google-Smtp-Source: ADUXVKIw4iuzhZWgPyHTF4JFIsIFpmO65woLHBv8b6SwfOuyS6YpwdPd55BzEm58bvOsEy8Zadh84lZqXvZN5pYYxdw=
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr754291pgs.84.1529660584364;
 Fri, 22 Jun 2018 02:43:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Fri, 22 Jun 2018 02:42:43
 -0700 (PDT)
In-Reply-To: <1529659626-12660-1-git-send-email-thunder.leizhen@huawei.com>
References: <1529659626-12660-1-git-send-email-thunder.leizhen@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Jun 2018 11:42:43 +0200
Message-ID: <CACT4Y+Y3cLwVroPri8kKE+wG+YCMOynfzJcL_CjXRXn1omRF_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] kasan: fix shadow_size calculation error in kasan_module_alloc
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:27 AM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> There is a special case that the size is "(N << KASAN_SHADOW_SCALE_SHIFT)
> Pages plus X", the value of X is [1, KASAN_SHADOW_SCALE_SIZE-1]. The
> operation "size >> KASAN_SHADOW_SCALE_SHIFT" will drop X, and the roundup
> operation can not retrieve the missed one page. For example: size=0x28006,
> PAGE_SIZE=0x1000, KASAN_SHADOW_SCALE_SHIFT=3, we will get
> shadow_size=0x5000, but actually we need 6 pages.
>
> shadow_size = round_up(size >> KASAN_SHADOW_SCALE_SHIFT, PAGE_SIZE);
>
> This can lead kernel to be crashed, when kasan is enabled and the value
> of mod->core_layout.size or mod->init_layout.size is like above. Because
> the shadow memory of X has not been allocated and mapped.
>
> move_module:
> ptr = module_alloc(mod->core_layout.size);
> ...
> memset(ptr, 0, mod->core_layout.size);          //crashed
>
> Unable to handle kernel paging request at virtual address ffff0fffff97b000
> ......
> Call trace:
> [<ffff8000004694d4>] __asan_storeN+0x174/0x1a8
> [<ffff800000469844>] memset+0x24/0x48
> [<ffff80000025cf28>] layout_and_allocate+0xcd8/0x1800
> [<ffff80000025dbe0>] load_module+0x190/0x23e8
> [<ffff8000002601e8>] SyS_finit_module+0x148/0x180
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  mm/kasan/kasan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 81a2f45..f5ac4ac 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -427,12 +427,13 @@ void kasan_kfree_large(const void *ptr)
>  int kasan_module_alloc(void *addr, size_t size)
>  {
>         void *ret;
> +       size_t scaled_size;
>         size_t shadow_size;
>         unsigned long shadow_start;
>
>         shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
> -       shadow_size = round_up(size >> KASAN_SHADOW_SCALE_SHIFT,
> -                       PAGE_SIZE);
> +       scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
> +       shadow_size = round_up(scaled_size, PAGE_SIZE);
>
>         if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
>                 return -EINVAL;


Hi Zhen,

Yes, this is a bug. Thanks for fixing it!

Reviewed-by: Dmitriy Vyukov <dvyukov@google.com>
