Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1661265-1522219659-2-4055048120803176404
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
    t=1522219659; b=Q3Jw6Dz6nDMGJYd6eglFfea5js/dBfmtDcm8DHWnWjwbG8z
    aFJ482/KiAO8PczJcxA6JEHqerwaXLkvYp4FC+pxzLj1lAb4jXtkq7YR+ZsND0vk
    qCQ8tEFUpgq5w72NjNSpEaeOBo/6BgmG1XnzGFsH6RNp07R0NurwtYmnz3RK3PkT
    MFzxqwizp1WlOnujRsyMPc+7Ln80+O+53hs8l71KaLe0glEJt00kPzuFooZaeCkk
    MGDugyRV5ka13BQPWmo+WRYD2StlW4CYLlXNcYGki7/uB0BltQTX/Lt62d1bP3lH
    rovMiIejmsiRiDvLmnVX9zhX8ocDMgZWCasaIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522219659; bh=uWfKgPA
    ht80kbf9lI8KjbCDQdDS+ypI+0SsO/gmF4Xk=; b=tJpXHHgXj2Mlha0r4QwYfQ5
    Q7lnuO59sGo+UorLHh4lXsexMiX8JTifK8U9OjWEoLURvCC+yHXb2aAga5U/5anO
    KqreAx+2GWHBTXfCawT155LL8Uo3H5VDADkuyBlj3nrml6GUuqVUToX83V/BWcrk
    DnahZBmjtBoBM0x5y5azrA99xSET7DtK61bbadliVm9rGafkEViAQwUUB0Jzy5u/
    rb3TqxVYAbuWSKC5EDULOlCR0nZlMzBkapB+F7kvvCSkoi8tCE1xYflb7YuvaSk3
    ey1HXUjvjyK3mblC8uqO1eM0/kZK6+p8PtogSI6cKx1a7NaqqU2comiiC7awbFw=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=S1dJ2lX7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XwI5xHRa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=S1dJ2lX7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XwI5xHRa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHkTpS2FAvV46RtBppQ+acokZVyujHh9Ssm0KCyeTI6F/W4FTZ8mb1nWYMRfwSog7IWyQBLrt4+l0VzIIL8A2hpVAVrolbYDlR8UoDX/at1TzXaaTHwi
    kuOv4lsqTUcJYnmBVhp2EAl6VsKJlgNV1dD3mcigM6iPRBmBdHr41VEqdbfduCpxwP7hns9JULIze7LB9bCYo7NOtPhIk/QygUXr6BBGPVO4qowS9nTZEGzn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=v2DPQv5-lfwA:10 a=ag1SF4gXAAAA:8 a=RrIUONaYjWryRK0By9AA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeC1Gr0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 02:47:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33203 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbeC1GrW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 02:47:22 -0400
X-Google-Smtp-Source: AIpwx4+9p8Q35/aSHRbSXfkds8pxaocjraKaX5WYsJwcW+akgxhi3f8Uy6hL0+RI7OtgxjaQMWO2ag==
Date: Tue, 27 Mar 2018 23:47:18 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "Kani, Toshi" <toshi.kani@hpe.com>,
        "dan.rue@linaro.org" <dan.rue@linaro.org>,
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
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped
 page table
Message-ID: <20180328064718.GA31963@flashbox>
References: <20180327162716.407986916@linuxfoundation.org>
 <20180327162717.580646019@linuxfoundation.org>
 <20180327201700.xmgzgqox3sz3z32r@xps>
 <20180327203130.GA18921@localhost>
 <1522183239.2693.240.camel@hpe.com>
 <20180327204755.GA19436@localhost>
 <20180328063202.GB9547@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328063202.GB9547@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 08:32:02AM +0200, gregkh@linuxfoundation.org wrote:
