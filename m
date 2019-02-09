Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD91BC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CC4218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dATwHBHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBIMbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:31:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41659 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:31:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id f21-v6so3774915ljj.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 04:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcHsUnh5QxvsPy/ZT8tglv4I/mDQW8SZPvAeIODUNDw=;
        b=dATwHBHsqOkTw+3DssemY1J/e1evWXIBxi5qj4Kxdgw0zelGSpd98RYuOdpvJ+aHo3
         sOy6WkG3IFSNA3p+J8ekHjBA8E5QeD/yNvfVVeS5cBeU3tzNpeh1scYJHKo0rNftUEhl
         RXLkVj0e0IZKE7PldQU1y41Yx7idPfTFoOTvfoncGdT4rRNYU21juaUfl/MDzfrQsDYz
         ZFRpsb9pax/RQD5VT1GRkhGuqToUbNOEZm8GvQjGVxXjiuuNOU0UrFVuGl67EupmkVZx
         LGpmlaqL5AyZp323vHN44q1sBv/BH3+lCpvPktoqkuqJw5K81eUrE3Lxhvx8xI+3tIwG
         64zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcHsUnh5QxvsPy/ZT8tglv4I/mDQW8SZPvAeIODUNDw=;
        b=H6eWVg618wItQcPLnwz8n+4opoI67xoRu+F+N7E1dgG4kFY79Cgea5ZQubXCSv/XtD
         YYhon9z7UM+emllGnv9q0X3gRERLS5qYvZ6fJOpnZLZtmrCttYlbMcMyLw9DWO+6i2w0
         fqizcLJFlzm9xFCLuE3/z1KU7R7yQ3qUqp9OzY/UkHLO9zQNgf667V6MWobmgEVBn4uL
         7RYujJyDE3215a3UIJaC2Ed1xHOV93ORF/cfCVgKa/SwVfNjLDFcipRbvwN0q65A9gfY
         XpqJbZtXpzhzD724QuoGHctaHPjF0tBYrYUnx1IP/jPls1eg768gxi15F20awZsfuSP9
         el7Q==
X-Gm-Message-State: AHQUAubONwNvRQ1yFMbD/xqj/KTfrs7OnFB22qhhP/rk8k2jwtn+4wUO
        mUvuFlBv3/+phBF4VtZJAfbmh7WxbMmDhD8p71k=
X-Google-Smtp-Source: AHgI3Ia7okk+0+95zUBP7BnwZqWLYqk3YDa05ZYrPY8zwDoFfQt58Ux26LncPfTvbIxEBwcZHdOyuEJhQmlLB5CU6LA=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr17821221lji.113.1549715509070;
 Sat, 09 Feb 2019 04:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
 <CAKv+Gu83rXGH5hVdHXM=65zQkc5FtG86xMccT7WByUFy9BmXkQ@mail.gmail.com>
 <CANiq72nf2qyNxJ2Z9nypzqUC99-v5+WC_f3o98P-zoMqy+5sLw@mail.gmail.com> <CAKv+Gu9a=W6Fg+ai_W-HB1gL5oUg=FKcGdLk_15CdbHLWt6gMg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9a=W6Fg+ai_W-HB1gL5oUg=FKcGdLk_15CdbHLWt6gMg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 9 Feb 2019 13:31:38 +0100
Message-ID: <CANiq72kZouVeaJ=NnyYqedCvz9A0K_GHEwuGXkgBbg5R_NRJTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sat, Feb 9, 2019 at 12:26 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Sat, 9 Feb 2019 at 12:19, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > It also affects the optimizer in two different ways AFAIK:
> >
> >   * For the function itself, it gets optimized for size instead of speed.
> >   * For callers, the paths that lead to the calls are treated as unlikely.
> >
>
> That seems reasonable, but that still does not mean it is necessarily
> a problem if you apply 'cold' to one but not the other.

Indeed. As I said, it is likely that you missed the attribute, not a
sure thing (i.e. that you didn't do it explicitly).

> > So GCC reports it because you would be (likely) missing the
> > optimizations you expected if you are using the alias instead of the
> > target.
> >
>
> I see how that could be reasonable for extern declarations that do not
> match the definition, since in that case, it is assumed that there is
> only one instance of the function. For function pointers, I don't
> think this assumption is valid.

It sounds reasonable to have another warning for
declarations-definition attribute mismatches too. However, I don't see
why you would warn differently. Even if you have one instance of the
function, you may also be using the declaration to explicitly avoid
the unlikely treatment.

Now, whether the warning is worth or not or at which "level", it
depends. I guess the rationale behind having it under -Wall is that
they expect people to have missed copying the attributes, rather than
they are using aliases specifically to avoid a cold/... attribute.

> > In our case in patch 3, we do not want the optimization for callers,
> > which is why we don't mark the extern declaration as __cold (see the
> > commit message).
> >
>
> You did not cc me on the whole set, so I don't have the patch. But in
> any case, GCC 9 has not been released so we should still have time to
> talk sense into the GCC guys.

I only CC'd people on the relevant patches according to
get_maintainers (but yeah, 2 & 3 are related, I could have merged
those lists). Anyway, using the lore.kernel.org server makes it easy
to see an entire series when you have already one:

  https://lore.kernel.org/lkml/20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com/

As for GCC, Martin (the author of the features) is CC'd, so he can
chime in (and I am sure he appreciates the feedback :-)

Cheers,
Miguel
