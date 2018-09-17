Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78982206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vTzYHJhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78982206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeIQVpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:45:25 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35277 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQVpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:45:24 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 47aadfb2;
        Mon, 17 Sep 2018 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=TDAqOAO/9waODShSp7t9TiLTgU8=; b=vTzYHJ
        hb1V+v5HfcHf9M8ZYZC8HYkcHIfRPpZ1lRrn1CiM4iOjl2ogsUbBMg9Ki/pT1n80
        uT5Fx930HLOQY95JPnhigps9l2QjQmFKfp+A2TpzP+JnYKdsH4dgA9DUejQ+zRQ2
        tiVqvUPP0NaQt3bxUMI0kpfEaHz1mbSdhu+JQC4nw36Fd31lueZCtdD+nAYQNEfE
        Wkom0OOY7VChua4VrFVeY2elVP0dlOuYYeIDpoq9OHpJjiW19cwsm8sp2sHyhsRK
        AxHf3JROR0Gvos0q9l/i6hDInVF8MK4vDoW/OCZ4yQE/1jkQ4Jc8hFsQhqH4VXzi
        r56eSRHRkdgEqQKg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 896b6002 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 15:59:53 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id b15-v6so19388297oib.10;
        Mon, 17 Sep 2018 09:17:19 -0700 (PDT)
X-Gm-Message-State: APzg51CVYjyPBeCUp0UL3FQchgBXLF8dLsWz6AyH+taecNJYMh87Ea1+
        g5ovOH3iDdNudMUJ2/xeJ/6dnJaoSXpnkGF9zlI=
X-Google-Smtp-Source: ANB0VdZlEWXv9vWkxyAe1v9UjW8azrwlAHSxUyr1MSia1SmAhmi6ylh3k+dIRH13s+0t1wKOPjrwO5JVhTQWjiK6wA4=
X-Received: by 2002:aca:d4cd:: with SMTP id l196-v6mr18177363oig.15.1537201038879;
 Mon, 17 Sep 2018 09:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
 <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net> <CAHmME9qQR4ynsZ5xXejEdnr3oZcOnpRRTdohX+eT9Df+AU2_iA@mail.gmail.com>
 <CALCETrXXg_nnp_pafK3+Pwd00PRUr=X=WfLu+YFYeggRs8-i1Q@mail.gmail.com>
In-Reply-To: <CALCETrXXg_nnp_pafK3+Pwd00PRUr=X=WfLu+YFYeggRs8-i1Q@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 18:17:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9qjZw-hmTtBC0f4mCz_ERMZaYqw6gOa+04mXPju-X2Hsg@mail.gmail.com>
Message-ID: <CAHmME9qjZw-hmTtBC0f4mCz_ERMZaYqw6gOa+04mXPju-X2Hsg@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 6:06 PM Andy Lutomirski <luto@amacapital.net> wrote:
> #ifdef CONFIG_X86_64
> #include "whatever"
> #endif
>
> It seems a more obfuscated than needed to put the equivalent of that
> into the Makefile, and I don't think people really like searching
> through the Makefile to figure out why the code does what it does.

Okay, I'll change it back to ifdefs for v5.
