Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D08259E5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rWS0zCXH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+Gtd+V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D08259E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeFZQpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:45:16 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41971 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeFZQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:45:10 -0400
Received: by mail-yb0-f195.google.com with SMTP id y187-v6so5886334yby.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=f3P/2GUaNNmyvgMsxP0iPouVUKbOuGn2h38+V/ujWzw=;
        b=rWS0zCXHaP2r74M+VXMM+nEKYGI0ZWERpEq6TLQrX8diZp5wvZgT9N8yCndXyVBhsS
         KlLYig0SeYeo4T4r6jUxubRdIo2uYMHuiTYUT1KabJpf+ftO1NQuresCI4tmgxvQoVcz
         iZnUg6E7lefBWSuVl1APU1t8uDfZRMznQyZAoZZJ4ay6QksjO0/h76BxmomAqMeMvfkx
         Y7mhYaJK/nlZ9kNbMXLSH/IgDEydGQzAQP+j5DYPqXAA7n4H1X0q3pNEEhCT19+hLzzI
         VllRsLYS2KKEhFYsb09Jo7B425aodzEYdDSaHgLOlfmNU8g0/xKEy3cG64UTOG0ZiE4n
         TeIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=f3P/2GUaNNmyvgMsxP0iPouVUKbOuGn2h38+V/ujWzw=;
        b=C+Gtd+V2jlPBByLTMq71NCJtocHi2ZkQOitdKDNh6JoaOIwIhCZ69Skr6IF3EG5P0V
         Nc+x3NMtWAbTDfhT8+WEa+Apod1YM589jUNc/hThUxUk3bDh6aCrRlSW9PuA7icYqAjY
         vxx6IuRTyOrzQlxwjLgbThZlmsmQW9yspre+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=f3P/2GUaNNmyvgMsxP0iPouVUKbOuGn2h38+V/ujWzw=;
        b=Kr9v09GK5Pb8nIBdgqOOPP2IbbERKuuQqOZLgVOCYiNj+gaTXZstL9cYyjVSoO2RVx
         YIJuv+T5qGJICI3v6t4q6wKC8ZKXCAL/d/qWuB13uBYGRiTxGuFrXEx6VrAb2SVMItby
         FDC5iYATSdtKz2f7rMEaVSMC5ODsMkabS2LownGdLARdQSFNfbvcE/qfgLVgMuCT57Us
         sBsbLXBBM/x0UQfoo0PfPaQ9qChxoROV+j0r3GSqKV5Ix2bMMDXPKqgn6dq5eKz+u6NU
         PhvUPO9PfGAmrELEtxXdp0H18JvwBTar9R/NmIhgAcmYqy82TP5D/taq5nARNP31hLAB
         t34g==
X-Gm-Message-State: APt69E1uFyunO+FAo2WUaQsJcfEpwiMQEQzaeYS5W3xD9xNh5Zj8AAmY
        woPPRT/nopqthfqbjNVTHsbCMabM970KpZTf275Siw==
X-Google-Smtp-Source: ADUXVKJQ23R8OGfmYHmzabm7WTDmMFhbWisIhlZodW9CbEmhL6F0wXUW2iZfyB+3FnYEVVK6y6pLyBBWyZ+HQZf2AQI=
X-Received: by 2002:a25:ce8b:: with SMTP id x133-v6mr1175320ybe.118.1530031510024;
 Tue, 26 Jun 2018 09:45:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:45:09
 -0700 (PDT)
In-Reply-To: <20180626092041.mxfg4lxcvxfivzc2@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-12-keescook@chromium.org>
 <20180626092041.mxfg4lxcvxfivzc2@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Jun 2018 09:45:09 -0700
X-Google-Sender-Auth: aoBJ25LblkmlO__Xa0_adn7svsk
Message-ID: <CAGXu5jKYb-0NNvOcN79hzqU7O6vCFhMTBDGBL8Knuoc-YHamPg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:20 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Jun 25, 2018 at 02:10:26PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> caps the skcipher request size similar to other limits and adds a
>> sanity check at registration. In a manual review of the callers of
>> crypto_skcipher_set_reqsize(), the largest was 384:
>>
>> 4     sun4i_cipher_req_ctx
>> 6     safexcel_cipher_req
>> 8     cryptd_skcipher_request_ctx
>> 80    cipher_req_ctx
>> 80    skcipher_request
>> 96    crypto_rfc3686_req_ctx
>> 104   nitrox_kcrypt_request
>> 144   mv_cesa_skcipher_std_req
>> 384   rctx
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: linux-crypto@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> This has the same issue as the ahash reqsize patch.

Which are likely to be wrapped together? Should I take this to 512 or
something else?

-Kees

-- 
Kees Cook
Pixel Security
