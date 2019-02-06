Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EBAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C033C218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMgk+pnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfBFQbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:31:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40008 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfBFQbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:31:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25-v6so125049ljk.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vWkxmj9oWLrggUv+QTuu3iX5qrC5YTFQd8nT7R1idA=;
        b=NMgk+pnk+1Q5qb1JNI0hRVsCcAbFJDOEO6vVkVOVKPbkcyTjTNFhExv1CGZmCOLY/P
         nqL8ifj6nOjE0goo4gzWQYleZceJcA6c+VIZqlwfGnyC+hq68VTtiJVIyqv58VOnz0Do
         IsxBIVlTjAOm41unDLC4x/bYx4p5OdFqh2bK1nYM8Yu9819FZtAhIacWY5gaqerep+Ka
         hiPTNO/I8HSgd+seBERLN3T8BRWI57vv0B+xJDJ5rmG3+wyXrEMvRQOKUN3TQXPGVZ8Z
         0smdfe8eAFJ9cnnTOvGpQzO1Sbf/tjrsWVc4kdoyUdhnd2CYcE7wpX38khW05CMgRuo6
         2vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vWkxmj9oWLrggUv+QTuu3iX5qrC5YTFQd8nT7R1idA=;
        b=PcHfvH/LII57tPhPXgc4T/zUn9LttkTxLUKiojPBSFbrgR1pBRAMNmUVy7MnHSwI5i
         gRN0b3U/X7GNPOCNe0HMIHwEKMRgBdVWowh/eA710wJLByhh8n9Q82Hw3BVY8b5T5Uos
         bS+bnF4yw3aWLBPhzkScrkQ1zXzGE+2ZPrJCQSOQMfv67lExWdcVhrhaQkJoCFnY0uIq
         0RbGJP9G07vYwHL+vOZBgBny+yJCO06fom91NlpCBLt4lqMtHiqsgSFE4WKVmTGvpkTP
         M9NeLO3bLUG9faOwdWYsRgO3Zo13ydKJxRuM47uK/r0J9AUI71Waj81phW+YK19Yhcmf
         2/tg==
X-Gm-Message-State: AHQUAubTu22RC70RnuRMq0eGjBjMklK6qVV/V0so151tVJYAwqpyEAIu
        Q3qjzFRN6Ulvxt79y09O+MdLoNQnPVw12hieDQqbzY6fwk4=
X-Google-Smtp-Source: AHgI3IZE3MgPMr8OFkFlsThjegYnSX5WvWxuH4yu+/BGMxsN7is6hUlTrM0iR+yZYiX+LKdTr+YXi7VONZjCmrFDcuY=
X-Received: by 2002:a2e:9681:: with SMTP id q1-v6mr6929616lji.182.1549470695597;
 Wed, 06 Feb 2019 08:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20190123173707.GA16603@gmail.com> <20190131142221.GA26303@linux-8ccs>
 <CANiq72m8VuD_dsA+=0q88FRJgVnnSS1pt1SAFf9upGS7RFjT_g@mail.gmail.com> <20190204150852.GA24444@linux-8ccs>
In-Reply-To: <20190204150852.GA24444@linux-8ccs>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Feb 2019 17:31:24 +0100
Message-ID: <CANiq72=cK0oMFtMejAsphNyJmQ8KvG5=70Gyt7idbvp4ScoxgA@mail.gmail.com>
Subject: Re: [PATCH] include/linux/module.h: mark init/cleanup_module aliases
 as __cold
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 4:08 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> IMHO I think annotating with __init is more straightforward, instead
> of cherry-picking attributes (we wouldn't know at first glance why the
> aliases are specifically annotated with __cold without looking at git
> history). Plus the actual module init function and alias declarations
> would be consistent. Just looking at the __init attributes:
>
>     #define __init              __section(.init.text) __cold  __latent_entropy __noinitretpoline
>
> __section(.init.text) - alias already has same section ndx as the
> target symbol so this doesn't have any effect.
>
> __latent_entropy - according to commit 0766f788eb7, if this attribute
> is used on a function then the plugin will utilize it for gathering
> entropy (apparently a local variable is created in every marked
> function, the value of which is modified randomly, and before function
> return it will write into the latent_entropy global variable). Module
> init functions are already annotated with this since they are
> annotated with __init, I don't think marking the alias would do any
> harm.
>
> __noinitretpoline - compiled away if the function is in a module and
> not built-in. The alias is not utilized if the module is built-in. So
> this wouldn't apply to the alias.

In that case, there is also the option suggested by Martin: using the
new "copy" attribute which copies all attributes, except those
blacklisted by GCC, at the moment:

    alias, always_inline, gnu_inline, ifunc, noinline, visibility,
    weak, weakref

Since we have the __init macro, there is not much gain in this
instance (but if you prefer the copy alternative, let me know).

> Unfortunately I don't have gcc9 set up on my machine so I can't
> actually test if it gets rid of all the warnings, so testing this
> would be appreciated :)

The warning triggers currently for a subset of attributes only:

    alloc_align, alloc_size, cold, const, hot, leaf, malloc,
    nonnull, noreturn, nothrow, pure, returns_nonnull,
    returns_twice

So the rest of the attributes do not make a difference w.r.t. the warnings.

I will change it to __init then and send the PR after a couple of days
in -next :)

Cheers,
Miguel
