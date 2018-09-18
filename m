Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB5ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71310214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RdUuhsKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71310214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeIRG0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:26:30 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37131 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeIRG03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:26:29 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a93489e5;
        Tue, 18 Sep 2018 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=LzT12v5VYxp6
        nqc8E6eoIosiqvQ=; b=RdUuhsKZipRCNkR441zTIv6BXIE7WJ2X37MFOijajP1a
        1Qs8G72fkqIyXT9PcDs20WvEGIVD8rQ9mmsfx8Z3DPajj1k3Yx7b+gxqqVTLyfIk
        +DekPqhJ1+J9XTvYa8PJgV1VED88KQo7Gqv8ygsqf5JMBn+elWNHVP62VVjjgGUi
        7oi22klDKvrnu4EcoxE3h1BPNjwTvxwP7e8bNcY/3cye1O1ZZg3OjDHOmDVGJP/7
        OOfYkEOW69zQcQLZEzeHQcU7hRRtVeaVy68LSn9ccBeRawIUz3PxUQ+85CSe7KsX
        W4+8IZ2raA4eRSDdElTKyDwG6Dp6kEqEv91eI767vg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cdbeb4b2 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 18 Sep 2018 00:39:01 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id k12-v6so187703oiw.8;
        Mon, 17 Sep 2018 17:56:30 -0700 (PDT)
X-Gm-Message-State: APzg51D8U5kK9TXtL4JWMf3Mj5v6ZGiHlp0lVJujiSpKu7jvNY4B3TBG
        C26ST+dBncO3R0aSPMS/cmcMALC22ObNIEZktjc=
X-Google-Smtp-Source: ANB0VdaCRadHgBig9uq6Ul2zSRDobG+dp1n7qug2mTb9yd6u2xc9IVL7+UzTz7lxOVdmiKOO9Ay5xlE03w7TCkEEOOs=
X-Received: by 2002:aca:f58f:: with SMTP id t137-v6mr77734oih.244.1537232189910;
 Mon, 17 Sep 2018 17:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
 <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net> <CAHmME9o2sB-rQo0DRh56AFe7ZLJJh+CU6Z1m5XZ4tA8vATCy1g@mail.gmail.com>
 <CALCETrWHWZibRev=hZeE1_YFjktnpV9VBN_QmvHJfakb-saRuA@mail.gmail.com>
 <CAHmME9o+Q25t8c2Yk5_5ob2yJsu=7OA7WeAM71S5krP8KMY5GQ@mail.gmail.com> <63AAE78E-25D7-46E7-84AB-5D0DFD0F1BF2@amacapital.net>
In-Reply-To: <63AAE78E-25D7-46E7-84AB-5D0DFD0F1BF2@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Sep 2018 02:56:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9pdesobgG=AeZ74Rb+aJ-gGDEYj624MnYDz-A=w9fkiYA@mail.gmail.com>
Message-ID: <CAHmME9pdesobgG=AeZ74Rb+aJ-gGDEYj624MnYDz-A=w9fkiYA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

On Mon, Sep 17, 2018 at 6:18 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> I think it=E2=80=99s fine for later. It=E2=80=99s potentially useful for =
benchmarking and debugging.

I went ahead and added it anyway in the end. It was really quite easy
to do, and it sets a good template for future primitives that are
added to Zinc.

Meanwhile, I've fully triaged the regression Martin found, and in the
same test he performed, the Zinc code now runs faster than the old
code (which should be no surprise).

I've also finished getting rid of -include, per your suggestion, and
modularizing each algorithm to be loadable independently, per your
suggestion.

All and all, v5 is turning out really well, and I'll probably submit
it sometime soon. My tree was just added to the kbuild test bot, so
I'll hopefully get an email about any breakage *before* I submit this
time.

Regards,
Jason
