Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C6EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5851221920
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yku9audv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5851221920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbeHGJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:10:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51601 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732910AbeHGJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:10:11 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so20735206itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 23:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7iKm6bxFnwAm1/uare8Nwk42f5/UvNKaBhIcihefxis=;
        b=Yku9audvuOfbi9NXJTuqf5F/AG6V8DAVwohKYX1BjJa6Q1m7mQgskCoVFq4Fnp89gz
         z8ycES/VJzOKzLMRBlg486jZkkOrK4k9bo+FxuYBFp9bzIDBOvvze0PyuLLjN2fOKspJ
         vr4V1vAy5L/9GSnQfnThWwql2Ye3VfUAICnbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7iKm6bxFnwAm1/uare8Nwk42f5/UvNKaBhIcihefxis=;
        b=QVhhsuHQReJCoakreFsZ4dDl/yGWYJ2lfyUqmKA8up9+eVXOUuZNUIJdUd3q8PKpY9
         GqiGvhjMW+JEGcOhFo9oH+9dc2tX9xLGZq/p29v5IMatuFel/QLHXyihhhVJT/ucZYFy
         4Jb7YZ/UEJKp7PGwXUn3szBFACol24uVdLa99Y783IhxZ9v+eNYSzHv8XWqUtPu38fXG
         elGt0/+Uj1wRVuS7YcPNP2vxhuS/GtTj2IHWG0eAnh8/RNvqtOTlKFAf47TyrecAN8pF
         2JzuOQjIVzYoFbzVKEFREBVvhK50Fm6Jassg1IGxzpo789qaM1EhVuq/OvGHFuxDrOdC
         Vu+w==
X-Gm-Message-State: AOUpUlHSBOJ6v48GYjbF9wRjII49WRwlPkLlsNg5x57PUvd3W0rqTXQ8
        z0NuWe8t2V9WNbziXcmktOsDmMV1qbvNW+llyFOI0g==
X-Google-Smtp-Source: AA+uWPwhsJHODJlV67obO1aawUsq0b01nmQgGpTamvfygNsOFI6cCXd6FbJqX1OWnemA4btDn93YR+gJwPwu6eZF66s=
X-Received: by 2002:a24:5242:: with SMTP id d63-v6mr921813itb.138.1533625037887;
 Mon, 06 Aug 2018 23:57:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 23:57:17 -0700 (PDT)
In-Reply-To: <20180807062225.6331-1-Jason@zx2c4.com>
References: <20180807011937.GA133621@gmail.com> <20180807062225.6331-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Aug 2018 08:57:17 +0200
Message-ID: <CAKv+Gu893jhyC9m++r719845-7axqj5qCPhk7hp-iStykj+HsQ@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: remove Speck
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 August 2018 at 08:22, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> These are unused, undesired, and have never actually been used by
> anybody. The original authors of this code have changed their mind about
> its inclusion. While originally proposed for disk encryption on low-end
> devices, the idea was discarded [1] in favor of something else before
> that could really get going. Therefore, this patch removes Speck.
>
> [1] https://marc.info/?l=linux-crypto-vger&m=153359499015659
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Acked-by: Eric Biggers <ebiggers@google.com>
> Cc: stable@vger.kernel.org

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
