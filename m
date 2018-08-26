Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB08C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B588020862
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Odh+Sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B588020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeHZVVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:21:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45209 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZVVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:21:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id g44-v6so14883840qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q3iLmzfgI4gyPLnAI7B85bMTJ1nidi/SfqCTtfEPIak=;
        b=m6Odh+Sb8QU0dsV2Ddb+C7McHe1EBv1b+f1lexMuASHYZeFrYYYm/5ysOBAB5WifYI
         1fBGNeyv3vM8fK6NCV7QZq1iARFw5EBy3FvQ4Ky8xDAa8fTfnMKfd9gvZTePcNLpv4th
         mBbZIb/fPiuSTmde6wuuacGuYjXp9ONQ3/U6Z38yj7lQW5NGHFoH+ZaSm55xkSJhAyqr
         1VwoeKQRZ0XKUcN42OtpA2g8GQp1eCzD0UlB45TsI5kYPrACc6YT8vGrKLVtfrWQ5+ZF
         Azc/l3aJjQ6t08pTAwOZSZZarIqDxsknRfzksVdX0/voFVYVar0W/8laQ2G6R4snl180
         2Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q3iLmzfgI4gyPLnAI7B85bMTJ1nidi/SfqCTtfEPIak=;
        b=c5Ces4/VOkCqlLSNYSWmhbUEfTzhFxaq9y5KcUbgEEg3WlqJYTpshhGw2KR1Q3f8N+
         F/bXuTej+Z5DP/mDHixJLJuJCjUJ+IZDkqG0/910fk5NOYgR6jmfVhQOBUxNk3qrrfJa
         3kV6FSe6q7uS93iVRuDkXr86IxaZRFKjGVDo9fEEWDaUsqukGKcM+1DV2ZjwMg18y6l9
         U2R0lBU1YyMzLE5M9lopbssaY9K1u6aCiMFQ8yXsT0DWUIOg/wVGiCWBM1PW0dPRgp6f
         IzABhc2Z1hMk6yf3SeHNGnFXAr4B1eEHOQXqKRNFoaSKQoc/cSqowyRoOIyq16mhkucL
         4muA==
X-Gm-Message-State: APzg51C/cjROURms2cLTbeTZjCKT2yjv/FEgPrWONAXDJTbVXxjwIGCg
        1jTibxlz2kRckvhpTX52skQrgdUrIj62nrNZcww=
X-Google-Smtp-Source: ANB0VdY17fmFUhrHBzG4pdz7zJuJb/XZfDl3RXXysfonLpZKC5hqE5AJ3TmWzLDzR65s6SN9bgypb2fa9uLq1KOOWPg=
X-Received: by 2002:ac8:304a:: with SMTP id g10-v6mr10894380qte.136.1535305069053;
 Sun, 26 Aug 2018 10:37:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 10:37:28
 -0700 (PDT)
In-Reply-To: <1be357c91f6469c7a9b0e857fd15bad30347fd09.camel@perches.com>
References: <20180822233724.110454-1-ndesaulniers@google.com>
 <20180823002508.GA822@nautica> <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
 <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
 <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
 <e5d579d8ef832fbc133e96746ceb6edbd0870cc2.camel@perches.com>
 <CAKwvOdncUZZumxuJoLYWwPomNQb8TH+e0K=WaOSc5RjdJL7Uxw@mail.gmail.com> <1be357c91f6469c7a9b0e857fd15bad30347fd09.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 26 Aug 2018 19:37:28 +0200
Message-ID: <CANiq72kV0srrjF8CfzUntFT7KcdNQfnP8rF3RG44WR4j89uhjA@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually exclusive
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, asmadeus@codewreck.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel@iogearbox.net, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Aug 24, 2018 at 1:31 AM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2018-08-23 at 16:12 -0700, Nick Desaulniers wrote:
>> On Thu, Aug 23, 2018 at 2:19 PM Joe Perches <joe@perches.com> wrote:
>> >
>> > On Thu, 2018-08-23 at 14:03 -0700, Nick Desaulniers wrote:
>> > > Not this case; it's how we get gnu89 semantics for `extern inline` is
>> > > not compiler specific (therefor should not go in a compiler specific
>> > > header).
>> >
>> > It's not possible to know that compilers support what
>> > __attribute__((<foo>)) and at what version that support
>> > exists unless it is specified somewhere.
>>
>> __has_attribute:
>> https://clang.llvm.org/docs/LanguageExtensions.html#has-attribute
>>
>> The release notes of GCC-5 mention __has_attribute.
>> https://gcc.gnu.org/gcc-5/changes.html
>
> So not available in the now minimum supported gcc 4.6?
>

We can workaround that until we have 5 as the minimum. I have tried
and the result is quite nice.

Sending the patch in a few moments -- compile-testing for a while
allmodconfig on both 4.6 and 8.2...

Cheers,
Miguel
