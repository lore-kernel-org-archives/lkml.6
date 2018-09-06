Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690C420869
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S9RpkC1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690C420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeIGBxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:53:51 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38763 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIGBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:53:51 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so17109203ite.3;
        Thu, 06 Sep 2018 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1RiOacWWjO2kJqUAa8v4HQtOgf41LcgCrGvyVmkTCY=;
        b=S9RpkC1Wf4WofPxwkH6NTo/1yYHGCQp9BmP0CbwKsxHcR4iTp6sroU0iS9nXY+Fgcs
         Kj5jWgGAj0nfUJlY8JYbc7TpLYXh00g/eNENVcu6dsdxqWj5YafRbbv5tcxwgkp7A0jX
         YFNDwyVksPDoulzZj9J14kOoYA4krfkFoFxK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1RiOacWWjO2kJqUAa8v4HQtOgf41LcgCrGvyVmkTCY=;
        b=gocf6IeQQ8EW7RzQTvjuF3MqCxGNBngfoc3+mh0kDg0U+bCMIrC6OCip1rupZEQo/y
         gXhqu+VJv8/5gFrOyIC0V+2fD6mb/7oxRCyWDm3sXp6EFLzdAJY1VY0IGW3ZpzXvMkPy
         Dyv/Ca3GsLBv9rI4zYmvY1h0WLWaBltMxjwSxOmllX+3nqSTdK3OnUKYoYyaLxQZzBGd
         SfRoTrLwcMisbOBPIkiq+3tWClGMXvOBmdTt85hOvpM+ll2Icx5+ZiiKoIc5ISNEwUcb
         F919U6TRInssVvmQeqO5RAdgVDLbGo6qltur5/vE0ZwTckWb0b3il3PKDYZ1MkQbh14l
         T5tw==
X-Gm-Message-State: APzg51AzD6DCQCGFXgoHI8Esi4hRj2LdRt93dP88xq38o/oSrg7z1Ha/
        evE0ilokh9qrsF/EUQTgJntowFVQ5eLu135F0Ps=
X-Google-Smtp-Source: ANB0VdZUTqlWjaw/8j9b5QBGl4CDoFqERlkE9m4WzxkY/o7EB76eETZ1PbqsjjT4u/0PGvsA8xc21Z0iInq5sw3g2Y8=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr4578345itq.9.1536268590932;
 Thu, 06 Sep 2018 14:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
In-Reply-To: <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Sep 2018 14:16:19 -0700
Message-ID: <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>, eugenis@google.com,
        Lee.Smith@arm.com,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob.Bramley@arm.com, Ruben.Ayrapetyan@arm.com,
        cpandya@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 2:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So for example:
>
> >  static inline compat_uptr_t ptr_to_compat(void __user *uptr)
> >  {
> > -       return (u32)(unsigned long)uptr;
> > +       return (u32)(__force unsigned long)uptr;
> >  }
>
> this actually looks correct.

Side note: I do think that while the above is correct, the rest of the
patch shows that we might be better off simply not havign the warning
for address space changes at all for the "cast a pointer to an integer
type" case.

When you cast to a non-pointer type, the address space issue simply
doesn't exist at all, so the warning makes less sense.

It's really just he "pointer to one address space" being cast to
"pointer to another address space" that should really warn, and that
might need that "__force" thing.

Hmm? So maybe a sparse change is better for most of that patch.

             Linus
