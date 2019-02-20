Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8782C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D3121848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjRfl25Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfBTMvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:51:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43525 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBTMvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:51:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id m10so2528423plt.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOha2KzOEG9V/5MhHyFHoO8NfVaaMb6gXtQiy42AI/0=;
        b=GjRfl25YkgcRLEXe2itWYLfzPzTxs08hcR2Qmw44KjntlvEoAwIwp81DJAniCTc2H4
         SGaGwFBPZNYJumyF7PNb77CtPzGyzc7ighyw9svK/z6zTlU7mQt0+34TIYmnlA+Tz7pe
         R4GUI6A65GhV4ClBuye6S71XRYq3VElnJdPWIc4R5Lfelous94NShkjsmESscPBGJGFl
         tUJqn4WvEGsOnxn/vXnd+YRQYlvqBDzU9eU/WDrhg9SxmPv+3wOIW54edCZHxZfC7eTN
         iViF5SvBsDRbwyPCpD0mw6ArwPnvuOg0zVyO7pwKwWlGfcvsppj9ljS2Ga/6e87iwG3b
         D5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOha2KzOEG9V/5MhHyFHoO8NfVaaMb6gXtQiy42AI/0=;
        b=gxBzI6i7bK8HOaz8X7h0Y/w/CfyCNA5AOFkem32yO3XY0jh4XPmEBeE9Cg9kbOI6Y/
         Sl+lhqDO1tc6h88XNLzyzq1xD8h2Ib59DIWksZ+1D5Q76zRiYstVpRKxWmYtzpJhMQKg
         VdMZKHALu6qIwOsGsP2zg2B4cnshSGBBMTYZRgc3Gr5zTRpv75UgyAckMZo3W96N2fbT
         TrL1+i6G4OplzdvBwXVUbqwYODL8gasNQ3FpRqEp4FnGYpv4o4KhtaYm97Gnxl8giguI
         wFsDryRDOWvyyInSOjNgmdpgLCXa4ZUgY1ttNC0d31UWfE6uVYoRa31UyDltvCwbUPS4
         +X5g==
X-Gm-Message-State: AHQUAuY5GdaKTRJb8oRGy43Eju0PqZY6up0qo+ab2eaVOdqE1KWNSv/J
        kcdmdmvDlTBGO1OAIBQ2I387p2Hl89xQ41a6ZpgLNg==
X-Google-Smtp-Source: AHgI3IbgBiZcT1uJ/i5w0+lv8WT7ZfgAXnH3sWorFq2ayrFGES6yl3f3n35c0/JaXpKBMpIC+JiNPz3lMp/VQioBaho=
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr36570627pld.236.1550667106551;
 Wed, 20 Feb 2019 04:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20190220020251.82039-1-cai@lca.pw>
In-Reply-To: <20190220020251.82039-1-cai@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 20 Feb 2019 13:51:35 +0100
Message-ID: <CAAeHK+wp=UtzoNzcnmnef_uMpEMSeXBgKYOJz7V_tZXs-RK+kQ@mail.gmail.com>
Subject: Re: [PATCH] slub: fix a crash with SLUB_DEBUG + KASAN_SW_TAGS
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