> On Tue, Mar 27, 2018 at 01:47:55PM -0700, Nathan Chancellor wrote:
> > On Tue, Mar 27, 2018 at 08:40:56PM +0000, Kani, Toshi wrote:
> > > On Tue, 2018-03-27 at 13:31 -0700, Nathan Chancellor wrote:
> > > > On Tue, Mar 27, 2018 at 03:17:00PM -0500, Dan Rue wrote:
> > > > > On Tue, Mar 27, 2018 at 06:27:24PM +0200, Greg Kroah-Hartman wrote:
> > > > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > > > 
> > >  :
> > > > > 
> > > > > This patch causes the following build error on 4.4 arm64:
> > > > > 
> > > > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
> > > > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64
> > > > > 
> > > > >   CC      arch/arm64/mm/mmu.o
> > > > > ../arch/arm64/mm/mmu.c:701:5: error: redefinition of ‘pud_free_pmd_page’
> > > > >  int pud_free_pmd_page(pud_t *pud)
> > > > >      ^~~~~~~~~~~~~~~~~
> > > > > In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
> > > > >                  from ../include/linux/mm.h:55,
> > > > >                  from ../include/linux/mman.h:4,
> > > > >                  from ../arch/arm64/mm/mmu.c:25:
> > > > > ../include/asm-generic/pgtable.h:777:19: note: previous definition of ‘pud_free_pmd_page’ was here
> > > > >  static inline int pud_free_pmd_page(pud_t *pud)
> > > > >                    ^~~~~~~~~~~~~~~~~
> > > > > ../arch/arm64/mm/mmu.c:706:5: error: redefinition of ‘pmd_free_pte_page’
> > > > >  int pmd_free_pte_page(pmd_t *pmd)
> > > > >      ^~~~~~~~~~~~~~~~~
> > > > > In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
> > > > >                  from ../include/linux/mm.h:55,
> > > > >                  from ../include/linux/mman.h:4,
> > > > >                  from ../arch/arm64/mm/mmu.c:25:
> > > > > ../include/asm-generic/pgtable.h:781:19: note: previous definition of ‘pmd_free_pte_page’ was here
> > > > >  static inline int pmd_free_pte_page(pmd_t *pmd)
> > > > >                    ^~~~~~~~~~~~~~~~~
> > > > > make[2]: *** [../scripts/Makefile.build:270: arch/arm64/mm/mmu.o] Error 1
> > > > > make[1]: *** [/home/drue/src/linux/4.4-rc/Makefile:969: arch/arm64/mm] Error 2
> > > > > make[1]: Leaving directory '/home/drue/src/linux/4.4-rc/build-arm64'
> > > > > make: *** [Makefile:152: sub-make] Error 2
> > > > > 
> > > > > 
> > > > 
> > > > Both of my arm64 devices built fine with this patch... It seems like
> > > > the only way to hit that error is if HAVE_ARCH_HUGE_VMAP isn't set,
> > > > which seems impossible since it is selected by ARM64...
> > > > 
> > > > Someone smarter than I might have more insight but this patch is
> > > > unchanged from upstream so I can only assume that this error would
> > > > manifest there as well.
> > > 
> > > It appears that HAVE_ARCH_HUGE_VMAP was introduced in 4.6 on arm64. 
> > > Hence the problem in 4.4.
> > > 
> > > Thanks,
> > > -Toshi
> > > 
> > 
> > Ah, thanks for the heads up, since I have 324420bf91f6 ("arm64: add
> > support for ioremap() block mappings") in my tree due to Linaro's
> > backport of it for their Linaro Stable Kernel, which serves as a base
> > for most Android kernels. My apologies for not digging deeper and sorry
> > for the noise!
> 
> So should I just drop this patch?

Unless I am reading the commit message wrong and ignoring the fact that
the mainling commit applied cleanly to 4.4.124, it seems like this is
still relevant for x86.

Toshi suggested dropping the changes to arch/arm64/mm/mmu.c, which won't
be a problem for arm64 devices running the stable kernels as they come
because they don't have HAVE_ARCH_HUGE_VMAP so they shouldn't be hitting
the bug mentioned in the commit message anyways.

However, for Android devices which have the mainline commit I mentioned
above introducing HAVE_ARCH_HUGE_VMAP, dropping those changes would mean
this commit isn't fixing the issue it mentions, which they would be able
to hit in theory.

I don't know how you want to handle that but a simple suggestion that
would not change the end result of the patch for both the stable tree
and frankenkernels would be to add a simple

#ifdef CONFIG_ARCH_HAVE_HUGE_VMAP

around the changes in arch/arm64/mm/mmu.c.

I'll let you be the final judge though! Cheers,
Nathan
