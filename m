Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE5C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2549720C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="oF10Zuwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2549720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeKUFZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:25:22 -0500
Received: from imap.thunk.org ([74.207.234.97]:59366 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbeKUFZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=smOOL5wUGG81VvEbup4WV9Fm1Q7kwbp5OAcLw1zwJu8=; b=oF10ZuwnKZSqBWKw5/897nZaes
        Fa5Rg65lxcECqsz3G5uoOKeit4bFc4pZ1RIfOrhDtC5qgnt9ipbfSvVhvig+05+Tp2T5tThLvks0j
        vx6sfywLxHJQB41ZXq6FdqypZE1WflIPu14D5PLT0u0RekKoxCiFyI+XadBqcoYGJ5ag=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gPB7r-0007BT-RE; Tue, 20 Nov 2018 18:51:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E3ED97A04D1; Tue, 20 Nov 2018 13:51:54 -0500 (EST)
Date:   Tue, 20 Nov 2018 13:51:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
Subject: Re: [RFC PATCH v2 0/4] Exporting existing crypto API code through
 zinc
Message-ID: <20181120185154.GB6401@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
References: <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com>
 <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com>
 <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au>
 <20181120060217.t4nccaqpwnxkl4tx@gondor.apana.org.au>
 <CAKv+Gu-SHS2tF665dfqSgmH5EF5vGVtef=3_4WgCE=+8+Jw7Rw@mail.gmail.com>
 <20181120141850.zjmfwcari5kykk6y@gondor.apana.org.au>
 <CAHmME9oPGkvEmqvfbav-AOf_P=Z4zWYxvqD3a3QhuOSh_OWd_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oPGkvEmqvfbav-AOf_P=Z4zWYxvqD3a3QhuOSh_OWd_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 05:24:41PM +0100, Jason A. Donenfeld wrote:
> On Tue, Nov 20, 2018 at 3:19 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > Yes.  In fact it's used for FIPS certification testing.
> > Sure, nobody sane should be doing it.  But when it comes to
> > government certification... :)
> 
> The kernel does not aim toward any FIPS certification, and we're not
> going to start bloating our designs to fulfill this. It's never been a
> goal. Maybe ask Ted to add a FIPS mode to random.c and see what
> happens... When you start arguing "because FIPS!" as your
> justification, you really hit a head scratcher.

There are crazy people who go for FIPS certification for the kernel.
That's why crypto/drbg.c exists.  There is a crazy fips mode in
drivers/char/random.c which causes the kernel to panic with a 1 in
2**80 probability each time _extract_entropy is called.  It's not the
default, and I have no idea if any one uses it, or if it's like the
NIST OSI mandate, which forced everyone to buy an OSI networking stack
--- and then put it on the shelf and use TCP/IP instead.

Press release from March 2018:

https://www.redhat.com/en/about/press-releases/red-hat-completes-fips-140-2-re-certification-red-hat-enterprise-linux-7

    	     	       	   	     	 	- Ted
