Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YbK7KBIpGlsiDQAAmS7hNA
	; Fri, 08 Jun 2018 07:27:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4B8F4607E4; Fri,  8 Jun 2018 07:27:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbtPEl3M"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 91C4860275;
	Fri,  8 Jun 2018 07:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91C4860275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeFHH1h (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:27:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53376 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeFHH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:27:36 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so1204835itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tSQ2MW8eMWXQ+lWN8+UPYRpvkJyYdzOA/5jW4rMW5SU=;
        b=PbtPEl3McNiTRhd3oadSqYeC76bSmZRr5GeJKMdeSmCBUd8bMJCF6rTjaT/Y0LOz5X
         bcimiqjZzVjjg8qovzyRkzbnSNkUlV35pvUDXlWN63JeB5ZqPf6YCxjvKdbZhAaPyMVv
         R1L8QAdbrXz3EO2MFtDfhMCrMibBAlULH6Fck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tSQ2MW8eMWXQ+lWN8+UPYRpvkJyYdzOA/5jW4rMW5SU=;
        b=VUjCv1vLG0h+8bZUZ7HzEZb86L6KC7aUF2/Vq5oEUNa3lHLFtwD2QpgcBalXruKktU
         i/HitN5I8XwXMOylzBBKq8qfczJq/f/r/8ONeID7gpWN04q1d83C1sA4YOQKKSJxA0Ke
         VtpdPNp/JfI5cDcDU9zwnJTw+bITNcAlmZ5nQremHm2LJ7OKhoBUKx4E+X6OGyfUq9fj
         GVcf7CNDsDnZRu1gXEeGIJn9UxFxRv+tUDgSUB6uG6gIYdrvxZlrCp907JySZekG7Okp
         NM7oiTTSzU01Js6qkB6aR59id2U4MErdrKoHHrBIVBEx9sd9k1tOQpQ7A7RHTskuFyUL
         XGRA==
X-Gm-Message-State: APt69E17gx9CTijwHmdDxlkIBq2Xplkxht5voGiDalJYvfqPxb6Yo5wH
        8Pbi4gZvtnBUJNuGL2wmtxKuEzNQj34/pLD3sNdSrA==
X-Google-Smtp-Source: ADUXVKJMxAMbwyKP8fDv6hGjru/yPItRBnhv243pNrvGGL1hHG1lasvw6o5cZJc2/CyIXQaKmpyueUVW7fhyET0g53s=
X-Received: by 2002:a24:f04e:: with SMTP id p14-v6mr744342iti.106.1528442855330;
 Fri, 08 Jun 2018 00:27:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:27:34 -0700 (PDT)
In-Reply-To: <1528441502-26425-1-git-send-email-hejianet@gmail.com>
References: <1528441502-26425-1-git-send-email-hejianet@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 8 Jun 2018 09:27:34 +0200
Message-ID: <CAKv+Gu-pjaMX2jNDgnf7yEsTaLk5YTpbgt4tSxaDT0VRJCJTpQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm64/aes-blk - fix and move skcipher_walk_done
 out of kernel_neon_begin, _end
To: Jia He <hejianet@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jia He <jia.he@hxt-semitech.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 June 2018 at 09:05, Jia He <hejianet@gmail.com> wrote:
> In a arm64 server(QDF2400),I met a similar might-sleep warning as [1]:
> [    7.019116] BUG: sleeping function called from invalid context at
> ./include/crypto/algapi.h:416
> [    7.027863] in_atomic(): 1, irqs_disabled(): 0, pid: 410, name:
> cryptomgr_test
> [    7.035106] 1 lock held by cryptomgr_test/410:
> [    7.039549]  #0:         (ptrval) (&drbg->drbg_mutex){+.+.}, at:
> drbg_instantiate+0x34/0x398
> [    7.048038] CPU: 9 PID: 410 Comm: cryptomgr_test Not tainted
> 4.17.0-rc6+ #27
> [    7.068228]  dump_backtrace+0x0/0x1c0
> [    7.071890]  show_stack+0x24/0x30
> [    7.075208]  dump_stack+0xb0/0xec
> [    7.078523]  ___might_sleep+0x160/0x238
> [    7.082360]  skcipher_walk_done+0x118/0x2c8
> [    7.086545]  ctr_encrypt+0x98/0x130
> [    7.090035]  simd_skcipher_encrypt+0x68/0xc0
> [    7.094304]  drbg_kcapi_sym_ctr+0xd4/0x1f8
> [    7.098400]  drbg_ctr_update+0x98/0x330
> [    7.102236]  drbg_seed+0x1b8/0x2f0
> [    7.105637]  drbg_instantiate+0x2ac/0x398
> [    7.109646]  drbg_kcapi_seed+0xbc/0x188
> [    7.113482]  crypto_rng_reset+0x4c/0xb0
> [    7.117319]  alg_test_drbg+0xec/0x330
> [    7.120981]  alg_test.part.6+0x1c8/0x3c8
> [    7.124903]  alg_test+0x58/0xa0
> [    7.128044]  cryptomgr_test+0x50/0x58
> [    7.131708]  kthread+0x134/0x138
> [    7.134936]  ret_from_fork+0x10/0x1c
>
> Seems there is a bug in Ard Biesheuvel's commit.
> Fixes: 683381747270 ("crypto: arm64/aes-blk - move kernel mode neon
> en/disable into loop")
>
> [1] https://www.spinics.net/lists/linux-crypto/msg33103.html
>
> Signed-off-by: jia.he@hxt-semitech.com

Yes, that is a bug. My bad.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Please tag for stable (v4.17)


> ---
>  arch/arm64/crypto/aes-glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
> index 253188f..e3e5095 100644
> --- a/arch/arm64/crypto/aes-glue.c
> +++ b/arch/arm64/crypto/aes-glue.c
> @@ -223,8 +223,8 @@ static int ctr_encrypt(struct skcipher_request *req)
>                 kernel_neon_begin();
>                 aes_ctr_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
>                                 (u8 *)ctx->key_enc, rounds, blocks, walk.iv);
> -               err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
>                 kernel_neon_end();
> +               err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
>         }
>         if (walk.nbytes) {
>                 u8 __aligned(8) tail[AES_BLOCK_SIZE];
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
