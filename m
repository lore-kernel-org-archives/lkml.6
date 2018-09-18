Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD39ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D061D2150E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDg/YjO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D061D2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeIRWYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:24:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46356 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbeIRWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:24:12 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so2110080ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S7NSi8y5oqjKqVQu+A5gE7d9gD4oGqqQyNJAQWjDqVs=;
        b=LDg/YjO/irWKmN3s7HJilg47wiCRlMtNAtqwm4Y2t7gql3JwLohRZY/iiFRWMvJXEi
         Bbue0MpGpWl/EoWn9/bv4s41xCyq8PbMyNLR+7BUc+fQnF865gSe0xjUejt1gtatCXS6
         5PWWQD+RJZys8UUF4turVeLvp4PFU8U73/ZIGfkAGUjajugrarm6EDCCOrZNVpW/biF8
         xg1oX1lH2uVEXpYmeZuzJma3tD/7kKbf6IR9+OA1XDA/WIJf1XUZC+WuLKPYVImwErRY
         5KGhr7jDpWKN5c9+c+toHhsCCmrLtQdSUlkCVjxI6y/hP9cm/mdL3NcFH6rcUTOIr4cT
         V/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S7NSi8y5oqjKqVQu+A5gE7d9gD4oGqqQyNJAQWjDqVs=;
        b=KC9Pyj6LjXOql9MlJZcNGPjbivQrxaoc4GvAW++0olVwaCdlhBI/ZiG5PLdE9CJYlC
         akeL+omxDYs8xlFJq2iNWmVuJBqNHfkaX6+86lys0nl3CVjY8pKKvKnQfHFCK9nM8pXj
         DGk+LknZe/VmMw8qwfSglt/OB5ctAdbfUjG0g171gv8iXB3Fxl5TI0hetOcxCtuCKVbl
         22JydXH19DgpYMT5ydTfoJdcEMvNsUCV9VOYq+zvpEpoBPPza0w8BGiU+W6DrkR/2iPJ
         Di2aUAJXSg0tkLbiTm7UJQ+3/GYuNJfDm6LLabRPfFZMuYQ2xvvb+MVg7kLQ9f0No3dH
         ymIw==
X-Gm-Message-State: APzg51D6MvECEizYZqBORJ6rVtYpK321KcPa73ad5FwtVVQd5UWh3GlV
        V7QfJAXe1DHgsEeYqtnCApSUw3tylyyhU+pvDvbU/Q==
X-Google-Smtp-Source: ANB0VdYx/8DId4QQx4kOmfZXWV7OZTbWXv2pf6J0pgoluaAvMz9R2OKl2U9UJdBIxGtqcOJvE/HXrOT5fcrpY2gTzGc=
X-Received: by 2002:a6b:2147:: with SMTP id h68-v6mr25437479ioh.192.1537289445779;
 Tue, 18 Sep 2018 09:50:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:50:45
 -0700 (PDT)
In-Reply-To: <CACT4Y+awX48sFAYFCgx1Q-nJ=QrBhr08psMmHr+hDeCsQc0NRw@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <95b5beb7ec13b7e998efe84c9a7a5c1fa49a9fe3.1535462971.git.andreyknvl@google.com>
 <CACT4Y+awX48sFAYFCgx1Q-nJ=QrBhr08psMmHr+hDeCsQc0NRw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 18 Sep 2018 18:50:45 +0200
Message-ID: <CAAeHK+z3W+JqC2d=-ZddsLv5D7BWa6oKpEdJFiyS1DbEYVnmqA@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] khwasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
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

On Wed, Sep 12, 2018 at 6:36 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>>         if (!shuffle) {
>> +               start = khwasan_preset_slub_tag(s, start);
>>                 for_each_object_idx(p, idx, s, start, page->objects) {
>>                         setup_object(s, page, p);
>> +                       p = khwasan_preset_slub_tag(s, p);
>
>
> As I commented in the previous patch, can't we do this in
> kasan_init_slab_obj(), which should be called in all the right places
> already?
>

As per offline discussion, will do in v7.
