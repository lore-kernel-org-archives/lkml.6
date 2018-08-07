Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2988E2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EMJRPpBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2988E2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbeHGVJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:59 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:49161 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388940AbeHGVJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:58 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e7308e30;
        Tue, 7 Aug 2018 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=cnVgRP4U+0C9t8ZXR6+0RMEJzZA=; b=EMJRPp
        BoYWPPluvcOBjhPwO6oLEsdi/7KvTO9h63kZStmQcwijIY7Rt2MCfjEy6laPQuFW
        wozmz+9jwApsFEYf7p41jzvhCNHmRurq9fKp0n/Jax+duyNgJT6ovMe4QPBCFYeB
        j+4Nmrt6B9Zp3Fg6sEanI2DTJ4x+jPtRgJm1ktwFG0OOkQ1ZN/NGwOUvCAYshhs3
        78rO0WcRl7XswbZaJn9/SBK2dYWVfnOH62H9q4S0+R/B7jTA6hYdEzKYZm7aLgve
        pcEX9KIt50v/i4G9fi9huWv4YAgRhOJShD+gzqqNJOp2w1i81kvwMaG2+glk93to
        Ga2KkdYDZsBTeCJQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a11d3345 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 7 Aug 2018 18:41:59 +0000 (UTC)
Received: by mail-oi0-f43.google.com with SMTP id w126-v6so30296025oie.7;
        Tue, 07 Aug 2018 11:54:13 -0700 (PDT)
X-Gm-Message-State: AOUpUlHYU+ovrCtRuYXs5tl4ohJNu1znlIyv8g8VhsKVGOPK1qdt6L0n
        0UXjA9SeTVktaxPqGrntSjn6h9MLy7PBYJaYvxg=
X-Google-Smtp-Source: AAOMgpdUWGmPlRCCEM/bHczHQrKayMv64M/e2ukBMjpW1+o3X2bo1roKM2RaGUKT5jZkQaFtnNvx1qf8bFJJTrr6Q5g=
X-Received: by 2002:aca:f189:: with SMTP id p131-v6mr19306300oih.14.1533668052973;
 Tue, 07 Aug 2018 11:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com> <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
In-Reply-To: <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Aug 2018 11:54:01 -0700
X-Gmail-Original-Message-ID: <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
Message-ID: <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>,
        Eric Biggers <ebiggers3@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy, Eric, & all,

I've started the work of separating this out into 16 individual
commits, have addressed numerous other things brought up like the
ifdef maze, and have begun rewriting (parts of) the original commit
message. It's still a work in progress, and I still have some work to
do, but if you want to follow along, things are happening here:

https://git.zx2c4.com/linux-dev/log/?h=jd/wireguard

I'll be rebasing and reworking this continuously, but that's how it's
shaping up.

As I'm still working on it, I won't be submitting v2 today, but if you
have suggestions or concerns or want to poke me while I'm working on
v2, don't hesitate to send me private email or ping me in IRC (I'm
"zx2c4" there) to chat.

Regards,
Jason
