Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CFEC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569A720663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z27qnR4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfAUKn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:43:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51565 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAUKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:43:26 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so15828824ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQXb0zgoJ2mCoNOejW9tOHoVJWqC6dyFJgLtkR+K7VM=;
        b=Z27qnR4dsnp7AYzCCgtZ6dyL9Z3KONJQXeXGIMAaSDb/UtUnfoc6A9Az381jndlEi0
         dlpiMFeA3VGF98Hgi5g/povXhCcUKmDD7DLoXbnvUvYgQZzylEZFQ97WPvZhS76jhicN
         FFhdd9OE7BUkW3dt8hlLF5aDJX2U9opvYRryA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQXb0zgoJ2mCoNOejW9tOHoVJWqC6dyFJgLtkR+K7VM=;
        b=bL+xaOH3rErulG+j5w/BnV2RmcpgisjqAqbmM8ha8L71SgxXQTd247fWe0VRcAMIYZ
         F71Fr4usulnuC8dzk/5zgKx2NnxkpJhhpgCa50BYTjJl5Z6sjR6bfxpOFoGnEEwhKJvz
         Uilr9Mwj2+bsgQJICy9PQyJOUSRviCjGGACL+t+M+KzLv1CYgU3efO5FyusGSitqeScN
         3yGmnWKqPNt4Svd4AM/KKoe3zEXxKJHwg+6TR2imYbqaovEB6MSBlZMyHyQglI7AMaUt
         xLzifGyCqQyUFouf/Rn2dJg2QnIwOHO3LH6Ef43gzA5ReSjKD1RdKky3z4iMijYL+d1w
         kQYA==
X-Gm-Message-State: AJcUukdoDv4YI8ynhvwQ9mcahOOm9hMerUMkt2Z9b90BfOjHY6FXzOGR
        2vRpBBP18RJsdSUjAlAXOIXzpwyCH3iroil679qV3g==
X-Google-Smtp-Source: ALg8bN5WGvBMiF44LaTui5bstwU8eNuQkUryJQpFe200XNIaEcVCdAWtEKNAxGYKSfMBhwSsgSfsyx3F1Sgg+th4rPQ=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr18358127ith.158.1548067405296;
 Mon, 21 Jan 2019 02:43:25 -0800 (PST)
MIME-Version: 1.0
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-5-git-send-email-sumit.garg@linaro.org> <20190121103026.GB15590@kroah.com>
In-Reply-To: <20190121103026.GB15590@kroah.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 11:43:14 +0100
Message-ID: <CAKv+Gu9xT87twvnfvnxZqZ-Yj-Xmw5+2wkw6yCRhF7iuz+y-TA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] hwrng: add OP-TEE based rng driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mpm@selenic.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 21, 2019 at 02:59:19PM +0530, Sumit Garg wrote:
> > --- /dev/null
> > +++ b/drivers/char/hw_random/optee-rng.c
> > @@ -0,0 +1,272 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Nice, but:
>
> <snip>
>
> > +MODULE_LICENSE("GPL");
>
> This string means "GPL2+", you need "GPLv2" here instead.
>

I think you need a space there: "GPL v2" or it doesn't get picked up
correctly (or at least, it didn't use to)

> Yeah, it's a pain, and everyone gets it wrong, we need to add a
> checkpatch.pl rule for this to keep it from being added in new code.
>
> thanks,
>
> greg k-h
