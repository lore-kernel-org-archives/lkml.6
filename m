Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED57C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FF8214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSgNMyXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FF8214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbeIRXKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:10:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39948 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbeIRXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:10:14 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so4080034ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+k/5drNdlZWuPZfdEpsZoFUQEmCXXOlIeKSjH9PPxNE=;
        b=aSgNMyXj/LVT78mYo+FKAfQAdDwcwkcTek2Q1vje6UTpyT5M/9RoC/uJ3A3nl3f3z+
         bYk3/C1LSYCjh7RsxeoLwSB0LZvp7emLObzjZGyAXU2UTSZEpCdLjsmGgjz0fkiP/tgS
         nNGGwrvDPNrprsB3fFgZ3k3dOp6IWCpBnezuY9qigifXlwOe62fkWrrCb8qPAYK4ri1R
         S8zmTmy2BPrZ8SXxgJieywiGwekROo1Rw2vPGxux7D9PpeZyUyCFEGF11Tj+jAYWVtyw
         n+15C/lx3gE1YVpLuPepsg6k317Jt6hjhm/Z9Y77DnCc1AbDmuoR8uP8XrCQhTr4hPeX
         l9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+k/5drNdlZWuPZfdEpsZoFUQEmCXXOlIeKSjH9PPxNE=;
        b=hq9NJxGWc00nLa1mVmJoY0TH9wU906CeF0JZO2sPZUA43qiOh5XkWOQnY8dxCutMp2
         yKpwEblRC0pbY7f7z2UBBHcO8EFngRfpViVFzqGtULqgAOBue1NOfgbJylm6GEJxxQgI
         IFyMyAOsqmYKRAK5EBhheGA5v1l/Vow5JmLXnLtKFX5fu4iUMxmi74bgzcBN5ppqnULo
         e/4UWewLsypXp0cNtlOvZ2JWvZiEEC7hK+qAXZzij4JjH+WRcPDAvM5zgnJNCYAi2wa2
         CJ3nQ9knbmX9Zt5CWeXJ06OjNdrkLlB2jTAQMrQudzyCxEo2XcI9fu/MvMWjpoFgrd43
         zbKQ==
X-Gm-Message-State: APzg51Bz38HvyCpRbFpNrje9bnb6Q/Sb5VFrB3CMaiNtJbgnrHhB3rTO
        05gHfy/CS5wi6ErqhFRBi+MVfmOp2glTOtuSHmCCHQ==
X-Google-Smtp-Source: ANB0VdZWIk8DDN+tcU4GaFWqGM7cUE8rns1/yrM+jqVZmET9GamPHR//UMkGR15EKfHztiNzrCDRYaLTzBuu0yXNFCI=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr17045618itb.95.1537292195894;
 Tue, 18 Sep 2018 10:36:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 10:36:35
 -0700 (PDT)
In-Reply-To: <CACT4Y+aNhNeR==XKQ9gHxt1p-9JS0EkjMSyWtgYi886oumh9rA@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <f39cdef4fde40b6d2ef356db3e0126bda0e1e8c7.1535462971.git.andreyknvl@google.com>
 <CACT4Y+aNhNeR==XKQ9gHxt1p-9JS0EkjMSyWtgYi886oumh9rA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 18 Sep 2018 19:36:35 +0200
Message-ID: <CAAeHK+xFV0x3g0_HUp_TtACR1dsjXCGdzFyw0BHEmrwqdXi-Og@mail.gmail.com>
Subject: Re: [PATCH v6 13/18] khwasan: add bug reporting routines
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

On Wed, Sep 12, 2018 at 7:50 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +#ifdef CONFIG_KASAN_HW
>
> We already have #ifdef CONFIG_KASAN_HW section below with additional
> functions for KASAN_HW and empty stubs otherwise. I would add this one
> there as well.

Will do in v7.

>
>> +void print_tags(u8 addr_tag, const void *addr);
>> +#else
>> +static inline void print_tags(u8 addr_tag, const void *addr) { }
>> +#endif

>> +void *find_first_bad_addr(void *addr, size_t size)
>> +{
>> +       u8 tag = get_tag(addr);
>> +       void *untagged_addr = reset_tag(addr);
>> +       u8 *shadow = (u8 *)kasan_mem_to_shadow(untagged_addr);
>> +       void *first_bad_addr = untagged_addr;
>> +
>> +       while (*shadow == tag && first_bad_addr < untagged_addr + size) {
>
> I think it's better to check that are within bounds before accessing
> shadow. Otherwise it's kinda potential out-of-bounds access ;)
> I know that we _should_ not do an oob here, but still.
> Also feels that this function can be shortened to something like:
>
> u8 tag = get_tag(addr);
> void *p = reset_tag(addr);
> void *end = p + size;
>
> while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
>         p += KASAN_SHADOW_SCALE_SIZE;
> return p;

Will do in v7.
