Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A96ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538AE20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3pyKlOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538AE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeGRQMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:12:22 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43244 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbeGRQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:12:22 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so4440215ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ItGYnOyuplg5zeX7jLigHkp90Z2TlK+7g801IPBHHMA=;
        b=Z3pyKlOgFBHdPdB55YUZdQICDgplLeYdraOa113wD9ezTNOH0ZAVPypj6mlNoMsGEH
         B8RnHaOfpqe5LEftSKNAlZhpXWXul5POwBJFjX4ICSXN5XsnYXDK6IzLjIQZpBJIHrro
         +Zu7y2JEy+bP2IFfSQI+gQa9B/YY+IrIRCuT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ItGYnOyuplg5zeX7jLigHkp90Z2TlK+7g801IPBHHMA=;
        b=OkaFdyzf79BmGpezcF1RxsXIhqYyKE2mNmTO26XLxcZ3BQGvKYFDKBkYictycG8+Rk
         rn6MaOP6WPzwPDTReK1IbD4Z1l6T5m8foazbljdLejinGQoJrUJ/yxyxXnszamt5lhAo
         YQctUBXX02Dc38FF28wrzdrMkQFuTDidGku4aZizF549dOMeiVjjLXvK46wYsI4aWc4S
         B312RuEXxHrdiCCOHyziuSAoizWxSVLDLIC9YbESuh1dnf3uiNBvpadSB697uAYec8nT
         44GVv7d+UYu1aWMmYUpeQdZa2WmZZSLoG+Gr2ASfLaEobYeTc37+3Fcrl94yj/l3AcXk
         yaRg==
X-Gm-Message-State: AOUpUlF2leISRAEMuYBiZdQxwihGC7SZIpZZaXu0mnQacpL7tqLFTmVL
        7Ym57Pr5lkzevwr9NvLXQik1mRZ6y4L6gP/MYyLvFw==
X-Google-Smtp-Source: AAOMgpdgZl8CdkkN4Tfuk23O6bgmU/s9zFlJHpHlafG0qrbZU4x7B/gANXiLb9YvGlqv3ucrWo+wla/qF7XXewu//hY=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr5367001iof.173.1531928034941;
 Wed, 18 Jul 2018 08:33:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:33:54
 -0700 (PDT)
In-Reply-To: <CAK8P3a3C1ihC=X=kZ0S836xeMJSGSy6OLNAcBEkdZ35N04bAMw@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
 <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
 <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
 <CAKv+Gu-cOV6uo6MpLxr9uQSTT-ku_wn9+D7CC4+3maJtvcaGoA@mail.gmail.com>
 <CAKv+Gu8e9sm42NKwQvQzD33JTHSaEY2q7sm0W0065dDz_rzSaA@mail.gmail.com> <CAK8P3a3C1ihC=X=kZ0S836xeMJSGSy6OLNAcBEkdZ35N04bAMw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Jul 2018 00:33:54 +0900
Message-ID: <CAKv+Gu-NBKxzV5PYAuzeP5xXfsk=Kw41677ASzRkD6=xO23zeQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Arnd Bergmann <arnd@arndb.de>
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

On 19 July 2018 at 00:33, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jul 18, 2018 at 5:19 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 18 July 2018 at 23:50, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> On 18 July 2018 at 05:59, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Sun, Jul 15, 2018 at 6:28 AM, Kees Cook <keescook@chromium.org> wrote:
>>>>>
>>>>> After my ahash to shash conversions, only ccm is left as an ahash
>>>>> user, since it actually uses sg. But with the hard-coded value reduced
>>>>> to 376, this doesn't trip the frame warnings any more. :)
>>>>>
>>>>> I'll send an updated series soon.
>>>>
>>>> Maybe we should get rid of that one as well then and remove
>>>> AHASH_REQUEST_ON_STACK()?
>>>>
>>>> I see that Ard (now on Cc) added this usage only recently. Looking
>>>> at the code some more, I also find that the descsize is probably
>>>> much smaller than 376 for all possible cases   of "cbcmac(*)",
>>>> either alg->cra_blocksize plus a few bytes or sizeof(mac_desc_ctx)
>>>> (i.e. 20) for arch/arm64/crypto/aes-glue.c.
>>>>
>>>> Walking the sglist here means open-coding a shash_ahash_update()
>>>> implementation in crypto_ccm_auth(), that that doesn't seem to
>>>> add much complexity over what it already has to do to chain
>>>> the sglist today.
>>>>
>>>
>>> It would be better to add a variably sized ahash request member to
>>> struct crypto_ccm_req_priv_ctx, the only problem is that the last
>>> member of that struct (skreq) is variably sized already, so it would
>>> involve having a struct ahash_request pointer pointing into the same
>>> struct, after the skreq member.
>>
>> Actually, I think the below should already do the trick: ahreq and
>> skreq are not used at the same time, so we can stick them in a union,
>> and take the max() of the reqsize to ensure there's enough empty space
>> after it.
>
> This looks very nice indeed.
>
>> --------8<----------
>> diff --git a/crypto/ccm.c b/crypto/ccm.c
>> index 0a083342ec8c..b242fd0d3262 100644
>> --- a/crypto/ccm.c
>> +++ b/crypto/ccm.c
>> @@ -50,7 +50,10 @@ struct crypto_ccm_req_priv_ctx {
>>         u32 flags;
>>         struct scatterlist src[3];
>>         struct scatterlist dst[3];
>> -       struct skcipher_request skreq;
>> +       union {
>> +               struct ahash_request ahreq;
>> +               struct skcipher_request skreq;
>> +       };
>>  };
>>
>
> And this structure is never put on the stack anywhere but
> always dynamically allocated anyway, right?
>

Yes.
