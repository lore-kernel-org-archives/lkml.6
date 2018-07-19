Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42125ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E664920854
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vUsYkXIe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HDFpVJBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E664920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeGSDzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:55:03 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:32773 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbeGSDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:55:03 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so2719033ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3LDk1ao7K2HBbuPB2oQ4y3KZ0/VdNQ3iXIyvGaAjiTY=;
        b=vUsYkXIeZMobhCjt7EO3NtagL+4NFMGdc8XWmjEjus3W+qsodnaJg2EhuAXgl2a+9j
         VkgRgpDu+e2Ht6MhTLyEQz7RP4mJObZM/QihlB5ScZ6yPhV738lhsGedxDciV0rHThgJ
         hq2pkgmCgZT3EJo7Wn3PAzESWznFb1l/8IkUMHFCs9kuZuAyq646Iohuavy5HG3nsCn5
         Z2tpyyHf/Lz4Ma4KBDvcInZGZlsUPIOJs/0WHBVjlIx5Sy6BY9Hc6EoZyilrynryiFmy
         lnwNIb7tW8qU0pc3lFHRDt9ZMcqS6rJBraSd+EHA/Y6b09uYLPvLByIO0JQeq49JavpN
         yCTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3LDk1ao7K2HBbuPB2oQ4y3KZ0/VdNQ3iXIyvGaAjiTY=;
        b=HDFpVJBL+Se333fUwDXuAxSN9RWT++7GxvbWJUOOPSU+jd1vOSs9hqnmf5+3c4OTni
         XX1oNmrZj31ST7DQRziDWiajxowrUAwjvwvKV/YO/0kmvpYytiMSBT94Frscdm3r/EW1
         9cFWbZmAvtXJ+yvZX6xj0kdwNMU7EOTcIPhtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3LDk1ao7K2HBbuPB2oQ4y3KZ0/VdNQ3iXIyvGaAjiTY=;
        b=K39KoZ3ucUkr5l1oiJ1Z+XUjWd5gaQf9VC/r4ZVNzE3J42UDuqm1C/Zi0uHFwnr0pW
         GTFgHYvWrYRvbZJsqgeWH8JwOiF6iU0TgX/1R3nAQn3HeEMfkFXz9Cin3eyerguOLxxl
         k4vhJVhoRE9lmKO490SYxP3LtQsMuLbDIX5Koa1Xmq8T6tRabRFqsO4GBp7e+r4s02Kr
         lqe/fJ1I1FgQlVhm152Ogb7KCN8dAX7ULRCyv9GIZSYrE9iw2HQ/v0ALtMD6wNRCdb9v
         DJCKpfS1838nm/6W0/ieW9kLgWEyayaAmQqxvY1SsbWK4Ln8aH7tsHCuwaLVJ5hRrTGu
         hjjA==
X-Gm-Message-State: AOUpUlGWKxTphq6tkyvMsVKxdV0iV5ua3YUCDMEW5hmr5llel4gXIHXP
        XIwchtb6a7EgtJB2qYX5g++Ur577OxAX+7JZNsTINw==
X-Google-Smtp-Source: AAOMgpevo22WDv3T1nsiL/8qaeTZV3wFXRKWnSFYo282UU6KiD5Rmu1pyes3nqvWM7RP6EXTPwNlL0hQ+U3HUp8mnIQ=
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr4690073ybi.193.1531970048536;
 Wed, 18 Jul 2018 20:14:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 20:14:07
 -0700 (PDT)
In-Reply-To: <20180717231209.GJ75957@gmail.com>
References: <20180717042150.37761-1-keescook@chromium.org> <20180717042150.37761-6-keescook@chromium.org>
 <20180717163936.GB75957@gmail.com> <CAGXu5jKKD4hzeFEdvY5QdahEr4POd9ZM_B_5Z_iU-Qmx3AYSfQ@mail.gmail.com>
 <20180717231209.GJ75957@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 18 Jul 2018 20:14:07 -0700
X-Google-Sender-Auth: 2HGfgG8CrAkplut69vmxiQBzvuI
Message-ID: <CAGXu5jJUeMcVQDTd2JAYFTbTk0DcN84i1-4EOJcvLR9zNgyoOQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v5 05/11] crypto: ahash: Remove VLA usage
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>, qat-linux@intel.com,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:12 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> I just don't see why ahash algorithms would need such a huge maximum digest
> size.  Don't the 'ahash' algorithms all have 'shash' equivalents too?  Is there
> actually any hash algorithm, either shash or ahash, in the Linux kernel that has
> a digest size greater than 64 bytes (512 bits)?  Note that for a real
> cryptographic hash there isn't really any need for a digest size larger than
> that, since that already gives you 256-bit collision resistance; that's why
> SHA-2 and SHA-3 max out at that size.

Yup, it certainly looks that way on investigation. I'll adjust both
ahash and shash to use the same #define.

-Kees

-- 
Kees Cook
Pixel Security
