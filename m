Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4FC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D444E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fvknt2eI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+lAB4IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D444E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933360AbeFTUiY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:38:24 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35261 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeFTUiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:38:22 -0400
Received: by mail-yb0-f194.google.com with SMTP id a16-v6so357141ybm.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jdyZYn4J7cGa9q27FcbltND+tOnAiGP7IIw143jCsiY=;
        b=fvknt2eIcy6bTVfDuoSLxoe5SnDUkv2VKrceVorV3Ltu9aGe1qfi/JI2ghVA2QuEu9
         Qc5dAY9M5UtqGLvZql2qztal3Ln6uh/TvoVqMYr+833w8B5tB3Mo9s/vGe+wOtK5LuMG
         Dj4qMDsa5zuK96ePwF7+Di0ks2GjImvdaeiYUT4p2J7ErUf6FCtWiN9Jrz9Yx3lFoZmx
         4qUXfLUVct4Xldd7KHWk/AXIGDjw8I7Tf07PFRziJS/RYlbw7zZXSWY7OR9Ui7uyUuJJ
         c5qy/oX3DeBUSxTZAzYF/72Yp7ocSE64arkLIBxCAmAbTR+bIHr1GbxOB+95yCQ6UCxD
         PMaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jdyZYn4J7cGa9q27FcbltND+tOnAiGP7IIw143jCsiY=;
        b=Z+lAB4INHziqr5oF/btKhzRzaUYbTLzUydI9Z8rpCAjrx09zvAOr9H7GFY3NH4rVmL
         937DzQe5ekMpBw5kgrfSsLIbFyRGzaNPcheeUb+S6O2F2tFuPkPhzFtkfW32FOpqWziu
         2znR+BjoiWHMys39lU7YjkNnKhqlL8W770oLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jdyZYn4J7cGa9q27FcbltND+tOnAiGP7IIw143jCsiY=;
        b=YkAuUjzg+eiGKm4u5/wV0yOQ6RHNglRVTRqoSjNPIMAgvhsGBMRaXQLOIk/rsOCwP5
         MfqLKhF1YMxtob3FypV1eNB8SopybaQP82vEG/14l7rbCAp7MuGiI6Yt24i1QDheiGru
         vmezWKmeWqWnaFzG6OOHkE9r15JDYu9vAPEVfze+YZUkLDg/DwMcuWxDt0La22qcbBb7
         IH3qp5jKo+S51qDEajl8pNUnnfbdCzGfWbpjSPZ1c3l/fl3t0mnPBHYmqFZzb/OGY/zl
         jU5YsY/VKHqz7OB3BRn9Vmg/yWwBf8R0+WFsHrRU7O+DEugX2P5sJRtBCXaFUilo2Mwm
         HxFg==
X-Gm-Message-State: APt69E2MxP9HwFKRQpKvYys4k1qgpoME3/Csfx1uHlMctZzNZcDezCr6
        tfbBJs3+m09UNeEkkSwDuzleNqJ5OG/8/M0BehSDFg==
X-Google-Smtp-Source: ADUXVKJrirNBJqIhO5Rf73Z3iGeZMAkfO4dIr6gfrBboHfo6Do9syy7E3sK4pfZyLlDo5jO0c7dYMzqsZq4kh/DEz94=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr11706289ybi.193.1529527101429;
 Wed, 20 Jun 2018 13:38:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 13:38:20
 -0700 (PDT)
In-Reply-To: <CAK8P3a1U1RNxmx-G5QCS8emzXc3nHqEN5bqmZDMqZBBmo3vCtQ@mail.gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-12-keescook@chromium.org>
 <CAK8P3a1U1RNxmx-G5QCS8emzXc3nHqEN5bqmZDMqZBBmo3vCtQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 13:38:20 -0700
X-Google-Sender-Auth: 5CDj4Ct5kyFjj4jZIII2gnc2DqE
Message-ID: <CAGXu5j+P++iR=Vf6OKi31foxRAO+eRcDZHeHmc7K_G2rViCjmQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Arnd Bergmann <arnd@arndb.de>
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

On Wed, Jun 20, 2018 at 12:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jun 20, 2018 at 9:04 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> caps the skcipher request size similar to other limits and adds a sanity
>> check at registration.
>>
>>
>> +#define SKCIPHER_MAX_REQSIZE   (PAGE_SIZE / 8)
>> +
>>  #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
>>         char __##name##_desc[sizeof(struct skcipher_request) + \
>> -               crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
>> +               SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
>>         struct skcipher_request *name = (void *)__##name##_desc
>>
>
> This is probably a bad idea on kernels with large values of PAGE_SIZE.
> Some users on ppc64 and arm64 use 64KB here, but still limit
> the per-function stack size to 2KB.

We could make all of these PAGE_SIZE-related limits explicitly 512? I
think that was the intent originally.

-Kees

-- 
Kees Cook
Pixel Security
