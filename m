Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E85E214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ph1VhSwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E85E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeIQVoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:44:32 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40865 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQVoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:44:32 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c4c421a1;
        Mon, 17 Sep 2018 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=22QLD/q5h6ppBKNB7/8qWa7Ng4E=; b=ph1VhS
        wdbpdQjzIt68yrLA1Cb3a6KK7M7uVtGu8xmWgT30NM8o/OEsiChtyFADsF1vyIaA
        XNLSmUNb8FQsWOlUVLatU98azNwgCLQvhdlPESncOQ1zSTIkhxZ/b5Hetcq/b7ll
        u+6umD22zXlsn5idKfHLU8QWK+EtBpqrUq/ONg05os4OFUMAanXD2giOK8VZCJar
        lBZAp3gA/30CtUhf/PJvDpLAhoyTCL4G8geM1Zq/NWR0mzk8O/H8V+AlFt/F0xBu
        YiJuGWi7ZoWsATyJ9d11HgL4AlEDEeX1aJEURui1/0Dyy5c6CgjRoekvjtLYajhf
        S9NeH+Mc+cZNSA4w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d71bd556 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 15:59:00 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id a19-v6so11884011otl.12;
        Mon, 17 Sep 2018 09:16:26 -0700 (PDT)
X-Gm-Message-State: APzg51Ant7T240+w7fb4LA8DwjR2LH2T9Tr2mg10uFyRDOpGVlAfz1XP
        dm5vMR+09cyB5fdocW6PbjxKuwf7LjLGKGlnmyo=
X-Google-Smtp-Source: ANB0VdYuW8DXHGaBV09GEZZiLYhTrVEqPDv83Fa7ACN4ZPEKiXky7IKWjug6vnRdx6WZvPcGAUOTkQGgpzHBlMJZ+14=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15-v6mr13595546otf.138.1537200985969;
 Mon, 17 Sep 2018 09:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
 <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net> <CAHmME9o2sB-rQo0DRh56AFe7ZLJJh+CU6Z1m5XZ4tA8vATCy1g@mail.gmail.com>
 <CALCETrWHWZibRev=hZeE1_YFjktnpV9VBN_QmvHJfakb-saRuA@mail.gmail.com>
In-Reply-To: <CALCETrWHWZibRev=hZeE1_YFjktnpV9VBN_QmvHJfakb-saRuA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 18:16:10 +0200
X-Gmail-Original-Message-ID: <CAHmME9o+Q25t8c2Yk5_5ob2yJsu=7OA7WeAM71S5krP8KMY5GQ@mail.gmail.com>
Message-ID: <CAHmME9o+Q25t8c2Yk5_5ob2yJsu=7OA7WeAM71S5krP8KMY5GQ@mail.gmail.com>
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

On Mon, Sep 17, 2018 at 6:14 PM Andy Lutomirski <luto@amacapital.net> wrote:
> Indeed.  What I'm saying is that you shouldn't refactor it this way
> because it will be slow.  I agree it would be conceptually nice to be
> able to blacklist a chacha20_x86_64 module to disable the asm, but I
> think it would be very hard to get good performance.

I hadn't understood your nosimd=1 command line suggestion the first
time through, but now I see what you were after. This would be really
easy to add. And I can do it for v5 if you want. But I'm kind of loath
to add too much stuff to the initial patchset. Do you think this is an
important feature to have for it? Or should I leave it for later?
