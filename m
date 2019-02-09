Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97535C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFED20818
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRpt93ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBIL0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 06:26:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54109 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBIL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 06:26:23 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so15408793ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 03:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7q6z+34+FnKC4hX+HhfniurjW/0RmyWhUrpxIJ3+8VQ=;
        b=SRpt93lyJbIljyFa750SX3DwDGQNoCErXgEv9DwQTa4yDWoTflhICfd7CGjeFm6Q9S
         ky6hMIIIwbXycp0fZ6z9578H/VD78Zdv0G8Q1pP1thNkB9KZBgvkK6QFzI9PMXBTQ4k+
         cOyoDckZP8h09s3qdZVQ7/k+Mldi7Cz6CZDp3q9nOsP+DW/iikTX8KqN3AxgFGT3ZkhC
         R9RWGz3ShJqyCH6SN7wjgKBbo5B14hBhcTOgC/9w/4UWxJ1YsjLhqCi6MaG6d7XuQb98
         0Ci1q22479Y80G4wvmozyZJ22zhHTeBZs1F/6Dn9FZ65Qn0QXl9hFSko3LA4apbCPK7F
         LMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7q6z+34+FnKC4hX+HhfniurjW/0RmyWhUrpxIJ3+8VQ=;
        b=Xzu3HzLq6/rmgBp9/EB2QAKgmiaxXUyWKSQjBDM94kEPsVEc90ni7gno/YwDyXFlyn
         tKJ8BZzvAcjhgTZwHQo/92Kon7pqOS5mGTJ2y9DzChF8AnutatK+vLB5PVW9w7ktiJoW
         71d2nRNf6lfvsXwe3stuF2VcQu6HIleP/JDtbY0H3pxQyGGke+WZbSzw+fS3cSlfU62L
         htK1uNWQQuKh6EhK6rdvSvXeaGd90M/b7UbBBrNrwIX6RDuWEWZYhyFj6fCFn+ddKTof
         LJozhoO5skjp8lgR6KIIL3k5ichEEDbkGLAcoAvwYK8thZWBzZcZHlm37lUcqT2Ud959
         qR+A==
X-Gm-Message-State: AHQUAuZYpuBa/nJ5l/w5WuDB5yBA/epMfJ7C93qvJRxBTF2rpRTwK8bD
        eQGX7nzlWPHouLvBX5cR2CS7fx7wI5wtCWLG4DbDbw==
X-Google-Smtp-Source: AHgI3IZlARoDn8MFftQUf6d3BQtnWvZmuCXzVNo3tScgo43bkj+9d/RobCqAfvefUW70uLDweGYr8lDFGUtONdEJugQ=
X-Received: by 2002:a24:4582:: with SMTP id c2mr1814271itd.158.1549711581881;
 Sat, 09 Feb 2019 03:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
 <CAKv+Gu83rXGH5hVdHXM=65zQkc5FtG86xMccT7WByUFy9BmXkQ@mail.gmail.com> <CANiq72nf2qyNxJ2Z9nypzqUC99-v5+WC_f3o98P-zoMqy+5sLw@mail.gmail.com>
In-Reply-To: <CANiq72nf2qyNxJ2Z9nypzqUC99-v5+WC_f3o98P-zoMqy+5sLw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 9 Feb 2019 12:25:42 +0100
Message-ID: <CAKv+Gu9a=W6Fg+ai_W-HB1gL5oUg=FKcGdLk_15CdbHLWt6gMg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Sat, 9 Feb 2019 at 12:19, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Feb 9, 2019 at 11:44 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Sat, 9 Feb 2019 at 01:09, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > The upcoming GCC 9 release extends the -Wmissing-attributes warnings
> > > (enabled by -Wall) to C and aliases: it warns when particular function
> > > attributes are missing in the aliases but not in their target, e.g.:
> > >
> > >     void __cold f(void) {}
> >
> > Apologies if I missed any discussions on this topic, but I would argue
> > that 'cold' is not an attribute that has to be applied to the function
> > pointer as well as each of its targets, since it basically decides the
> > placement in the binary, and it doesn't affect the nature of the code
> > being referenced.
>
> It also affects the optimizer in two different ways AFAIK:
>
>   * For the function itself, it gets optimized for size instead of speed.
>   * For callers, the paths that lead to the calls are treated as unlikely.
>

That seems reasonable, but that still does not mean it is necessarily
a problem if you apply 'cold' to one but not the other.

So to me, it makes perfect sense to permit 'cold' on the target, but
not on the function pointer itself, in which case you get 1) but not
2)

> So GCC reports it because you would be (likely) missing the
> optimizations you expected if you are using the alias instead of the
> target.
>

I see how that could be reasonable for extern declarations that do not
match the definition, since in that case, it is assumed that there is
only one instance of the function. For function pointers, I don't
think this assumption is valid.

> In our case in patch 3, we do not want the optimization for callers,
> which is why we don't mark the extern declaration as __cold (see the
> commit message).
>

You did not cc me on the whole set, so I don't have the patch. But in
any case, GCC 9 has not been released so we should still have time to
talk sense into the GCC guys.
