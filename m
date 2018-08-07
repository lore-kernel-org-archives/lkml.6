Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D085C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD46221A60
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOsLa5Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD46221A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbeHGDPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:15:12 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40036 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732952AbeHGDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:15:12 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so25557734oie.7;
        Mon, 06 Aug 2018 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=v1d0tcHdSsM4jm3s6OCYwhWsgPSfRxGNmeUi2kqqtz8=;
        b=GOsLa5EtyhDXodb660vVmapuNyXvmxKk/rgdejWiahj0CnbKvp560vljG4MGts5qHk
         EjQli2FK9Cv7X4ME+hSkTklNmrAhGWlyfIibRNx1YD1LC2WvCN9FCpOWqdO7Q12+qgq5
         aPy3RzqmKfzMRHHtwAmPp4nBN41IQ0df+sBDrSdvVc1kwPi+FHl3YFHP1AZm8/t3353Z
         zQCwev4G60A0cK1dlYVoYCggUaUXxgXEsp53Jofxk3/4RjKsHRg+D3AB1FTlXqxLdXhq
         Zk9oV4hHayhl9Cwq+BEm2HxBtU3XRWPIv5Ml2/ZLxSIK/W9SiQ7sVytk7KkDnk3DuC2G
         PHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=v1d0tcHdSsM4jm3s6OCYwhWsgPSfRxGNmeUi2kqqtz8=;
        b=QF/UgQCuVmL3WLLWHyeGoNTQMfE4sLsTQot0+WfMeIbjrQjnGZXK5jynrx1uNvl4cb
         7qNkkOMFEhgrv+B71+yB2RgfsgUKTA17VdF7WFR4lRQo2UyDPZZ9+m9kNkvdWtyCwpYB
         lqxvr+bwDudKUjkLU0E6z5RS4Q7EnNp0DEuwd2/CXSBheWyQ2KC381lLeBZSmeYUuDMi
         G2PIZlNf/4qZF6VMseDDPi6UVQszzEkHKXvFXE24O9/stiagjYIcn2VT1ROp5qgvRbut
         1edOWgJgjK79K+eLGfUE3hmWPCIfz4or7Rv7fFeILo1xcIFGdy4tHAJbn4uxCwVaZRC5
         jpBA==
X-Gm-Message-State: AOUpUlEFqpHGq/EolPLdd42pwU/6bpouG3HmQC1AdCDIRREl11ncsiDk
        fakYw3lfJwp9uclxiGrGudn+ERYH/KtPdA3fQNc=
X-Google-Smtp-Source: AAOMgpdyuzBdfLH4xHbkLCyMwyRLDChHCmddmTv7Ty89ZeHbpOSdeR0voftc24CPjIszGNP1odtROwpMpkFrOg9JrGI=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr15485056oia.154.1533603807743;
 Mon, 06 Aug 2018 18:03:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c712:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 18:03:27 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20180806230437.21431-1-Jason@zx2c4.com>
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806230437.21431-1-Jason@zx2c4.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 6 Aug 2018 21:03:27 -0400
Message-ID: <CAH8yC8kKet=fx0rYF8QEWK+TzyBgwHrLabWE72znBY=QLZVWkA@mail.gmail.com>
Subject: Re: [PATCH] crypto: remove speck
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 7:04 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> These are unused, undesired, and have never actually been used by
> anybody. The original authors of this code have changed their mind about
> its inclusion. Therefore, this patch removes it.

I think it may be unwise to completely discard Speck for several
reasons. The two biggest pain points for me are:

  - political concerns addressed by other ciphers
  - high quality lightweight block cipher implementation
  - some regulated industries will need it for their problem domains

It seems to me the political concerns were addressed by not using
Speck for Android. I don't believe HPolyC and Speck are orthogonal.
Instead they provide the user with a choice which is usually a good
thing.

I also think allowing politics a heavy hand endangers other ciphers
like SM3 and SM4. I would advise against removing them just because
they are Chinese ciphers. I suppose the same could be argued for North
Korea and Jipsam and Pilsung (if North Korea ever offers their
ciphers).

I think Eric, Ard and other contributions lead to a high quality
implementation of Speck. High quality implementations that "just
works" everywhere on multiple platforms are rather hard to come by.
The kernel's unified implementation ensures lots of folks don't go
making lots of mistakes when rolling their own.

There are verticals that will need a choice or alternative like Speck.
US Aerospace, US Automotive and US Hoteliers come to mind. US
Financial my use them too (they having some trading platforms with
absurd requirements that make Simon and Speck appear bloated and
overweight).  Some of the verticals are going to need an alternative
that meets technical and security goals and pass the audits.

Choice is a good thing. Users need choices for technical, regulatory
and legal reasons.

Jeff