On Wed, Feb 20, 2019 at 3:03 AM Qian Cai <cai@lca.pw> wrote:
>
> In process_slab(), "p = get_freepointer()" could return a tagged
> pointer, but "addr = page_address()" always return a native pointer. As
> the result, slab_index() is messed up here,
>
> return (p - addr) / s->size;
>
> All other callers of slab_index() have the same situation where "addr"
> is from page_address(), so just need to untag "p".
>
>  # cat /sys/kernel/slab/hugetlbfs_inode_cache/alloc_calls
>
> [18868.759419] Unable to handle kernel paging request at virtual address 2bff808aa4856d48
> [18868.767341] Mem abort info:
> [18868.770133]   ESR = 0x96000007
> [18868.773187]   Exception class = DABT (current EL), IL = 32 bits
> [18868.779103]   SET = 0, FnV = 0
> [18868.782155]   EA = 0, S1PTW = 0
> [18868.785292] Data abort info:
> [18868.788170]   ISV = 0, ISS = 0x00000007
> [18868.792003]   CM = 0, WnR = 0
> [18868.794973] swapper pgtable: 64k pages, 48-bit VAs, pgdp = 0000000002498338
> [18868.801932] [2bff808aa4856d48] pgd=00000097fcfd0003, pud=00000097fcfd0003, pmd=00000097fca30003, pte=00e8008b24850712
> [18868.812597] Internal error: Oops: 96000007 [#1] SMP
> [18868.835088] CPU: 3 PID: 79210 Comm: read_all Tainted: G             L    5.0.0-rc7+ #84
> [18868.843087] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.0.6 07/10/2018
> [18868.852915] pstate: 00400089 (nzcv daIf +PAN -UAO)
> [18868.857710] pc : get_map+0x78/0xec
> [18868.861109] lr : get_map+0xa0/0xec
> [18868.864505] sp : aeff808989e3f8e0
> [18868.867816] x29: aeff808989e3f940 x28: ffff800826200000
> [18868.873128] x27: ffff100012d47000 x26: 9700000000002500
> [18868.878440] x25: 0000000000000001 x24: 52ff8008200131f8
> [18868.883753] x23: 52ff8008200130a0 x22: 52ff800820013098
> [18868.889065] x21: ffff800826200000 x20: ffff100013172ba0
> [18868.894377] x19: 2bff808a8971bc00 x18: ffff1000148f5538
> [18868.899690] x17: 000000000000001b x16: 00000000000000ff
> [18868.905002] x15: ffff1000148f5000 x14: 00000000000000d2
> [18868.910314] x13: 0000000000000001 x12: 0000000000000000
> [18868.915626] x11: 0000000020000002 x10: 2bff808aa4856d48
> [18868.920937] x9 : 0000020000000000 x8 : 68ff80082620ebb0
> [18868.926249] x7 : 0000000000000000 x6 : ffff1000105da1dc
> [18868.931561] x5 : 0000000000000000 x4 : 0000000000000000
> [18868.936872] x3 : 0000000000000010 x2 : 2bff808a8971bc00
> [18868.942184] x1 : ffff7fe002098800 x0 : ffff80082620ceb0
> [18868.947499] Process read_all (pid: 79210, stack limit = 0x00000000f65b9361)
> [18868.954454] Call trace:
> [18868.956899]  get_map+0x78/0xec
> [18868.959952]  process_slab+0x7c/0x47c
> [18868.963526]  list_locations+0xb0/0x3c8
> [18868.967273]  alloc_calls_show+0x34/0x40
> [18868.971107]  slab_attr_show+0x34/0x48
> [18868.974768]  sysfs_kf_seq_show+0x2e4/0x570
> [18868.978864]  kernfs_seq_show+0x12c/0x1a0
> [18868.982786]  seq_read+0x48c/0xf84
> [18868.986099]  kernfs_fop_read+0xd4/0x448
> [18868.989935]  __vfs_read+0x94/0x5d4
> [18868.993334]  vfs_read+0xcc/0x194
> [18868.996560]  ksys_read+0x6c/0xe8
> [18868.999786]  __arm64_sys_read+0x68/0xb0
> [18869.003622]  el0_svc_handler+0x230/0x3bc
> [18869.007544]  el0_svc+0x8/0xc
> [18869.010428] Code: d3467d2a 9ac92329 8b0a0e6a f9800151 (c85f7d4b)
> [18869.016742] ---[ end trace a383a9a44ff13176 ]---
> [18869.021356] Kernel panic - not syncing: Fatal exception
> [18869.026705] SMP: stopping secondary CPUs
> [18870.254279] SMP: failed to stop secondary CPUs 1-7,32,40,127
> [18870.259942] Kernel Offset: disabled
> [18870.263434] CPU features: 0x002,20000c18
> [18870.267358] Memory Limit: none
> [18870.270725] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 4a61959e1887..289c22f1b0c4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -311,7 +311,7 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
>  /* Determine object index from a given position */
>  static inline unsigned int slab_index(void *p, struct kmem_cache *s, void *addr)
>  {
> -       return (p - addr) / s->size;
> +       return (kasan_reset_tag(p) - addr) / s->size;
>  }
>
>  static inline unsigned int order_objects(unsigned int order, unsigned int size)
> --
> 2.17.2 (Apple Git-113)
>
