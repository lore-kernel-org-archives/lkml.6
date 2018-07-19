Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F44ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ABA20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Lhskft0o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOmWXqeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ABA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeGSDcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:32:23 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34345 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbeGSDcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:32:23 -0400
Received: by mail-yw0-f194.google.com with SMTP id j68-v6so2534022ywg.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KuU6+nD/oyDDeUdJLTaJDLJAmmYMfTT9s8JrHu5/fWM=;
        b=Lhskft0optQ8YiATlf8Kkd0IYvV7sYUaJQB5Qw/6l72ECrUIWOVGqLKy+QOf3jlcKc
         BgtMBpbf3hog/KbM70NvgFlT0haMENvWVvzNaPNAqT2gf1U1d1Ik1v2o94zwRpXytVZE
         /VUcSird93vbs7x6rdzMRTbLunnX42WpB5FZ1dKLiL9uIVsaqrj2Y8SCW1zqEnLWiGL/
         YIEQPRyJ5vmZWmLaRpolA5foB30iyHTQVQWdVvB6nJUXtgCXjjPWlLSMvWPhOaIUI6ZS
         ENq5Oa+yxs+FgUKwmZOLbx8/t6h8tiRZq/V424FnvGtGliu3wyhWiZwQqrW+oRCgLPGw
         HNCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KuU6+nD/oyDDeUdJLTaJDLJAmmYMfTT9s8JrHu5/fWM=;
        b=lOmWXqeZtk/P8skHJ1XHa7snUnRUANuOjJ/jucqhIjfNO3pO/cIeda3KzB0jaP/Yuz
         hwtQ/ntGUx93bN4uBuLoB6/ktRngLDYrBz8912X25ywF1iT6Kz4+95VyuGOr38uv+tw7
         n8FDkqUKBetFXGmdwYgu+9uZXJyVV8M3HfXCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KuU6+nD/oyDDeUdJLTaJDLJAmmYMfTT9s8JrHu5/fWM=;
        b=r/SOcNVVtDN9ZTa0vkFbyRtglQE0mOHh4gO2kGiqJ99WcjSVKOPIE6ur60RN3dK1kD
         g9nbHVFJasBUbtP4rLaEs0CtKqcq8r9eKJxWIh37FAAuwQsyztDHESpyBspW2BEPK0/5
         vJiW2nPT3DtTzMkP5erpCSD9unEEIaIoLSHSiwO8Plj0oyNxA5SE06KSIhSPJTwcWzkG
         TGXLobrRpCMSrn3KpAgmGcGbxsYQD7j2iz1O3/+vi6u5hIyXO1iEJlNnE9iYjoezXFaM
         GJFVRIRmvP36VGaPpdEChoyTDzyeEhTPwQnMixkPWsWi2+NEiND5laJJ2x0M2IMmhtom
         ZQWQ==
X-Gm-Message-State: AOUpUlFTFWF/9IzX+wpzw1K5xXAN1/QEvt8c+tqWlfBNLf132j/zpXf7
        hf6xFi5i5wCf0lZ1iy7SiTRHcmViVntmBwQCca2I9Q==
X-Google-Smtp-Source: AAOMgpcfO0qY+UD8l5UHqog7MJzBQamvwaXfmn1QG+FIZBAZKhspUQ82yyGmAO/RKUZYNevlEp1JhK/FCjMwuZQdtko=
X-Received: by 2002:a81:39d7:: with SMTP id g206-v6mr4525897ywa.416.1531968692614;
 Wed, 18 Jul 2018 19:51:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 19:51:31
 -0700 (PDT)
In-Reply-To: <CAKv+Gu8e9sm42NKwQvQzD33JTHSaEY2q7sm0W0065dDz_rzSaA@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
 <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
 <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
 <CAKv+Gu-cOV6uo6MpLxr9uQSTT-ku_wn9+D7CC4+3maJtvcaGoA@mail.gmail.com> <CAKv+Gu8e9sm42NKwQvQzD33JTHSaEY2q7sm0W0065dDz_rzSaA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 18 Jul 2018 19:51:31 -0700
X-Google-Sender-Auth: WSD8YtqyzFH_mXzJ14JgK7eRrzA
Message-ID: <CAGXu5jLuWfZFTs390c3WSAReLrQ6_KOOvr0FYjXhUQ5h5b8xWA@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 8:19 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 18 July 2018 at 23:50, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 18 July 2018 at 05:59, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Sun, Jul 15, 2018 at 6:28 AM, Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> After my ahash to shash conversions, only ccm is left as an ahash
>>>> user, since it actually uses sg. But with the hard-coded value reduced
>>>> to 376, this doesn't trip the frame warnings any more. :)
>>>>
>>>> I'll send an updated series soon.
>>>
>>> Maybe we should get rid of that one as well then and remove
>>> AHASH_REQUEST_ON_STACK()?
>>>
>>> I see that Ard (now on Cc) added this usage only recently. Looking
>>> at the code some more, I also find that the descsize is probably
>>> much smaller than 376 for all possible cases   of "cbcmac(*)",
>>> either alg->cra_blocksize plus a few bytes or sizeof(mac_desc_ctx)
>>> (i.e. 20) for arch/arm64/crypto/aes-glue.c.
>>>
>>> Walking the sglist here means open-coding a shash_ahash_update()
>>> implementation in crypto_ccm_auth(), that that doesn't seem to
>>> add much complexity over what it already has to do to chain
>>> the sglist today.
>>>
>>
>> It would be better to add a variably sized ahash request member to
>> struct crypto_ccm_req_priv_ctx, the only problem is that the last
>> member of that struct (skreq) is variably sized already, so it would
>> involve having a struct ahash_request pointer pointing into the same
>> struct, after the skreq member.
>
> Actually, I think the below should already do the trick: ahreq and
> skreq are not used at the same time, so we can stick them in a union,
> and take the max() of the reqsize to ensure there's enough empty space
> after it.
>
> --------8<----------
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
> @@ -181,7 +184,7 @@
>         struct crypto_ccm_req_priv_ctx *pctx = crypto_ccm_reqctx(req);
>         struct crypto_aead *aead = crypto_aead_reqtfm(req);
>         struct crypto_ccm_ctx *ctx = crypto_aead_ctx(aead);
> -       AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
> +       struct ahash_request *ahreq = &pctx->ahreq;
>         unsigned int assoclen = req->assoclen;
>         struct scatterlist sg[3];
>         u8 *odata = pctx->odata;
> @@ -427,7 +430,7 @@
>         crypto_aead_set_reqsize(
>                 tfm,
>                 align + sizeof(struct crypto_ccm_req_priv_ctx) +
> -               crypto_skcipher_reqsize(ctr));
> +               max(crypto_ahash_reqsize(mac), crypto_skcipher_reqsize(ctr)));
>
>         return 0;

Oh, this is lovely! Thank you! Shall I add your S-o-b and add it to the series?

-Kees

-- 
Kees Cook
Pixel Security
