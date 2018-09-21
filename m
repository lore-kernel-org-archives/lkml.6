Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D258ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FB521479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GP4qjuN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FB521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbeIUSNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:13:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46210 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:13:39 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so11944462ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FEdUn77hfplHsqh8OJiidognkuBS3sbEWNjMCJbO6VU=;
        b=GP4qjuN05dK/c/Y08fV1cwM1zbmNoXO/DtzcncLXrcJovUTu/YiAIgZW2GqspfQFVd
         DUvHDxTWQBd4sFKKrrE0mwwInpyo4hX6Zrsa83lbZpTpIRgSeq7I/1lk79VywlgU4Ail
         bV7rTiz0QWimp8z4RjEgOJXT1kUgPQf/EHPP2gsZ4a1c4w8vVoo+mDEGxL5wf/KPzKpW
         KoEM6YEVL5x3vg8aB5C6ootI8yBWAqS2Hrk7B/u7J4APBqfleB9BkydvO9Vt/5J+MB6+
         xU7e1knycUsmVOcM4bFmCXbjS1rglXdjTW/ITO05jI8yUj5i+84WXamTYO7jLdWPM1P1
         3XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FEdUn77hfplHsqh8OJiidognkuBS3sbEWNjMCJbO6VU=;
        b=etgdHn4QU+nftMofTOuk8NT0LmRjlBTaAQEnjlxn6OXsMfui27Ktas9lHuRcsjWiHD
         R0xLvKG1OyoUEO1u5FhGvJiMTrynZgc4uf73WQJUaPG5w1ZBq9wTSCsHod2fL0TXmSV+
         Z/tVqLYmYXoM408bmI2VkMd1ZoLrDHp/xURma8H6PvbIXXLoGTnymkuK8n3J4jTrmIBx
         iqpqrav2T64W02z9c1XQtEjYH9Avfc/bGN2G32yIgWTobNQ9l330+rk46QTWJ4koaySF
         xyUG2ZvWBWetFNsCkORwvimSUifV0SHdOaWYrpJgaYRDPO5WjTYZ8A2o4Ld8o7Paf2ch
         3PVw==
X-Gm-Message-State: APzg51A19eQCwsJSq6uX942sIrNlkLCwD85hmP2I3o3nupm/86csHBkn
        8sbboaf8MoBinrbsF93UFggyxSl3bzgjRsF/t1s1ug==
X-Google-Smtp-Source: ANB0VdaNHfIHTAgSgtpHFhzU739EApcUV90eoDrRT4ferIYcUz1KEndOEVMf9lLEnE6sh9sh+FRb4d3PaiHuwdmXPgw=
X-Received: by 2002:a6b:ca85:: with SMTP id a127-v6mr38249544iog.31.1537532700205;
 Fri, 21 Sep 2018 05:25:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 05:24:59
 -0700 (PDT)
In-Reply-To: <CACT4Y+aoFSySFTd9FzA0xzRYQXSbs-wzX7B67hD3jTGAQEXBOA@mail.gmail.com>
References: <cover.1537383101.git.andreyknvl@google.com> <d74e710797323db0e43f047ea698fbc85060fc57.1537383101.git.andreyknvl@google.com>
 <CACT4Y+aoFSySFTd9FzA0xzRYQXSbs-wzX7B67hD3jTGAQEXBOA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 21 Sep 2018 14:24:59 +0200
Message-ID: <CAAeHK+zBh0BiYq65QDxD-nxkHHF0QL6UQx8fs40K39R6XJJfzA@mail.gmail.com>
Subject: Re: [PATCH v8 09/20] kasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
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

On Fri, Sep 21, 2018 at 1:25 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 19, 2018 at 8:54 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>>         if (!shuffle) {
>>                 for_each_object_idx(p, idx, s, start, page->objects) {
>> -                       setup_object(s, page, p);
>> -                       if (likely(idx < page->objects))
>> -                               set_freepointer(s, p, p + s->size);
>> -                       else
>> +                       if (likely(idx < page->objects)) {
>> +                               next = p + s->size;
>> +                               next = setup_object(s, page, next);
>> +                               set_freepointer(s, p, next);
>> +                       } else
>>                                 set_freepointer(s, p, NULL);
>>                 }
>> -               page->freelist = fixup_red_left(s, start);
>> +               start = fixup_red_left(s, start);
>> +               start = setup_object(s, page, start);
>> +               page->freelist = start;
>>         }
>
> Just want to double-check that this is correct.
> We now do an additional setup_object call after the loop, but we do 1
> less in the loop. So total number of calls should be the same, right?
> However, after the loop we call setup_object for the first object (?),
> but inside of the loop we skip the call for the last object (?). Am I
> missing something, or we call ctor twice for the last object and don't
> call it for the first one?

Inside the loop we call setup_object for the "next" object. So we
start iterating on the first one, but call setup_object for the
second. Then the loop moves on to the second one and calls
setup_object for the third. And so on. So the loop calls setup_object
for every object (including the last one) except for the first one.

The idea is that we want the freelist pointer that is stored in the
current object to have a tagged pointer to the next one, so we need to
assign a tag to the next object before storing the pointer in the
current one.
