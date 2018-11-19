Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FF420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wb6MBYuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FF420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbeKTJlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:41:31 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:40925 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730692AbeKTJlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:41:31 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b7b625ea;
        Mon, 19 Nov 2018 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=DmEy4hyMMU2bsk8BSN+IOFgj+ZQ=; b=Wb6MBY
        uMiQeu57hdYKhjTQXawAmnwAUij1po/tezOFBEf/KhFMtclWBRQdDxjKCnyJ9uE7
        hLt9upFU060RjApCughsx/dIwGQFf7aB9t8Y3TPKTj9HSQ8dhuQr8hKOlicMsw1R
        ppfFFROuMyXRv5XiBj6+SitbPHHHaCJ5WeInGXVLkBS1MZV/RUZGJbm2IXFRKvX/
        25yHabJ9GCF7yzQ3DuFjup+LJIiS42zPQYiqY1tdDhIo2vvqWlGAai2FjKx1+2UX
        UkXb1rBcoHZCJsHj6odaCU3jJ+TUH92z3M/zbqYJTxcCOVPoAgWbMu0oczXz+rof
        Yjy8d8dkEg/zyyJg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3d632564 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 19 Nov 2018 23:09:26 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 81so27902otj.2;
        Mon, 19 Nov 2018 15:15:29 -0800 (PST)
X-Gm-Message-State: AGRZ1gKx7Guhu8a+ZnZw5ydHpfynxlLTZVb2WSz37z+aRH1ahMN8EMe5
        62UWvjNJzbzjfsnPd6IfN9Yom0I+7Gdj5s1x7bQ=
X-Google-Smtp-Source: AJdET5faivw9IJhSeKkwQdNKDnOKxTZ/tGyx2pOiIdPmoHMltEcUqrNvGSDYEgEtrC6+x9IKmrTpmwa3TYEHttug/yQ=
X-Received: by 2002:a9d:12e3:: with SMTP id g90mr10437983otg.223.1542669328537;
 Mon, 19 Nov 2018 15:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20181105232526.173947-1-ebiggers@kernel.org> <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com> <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com> <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au> <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
 <20181119225414.GB258711@gmail.com>
In-Reply-To: <20181119225414.GB258711@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Nov 2018 00:15:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9okRjuYUiL0D=6ZmtMX6rvxU+0xvy2tva+LetjU9itx8Q@mail.gmail.com>
Message-ID: <CAHmME9okRjuYUiL0D=6ZmtMX6rvxU+0xvy2tva+LetjU9itx8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] zinc chacha20 generic implementation using crypto API code
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, Nov 19, 2018 at 11:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
> Will v9 include a documentation file for Zinc in Documentation/crypto/?
> That's been suggested several times.

I had started writing that there, but then thought that the requested
information could go in the commit message instead. But I'm guessing
you're asking again now because you poked into the repo and didn't
find the Documentation/, so presumably you still want it. I can
reorganize the presentation of that to be more suitable for
Documentation/, and I'll have that for v9.

> I'd still prefer to see the conversion patches included.  Skipping them would be
> kicking the can down the road and avoiding issues that will need to be addressed
> anyway.  Like you, I don't want a "half-baked concoction that will be maybe
> possibly be replaced 'later'" :-)

Okay, fair enough. Will do.

> Either way though, it would make things much easier if you at least named the
> files, structures, constants, etc. "ChaCha" rather than "ChaCha20" from the
> start where appropriate.  For an example, see the commit "crypto: chacha -
> prepare for supporting non-20-round variants" on my "adiantum-zinc" branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=adiantum-zinc&id=754af8d7d39f31238114426e39786c84d7cc0f98
> Then the actual introduction of the 12-round variant is much less noisy.

That's a good idea. I'll do it like that. I'll likely order it as what
we have now (renamed to omit the 20), and then put the 12 stuff on top
of that, so it's easier to see what's changed in the process. I
noticed in that branch, you didn't port the assembly to support fewer
rounds. Shall I follow suite, and then expect patches from you later
doing that? Or were you expecting me to also port the architecture
implementations to chacha12 as well?

Regards,
Jason
