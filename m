Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629663-1522253770-2-8696407474676002449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522253769; b=ZkJfJm1vrAd39w5ZPPaox8XU+hYWxJPHwJ/TKaFWyq79t30
    ZFgrX/hjB4Jke8IuSJte3BEYXFP8bog0ZbYYo78atGFOCB2sxGLv49fGure03+pK
    C0LQ22jd+nC2bnHgMxZLXLSQRFvMZrzpLHcLPLxVwYqthhx1NrvNrMIDIes2q/gL
    1DVbRCP97amANvf6KjnDAql/wI+CRww7zeou/wL9rBUHLNdVXgEiRZwVhz+nimcS
    1KmPgg1JC5SkunXQiwoU+ZlfoXURmO/NWDjpcPf042EC2mt/5ydKVxs3mCeh/TL6
    A2BFcmLapbG06548/Xr4G1f7yVadMNXA/9OPTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522253769; bh=3D341/w
    GWhwhCAlXClG7MQiNdrA53ZyIbX8KomSDfI4=; b=hloG1Tym3r6CSfZ4w6zFpNE
    RyNycNWY4oqjt+zTYBSVskjG8uUTht+TNySDisSg2C2CzK8vwkpOsU1gF/E/oEli
    XcHexYNNJ6ZnQh2lo1IAaqHLkU2LF6tLQ0qLeYyy5mCOy7yVffyHHVPMh79pQCbq
    jkcDEk261i7RaSk7gEY0gxPyV0LFg7kMMEt/K/xMpYt+SSqutjqiY+V6Bn06elXl
    YtbERZsp9Sd/GNrfaPepSDCWfLAEewkpPYMYXqi+naIiUquntJQdqRULrnoNubPf
    so7ZbaY+ZKZb9Hm24QR502l5X/QotyhrzRnGn3C5YDw3PyDI12C6wY1zC/JxHag=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGMGyiOO0W17wirqq7XppASTJp4APDXrNr3PIOfx+a7Nk0QRSphExsn32GYfg8/L8lc3fSuAomt5MlyZAlPj21zTZLAqiII+u9p9+Nkw9djrmnq1RHPO
    9vHAR40jLturTks5koEg2NwApbLUV2UCmngpINEwIL0IlggvL66ckK06jIeRkIK1AKKSw+cvX/cIWi4m3ZW28yMQgFdS4gzIGGdN0fbOyZpHOfmnvFcUHHDL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=ag1SF4gXAAAA:8 a=XdR0NtRAtsYAOTNRzE8A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeC1QQH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 12:16:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC1QQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 12:16:06 -0400
Date: Wed, 28 Mar 2018 18:16:02 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lious.lilei@hisilicon.com" <lious.lilei@hisilicon.com>,
        "dan.rue@linaro.org" <dan.rue@linaro.org>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "bp@suse.de" <bp@suse.de>,
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
Message-ID: <20180328161602.GB9211@kroah.com>
References: <20180327162716.407986916@linuxfoundation.org>
 <20180327162717.580646019@linuxfoundation.org>
 <20180327201700.xmgzgqox3sz3z32r@xps>
 <20180327203130.GA18921@localhost>
 <1522183239.2693.240.camel@hpe.com>
 <20180327204755.GA19436@localhost>
 <20180328063202.GB9547@kroah.com>
 <20180328064718.GA31963@flashbox>
 <20180328095801.GB20664@kroah.com>
 <1522249580.2693.244.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522249580.2693.244.camel@hpe.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 03:06:38PM +0000, Kani, Toshi wrote:
