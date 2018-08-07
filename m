Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB377C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D962170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulwqaliV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D962170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeHGMjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:39:43 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40411 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeHGMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:39:43 -0400
Received: by mail-ua0-f196.google.com with SMTP id m13-v6so15514864uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b2HLvKCPEl72F2jcVFCHOYKs0f42OyKKnYYNQdBzhHo=;
        b=ulwqaliVAGvQbieyUDtnl+HLQ1OMUprucGCmOA8rktKjgLre4Z74VaJ3iNkpLk2H92
         FWL0eHiCAmuQTyNje/0ZYCso1zZdFgrWRyXPmml37mtxwleENFjxNFlK3YN8SZ/kVS+f
         yOD57LL3FxhEJU+wcoXX5j3nlZ5Ly/BXw01eVtqVXQ3DuZ02vsinkfTDnBmg5F0whpF9
         ZuEmPXhLoBHzf6E9IHoGDSve7i0rEMer5cA2Hk1ZmkE0iOtIlKvLTNsK/KE8NaDxC5lZ
         qR6XkDqNr7xVyBeQeaWJUIIN2oUQ0Wqv2cewMdErS2q2QVL16/pvILu4iq9iAFdjtHY7
         vZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b2HLvKCPEl72F2jcVFCHOYKs0f42OyKKnYYNQdBzhHo=;
        b=peyVCZRhokPVpGt89VPavxo8FK5lTrsE3Q1nXoL5YigF+4PNv+MyDtClIybxtgkIa9
         /CvUkMxpvsmUjY6O4XGDxz/3hger0t/Sn1Itqi21DJeEob/tTklW7wD12IFdYv2T1OEH
         4bzanwtZLNsiIFiTaX7R8xq+Gropm+wxkcAMHhiIZQ5KCZHIMDqd80QmznBoIgGSq82J
         pCEYdHHKx0nH3HQ1qUIyhjVFDCnJLjB/hLmukJx/1rO4CNAq1467v92FKdLbegiXQM5q
         eS//0zO0O8Epe0RCi91qlQpyTAg1R0rx/t2A1v4a1ApHvfseltaKRNk5EIAyI79Ee/Dl
         ERdw==
X-Gm-Message-State: AOUpUlGvt0kzVWcHxfZiBN/C8ymc/OIOLewhjVkG13OgcKTrMoxGLUxD
        PlKL3llbq1VI8Bk8d7vqk1bQflJYP8vtcfR9pG4=
X-Google-Smtp-Source: AAOMgpcIOYQmP0kIWt+cJm+vPPwrC3frr27zG6nTPbgYuzpYBzinbuubIIuHqJGa4G+tD7uhFHbK4DbyiIkX+EtWgCw=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr13068228uae.47.1533637563248;
 Tue, 07 Aug 2018 03:26:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 03:26:02 -0700 (PDT)
In-Reply-To: <5B69445D.1000107@intel.com>
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
 <20180726093728.GA9069@yury-thinkpad> <5B599F5F.2070705@intel.com>
 <08410774-8b10-d620-064c-fdf4399d7336@rasmusvillemoes.dk> <5B69445D.1000107@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Aug 2018 13:26:02 +0300
Message-ID: <CAHp75VeQaHGaRgN8o1t7bA2BTjshZqO1GUO+D9BBqp1cVVrV2A@mail.gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dgilbert@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 10:03 AM, Wei Wang <wei.w.wang@intel.com> wrote:
> On 08/07/2018 07:30 AM, Rasmus Villemoes wrote:
>> On 2018-07-26 12:15, Wei Wang wrote:

>>> if (bits % BITS_PER_LONG)
>>>      w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
>>>
>>> we could remove the "if" check by "w += hweight_long(bitmap[k] &
>>> BITMAP_LAST_WORD_MASK(bits % BITS_PER_LONG));" the branch is the same.
>>
>> Absolutely not! That would access bitmap[lim] (the final value of the k
>> variable) despite that word not being part of the bitmap.

> Probably it's more clear to post the entire function here for a discussion:
>
> int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
> {
>         unsigned int k, lim = bits/BITS_PER_LONG;
>         int w = 0;
>
>         for (k = 0; k < lim; k++)
>                 w += hweight_long(bitmap[k]);
>
>         if (bits % BITS_PER_LONG)
> ==>            w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
>
>         return w;
> }
>
> When the execution reaches "==>", isn't "k=lim"?

Let's check again, if bits == 0, bits % whatever == 0 as well, thus,
no execution. When bits < BITS_PER_LONG, the execution is fine (k = 0
and still 0).
When bits >= BITS_PER_LONG, but not aligned, k goes from 0 to lim and
last word is exactly the partially filled one. No problem here. Las
case if bits % BITS_PER_LONG == 0, but hey, we have a guard against
this.

So, where is the problem exactly?

>> OTOH, for nbits=0, there _is_ no last word (since there are no words at
>> all), so by the time you want to apply the result of
>> BITMAP_LAST_WORD_MASK(0) to anything, you already have a bug, probably
>> either having read or being about to write into bitmap[0], which you
>> cannot do. Please check that user-space port and see if there are bugs
>> of that kind.

> Yes, some callers there don't check for nbits=0, that's why I think it is
> better to offload that check to the macro. The macro itself can be robust to
> handle all the cases.

Where they are? Can't you point out?

>> So no, the existing users of BITMAP_LAST_WORD_MASK do not check for
>> nbits being zero, they check for whether there is a partial last word,
>> which is something different.

> Yes, but "partial" could be "0".

How come?!

>> And they mostly (those in lib/bitmap.c) do
>> that because they've already handled _all_ the full words. Then there
>> are some users in include/linux/bitmap.h, that check for
>> small_const_nbits(nbits), and in those cases, we really want ~0UL when
>> nbits is BITS_PER_LONG, because small_const_nbits implies there is
>> exactly one word. Yeah, there's an implicit assumption that the bitmap
>> routines are never called with a compile-time constant nbits==0 (see the
>> unconditional accesses to *src and *dst), but changing the semantics of
>> BITMAP_LAST_WORD_MASK and making it return different values for nbits=0
>> vs nbits=64 wouldn't fix that latent bug.

> nbits=0, means there is no bit needs to mask

Like Rasmus said it's rather broken input and here you can consider
nbits==0 brings _rightfully_ UB to the caller's code.

> nbits=64, means all the 64 bits need to mask
>
> The two are different cases, I'm not sure why we let the macro to return the
> same value.

The point is macro mustn't be called when nbits==0.

-- 
With Best Regards,
Andy Shevchenko
