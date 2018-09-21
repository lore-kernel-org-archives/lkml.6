Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D47ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F061A21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWA6AJhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F061A21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbeIUURh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:17:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41287 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbeIUURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:17:37 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so12411990iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=74oBTiZr3GKImqfkkADCJON0PqznDXIBxVnzqvX+kz8=;
        b=iWA6AJhNk820rNuxGMftyKtHbvikFgsPcQoQMTPgFe0HS04jIlQQhqDoXU94t2ocZK
         2FnhhFOHAA69jWD3Mv7DPNAqFfCOQzrDWWxnWomgNi8pbQivISplEJmgE5CpGJV3mHnT
         mw4yqk41E6Ej6Mjx5FaqWhbIMHtzU8jV0I6PBCh0onl959gPA2p8h9YaoPNM87DOrfQ/
         vYcMPMmz1EwFCsphyOw35uSyy11lKl1B8aP8XR/rTwz91DoGfIiZKBgBgkJ2HgQIYS9b
         u4H4ThoSozTsEPNxMHM5fyseiGcRusxhajAKtRwzaImhESAD25J0yh4dkhfZltYXi+5W
         Qhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=74oBTiZr3GKImqfkkADCJON0PqznDXIBxVnzqvX+kz8=;
        b=bTED69pel6HBE4pFyWGxGIZwcmWDokXc685PHAbs6gZIJTNp3mvKgB4qOPv4UQPszI
         Hn80BE+In9MWRBEwfMKstu7KawXXVmQGG0UiIDTaQRibWxq7r49EmxGVap96Q+Dsac7p
         UpZV4QN/3WTFbKvw4nalq/elanEUR7COoLiLsSIjgVmOg1RnW4d3xJlKIEnWawEUfM6m
         9Y6D+aBhdUiRRAEX3wAuurVEiwUdCunGg1pwNmZMFV6OrZC4PhLhrEMpPynVA7rdCFyb
         jtLMzWRo3P5HSNO5k3RLhNM0xc/2ecPvfpt8Kaexd/JakZTmH3iXyeewjUWnJzCVWYeU
         3p0w==
X-Gm-Message-State: APzg51AArB3hY3SIZrWiBkhr2Q5DIMZ483cHr8RMEBw2TC4NKo3qaAl0
        u0+Qx9NRefLD7CyYGeu2LQj9+f3uoSiJgHL68pXtBQ==
X-Google-Smtp-Source: ANB0VdaQDDxYU4zdTLk5+IoXzhgYjoTNs3ohPMdEFEeKaqticcN3tguxn/UeElIfUDhG0VOPgBCsgntoLXoOSu7B56A=
X-Received: by 2002:a6b:ca85:: with SMTP id a127-v6mr38758579iog.31.1537540108394;
 Fri, 21 Sep 2018 07:28:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 07:28:27
 -0700 (PDT)
In-Reply-To: <CACT4Y+aD=ghemsrBaw2N_FJWtrWNf3r=BWxjWLkKBjNB-s=4Vg@mail.gmail.com>
References: <cover.1537383101.git.andreyknvl@google.com> <d3f5102da9792370158ed02203d8066dd5e07ff7.1537383101.git.andreyknvl@google.com>
 <CACT4Y+aD=ghemsrBaw2N_FJWtrWNf3r=BWxjWLkKBjNB-s=4Vg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 21 Sep 2018 16:28:27 +0200
Message-ID: <CAAeHK+wBcmoikVedBZFSGC4UGsF578AKCzFhNFNgMuJe6oWvZA@mail.gmail.com>
Subject: Re: [PATCH v8 16/20] kasan: add hooks implementation for tag-based mode
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
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

On Fri, Sep 21, 2018 at 1:37 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 19, 2018 at 8:54 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +       /*
>> +        * Since it's desirable to only call object contructors ones during
>
> s/ones/once/

Will fix.

>
>> +        * slab allocation, we preassign tags to all such objects.
>
> While we are here, it can make sense to mention that we can't repaint
> objects with ctors after reallocation (even for
> non-SLAB_TYPESAFE_BY_RCU) because the ctor code can memorize pointer
> to the object somewhere (e.g. in the object itself). Then if we
> repaint it, the old memorized pointer will become invalid.

Will mention.

>> -       kasan_unpoison_shadow(object, size);
>> +       /* See the comment in kasan_init_slab_obj regarding preassigned tags */
>> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
>> +                       (cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)) {
>> +#ifdef CONFIG_SLAB
>> +               struct page *page = virt_to_page(object);
>> +
>> +               tag = (u8)obj_to_index(cache, page, (void *)object);
>> +#else
>> +               tag = get_tag(object);
>> +#endif
>
> This kinda _almost_ matches the chunk of code in kasan_init_slab_obj,
> but not exactly. Wonder if there is some nice way to unify this code?
>
> Maybe something like:
>
> static u8 tag_for_object(struct kmem_cache *cache, const void *object, new bool)
> {
>     if (!IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
>         !cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
>         return random_tag();
> #ifdef CONFIG_SLAB
>     struct page *page = virt_to_page(object);
>     return (u8)obj_to_index(cache, page, (void *)object);
> #else
>     return new ? random_tag() : get_tag(object);
> #endif
> }
>
> Then we can call this in both places.

Will do, however I think it's better to do the CONFIG_KASAN_SW_TAGS
check outside this helper function.

> As a side effect this will assign tags to pointers during slab
> initialization even if we don't have ctors, but it should be fine (?).

We don't have to assign tag in this case, can just leave 0xff.
