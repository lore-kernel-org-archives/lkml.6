Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC691ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7749020685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3O5kITh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7749020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeIXXio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:38:44 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37860 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeIXXin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:38:43 -0400
Received: by mail-yw1-f67.google.com with SMTP id y14-v6so968911ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7yBdGrp7CEyoh7J9IE3uIY1MOVkuTfcwhpK+PkTNS58=;
        b=U3O5kIThO7QZCPG5u9a7HKpqJMQR9YOcd7L5WK6ooawYRWYCGvCJVDQvvOin0l+efQ
         2m8FR3qNEhxtrAfFKXpc9qXvHBwyBRl1qOKTT2eLJUNb6/03pCK/z6giuHxCvKX67/c7
         f1NQUnywQMAcl1+e/4/++RPFtgVVwhz7lo/eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7yBdGrp7CEyoh7J9IE3uIY1MOVkuTfcwhpK+PkTNS58=;
        b=LrDkxI8+wcimN0fJWDXHxrEIl12RSPRh79hEGYMGNkn/IANGGP/tr3BWWGR0ZEyEeP
         FHDqLEUb42cCYfaGqpftd6EemuTE5VGws5n7Cee2Nt18e+savVcsQB/WEGowGdGvGgFb
         ud8AT0dFctEj177Vw74ox0meubrVv1+ZTQv8xSLFg8GffuBOTiyolIwuPpZFunKccvaX
         nJHwKkk9AqlEjA0+0aSPP00Ay4+VJ7griXw463amT0sOQGDOM7X8+LJ3ROGmLxft+ZqX
         4NA4bP80pyzoMH2RVBskqqEuxy7TRfYk+sW0KyKtCkr7jDHoFOgrdROd+7UCOTkR9LXs
         weoQ==
X-Gm-Message-State: ABuFfohzFMK+vRLI/lBdqXc1dVwkC1Hahvj1C8TanqeF9IYO4f8cKPqe
        fVpFW4jub/XrdY7bHg1RyS6ONyo6WVs=
X-Google-Smtp-Source: ANB0VdYvGHV6BVWFpMH0f/zAcl339ThBqIfMMjsoWNKZbN9q9/nYo6kSdR2OVXO/33SZJ1IzXUpj7Q==
X-Received: by 2002:a81:5002:: with SMTP id e2-v6mr5117705ywb.114.1537810528508;
        Mon, 24 Sep 2018 10:35:28 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id t64-v6sm5314892ywe.21.2018.09.24.10.35.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:35:27 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 184-v6so8593382ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:35:26 -0700 (PDT)
X-Received: by 2002:a25:249:: with SMTP id 70-v6mr5505823ybc.421.1537810526342;
 Mon, 24 Sep 2018 10:35:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 10:35:24
 -0700 (PDT)
In-Reply-To: <CAKv+Gu8OXbMZqQCM3MOa0Feag94j+wnKKfCCyzit3eRJSN5+_A@mail.gmail.com>
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-7-keescook@chromium.org>
 <CAKv+Gu8OXbMZqQCM3MOa0Feag94j+wnKKfCCyzit3eRJSN5+_A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 10:35:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJxCHHxYzJy2v9sQ03qnDPAjf_biCxudaSuDH6LBEki2A@mail.gmail.com>
Message-ID: <CAGXu5jJxCHHxYzJy2v9sQ03qnDPAjf_biCxudaSuDH6LBEki2A@mail.gmail.com>
Subject: Re: [PATCH crypto-next 06/23] x86/fpu: Remove VLA usage of skcipher
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 4:45 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
>>
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
>> with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
>> which uses a fixed stack size.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Cc: x86@kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Doing some archeology on this driver, it turns out that the FPU
> wrapper was introduced to support combining the generic CTR, LRW, XTS
> and PCBC chaining modes with the AES-NI core transform. In the mean
> time, CTR, LRW and XTS support have been implemented natively, which
> leaves pcbc-aes-aesni as the only remaining user of the fpu template.
>
> Since there are no users of pcbc(aes) in the kernel, could we perhaps
> just remove this driver and all the special handling we have for it in
> aesni-intel_glue.c?

Both options get rid of the VLA, so I'm happy either way. ;)

> If not, or in case we prefer to defer that to the next release:
>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
