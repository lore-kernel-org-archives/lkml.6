Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B2AC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC262146F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkl2UGXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC262146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbeGKWcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:32:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37075 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732831AbeGKWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:32:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id x10-v6so9423385pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=clILQctNZt4NtF6j3C50lr69xqHnPN1h0R9FImelFPc=;
        b=Rkl2UGXHXikhNsyaemyMz2LxEUDVSzSXBgGwyN7TVTu/tOwZ/KxVKfnTPS1ilPHd+l
         +ZTQJo+Ue0C3W9yy7LW8qOdluIiGJJmIK1ot1C1ygD7iA59Tp1HJWmTqfAUidOP5YXZO
         zoID9MFokcf6iAv62K14hfgDH9nwF+6bF6PeXm5k0FwPqt9FoxNVOYp95iD0QqPEEXES
         gFWSx5vH5PLgFS/euvWbAa7Ry1NCWqDPtxipk8d/pQQGUH+MkBgTyz0ytkvV0GWY6HuY
         qCddifDK9C6wvQ/c2j/scd0D6S4OT+Epnbj8UsvWdg8ttgCHOpJ8GvZqG47oBhQIcULD
         z/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=clILQctNZt4NtF6j3C50lr69xqHnPN1h0R9FImelFPc=;
        b=OiShK6VyCj97j3cmJN8D/tgFH/wxB/NUO6vzt4ncS/8nEmiYRBHydmqDckudI9HeR/
         ZtU74BsONS1Tb/vuMey+521s4hGMWQi1zg65QccEBy50lnmrPzvWTIhKzs8CLK6fxv2v
         bXZNXc2KXcmKT15c1sttHQVoYHt3Uc1+axtYtnIgX3ray2sDnHmya+qmtZlDQ1OIpmET
         ZvREbHoRdFjJ76tv4IxPLjcadyGHp7kibXegNM1/xrwjGtzroGSAimzONsPDyMetEKsm
         VD1QclRRIolKP3QScaVh7GG0ZCu4FuDGWULyGiH9FL/D3APN4wUwuhOGQ1No+j4qWpbt
         RS0g==
X-Gm-Message-State: AOUpUlEco/3X95O+8IZdZSNgdS0C4jaeFuExhatgORpv6RMZG52Lymn2
        HaaGOUALoREWngfM+GKaKPo=
X-Google-Smtp-Source: AAOMgpep852ixWRgSNUahnYOMHFR5/kcTV2OANwPjGVE2OcUXl61b0hQXuWvoJ/4S1BSd7//YmFTCg==
X-Received: by 2002:a62:15c8:: with SMTP id 191-v6mr433891pfv.194.1531347979713;
        Wed, 11 Jul 2018 15:26:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r19-v6sm23687830pgg.39.2018.07.11.15.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 15:26:18 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:26:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@techadventures.net>,
        linux-mm@kvack.org, kirill.shutemov@linux.intel.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v6,5/5] mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
Message-ID: <20180711222618.GA29869@roeck-us.net>
References: <20180628062857.29658-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628062857.29658-6-bhe@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 28, 2018 at 02:28:57PM +0800, Baoquan He wrote:
> Pavel pointed out that the behaviour of allocating memmap together
> for one node should be defaulted for all ARCH-es. It won't break
> anything because it will drop to the fallback action to allocate
> imemmap for each section at one time if failed on large chunk of
> memory.
> 
> So remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER and clean up the
> related codes.
> 

This patch causes several of my qemu boot tests to fail.
	powerpc:mac99:ppc64_book3s_defconfig:initrd:nosmp
	powerpc:mac99:ppc64_book3s_defconfig:initrd:smp4 
	powerpc:mac99:ppc64_book3s_defconfig:rootfs:smp4 
	powerpc:pseries:pseries_defconfig:initrd 
	powerpc:pseries:pseries_defconfig:rootfs 
	powerpc:powernv:powernv_defconfig:initrd 

Bisect points to this patch. Bisect log is attached for reference.
Reverting the patch fixes the problem.

[ Yes, I am aware that Michael already reported the problem at
  https://lkml.org/lkml/2018/7/11/480 ]

Guenter

---
# bad: [98be45067040799a801e6ce52d8bf4659a153893] Add linux-next specific files for 20180711
# good: [1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4
git bisect start 'HEAD' 'v4.18-rc4'
# good: [ade30e73739a5174bcaee5860fee76c2365548c5] Merge remote-tracking branch 'crypto/master'
git bisect good ade30e73739a5174bcaee5860fee76c2365548c5
# good: [792be221c35d19a1c486789e5b5c91c05279b94d] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 792be221c35d19a1c486789e5b5c91c05279b94d
# good: [1d66737ba99400ab9a79c906a25b2090f4cc8b18] Merge remote-tracking branch 'mux/for-next'
git bisect good 1d66737ba99400ab9a79c906a25b2090f4cc8b18
# good: [c02d5416bd8504866dd80d2129f4648747166b6f] Merge remote-tracking branch 'kspp/for-next/kspp'
git bisect good c02d5416bd8504866dd80d2129f4648747166b6f
# bad: [1e741337a9416010a48c6034855e316ba8057111] ntb: ntb_hw_switchtec: cleanup 64bit IO defines to use the common header
git bisect bad 1e741337a9416010a48c6034855e316ba8057111
# good: [205a106bac127145a4defae7d0d35945001fe924] kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN
git bisect good 205a106bac127145a4defae7d0d35945001fe924
# bad: [e87ebebf76c9ceeaea21a256341d6765c657e550] mm, oom: remove sleep from under oom_lock
git bisect bad e87ebebf76c9ceeaea21a256341d6765c657e550
# good: [9f95e9e87283a578fb676f14fd5e1edd4cb401f7] mm/vmscan.c: iterate only over charged shrinkers during memcg shrink_slab()
git bisect good 9f95e9e87283a578fb676f14fd5e1edd4cb401f7
# bad: [0ba29a108979bdbe3f77094e8b5cc06652e2698b] mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
git bisect bad 0ba29a108979bdbe3f77094e8b5cc06652e2698b
# good: [ca464c7768574c49f58a5be8962330814262820f] mm/sparse.c: add a static variable nr_present_sections
git bisect good ca464c7768574c49f58a5be8962330814262820f
# good: [4f02f8533cbad406e004b3bfe75f65e6b791efd5] mm/sparse.c: add a new parameter 'data_unit_size' for alloc_usemap_and_memmap
git bisect good 4f02f8533cbad406e004b3bfe75f65e6b791efd5
# good: [110cb339e5d95c77cf83d33de25f6f392d0ca7f6] mm-sparse-optimize-memmap-allocation-during-sparse_init-checkpatch-fixes
git bisect good 110cb339e5d95c77cf83d33de25f6f392d0ca7f6
# first bad commit: [0ba29a108979bdbe3f77094e8b5cc06652e2698b] mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
