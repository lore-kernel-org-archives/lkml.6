Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3322C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FF520675
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+Pqsk1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAIX4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:56:00 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44328 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfAIXz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:55:56 -0500
Received: by mail-pl1-f175.google.com with SMTP id e11so4309665plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwjF/VxuZonYGKQfOlWard9IemqUb62ut1FQS6KZ/wc=;
        b=t+Pqsk1vTR1uB8eB8evEIMJO9Bd884JNpHZK03Qwi0lW6VFlPEMbuWkDBv44Qoj9XR
         SF39TZTeY8JZob2ag/VD8LukK60fG2r9ny0hlU1huTIYRa49nR/KfhU6nY2NT5oG3e45
         OrfpcXcaXdU4KwiEZY48sYHNmNm1I4X4Z5xVQ1eUsAQjAC6OldBNIKxaPcNgPlMm7JOI
         I6Upez8il49uadGexvNtBFESy4bx6gPZIZS2J/ZU4Y3Pwk9m4hpeWO+nQULxUOeMf2gn
         4Vn0iJaQ5PIbrAfBkr/U8VXs78RPvB4CEJzmw+n2AIHduvdVB6vEPP9bFKV0OFtsXz4i
         Vf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwjF/VxuZonYGKQfOlWard9IemqUb62ut1FQS6KZ/wc=;
        b=p7CHsWhXcTh+NsrGt2X03GeA7EBDlA16cfIh+Af+08BQ34k8NPCRj2e5LnQPbcWa1R
         uUoeQagDufYyi+luRmn3aK3yFeURn8CPyAxl1m4+e34zBCsxbkBQyxRsUz/5/Q4jATKN
         0aPCWzBLrrUCqHkcNP62lyv4UR4Swbldyu/W/oH8TwXHmu9+LO4/0xdmtNCLVrJgcjEh
         DEsFUH75suuUR+v6CjcAAuICsdXVR//ycy06Abab7DQJo2Pi5SmuuV0R/uD6eBr/e2B/
         ALWhOu66m5AFz25fA9Q5iLlWvpft5VN/3HcziPjFJ7WkPfw7j1wcVHWCSu8YVmKpjgNB
         I7mA==
X-Gm-Message-State: AJcUukfH+wd3JXanJSpgk8hdOibU2l4R9Aj2AYMPlD6Ryvw42ZYN5PvR
        bbbxBVQIVIJbHOQKB6MD3a/dCC3NOr0WUV3XGFpGBw==
X-Google-Smtp-Source: ALg8bN6O3IfdjTbqKoy88xRgKRNoXnYayKymU0QiOBDVZ5aKSWoeDbGOTc6Xi8nkSm4Sx9m2U2i4D+F5mfnN1NOQxgA=
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr7998914pll.320.1547078155144;
 Wed, 09 Jan 2019 15:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20190109203119.GR6310@bombadil.infradead.org> <CAHk-=wjjkLv-8oAZPLf=pp4z_-VFpWJw+wTJYevqq0bWWY=L9g@mail.gmail.com>
In-Reply-To: <CAHk-=wjjkLv-8oAZPLf=pp4z_-VFpWJw+wTJYevqq0bWWY=L9g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Jan 2019 15:55:44 -0800
Message-ID: <CAKwvOdmOt7xhnLYmNsgJbD=6aM2BKjdqUyeARxinsT4wpSVaew@mail.gmail.com>
Subject: Re: [RFC] Use plan9 C extensions
To:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is Matthew's example tweaked a little bit for my understanding, FWIW:
https://godbolt.org/z/mD7HdX

On Wed, Jan 9, 2019 at 3:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jan 9, 2019 at 12:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > While replacing idr_alloc_cyclic(), I've come across a situation in
> > which being able to depend on -fplan9-extensions is going to lead to
> > nicer code in the users.
>
> Oh, no. Please don't.
>
> The subset of the pla9 extensions that are called just "ms" extenions
> is fine. That's a reasonable thing, and is a very natural expansion of
> the unnamed structures we already have - namely being able to
> pre-declare that unnamed structure/union.
>
> But the full plan9 extensions are nasty, and makes it much too easy to
> write "convenient" code that is really hard to read as an outsider
> because of how the types are silently converted.
>
> And I think what you want is explicitly that silent conversion.

I agree that this reminds me of an implicit conversion, which is one
of the *worst* parts of C IMO.  Implicit conversions violate the
principle of least surprise
(https://en.wikipedia.org/wiki/Principle_of_least_astonishment), and
implicit conversions are the most pointed to "defect" in languages
like JavaScript.  I understand why they're convenient, but the
resulting surprising bugs don't outweigh their cost (again, my
opinion), and developers frequently can't keep these implicit
conversion rules straight (whether we're talking about JavaScript or
C).  When it comes to type conversions, my personal thoughts align
with the Zen of Python ("Explicit is better than implicit.").

Of course, each code base can weigh the benefits with the risks and
decide what works best for them.

>
> So no. Don't do it. Use a macro or a inline function that makes the
> conversion explicit so that it's shown when grepping.
>
> The "one extra argument" is not a strong argument for something that
> simply isn't that common. The upsides of a nonstandard feature like
> that needs to be pretty compelling.
>
> We've used various gcc extensions since day #1 ("inline" being perhaps
> the biggest one that took _forever_ to become standard C), but these
> things need to have very strong arguments.
>
> "One extra argument" that could be hidden by a macro or a helper
> inline is simply not a strong argument.

I agree that something like builtin_types_compatible_p() in a macro
could help make these functions more "generic" in the sense of being
able to accept either a `struct xarray*` or `struct xarray_cyclic*`.

We're always happy to see where Clang is in terms of GCC
compatibility; I'm always happy to chat about this subject more in the
future. (and TIL about -fplan9-extensions) :D
-- 
Thanks,
~Nick Desaulniers
