Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAFAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62B8259A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qYt3ZM5L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kUpgkB0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62B8259A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeF1AKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 20:10:08 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34689 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeF1AKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 20:10:07 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so1455492ybq.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ytac44Imxj1TycbJHWSQn1SDdlrwlZQjpO8QRu+K20U=;
        b=qYt3ZM5LpaCCmHbW6+1Ux4XkrQwFGG7y0yNU0i1eth0Tv1FalC2t6u/8i9WXeFw3/q
         itMHG3X+U0HnI0wE8sfugLDdnSBQ48BWgh9f/UFTMjNDLf91kf9olX8SrcEShT4A8nfK
         kr1cOmbdYpJMmYy99UACoZ7HY50K57NR8/hgprHUgPPb/25A9cfi7yvxntfHPZBE1of1
         FMZUTayh/Gqt8ftPvIjzEST2/6h0VckR0NhN8MDdn/NeegMxr0RVfmsbJPs4inrHaRRm
         0tJd2spju23BLsiFtuHkmBegHzayF14OfTXrYGFO1KgI55tZAiTV+8pAJcSf9RWCB19J
         U0/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ytac44Imxj1TycbJHWSQn1SDdlrwlZQjpO8QRu+K20U=;
        b=kUpgkB0wbvyJz94lRezvKXbm0wLNvF69yj9/R9YMfXbZ1nIzjNKw9maN1L/2jO0Fuu
         qYkEnOcsBibp2dyBVpogSyTvqPhWYy5CIFZhMLmNA0K4m7/E0DYCyerJYvHLO3Wo45EA
         sVC+Dh2ybXdrYIjbAToOs4nd0Q1Uzw3BhOjsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ytac44Imxj1TycbJHWSQn1SDdlrwlZQjpO8QRu+K20U=;
        b=S2JLRSKZjQihhfaMkN724AAn4ZBOMWNY5tnOZRepRBAHuB/3nlbOKSsMCntpaeMc6+
         9qbpTU8bAi+LcRjUAyYcGtHPm7gTpp4HytYTbfhl9H2cow4m5fjibi3aUFVrwmDtDHF+
         UWqG9dCpL6D0FN19t0rNmi/Tc8Ii73g3t1eeowxvVHm0Tv/FFPPQ9Ibad1ig2+QG/00g
         pMqqx3k389VqDMRJbSTdn6Z2WvW51ra1jhW45rPj+CYsyUHHajtxyiaX3UXDtz/ZbzDw
         d8XSUBPhEeyuhVYgs+Car6Dw+oZFgcsAtdvIlTNxMLRG4hO5fQojKE4gomUgW09UjLb+
         KMlg==
X-Gm-Message-State: APt69E3QpV9qMFSRbdKAQABSaHxxxbaa0sfSDKOM8dY8EjDGIFzuaH2e
        cYjWBPyYEPRVARrHdU9suJ6j/6bdk8cv8SeVGR9ndg==
X-Google-Smtp-Source: ADUXVKLDmxBXWm2frNvCobfWgmXO+TeF0sIqaaJX7/nXUCILqbCcMnR18xKnY5Sxdp0Dp/pZxzht9Y7bWd/+pvnhoT8=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr4297164ybi.193.1530144605997;
 Wed, 27 Jun 2018 17:10:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 17:10:05
 -0700 (PDT)
In-Reply-To: <20180627222749.xa5333caq5vaa7st@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-12-keescook@chromium.org>
 <20180626092041.mxfg4lxcvxfivzc2@gondor.apana.org.au> <CAGXu5jKYb-0NNvOcN79hzqU7O6vCFhMTBDGBL8Knuoc-YHamPg@mail.gmail.com>
 <20180627143622.ntksjxsymo4yw6dz@gondor.apana.org.au> <CAGXu5jJ2Z=YP+fNsvy+6a_BpC1ibZf6tOzZuPHk=Qx1qNVvOZw@mail.gmail.com>
 <20180627222749.xa5333caq5vaa7st@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Jun 2018 17:10:05 -0700
