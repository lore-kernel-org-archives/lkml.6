Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A810FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60900217BD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2PmTAHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60900217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbeHGOXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:23:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37209 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeHGOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:23:08 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so22615518itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3YM5yxBcH2gTdV4OwCJxQXs9pMmR63KgjLeLzs4d3So=;
        b=b2PmTAHHbywT7/bZXcFqsSiBpdTzV5RotckvdzUEfCeYy3zAzTU24K5oZGy7BUYOqs
         YRlWdc5yxW+L1O2rXea+yd0LjXaNzq83QBdDNMGCvdpQYggZs0G7CMqsznG1Gx/WNEen
         iujfszPNDeFE90hA3PPVixa8kUnMICQoEv8Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3YM5yxBcH2gTdV4OwCJxQXs9pMmR63KgjLeLzs4d3So=;
        b=jI7UmcOJC8Xg661XwN9x7ct4Yl6EZLMr0ZF8k1QmYorXPlXnowIe7h30eipR2NsX5Z
         LiGlteQqt9mB0YFeV1SYcHXu+I6H7rnXoastVCPEZ4FuYaIVATYWWJ9L+zC3dJhRmusz
         6z41aKXfEeyt3f9xJZx+2EzoLIWKWV5rD4O/4+N+c0QHLsYhBA7ef3m9jeQ7O4SuWAUK
         gCbx0+j7XqN8zJEEFF7G9ODUSf+LcACZ6DtOm0wKJHeb5Qzlq0hMFGSYvNLGlKbBY2fL
         mrEYE4mJ5FnOqEWbqNRFhmlkE5h3DLQBvBauzcEkOY7K+hdk8loZKedsXjKBBP+Yl+ud
         xAuQ==
X-Gm-Message-State: AOUpUlG+qQoULORM24lCM1oFLPohZkoTdOggpTcoBKFnQogNEHpg64EM
        auQ5fvhZjavkg5+u6RNJ+gx/5LnjNyP9qhTxL2hFTA==
X-Google-Smtp-Source: AA+uWPxqFAVaNgxK7bZkjoEgw/0ZqtHsRMcN0xOLmFKpF398bt5FYqOrb6pnLAusE4SLrVEARuPo8K8pvkgaAeCuMls=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr1671722itc.68.1533643745960;
 Tue, 07 Aug 2018 05:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 05:09:05 -0700 (PDT)
In-Reply-To: <20180806223300.113891-9-ebiggers@kernel.org>
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806223300.113891-9-ebiggers@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Aug 2018 14:09:05 +0200
Message-ID: <CAKv+Gu_T+f=isb_dBF7icfTHApG+E8Y5njSQ=NmtyTHEN2VMgg@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] crypto: arm/poly1305 - add NEON accelerated
 Poly1305 implementation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 August 2018 at 00:32, Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Add the Poly1305 code from OpenSSL, which was written by Andy Polyakov.
> I took the .S file from WireGuard, whose author has made the needed
> tweaks for Linux kernel integration and verified that Andy had given
> permission for GPLv2 distribution.  I didn't make any additional changes
> to the .S file.
>
> Note, for HPolyC I'd eventually like a Poly1305 implementation that
> allows precomputing powers of the key.  But for now this implementation
> just provides the existing semantics where the key and nonce are treated
> as a "one-time key" that must be provided for every message.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Hi Eric,

In the past, I worked with Andy on several occasions to get my kernel
changes incorporated into the upstream OpenSSL version of the
'perlasm' .pl file.

This achieves a number of things:
- we get a readable version of the code in the kernel tree,
- our changes are reviewed upstream
- upgrading involves grabbing the latest .pl file rather than merging
generated code (which requires careful review)
- GPLv2 permission is made explicit, rather than something someone
claims to have reached agreement on,
- no legal ambiguity whether the output of the perl script is covered
by the license (which is what we incorporate here)

Note that the 'available under GPL depending on where you obtained the
code' in the CRYPTOGAMS license likely conflicts with the GPL itself,
but I am not a lawyer so I'd much prefer having the upstream copy
mention this explicitly.
