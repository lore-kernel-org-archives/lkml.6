Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3FC4646D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15231217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vQAEKlKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15231217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeHDAIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:08:25 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55263 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbeHDAIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:08:25 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d77afddc;
        Fri, 3 Aug 2018 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=BQ3yMWvnOBnsgLQUk5Hxul/kO8w=; b=vQAEKl
        Kp/J0b1mkTN3uo9pqCaGh6um+fHQIziUA1ClgzR4w6f0OEFI9OX+l4jWmReILhmK
        5HfAxs5SyRhz6kT/x5+85VbpWXoAq+gbG+63mlXBZHSE2KLex2+wSaVBc7qcOfId
        VaQJ1pwo4Ka37H9yaUtK4bYlQRAi4ga0WfMa3b/jK8ia2q5qvknQc9Rl4LBDKHaL
        +riOi/gjhOn4jVGqZNoy/Xj5S6yRVeBBZc0LRSl84qq1P5BXaSsZpltFnnEUYRqe
        It1YVQnsAFL1Jmja5bjn6tCV2khMdijvC+sLHEnPwFC9j0iiZmey0HanIJuqZKyF
        aqgv6hKm4kIYwQiQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e962cce6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 3 Aug 2018 21:58:29 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id n84-v6so12418515oib.9;
        Fri, 03 Aug 2018 15:10:13 -0700 (PDT)
X-Gm-Message-State: AOUpUlG2K96fnC6hQpUi8pl0/EmASU3qXM3H8ln8HLqEHLCiuizEd8lI
        e2vaPtOz5GAdEEdaissMeTNOUmg75oO2QRVModo=
X-Google-Smtp-Source: AAOMgpeRDGhXdVs0BpIok0Eh1Pau8rfnCo1GLHEEHd30Eh9L+bNWvnbZsGKKQ689aAz87xi0Yt0x0tVcHpNxmnZmg7o=
X-Received: by 2002:aca:7596:: with SMTP id q144-v6mr5396955oic.105.1533334213138;
 Fri, 03 Aug 2018 15:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com> <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
In-Reply-To: <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 4 Aug 2018 00:10:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
Message-ID: <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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

On Fri, Aug 3, 2018 at 11:29 PM Andy Lutomirski <luto@amacapital.net> wrote:
> Gotcha.  That was very hidden in the 24k lines.  Please make this (and
> any similar goodies) be their own patches.

I know, sorry, and I certainly will have this split out. The above
code snippet was from the much much shorter WireGuard patch (3/3), but
indeed the simd_get/put/relax code is in the monster patch here, so
that'll certainly be split for v2.

>
> Also, please consider spelling it differently:
>
> simd_context_t simd_context = simd_get();
>
> Because we'll feel very silly the first time some architecture has
> more than one possible state.  (It wouldn't be entirely insane for x86
> to distinguish between "no SIMD", "XMM only", and "go to town!", for
> example.)

That's a great idea. It'll also make it clearer that users shouldn't
just dump a raw "true" in there; raw bools are more tempting to abuse
like that.
