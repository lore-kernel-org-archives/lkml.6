Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1258C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BD021B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPdGaHbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfBKSUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:20:31 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53618 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfBKSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:20:31 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so541487ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAU/yKj0QXxla3Viu5M/6EOsL3HpGEo4vnhRjeap1u8=;
        b=uPdGaHbUYiBCbGY18wf0fx+V7qybX8JeB9WGfZQQ0XCiMwzq+Bq31QhkwDr+2OoWv3
         hubaV5sIv8KVS37KeEnOPR46TZ21nEFtZFJvZhsnCSgbqUVVvABg54NRA1K8nXYcxIVW
         VLPjAr8qM9Z0A1J/cU9YcR/ls2tXkRgEUZ1t2kdGs3ogvJSNKVwUHWmvSt5B+C7c938J
         k2Tm7jrvj2vYsmOSHbMQrYJxZbPvoOmKRg9NMnnmlgt/1AneSgOOyRGMPdn0d1wgpGVN
         sspUngdTuvkUi3PiuuqNNtLXJ9jUdpgLOwtKkaJ65mzNujVhsXE3bTJ1D9nc0MlQLuem
         he1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAU/yKj0QXxla3Viu5M/6EOsL3HpGEo4vnhRjeap1u8=;
        b=qalXIDNkFiRY/3TfSdMP9AWUxVlv0CjGrcySOw3OsbDtQvPVbmuwSfvNlFvZfMyQ/G
         fpq4UTacxPnzFGyq/lXh3vgV1EoM79nNrdNtbxijViHsBx+wB9E3f0DkVFo4kWU0lGZ6
         af+Fl3cXSwCwuY5EE2VmrzQHq2Yhnq4VGvD9nBov+tErenGm1BLPqx+q58nvAyDpmqNG
         cELHMaPgs0L1eXkKKuBuPs0JUjdFZW1qRbHf4Y+cQnH1/6gmeqjm5noGMEhVhymwq/pR
         uhkaukdG0khFZ3eMtr37KTvjPoTJP0o0DjrmCqohuUJxtipUn8LOjKSiGq4jVG4/BYF4
         YMRA==
X-Gm-Message-State: AHQUAubGcD1Hv8cQu8zGyYgb7OEVKXzY/hqGk3A62XDq872z56DgbXGz
        mtCNQBhwBGofgzPEp3FZONLQ49uTGV4XqGJY/6OcIw==
X-Google-Smtp-Source: AHgI3IZr1YTFSYdFu7BCxH8vv/Z2jLxzLDrMIUQreaasD8zeol6LszIfmbpDwuq/HsIRuKwCs+sZA8OElg4D+d+yNyQ=
X-Received: by 2002:a24:4582:: with SMTP id c2mr544687itd.158.1549909230194;
 Mon, 11 Feb 2019 10:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
 <CAKv+Gu83rXGH5hVdHXM=65zQkc5FtG86xMccT7WByUFy9BmXkQ@mail.gmail.com>
 <CANiq72nf2qyNxJ2Z9nypzqUC99-v5+WC_f3o98P-zoMqy+5sLw@mail.gmail.com>
 <CAKv+Gu9a=W6Fg+ai_W-HB1gL5oUg=FKcGdLk_15CdbHLWt6gMg@mail.gmail.com>
 <CANiq72kZouVeaJ=NnyYqedCvz9A0K_GHEwuGXkgBbg5R_NRJTw@mail.gmail.com> <47895935-0619-fb4a-e74e-a8b029ba8504@gmail.com>
In-Reply-To: <47895935-0619-fb4a-e74e-a8b029ba8504@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Feb 2019 19:20:17 +0100
Message-ID: <CAKv+Gu_xdZYfUbje7GSDE3YuOoo_krcz9hnhBFAVk5X4dEmq3Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Martin Sebor <msebor@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 at 17:21, Martin Sebor <msebor@gmail.com> wrote:
>
> On 2/9/19 5:31 AM, Miguel Ojeda wrote:
> > On Sat, Feb 9, 2019 at 12:26 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On Sat, 9 Feb 2019 at 12:19, Miguel Ojeda
> >> <miguel.ojeda.sandonis@gmail.com> wrote:
> >>>
> >>> It also affects the optimizer in two different ways AFAIK:
> >>>
> >>>    * For the function itself, it gets optimized for size instead of speed.
> >>>    * For callers, the paths that lead to the calls are treated as unlikely.
> >>>
> >>
> >> That seems reasonable, but that still does not mean it is necessarily
> >> a problem if you apply 'cold' to one but not the other.
> >
> > Indeed. As I said, it is likely that you missed the attribute, not a
> > sure thing (i.e. that you didn't do it explicitly).
> >
> >>> So GCC reports it because you would be (likely) missing the
> >>> optimizations you expected if you are using the alias instead of the
> >>> target.
> >>>
> >>
> >> I see how that could be reasonable for extern declarations that do not
> >> match the definition, since in that case, it is assumed that there is
> >> only one instance of the function. For function pointers, I don't
> >> think this assumption is valid.
> >
> > It sounds reasonable to have another warning for
> > declarations-definition attribute mismatches too. However, I don't see
> > why you would warn differently. Even if you have one instance of the
> > function, you may also be using the declaration to explicitly avoid
> > the unlikely treatment.
> >
> > Now, whether the warning is worth or not or at which "level", it
> > depends. I guess the rationale behind having it under -Wall is that
> > they expect people to have missed copying the attributes, rather than
> > they are using aliases specifically to avoid a cold/... attribute.
> >
> >>> In our case in patch 3, we do not want the optimization for callers,
> >>> which is why we don't mark the extern declaration as __cold (see the
> >>> commit message).
> >>>
> >>
> >> You did not cc me on the whole set, so I don't have the patch. But in
> >> any case, GCC 9 has not been released so we should still have time to
> >> talk sense into the GCC guys.
> >
> > I only CC'd people on the relevant patches according to
> > get_maintainers (but yeah, 2 & 3 are related, I could have merged
> > those lists). Anyway, using the lore.kernel.org server makes it easy
> > to see an entire series when you have already one:
> >
> >    https://lore.kernel.org/lkml/20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com/
> >
> > As for GCC, Martin (the author of the features) is CC'd, so he can
> > chime in (and I am sure he appreciates the feedback :-)
>
> I do very much, thank you.  I think you've fielded all the GCC
> questions here so I don't have much to add.  Just a comment regarding
> aliases with different sets of attributes than their targets: it is
> possible to come up with use cases not just with attribute cold but
> others as well, including mutually exclusive pairs such as const and
> pure.  But the uses cases that drove the design of the warning were
> those where the set of attributes is meant to be the same, and we
> are yet to to come across the others in practice.  If it turns out
> that there are others in common use we can tweak the warning logic.
>
> Regarding function pointers, attribute cold only applies to function
> declarations (and labels) and is ignored on pointers, so calls to
> a cold function through a pointer are not necessarily subject to
> the same effects as direct calls to the cold function.  (This is
> inconsistent with other attributes such as const and pure which can
> be applied to function pointers, so I wouldn't recommend relying on
> cold not changing to match the others.)
>

Hello Martin,

Thanks for clearing this up. I seemed to have confused myself into
thinking that the slew of attribute 'cold' warnings I was seeing when
building the kernel plus modules with GCC-9 were about function
pointers, but in fact they were about symbol aliases, for which the
warning makes perfect sense.

Next time, I'll try talking some sense into myself first. Apologies
for the noise.

-- 
Ard.
