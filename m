Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE199ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F18214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXvoZLmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F18214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeIRA1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:27:45 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56145 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIRA1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:27:44 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so12632091itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=imbl7D6svXjMEDV1aM57VNbFqhmwF/aRo2PktqskJuQ=;
        b=AXvoZLmLgMAkSSLph5qhphHZPpuXzsVeA+LJnEioxD2i9DbxIbUMZ7oU/I7T0KAQEG
         HWB1T5bqUEG6VEPGD8GTee4MqYcfAMZDmQMxszQ63t59biirUoMKxrO6CjKf06sp/Y29
         31Ek95BboUhSTqFMKjwriT0NMBhJ9uZWh6ReIvNYjgx2ol0Jf65rxmWDhRCWG1KSpGDw
         kL0TazrHkDS+H/6Qe2mUoUvzEKLIwdVDHBJ1tqpcOuZwFrqJfXvfQFN1AqhqOzHCwdod
         W29fkyw6sKhsiW2nMQDhZQxSuMFgVI0isAvsI8NrMiWsYdFKU43eWaSd1nQfPhmE+dl3
         J3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=imbl7D6svXjMEDV1aM57VNbFqhmwF/aRo2PktqskJuQ=;
        b=he4ZByf26zony/jesgLY6vS1WRJFOP6F6yZw6zmBLw8qL9gSn+huqIoYCDmVIbAHEj
         wyHHijMZTA1//UVGD2QVeth91ByeALz3zzkkgeg6gwPbxElCMTAn7ixcaiygG6a1yT6d
         YmIlGCbC4LPVzPPQI/n2axj7sdWgs/CcRwtmzUKJLpVrH9nznnHo8ArX8WuM2m7maGon
         rs5dJw5RVyz4gdI60zGOjugzz4dTXGkQlcMUK9ZD1ZA2WQ3T4P9cOoKV8EqHPJ43PwS2
         Fq/eI3aVfltyiuepVCgV21DzsPzUoaIyAhtxeJqlbAv5GpVdA3a808DQcWNIyLOVxqDy
         5I5w==
X-Gm-Message-State: APzg51DfW1jL1QOAT0X25fEodm8A0HZRWfKPzHiELk3Y8VrFj22DZwkW
        1qWDjYhQ9OC7gRS4tbk2FJ5fbq3afCYDDgTqKcUNQA==
X-Google-Smtp-Source: ANB0VdaS1EoKzdL952x3zxcMxZ9kKbrRdhvkgUNLHKzjLC0aaZXkL32ZLULEnBXIBEItyZhiP7MBWrW3iJZ02RUaX8s=
X-Received: by 2002:a24:be8f:: with SMTP id i137-v6mr14019760itf.113.1537210746324;
 Mon, 17 Sep 2018 11:59:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 11:59:05
 -0700 (PDT)
In-Reply-To: <CACT4Y+adO3n4Nb4XOPyXdt43DbYjb=Kz6__tPTmb1CX=00qNSQ@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <6cd298a90d02068969713f2fd440eae21227467b.1535462971.git.andreyknvl@google.com>
 <CACT4Y+adO3n4Nb4XOPyXdt43DbYjb=Kz6__tPTmb1CX=00qNSQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 17 Sep 2018 20:59:05 +0200
Message-ID: <CAAeHK+w+Znw-t_wd29PO5B+pNegS3wqzS1mUVCmfrgdCXpavWw@mail.gmail.com>
Subject: Re: [PATCH v6 07/18] khwasan: add tag related helper functions
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

On Wed, Sep 12, 2018 at 6:21 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +void *khwasan_preset_slub_tag(struct kmem_cache *cache, const void *addr)
>
> Can't we do this in the existing kasan_init_slab_obj() hook? It looks
> like it should do exactly this -- allow any one-time initialization
> for objects. We could extend it to accept index and return a new
> pointer.
> If that does not work for some reason, I would try to at least unify
> the hook for slab/slub, e.g. pass idx=-1 from slub and then use
> random_tag().
> It also seems that we do preset tag for slab multiple times (from
> slab_get_obj()). Using kasan_init_slab_obj() should resolve this too
> (hopefully we don't call it multiple times).

The issue is that SLAB stores freelist as an array of indexes instead
of using an actual linked list like SLUB. So you can't store the tag
in the pointer while the object is in the freelist, since there's no
pointer. And, technically, we don't preset tags for SLAB, we just use
the id as the tag every time a pointer is used, so perhaps we should
rename the callback. As to unifying the callbacks, sure, we can do
that.
