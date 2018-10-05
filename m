Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9614AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD4F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4fw5pRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD4F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeJEUg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:36:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJEUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:36:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so1910056wmf.1;
        Fri, 05 Oct 2018 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK6EzRMfaUabjqoYDvuZwU1hNBWygeF3CXtM6oIARAU=;
        b=V4fw5pRZwFnS7+9akPGvQviwOA97TEu23OyA6xURDRXNCEpN1sJH0GWjGeJyp7bQ5C
         ELOk6jkXsBcOJ5ZX1x/5gBJkIi97589PRD9vWOZEhODq+AXRLD6egbT5yiIkaOBOiswi
         piC+ZNUOvj1g32JSCuGhqpRhm7hfeaRUJSKKh8Nkl7pJAtVmYonWCmYAqyCSVpqfOWQO
         XIaY3TZahti4B7B5p2Od9kH1oEmn44XDChfrnZpMxzofsBp6c+I6uVACaR4cpd869Fid
         kQggwVLfDEx0KpQ6QgOwLS3FWUumoCzN3WrwHrnOPeJ3Gq2oE/MByrL4oLqJAdtdffbn
         jYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK6EzRMfaUabjqoYDvuZwU1hNBWygeF3CXtM6oIARAU=;
        b=KfOkfAv69+hncgymFABBZ8gK5s4asMPuO29IPE1dD5OCqr7sB70HB+5K2xtEIYCY6i
         7hOyaiKQyYlot1OqgKKabycitC9fMdkobRpc+nQ9BJ9DMt5PN8bbY+ZYW13+EaUH/Z+k
         y+vxznEDVMytgjPeHDGeAYeQ5IoehBdDgtMhG3Y5ZFObEFzNKnXD/uCPlJuZByPPR5Vo
         CA9MWd98b73xggkosgs1SceVehLcgZlqT5J9ZuXjOCdkZCeHGhWCM8lwYkCrfx1498x1
         WXETuTOqMBfxQQ/4bDjIluV/ZxUnq/FGoZaYOLMpuoGBy7D6v7GVs90sOgd9aULjc3WS
         DAwA==
X-Gm-Message-State: ABuFfohft8Zsnsxm9TbbNgJk8ySKXBU1kIELb4F+4dkomJGX5IEUzYDb
        1KhuoZA8aZXKH49Cudz/JCoHViWcl0lspjiHIXw=
X-Google-Smtp-Source: ACcGV63VObnJ2eOxo4OjLpmDeg+gDfVa/2wwReYj13Cf7cmz1F4aDUgaHs6aDtIgpPYlIBRl/kjhEzyy9QNaDLQkfOs=
X-Received: by 2002:a1c:8fcc:: with SMTP id r195-v6mr8178820wmd.44.1538746689285;
 Fri, 05 Oct 2018 06:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au> <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
 <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
 <CAHmME9r6-DHLwePQGBGcnPUZuZgZ2GtSUX9arsWzLqhKxd=uDA@mail.gmail.com>
 <20181003064951.GC745@sol.localdomain> <CAHmME9ogY=v2Le85+_=-m++RwAzwiUmKyNzx6N2y9Ht-J7xBcQ@mail.gmail.com>
In-Reply-To: <CAHmME9ogY=v2Le85+_=-m++RwAzwiUmKyNzx6N2y9Ht-J7xBcQ@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 5 Oct 2018 15:37:57 +0200
Message-ID: <CAFLxGvw154vyOziRKuFf5-XTa1NcQm5ZVmgUy3=F79k=Rw2dvA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     ebiggers@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 3:14 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Wed, Oct 3, 2018 at 8:49 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > It's not really about the name, though.  It's actually about the whole way of
> > thinking about the submission.  Is it a new special library with its own things
> > going on, or is it just some crypto helper functions?  It's really just the
> > latter, but you've been presenting it as the former
>
> No, it really is its own thing with important differences from the
> present crypto api. Zinc's focus is on simplicity and clarity. To the
> extent that we're at all tangled with the current crypto api, the goal
> is to untangle as much as possible. It intends to be a small and
> lightweight set of routines, whose relationships are obvious, and with
> this direct and to the point organization, as well as work with the larger
> cryptography community and with academia to invite collaboration. With
> this comes a different way of maintaining it, with higher standards
> and a preference for different implementations than the current
> situation. With Zinc, you have an obvious series of C function calls
> composing the whole thing, without complicated indirection. It's
> something that could be trivially lifted out into a userspace library,
> and used broadly, for example -- something I'll probably do at some
> point. That's a bit of a design change to the current crypto api, and
> sprinkling some direct function calls within the current crypto api's
> complicated enterprise situation would only kick the can further down
> the road, as much complexity would still remain. The goal is to move
> away from behemoth enterprise APIs, and large and complex codebases to
> a simple and direct way of doing things. This desire to untangle, to
> start from a simpler base, and to generally do things differently
> means it will go into lib/zinc/ and include/zinc/ and have different
> maintainers.

So we will have two competing crypo stacks in the kernel?

Having a lightweight crypto API is a good thing but I really don't like the idea
of having zinc parallel to the existing crypto stack.
And I strongly vote that Herbert Xu shall remain the maintainer of the whole
crypto system (including zinc!) in the kernel.

-- 
Thanks,
//richard
