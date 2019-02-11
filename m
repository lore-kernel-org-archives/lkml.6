Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAF9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926EA222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPba+k+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbfBKPrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:47:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35006 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfBKPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:47:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so5131401pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBZ8wmS5srFcgTYc5C3Sy0EQsf5bbpobNEiqppPAhpY=;
        b=UPba+k+QxDSXAHWgOHSqtNEgEvS1KUz8tFh2uTQSPnh3PQJOsmYqY6y4K3iHOjxKHf
         cgwopRnTGnxw01Y7QTkNCjLVtYNsn37wjpUu36jWC9qrKDsMWFc0VKuizHdErkb/jzmy
         383kI42iR+Z4Q34lMdlGgf2GMJhw6qs0LeJ7YrC46SPSgY3Tnc8TbOg4RiGctTzRllaK
         Hv16Sej7VdQ8OgPhCSmkNDL+12U/3i0pg9yXXGazBuiMttUCFTooMNi9NySE2NA8v6UN
         pjZa2FLT026g3t08HW8rqIz3CpfNGrCuqN/PA4yyp1zRFIrP+lVLGiRpv2fY7XESdIeD
         WVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBZ8wmS5srFcgTYc5C3Sy0EQsf5bbpobNEiqppPAhpY=;
        b=rR8cgfUBwICmTxFg8c+S2CL6caVtjsEeLkE+V7Qz6JSBekqhYAvP0b3jQy8URNWfdV
         wo9YSzGy4Rt6wLJcz/ouz9mxymG8LC85mgIQ/p0yj+GLMgG38+gO1x69eONIxrL9meLM
         jeE6RQlDsUlljDGaS8ksYd8w4gczAVf3/LF8sWkbHnK7c5vb5JdgXvy84QhrDGkhcgkL
         ZvQBExbWcMrHK7mwzcYI0OzMVW5/GDLi0AM7nuxDoNhpIWppqT46IO+qPxAjyFwlARzx
         1TvTuyHmMwCY2pXfVMeaMpkkwUSlP+VD6drd12vFZglQiy9lZaMo099ewsRQDRzAssL2
         Pazg==
X-Gm-Message-State: AHQUAuZTSJ8nLTxgoVWsjbeAgk79VYvSDDkgLV9T01Lfq6Y4Bzex4q/Y
        Q985hpwGhpdltoaMLtaJaiIFvIKj4IUmrttHlbWFhg==
X-Google-Smtp-Source: AHgI3IYO/I+emG2hCaNAo0q2p2ln6X81grX0lWg1PQSOLYZY6dYksyp2d8fkbdsnNDDY3dNpW5BKzZaWuS/fm3PT+mA=
X-Received: by 2002:a62:6047:: with SMTP id u68mr36814181pfb.239.1549900036827;
 Mon, 11 Feb 2019 07:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20190209044128.3290-1-cai@lca.pw>
In-Reply-To: <20190209044128.3290-1-cai@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 11 Feb 2019 16:47:04 +0100
Message-ID: <CAAeHK+wKeqt2xvZfF5X4Z0dxLJqrdvDu894tFpGR172z0iVGRw@mail.gmail.com>
Subject: Re: [PATCH] slub: fix SLAB_CONSISTENCY_CHECKS + KASAN_SW_TAGS
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

On Sat, Feb 9, 2019 at 5:41 AM Qian Cai <cai@lca.pw> wrote:
>
> Enabling SLUB_DEBUG's SLAB_CONSISTENCY_CHECKS with KASAN_SW_TAGS
> triggers endless false positives during boot below due to
> check_valid_pointer() checks tagged pointers which have no addresses
> that is valid within slab pages.
>
> [    0.000000] BUG radix_tree_node (Tainted: G    B            ): Freelist Pointer check fails
> [    0.000000] -----------------------------------------------------------------------------
> [    0.000000]
> [    0.000000] INFO: Slab 0x(____ptrval____) objects=69 used=69 fp=0x          (null) flags=0x7ffffffc000200
> [    0.000000] INFO: Object 0x(____ptrval____) @offset=15060037153926966016 fp=0x(____ptrval____)
> [    0.000000]
> [    0.000000] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 18 6b 06 00 08 80 ff d0  .........k......
> [    0.000000] Object (____ptrval____): 18 6b 06 00 08 80 ff d0 00 00 00 00 00 00 00 00  .k..............
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [    0.000000] Redzone (____ptrval____): bb bb bb bb bb bb bb bb                          ........
> [    0.000000] Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B             5.0.0-rc5+ #18
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x0/0x450
> [    0.000000]  show_stack+0x20/0x2c
> [    0.000000]  __dump_stack+0x20/0x28
> [    0.000000]  dump_stack+0xa0/0xfc
> [    0.000000]  print_trailer+0x1bc/0x1d0
> [    0.000000]  object_err+0x40/0x50
> [    0.000000]  alloc_debug_processing+0xf0/0x19c
> [    0.000000]  ___slab_alloc+0x554/0x704
> [    0.000000]  kmem_cache_alloc+0x2f8/0x440
> [    0.000000]  radix_tree_node_alloc+0x90/0x2fc
> [    0.000000]  idr_get_free+0x1e8/0x6d0
> [    0.000000]  idr_alloc_u32+0x11c/0x2a4
> [    0.000000]  idr_alloc+0x74/0xe0
> [    0.000000]  worker_pool_assign_id+0x5c/0xbc
> [    0.000000]  workqueue_init_early+0x49c/0xd50
> [    0.000000]  start_kernel+0x52c/0xac4
> [    0.000000] FIX radix_tree_node: Marking all objects used
> [    0.000000]
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

> ---
>  mm/slub.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 1e3d0ec4e200..075ebc529788 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -507,6 +507,7 @@ static inline int check_valid_pointer(struct kmem_cache *s,
>                 return 1;
>
>         base = page_address(page);
> +       object = kasan_reset_tag(object);
>         object = restore_red_left(s, object);
>         if (object < base || object >= base + page->objects * s->size ||
>                 (object - base) % s->size) {
> --
> 2.17.2 (Apple Git-113)
>
