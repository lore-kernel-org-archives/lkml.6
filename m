Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF2021531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="fXdu9CtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF2021531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeIZXhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:37:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32832 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbeIZXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:37:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so10970403pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kxaaz2RnB8HLkXHCud4XCD1MDycxzcakMk/xAuP1wqg=;
        b=fXdu9CtUBscZaa3jMXn17+bOQg3Haj8YgmM9vqbZgHtoRdFH6+sHLLqsntTUNb5gp8
         QYS7pYlqGvQqfTo7Ns1kl8xvdM0hJ0zqYlovukDfiyQKpadtQkTdCIv87HUGqdNCV2OB
         ViK89blU3fVstB+ONdhQQARUKaZXTYaJtMme5nPq0j20FZcVWzNb0GfltfNF7ZeuoulJ
         BtxUrQknN3wyxx1CS4es8K/NXi0/MjJtGRGEDa9hsh2f235AjRCWcxcpkAG1vjChtcpv
         pJP65DTpovodz20WNLwEPKdK5W0vy3azaEJ0CK6pNJsP48wgRNeVwYQwGsMq9HX0pVaB
         oI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kxaaz2RnB8HLkXHCud4XCD1MDycxzcakMk/xAuP1wqg=;
        b=YwLO9X5nq63pj0cHzyAzHv5GRkUky7jLtK3QzPMMJJuuCRFNz3KjvqwUMwHhKzVocD
         Q8hS/gAhJfq0D6aTiiPR0F01Xi5bgGhat7a+PtP2onul3QYlG1sSSAYEVm3JCtvhyOKv
         127QEJ4ye81tWUlH1gh2sWPgAb6iq7V++4po8ia39vD3YnCzS7SV7GImZECuo+k+gOih
         jrwSJ2ZLkIF9SCVR0few//jU2P9SC2PW1uj/bSyZgX1yDhkOcyh/AYzwx2f/wh6crK8Z
         uw/AwTxYxRJuLSXglCPByO3hfBIZZZogqR41DNKJVJHSgAUIfDsbmF0tlp8knTaJa2dP
         T5mQ==
X-Gm-Message-State: ABuFfoizEIaekiFn/VgFhU806zA6szcmgQmLBi5ud/xhnxuBusaIrVGu
        I0bE2Yo+3x7ahKy37YQ6pHDk8w==
X-Google-Smtp-Source: ACcGV63tX+D8yTaeAIEnZSXmps+A6vcUfVl7r8V+CFninskpZYDbbasjD9GlLk73hLj6COy+IIKvdw==
X-Received: by 2002:a17:902:76c8:: with SMTP id j8-v6mr6977070plt.161.1537982632586;
        Wed, 26 Sep 2018 10:23:52 -0700 (PDT)
Received: from ?IPv6:2600:1010:b05b:ba3d:c4f0:cf46:a1b5:59b9? ([2600:1010:b05b:ba3d:c4f0:cf46:a1b5:59b9])
        by smtp.gmail.com with ESMTPSA id u9-v6sm9460126pfi.104.2018.09.26.10.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 10:23:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <CAHmME9pZKUMnnSZ0670rUH4H61g0x88c-B-DZYw_X-8+xgH-=g@mail.gmail.com>
Date:   Wed, 26 Sep 2018 10:23:49 -0700
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <15747F92-4C04-4550-AF19-2EFDE936920A@amacapital.net>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com> <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com> <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com> <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com> <D93C2C15-DC70-4A95-9350-AD4036C9556A@amacapital.net> <CAHmME9pZKUMnnSZ0670rUH4H61g0x88c-B-DZYw_X-8+xgH-=g@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2018, at 10:03 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
>> On Wed, Sep 26, 2018 at 6:21 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> Are, is what you=E2=80=99re saying that the Zinc chacha20 functions shoul=
d call simd_relax() every n bytes automatically for some reasonable value of=
 n?  If so, seems sensible, except that some care might be needed to make su=
re they interact with preemption correctly.
>>=20
>> What I mean is: the public Zinc entry points should either be callable in=
 an atomic context or they should not be.  I think this should be checked at=
 runtime in an appropriate place with an __might_sleep or similar.  Or simd_=
relax should learn to *not* schedule if the result of preempt_enable() leave=
s it atomic. (And the latter needs to be done in a way that works even on no=
n-preempt kernels, and I don=E2=80=99t remember whether that=E2=80=99s possi=
ble.). And this should happen regardless of how many bytes are processed. IO=
W, calling into Zinc should be equally not atomic-safe for 100 bytes and for=
 10 MB.
>=20
> I'm not sure this is actually a problem. Namely:
>=20
> preempt_disable();
> kernel_fpu_begin();
> kernel_fpu_end();
> schedule(); <--- bug!
>=20
> Calling kernel_fpu_end() disables preemption, but AFAIK, preemption
> enabling/disabling is recursive, so kernel_fpu_end's use of
> preempt_disable won't actually do anything until the outer preempt
> enable is called:
>=20
> preempt_disable();
> kernel_fpu_begin();
> kernel_fpu_end();
> preempt_enable();
> schedule(); <--- works!
>=20
> Or am I missing some more subtle point?
>=20

No, I think you=E2=80=99re right. I was mid-remembering precisely how simd_r=
elax() worked.=
