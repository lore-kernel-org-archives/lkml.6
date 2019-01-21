Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE6C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7A020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FspUHSpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfAUJYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:24:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44915 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAUJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:24:14 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so15810337iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OL2n5Xw7y8Ptr0DjBBqoBVn5ATX7sgHlxy4qXLn+gjs=;
        b=FspUHSpgPEzwu1muclAAi7XviMZms13m3cDHuKxYXJ1txn+rRvpIutGfSdYUg7uztB
         xf0plqq0jVHk+Pma9VT7cern26/a8LJVbBatAa3FYL3i5PBIOHtm56/rU9RGR2aoG+aS
         qBasWBA/Rf93rMpK4ZyhYU2beT1DCU5/OgeFih4+RDeMdtTAkWX5eF2E5Fg9/bp2jwy5
         l02kCcVUVVtUEnM85o34JZc0TVb8sMXotrDgNecM1ButMpxJXVUpMt8ZVp2txQ+dq65o
         X6EDHO4CRm8RBQwadx4ejWA7kEK1d/UA6v3wT6M+YKVf2K1mmZn6ypDjll8rRH1v6BaZ
         DqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OL2n5Xw7y8Ptr0DjBBqoBVn5ATX7sgHlxy4qXLn+gjs=;
        b=PFpJsB826Wc6zHRJNktCgBxfm2FAp2Serh6avoeji+MNnFDh3yt9khfmuosz3BA7+N
         HSu7Vxci8kNzDokJAP1Wfp1vTPp+eheRlNC2Mvk3F2VMGlRaw+BKNINXWcRiXyMjJGpi
         IfKaHP7eHSknm9Jq4cZFlJW+2BqC2vOWa7GaSeIfdK9OpEDcgNfxbU4/q8K0eKMTSu+s
         YK/VCyzrn/n8N6rktL8+vrA0ScPfHuqKzV3Jqy6kk4Zbj/9h3Fh33iq+vZHAe8x/oXv3
         CB0/Df08I1OBM0/Ieklnlz1j+Wd5xLMW++eHFYSq/I7Mh7lF6zdZrmwT+SVF3vtMSxVp
         45QQ==
X-Gm-Message-State: AJcUukcOJSfM1BuGBUUiDUc+2BKMYbPJVZC6rk4Be73thZ6yLY1DoZdn
        3CE3hhfFi0A7j47EZhR91ioqXhbPAlGs9l2EbdRHTQ==
X-Google-Smtp-Source: ALg8bN6493yX5n0Sowdnesa/q/XbYafkPUw9euh9B+RBhmtez05eHYlS1J4VDNJ67eWt65/+x40iKxqMYkrOW49HbY0=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr16118491iom.11.1548062652245;
 Mon, 21 Jan 2019 01:24:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547289808.git.christophe.leroy@c-s.fr> <935f9f83393affb5d55323b126468ecb90373b88.1547289808.git.christophe.leroy@c-s.fr>
 <e4b343fa-702b-294f-7741-bb85ed877cdf@virtuozzo.com> <8d433501-a5a7-8e3b-03f7-ccdd0f8622e1@c-s.fr>
 <CACT4Y+Z+UbN1rjHr3T5rgHpCJUknupPvEPw0SHs1-qjWBDhm3Q@mail.gmail.com> <d2f85bee-c551-ec9d-1a13-6d3364788cc1@c-s.fr>
