Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB173C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C7C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lXK92bKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C7C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeKUCyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:54:53 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:45373 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeKUCyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:54:52 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d140d4f1;
        Tue, 20 Nov 2018 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=7Q0jnRYteL0t9N+lomKk7N6MQHc=; b=lXK92b
        KdOEBx7FOJ9V734LApNY7qUIJqbq9oPvch+B9eHyulkBC68S6Oy/WX7HxN/KhGUQ
        qAGHVzQYwqfJx4Hxx+Gqi/3Ak72ACswW4LNUZdjw+2xO3YqpxutOaAYwU8ybVKis
        iopjsc0K/yLCTD8R4SSYLH27RvRXHmeUy5vIdLitEK25cu97Av2Z9P+wjzFJsUqF
        bEeodZXG+6HwAyn3AYMR8HFCwpj2F2pgBRXavYc7sekLiVe6Q7OCXjlo0eMhk7b8
        QnICpWZuwWt+mmv6KL6yXsBpedsEJBFciIu2DbVQ8uwBhX1mCRYCgvSvw7Ff0usL
        uWZJ9bMip4hEXBoA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c7c277b0 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 20 Nov 2018 16:18:45 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id b141so1948111oii.12;
        Tue, 20 Nov 2018 08:24:53 -0800 (PST)
X-Gm-Message-State: AA+aEWZTcDF/K+EcZSTOTLiUOBpcq2WbfK3qvHrxwkCT8UsQ4Q3M6Wnh
        0tGJSwXIapdX6G8rhtzW3NSnbdhYMFn7d3NQonM=
X-Google-Smtp-Source: AJdET5fsyf/9cbRXXjDD+15YsdaBKhpFrVpK2uZYJ76LQ3LP/vJF56jbpPm6Oz4mxCjr2AGlN4RJP8bYozQ4DptROLU=
X-Received: by 2002:aca:3f87:: with SMTP id m129-v6mr1370041oia.228.1542731093111;
 Tue, 20 Nov 2018 08:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20181105232526.173947-1-ebiggers@kernel.org> <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com> <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com> <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au> <20181120060217.t4nccaqpwnxkl4tx@gondor.apana.org.au>
 <CAKv+Gu-SHS2tF665dfqSgmH5EF5vGVtef=3_4WgCE=+8+Jw7Rw@mail.gmail.com> <20181120141850.zjmfwcari5kykk6y@gondor.apana.org.au>
In-Reply-To: <20181120141850.zjmfwcari5kykk6y@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Nov 2018 17:24:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9oPGkvEmqvfbav-AOf_P=Z4zWYxvqD3a3QhuOSh_OWd_A@mail.gmail.com>
Message-ID: <CAHmME9oPGkvEmqvfbav-AOf_P=Z4zWYxvqD3a3QhuOSh_OWd_A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Exporting existing crypto API code through zinc
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 3:19 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Yes.  In fact it's used for FIPS certification testing.
> Sure, nobody sane should be doing it.  But when it comes to
> government certification... :)

The kernel does not aim toward any FIPS certification, and we're not
going to start bloating our designs to fulfill this. It's never been a
goal. Maybe ask Ted to add a FIPS mode to random.c and see what
happens... When you start arguing "because FIPS!" as your
justification, you really hit a head scratcher.

> They've already paid for the indirect
> function call so why make them go through yet another run-time
> branch?

The indirect function call in the crypto API is the performance hit.
The branch in Zinc is not, as the predictor does the correct thing
every single time. I'm not able to distinguish between the two looking
at the performance measurements between it being there and the branch
being commented out.

Give me a few more days to finish v9's latest required changes for
chacha12, and then I'll submit a revision that I think should address
the remaining technical objections raised over the last several months
we've been discussing this.

Regards,
Jason