X-Google-Sender-Auth: 9tq98TiJOp28B6a7nfkFb83cuR8
Message-ID: <CAGXu5jKas=OyJPsrMthxjEykG=FkHDW84dO4bKGpj-50JjUYwQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 3:27 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Wed, Jun 27, 2018 at 11:31:09AM -0700, Kees Cook wrote:
>> crypto/lrw.c:   crypto_skcipher_set_reqsize(tfm,
>> crypto_skcipher_reqsize(cipher) +
>> crypto/lrw.c-                                    sizeof(struct rctx));
>> ...
>> crypto/cts.c-   align = crypto_skcipher_alignmask(tfm);
>> crypto/cts.c-   bsize = crypto_skcipher_blocksize(cipher);
>> crypto/cts.c-   reqsize = ALIGN(sizeof(struct crypto_cts_reqctx) +
>> crypto/cts.c-                   crypto_skcipher_reqsize(cipher),
>> crypto/cts.c-                   crypto_tfm_ctx_alignment()) +
>> crypto/cts.c-             (align & ~(crypto_tfm_ctx_alignment() - 1)) + bsize;
>> crypto/cts.c-
>> crypto/cts.c:   crypto_skcipher_set_reqsize(tfm, reqsize);
>>
>> What values might be expected here? It seems the entire blocksize
>> needs to be included as well...
>
> But otherwise yes these are the ones that count.

In both cases here, what is "cipher"? i.e. what ciphers could lrw be
wrapping, and what ciphers could cts be wrapping, so that I can
examine the blocksizes, etc?

FWIW, looking at the non-ASYNC wrappers, I see only:

crypto/ctr.c
crypto/cts.c
crypto/lrw.c
crypto/xts.c
drivers/crypto/sunxi-ss/sun4i-ss-cipher.c

Building in all crypto things and running tcrypt with an instrumented
crypto_skcipher_set_reqsize, I see:

# dmesg | grep skcipher_set_req | cut -c16- | sort -u | sort +1 -n
crypto_skcipher_set_reqsize: 8
crypto_skcipher_set_reqsize: 88
crypto_skcipher_set_reqsize: 184
crypto_skcipher_set_reqsize: 256
crypto_skcipher_set_reqsize: 472

The 472 maps to lrw with its 384 struct rctx:

[  553.843884] tcrypt: testing lrw(twofish)
[  553.844479] crypto_skcipher_set_reqsize: 8
[  553.845076] crypto_skcipher_set_reqsize: 88
[  553.845658] crypto_skcipher_set_reqsize: 472

[  553.860578] tcrypt: testing lrw(serpent)
[  553.861349] crypto_skcipher_set_reqsize: 8
[  553.861960] crypto_skcipher_set_reqsize: 88
[  553.862534] crypto_skcipher_set_reqsize: 472

[  553.871676] tcrypt: testing lrw(aes)
[  553.872398] crypto_skcipher_set_reqsize: 8
[  553.873002] crypto_skcipher_set_reqsize: 88
[  553.873574] crypto_skcipher_set_reqsize: 472

[  553.957282] tcrypt: testing lrw(cast6)
[  553.958098] crypto_skcipher_set_reqsize: 8
[  553.958691] crypto_skcipher_set_reqsize: 88
[  553.959311] crypto_skcipher_set_reqsize: 472

[  553.982514] tcrypt: testing lrw(camellia)
[  553.983308] crypto_skcipher_set_reqsize: 8
[  553.983907] crypto_skcipher_set_reqsize: 88
[  553.984470] crypto_skcipher_set_reqsize: 472

And while I'm using tcrypt, ahash shows:

44
124
336
368
528
536
568
616
648
728
808

The largest seems to be sha512:

[  553.883440] tcrypt: testing sha512
[  553.884179] sha512_mb: crypto_ahash_set_reqsize: 528
[  553.884904] crypto_ahash_set_reqsize: 728
[  553.885449] sha512_mb: crypto_ahash_set_reqsize: 808

So ... should I use 472 for skcipher and 808 for ahash?

-Kees

-- 
Kees Cook
Pixel Security
