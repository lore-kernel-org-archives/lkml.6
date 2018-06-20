Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A1C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1823D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7OuKtJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1823D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeFTTor (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:44:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44318 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeFTTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:44:45 -0400
Received: by mail-lf0-f68.google.com with SMTP id p23-v6so1043308lfh.11;
        Wed, 20 Jun 2018 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6gdsOwhHlG5vMSR+TDUjQBCG+Q+EF4G5SNblkbYJZ3Q=;
        b=g7OuKtJRAHCKBYwaQfhOZYktEfZMpUrN+NuewtOkLjWwuwhXDJ5Gxp6DbUq3GdNfOV
         pn41FMhvKmkhv7HlPZKlAApjUfRWVAjVozfSmbQgEioFiGC5HoKkwFdNcMZkOTaySvDK
         saV+2K7YAECitI44e2GZLjM1jhXp3Sms4iPhffmyFslOYxSLnLuawy4JZGxZlKm197cp
         /K9FO92axsytAVoihIDMTaUJHEWxfVp2DRm6PN0TSaajnqWnycIB+HLH/N2oANi8zwVQ
         YGwR3U845T0y3w8kPTHU3h3AFnpJkuhTYR1eyv5JOiMxfZFVLOA0fxBbrti8vsKaGtZR
         79mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6gdsOwhHlG5vMSR+TDUjQBCG+Q+EF4G5SNblkbYJZ3Q=;
        b=SVJ2mAl6CU1YTwZKSFu5exwiTD5RqTWw7yZXbJLc8LI09qnJI0QwARggazPU9+EQFo
         04nk5Hxf3P+sFg7lFtvhdTh/FhPUlSsU6gzspPkOmIwRL1G/oW5nz5HteNhID3135X/W
         GmytCAHi69aB7RnFu4a2/OSGHG64RwRI6fIdPnU+cPHGLrWIAjGIph5wBq7VoUPYTqPI
         8aIPSRbo//QVQFbi1BZ4uEo3IYTL5Au1osZ1uie30nzcBl3bBbJzEJJvIloyfUqgsLDq
         001b1O0uCQa5nnUnGXvGAE4P1eDN+YQTYLcZ42SdzbiIXLjBHAvS89LeCPFZDaWYrX9G
         oNIQ==
X-Gm-Message-State: APt69E3ZbK6DitmGxJgyifPOYo1xJA7wxgy8MSHt8Uwxfs8OaX2D3QU0
        zTFmyM1pN4KPEexIAsVLFl4z62C9YSjywsuL6Ic=
X-Google-Smtp-Source: ADUXVKKkyjJSCvAnF8vYH7qEwGSgqZV2PZGvueWcTY/mncBd3m9NTI0sDlKksAoY3hO5XkIkDyM+mMrB9RaGTRd75Sw=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr14984171lje.19.1529523883672;
 Wed, 20 Jun 2018 12:44:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:44:42
 -0700 (PDT)
In-Reply-To: <20180620190408.45104-12-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-12-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 21:44:42 +0200
X-Google-Sender-Auth: QBeswwwygk5-vsg-S4bWtBVFYFw
Message-ID: <CAK8P3a1U1RNxmx-G5QCS8emzXc3nHqEN5bqmZDMqZBBmo3vCtQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 9:04 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> caps the skcipher request size similar to other limits and adds a sanity
> check at registration.
>
>
> +#define SKCIPHER_MAX_REQSIZE   (PAGE_SIZE / 8)
> +
>  #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
>         char __##name##_desc[sizeof(struct skcipher_request) + \
> -               crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
> +               SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
>         struct skcipher_request *name = (void *)__##name##_desc
>

This is probably a bad idea on kernels with large values of PAGE_SIZE.
Some users on ppc64 and arm64 use 64KB here, but still limit
the per-function stack size to 2KB.

        Arnd
