Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-472497-1522182701-2-5153006082751480678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522182700; b=o58s0NCCUTLejcijd1MkOI7MSnSfKEj+WVNfGb2hbyRKKbK
    zxxFk59ULTZpcahh9b5TSGorXv7GZ0FM6GiGA49V7TTXf/VPZ3/VcV/hO1vPbQ8K
    SJWdpxZlKd/s2Ox5T5e8C5UxEdXbPBxqO06mgvsn7KZHTarB6FQ8fNR8UyJ/coeV
    KS4zKnrp9UzFzAPftq4pr2qYP0BtB0evEO+InLRgofb0JbGf57qvWfNh904i9YcX
    qGdPNzLzN57JTAgd6bfgZaOfy07i/vlQw8zMuBessa4HqW3mcXkElVWWnTkhpx/B
    VVSPmjKGLa49mte46VCk/aRO5YlVo1M/bYjrIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522182700; bh=nylL2xF
    9GIT4GiE6YwsEffiWBnNMlorDG8wQ1O0wZRw=; b=QESFCA3UlNN32YGJtU7s1u+
    Xylhnk4ynEnpMNCOsDKuWjKhMIuTmslIx62iRJfA97tgCnyDoroIF7E1RIcKW4lN
    7crcDdTPXmHscAAAP0n0pKhq6cYQS4C+sSuV6jsUOAsVWcHW2UpGf0MJ5qnp0J+f
    vG7IZruZxAzgQ2U2qpzcU6SBa59XVW5cHkEfDwT1rmj7jmrt4dw43vGY7/yK41+s
    B423zt9gXpamsqxQi1sIfp2W77ZXVqtZoglyBIOyCdK+tL3g4jm0RFFv/mvcQQuX
    wpWQl12j7n9NSE2sCfhm3Gt24BF18WBDHrbVmUc5gz5syu/V3STWqMxjgt4PY2Q=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DcRANoek x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I544erK4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DcRANoek x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I544erK4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDkROtefmPY7PNz89fm0q4eaa5NCEJjv03wcjqC0k1oNYNxO1aO9Msm4Ayg0DPirc7lgPJ0jJ/iz6XsUPZF9ZvF/7wLVi/kbKAkZVqBnc3O5VDsjYucb
    y4IFSKrScV0F/zb+v/dWxNYaHe9heTHZiDg3UQJntS/+Qo7fYyrHJcOv+BpBEYpjMppMjGltvJ3NIYnVnxNm7dRxqybS1w+ffzKKPpSuZGwrECHXok2Wi3ZR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=v2DPQv5-lfwA:10 a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=BTeA3XvPAAAA:8 a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8
    a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=JfrnYn6hAAAA:8
    a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8 a=cat7hbm38FGNYthO63oA:9
    a=a2W6tOxwmpiBB1nu:21 a=aC-TP2wdD5rAUOXQ:21 a=QEXdDO2ut3YA:10
    a=dVHiktpip_riXrfdqayU:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=tafbbOV3vt1XuEhzTjGK:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=1CNFftbPRP8L7MoqJWF3:22 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbeC0Ubi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 16:31:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36124 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeC0Ubg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 16:31:36 -0400
X-Google-Smtp-Source: AIpwx4/mKJpfebJRaE3gEHuW4v+nMXiRTealr5aMTbUt16xsWU52CN6LRtpmNHJtolRX2rJo/if9GQ==
Date: Tue, 27 Mar 2018 13:31:30 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Dan Rue <dan.rue@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lei Li <lious.lilei@hisilicon.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wang Xuefeng <wxf.wang@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped
 page table
Message-ID: <20180327203130.GA18921@localhost>
References: <20180327162716.407986916@linuxfoundation.org>
 <20180327162717.580646019@linuxfoundation.org>
 <20180327201700.xmgzgqox3sz3z32r@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180327201700.xmgzgqox3sz3z32r@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 03:17:00PM -0500, Dan Rue wrote:
