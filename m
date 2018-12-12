Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17B3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB8720849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBQjFxqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB8720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeLLPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:07:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38462 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeLLPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:07:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so15832916ede.5;
        Wed, 12 Dec 2018 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlOkxSHqCS7ZGhiQkTlcs2yGQXRA9uAHpSH3Mn5XFnk=;
        b=hBQjFxqhcfEHC9t8xLKW+dVBqtlw/sBPT9BnOiCqfvC9KtTOs3F1unQsCFhzT6qXda
         fJKIe8wxAdC27zus49EErwrXgr7QShMbQsG36RvaN56PK6kx3gVQjefme9SI4ZIv0txl
         fYUiyredYUTKif3eTWJG8H34po8QMMfXElpYWi8L5h28P1TpNAKvotms8m/4Pr5OlsoB
         u4UjuQmZ+p0BuXH7KQ0qxu8ZmYGKWhR78v80byXIp3FFrIO9SyEOaNFtdjGBvgm0dY6J
         FfnQIJeKJ2pIuHOBgSImKTJQDGn4KcgBkHoyM/Z81wbOgh9rD7MKGryu9NDkoFXIRsJE
         AknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlOkxSHqCS7ZGhiQkTlcs2yGQXRA9uAHpSH3Mn5XFnk=;
        b=t6piy2yQHQu8laOAEjFQcM6nNThYFwPKjQDxcO8w4I1hBwERjk4W+a2VqdjV2ExDlK
         9CCarf+O7I6t3BVG4LNZK6xVYxRGpnBWonknyMSWSkz1cpedtc36k04KQX5K2rAofw7t
         XmL9zLZPDARHOz7aCLE4zWUZP/gt2qd9zCFF2jhq+/7zSdlGM111JaU9xESOpsfmA9Hq
         17z6sF3cQHh/tR5sRZBBpzAbki9tFFHaGmopuGF8JTvr9QnbJj1oQI4y7Gq+U7K+OZqJ
         lNmkvVhV1yBBBeIkLR+gKdoZw6nya2HoExtVcQV/X+zG1cNE/TzweKJ27FuLqtxQwzB7
         QOpw==
X-Gm-Message-State: AA+aEWZZ4FWDpZo+E7qgN8cTTMnFeji/5oa+K5aID6WBDbCrY3dNV0lB
        QlsGsL2eE3P7Ixor+oa/8KVuY/MXZwwYZ98RYzDy1Q==
X-Google-Smtp-Source: AFSGD/XpqqM5Wd/f6qUTIHdZOJK1mT4bnTwT0AcyIzx9m3oGLjiK+8uVZuMLbwKU7yEk8oFxgVbWPy8Y3tgiArxnMJE=
X-Received: by 2002:a50:ac81:: with SMTP id x1mr19631614edc.71.1544627271959;
 Wed, 12 Dec 2018 07:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com> <20181211202520.16799-9-deepa.kernel@gmail.com>
In-Reply-To: <20181211202520.16799-9-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 12 Dec 2018 10:07:15 -0500
Message-ID: <CAF=yD-+FDiTZpa51-o4gMN5=3EE8iYfV27psTdsaPDT+P=FVWA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] socket: Update timestamping Documentation
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 3:31 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> With the new y2038 safe timestamping options added, update the
> documentation to reflect the changes.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Thanks for adding documentation.

Acked-by: Willem de Bruijn <willemb@google.com>

One suggestion below if this patchset is respun.

> ---
>  Documentation/networking/timestamping.txt | 43 ++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/networking/timestamping.txt b/Documentation/networking/timestamping.txt
> index 1be0b6f9e0cb..67e4ab3cdb86 100644
> --- a/Documentation/networking/timestamping.txt
> +++ b/Documentation/networking/timestamping.txt
> @@ -6,11 +6,21 @@ The interfaces for receiving network packages timestamps are:
>  * SO_TIMESTAMP
>    Generates a timestamp for each incoming packet in (not necessarily
>    monotonic) system time. Reports the timestamp via recvmsg() in a
> -  control message as struct timeval (usec resolution).
> +  control message in usec resolution.
> +  SO_TIMESTAMP is defined as SO_TIMESTAMP_NEW or SO_TIMESTAMP_OLD
> +  based on the architecture type and time_t representation of libc.
> +  Control message format is in struct __kernel_old_timeval for
> +  SO_TIMESTAMP_OLD and in struct __kernel_sock_timeval for
> +  SO_TIMESTAMP_NEW options respectively.

Perhaps add one sentence to explain why this matters and how the
sizeof(time_t) trick works:

on 64-bit old and new are the same. All fields are 64-bit wide. On
32-bit the old variant uses a signed  32-bit integer for time_t that
will overflow in 2038.
