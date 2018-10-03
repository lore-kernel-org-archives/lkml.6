Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3CEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ACD20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRFLq+vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8ACD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJCOpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:45:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45395 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJCOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:45:35 -0400
Received: by mail-io1-f67.google.com with SMTP id e12-v6so4251410iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w7U3hKkzXO+tAUJhJY+xjsKPqkh0CTBzgdIvCsl9vKo=;
        b=WRFLq+vRDxkoRLAqhfYV9BQjHxsK5cMKzIU2jZv6158XqZkpStdvJ6DpD33YlW50Ul
         OwWv2o9I4I9nRHQDRamLDYQXX6b+OFtLdG2ASt7haXAq6DCpnyqF3OVTJqtsHIx6L5Ae
         vh0Z62zesvlFITxjvoWMLUHk6T0mQ/KoseiBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w7U3hKkzXO+tAUJhJY+xjsKPqkh0CTBzgdIvCsl9vKo=;
        b=SKrfL8WAkj86pa/Y1MNTFnU5KEv12th+yLr0aN0AwTdzh7AO0PDfteK3afB2PQoHgK
         c9jqfKlofGoUAIJlnYfVE44Ac7GYbYqWc6cFI2aEWvxpgDcGbprnTrStUZKyRfs8u0yO
         B4eUw/6YIZtysFm2lJ9Q8RMaVeBBFkrFCTuq54T0RXAPB4OjKedGfSOjbLqJKCE4xcdg
         Cp4dLkUdV9DZ8cVI1aaEo8cjpJcSubMakVec1EcBequ+P8uNizuPMm39DKJzh6BUWVeY
         YE1TeHA/pUAdo5xi9CF6RbWutVOK/RlyMk64uxyRtIf2D3eqEtB7sj4GFDKk1c3P6rJU
         pCfA==
X-Gm-Message-State: ABuFfojvXLo879pOtyr1KoSojfDLJFn492woUYM0LDWHYAEFXNbyTUaI
        oCoL7nrexc0HaLDOxYHH4+/UK3bCmoCWHWxUntOXLg==
X-Google-Smtp-Source: ACcGV63PfcY66X2qRGmWOuVUqsvBK2JJupTtKEVlsJqSV3uIg4lWdwU5ysi/LMfJg9Vh2bbITFeb/Hl5w8I2i+A/EYw=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr160539iof.173.1538553498584;
 Wed, 03 Oct 2018 00:58:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 00:58:18 -0700 (PDT)
In-Reply-To: <20181003061236.GB745@sol.localdomain>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-12-Jason@zx2c4.com>
 <20181003061236.GB745@sol.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 3 Oct 2018 09:58:18 +0200
Message-ID: <CAKv+Gu8-HoAEyYiPYqMOMy9MGduFLQik2YxdJziqxN_cUs0nCA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/23] zinc: import Andy Polyakov's Poly1305
 ARM and ARM64 implementations
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andy Polyakov <appro@openssl.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 October 2018 at 08:12, Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Sep 25, 2018 at 04:56:10PM +0200, Jason A. Donenfeld wrote:
>> These NEON and non-NEON implementations come from Andy Polyakov's
>> implementation, and are included here in raw form without modification,
>> so that subsequent commits that fix these up for the kernel can see how
>> it has changed. This awkward commit splitting has been requested for the
>> ARM[64] implementations in particular.
>>

"This awkward commit splitting"

Seriously?!?

So you really think it is fine to import huge chunks of code like this
from other projects without keeping track of the local changes?

>> While this is CRYPTOGAMS code, the originating code for this happens to
>> be the same as OpenSSL's commit 5bb1cd2292b388263a0cc05392bb99141212aa53
>
> Sorry to ruin the fun, but actually there are no Poly1305 implementations in
> CRYPTOGAMS (https://github.com/dot-asm/cryptogams).  Nor are there any ChaCha20
> implementations.
>

So was this code taken directly from the OpenSSL project then? If so,
why do the commit messages claim otherwise?

> Andy P., can you please add your Poly1305 and ChaCha20 implementations to the
> CRYPTOGAMS repository, so that they have a clear kernel-compatible license?
>
> It would be great if you'd include a kernel-compatible license directly in the
> versions in the OpenSSL tree too...
>

Yes please.
