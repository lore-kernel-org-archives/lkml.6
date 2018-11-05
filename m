Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B5C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DA220825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJptL+Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DA220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeKETj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:39:29 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53832 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKETj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:39:28 -0500
Received: by mail-it1-f195.google.com with SMTP id r12-v6so9107232ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VhdvL1uLGtlLDhJabG/pQgJeee3A3ZGaGzNYTsDl2cM=;
        b=KJptL+XjWSYq2VyQ5VSBPJbYELstFfzzcNH1PN0wN0+4Htju18DiCreXlTg+RfXJ/0
         k0EvS31NWZO9qX+w2y/VGE/Ib1LvIQ6X4TuvkgotpG6H7TjcmmDnNbQiFRQUVgDt0VLj
         BCl3ehT87z4DF3paIKe7DQnDkveaWU7OJZb10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VhdvL1uLGtlLDhJabG/pQgJeee3A3ZGaGzNYTsDl2cM=;
        b=VNkxywa9y5zc6WFQqGgcsAk57y+rHVAhBnkX3zlm6eRMgVwsiH6CPVKRn9HocAoCVy
         iqhNRQYjm/PjXEvURZKC+ean+ECD4KiqjyX2CZQbWeq6EzXziZi1BgRgXkys1Xs29qFQ
         J5h421AVHSlg+fBs84N9kOYpjg9hnUHhQ5MNA3lMAwzLdsPO8V8H2RT8NZozVY1CFpQl
         qs522F2VWXg6D4Zq8wS2qcVb+JfpJb/Kx26z/XwnvMUc911Q/nYuxmOI1MTMB3i7iIPX
         4EsDRy/Jz5HtiO1++Rc3GHcTqsh8cqT3SHg3DITDpLndRfw9ezbWJKF0RxUKrNso0Nye
         y9Fw==
X-Gm-Message-State: AGRZ1gKtLNQENCLfupAdY70eeXVisgMChqP18VKIwCmZcEOFhllafBT3
        /gwJXpOEcUN13yQxqH4thJH99+075zeNf7NF1JuGaA==
X-Google-Smtp-Source: AJdET5dmfRinnApLdMyfoDOXhe3vPmm2qAbVebEfDu/sdrxQyplaybCZ1YwVAW8Z+PLkMJJbcOFBb5LJHcYr2adGmdE=
X-Received: by 2002:a02:9f85:: with SMTP id a5-v6mr19822545jam.2.1541413228819;
 Mon, 05 Nov 2018 02:20:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 02:20:28 -0800 (PST)
In-Reply-To: <CAOtvUMeRth4zrTZbEy6Co=+CR4==5oSDbaf760Yh4fj8UAf8bQ@mail.gmail.com>
References: <1541325924-14777-1-git-send-email-gilad@benyossef.com>
 <2578248.XAorIH2ink@tauon.chronox.de> <CAOtvUMeRth4zrTZbEy6Co=+CR4==5oSDbaf760Yh4fj8UAf8bQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 11:20:28 +0100
Message-ID: <CAKv+Gu8x1LRKq4xJTrWfu7vQDPSzxYwEYGXG_o3Xv+Zsch9S-g@mail.gmail.com>
Subject: Re: [PATCH] crypto: mark cts(cbc(aes)) as FIPS allowed
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 10:18, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> Hi Stephan,
>
> On Mon, Nov 5, 2018 at 10:50 AM Stephan Mueller <smueller@chronox.de> wrote:
>>
>> Am Sonntag, 4. November 2018, 11:05:24 CET schrieb Gilad Ben-Yossef:
>>
>> Hi Gilad,
>>
>> > As per Sp800-38A addendum from Oct 2010[1], cts(cbc(aes)) is
>> > allowed as a FIPS mode algorithm. Mark it as such.
>> >
>> > [1] https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
>>
>> There are several types of CTS approaches. Only three of those are listed in
>> the SP800-38A addendum. The source code only refers to some RFCs.
>>
>> Did you check whether the CTS implementation matches one or more of the types
>> listed in the addendum? If yes, may I suggest to add a small statement in the
>> code noting this fact?
>
> Yes, AFAIK the software implements CBC-CS3 as described in the document.
> You have a very good point about this not document anywhere. I will
> send a patch.
>

I agree that it makes sense to document this.

> While we're at it, does someone find it useful if I implemented the
> other two modes?
> They are part of the standard as well, although I am not sure that in
> itself is sufficient cause.
>

Nope. The linux crypto API is not a general purpose cryptography
toolkit, it should only offer what we actually use in the kernel, or
we'll either end up with bitrot or with a disproportionate maintenance
burden for stuff nobody actually uses.