> On Wed, 2018-03-28 at 11:58 +0200, gregkh@linuxfoundation.org wrote:
> > On Tue, Mar 27, 2018 at 11:47:18PM -0700, Nathan Chancellor wrote:
> > > On Wed, Mar 28, 2018 at 08:32:02AM +0200, gregkh@linuxfoundation.org wrote:
> > > > On Tue, Mar 27, 2018 at 01:47:55PM -0700, Nathan Chancellor wrote:
> > > > > On Tue, Mar 27, 2018 at 08:40:56PM +0000, Kani, Toshi wrote:
> > > > > > On Tue, 2018-03-27 at 13:31 -0700, Nathan Chancellor wrote:
> > > > > > > On Tue, Mar 27, 2018 at 03:17:00PM -0500, Dan Rue wrote:
> > > > > > > > On Tue, Mar 27, 2018 at 06:27:24PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > > > > > > 
> > > > > > 
> > > > > >  :
> > > > > > > > 
> > > > > > > > This patch causes the following build error on 4.4 arm64:
> > > > > > > > 
> > > > > > > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
> > > > > > > > $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64
> > > > > > > > 
> > > > > > > >   CC      arch/arm64/mm/mmu.o
> > > > > > > > ../arch/arm64/mm/mmu.c:701:5: error: redefinition of ‘pud_free_pmd_page’
> > > > > > > >  int pud_free_pmd_page(pud_t *pud)
> > > > > > > >      ^~~~~~~~~~~~~~~~~
> > > > > > > > In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
> > > > > > > >                  from ../include/linux/mm.h:55,
> > > > > > > >                  from ../include/linux/mman.h:4,
> > > > > > > >                  from ../arch/arm64/mm/mmu.c:25:
> > > > > > > > ../include/asm-generic/pgtable.h:777:19: note: previous definition of ‘pud_free_pmd_page’ was here
> > > > > > > >  static inline int pud_free_pmd_page(pud_t *pud)
> > > > > > > >                    ^~~~~~~~~~~~~~~~~
> > > > > > > > ../arch/arm64/mm/mmu.c:706:5: error: redefinition of ‘pmd_free_pte_page’
> > > > > > > >  int pmd_free_pte_page(pmd_t *pmd)
> > > > > > > >      ^~~~~~~~~~~~~~~~~
> > > > > > > > In file included from ../arch/arm64/include/asm/pgtable.h:682:0,
> > > > > > > >                  from ../include/linux/mm.h:55,
> > > > > > > >                  from ../include/linux/mman.h:4,
> > > > > > > >                  from ../arch/arm64/mm/mmu.c:25:
> > > > > > > > ../include/asm-generic/pgtable.h:781:19: note: previous definition of ‘pmd_free_pte_page’ was here
> > > > > > > >  static inline int pmd_free_pte_page(pmd_t *pmd)
> > > > > > > >                    ^~~~~~~~~~~~~~~~~
> > > > > > > > make[2]: *** [../scripts/Makefile.build:270: arch/arm64/mm/mmu.o] Error 1
> > > > > > > > make[1]: *** [/home/drue/src/linux/4.4-rc/Makefile:969: arch/arm64/mm] Error 2
> > > > > > > > make[1]: Leaving directory '/home/drue/src/linux/4.4-rc/build-arm64'
> > > > > > > > make: *** [Makefile:152: sub-make] Error 2
> > > > > > > > 
> > > > > > > > 
> > > > > > > 
> > > > > > > Both of my arm64 devices built fine with this patch... It seems like
> > > > > > > the only way to hit that error is if HAVE_ARCH_HUGE_VMAP isn't set,
> > > > > > > which seems impossible since it is selected by ARM64...
> > > > > > > 
> > > > > > > Someone smarter than I might have more insight but this patch is
> > > > > > > unchanged from upstream so I can only assume that this error would
> > > > > > > manifest there as well.
> > > > > > 
> > > > > > It appears that HAVE_ARCH_HUGE_VMAP was introduced in 4.6 on arm64. 
> > > > > > Hence the problem in 4.4.
> > > > > > 
> > > > > > Thanks,
> > > > > > -Toshi
> > > > > > 
> > > > > 
> > > > > Ah, thanks for the heads up, since I have 324420bf91f6 ("arm64: add
> > > > > support for ioremap() block mappings") in my tree due to Linaro's
> > > > > backport of it for their Linaro Stable Kernel, which serves as a base
> > > > > for most Android kernels. My apologies for not digging deeper and sorry
> > > > > for the noise!
> > > > 
> > > > So should I just drop this patch?
> > > 
> > > Unless I am reading the commit message wrong and ignoring the fact that
> > > the mainling commit applied cleanly to 4.4.124, it seems like this is
> > > still relevant for x86.
> > > 
> > > Toshi suggested dropping the changes to arch/arm64/mm/mmu.c, which won't
> > > be a problem for arm64 devices running the stable kernels as they come
> > > because they don't have HAVE_ARCH_HUGE_VMAP so they shouldn't be hitting
> > > the bug mentioned in the commit message anyways.
> > > 
> > > However, for Android devices which have the mainline commit I mentioned
> > > above introducing HAVE_ARCH_HUGE_VMAP, dropping those changes would mean
> > > this commit isn't fixing the issue it mentions, which they would be able
> > > to hit in theory.
> > > 
> > > I don't know how you want to handle that but a simple suggestion that
> > > would not change the end result of the patch for both the stable tree
> > > and frankenkernels would be to add a simple
> > > 
> > > #ifdef CONFIG_ARCH_HAVE_HUGE_VMAP
> > > 
> > > around the changes in arch/arm64/mm/mmu.c.
> 
> Agreed.
> 
> > > I'll let you be the final judge though! Cheers,
> > 
> > That's a good idea about the #ifdef, I've updated the patch to be like
> > this, and pushed out a -rc2 with that change in it.
> 
> Great! Please note that Patch 4.4 21/43 applies on top of this 20/43
> patch. 

Yes, that patch did not get modified and sayed as-is.

thanks,

greg k-h
