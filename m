Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EEAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA9820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KXoGCuRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA9820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbeGXSFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:05:08 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35915 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbeGXSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:05:08 -0400
Received: by mail-io0-f193.google.com with SMTP id r15-v6so3996008ioa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VoVAj1ZkTXmNlv9r3osCFCaIs3/6JtsSKqlipDGMjBs=;
        b=KXoGCuRICJNUfLKpDRIixnGzlMaOvHfwa24W5yOHQSUZaJJlYGsKeCLQ0u/+niWjZr
         44wFUYaDodmrTb++1C+5RLrbmeas62cmoDINxfeYk781Ye7qHTV92zipcF8slNaTfAdP
         uKdlUUZpW+kf0LRgtOgwOCDySVx32o7OS4gfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VoVAj1ZkTXmNlv9r3osCFCaIs3/6JtsSKqlipDGMjBs=;
        b=WV+RMn4Ki1Z1DExcPFW+UF14wb2IW6BuCVyKdRNSmRJjDpttPfu2UWBq2hmVCPPZBg
         DG+AVcWwa5JXtkHYj6SiblmwDFYdn31WtrXms0eH8nzNuE92SpJ1mCN9MYBhRjjJRXQh
         pP6FRE3SACnU5syObPI8yzBlk9lGOQmvjOumwMPq9fhsnIEgIxwqzaXKZvSFhe6q20jd
         qE353OvEtd6+cqyf1b1gwSMqo7davCumRGgOw6+hIbm3lJjMn1hxF1qMLeI5LwZC7vhb
         q820d7CzX13RTigKPDSoe9jZXACW5cxNDKdYM+OzgdvWuwjE0GWMRpFAjtVU9OprpViq
         CPEg==
X-Gm-Message-State: AOUpUlF1BIQcFMX+3N07p/H9kvwPy6ttWttiQCl9AfcAnxjXjTC/lgSL
        7O7j9RJDU5V5Gka/6SjJES+wrq+RCpmc7u2erYEURA==
X-Google-Smtp-Source: AAOMgpeaVpKG7k6Hl0QC/9RZKDDzTigYHYwpkFhqxDkKs3FRipA5DDVmNACbmdPgRukqkMXDuY+EzQwaMSNH/zBGRi4=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr13941027iof.173.1532451464793;
 Tue, 24 Jul 2018 09:57:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 09:57:44
 -0700 (PDT)
In-Reply-To: <20180724164936.37477-18-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-18-keescook@chromium.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 24 Jul 2018 18:57:44 +0200
Message-ID: <CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
Subject: Re: [PATCH v6 17/18] crypto: ccm: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, qat-linux@intel.com,
        linux-ppp@vger.kernel.org,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-afs@lists.infradead.org,
        "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 July 2018 at 18:49, Kees Cook <keescook@chromium.org> wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> In the quest to remove all stack VLA usage from the kernel[1], this
> drops AHASH_REQUEST_ON_STACK by preallocated the ahash request area
> with the skcipher area (which are not used at the same time).
>

-EGRAMMAR

> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/ccm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/ccm.c b/crypto/ccm.c
> index 0a083342ec8c..b242fd0d3262 100644
> --- a/crypto/ccm.c
> +++ b/crypto/ccm.c
> @@ -50,7 +50,10 @@ struct crypto_ccm_req_priv_ctx {
>         u32 flags;
>         struct scatterlist src[3];
>         struct scatterlist dst[3];
> -       struct skcipher_request skreq;
> +       union {
> +               struct ahash_request ahreq;
> +               struct skcipher_request skreq;
> +       };
>  };
>
>  struct cbcmac_tfm_ctx {
> @@ -181,7 +184,7 @@ static int crypto_ccm_auth(struct aead_request *req, struct scatterlist *plain,
>         struct crypto_ccm_req_priv_ctx *pctx = crypto_ccm_reqctx(req);
>         struct crypto_aead *aead = crypto_aead_reqtfm(req);
>         struct crypto_ccm_ctx *ctx = crypto_aead_ctx(aead);
> -       AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
> +       struct ahash_request *ahreq = &pctx->ahreq;
>         unsigned int assoclen = req->assoclen;
>         struct scatterlist sg[3];
>         u8 *odata = pctx->odata;
> @@ -427,7 +430,7 @@ static int crypto_ccm_init_tfm(struct crypto_aead *tfm)
>         crypto_aead_set_reqsize(
>                 tfm,
>                 align + sizeof(struct crypto_ccm_req_priv_ctx) +
> -               crypto_skcipher_reqsize(ctr));
> +               max(crypto_ahash_reqsize(mac), crypto_skcipher_reqsize(ctr)));
>
>         return 0;
>
> --
> 2.17.1
>
