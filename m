Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B576C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF113208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOQWySiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF113208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeGaOqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:46:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54099 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732024AbeGaOqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:46:16 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so4318702itw.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KDgx1wu0S4s/fsoNbAILQ44BQFWBJhQa9o5lBqBhbsA=;
        b=QOQWySiUBOrjacnJ/0qrKicp9QAp0C7Zv8NRMdXSFPVOgRPlbrS8gNd7RgL6qlUlIj
         6Edog2HkYgSwovUnsQr3R6tdcWaZ6CMZOERKw/bmb15/wFIaFCBcmj6z8jkHux9rq87W
         AO6JyepCVfczcxK4BUkGChYkwGL58YRhMTG+GCY7pJ6Mjz2DlxjNL3eFfJ4sbUys8Pid
         zWWu3yP+QTS79xD9lQ2WPYNGLpo7l0LCi07KWKX9D9Ha6LTnh2DoSh08tdRfYvYMjqmC
         iOr2p9fMlVTF0Qu6djS0WqVPm5Dohd9sSqUco6niSssdghIxeO6QOgh2PUlh4M5UVEHI
         vsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KDgx1wu0S4s/fsoNbAILQ44BQFWBJhQa9o5lBqBhbsA=;
        b=HI1X0qn178QoRzGiRBLfYaVNKykGnpzOT4Z+Cx+Ja9M56sgeSvvNWxN6HIses0lYWF
         oHa5/fRCea6E1Ux+Ob+xZ3ekiV1iWd0W5/fp7UC61lG4oGzh2os7Vjnd+gJ/3SZ1y2eZ
         jcUvlppRlcU1w7Z8r4k1J4LhqgWbIcagjfxwGWUfG2RCsv2DetWaiCvjTZKnc6MMQYfX
         Zu5EmrEmL4LRUVSrjgEXj3anAX/qxgKT7X/nV0/DGjVtknE8kt3fxPomsQPTlng5LOml
         IJ73/YLzIUT4lgg30ABBIzRWwd3Z5oGXT5zn73/YUj2T5uHZ6JvtkaMgeKtqZV6Jwm9C
         541Q==
X-Gm-Message-State: AOUpUlF2hypY7TT93b1fb2ELkvS1fE/rVPoFRYDrHjkOOz4DbHuYCMk3
        rSCCezRYl4ZWrHN4NaajA3mAacI693GM95dzu/SImQ==
X-Google-Smtp-Source: AAOMgpeZr80M/FmFnLuElEuAGYI8x7OAsEcGWQDEiBDQKUU5ihxSenWvbznd9FPrqYswVUCn6u4AzvDQ097Hlxvkuqc=
X-Received: by 2002:a24:db05:: with SMTP id c5-v6mr3119100itg.44.1533042360087;
 Tue, 31 Jul 2018 06:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 06:05:59
 -0700 (PDT)
In-Reply-To: <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
References: <cover.1530018818.git.andreyknvl@google.com> <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
 <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 31 Jul 2018 15:05:59 +0200
Message-ID: <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
To:     vincenzo.frascino@arm.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 3:44 PM, Vincenzo Frascino@Foss
<vincenzo.frascino@arm.com> wrote:
> On 06/26/2018 02:15 PM, Andrey Konovalov wrote:
>
>> @@ -325,18 +341,41 @@ void kasan_init_slab_obj(struct kmem_cache *cache,
>> const void *object)
>>     void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t
>> flags)
>>   {
>> -       return kasan_kmalloc(cache, object, cache->object_size, flags);
>> +       object = kasan_kmalloc(cache, object, cache->object_size, flags);
>> +       if (IS_ENABLED(CONFIG_KASAN_HW) && unlikely(cache->ctor)) {
>> +               /*
>> +                * Cache constructor might use object's pointer value to
>> +                * initialize some of its fields.
>> +                */
>> +               cache->ctor(object);
>>
> This seams breaking the kmem_cache_create() contract: "The @ctor is run when
> new pages are allocated by the cache."
> (https://elixir.bootlin.com/linux/v3.7/source/mm/slab_common.c#L83)
>
> Since there might be preexisting code relying on it, this could lead to
> global side effects. Did you verify that this is not the case?
>
> Another concern is performance related if we consider this solution suitable
> for "near-production", since with the current implementation you call the
> ctor (where present) on an object multiple times and this ends up memsetting
> and repopulating the memory every time (i.e. inode.c: inode_init_once). Do
> you know what is the performance impact?

We can assign tags to objects with constructors when a slab is
allocated and call constructors once as usual. The downside is that
such object would always have the same tag when it is reallocated, so
we won't catch use-after-frees. But that is probably something we'll
have to deal with if we're aiming for "near-production". I'll add this
change to v5, thanks!
