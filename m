Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B85ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22022098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JspcNq+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22022098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeISJtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:49:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34357 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbeISJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:49:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so2084161pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Vmq0ExtILdmwB6SVnVLapFRWujxeBztuCDjeMPNy2AM=;
        b=JspcNq+eOgeLhT9xg/uifB3o/zQLHpvvHyjjC5A2kyVpwUo1sN2dEix8x4kIMSjY7u
         ElGx5DXWWKPIzA1y64vC9zO0VFIviBF3AmEaBvOPez2hc0c8VeaaTslArSK4g0g+TgE4
         PNazxCaKF2yAu1vzk+jVQO2u/bI3Ny8nCuwhbVhvgdcGehx3v3SleZ0K+tQ8WeCo4mpj
         bhurhtYLn6zdNrKnL94xtW/v4gakaRi4cXkJmA3+kyVTzQmUT9+BF9HCYTLNtEeWHPmm
         ijiVHue1Xxm4O6u2qyh2aydrwOHGkLXjnlp6cXZEeOY4xwrSwaeU45+ma0MDs8jml5Fu
         LBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Vmq0ExtILdmwB6SVnVLapFRWujxeBztuCDjeMPNy2AM=;
        b=AXZFL4Vwx26HcAxlJYx8K/SaPfrtT+elAxLrlrYaEgsQ33khDTXy6WT9TvorMEK4f3
         6aNGWy8iukA9miWwYnMZWQy0JScWZMHyaBxQn2x6j1FFVhSnbjhyOFgOMu8CN8Lh0XlB
         PWDum3+h5jM3seN9ad3kLVJr8TpFVLE0GJA2qOzxchA3dS2gt/C+jvBEv4AIfQEa3SXN
         HGJhtMcd6E5kHThXizvggUN7okRIXOq0LIcSHSNNJQRSi38UyQGX2vRksRQV+PeCOA0M
         E5kAFBNtxYiqIjpZHHWVz81iRO+jEDmne7cMggpinGp5wPJWFB7EYIoF8kciRUzASn3S
         88tw==
X-Gm-Message-State: APzg51COvpcB2yICqz8FlhHqzJdeXLIM/tIC+QhW+M2e1F6NkzAf5xus
        qnN5mwDDhfwJ8GSMXEUY5zuyiBkuM0U=
X-Google-Smtp-Source: ANB0VdZAvCLafZ+rL1c7xLo8uKL+/KA0UO+KMagIU1bAHytIOdFQswOzi45PBPxgv+WlcAVdStoVew==
X-Received: by 2002:a65:62d8:: with SMTP id m24-v6mr30332727pgv.307.1537330386940;
        Tue, 18 Sep 2018 21:13:06 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:2891:46e6:aad6:73f9? ([2601:646:c200:7429:2891:46e6:aad6:73f9])
        by smtp.gmail.com with ESMTPSA id v8-v6sm24525521pff.120.2018.09.18.21.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 21:13:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v5 07/20] zinc: Poly1305 generic C implementations and selftest
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAHmME9oL98adRp6xXqaXxA0E4Oa4ecPW+JHChCS3hTgH7RLPjA@mail.gmail.com>
Date:   Tue, 18 Sep 2018 21:13:04 -0700
Cc:     Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF781C43-52C2-410A-A6D0-AAD0AC998C2D@amacapital.net>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-8-Jason@zx2c4.com> <20180919005054.GC74746@gmail.com> <CAHmME9oL98adRp6xXqaXxA0E4Oa4ecPW+JHChCS3hTgH7RLPjA@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 18, 2018, at 6:35 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
>> On Wed, Sep 19, 2018 at 2:50 AM Eric Biggers <ebiggers@kernel.org> wrote:=

>> Hardcoding the 'input' array to 600 bytes forces the full amount of space=
 to be
>> reserved in the kernel image for every test vector.  Also, if anyone adds=
 a
>> longer test vector they will need to remember to increase the value.
>>=20
>> It should be a const pointer instead, like the test vectors in crypto/tes=
tmgr.h.
>=20
> I know. The agony. This has been really annoying me. I originally did
> it the right way, but removed it last week, when I noticed that gcc
> failed to put it in the initconst section:
>=20
> https://git.zx2c4.com/WireGuard/commit/?id=3Df4698d20f13946afc6ce99e98685b=
a3f9adc4474
>=20
> Even changing the (u8[]){ ... } into a (const u8[]){ ... } or even
> into a const string literal does not do the trick. It makes it into
> the constant data section with const, but it does not make it into the
> initconst section. What a bummer.
>=20
> I went asking about this on the gcc mailing list, to see if there was
> just some aspect of C that I had overlooked:
> https://gcc.gnu.org/ml/gcc/2018-09/msg00043.html

Can you not uglify the code a bit by using normal (non-compound) liberals as=
 described in the response to that email?

