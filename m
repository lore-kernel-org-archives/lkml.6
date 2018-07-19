Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A3BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087BD2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u4bzKrkB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nd5+02+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087BD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGSDt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:49:57 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34028 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbeGSDt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:49:56 -0400
Received: by mail-yw0-f194.google.com with SMTP id j68-v6so2546042ywg.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=b1LlaExhQmTbHhova/So0g4CsrX8o5btqhpHn3O5iCo=;
        b=u4bzKrkBM9yKwvbHX1F5XgvXIHwxlsxMQQhFDY/DcY/jqBsSFLqfCoGByzusUnH/qQ
         D9q855LIhFoMDty4k25CqlU8utf/pzGSWCkWLxkVcaUNWvBN09kQqwU/h4/80Qg8jkmn
         262VT0LhwFKAt+AXAG10w0IkaGNAhk35hWTZWEzjguvPLlmizwtFOFEjThi4pEoHwjfh
         FDRoS4rHZUKpWNjNCbLhbXoF5qQs22fKsLT1Tic61aCEBLxDemjVmwsBntDa8dknOdVL
         jV3ZtqPVMerWp5GaVF/kcXX4QpUvuu3Ue1UyCYv5TMIsdI9qFaLwO6zM2hFten+R1kJz
         I4Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=b1LlaExhQmTbHhova/So0g4CsrX8o5btqhpHn3O5iCo=;
        b=Nd5+02+kU8yVu0e9O/XgJDAgvYiBE939pU0uvNeM073hvAiMpXVlr5xFZqdYUa5C6C
         BCqeERtlsDVhP45ZWT3qBSd2mmIbpej03pTwc7Wq+HVMEqF7Eu63hELAQk3l7gAYjne3
         anwoeNor6IxZL6elBmd6oSvQkAWGj/umGy6BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=b1LlaExhQmTbHhova/So0g4CsrX8o5btqhpHn3O5iCo=;
        b=IzVLmGHDUvwJ0aQ6JmzdfxTHmPS/lrr/lfHDEz/RgC0Airt+n9zEfeTDVauLq28jAR
         ScBSmuHOpAG2VIILqcXR55vbN3QtDWT2Fgu55RBIixcbmSEhAebUx6X/jnBwtxJ9iRlQ
         1Iqi5Z9qo9pGIxVlLe3rzizlJ+Ek+6yu54U/zssozhcX+QNsTvgeQ1mY65OGM3eY6hX/
         HNSqmcRB7OHHsCTI2ZqTUAYH3aqd4u5gQU9s9bFF2hTmZBNvElmt0uDa6zKFMrZmaNd/
         OY6byvc3EpwDhDQRC+i0HAJqYV4bVQpsGegjnWrHRBia/aplZxpdYmlp7S7HXnUrgOIc
         OqCg==
X-Gm-Message-State: AOUpUlFREXvZwCVKn4hwKSa7Zgk1LH0rcmRky68l8iXzInVknTfnBOk3
        5dd3UXlEOeKh5zZ0sy2ERMDv4kQYX7Hd/s8dygDcSw==
X-Google-Smtp-Source: AAOMgpfsOSTfJRHBFt2D9gSuixjflwno4dKKC7VWhOPSzScNJzGjbjqTp+IzJflpw43WIv0uEuo1jO1U42qYiN1nxoM=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr4358223ywf.129.1531969742882;
 Wed, 18 Jul 2018 20:09:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 20:09:01
 -0700 (PDT)
In-Reply-To: <B278D0F7-71B6-4F3D-B625-D8B0298CE5B4@linaro.org>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
 <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
 <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
 <CAKv+Gu-cOV6uo6MpLxr9uQSTT-ku_wn9+D7CC4+3maJtvcaGoA@mail.gmail.com>
 <CAKv+Gu8e9sm42NKwQvQzD33JTHSaEY2q7sm0W0065dDz_rzSaA@mail.gmail.com>
 <CAGXu5jLuWfZFTs390c3WSAReLrQ6_KOOvr0FYjXhUQ5h5b8xWA@mail.gmail.com> <B278D0F7-71B6-4F3D-B625-D8B0298CE5B4@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 18 Jul 2018 20:09:01 -0700
X-Google-Sender-Auth: Jb07nI_MAyxN0675tQ_gRAzh3Rc
Message-ID: <CAGXu5jJyyi1FvT9PytMkU_rPeSqMSHR7asjn8ykShZGGRPPRDg@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 7:55 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> I have only build tested it, so if you make sure that it does not break anything, please go ahead.

I can give it a spin; what's the best way? Is CONFIG_CRYPTO_MANAGER=y
sufficient?

-Kees

-- 
Kees Cook
Pixel Security
