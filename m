Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B04C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238EA2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jv9aMC6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238EA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeIGVM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:12:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50514 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIGVM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:12:28 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so21361901ite.0;
        Fri, 07 Sep 2018 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMRrohax2ph2KNSbc5xLDIW7fWy7SURlq3551ppnb3A=;
        b=Jv9aMC6WMn+ZZbrW7T5olUwTPc5byE+tCYNoBPGCA0NPR6sqEy6yVycYd4/RQZGhSb
         WRCQIX2VbhZ08uVnMOyKwJuSVXoJz0hM+49IjDvzuM9bDuKmWlP4Dnpq8WYJ41ODWYjE
         v1bWgh+npuEuo8rXrFtyECtaVyjJ+2gDxPkp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMRrohax2ph2KNSbc5xLDIW7fWy7SURlq3551ppnb3A=;
        b=pXRoN9Nb5stgGw+jqD+b9DgSTaX8crKIKayl1V9d+l8uHhtw7w8fKwnl519zFYz6tp
         PuVNQ8CuS1YTwZafAzuCZIjUYsC3iBB9prJaQu/JyXabW+AUIRRcVhy/Fkmefe2IkVD2
         aehIN93E4yOhLoRrZbFzWqO3qnNsnhE4n6DyA56baTqeLmPvhPKYgS92xUu11Nr4sq+m
         FRX/iBTdHE8FDLmFLRGDTOzk2XJX5zT8WgG9YkX/SdfqKxShxjjxt/cZdDA7wObtP8gd
         sM4XIXyvSzmcs1J0bBS71/4+aUPG0ZBA3tzw0FamggzFPDAGAEKqgnPEmTxV92hNcGJ+
         MvmQ==
X-Gm-Message-State: APzg51AEzcTinS3S2EcjO6UZH0sAf+iSNMwwPrbVjyPXuHi95P6PizHH
        0lTsumSVVXGA/GeLQX1NfraVVzU20fMzdFdetzw=
X-Google-Smtp-Source: ANB0VdboeNEPX1Kt8Zv6DTO1vTEjeOcdVJBpL/uIzgoWBVFY394ZNZx4Njr3smtjrBVZlkIFW4F2L9EJtc63vfjJcsI=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr8597569itc.22.1536337846281;
 Fri, 07 Sep 2018 09:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
 <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com> <20180907152600.myidisza5o4kdmvf@armageddon.cambridge.arm.com>
In-Reply-To: <20180907152600.myidisza5o4kdmvf@armageddon.cambridge.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Sep 2018 09:30:35 -0700
Message-ID: <CA+55aFzQ+ykLu10q3AdyaaKJx8SDWWL9Qiu6WH2jbN_ugRUTOg@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, cpandya@codeaurora.org,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>, Ruben.Ayrapetyan@arm.com,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 8:26 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> So it's not about casting to another pointer; it's rather about no
> longer using the value as a user pointer but as an actual (untyped,
> untagged) virtual address.
>
> There may be better options to address this but I haven't seen any
> concrete proposal so far. Or we could simply consider that we've found
> all places where it matters and not bother with any static analysis
> tools (but for the time being it's still worth investigating whether we
> can do better than this).

I actually originally wanted to have sparse not just check types, but
actually do transformations too, in order to check more.

For example, for just the user pointer case, we actually have two
wildy different kinds of user pointers: "checked" user pointers and
"wild" user pointers.

Most of the time it doesn't matter, but it does for the unsafe ones:
"__get_user()" and friends.

So long long ago I wanted sparse to not just do the completely static
type analysis, but also do actual "data flow" analysis where doing an
"access_on()" on a pointer would turn it from "wild" to "checked", and
then I could have warned about "hey, this function does __get_user(),
but the flow analysis shows that you passed it a pointer that had
never been checked".

But sparse never ended up doing that kind of much smarter things. Some
of the lock context stuff does it on a very small local level, and not
very well there either.

But it sounds like this is exactly what you guys would want for the
tagged pointers. Some functions can take a "wild" pointer, because
they deal with the tag part natively. And others need to be "checked"
and have gone through the cleaning and verification.

But sparse is sadly not the right tool for this, and having a single
"__user" address space is not sufficient. I guess for the arm64 case,
you really could make up a *new* address space: "__user_untagged", and
then have functions that convert from "void __user *" to "void
__user_untagged *", and then mark the functions that need the tag
removed as taking that new kind of user pointer.

And if you never mix types, that would actually work. But I'm guessing
you can also pass "__user_untagged" pointers to the regular user
access functions, and you do?

                  Linus
