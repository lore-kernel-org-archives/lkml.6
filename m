Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E30CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B95206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RiarUkEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B95206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeILJez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:34:55 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:49115 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeILJey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:34:54 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 26c689bc;
        Wed, 12 Sep 2018 04:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=S6ANol2e2m77
        gIN6Kn+N6c5BFyk=; b=RiarUkEFHb1JeimEq1I3rZb4p02QTaLcFrv6Tfav3C5f
        XFVzHJ6ca0IAJin10DBS73kbB+i47Z6LCQKV9hZ79Lees09a595+KpWOcsHAP7xc
        SiFbk5YESJodcZ8FmffrLHPtlHF4JPBRVxfn2esDxuJ3NgDSHkfOY3/VJfI8/e/i
        EvtkiNx8c/jDOZa3ZuyBFdJBGBsGrJcVqLvjooCxaBG7lDGOfrU6eoLeWgSggGMI
        OfACXtzuw20WrKw6TCQoiCEaVFDcANmDpSTUxNfFPXVdTxnO1G+AGGMXUi0d0bhy
        Rrdpj6l6LlF0wcoMQGgvHUBRxdP/7T5SQk2UDS66ig==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9932cd4c (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 12 Sep 2018 04:15:28 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id b15-v6so1078418oib.10;
        Tue, 11 Sep 2018 21:32:13 -0700 (PDT)
X-Gm-Message-State: APzg51AkMfyW4WBKBXabKPZzxrQNlp1oqcJEAWej3mrIW8AvO9YVxkw4
        RK65MSmKkZsugXQTMh+T22ZwEnH9fPTZRAhZZus=
X-Google-Smtp-Source: ANB0VdYrLjteb1kWzmK43XHaJIvJFr3A0Y3xyA+xOlqFCC8qGHPZw0YbdQ5w4FeBtjqjXGd1Wy85pet7LPMTwBqBFYY=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr22038oig.189.1536726732658;
 Tue, 11 Sep 2018 21:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911145624.GA21635@kroah.com> <20180911214737.GA81235@gmail.com>
 <49BAF465-B3DC-4155-BFF9-DB6C386C1878@amacapital.net> <CAHmME9q+mqT+vtM1FdBvf8=nAFu=u+wN48sOxqLcFthxYVn7NQ@mail.gmail.com>
 <2E01FBB6-030A-40AB-8BEE-F8F271A57568@amacapital.net> <CAHmME9om2rJONj6mMvSPHjiZDQKe05BCe=GonHN=c2Rg4n=pkg@mail.gmail.com>
In-Reply-To: <CAHmME9om2rJONj6mMvSPHjiZDQKe05BCe=GonHN=c2Rg4n=pkg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 22:29:34 -0600
X-Gmail-Original-Message-ID: <CAHmME9pp1f-3eUvyFAR1nvvvcmtaqQio_X1EmKwSaLNBgDiHLQ@mail.gmail.com>
Message-ID: <CAHmME9pp1f-3eUvyFAR1nvvvcmtaqQio_X1EmKwSaLNBgDiHLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric, Andy,

> On Tue, Sep 11, 2018 at 5:01 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > I think Ard=E2=80=99s point is valid: in the long run we don=E2=80=99t =
want two competing software implementations of each primitive. It clearly *=
should* be possible to make crypto API call into zinc for synchronous softw=
are operations, but a demonstration of how this actually works and that the=
re isn=E2=80=99t some change to zinc to make it would well would be in orde=
r, I think.
> >
> > IMO the right approach is do one conversion right away and save the res=
t for later.

It turned out to be fairly straight forward and quick to do. I'm on a
transatlantic plane so the connection is super spotty, but you can
check out the three commits added to:
<https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log?h=3Djd=
/wireguard>
-- the two "crypto:" commits and the one "random:" commit.
Alternatively, you can look directly at
<https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/tree/crypt=
o/poly1305_zinc.c?h=3Djd/wireguard>
and <https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/tree/c=
rypto/chacha20_zinc.c?h=3Djd/wireguard>.
I'll be refining and checking these over the next week or so, but the
basics were super easy to do.

Jason
