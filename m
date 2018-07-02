Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362A6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6658257A9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQw33hFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6658257A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeGBUW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:22:29 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34783 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeGBUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:22:26 -0400
Received: by mail-ua0-f193.google.com with SMTP id r10-v6so10849172uao.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DZTBWkBvc3s6b5/8FNQDgU2F5m6kB0RUONZYE0rCNzA=;
        b=RQw33hFZlr62q4fW1W2GrPeZcbVZLDaSJZoa6oo6OSrbiwuPJlR+B6Y6kTyRV/x7Rq
         +cXPwxjfqVPND/f2uASUgl1r2G/ouYqIsQlZVhPMcLoAQ1gApxM9qLOYag6N9AJJLEty
         AloaAEHgghdna0/N4yziYab+v5aN3wlXPwiyzRczljNB+0Iw6gw/NEYxnVVGSX6OKnRO
         RHZUGKMDU81fmvN+AGwGSHlfmo8p4iG2IEUP65SgbVeDJXeDO2ZKQAwUdW1TnGTWeRNx
         qMJvh3ANDyKYWnnAaaWWJkPr76bgLsRqNWuIYtfRPjrpfkongRWdgIY2Z5w/UGWQmszd
         lR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DZTBWkBvc3s6b5/8FNQDgU2F5m6kB0RUONZYE0rCNzA=;
        b=QOG6NduhjO6YLb/Wunhcz1OthlJf/lgr342PiFyzNrEJ4QRKCiiIu4PQ6dB2cw+GU6
         x22pqnTk3MuXrFbnWH0S+eZM7zY5xhkLYbogdPmrG0e78/HVPf92GhorHHRKnYZR/ljP
         4S9OJsfCu62N1Hm643pfz0O+YWQuLi33ZWOESrf0s9QoxXG+xXQc+Ak6Km0bstBBn+XY
         2Qo8+qHff4+jm0u6FOkz9X5KY2XVzAj2aSFm9lfiiUpTvf/4Kj829g2WVMINv/maLNbu
         4mFjKYxVaNNxwWe6BCZXD9r4giqD1Zz7hkD2dafKFlHIiqkHmL7CVq8XpC0mQjJzzu3Y
         s/Fg==
X-Gm-Message-State: APt69E10eRUBgq+8TFwMd+umb8C4aRkTUOtrUYtmzlsdg3UbWLPrvCcu
        G78FB07t/VOAgEtNiVR4hwG4kHLTHC3xYmfeqU8C2g==
X-Google-Smtp-Source: AAOMgpccMptwiPW//Pk+1Cld7aNqUNL72OwwXGoGFwr2HD6EG3Je2acSfBi9JXQ/aYcB2KI3ZBvmP7elwYKfXvk23S0=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr16664810uai.17.1530562944456;
 Mon, 02 Jul 2018 13:22:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9d83:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 13:22:23 -0700 (PDT)
In-Reply-To: <20180702122112.267261b1e1609cf522753cf3@linux-foundation.org>
References: <cover.1530018818.git.andreyknvl@google.com> <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
 <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
 <CAAeHK+xsBOKghUp9XhpfXGqU=gjSYuy3G2GH14zWNEmaLPy8_w@mail.gmail.com>
 <20180629194117.01b2d31e805808eee5c97b4d@linux-foundation.org>
 <CAFKCwrjxGEa6CLJnjmNy+92d2GSUkoymQ6Sm91CDpMZcJCcWCA@mail.gmail.com> <20180702122112.267261b1e1609cf522753cf3@linux-foundation.org>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Mon, 2 Jul 2018 13:22:23 -0700
Message-ID: <CAFKCwri_W8qEw-qMs+gXGqMGdZO82WpCiVpzcG4kinEyL7+zGg@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 12:21 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 2 Jul 2018 12:16:42 -0700 Evgenii Stepanov <eugenis@google.com> wrote:
>
>> On Fri, Jun 29, 2018 at 7:41 PM, Andrew Morton
>> <akpm@linux-foundation.org> wrote:
>> > On Fri, 29 Jun 2018 14:45:08 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>> >
>> >> >> What kind of memory consumption testing would you like to see?
>> >> >
>> >> > Well, 100kb or so is a teeny amount on virtually any machine.  I'm
>> >> > assuming the savings are (much) more significant once the machine gets
>> >> > loaded up and doing work?
>> >>
>> >> So with clean kernel after boot we get 40 kb memory usage. With KASAN
>> >> it is ~120 kb, which is 200% overhead. With KHWASAN it's 50 kb, which
>> >> is 25% overhead. This should approximately scale to any amounts of
>> >> used slab memory. For example with 100 mb memory usage we would get
>> >> +200 mb for KASAN and +25 mb with KHWASAN. (And KASAN also requires
>> >> quarantine for better use-after-free detection). I can explicitly
>> >> mention the overhead in %s in the changelog.
>> >>
>> >> If you think it makes sense, I can also make separate measurements
>> >> with some workload. What kind of workload should I use?
>> >
>> > Whatever workload people were running when they encountered problems
>> > with KASAN memory consumption ;)
>> >
>> > I dunno, something simple.  `find / > /dev/null'?
>> >
>>
>> Looking at a live Android device under load, slab (according to
>> /proc/meminfo) + kernel stack take 8-10% available RAM (~350MB).
>> Kasan's overhead of 2x - 3x on top of it is not insignificant.
>>
>
> (top-posting repaired.  Please don't)
>
> For a debugging, not-for-production-use feature, that overhead sounds
> quite acceptable to me.  What problems is it known to cause?

Not having this overhead enables near-production use - ex. running
kasan/khasan kernel on a personal, daily-use device to catch bugs that
do not reproduce in test configuration. These are the ones that often
cost the most engineering time to track down.

CPU overhead is bad, but generally tolerable. RAM is critical, in our
experience. Once it gets low enough, OOM-killer makes your life
miserable.
