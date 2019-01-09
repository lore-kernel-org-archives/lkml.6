Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED8120661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H3j7dJ+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfAIXeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:34:11 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:35326 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfAIXeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:34:10 -0500
Received: by mail-lf1-f46.google.com with SMTP id e26so6975542lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kihea9656pyrZLekdKJKkbc+TkTwWk+wlGPYP62NVDs=;
        b=H3j7dJ+utHvOHiJP+4P/itsVuR3HAJBKrIunG8RM+JfHYw5EUICbpdOv0Ji44E9Zby
         RyaIDz3n7mOy8mx2d4jdtWhVnNBf3iQP2UztKg1Qku8sWR7F/5wjJFb8WllKluP0jll0
         bgeBuMwSVvM+X1Au59rOLXWdzfqzjZPyTGyPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kihea9656pyrZLekdKJKkbc+TkTwWk+wlGPYP62NVDs=;
        b=GkO6xKuVepDCWuNJbUoKtbKp/ZDju4YlR6YnNOJMk66DQZxK/wRtit/SM014C7OSe6
         ffv+lQL6nzUia0jdT73zBJRH3TLBHg9lHEvEKdeJLKBe9x3+1nl395cUAxz5m2vI4Jk+
         DOUhOp5Hf/3ck0PkU2eQ3PNF5DBtlb9KF5zPKrIeARsj366RECx1gJ2wr6pjS00U57Lq
         E/fa0lHT42IN1klJXaPMlrGfLRHTKSQ69k8jB8iwzhv8XtFHHeZvVJ/BPe5my1iHhCKu
         gpZvYUMxhNwP1QaRSzcBlgjG5mYHED2TDuGB23Cj1hNTftCWpv5tpYoceJpWaXeENWPU
         9ppQ==
X-Gm-Message-State: AJcUukdI9EYoj8Gf5pSfvREKEEQnAReRvTOPuWSJpTvYRmAmUV8dDo/m
        FEspz+OYRrO03fBalbrmWGeGW8qnHF8=
X-Google-Smtp-Source: ALg8bN5WeUgmFrCleaT7j6UDu/wFYUIA9EyKant3ShDhs9mcr7FvgfFTf3QWvIBlamZCFly0r3hzgQ==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr4786941lfi.19.1547076848141;
        Wed, 09 Jan 2019 15:34:08 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 11-v6sm14736469ljv.1.2019.01.09.15.34.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 15:34:07 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id n18so6971625lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 15:34:06 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr4297785lff.16.1547076846414;
 Wed, 09 Jan 2019 15:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20190109203119.GR6310@bombadil.infradead.org>
In-Reply-To: <20190109203119.GR6310@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jan 2019 15:33:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjkLv-8oAZPLf=pp4z_-VFpWJw+wTJYevqq0bWWY=L9g@mail.gmail.com>
Message-ID: <CAHk-=wjjkLv-8oAZPLf=pp4z_-VFpWJw+wTJYevqq0bWWY=L9g@mail.gmail.com>
Subject: Re: [RFC] Use plan9 C extensions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 12:31 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> While replacing idr_alloc_cyclic(), I've come across a situation in
> which being able to depend on -fplan9-extensions is going to lead to
> nicer code in the users.

Oh, no. Please don't.

The subset of the pla9 extensions that are called just "ms" extenions
is fine. That's a reasonable thing, and is a very natural expansion of
the unnamed structures we already have - namely being able to
pre-declare that unnamed structure/union.

But the full plan9 extensions are nasty, and makes it much too easy to
write "convenient" code that is really hard to read as an outsider
because of how the types are silently converted.

And I think what you want is explicitly that silent conversion.

So no. Don't do it. Use a macro or a inline function that makes the
conversion explicit so that it's shown when grepping.

The "one extra argument" is not a strong argument for something that
simply isn't that common. The upsides of a nonstandard feature like
that needs to be pretty compelling.

We've used various gcc extensions since day #1 ("inline" being perhaps
the biggest one that took _forever_ to become standard C), but these
things need to have very strong arguments.

"One extra argument" that could be hidden by a macro or a helper
inline is simply not a strong argument.

                      Linus
