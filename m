Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC75BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C89E24718
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CjUY9zuK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZyURXFzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C89E24718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965889AbeF0SbO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:31:14 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44269 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965852AbeF0SbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:31:11 -0400
Received: by mail-yb0-f195.google.com with SMTP id a2-v6so1125455ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cPZBeeM5Xxq27hdOtzM48/U9LC6WYZrMtDDgtTKWEzU=;
        b=CjUY9zuKx3cszc3m13DrrRPv9JeZvCLuhv8PU31LMwSnKUF4liIU0SeiZF45lyuDip
         qUAWV+h8H2eqgnROs0ytC2bWflDaZ1jghH2kJ1vlplqetUizTCfi25E6f9jpVtuJlKRN
         dXAt3SK7SH0cGb9YRzHYJzk0k/Dttd7eqgyt/VOlyAq0E+3loAlvjT3XgqfXTxC4ZQg6
         UVyU+vtLZwhzkvF86D6nN5ymabxaQu664rkNurac6hqIHRfMGmx4cO9Tdgvk3iVurkI/
         BlwmaNtUTIhxFAba5THUCknVcISADCTPPRKmifqN/LrLnktL8KIATyjAzBM7FamSvgfk
         r4YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cPZBeeM5Xxq27hdOtzM48/U9LC6WYZrMtDDgtTKWEzU=;
        b=ZyURXFzKo0GKyZc9xuKhM6UnPRthE7UFhF7MT1ywc7osXLi2zANfGK5Yc0VSU/IbtO
         JxGFqw00Qo6R3KF+kgBUKgGm4ciRoYY9LAmzBoOoC0wIjJ8nRKQSW0jqYvIYSZIlvszW
         ZHvF9Y7TfthdG80SAMfn7jO24BGp39JlekvFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cPZBeeM5Xxq27hdOtzM48/U9LC6WYZrMtDDgtTKWEzU=;
        b=NRULN/wsnqTPh86VWpnmgmkj5kSNBJ2DYo9FhkyESk0n3qwav6JoxjsHc0UVRwY+Il
         zs5TYUpzFImf7xANXDmkvzoMKY4HTy3nYP3rhPnTWARm1JtXzECDDNpOGkTR8Ih+xuMf
         hAzaMcplYqMgD04eNwmfGpkja49NBNwOCUvcB9Qfdz6VzNrdsqAtUNWJwGtnXTuatnaO
         KVUW/6IZG120GK0k1MqZO5AsNhZ4BL4K7cNJBih1/nUNSOxFdC0ThnWHlyftiIMK0weh
         L45UHZew1TkBpBK3B5faQbdT5PejUh6D7sypi9o9oPKc4QHNusVVb8wsmc4rQwUO8OaN
         oN0w==
X-Gm-Message-State: APt69E2TTllclWHF/M2/PIO6jR4n+WzccXCU53PuQNgnF/Bp0FLSosLt
        WbXvJACaJAmSjzUtWeKYKDd+7BubmLtjn1pM7Y25rQ==
X-Google-Smtp-Source: ADUXVKJL5YWZ+uxJArvx9YU0Yg9qvCwx7j7EAPcczPPUILHsjYx/NWRSsu86O/LpnXQhPJdyAUQiZDyJsJlj+a4MpOY=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr3461584ybj.343.1530124270622;
 Wed, 27 Jun 2018 11:31:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 11:31:09
 -0700 (PDT)
In-Reply-To: <20180627143622.ntksjxsymo4yw6dz@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-12-keescook@chromium.org>
 <20180626092041.mxfg4lxcvxfivzc2@gondor.apana.org.au> <CAGXu5jKYb-0NNvOcN79hzqU7O6vCFhMTBDGBL8Knuoc-YHamPg@mail.gmail.com>
 <20180627143622.ntksjxsymo4yw6dz@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Jun 2018 11:31:09 -0700
X-Google-Sender-Auth: _q-jVrmLRCTBJa4-BmDes7VwqwA
Message-ID: <CAGXu5jJ2Z=YP+fNsvy+6a_BpC1ibZf6tOzZuPHk=Qx1qNVvOZw@mail.gmail.com>
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

On Wed, Jun 27, 2018 at 7:36 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Jun 26, 2018 at 09:45:09AM -0700, Kees Cook wrote:
>>
>> Which are likely to be wrapped together? Should I take this to 512 or
>> something else?
>
> The situation is similar to ahash.  While they're using the same
> skcipher interface, the underlying algorithms must all be
> synchronous.  In fact, if they're not then they're buggy.
>
> Therefore it makes no sense to use the general skcipher request
> size as a threshold.  You should look at synchronous skcipher
> algorithms only.

I might be catching on... so from this list, I should only "count" the
synchronous ones as being wrappable? The skcipher list is actually
pretty short:

crypto/cryptd.c:        crypto_skcipher_set_reqsize(
crypto/cryptd.c-                tfm, sizeof(struct
cryptd_skcipher_request_ctx));

The above is, AIUI, unwrapped, so I only need to count sizeof(struct
cryptd_skcipher_request_ctx)?

These are "simple" wrappers:

crypto/lrw.c:   crypto_skcipher_set_reqsize(tfm,
crypto_skcipher_reqsize(cipher) +
crypto/lrw.c-                                    sizeof(struct rctx));

crypto/simd.c-  reqsize = sizeof(struct skcipher_request);
crypto/simd.c-  reqsize += crypto_skcipher_reqsize(&cryptd_tfm->base);
crypto/simd.c:  crypto_skcipher_set_reqsize(tfm, reqsize);

crypto/xts.c:   crypto_skcipher_set_reqsize(tfm,
crypto_skcipher_reqsize(child) +
crypto/xts.c-                                    sizeof(struct rctx));

But what are the "legitimate" existing crypto_skcipher_reqsize() values here?

These are "complex" wrappers, with cts even adding blocksize to the mix...

crypto/ctr.c-   align = crypto_skcipher_alignmask(tfm);
crypto/ctr.c-   align &= ~(crypto_tfm_ctx_alignment() - 1);
crypto/ctr.c-   reqsize = align + sizeof(struct crypto_rfc3686_req_ctx) +
crypto/ctr.c-             crypto_skcipher_reqsize(cipher);
crypto/ctr.c:   crypto_skcipher_set_reqsize(tfm, reqsize);

crypto/cts.c-   align = crypto_skcipher_alignmask(tfm);
crypto/cts.c-   bsize = crypto_skcipher_blocksize(cipher);
crypto/cts.c-   reqsize = ALIGN(sizeof(struct crypto_cts_reqctx) +
crypto/cts.c-                   crypto_skcipher_reqsize(cipher),
crypto/cts.c-                   crypto_tfm_ctx_alignment()) +
crypto/cts.c-             (align & ~(crypto_tfm_ctx_alignment() - 1)) + bsize;
crypto/cts.c-
crypto/cts.c:   crypto_skcipher_set_reqsize(tfm, reqsize);

What values might be expected here? It seems the entire blocksize
needs to be included as well...

-Kees

-- 
Kees Cook
Pixel Security
