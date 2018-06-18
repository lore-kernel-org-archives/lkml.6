Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88B2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C56020693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOnYYSgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C56020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbeFRWwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:52:17 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39077 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755329AbeFRWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:52:15 -0400
Received: by mail-vk0-f68.google.com with SMTP id r83-v6so10570223vkf.6;
        Mon, 18 Jun 2018 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DUh/BdUCoOISWT8eUOYXHilFbNBpolZpltroZB1lHPA=;
        b=EOnYYSgjOmYfxpIlbr/UpILzEobhKDRO2X6WRU26DmZoTj5hYwgP66yu1eW2GyW9W/
         Uu5BuEPQZ0L/4LzgTtf7ib+cWeBlC+Lp+upqRf2YjKxcwSpuxC/pNdoZuun4IPJjlCF1
         iCPn/uwQeM0KVIWr3NEorIkStTXKIWbmkV5w0XnWpiDTuNAz5vNBo6d3FdlOqR52q37w
         C7hOkhEs5tHB7DJionOHzsNgjKJDysaZj+Azaq8cmE9wxMBRMsMueTk/zggSgAZkDQ++
         rR8QLXYFGZykiu/BnS8Qroo52VvrhdNfDshgvA8H2KTehBerZ3VfDMe3z4Dq3kOWpCGe
         igZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DUh/BdUCoOISWT8eUOYXHilFbNBpolZpltroZB1lHPA=;
        b=In8kQb17s8yKu+N3ZkUfG91mpIl6JwKV2csKPvV7+aR2ZnM/DODEIonXzRvrrZGhTC
         xU92V+++GVtFigGi+7GQdTmntblMGYIpdSorMfPBnttzr5ibii6y58nkgO0XHCVqBKQ/
         rd8iuEfnRdVkPdGgUg8XfnmWDiggO/vzSmhWxzHUtwHbt/7Uaf3OWgT3NAHxWL+7Q8yL
         MKGT/23sv8nhlxrVSYu0C7gHH5CLU9tvZm5E0kSm+Y0QEhYOn48luE6ZwqJ6W9X3Qwit
         /n2DS4YS3XU8GsioJ/4atJrCOFPATE+Kr2msZgwOllShD1l5L9bDh3gKJ62KCU/wzvxO
         DY1A==
X-Gm-Message-State: APt69E1ow/oiMGOMCB9HisIot4IpcRHt2V2/8BuA8xC2MdbXrvfm5H2S
        UkYrStGaX5tmJDLy5fh8lowf7RTivEJs80rp/5U=
X-Google-Smtp-Source: ADUXVKLz3MfpLJeewHY84JA9WzfHiPG4nfw2CJ8tI1FKur/OqLRXJENznNUzWLKMalRd6Jyp4lPOX7TbwzTqpmBszDo=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr8413950vkg.131.1529362334309;
 Mon, 18 Jun 2018 15:52:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 15:52:13
 -0700 (PDT)
In-Reply-To: <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
 <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
 <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org> <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 01:52:13 +0300
Message-ID: <CAHp75VdoL=qTBKMp+FB=RdNRqbZgv9=hJ=kYAAAYFTUpxFAr6g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        shli@kernel.org, linux-raid@vger.kernel.org,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:01 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jun 18, 2018 at 2:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 18 Jun 2018 16:10:01 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>
>> > A lot of code become ugly because of open coding allocations for bitmaps.
>> >
>> > Introduce three helpers to allow users be more clear of intention
>> > and keep their code neat.
>> >
>> > ...
>> >
>> > +unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
>> > +{
>> > +     return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
>> > +}
>> > +EXPORT_SYMBOL(bitmap_alloc);
>> > +
>> > +unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
>> > +{
>> > +     return bitmap_alloc(nbits, flags | __GFP_ZERO);
>> > +}
>> > +EXPORT_SYMBOL(bitmap_zalloc);
>> > +
>> > +void bitmap_free(const unsigned long *bitmap)
>> > +{
>> > +     kfree(bitmap);
>> > +}
>> > +EXPORT_SYMBOL(bitmap_free);
>> > +
>>
>> I suggest these functions are small and simple enough to justify
>> inlining them.
>>
>
> We can't as we end up including bitmap.h (by the way of cpumask.h)
> form slab.h, so we gen circular dependency. Maybe if we removed memcg
> stuff from slab.h so we do not need to include workqueue.h...

I will look at it. It might be doable.
Though I dunno what MM people would say about this. Anyone's name
comes to your mind to ask?

-- 
With Best Regards,
Andy Shevchenko
