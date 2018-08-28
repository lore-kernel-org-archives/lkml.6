Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5077FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEA62087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ3wE8aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEA62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeH2AfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:35:09 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34209 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2AfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:35:09 -0400
Received: by mail-qk0-f193.google.com with SMTP id d15-v6so1966741qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EjMNBEUhX2l/wwWJFcNVCSAiRNbsY2g0FGQRFaq1W3E=;
        b=DQ3wE8aEYFXTeKcpFqOaq97/w95WyQ7zULg31BQ/YCCcEfWsqhM3cvDTlsjUIYi8+3
         xwyguoFIqkaMH4elZkDzJz3JVNRO6u6clUAugawtxw7teB/Ba/d/N5BhT/vdkjL/yFUH
         2of1x8CO38rXoM7gcggFFPhp7zTw4RyOZCGdqhxlmz62cqOIbEFUKD1Z+74jaSQB01zg
         TWsRyUKrY89fXuQcx/tViDywzIm4/3H9k9JJy/T0TfpZA5PJ6Cy4iTnTi+mxl1A4y9Zq
         KHQz25M8mIZJubUiXNq3jOKQ9P9BbaDE5/5CXKrVe/OAVFSaZ7Thuols/LGS8jX9sP5w
         IeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EjMNBEUhX2l/wwWJFcNVCSAiRNbsY2g0FGQRFaq1W3E=;
        b=Lc5gKNgteP9NbG0i/0l6CbgessCMK5JRziDZUAXRBgzN6UbNjQVo235Oof0NRwraW2
         0WIvVZJswWi9KdzRwrUbXRJIJhTe2Dtty08QARG3PLXY/ZOQyPuQmU1xGa+87b9HOps/
         t8VdiQwlthrIT3/fG4v3eXFY5Vq8STFjG1VW48bhuPAcBkmXNwmRq6eQ51BSacHEJjxq
         +3kjTBM+OjvM8TBOniHJiaTatO9S83Nq2yiAKM9U8JLLtQt1CWHSytJmvTy5QindUnen
         6dev07x++K9pKGtqokQy4tVjcPsVtLSqcQTzAMgPTZYvbGi4WPesIVwRDE3G7KsAwerg
         dwBg==
X-Gm-Message-State: APzg51B2oiYcWzYC9nm5wcFaCUfuLPhA3/w4EPKNZix3IF0MfQGLdFj2
        iTi/ti/O88AnvdGtV/zxYC08SAb3lAdg2a0Dn3Q=
X-Google-Smtp-Source: ANB0VdZEfKK+vgE6gf9fiyG+lu8+bTli0CIi9+in9ptp4kaU/MHZcKGLXch5uswEsCbIWx+o6Bz4hKWczbobpXT6bxA=
X-Received: by 2002:a37:1383:: with SMTP id 3-v6mr3348063qkt.129.1535488907763;
 Tue, 28 Aug 2018 13:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 13:41:27
 -0700 (PDT)
In-Reply-To: <CAKwvOdkPrKYyBsdv-FMD5pBc5TQr=cTTYb0hvLJ4Cyz7FU1qwg@mail.gmail.com>
References: <20180826175748.GA29525@gmail.com> <CAKwvOdnyHctAYRBOdrkX15MBPX68pOSiKc2P2S_JnDdffdY+OA@mail.gmail.com>
 <CANiq72=DmREZ=1mjFU5PAjQ+WYVOqerP0odFYbiNRjpyrwiNmQ@mail.gmail.com> <CAKwvOdkPrKYyBsdv-FMD5pBc5TQr=cTTYb0hvLJ4Cyz7FU1qwg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 28 Aug 2018 22:41:27 +0200
Message-ID: <CANiq72nJemek_uo16P2KhyfKNgrUQOmi+495SGGWW+QzLDfTsw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: Use feature checking instead
 of version checks for attributes
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Actually, to acknowledge the comments to the other email...

On Tue, Aug 28, 2018 at 6:53 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Tue, Aug 28, 2018 at 8:04 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Hi Nick,
>>
>> On Mon, Aug 27, 2018 at 7:43 PM, Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>> > On Sun, Aug 26, 2018 at 10:58 AM Miguel Ojeda
>> > <miguel.ojeda.sandonis@gmail.com> wrote:
>> >>
>> >> Instead of using version checks per-compiler to define (or not) each attribute,
>> >> use __has_attribute to test for them, following the cleanup started with
>> >> commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>> >>
>> >> All the attributes that are fairly common/standard (i.e. those that do not
>> >> require extra logic to define them) have been moved to a new file
>> >> include/linux/compiler_attributes.h. The attributes have been sorted
>> >> and divided between "required" and "optional".
>> >
>> > Nice! Thanks Miguel.  Regarding sorting, I'm happy with that.  In
>> > fact, some of the comments can be removed IMO, as the attributes have
>> > common definitions in the docs (maybe an added link to the gcc and
>> > clang attribute docs at the top of the file rather than per attribute
>> > comments).
>>
>> Thanks for the review!
>>
>> I thought about that, although there isn't a single page with them in
>> GCC (we could group them by type though: function ones, variable
>> ones... and then link to those).
>> On the other hand, maybe writing a
>> Doc/ file is better and allows us to write as much as one would like
>> about each of them (and a link to each page compiler's page about it,
>> etc.). I think in the end the Doc/ file might be the best, in order
>> not to crowd the header.
>
> A comment is closer to the source, but I guess that's bytes for each
> inclusion for every file.  I don't feel passionate about this point
> one way or the other.
>

I think I will write a simple Doc/ file, link to it from the source,
and see if people like it.

>>
>> >
>> >>
>> >> Further, attributes that are already supported in gcc >= 4.6 and recent clang
>> >> were simply made to be required (instead of testing for them):
>> >>   * always_inline
>> >>   * const (pure was already "required", by the way)
>> >>   * gnu_inline
>> >
>> > There's an important test for gnu_inline that isn't checking that it's
>> > supported, but rather what the implicit behavior is depending on which
>> > C standard is being used.  It's important not to remove that.
>>
>> Hm... I actually thought it was not available at some point before 4.6
>> and removed the #ifdef. The comment even says it is featuring
>> detecting it so that the old GCC inlining is used; but it shouldn't
>> matter if you always use it, no?
>
> Good point.  Rather than defining it only if GNU inline is not the
> current behavior is a bit more verbose than just always defining it.
> This seems to confirm that that should work:
> https://godbolt.org/z/igwh32.
>

Great then! Thanks for confirming!

Cheers,
Miguel