> On Tue, Mar 27, 2018 at 06:27:24PM +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Toshi Kani <toshi.kani@hpe.com>
> > 
> > commit b6bdb7517c3d3f41f20e5c2948d6bc3f8897394e upstream.
> > 
> > On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap() may
> > create pud/pmd mappings.  A kernel panic was observed on arm64 systems
> > with Cortex-A75 in the following steps as described by Hanjun Guo.
> > 
> >  1. ioremap a 4K size, valid page table will build,
> >  2. iounmap it, pte0 will set to 0;
> >  3. ioremap the same address with 2M size, pgd/pmd is unchanged,
> >     then set the a new value for pmd;
> >  4. pte0 is leaked;
> >  5. CPU may meet exception because the old pmd is still in TLB,
> >     which will lead to kernel panic.
> > 
> > This panic is not reproducible on x86.  INVLPG, called from iounmap,
> > purges all levels of entries associated with purged address on x86.  x86
> > still has memory leak.
> > 
> > The patch changes the ioremap path to free unmapped page table(s) since
> > doing so in the unmap path has the following issues:
> > 
> >  - The iounmap() path is shared with vunmap(). Since vmap() only
> >    supports pte mappings, making vunmap() to free a pte page is an
> >    overhead for regular vmap users as they do not need a pte page freed
> >    up.
> > 
> >  - Checking if all entries in a pte page are cleared in the unmap path
> >    is racy, and serializing this check is expensive.
> > 
> >  - The unmap path calls free_vmap_area_noflush() to do lazy TLB purges.
> >    Clearing a pud/pmd entry before the lazy TLB purges needs extra TLB
> >    purge.
> > 
> > Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(), which
> > clear a given pud/pmd entry and free up a page for the lower level
> > entries.
> > 
> > This patch implements their stub functions on x86 and arm64, which work
> > as workaround.
> > 
> > [akpm@linux-foundation.org: fix typo in pmd_free_pte_page() stub]
> > Link: http://lkml.kernel.org/r/20180314180155.19492-2-toshi.kani@hpe.com
> > Fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
> > Reported-by: Lei Li <lious.lilei@hisilicon.com>
> > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Wang Xuefeng <wxf.wang@hisilicon.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Chintan Pandya <cpandya@codeaurora.org>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This patch causes the following build error on 4.4 arm64:
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64
> 
>   CC      arch/arm64/mm/mmu.o
> ../arch/arm64/mm/mmu.c:701:5: error: redefinition of ‘pud_free_pmd_page’
>  int pud_free_pmd_page(pud_t *pud)
>      ^~~~~~~~~~~~~~~~~
> In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
>                  from ../include/linux/mm.h:55,
>                  from ../include/linux/mman.h:4,
>                  from ../arch/arm64/mm/mmu.c:25:
> ../include/asm-generic/pgtable.h:777:19: note: previous definition of ‘pud_free_pmd_page’ was here
>  static inline int pud_free_pmd_page(pud_t *pud)
>                    ^~~~~~~~~~~~~~~~~
> ../arch/arm64/mm/mmu.c:706:5: error: redefinition of ‘pmd_free_pte_page’
>  int pmd_free_pte_page(pmd_t *pmd)
>      ^~~~~~~~~~~~~~~~~
> In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
>                  from ../include/linux/mm.h:55,
>                  from ../include/linux/mman.h:4,
>                  from ../arch/arm64/mm/mmu.c:25:
> ../include/asm-generic/pgtable.h:781:19: note: previous definition of ‘pmd_free_pte_page’ was here
>  static inline int pmd_free_pte_page(pmd_t *pmd)
>                    ^~~~~~~~~~~~~~~~~
> make[2]: *** [../scripts/Makefile.build:270: arch/arm64/mm/mmu.o] Error 1
> make[1]: *** [/home/drue/src/linux/4.4-rc/Makefile:969: arch/arm64/mm] Error 2
> make[1]: Leaving directory '/home/drue/src/linux/4.4-rc/build-arm64'
> make: *** [Makefile:152: sub-make] Error 2
> 
> 

Both of my arm64 devices built fine with this patch... It seems like
the only way to hit that error is if HAVE_ARCH_HUGE_VMAP isn't set,
which seems impossible since it is selected by ARM64...

Someone smarter than I might have more insight but this patch is
unchanged from upstream so I can only assume that this error would
manifest there as well.

Cheers!
Nathan
