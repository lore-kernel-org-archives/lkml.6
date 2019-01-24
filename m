Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE15C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D19E218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TO+6z/ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfAXKQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:16:35 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40592 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:16:35 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so3569448ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SwDObEh9OokimBV+T4T/grxG1yyhQk0b56zMiko/6I=;
        b=TO+6z/ki0ONeEuoS5OI2Q7jdQeuywhdXLvkekokMzMWiR5GQERwbrfV2mexOAoZ1GO
         b8I8iEvum5lYcQHoIy/2NIRn1k6gyBS6ejXQuiNFbKjsIVZ0ZP97oryjKm582yTvP3Zy
         /+UFbrj7Aj7S9k4WeZqssOQcus07F/KRphEkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SwDObEh9OokimBV+T4T/grxG1yyhQk0b56zMiko/6I=;
        b=ncPREvA7ZwezlyYBGYz8X3tky30lr0jDYFiahVCF2SiptjgesEv1KcmB4bqG6gFo1k
         9XxiiMliOTxa2cu6V4c3mA+UbeHGkHul+Fbg9lIj2JyF9CKbWSY4iiH6xX9WdasuRMNl
         w4kQg/GdhHvCiTlZKx1K+krqQ+Cwzc4MAQUxHv1rVAlbdpT1ohjrStxkwVZVmM2F0bTG
         NORoNE9JTWgXrUZ81GtLPajIr6KiTt21pwtZNFNnwylCPVcgrGHC+J20Tq3I4SfyIM6u
         20UkXjdlCcgiEfbHk3bHkRlIZcxbkrMIB1+colW4NxVuABf+/q+MLhG4z/5F+r/lrOtH
         jAvg==
X-Gm-Message-State: AJcUukf9P7Ut3W1IkWhmhftxknYffUHYNGFZkADtln4orWaM3l8tLnI+
        mwojFQBeAVTVhbV0vdf4TaKAyQVYNt5ovFcGIGKp+0XRzvA=
X-Google-Smtp-Source: ALg8bN68VTe9/KZuOypBEz8B822lYhOWK53rZDTATXA5TXHv+5gbAIzE2nQfBq8SRTj3ZlmcUr8yfW/om8B0HSYyp24=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr1140494ith.158.1548324994563;
 Thu, 24 Jan 2019 02:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20190123224926.250525-1-ebiggers@kernel.org> <20190124084818.GA650@sol.localdomain>
 <CAKv+Gu9zridWAYO3cR_KAAbupWfLd+FAMmcgAMuYE5Lgxoek-w@mail.gmail.com> <20190124092359.hvizqdi2ptjdsot7@gondor.apana.org.au>
In-Reply-To: <20190124092359.hvizqdi2ptjdsot7@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 24 Jan 2019 11:16:23 +0100
Message-ID: <CAKv+Gu_C5p1pf_+8Ci+y8GGRr4OHEN8FwLJHnvu=wq3bTzGrYA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 00/15] crypto: improved skcipher, aead, and hash tests
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 10:24, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jan 24, 2019 at 09:50:35AM +0100, Ard Biesheuvel wrote:
> >
> > Thanks for yet another round of cleanup
> >
> > I'll look into these, but I'd like to clarify one thing first.
> >
> > IIUC, you are trying to deal with the case where a single scatterlist
> > element describes a range that strides two pages, and I wonder if that
> > is a valid use of scatterlists in the first place.
> >
> > Herbert?
>
> Yes it is valid.  IIRC the network stack may generate such a
> scatterlist.
>

OK, so how many adjacent physical pages is a scatterlist entry
permitted to cover? Unbounded?
