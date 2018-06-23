Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD17DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9752924ACE
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYip9nvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9752924ACE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934953AbeFWCWY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:22:24 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43455 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934626AbeFWCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:22:21 -0400
Received: by mail-yw0-f195.google.com with SMTP id r19-v6so3027849ywc.10;
        Fri, 22 Jun 2018 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m6tqfOlJVWDA4H2/n763TYEcyCQKcv6oGMLWRzkv7v0=;
        b=tYip9nvICtvdMmPxngeeevAI2c4dwxcX3xMXMXmzq62K8MfsmOahvG3SLhlhPtzSVO
         o03WBJB85a9flf1gGwicbdsn0QPWCV50KrB7jmGexOLgVDwsOD8H400uiMhHvMe+g4Di
         rYXUre4LEo0iLlxCQTdANkP8/t70mfucS24pSilYtIMXRsAFU9K1i/GRzzb0S2mHHY7+
         jzEEIYLamAwpB4m6dPzMFXy4yphqrhjcE6spQHWIhdp4U/XafFSiyaFJBhQXcXDtuvQ6
         329uB/RCQmQBxypUXgOAMkBewjI5ek3AnKuReJ/F+Z1BwZ1bkM14R0WLMEGwx/poFOnT
         weUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m6tqfOlJVWDA4H2/n763TYEcyCQKcv6oGMLWRzkv7v0=;
        b=hlIwTw61hwQyVOGOAm2gfMJW7B3L+a6GxC1yprsLbAvE2glVE8nPoYC3l6+rzxH/JC
         YrA1nqoApW7ffwXp1J3+uDtFEqM0G6CUowKc4epV6PMKmiPsHbaTx0IgoJeCgRYBZ/uQ
         Ge3iumAcQfdn9Pvo9NMfuz1CbVwH6I3nEksH+ozEJVxlMAO4+BioSz6yI/QCtGLWtTll
         /f6EAteDxAuxFLgdIwxcb0MK9DI6DAJlqvY3iXYMAVyIaq0LKigVOsePf+5MJaULANeQ
         yRFP3agzvjZu3G7i8+X0G/MfyLB60r3tstwFOKWOzipo3TE4kNW8hRw4nAVjmmrRsEI8
         jEGQ==
X-Gm-Message-State: APt69E3TG+kcbtnH91zwVpE3QZZMUqBU5JxD2ZlwJHHD2K6Vhyle9ks6
        RZ67itBgs15gkedXmUETF5lKIqaQrH+VhaG5kVU=
X-Google-Smtp-Source: ADUXVKIrHlKZSk/gdADMq8CZdgSsDkDWqQOqGKqyAYzuWYs/u5bjroQSlIoA978+KhwCfuZ2znCDyKNPGT4sVXGoxHo=
X-Received: by 2002:a0d:e446:: with SMTP id n67-v6mr2047337ywe.112.1529720541318;
 Fri, 22 Jun 2018 19:22:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:61d0:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 19:22:20
 -0700 (PDT)
In-Reply-To: <20180623020753.27266-2-shorne@gmail.com>
References: <20180623020753.27266-1-shorne@gmail.com> <20180623020753.27266-2-shorne@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 22 Jun 2018 19:22:20 -0700
Message-ID: <CAMo8BfLZi5NBr-rjGd8y88t8o=e9q-Mra05GJbH5OtUvXZhZgw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] crypto: Fix -Wstringop-truncation warnings
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 7:07 PM, Stafford Horne <shorne@gmail.com> wrote:
> As of GCC 9.0.0 the build is reporting warnings like:
>
>     crypto/ablkcipher.c: In function =E2=80=98crypto_ablkcipher_report=E2=
=80=99:
>     crypto/ablkcipher.c:374:2: warning: =E2=80=98strncpy=E2=80=99 specifi=
ed bound 64 equals destination size [-Wstringop-truncation]
>       strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        sizeof(rblkcipher.geniv));
>        ~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This means the strnycpy might create a non null terminated string.  Fix t=
his by
> limiting the size of the string copy to include the null terminator.

That could work if the destination buffer was zero-initialized,
but it's allocated on stack and is not initialized.
Replacing strncpy with strlcpy without changing its arguments
should do the right thing.

--=20
Thanks.
-- Max
