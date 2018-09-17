Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634BB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Am3u2gNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634BB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeIQVUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:20:42 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60759 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeIQVUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:20:41 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a34a4f54;
        Mon, 17 Sep 2018 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=l8lg6SDSb9McL2SbWSyqSRt8NtM=; b=Am3u2g
        NZwvMqxGwKjWqwPrlRETyIWjgGISN4z/3v0uKpiD3EP9caKkjVDvK0Dv5W5VM6yt
        WZDPNu8UIM328tGnV3WbauVkkldbn01Hk1VZKz+6dqLZq/3cRgWY6T/8v9x1sS9k
        /4fasdQKZBQy8qxP19lkTr1/NGyqzttZFKMyuF2jn/PKt3ihBh31F2/sCDQKShT0
        nZ3vJzaYjAKV12ViAXEXsRU1IXLHYdS4At0XRSLPFIMJOsGHoo7I6dztf/iT/pe+
        kq9zOtF5KH2+3wFvIY3UdWxmg+2dQulAMAW2oONhDglkHEOxnVkZ7Hh24pkxSBu3
        nHb09N8yIhsCqIOg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dceb08bd (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 15:35:16 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id t68-v6so19287898oie.12;
        Mon, 17 Sep 2018 08:52:42 -0700 (PDT)
X-Gm-Message-State: APzg51Addqz2/AxSXLlKfGrRT8mwHUgXlfkT/EVkt3tY6MCSXm4lees8
        DlMrqjQnE+yTkqVieRGv8XRzB0+JiVi1IkiuRAE=
X-Google-Smtp-Source: ANB0VdZPX+VE1SrL1hMFNZDnuQ7GSOvdjfZ1mpSqfLdYUq4dLwnZ8GBtk5KgFMclOzq6+bV4cOV0XkHoxalKZc/TwRo=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr18640746oig.295.1537199561882;
 Mon, 17 Sep 2018 08:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com> <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 17:52:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
Message-ID: <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Mon, Sep 17, 2018 at 7:26 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> OK, so let me summarize my remaining concerns as well. I may be a bit
> more finicky than Andy, though.

Yes, and generally hostile to this whole initiative since the
beginning. But I am very grateful for your reviews nonetheless, and
I'll do my best to incorporate as much as is reasonable.

> I would like to urge Jason to
> bear with us and bring this discussion to a close before resubmitting.

What I fear is that either:
- You don't like the Zinc initiative in one way or another, and the
desire to "keep discussing" and adding more things is less out of
their necessity and more out of a desire to stall it indefinitely.
- You're going to bikeshed and bikeshed and waste tons of time until
Zinc copies lots of the same design decisions from the present crypto
API.

I do sincerely hope these are only fears and not what actually is
going on. I'll do my best to take into serious consideration what you
say -- many are indeed extremely helpful --  but I certainly won't be
wholesale accepting all the things you've mentioned.

Nevertheless, I'll make sure v5 has a pretty healthy quantity of
improvements in it before resubmitting.

> * simd_relax() is currently not called by the crypto routines
> themselves. This means that the worst case scheduling latency is
> unbounded, which is unacceptable for the -rt kernel. The worst case
> scheduling latency should never be proportional to the input size.
> (Apologies for not spotting that earlier)

Good catch. I actually did this correct when porting the crypto API to
use Zinc (in those later top commits in v4), but I hadn't in the Zinc
code itself. I'll address this for v5.

> maintainership
> responsibilities

Samuel and I intend to maintain Zinc in lib/zinc/ and send future
updates to it through Greg's tree, as mentioned in the 00/ cover
letter. The maintainership of the existing crypto API won't change.

> * The current organization of the code puts all available (for the
> arch) versions of all routines into a single module, which can only be
> built in once we update random.c to use Zinc's chacha20 routines. This
> bloats the core kernel (which is a huge deal for embedded systems that
> have very strict boot requirements).

I'll split each Zinc primitive into a separate module for v5, per your
and Andy's desire. And the SIMD code is already toggle-able via a
Kconfig menu option.

> we should
> work with Andy Polyakov (as I have done several times over the past 5+
> years) to upstream the changes we apply to the kernel version of the
> code.

Indeed this is the intent.

> The same applies to code from other sources, btw, but I am not
> personally familiar with them.

Good news on this front:
- Rene wrote the MIPS code specifically for WireGuard, so that _is_ upstream.
- Samuel wrote the BLAKE2 assembly, and he's the co-maintainer of Zinc with me.
- I talk to Dan and Peter a decent amount about qhasm.
- I'm in very close contact with the team behind HACL*, and they're
treating Zinc as a target -- stylistically and with regards to kernel
requirements -- which means they're looking at what's happening in
this patchset and adjusting accordingly.


> * If upstreaming the changes is not an option, they should be applied
> as a separate patch and not hidden in a 5000 line patch without any
> justification or documentation (but Jason is already working on that)

Indeed this is already underway.

Thanks again for your review.

Jason
