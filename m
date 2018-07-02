Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FC324F78
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkun1gkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FC324F78
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeGBTQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:16:49 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36986 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbeGBTQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:16:45 -0400
Received: by mail-ua0-f196.google.com with SMTP id u8-v6so5417460uao.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zM8QdUYcU79fmKmDab6fB3QO6ufAC+g62NgcxdseyEE=;
        b=hkun1gktPhl05hCgoKO9IHYr2GlqavZXde45ML0ZGNGf+MSUtAmd/O1bJp/e49UdW3
         uK6elNgGXRJ7Y7TEqXapmnMJawKGKoS/WS3jTVVdi6Gy2oc87msugrkKdUwqkbfIx+v2
         ghEiTylkhhL2XIdHIj2T6dVsQ+ULY/X4AnmyxQZrODy6Hz1tNcMKoM9fufgSx/dYnHJ8
         tgr8nrTkgFd1w2yHCAV44n5lFJRxxuayg4bhEyWY25mV3TZoKqXofAOnX3YmpZ7et2Dm
         pdKQ8BdP+DiDaV6PmgXDB+0UmY5hUIt1kYX5hoGkPljjfImmVGHCiy9SkCavNZVrCIZt
         0jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zM8QdUYcU79fmKmDab6fB3QO6ufAC+g62NgcxdseyEE=;
        b=FI/r8iVJsE6/GTOIfiOzmnzFpEUG43GcFV9tATfOe6rSUZqk3cTN65f+Ihp6rM4CQs
         ZhFV0OCs7YI7Xgv4wAjSgPhxuPrTddJc0A+IXri4YtbH3eCIGfK7WTGlN8+rTYi4LFzd
         b9ITeAr4I9ScZ8dSRCtbI38c0eWF4JaFy1OvXYMAsd65yLQjoNXb28JYeSzG7lSHmf7T
         X23vpMnIBMIY59f++zgDTIXkzV4BUAX2NDVSvgy9s6CczRctMsoz3QJKmKlRNiiEUNF7
         A4yEKSAL7gzoRP22s/ij0CjT0Us3bY05ya6UMLc0EcWdcT22mYb/EcBX35Xxzgtq1MVW
         F/Dg==
X-Gm-Message-State: APt69E0b+92WCd3pfvrKqPSpDdm1Tv9x/2PZkpJfzAXc7AzOtlBk5JGv
        gf4sVW0pXqo7Bt0L1bScXbKsDD+twPbxXJA5PelqiQ==
X-Google-Smtp-Source: AAOMgpemPtYrmgCK0Q5ateivPvC0Req6qaZzLHXDJH1esP4jmEjDxbCLYUkb6FbOxJxJzudffyuQCciGqORSzzSDYOU=
X-Received: by 2002:a9f:2523:: with SMTP id 32-v6mr8853089uaz.101.1530559003965;
 Mon, 02 Jul 2018 12:16:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9d83:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 12:16:42 -0700 (PDT)
In-Reply-To: <20180629194117.01b2d31e805808eee5c97b4d@linux-foundation.org>
References: <cover.1530018818.git.andreyknvl@google.com> <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
 <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
 <CAAeHK+xsBOKghUp9XhpfXGqU=gjSYuy3G2GH14zWNEmaLPy8_w@mail.gmail.com> <20180629194117.01b2d31e805808eee5c97b4d@linux-foundation.org>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Mon, 2 Jul 2018 12:16:42 -0700
Message-ID: <CAFKCwrjxGEa6CLJnjmNy+92d2GSUkoymQ6Sm91CDpMZcJCcWCA@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
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
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at a live Android device under load, slab (according to
/proc/meminfo) + kernel stack take 8-10% available RAM (~350MB).
Kasan's overhead of 2x - 3x on top of it is not insignificant.

On Fri, Jun 29, 2018 at 7:41 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 29 Jun 2018 14:45:08 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>
>> >> What kind of memory consumption testing would you like to see?
>> >
>> > Well, 100kb or so is a teeny amount on virtually any machine.  I'm
>> > assuming the savings are (much) more significant once the machine gets
>> > loaded up and doing work?
>>
>> So with clean kernel after boot we get 40 kb memory usage. With KASAN
>> it is ~120 kb, which is 200% overhead. With KHWASAN it's 50 kb, which
>> is 25% overhead. This should approximately scale to any amounts of
>> used slab memory. For example with 100 mb memory usage we would get
>> +200 mb for KASAN and +25 mb with KHWASAN. (And KASAN also requires
>> quarantine for better use-after-free detection). I can explicitly
>> mention the overhead in %s in the changelog.
>>
>> If you think it makes sense, I can also make separate measurements
>> with some workload. What kind of workload should I use?
>
> Whatever workload people were running when they encountered problems
> with KASAN memory consumption ;)
>
> I dunno, something simple.  `find / > /dev/null'?
>
