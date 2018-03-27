Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519608-1522183684-2-18267725637745759252
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
    t=1522183683; b=hqDsgbK+Jwcqo2Y5neFxCoXbKLfQXiPWrkpEnt5k5Vxz/ss
    Dl7xWSC4LzQ+GHZ4LdC1gL6L79peEnAcxt0aPfSg8RBizgw9LIr4mm7c/2wthdzs
    Hz/dg7flxtLvyvBCgSaJvjniZnnAFaVF1+wku0VELm9vUeyszCZaGbTX3YN1zToX
    OIcLpIj+1ru8cSiCBm58kcvcjJ2gB8Tq6g+vPCVhHhKMnhJv3IUdM6ew1oEMa1es
    +Fdz4EYVBqUAu4S7Gl5B14CYfPgwRexMxqvPJYv2i+09FOYe/L8XU5f08U5bds8N
    SpPwo33KB0LMETTn3V8e9OHL50EHszmAR5Ug92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522183683; bh=HlkEQOn
    H4wQguQ8COpUJ/bKT5nuj0c0x5aQ1WgId6CQ=; b=PLzNV/B1RdSHFdOdp3r9fdo
    /fRwDBy19RCi2rQM65L9bd+k9BF5wgIgad+gtLTD7+l1A2gDqKfj6rJjgyJo3YA7
    +ufJTBKtX0qGE5skh3s7OCTfhGNvqJyIOPqnULWwbMeSOHNV+P8C2PSiqSuij1zW
    9pefAat0dbJUnXcUcKRRjRytKjbJomllVpCTRo5YdAtVR97ZDRst3zfSpzbvQ+ai
    cPgh2oQV1pXLjwAe1L50v63xpAl8kdBMYU0Z9D38tcjYbTH8T6CLZ6mDYxOgoIOF
    G+jzwN7uniqdCXq+hexSZzJBmpjteZlNQByOCxwKlQl92xiw2XzxWUlVm7bDwWg=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gCKfPWFi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tuRKi0O/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gCKfPWFi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tuRKi0O/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIrxglHgmsht34IQueVWKOU5j89MEhf/SQp/U2/wn2vCxnkEcNgnzY5yLz4R9wqD1KJkGtBBcZ/1E4B0Gl1xyA8oqnQR/dDeiDKX9wD0yWcOfychGrVw
    GbWCmQHHlZoBUVeacdoyBh9ZUmw7BeiOXCnpVzhs7Fnre3iKskgiCAc3VYwLvwY6dKjiba0je2554BzYehHmta2n9elY10HDFnhKbHAn0kU/XyMi60a+PwYR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=v2DPQv5-lfwA:10 a=BEK_qOJoh_8nP7UDEFUA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeC0UsC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 16:48:02 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40107 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeC0UsB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 16:48:01 -0400
X-Google-Smtp-Source: AIpwx4+Ne8dxqyzKiv0CR3wzw9BitrsqpHVi4vqX0LsBRmcSYgrNUZxrxigW+oq7J9Tr2GBxl0zxBQ==
Date: Tue, 27 Mar 2018 13:47:55 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "dan.rue@linaro.org" <dan.rue@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lious.lilei@hisilicon.com" <lious.lilei@hisilicon.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped
 page table
Message-ID: <20180327204755.GA19436@localhost>
References: <20180327162716.407986916@linuxfoundation.org>
 <20180327162717.580646019@linuxfoundation.org>
 <20180327201700.xmgzgqox3sz3z32r@xps>
 <20180327203130.GA18921@localhost>
 <1522183239.2693.240.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522183239.2693.240.camel@hpe.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 08:40:56PM +0000, Kani, Toshi wrote:
> On Tue, 2018-03-27 at 13:31 -0700, Nathan Chancellor wrote:
> > On Tue, Mar 27, 2018 at 03:17:00PM -0500, Dan Rue wrote:
> > > On Tue, Mar 27, 2018 at 06:27:24PM +0200, Greg Kroah-Hartman wrote:
> > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > 
>  :
> > > 
> > > This patch causes the following build error on 4.4 arm64:
> > > 
> > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
> > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64
> > > 
> > >   CC      arch/arm64/mm/mmu.o
> > > ../arch/arm64/mm/mmu.c:701:5: error: redefinition of ‘pud_free_pmd_page’
> > >  int pud_free_pmd_page(pud_t *pud)
> > >      ^~~~~~~~~~~~~~~~~
> > > In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
> > >                  from ../include/linux/mm.h:55,
> > >                  from ../include/linux/mman.h:4,
> > >                  from ../arch/arm64/mm/mmu.c:25:
> > > ../include/asm-generic/pgtable.h:777:19: note: previous definition of ‘pud_free_pmd_page’ was here
> > >  static inline int pud_free_pmd_page(pud_t *pud)
> > >                    ^~~~~~~~~~~~~~~~~
> > > ../arch/arm64/mm/mmu.c:706:5: error: redefinition of ‘pmd_free_pte_page’
> > >  int pmd_free_pte_page(pmd_t *pmd)
> > >      ^~~~~~~~~~~~~~~~~
> > > In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
> > >                  from ../include/linux/mm.h:55,
> > >                  from ../include/linux/mman.h:4,
> > >                  from ../arch/arm64/mm/mmu.c:25:
> > > ../include/asm-generic/pgtable.h:781:19: note: previous definition of ‘pmd_free_pte_page’ was here
> > >  static inline int pmd_free_pte_page(pmd_t *pmd)
> > >                    ^~~~~~~~~~~~~~~~~
> > > make[2]: *** [../scripts/Makefile.build:270: arch/arm64/mm/mmu.o] Error 1
> > > make[1]: *** [/home/drue/src/linux/4.4-rc/Makefile:969: arch/arm64/mm] Error 2
> > > make[1]: Leaving directory '/home/drue/src/linux/4.4-rc/build-arm64'
> > > make: *** [Makefile:152: sub-make] Error 2
> > > 
> > > 
> > 
> > Both of my arm64 devices built fine with this patch... It seems like
> > the only way to hit that error is if HAVE_ARCH_HUGE_VMAP isn't set,
> > which seems impossible since it is selected by ARM64...
> > 
> > Someone smarter than I might have more insight but this patch is
> > unchanged from upstream so I can only assume that this error would
> > manifest there as well.
> 
> It appears that HAVE_ARCH_HUGE_VMAP was introduced in 4.6 on arm64. 
> Hence the problem in 4.4.
> 
> Thanks,
> -Toshi
> 

Ah, thanks for the heads up, since I have 324420bf91f6 ("arm64: add
support for ioremap() block mappings") in my tree due to Linaro's
backport of it for their Linaro Stable Kernel, which serves as a base
for most Android kernels. My apologies for not digging deeper and sorry
for the noise!

Cheers!
Nathan
