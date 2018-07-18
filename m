Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA3FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584ED2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGcfV5TT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584ED2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGRQLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:11:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43843 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbeGRQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:11:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so4480866ljg.10;
        Wed, 18 Jul 2018 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=x/GN+lkf5KiCNwrdMPuO+EbHsC/GSKAfP1lGHWuE6SM=;
        b=jGcfV5TTYduunuiMPRf9jlBMi+CaYZPmWsnd1tVnGD+IbozHlLOQmY1sHBraLuwFL1
         loU93OtM1klhoUmaWQViJymGY7mbwj5JC/F1LmNwjwyFvkTh4DSux4WIeJhQtCmT8vdp
         iHvrh+LFBTQsfcl0N2OKm8iWRbunusU7FWo5IKZC18o7oA+qWWsugPeDM9vJUCwsdt99
         zeEUMcXaiXsluIiMbTDFmxNUDeZWhlVDc4RTeHdpetDyELBtiDUs2EPuqgGmUQ+thAsy
         gS0C4bvVvDzeErstsEz9gevebjBX92G/hZMyS4gKLqbMdapl4FQ6GW/heAQHy8bp2tIO
         qRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=x/GN+lkf5KiCNwrdMPuO+EbHsC/GSKAfP1lGHWuE6SM=;
        b=mcgsCKom6vA6QSuNRAV2RdGqsMGyPLgaqsZhsUvfNIez2yqPlFhUfhpCzlvLDv0Wce
         uqDbJTm0lJ/xDqQ8yCWEt+9KiX9myyUh0nQe7bfeiIZEbd1wro//Afw/UzkDvGwNocBK
         wly855s/+mCNIf1UAAGgXE4Jo7CpWMkzy0sGH6UCD1WUxDGLpsAvdwlG6lC+dIiYkXo/
         22+TkaOcRb1glg3hKiTV1XufJJlKW2gA0XAvWifGHdKTNZTJusheDytVnLcRZTA4OM5O
         Ssr6o/jZrgykB/AJaUYrg2o7NDP+SCfvkahhbqrMf7uXjaZmA3qOllk2KRGEPqO9UZsb
         XZHA==
X-Gm-Message-State: AOUpUlFmajbUZw4lfr1gS6rbWP8JD5HbJO4P3bL9VaR+e0Xptjvwe77T
        68NSiPLqSeoyQFHzguWuj1ebL3pnU4CoHhV+rhE=
X-Google-Smtp-Source: AAOMgpdt3K72AdDxfF7hSK3LjiVX9lzaS+kGm2Emc/Wb5eq2YeDj85PH+mcRPrs0QVwYljXMKPh/u0CkU+RyN9gwqKI=
X-Received: by 2002:a2e:1dc8:: with SMTP id w69-v6mr5284032lje.110.1531927989559;
 Wed, 18 Jul 2018 08:33:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:33:08
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
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Jul 2018 17:33:08 +0200
X-Google-Sender-Auth: zhH7kv3a7sbC4Pa3IO-KFzjNBPg
Message-ID: <CAK8P3a3C1ihC=X=kZ0S836xeMJSGSy6OLNAcBEkdZ35N04bAMw@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Wed, Jul 18, 2018 at 5:19 PM, Ard Biesheuvel
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

This looks very nice indeed.

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

And this structure is never put on the stack anywhere but
always dynamically allocated anyway, right?

      Arnd