In-Reply-To: <d2f85bee-c551-ec9d-1a13-6d3364788cc1@c-s.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Jan 2019 10:24:01 +0100
Message-ID: <CACT4Y+Y9H8LhpODFk6TE00kZWCU_V2QK1CStWxBt4EnWpLuCcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/32: Add KASAN support
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 9:37 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 21/01/2019 =C3=A0 09:30, Dmitry Vyukov a =C3=A9crit :
> > On Mon, Jan 21, 2019 at 8:17 AM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >>
> >>
> >>
> >> Le 15/01/2019 =C3=A0 18:23, Andrey Ryabinin a =C3=A9crit :
> >>>
> >>>
> >>> On 1/12/19 2:16 PM, Christophe Leroy wrote:
> >>>
> >>>> +KASAN_SANITIZE_early_32.o :=3D n
> >>>> +KASAN_SANITIZE_cputable.o :=3D n
> >>>> +KASAN_SANITIZE_prom_init.o :=3D n
> >>>> +
> >>>
> >>> Usually it's also good idea to disable branch profiling - define DISA=
BLE_BRANCH_PROFILING
> >>> either in top of these files or via Makefile. Branch profiling redefi=
nes if() statement and calls
> >>> instrumented ftrace_likely_update in every if().
> >>>
> >>>
> >>>
> >>>> diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan_in=
it.c
> >>>> new file mode 100644
> >>>> index 000000000000..3edc9c2d2f3e
> >>>
> >>>> +void __init kasan_init(void)
> >>>> +{
> >>>> +    struct memblock_region *reg;
> >>>> +
> >>>> +    for_each_memblock(memory, reg)
> >>>> +            kasan_init_region(reg);
> >>>> +
> >>>> +    pr_info("KASAN init done\n");
> >>>
> >>> Without "init_task.kasan_depth =3D 0;" kasan will not repot bugs.
> >>>
> >>> There is test_kasan module. Make sure that it produce reports.
> >>>
> >>
> >> Thanks for the review.
> >>
> >> Now I get the following very early in boot, what does that mean ?
> >
> > This looks like an instrumented memset call before kasan shadow is
> > mapped, or kasan shadow is not zeros. Does this happen before or after
> > mapping of kasan_early_shadow_page?
>
> This is after the mapping of kasan_early_shadow_page.
>
> > This version seems to miss what x86 code has to clear the early shadow:
> >
> > /*
> > * kasan_early_shadow_page has been used as early shadow memory, thus
> > * it may contain some garbage. Now we can clear and write protect it,
> > * since after the TLB flush no one should write to it.
> > */
> > memset(kasan_early_shadow_page, 0, PAGE_SIZE);
>
> In the early part, kasan_early_shadow_page is mapped read-only so I
> assumed this reset of its content was unneccessary.
>
> I'll try with it.
>
> Christophe

As far as I understand machine memory contains garbage after boot, and
that page needs to be all 0's so we need to explicitly memset it.


> >> [    0.000000] KASAN init done
> >> [    0.000000]
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [    0.000000] BUG: KASAN: unknown-crash in memblock_alloc_try_nid+0xd=
8/0xf0
> >> [    0.000000] Write of size 68 at addr c7ff5a90 by task swapper/0
> >> [    0.000000]
> >> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> >> 5.0.0-rc2-s3k-dev-00559-g88aa407c4bce #772
> >> [    0.000000] Call Trace:
> >> [    0.000000] [c094ded0] [c016c7e4]
> >> print_address_description+0x1a0/0x2b8 (unreliable)
> >> [    0.000000] [c094df00] [c016caa0] kasan_report+0xe4/0x168
> >> [    0.000000] [c094df40] [c016b464] memset+0x2c/0x4c
> >> [    0.000000] [c094df60] [c08731f0] memblock_alloc_try_nid+0xd8/0xf0
> >> [    0.000000] [c094df90] [c0861f20] mmu_context_init+0x58/0xa0
> >> [    0.000000] [c094dfb0] [c085ca70] start_kernel+0x54/0x400
> >> [    0.000000] [c094dff0] [c0002258] start_here+0x44/0x9c
> >> [    0.000000]
> >> [    0.000000]
> >> [    0.000000] Memory state around the buggy address:
> >> [    0.000000]  c7ff5980: e2 a1 87 81 bd d4 a5 b5 f8 8d 89 e7 72 bc 20=
 24
> >> [    0.000000]  c7ff5a00: e7 b9 c1 c7 17 e9 b4 bd a4 d0 e7 a0 11 15 a5=
 b5
> >> [    0.000000] >c7ff5a80: b5 e1 83 a5 2d 65 31 3f f3 e5 a7 ef 34 b5 69=
 b5
> >> [    0.000000]                  ^
> >> [    0.000000]  c7ff5b00: 21 a5 c1 c1 b4 bf 2d e5 e5 c3 f5 91 e3 b8 a1=
 34
> >> [    0.000000]  c7ff5b80: ad ef 23 87 3d a6 ad b5 c3 c3 80 b7 ac b1 1f=
 37
> >> [    0.000000]
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [    0.000000] Disabling lock debugging due to kernel taint
> >> [    0.000000] MMU: Allocated 76 bytes of context maps for 16 contexts
> >> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: =
8176
> >> [    0.000000] Kernel command line: console=3DttyCPM0,115200N8
> >> ip=3D192.168.2.7:192.168.2.2::255.0.0.0:vgoip:eth0:off kgdboc=3DttyCPM=
0
> >> [    0.000000] Dentry cache hash table entries: 16384 (order: 2, 65536
> >> bytes)
> >> [    0.000000] Inode-cache hash table entries: 8192 (order: 1, 32768 b=
ytes)
> >> [    0.000000] Memory: 99904K/131072K available (7376K kernel code, 52=
8K
> >> rwdata, 1168K rodata, 576K init, 4623K bss, 31168K reserved, 0K
> >> cma-reserved)
> >> [    0.000000] Kernel virtual memory layout:
> >> [    0.000000]   * 0xffefc000..0xffffc000  : fixmap
> >> [    0.000000]   * 0xf7c00000..0xffc00000  : kasan shadow mem
> >> [    0.000000]   * 0xf7a00000..0xf7c00000  : consistent mem
> >> [    0.000000]   * 0xf7a00000..0xf7a00000  : early ioremap
> >> [    0.000000]   * 0xc9000000..0xf7a00000  : vmalloc & ioremap
> >>
> >>
> >> Christophe
