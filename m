Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D060B21546
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aR9vzWVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D060B21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeI1UYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:24:01 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36395 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeI1UYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:24:00 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 320dfc32;
        Fri, 28 Sep 2018 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=w4pl3cZcJHCvoD1JXphNb2Nx4BU=; b=aR9vzW
        Vj7GAnQdR1rjK8W7IHz4ldOBLpAFc9nzmgISfUpmjLJS4AdAHTu0CySFvu638PYF
        UqobQ+ADGXvFXZgJASOFxMN3lMfE3ciissi97uDOvsVWHfLmNJ0/ZZAPXP2zD7Fn
        h1hNcMA/URY2xDG3vxHTovrJ9bVRY4EPgfAQPnFEw3+4MvfpJaIUSPI5ywY7+bLN
        fT21sL5FGPuJKhuxaMDXCai7Wfm44yp7UhZ/th+YI+bMUOrr9lEpZS8hWwpAqi4s
        JMlDxxzMkiT9t9QT/dvJt4zvB5J+j3tVUukzy0qEbAHtA7AgewsgGpuZuJGiaKsO
        oeW190Vp1wj63tiw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e273ed41 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 28 Sep 2018 13:41:16 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id i12-v6so6143367otl.1;
        Fri, 28 Sep 2018 07:00:03 -0700 (PDT)
X-Gm-Message-State: ABuFfoh00KI04DmTJO+XKZSl7jgBj5gxhwWTMCkZqFVafb0ULVfdnKO5
        iyD/7wuqaamx2uE3UGQ7OXZfR1cpLI3zHrItiXA=
X-Google-Smtp-Source: ACcGV60WUbShDfc9/o/xVqQgmjqef9J2GTusR6cHQsMevY08vVOfwZH/JDkpZGN6lz7ypeInvRRjvioiqaoDGCbvcZ8=
X-Received: by 2002:a9d:48ac:: with SMTP id d41-v6mr2148395otf.144.1538143202793;
 Fri, 28 Sep 2018 07:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
 <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
 <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com> <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com>
In-Reply-To: <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 15:59:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com>
Message-ID: <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:58 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 28 September 2018 at 15:47, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > On Fri, Sep 28, 2018 at 10:49 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> >> >> +typedef enum {
> >> >> +       HAVE_NO_SIMD = 1 << 0,
> >> >> +       HAVE_FULL_SIMD = 1 << 1,
> >> >> +       HAVE_SIMD_IN_USE = 1 << 31
> >> >> +} simd_context_t;
> >> >> +
> >>
> >> Oh, and another thing (and I'm surprised checkpatch.pl didn't complain
> >> about it): the use of typedef in new code is strongly discouraged.
> >> This policy predates my involvement, so perhaps Joe can elaborate on
> >> the rationale?
> >
> > In case it matters, the motivation for making this a typedef is I
> > could imagine this at some point turning into a more complicated
> > struct on certain platforms and that would make refactoring easier. I
> > could just make it `struct simd_context` now with 1 member though...
>
> Yes that makes sense

The rationale for it being a typedef or moving to a struct now?
