Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E1720693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KREa3IKu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Li1h9lAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E1720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbeGQUqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:46:09 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34299 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbeGQUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:46:08 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so866491ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2yvHwkZ8MzJ9wGS1mNVLoL3xgTQu7us9DUTFp9nRzGU=;
        b=KREa3IKuP+3l0vTTsYlums91eUyNqIubVE1g7T2K9nqbScjSsc3nEgHDVh+KE3PgEL
         8M4dPqdvYpRyuBVbqrAS0zTlWXjen4ps/kXjXNgVGZjcTu1PRxIEcPg2INlVmOjd8NEO
         ECro26HX9bVTJypxMIV0pCz9feimhkxbOn8ffWifU7noa8YmX1nBJrMXMma38vQz/B9A
         94m+sx4RJaL1hSXyLmNrNmSfxjtrTaMZ+U9sb2DfC9LpsP3y4SSI/xaDoWn6kjDA+/Rh
         s3Fa3LVqZJvdIFq4pLxkJ0BNd+9EwqEuIOnnjhoF1/oLcHfI1clBR8J5oQ3rG3nONNqb
         LOqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2yvHwkZ8MzJ9wGS1mNVLoL3xgTQu7us9DUTFp9nRzGU=;
        b=Li1h9lAdylB3do/rFZbooBgSnolRHMLu+uY3fHaZ4EOJBjeJoyfE7x2aqDxlexPXZ8
         baILj1ym0xGeJVS8V32XAQpjQhK+j8D/2g4QVnPjnOR4SIdHne3Fqw5kyDuMo6RsH2gp
         62O4k807ZiZlWu7f/96Z6wWnGdyf2IHXTpS/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2yvHwkZ8MzJ9wGS1mNVLoL3xgTQu7us9DUTFp9nRzGU=;
        b=mBqTlmnGWMOxTiy5Z1mQP0DQR+cY1Z+L6fEeVfbttmOx+5b6Gs9cfrLZXaAWJhffr4
         2AbcghKkQBhA4MkFqVcBXneiarQDyXpgt3VVOVw1mNbdEmkQ3TlIHPbbias/bH6+Nooc
         lWoxZWBKsKGfJUZ8aYD6loJC+xjFS2Tp+f2ctnQ2Tu2tvQkEE/6G9kzX6nBFZv3wmfGB
         4du1cdyYDfYfgSzNnRuUmHYgbVo2ZDBxgmoWysqss7F+qEryrp8+o+v8hhLxulPWj3td
         SnEAWBftW7wutToZ9h4zGztpT4klfvb1xc8m2hqCMrvNZZNEyahGIiGG9/RVkwgFe8hf
         4Zag==
X-Gm-Message-State: AOUpUlGxuCTPsBbuQh5PEFr62rcMeTBqCiKlsOimdLKGCCL8RGFEZjXI
        4MHu0VjkV+O8C33p4abkrXcbUHCZU9qjLDeNHoEY/w==
X-Google-Smtp-Source: AAOMgpcyubc4EXJo8j9XdndfoV57EWat7wM6KU9IZIu4dVsgw2ak0cFV5xzm316PuUy1T4UXM9XolUC+aBlqujqQMqc=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr1685527ywf.53.1531858313526;
 Tue, 17 Jul 2018 13:11:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:11:52
 -0700 (PDT)
In-Reply-To: <20180717164358.GC75957@gmail.com>
References: <20180717042150.37761-1-keescook@chromium.org> <20180717042150.37761-11-keescook@chromium.org>
 <20180717164358.GC75957@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 17 Jul 2018 13:11:52 -0700
X-Google-Sender-Auth: X2XqlzxcxsVwGKMhI8keWWEGQ-s
Message-ID: <CAGXu5j+uUUKjDb3_W=PvLG+mG+_ozTRuK5PMAewKEVnomnc2yA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v5 10/11] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
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

On Tue, Jul 17, 2018 at 9:43 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Mon, Jul 16, 2018 at 09:21:49PM -0700, Kees Cook wrote:
>> +     reqsize = sizeof(struct shash_desc) + crypto_shash_descsize(shash);
>> +     if (WARN_ON(reqsize > AHASH_MAX_REQSIZE)) {
>> +             crypto_mod_put(calg);
>> +             return -EINVAL;
>> +     }
>
> 'crypto_free_shash(shash);' instead of 'crypto_mod_put(calg);'

Oops! Yes, thanks; I have fixed it now in the next version.

-Kees

-- 
Kees Cook
Pixel Security
