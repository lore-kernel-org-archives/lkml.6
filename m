Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3797C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F5A205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAX1yECj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfBNA0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:26:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38695 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBNA0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:26:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so2019462pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Owq3oTwBjNNWgPEI9Iu9WeIndEYXNUcW4ioW388h7rU=;
        b=KAX1yECjj/AZld0F/6clNhqkvErUzzvuN57oJ/dJO6chOBe7IDDgdRBPJKSdlljMjn
         6HgYgm+Efm0OXVOEaF5uty5Z8RhxVYAvZTXAyjXMkzmmmsy7TBJpdAVGyl6VIH3GfSdL
         ChZUNN+LqXWAGgvWvHvksccU9Z5XIlLcDPKdqXEQCH/2QjgmuwO0+leFAH0d0usoasCH
         caLe5eXq+ORpVjku1oPT/ctAFQywYluGEA1OP6OfYrIwHRHAwRyg5shV8Cgq8zamM7d+
         Qnkmgy8+/XIffFydQr3ZO2NFFI2Bptu6YUYcqvJ8RY0y9K+EA4WkIxmc0d4LqnDZUeGP
         ILAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Owq3oTwBjNNWgPEI9Iu9WeIndEYXNUcW4ioW388h7rU=;
        b=sn31eTS9Ztp3+W5DhZIChvskll5TVa7NZzEhBF4ShUK0pGxQ5B1KWZdGI3k+QP38vy
         gW+e+VepJ1d7wGGLM3yHbd8GB3iA6ptUsxBffvtjnyNpkjNAWTyBkEa6IunL26cbHs/M
         4BjBYTVqDDLNGuP1Hp29gYXNHT9bRE7RFbeZeShCiOODmUdA8QH/oun2m1dqqaTOli4q
         UpT6IHuCU/MTQBpCRP23H3S/CV5m937FeF9Ai8WKWufPXOkQs6beOpExB+sfeGKKa7pb
         dXzTzoU0svnzvuH2i1slCV01l70Hp6IGN7FdlP2Ed+P8hzrmkjJ8EmKjsreUMIjzXJZh
         G9JA==
X-Gm-Message-State: AHQUAuaY1OROygkbKJ5CqPisqn504QdwWGyDPSjvcxNR3XszvFtf8bsZ
        LQLxMg3AkX8UZZxPNqC0dLCYSdBAZDdqaVzwZsx/uQ==
X-Google-Smtp-Source: AHgI3IaSRScbdiv8Ar/Gk14E+aDZkPswmvEJvq/NTNz5uyqcJNwNJJoEEjqn/PD+IxrQlrKOjyxPzqQGVy+wPpzMWsQ=
X-Received: by 2002:a63:7044:: with SMTP id a4mr874989pgn.359.1550103977952;
 Wed, 13 Feb 2019 16:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20190213020550.82453-1-cai@lca.pw> <CAAeHK+w-EWDivYTNiUAeSUVZVGOpUyxbbcC8_nMM1=CcpsJ9Ug@mail.gmail.com>
 <1550092329.6911.35.camel@lca.pw>
In-Reply-To: <1550092329.6911.35.camel@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Feb 2019 01:26:06 +0100
Message-ID: <CAAeHK+wTcx+mk7ccLG-RtyO6X7TpYp1_BnuP8jBaS4KbGeb70w@mail.gmail.com>
Subject: Re: [PATCH] slub: untag object before slab end
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:12 PM Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2019-02-13 at 11:31 +0100, Andrey Konovalov wrote:
> > On Wed, Feb 13, 2019 at 3:06 AM Qian Cai <cai@lca.pw> wrote:
> > >
> > > get_freepointer() could return NULL if there is no more free objects in
> > > the slab. However, it could return a tagged pointer (like
> > > 0x2200000000000000) with KASAN_SW_TAGS which would escape the NULL
> > > object checking in check_valid_pointer() and trigger errors below, so
> > > untag the object before checking for a NULL object there.
> >
> > I think this solution is just masking the issue. get_freepointer()
> > shouldn't return tagged NULLs. Apparently when we save a freelist
> > pointer, the object where the pointer gets written is tagged
> > differently, than this same object when the pointer gets read. I found
> > one case where this happens (the last patch out my 5 patch series),
> > but apparently there are more.
>
> Well, the problem is that,
>
> __free_slab
>   for_each_object(p, s, page_address(page) [1]
>     check_object(s, page, p ...)
>       get_freepointer(s, p)
>
> [1]: p += s->size
>
> page_address() tags the address using page_kasan_tag(page), so each "p" here has
> that tag.

Ah, I see what the issue is. With those 5 patches page_address()
should return 0xff-tagged pointer here, but when we set_freepointer()
the tag indeed might be different. OK, I think that patch that you
linked below is the better way to deal with this. I've added a
detailed comment to it and sent it.

Thanks!

>
> However, at beginning in allocate_slab(), it tags each object with a random tag,
> and then calls set_freepointer(s, p, NULL)
>
> As the result, get_freepointer() returns a tagged NULL because it never be able
> to obtain the original tag of the object anymore, and this calculation is now
> wrong.
>
> return (void *)((unsigned long)ptr ^ s->random ^ ptr_addr);
>
> This also explain why this patch also works, as it unifies the tags.
>
> https://marc.info/?l=linux-mm&m=154955366113951&w=2
>
>
