Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176CB20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlC1WR61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176CB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeGaSgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:36:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40958 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731272AbeGaSgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:36:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so6399366pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaJCucJm5eu8jdEXk2ol+fvxbWy79/xLJRI8GQqUcHE=;
        b=JlC1WR61AeIDykWcPenJRKVYRj/shpCnquguI+47Jat3yCYpkVd9FtuamGovynCfWq
         NWFZGT8Lr/b10KQzTAJa1jUoXarnJqEDiyBNyZINIsaTfLmv7jvzPebmtYtnADnzFw3Q
         5v9KLFqgsPwo5asTL/gLN/pT0vjEAgaQpNcKMETMvCJ2/z94fAUTdFXUdUBNDNHnl6u6
         oWhxIWsVMCvf8HWW30gwFyzgZ88OdUpZNvVc1F2FUbs98UXFt6cJtb7xsCfcZxe/7tay
         LjyH2XUWifm6Tz8V2c2MItIKBiRLKDlbIEiRFBOs3pH7A2hI9frsiIqfX4SD5upUweyJ
         sDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaJCucJm5eu8jdEXk2ol+fvxbWy79/xLJRI8GQqUcHE=;
        b=Y3sOXjpPAMWi1cCOoqAkTRyYV3h7/LsbGzcBP/VJR08J78SeeBXCzxROdaevBFFS+2
         HE3eMO11gIH3iYv2BwcAsnjWxAdF586bbq7rhBj09Lt6VEkg2pSLkaZeutQDlSzStOZJ
         EHx7ldfSdiFcWdpK4oIQFyYJFMK/OJsPYMuE1EmaRTDH2XCEsAO1OHEvUK6LbwVp0iW1
         IHAM8ahwrhWLwDo4ERf8xwzD/ESU74irU/0UbxnvKCE34r1tWuSTJCPr8ruYRgkxM2Ea
         sTbvChUfz5x2tB8XNwFIF72nQQE62KkzKMU1H9WD6vY6GOs6+KDW7cwPiAlMmTR2pa8I
         lkmA==
X-Gm-Message-State: AOUpUlE6sAx14IzwMznAnQ3fMydmEvIWxU4772t90bVYeHWjFaGuAL0c
        wp1xAyQkFLIqahPcV6DU200GKTg2qJB9s61Mr1eJwA==
X-Google-Smtp-Source: AAOMgpe/5Kus+mdSKIIUcLEyM0n1jjFFHNWLQ50p7uO3iTbQaDAd9KeFWKgGKt865NaulnjMZK1xPgMBDKP8j1/HE2I=
X-Received: by 2002:a62:8d7:: with SMTP id 84-v6mr23091819pfi.172.1533056134400;
 Tue, 31 Jul 2018 09:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180730213412.242849-3-ndesaulniers@google.com> <201807312139.1v5egImL%fengguang.wu@intel.com>
In-Reply-To: <201807312139.1v5egImL%fengguang.wu@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 09:55:23 -0700
Message-ID: <CAKwvOd=gkkcztQSES0NaNdJ_igDem9FmKVh30=NKujR=ek+78g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
To:     lkp@intel.com
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, paul.burton@mips.com,
        christophe.leroy@c-s.fr, shorne@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, rdunlap@infradead.org,
        bp@suse.de, neilb@suse.com, LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, dwmw@amazon.co.uk,
        sandipan@linux.vnet.ibm.com, linux@rasmusvillemoes.dk,
        Paul Lawrence <paullawrence@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>, ghackmann@android.com,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>, avagin@openvz.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another strange error from 0-day bot.  The source file does not make
