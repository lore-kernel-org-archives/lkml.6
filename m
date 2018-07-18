Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA79ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609722075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TznRaq0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609722075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbeGRP24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:28:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46398 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbeGRP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:28:56 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so4301114ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6PqGTrnoFqomKK2IGI+iecZRX7MxoapEwQIIosfEGs0=;
        b=TznRaq0sedNyZPRo7D+KHVxf5s+3/oGdBjSfA5tZTQnBw7md0pmnpAua9W+0I2PIgL
         qcqaBj4suk/ywz7ZLfv5BQz3xYjkN76iIQl2LOVYAtIcaRumb9Y1g4eRfYyMG/OUM3oG
         6G82NDNI6Skhe+JxPq2HIV6vdmA6eD9U6om6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6PqGTrnoFqomKK2IGI+iecZRX7MxoapEwQIIosfEGs0=;
        b=IMvOlaIr8jO7Ee0hrBcih5VBaOR9lb9nKFnjhAJ7DFuYGEwZNocZNVYcM686Q/X2Xo
         h80Ygtcu8yuV4N0QTPYUV6M+iqD25jYuJM0lFm/59+tkfeOMuNYDr0W/Kg11T2xvUHAY
         MAj+W8zavHl7YIiCkEdkcZqMtENoqWHhzgijCvyC5m8Rtuhl0mmmzGqfgm9+AzBZTN9y
         +P68VKyEIUxvvgoT4cjBIyc6Wex7DX0ih9quf2RHRqwoI17rI2HVNn/Gv9FBq1u+0mBG
         ge3kmDKyhPBefaQB0aKxmQL9sxY0RNJvxzQwtd9VEqfdWj5wN1lib5ab/f+jNYF0y11v
         2hmg==
X-Gm-Message-State: AOUpUlHNgxoLw7gvDljZsowX5Wg5FOoYaHMp9yGcc3GqQBB5TTGAzL79
        KwPcP1O2E4k6DJ5EYJwhIfw9Mr0fQMYeT9SoCrEUcA==
X-Google-Smtp-Source: AAOMgpfK837Fwp8zQIJtcYHMxxAqTRIle9HeFVbsniQ4J1M2ySlLZR3kTcK0924mS3Iw1C5cDFTiaXGvLNRAgaoSeuY=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr5516940iob.60.1531925439854;
 Wed, 18 Jul 2018 07:50:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 07:50:39
 -0700 (PDT)
In-Reply-To: <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
 <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com> <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 18 Jul 2018 23:50:39 +0900
Message-ID: <CAKv+Gu-cOV6uo6MpLxr9uQSTT-ku_wn9+D7CC4+3maJtvcaGoA@mail.gmail.com>
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

On 18 July 2018 at 05:59, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Jul 15, 2018 at 6:28 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> After my ahash to shash conversions, only ccm is left as an ahash
>> user, since it actually uses sg. But with the hard-coded value reduced
>> to 376, this doesn't trip the frame warnings any more. :)
>>
>> I'll send an updated series soon.
>
> Maybe we should get rid of that one as well then and remove
> AHASH_REQUEST_ON_STACK()?
>
> I see that Ard (now on Cc) added this usage only recently. Looking
> at the code some more, I also find that the descsize is probably
> much smaller than 376 for all possible cases   of "cbcmac(*)",
> either alg->cra_blocksize plus a few bytes or sizeof(mac_desc_ctx)
> (i.e. 20) for arch/arm64/crypto/aes-glue.c.
>
> Walking the sglist here means open-coding a shash_ahash_update()
> implementation in crypto_ccm_auth(), that that doesn't seem to
> add much complexity over what it already has to do to chain
> the sglist today.
>

It would be better to add a variably sized ahash request member to
struct crypto_ccm_req_priv_ctx, the only problem is that the last
member of that struct (skreq) is variably sized already, so it would
involve having a struct ahash_request pointer pointing into the same
struct, after the skreq member.
