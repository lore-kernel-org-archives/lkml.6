Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C5ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E3C21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbbZuBbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E3C21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbeIUSBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:01:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37553 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbeIUSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:01:50 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so11954526iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VNiuHQhXMCIQgsespP7HYQC6vtun9kLHFpFKB+QCGz4=;
        b=gbbZuBbqvqPwyRQC/yKg4/72SK0QqbAeuAsNSv3G1gmGDPMcvr0memHNpaOfQzBafK
         QGRBPqOczIq3dUoi2fJBmWXWT4EGK13Kt2voGE7/SK4QC8yaZSobW9PHLSDvcUXsUnXU
         OFfIC9jJOFzgImw/5+lO8kXzWWQLEnKb7qUR/xVWOv+WvKZf+InmO07/gNvk90RZg3S5
         ce43pqslWPcpwDxmTpTz+HHDSY5v3TsPC26TUkk11kvJBWNNvlBy/km5vgr7NWpBOvx+
         zFcH6sNysNY3WiK2iyb7DO+JjRbRCd0cQpFp/akR8Qz8ivKam/Wwpvl6d+WmFJHUyLQI
         EDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VNiuHQhXMCIQgsespP7HYQC6vtun9kLHFpFKB+QCGz4=;
        b=mWctRd5H7PFdZ/uHbwgnhDF5f9y5+g21FLwGk6jpOc1XCwTQuP3t8wGovblHQJrm4s
         hc8AnW4dF44XXbDnzgsBsXgW79QbxxFxquvsK5/LhJNOFmwDn0Pz/34uOfjA5o7XeGWq
         AqMdZcLoym/O57yW0sfbuBh3NCwILc84NnzqNKAWGuqS3XGonOTHL3owcnLDMejPv7Ig
         qKRpM0jUB0janjBLmKrC2fcsyWcm9YVH617pIUMrck+m1ej2cgoLxYhA1E5jY6+7vHUv
         Yk1825mqlSBpJAbBPOVJGfMKgBkIieZ7y3uttZwEZsRIsiAeGuVqqb6N/rSER7uxR4/d
         OZXg==
X-Gm-Message-State: APzg51CJxdgzTyfA3JzPj/5RvOSuRcK2rqOZyFOFS2LbOvOEwpfzObMH
        U6UGhJUpfii9esf5JhWnPAMeQ/Ihg0iMvZNSdY32Mw==
X-Google-Smtp-Source: ANB0VdbR+tWj+mqo7W/yygdG6gufZ+swNG3Zig/NWtdHTkm9zoWfzUrU+sj4CxlOcpYUhsyOMzilFGUooYy1UsFXZxY=
X-Received: by 2002:a6b:1707:: with SMTP id 7-v6mr36430491iox.119.1537531993976;
 Fri, 21 Sep 2018 05:13:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 05:13:13
 -0700 (PDT)
In-Reply-To: <201809211218.10PA6RGy%fengguang.wu@intel.com>
References: <8b30f2d3e325de843f892e32f076fe9cc726191d.1537383101.git.andreyknvl@google.com>
 <201809211218.10PA6RGy%fengguang.wu@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 21 Sep 2018 14:13:13 +0200
Message-ID: <CAAeHK+z7s2mO4nn-86n+sNTkdOVpFRnAo05fO48S88qKpj_xeQ@mail.gmail.com>
Subject: Re: [PATCH v8 01/20] kasan, mm: change hooks signatures
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 6:05 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Andrey,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.19-rc4 next-20180919]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Andrey-Konovalov/kasan-add-software-tag-based-mode-for-arm64/20180920-172444
> config: x86_64-randconfig-x013-201837 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/slab.h:129:0,
>                     from include/linux/crypto.h:24,
>                     from arch/x86/kernel/asm-offsets.c:9:
>    include/linux/kasan.h: In function 'kasan_init_slab_obj':
>>> include/linux/kasan.h:111:9: error: 'ptr' undeclared (first use in this function)
>      return ptr;
>             ^~~

Right, will fix in v9.

>    include/linux/kasan.h:111:9: note: each undeclared identifier is reported only once for each function it appears in
>    make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
>
> vim +/ptr +111 include/linux/kasan.h
>
>    102
>    103  static inline void kasan_poison_slab(struct page *page) {}
>    104  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>    105                                          void *object) {}
>    106  static inline void kasan_poison_object_data(struct kmem_cache *cache,
>    107                                          void *object) {}
>    108  static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
>    109                                  const void *object)
>    110  {
>  > 111          return ptr;
>    112  }
>    113
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/201809211218.10PA6RGy%25fengguang.wu%40intel.com.
> For more options, visit https://groups.google.com/d/optout.
