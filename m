Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871DEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3122E216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MdfD2w6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3122E216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeHTXyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:54:11 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33637 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeHTXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:54:11 -0400
Received: by mail-io0-f196.google.com with SMTP id r196-v6so6690680iod.0;
        Mon, 20 Aug 2018 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmDUcc8dN2uKczcluUbtIELmnh1Uq04sXCZONPeqv+E=;
        b=MdfD2w6WBzgQdEc4eoXdVEmcEeM/LEpizZqv3k9EKUPC3Jdk2IjzimMA6j4p6MYzlH
         4RcqD3xCGMAGrKS6ejimyFH4MsT69SYNg8/dMsfCsYLb3uwI2CRg9VXErRghNUSBF2yV
         IaXvDs9wSNlyJVf/m52gQ0RPZslYTp/uaoORo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmDUcc8dN2uKczcluUbtIELmnh1Uq04sXCZONPeqv+E=;
        b=Gyapn/68pbWJKoaxLoGHJM+xiajxkiAgKttj5lapSKhJBYdcrzUHU38QqLDEiEIQhH
         pUHIjwikBzEHLY1DeBpjB/JMma0ZtIuhGK37lH6XQHzK+iHlDSdIzrrNtNtz2uqRsMao
         /qRHxCMq/n+ub1uAtDJTRPYSDuoY/1ig4A2QIE2O/F5QZrtaG3KA/foM4TwqyGXtbT8l
         kje7v2JjrV1qhyRWizjt/n4MyGy7Vw0ZBI4NKb810A7erIfU1Lg/2djvOCdwPnugR5Jo
         Fvg6p1YwrUeRNTwmxq7VCffKwgEVGrETjj/nlAC0Y7Me4G3goyVSMQPIamUGKnhnUTmv
         XvVA==
X-Gm-Message-State: AOUpUlFMpo+JpNkqzGMKCf4Uj4yiB4+ii2S9DvvGN6JXFDs2jDw5m4kZ
        nIjnJ6/4HFrBxXNF3CrAkxea3B2Aulq6oDhbWSo=
X-Google-Smtp-Source: AA+uWPwRgpzzt/+CbGp7wmk/EuOe6E52F8jOmzSwTpxCCRyQ2OIxyTImLj3b0IEY5tAOkAvwRzDFQZHUxichkkr7dZ4=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr27847287ioh.203.1534797426228;
 Mon, 20 Aug 2018 13:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
 <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org> <20180820080629.i7y4cx4wewmcyqpk@ninjato>
In-Reply-To: <20180820080629.i7y4cx4wewmcyqpk@ninjato>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 13:36:55 -0700
Message-ID: <CA+55aFy+vVH4Mb-unrxm72JNORdxHaCFYEhD8iXbxo-OW0f8qg@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler warning
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        sedat.dilek@credativ.de, Jean Delvare <jdelvare@suse.de>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, pmac@au1.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 1:06 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> [1] http://patchwork.ozlabs.org/patch/461759/

Let's just apply this.

If it breaks something and somebody notices, we'll at least have found a tester.

And if it doesn't break anything, or if nobody ever notices the
breakage, then we will have gotten rid of that deprecated function.

Either way we win. There's no downside.

Wolfram, should I just take that patch as-is and get rid of the
deprecated atach_adapter thing, or will you send me a pull request?

                 Linus
