Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E46C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647E820831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH9j7aFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647E820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeKTGag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:30:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43368 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbeKTGaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:30:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so15856567wrs.10;
        Mon, 19 Nov 2018 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7sggXc39n3r1MspDLVyEsvwDI6rbNYG68dYsFLrYx0M=;
        b=eH9j7aFeVbPIBJ0aw/grIL7DMoP9yukgBXMf2cw6JB787n1x9iLmOeQ0rXa6ihY/+R
         ENfU6iWR30PJ+K0urqjP79xDC+WpLhzS7vNzru8KF7OB4klWdmWR7zmpHt1LsedJ1gSl
         kxz7dnm4qgm8iJi/4IuYUpOwLQjcGHL+d8fB6sFPKpLkC+xksHoTxZlldCrbNZbc0zgY
         rWj49CrJIdMT957TQb3dRJnfi95Xr2f9+nRgMutqTBRiV7ti1hLB2V/vlET+zg/qXavE
         m7w9eBRTaDq2L6PMJdnYEcmvPIgOilH4H8+73MnpG8D0TpFNFpvsLWqeYLsaM53Wj30D
         26Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7sggXc39n3r1MspDLVyEsvwDI6rbNYG68dYsFLrYx0M=;
        b=JuS1LvW9JbBPjphQUDQ1FhEj0UvEYD62u+InZlT+Rf6ubLSiYYMmpiqe2gA4Offjvt
         L6S8VuxlRT6CNUEj+2/YfRoI9f3ZeGJRD1aWuwUdQ6mgxpKiPj1XjaN0VP9fk974qha9
         rTHN5g9bTnsoUjEMJzfftyxy7vMq8VK3bJvQiegTpQOoH7xN/7qF9yT7c9BXq1YYVN1E
         1hyh+jqDnIvL5QVW1vnMIcXdiVPMzpK890naxF8/abxCajxPzoN1AvF+39vEr6vtG9mn
         jVqosbtwURaI0KOIQ4P20mL+3OBrrbpYS2iXedUMLpcQsrdZSWYziq4+8S/fW9UVSsyp
         HwqQ==
X-Gm-Message-State: AA+aEWaaNIkP+XztmDJ+2Cnu7AycYIPsPv9edw+NTFpBT/W4U0L0vCRo
        KQdotEgIaUl3BAlzkckgo5k=
X-Google-Smtp-Source: AFSGD/VWPABZJve/Abphl7QCvmE2lBr9Bls8klxrtQROpKs8vVXPQpT4yrvuyFv2il053SMgrwu9NQ==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr9780410wrt.209.1542657920916;
        Mon, 19 Nov 2018 12:05:20 -0800 (PST)
Received: from [192.168.2.28] (218.83.broadband9.iol.cz. [90.176.83.218])
        by smtp.gmail.com with ESMTPSA id t82-v6sm36084786wme.30.2018.11.19.12.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 12:05:20 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com>
 <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
 <20181116215249.GA27149@gmail.com>
 <56883f08-26cb-ecef-5698-1c2948714773@gmail.com>
 <20181119192821.GA258711@gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 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
 vzRmJp4=
Message-ID: <1e9ec59a-6a2c-3536-0722-c6d96d6714b2@gmail.com>
Date:   Mon, 19 Nov 2018 21:05:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <20181119192821.GA258711@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/11/2018 20:28, Eric Biggers wrote:
> Note that Adiantum benchmarks on x86 are misleading at the moment, since the
> initial kernel patchset doesn't include SSE2 and AVX2 optimized XChaCha and
> NHPoly1305.  To start, only C and arm32 NEON implementations are included.
> Hence, on x86 Adiantum will appear much slower than it should be.  But I'm
> planning to add the x86 and arm64 implementations, so it will get much faster.

The posted benchmark was just an example (it was 32bit virtual machine on my
old laptop so numbers are misleading).

If Adiantum is going to be merged, I expect it can be used as an alternative
even on x86, so I expect more optimizations.

...
> I think that when using AF_ALG, cryptsetup should get the IV size from
> /proc/crypto, or else have it hardcoded that "adiantum" uses 32-byte IVs.
> (Actually Adiantum can formally can use any size IV, but we had to choose a
> fixed size for Linux's crypto API.)

I do not want to parse /proc/crypto (it needs to load the module first anyway)
and proper API was not yet here when I wrote this code (I think we were the first
real user of userspace crypto api...)

> Getting the IV size via CRYPTO_MSG_GETALG via NETLINK_CRYPTO is also an option,
> but that requires the kconfig option CONFIG_CRYPTO_USER which isn't guaranteed
> to be enabled even if CONFIG_CRYPTO_USER_API_SKCIPHER is.

Yes. For now, I hardcode Adiantum IV size in cryptsetup and later we will try to
find a more generic way.

> Also: why is cryptsetup's default keyslot encryption AES-128-XTS instead of
> AES-256-XTS?  People can choose a cipher with a 256-bit key strength such as
> AES-256-XTS or Adiantum, so the keyslots should use at least that strength too.

It was inherited from 256bit default key (so 2xAES-128 in XTS).
It is still the default for LUKS1, but we should perhaps change it to double key
it for XTS mode (at least for fallback keyslot encryption).

Anyway, we will release cryptsetup 2.0.6 very soon to fix one problem
in LUKS2, so I'll add the Adiantum IV size there as well so people can play with it.

Thanks,
Milan

p.s.
Reading the discussion about Zinc/Adiantum - I would perhaps prefer to merge
Adiantum first (if it is ready).
It is a new feature, I see it as useful cipher alternative for dm-crypt and it can be
esily backported without Zinc to older kernels (I am testing it actually this way).