use of my added macros, so not sure how they could generate such a
warning.
On Tue, Jul 31, 2018 at 6:54 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.18-rc7 next-20180727]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Nick-Desaulniers/compiler-clang-h-Add-CLANG_VERSION-and-__diag-macros/20180731-161932
> config: x86_64-randconfig-s1-07312048 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    drivers/gpu//drm/i915/i915_gem.c: In function '__i915_gem_object_set_pages':
> >> drivers/gpu//drm/i915/i915_gem.c:2697:1: error: expected expression before '#pragma'
>      GEM_BUG_ON(!HAS_PAGE_SIZES(i915, obj->mm.page_sizes.sg));
>     ^~~
>
> vim +2697 drivers/gpu//drm/i915/i915_gem.c
>
> 03ac84f18 Chris Wilson 2016-10-28  2658
> 03ac84f18 Chris Wilson 2016-10-28  2659  void __i915_gem_object_set_pages(struct drm_i915_gem_object *obj,
> a5c081662 Matthew Auld 2017-10-06  2660                                  struct sg_table *pages,
> 84e8978e6 Matthew Auld 2017-10-09  2661                                  unsigned int sg_page_sizes)
> 03ac84f18 Chris Wilson 2016-10-28  2662  {
> a5c081662 Matthew Auld 2017-10-06  2663         struct drm_i915_private *i915 = to_i915(obj->base.dev);
> a5c081662 Matthew Auld 2017-10-06  2664         unsigned long supported = INTEL_INFO(i915)->page_sizes;
> a5c081662 Matthew Auld 2017-10-06  2665         int i;
> a5c081662 Matthew Auld 2017-10-06  2666
> 1233e2db1 Chris Wilson 2016-10-28  2667         lockdep_assert_held(&obj->mm.lock);
> 03ac84f18 Chris Wilson 2016-10-28  2668
> 03ac84f18 Chris Wilson 2016-10-28  2669         obj->mm.get_page.sg_pos = pages->sgl;
> 03ac84f18 Chris Wilson 2016-10-28  2670         obj->mm.get_page.sg_idx = 0;
> 03ac84f18 Chris Wilson 2016-10-28  2671
> 03ac84f18 Chris Wilson 2016-10-28  2672         obj->mm.pages = pages;
> 2c3a3f44d Chris Wilson 2016-11-04  2673
> 2c3a3f44d Chris Wilson 2016-11-04  2674         if (i915_gem_object_is_tiled(obj) &&
> f2123818f Chris Wilson 2017-10-16  2675             i915->quirks & QUIRK_PIN_SWIZZLED_PAGES) {
> 2c3a3f44d Chris Wilson 2016-11-04  2676                 GEM_BUG_ON(obj->mm.quirked);
> 2c3a3f44d Chris Wilson 2016-11-04  2677                 __i915_gem_object_pin_pages(obj);
> 2c3a3f44d Chris Wilson 2016-11-04  2678                 obj->mm.quirked = true;
> 2c3a3f44d Chris Wilson 2016-11-04  2679         }
> a5c081662 Matthew Auld 2017-10-06  2680
> 84e8978e6 Matthew Auld 2017-10-09  2681         GEM_BUG_ON(!sg_page_sizes);
> 84e8978e6 Matthew Auld 2017-10-09  2682         obj->mm.page_sizes.phys = sg_page_sizes;
> a5c081662 Matthew Auld 2017-10-06  2683
> a5c081662 Matthew Auld 2017-10-06  2684         /*
> 84e8978e6 Matthew Auld 2017-10-09  2685          * Calculate the supported page-sizes which fit into the given
> 84e8978e6 Matthew Auld 2017-10-09  2686          * sg_page_sizes. This will give us the page-sizes which we may be able
> 84e8978e6 Matthew Auld 2017-10-09  2687          * to use opportunistically when later inserting into the GTT. For
> 84e8978e6 Matthew Auld 2017-10-09  2688          * example if phys=2G, then in theory we should be able to use 1G, 2M,
> 84e8978e6 Matthew Auld 2017-10-09  2689          * 64K or 4K pages, although in practice this will depend on a number of
> 84e8978e6 Matthew Auld 2017-10-09  2690          * other factors.
> a5c081662 Matthew Auld 2017-10-06  2691          */
> a5c081662 Matthew Auld 2017-10-06  2692         obj->mm.page_sizes.sg = 0;
> a5c081662 Matthew Auld 2017-10-06  2693         for_each_set_bit(i, &supported, ilog2(I915_GTT_MAX_PAGE_SIZE) + 1) {
> a5c081662 Matthew Auld 2017-10-06  2694                 if (obj->mm.page_sizes.phys & ~0u << i)
> a5c081662 Matthew Auld 2017-10-06  2695                         obj->mm.page_sizes.sg |= BIT(i);
> a5c081662 Matthew Auld 2017-10-06  2696         }
> a5c081662 Matthew Auld 2017-10-06 @2697         GEM_BUG_ON(!HAS_PAGE_SIZES(i915, obj->mm.page_sizes.sg));
> f2123818f Chris Wilson 2017-10-16  2698
> f2123818f Chris Wilson 2017-10-16  2699         spin_lock(&i915->mm.obj_lock);
> f2123818f Chris Wilson 2017-10-16  2700         list_add(&obj->mm.link, &i915->mm.unbound_list);
> f2123818f Chris Wilson 2017-10-16  2701         spin_unlock(&i915->mm.obj_lock);
> 03ac84f18 Chris Wilson 2016-10-28  2702  }
> 03ac84f18 Chris Wilson 2016-10-28  2703
>
> :::::: The code at line 2697 was first introduced by commit
> :::::: a5c08166265adc172a4cbde8ed26a1a96ce77fb7 drm/i915: introduce page_size members
>
> :::::: TO: Matthew Auld <matthew.auld@intel.com>
> :::::: CC: Chris Wilson <chris@chris-wilson.co.uk>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Thanks,
~Nick Desaulniers
