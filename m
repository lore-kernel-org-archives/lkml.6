Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1B9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB43321486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUxsK2Aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB43321486
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeIXPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:20:46 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52752 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeIXPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:20:46 -0400
Received: by mail-it1-f196.google.com with SMTP id h3-v6so9588487ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rS1mqpxBCQG2vYOjlLWLe8grWSn6psHa6d8/gEao3RQ=;
        b=CUxsK2AaMGXsYBs10gOijRXjTaNpaV4Q0sBe+bVWJbCm4aN4UroDEDmBIOcOoiHmlw
         KGOqJtT56YMlZf4VbQtNQw/bHoEE9vgrwl0pB05PFUMSl6VPlr264zKWfKBBhQl3a5pO
         bEWRZQ9BUmcO1+p4JMDehtx9dPJZOm7ehN9J3SAfA32uTo/PxWIHPFffPW0/qg10BSeK
         15UiRzcN0z6BywRM0EnqOqZvnN2EenEO+FIT3P3LNGQhMzIE6wZ/4bzeC2opvOSTfIHQ
         JwoUNOkt0jZ4/HGVE6uZs0SsMZ9ikORLB52WAFONeqPqA5F+R19U445stSV2+mE2q6I3
         5rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rS1mqpxBCQG2vYOjlLWLe8grWSn6psHa6d8/gEao3RQ=;
        b=DCltKzZ1q1WQMbpj42uSQTyQDGNio3Q0ZDkBYsbkt6U9phOet0RP4GFsByOfzPhXEK
         zzqDlI18p+rimn0DVUsMtLPyhd/MerL1ZnrVFaf+aPrkTeFVO/4ohlZGFTb04L6GIfk5
         eLWaOxcPHsX1+qUfPlIsISvQI12Ga8R/04EJlnduUiOIt+g8nFm+Z+6EIgySGlXimQr/
         U43uGSMF27DYKH2zQHh91JvhPUgI3BD0hKWBY94Sn3EIjdBBwUrV5QIJw4t4gIQOSxzM
         e2aJEQBlYgSk56XOXBLCEBBmsnVTQ+yqZ4X2nfeDgK0INCUg7Np/A2/iccwzDpNUO6Yw
         z/SA==
X-Gm-Message-State: ABuFfoguTtMZEDN4nS11KTNpA6n5xAizE5HGb/g/EdNZG0RgQ79lkMvt
        GhDyhZbgD5BScLuhAqifPucIH+j9+6gnmDLaZrxJ5w==
X-Google-Smtp-Source: ACcGV61KROE549eGpZAoEPJotXYLQ1GsMcQyeqFp6ed9F0BFlTX8vKqis1OS8Kz6X2l/g9GUME9qJJBzL7ApBnh2zrA=
X-Received: by 2002:a24:d286:: with SMTP id z128-v6mr6873183itf.14.1537780778120;
 Mon, 24 Sep 2018 02:19:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 02:19:17
 -0700 (PDT)
In-Reply-To: <CAAeHK+zBh0BiYq65QDxD-nxkHHF0QL6UQx8fs40K39R6XJJfzA@mail.gmail.com>
References: <cover.1537383101.git.andreyknvl@google.com> <d74e710797323db0e43f047ea698fbc85060fc57.1537383101.git.andreyknvl@google.com>
 <CACT4Y+aoFSySFTd9FzA0xzRYQXSbs-wzX7B67hD3jTGAQEXBOA@mail.gmail.com> <CAAeHK+zBh0BiYq65QDxD-nxkHHF0QL6UQx8fs40K39R6XJJfzA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Sep 2018 11:19:17 +0200
Message-ID: <CACT4Y+b6qe1S_4dAhYGPm0r1nFWW4Fn1rCNbSZW-7w7jMpcTtQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/20] kasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Fri, Sep 21, 2018 at 2:24 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Fri, Sep 21, 2018 at 1:25 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Sep 19, 2018 at 8:54 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>
>>>         if (!shuffle) {
>>>                 for_each_object_idx(p, idx, s, start, page->objects) {
>>> -                       setup_object(s, page, p);
>>> -                       if (likely(idx < page->objects))
>>> -                               set_freepointer(s, p, p + s->size);
>>> -                       else
>>> +                       if (likely(idx < page->objects)) {
>>> +                               next = p + s->size;
>>> +                               next = setup_object(s, page, next);
>>> +                               set_freepointer(s, p, next);
>>> +                       } else
>>>                                 set_freepointer(s, p, NULL);
>>>                 }
>>> -               page->freelist = fixup_red_left(s, start);
>>> +               start = fixup_red_left(s, start);
>>> +               start = setup_object(s, page, start);
>>> +               page->freelist = start;
>>>         }
>>
>> Just want to double-check that this is correct.
>> We now do an additional setup_object call after the loop, but we do 1
>> less in the loop. So total number of calls should be the same, right?
>> However, after the loop we call setup_object for the first object (?),
>> but inside of the loop we skip the call for the last object (?). Am I
>> missing something, or we call ctor twice for the last object and don't
>> call it for the first one?
>
> Inside the loop we call setup_object for the "next" object. So we
> start iterating on the first one, but call setup_object for the
> second. Then the loop moves on to the second one and calls
> setup_object for the third. And so on. So the loop calls setup_object
> for every object (including the last one) except for the first one.
>
> The idea is that we want the freelist pointer that is stored in the
> current object to have a tagged pointer to the next one, so we need to
> assign a tag to the next object before storing the pointer in the
> current one.

Ah, OK, then false alarm.
