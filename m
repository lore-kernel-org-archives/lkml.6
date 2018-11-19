Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA00C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBAA20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UPFQlysV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBAA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbeKTJ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:57:21 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:48171 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeKTJ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:57:20 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0eac1a5b;
        Mon, 19 Nov 2018 23:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=cKVEK2BpZngHHw5DaDCv65+IbGA=; b=UPFQly
        sV5PvA/adwO6oEIlC9gKkVG+lGgzbopMWW37tgROEwtIKPQ5h2vZ3rU45ijA+nuF
        Mp4PeixVRuDIdPsjHk9nxqbaEhe/P3jsXyl60+rJuVERY5X+JQ1Xjb24GUzqsCN1
        eRvScZn0lvzQhGjJaL2bCpKwympfMUE5FtpY12ut6muDzOLunKAeNjHunJanQkh8
        uSlzEAVvvSUb4/6DurOpWY6mXzI+iGx3QFkZuRvmziPdZsQUqa6OLnVJMnSTFKps
        NVl7U1EEVUE/hOXUaO7gRlqjRTzMFDYbn+rzlRXTko6UHzvm7tFQk6QLA6M0sxHt
        Yl+cGfcUfRrK/usw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5d5ebf7e (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 19 Nov 2018 23:25:12 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id g27so40032oth.6;
        Mon, 19 Nov 2018 15:31:14 -0800 (PST)
X-Gm-Message-State: AGRZ1gJz/5qzyRpelrsqfAnehK/k3sRpiyAVn0EoQ47DDPHDNsz9p747
        q4ubL8Fth6pWyjglsgCFBjcU2EsPWDIWvTMq554=
X-Google-Smtp-Source: AJdET5cGvuGsWIIWxtT+74MKZp2D1tsT9DwqMrFMSlch2KZ3ODxGrFoca0bMYupwOw3zAqPyDMDExZMHyLGYsfcdoGY=
X-Received: by 2002:a9d:837:: with SMTP id 52mr13699497oty.143.1542670274157;
 Mon, 19 Nov 2018 15:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20181105232526.173947-11-ebiggers@kernel.org> <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com> <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com> <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au> <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
 <20181119225414.GB258711@gmail.com> <CAHmME9okRjuYUiL0D=6ZmtMX6rvxU+0xvy2tva+LetjU9itx8Q@mail.gmail.com>
 <20181119232345.GC258711@gmail.com>
In-Reply-To: <20181119232345.GC258711@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Nov 2018 00:31:02 +0100
X-Gmail-Original-Message-ID: <CAHmME9o9N0r55i4zHu5p-9wcKPsfVVhRC+kbzx0TYxSTZG5kbQ@mail.gmail.com>
Message-ID: <CAHmME9o9N0r55i4zHu5p-9wcKPsfVVhRC+kbzx0TYxSTZG5kbQ@mail.gmail.com>
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

On Tue, Nov 20, 2018 at 12:23 AM Eric Biggers <ebiggers@kernel.org> wrote:
> It's much better to have the documentation in a permanent location.

Agreed.

> I actually did add ChaCha12 support to most of the Zinc assembly in
> "[WIP] crypto: assembly support for ChaCha12"
> (https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=adiantum-zinc&id=0a7787a515a977e11b680f1752b430ca1744e399).
> But I skipped AVX-512 and MIPS since I didn't have a way to test those yet,
> and I haven't ported the changes to your new perl scripts yet.

Oh, great. If you're playing with this in the context of the WireGuard
repo, you can run `ARCH=mips make test-qemu -j$(nproc)` (which is
what's running on https://www.wireguard.com/build-status/ ). For
AVX-512 testing, I've got a box I'm happy to give you access to, if
you want to send an SSH key and your employer allows for that kind of
thing etc. I can have a stab at all of this too if you like.

Jason
