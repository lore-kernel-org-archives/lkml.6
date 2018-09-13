Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B513C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01E020869
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ph1kLtpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01E020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeIMURF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:17:05 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39752 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeIMURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:17:05 -0400
Received: by mail-it0-f65.google.com with SMTP id h1-v6so8139806itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kvIV91aPNn5SA+AG9Ippjbb3td7Qp9sxqO5jjn7UwEQ=;
        b=Ph1kLtpecTHq4+pHUwQRTs7YaMYxMRatrij1EO4QlYBtFBFesrcpbn3x+qOvGq3UzT
         XLVuktgaToihj1kdJE1ZtxC3kYlT9hTpRJOi2EITaA5Jyi6KZrJKJbzzyW9TGNrrHXMH
         aaWeRVcFNVseZG3rNTx7JczXa+X6blXWllpQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kvIV91aPNn5SA+AG9Ippjbb3td7Qp9sxqO5jjn7UwEQ=;
        b=QNdlTSiQ8DOpx56wDS3OSZyCoa3qI7C8oL3W3iMZo8paGcbvUsQViszq0iznOacgZ+
         tyerZrI9S2d78Q4wkoyt9RP9H5M2xVzT3Q070KGeIfcCaQkGsX5oRWMe5TO5WUKe9mDf
         f5PEIH27WH/gPFrs9sbReQR24iv5rvSNQZJ6jNj5s37CvprNvwE4i+iN4qbu85LL+pQj
         gpNZKpXAFwNfa797je+gfVQuHDt7y23xLdVIvflPNeqQtWU5RIrE9aBcHpbSojA9iUWc
         /bdpa9EKmHXjFLp8lTbRoHB8jj+6I5SwiFhRZmTrJE1ZEa3vLpcr/u40orBAIAK5OyMa
         03Ng==
X-Gm-Message-State: APzg51DquMSe2+DIKgku8zNzjWrKw3gLJG9HK4eljzAmN+48XWMyuUnY
        aNZE3Pbb3TF4Ip4QJ4SOq0oeFOM/az4OcxRC3ix5MmQ+FKaHWg==
X-Google-Smtp-Source: ANB0VdZ9S8+r6T9s75jCFRxkoe6+5RBHWmQIyZMkVwb/lumV3xB0s4021cX9leorzIYdBVjSGswiquwpNo/fqfc8prw=
X-Received: by 2002:a02:4d1b:: with SMTP id l27-v6mr6988376jab.86.1536851229511;
 Thu, 13 Sep 2018 08:07:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 08:07:08
 -0700 (PDT)
In-Reply-To: <CAHmME9pp8HoisxQWL_eELR-ziiBii-7mcA=oF9UF-WMucewX5w@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com> <CAHmME9pp8HoisxQWL_eELR-ziiBii-7mcA=oF9UF-WMucewX5w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Sep 2018 17:07:08 +0200
Message-ID: <CAKv+Gu-CVsXQmx1BZQMe__LREvWEigd2FdoA2ErLu1ky6gzHtw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 September 2018 at 16:18, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Thu, Sep 13, 2018 at 1:45 AM Andy Lutomirski <luto@kernel.org> wrote:
>> I'm not convinced that there's any real need for *all* crypto
>> algorithms to move into lib/zinc or to move at all.  As I see it,
>> there are two classes of crypto algorithms in the kernel:
>>
>> a) Crypto that is used by code that chooses its algorithm statically
>> and wants synchronous operations.  These include everything in
>> drivers/char/random.c, but also a bunch of various networking things
>> that are hardcoded and basically everything that uses stack buffers.
>> (This means it includes all the code that I broke when I did
>> VMAP_STACK.  Sign.)
>
> Right, exactly. This is what will wind up using Zinc. I'm working on
> an example usage of this for v4 of the patch submission, which you can
> ogle in a preview here if you're curious:
>
> https://git.zx2c4.com/linux-dev/commit/?h=big_key_rewrite
>
> 28 insertions, 206 deletions :-D
>

I must say, that actually looks pretty good.

>> b) Crypto that is used dynamically.  This includes dm-crypt
>> (aes-xts-plain64, aes-cbc-essiv, etc), all the ALG_IF interfaces, a
>> lot of IPSEC stuff, possibly KCM, and probably many more.  These will
>> get comparatively little benefit from being converted to a zinc-like
>> interface.  For some of these cases, it wouldn't make any sense at all
>> to convert them.  Certainly the ones that do async hardware crypto
>> using DMA engines will never look at all like zinc, even under the
>> hood.
>
> Right, this is what the crypto API will continue to be used for.
>
>
>> I think that, as a short-term goal, it makes a lot of sense to have
>> implementations of the crypto that *new* kernel code (like Wireguard)
>> wants to use in style (a) that live in /lib, and it obviously makes
>> sense to consolidate their implementations with the crypto/
>> implementations in a timely manner.  As a medium-term goal, adding
>> more algorithms as needed for things that could use the simpler APIs
>> (Bluetooth, perhaps) would make sense.
>
> Agreed 100%. With regards to "consolidate their implementations" --
> I've actually already done this after your urging yesterday, and so
> that will be a part of v4.
>
>> But I see no reason at all that /lib should ever contain a grab-bag of
>> crypto implementations just for the heck of it.  They should have real
>> in-kernel users IMO.  And this means that there will probably always
>> be some crypto implementations in crypto/ for things like aes-xts.
>
> Right, precisely.
>
> Jason
