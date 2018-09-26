Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1275DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDEB2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dk2E52ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDEB2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeIZX3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:29:32 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35018 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIZX3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:29:32 -0400
Received: by mail-it1-f193.google.com with SMTP id 139-v6so3935801itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dbGDkCaAXKyVAl5Mu41yEunqB/fS6udM8rTz1ifZdoI=;
        b=dk2E52ER/vRG5UAAYi1lfw1+vdGp2CSJIyV8jFKmYoNidvcwJSGhjYDOgFvJsOpkLh
         aTi9+jUFDI1lL9qPB4+0JT6yvQroPBM/12RXcxw/xzrPhKmmybEcEjUbfcwgUgtQXjQL
         feN98BdFBlXpRuWkVwBAXJ5pLw4rcSb5FMdx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dbGDkCaAXKyVAl5Mu41yEunqB/fS6udM8rTz1ifZdoI=;
        b=aNnQKwdfoNWkYMU6oxAQJmKpO7L8m0ZLvtNd6iz83EW6JQG5Nx7i8cd7P2JlUIZ9mD
         Hy8J6hwpkzdif5tkqLjGi3/NgJ9Q7JU7Ht+9OrDft/8zenp+xK1Pl2yzZ715t+uEy6Yw
         9LTYsZ+KFobzAvvWO+lX8qhSLwNrBs/0CPDgBg94rPpkbrV9E3ob0CjbB5KHE3GIZgc7
         irc56UYo8ialjfrLXd4VybGV/8jy9nC1xZSDrjlSzZ4S5QMk6hkYlohs7gZ0FUQ/uWGP
         WnidEC+EClriwi7NfeVuyTQFCgh6fnf6GCwC4PRFAuYJ67tZk65NBjM+OWqHt15GvZ3c
         btjQ==
X-Gm-Message-State: ABuFfoh79qGgrAybK3XIj1WZIXkt7dw0lVFwQOpW5jWcHKuOZQFCzK7s
        e6qPuMUArhSwXzVWS8nHI88+LGz9UCRrpesfOlteSw==
X-Google-Smtp-Source: ACcGV63uyDDAqy6SD3JMwTiVdo/Q+FMxz1O9nMpZ/g2cOw4rbrrp54ovww2A2ssUZwKZtkXTK23drVJheTA3i9IaX3o=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr5882084ite.123.1537981723593;
 Wed, 26 Sep 2018 10:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <D93C2C15-DC70-4A95-9350-AD4036C9556A@amacapital.net> <CAHmME9pZKUMnnSZ0670rUH4H61g0x88c-B-DZYw_X-8+xgH-=g@mail.gmail.com>
In-Reply-To: <CAHmME9pZKUMnnSZ0670rUH4H61g0x88c-B-DZYw_X-8+xgH-=g@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Sep 2018 19:08:30 +0200
Message-ID: <CAKv+Gu__KE5taR-w5ZVKySM0zA3Y3tooTi=wvboX07qeWxBxkA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 19:03, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Sep 26, 2018 at 6:21 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > Are, is what you=E2=80=99re saying that the Zinc chacha20 functions sho=
uld call simd_relax() every n bytes automatically for some reasonable value=
 of n?  If so, seems sensible, except that some care might be needed to mak=
e sure they interact with preemption correctly.
> >
> > What I mean is: the public Zinc entry points should either be callable =
in an atomic context or they should not be.  I think this should be checked=
 at runtime in an appropriate place with an __might_sleep or similar.  Or s=
imd_relax should learn to *not* schedule if the result of preempt_enable() =
leaves it atomic. (And the latter needs to be done in a way that works even=
 on non-preempt kernels, and I don=E2=80=99t remember whether that=E2=80=99=
s possible.). And this should happen regardless of how many bytes are proce=
ssed. IOW, calling into Zinc should be equally not atomic-safe for 100 byte=
s and for 10 MB.
>
> I'm not sure this is actually a problem. Namely:
>
> preempt_disable();
> kernel_fpu_begin();
> kernel_fpu_end();
> schedule(); <--- bug!
>
> Calling kernel_fpu_end() disables preemption, but AFAIK, preemption
> enabling/disabling is recursive, so kernel_fpu_end's use of
> preempt_disable won't actually do anything until the outer preempt
> enable is called:
>
> preempt_disable();
> kernel_fpu_begin();
> kernel_fpu_end();
> preempt_enable();
> schedule(); <--- works!
>
> Or am I missing some more subtle point?
>

No that seems accurate to me.
