Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EFDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39232075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVeu1mni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39232075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIGWzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:55:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35102 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeIGWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:55:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so15535892wmc.0;
        Fri, 07 Sep 2018 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=10vE1Rg1a4/Ko7gX6XRid8jQMjfywWxVHkOwK+8YLKE=;
        b=tVeu1mniVl5vubhdp0vaissHPKyNiyvU9KdjQFnPVF3MsWnufrPJ1KNWPMfvSJg/q6
         7REuqCzOm+EqGm43GUJZqBvAIjIfFpLFySWTJdfM0Pr94W+WKkz453N3Kg3IPrhknyxh
         +gkzW8xsfZc4Y4eLfm8KbjvgTURe5EDN1jMwVKwsHaAqGlQ3H5++1+49c8+j2fLQPoxc
         /ttSjGKknpXNJuXQzzyc0a4ZO4HBWlj3pko9GX5zxqfJfgo03+429dIiJoJfdPtjy5GR
         YpaBQyaStzBWHc0ZvW+bH9MRBoYb46M6szSaj3tmawF2uurydrw5dNMYaFYBIq9GC5Th
         olAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=10vE1Rg1a4/Ko7gX6XRid8jQMjfywWxVHkOwK+8YLKE=;
        b=q6wYgrz2hfywuBuw3z1yJqMwr///dKvzBsLz1WK3HZ5atDYfG/cwLp5NCevp+Ufn2g
         RBj1gnOlztHV1vHaVAHJsc/all/Hlw8Q9XmWYYOwXUSR2G+WE+SSUxtKg0YVn+TC/njn
         klBpbrDBAmfM+dclCX8ODwD8Gg/5iT45mtWtqYPgnP5emFa3TAmlqtKSS2QNLoa7NLDb
         IKq3ygJ8wOnRpM50oJwYSGsW6mG4+psZaEE4gk+qx/XiR2MI7gQJTJubjcXQV/vSUJCA
         Vfc0y7FJ9vhixl/yn1zfuTcQULSMjF7SSH6IfJUTA8x3kGvCyWatDpd8k8YLlejJYs14
         tpVQ==
X-Gm-Message-State: APzg51A5ixWmIbHobfwdLIBa9bKL5jfDy/h/QlBIGsvMAupoo/2h/kbI
        inA44rAc64vqxoswd0RlYRE=
X-Google-Smtp-Source: ANB0VdZiah89DwJpCVMMUPcmePphe8hedXMyGAk1nRvi4bUx+p6ViVBiQmk/r6r2VaA+25ZPaQzbsg==
X-Received: by 2002:a1c:a78c:: with SMTP id q134-v6mr5940360wme.42.1536344020106;
        Fri, 07 Sep 2018 11:13:40 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:c856:97f7:a8a9:88f6])
        by smtp.gmail.com with ESMTPSA id c10-v6sm17969030wrb.17.2018.09.07.11.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:13:39 -0700 (PDT)
Date:   Fri, 7 Sep 2018 20:13:38 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     christophe.leroy@c-s.fr, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180907181337.peyfq7yvhahduvmq@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:22:56AM -0700, Nick Desaulniers wrote:
> On Fri, Sep 7, 2018 at 7:34 AM Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >
> > Cc linux-sparse@vger.kernel.org
> >
> > Le 07/09/2018 à 14:22, Christophe Leroy a écrit :
> > > Since commit cafa0010cd51f ("Raise the minimum required gcc version to
> > > 4.6"), sparse check fails as follows:
> > >
> > > [root@pc16082vm linux-powerpc]# make C=2 arch/powerpc/kernel/process.o
> > >    CALL    scripts/checksyscalls.sh
> > >    CHECK   scripts/mod/empty.c
> > > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
> > > old - please upgrade it.
> > >    CHECK   arch/powerpc/kernel/process.c
> > > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
> > > old - please upgrade it.
> > >
> > >
> > > I have sparse version 0.5.2
> > >
> > > What can be done to fix that ?
> > >
> > > Christophe
> 
> Oof, sorry Christophe.  Looks like that's the latest version of sparse:
> https://sparse.wiki.kernel.org/index.php/Main_Page#News
> 
> I'm curious what sparse expands __GNUC__, __GNUC_MINOR__, and
> __GNUC_PATCHLEVEL__ to?  Pre commit cafa0010cd51f, it MUST be
> expanding them to something, otherwise you'd have seen the error then,
> too.  The previous check was GCC < 3.3, now it's GCC < 4.6.

Sparse expand these macros to the same version than the compiler used
to compile GCC. I find a bit strange though to have sparse v0.5.2 but
using an old compiler.
 
Also, it's worth to look at what is said in this email:
  https://lore.kernel.org/lkml/CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com/


-- Luc
