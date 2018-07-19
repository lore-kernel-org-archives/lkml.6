Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA93ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EA820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZ/EAr3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EA820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeGSDgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:36:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34866 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbeGSDgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:36:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so3139258pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0sNpjrW60XxXyYIzpyrwCVw/9tYxwVrRdZDLNLSy7oM=;
        b=MZ/EAr3G65xc1wXBbi/Fhn7ds///ARDb/YK098Hm4tyQhc0NAbqpqQO+nTQLS2WF7i
         Sq6PlBN+YXM4mYJWWOutyROq5DCa10UmEtxksuA8T/WASZaS527HD76AFIg2VwpbZUYf
         oczcsGL2KhxyiTwzIlmTFCsjyN+2k4fSmY63g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0sNpjrW60XxXyYIzpyrwCVw/9tYxwVrRdZDLNLSy7oM=;
        b=H71uBJXAdNvBNEwNhD0M9zAW5fFgiWDpHhzpkdWy1ISBso4nIyeXIgd3WA+1RC5Xx0
         oPU9pf2kLeoRinmmibHXVerx+1xMWDIuggFRmSmuyOToKdG936KsQHs54p847G2LgQZx
         7QiDSCuz9wTLJCO6EINt0pgJ/zBOt+wKlHhWwIRea7wMkxbWdViCe26lr/nIzjOpdieI
         0v3XU7y6SWay/keNUZiA7THCptnDwtlVcwzs3qNYuZyTdU7UuS6ykf/s3BYuvlzclwoX
         XuZ3zPN2QbzcBVRBA2sc+q3NJeH7OCND4LM0ph7aU2uFhkO15bFYwGXrwMwjycPdOfzv
         Tn6Q==
X-Gm-Message-State: AOUpUlESLmw6fmxdLcdR1Pkfb719ANxrt7OMntyzPMDpLjGr9ocP5Qu8
        2RlCvddfw46MsUMt/ZdiJXAOQw==
X-Google-Smtp-Source: AAOMgpf46WxodKPK0HAx6LzNoBQMT1nL1Rk8T3ZRn5nAuNAnmqYdPSW13tNttC37mLubjuZgh0ufGA==
X-Received: by 2002:a63:4a07:: with SMTP id x7-v6mr8248262pga.34.1531968954368;
        Wed, 18 Jul 2018 19:55:54 -0700 (PDT)
Received: from [192.168.43.86] (om126204197014.6.openmobile.ne.jp. [126.204.197.14])
        by smtp.gmail.com with ESMTPSA id e2-v6sm5823728pgo.92.2018.07.18.19.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 19:55:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAGXu5jLuWfZFTs390c3WSAReLrQ6_KOOvr0FYjXhUQ5h5b8xWA@mail.gmail.com>
Date:   Thu, 19 Jul 2018 11:55:51 +0900
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <B278D0F7-71B6-4F3D-B625-D8B0298CE5B4@linaro.org>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org> <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com> <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com> <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com> <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com> <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com> <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com> <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com> <CAKv+Gu-cOV6uo6MpLxr9uQSTT-ku_wn9+D7CC4+3maJtvcaGoA@mail.gmail.com> <CAKv+Gu8e9sm42NKwQvQzD33JTHSaEY2q7sm0W0065dDz_rzSaA@mail.gmail.com> <CAGXu5jLuWfZFTs390c3WSAReLrQ6_KOOvr0FYjXhUQ5h5b8xWA@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 19 Jul 2018, at 11:51, Kees Cook <keescook@chromium.org> wrote:
>=20
> On Wed, Jul 18, 2018 at 8:19 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 18 July 2018 at 23:50, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrot=
e:
>>>> On 18 July 2018 at 05:59, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> On Sun, Jul 15, 2018 at 6:28 AM, Kees Cook <keescook@chromium.org> wro=
te:
>>>>>=20
>>>>> After my ahash to shash conversions, only ccm is left as an ahash
>>>>> user, since it actually uses sg. But with the hard-coded value reduced=

>>>>> to 376, this doesn't trip the frame warnings any more. :)
>>>>>=20
>>>>> I'll send an updated series soon.
>>>>=20
>>>> Maybe we should get rid of that one as well then and remove
>>>> AHASH_REQUEST_ON_STACK()?
>>>>=20
>>>> I see that Ard (now on Cc) added this usage only recently. Looking
>>>> at the code some more, I also find that the descsize is probably
>>>> much smaller than 376 for all possible cases   of "cbcmac(*)",
>>>> either alg->cra_blocksize plus a few bytes or sizeof(mac_desc_ctx)
>>>> (i.e. 20) for arch/arm64/crypto/aes-glue.c.
>>>>=20
>>>> Walking the sglist here means open-coding a shash_ahash_update()
>>>> implementation in crypto_ccm_auth(), that that doesn't seem to
>>>> add much complexity over what it already has to do to chain
>>>> the sglist today.
>>>>=20
>>>=20
>>> It would be better to add a variably sized ahash request member to
>>> struct crypto_ccm_req_priv_ctx, the only problem is that the last
>>> member of that struct (skreq) is variably sized already, so it would
>>> involve having a struct ahash_request pointer pointing into the same
>>> struct, after the skreq member.
>>=20
>> Actually, I think the below should already do the trick: ahreq and
>> skreq are not used at the same time, so we can stick them in a union,
>> and take the max() of the reqsize to ensure there's enough empty space
>> after it.
>>=20
>> --------8<----------
>> diff --git a/crypto/ccm.c b/crypto/ccm.c
>> index 0a083342ec8c..b242fd0d3262 100644
>> --- a/crypto/ccm.c
>> +++ b/crypto/ccm.c
>> @@ -50,7 +50,10 @@ struct crypto_ccm_req_priv_ctx {
>>        u32 flags;
>>        struct scatterlist src[3];
>>        struct scatterlist dst[3];
>> -       struct skcipher_request skreq;
>> +       union {
>> +               struct ahash_request ahreq;
>> +               struct skcipher_request skreq;
>> +       };
>> };
>>=20
>> struct cbcmac_tfm_ctx {
>> @@ -181,7 +184,7 @@
>>        struct crypto_ccm_req_priv_ctx *pctx =3D crypto_ccm_reqctx(req);
>>        struct crypto_aead *aead =3D crypto_aead_reqtfm(req);
>>        struct crypto_ccm_ctx *ctx =3D crypto_aead_ctx(aead);
>> -       AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
>> +       struct ahash_request *ahreq =3D &pctx->ahreq;
>>        unsigned int assoclen =3D req->assoclen;
>>        struct scatterlist sg[3];
>>        u8 *odata =3D pctx->odata;
>> @@ -427,7 +430,7 @@
>>        crypto_aead_set_reqsize(
>>                tfm,
>>                align + sizeof(struct crypto_ccm_req_priv_ctx) +
>> -               crypto_skcipher_reqsize(ctr));
>> +               max(crypto_ahash_reqsize(mac), crypto_skcipher_reqsize(ct=
r)));
>>=20
>>        return 0;
>=20
> Oh, this is lovely! Thank you! Shall I add your S-o-b and add it to the se=
ries?
>=20

I have only build tested it, so if you make sure that it does not break anyt=
hing, please go ahead.




