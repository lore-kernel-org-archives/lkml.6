Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF14ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0A020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Tr2drKCM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U99tMyPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0A020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeGSFKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:10:47 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36486 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeGSFKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:10:47 -0400
Received: by mail-yb0-f193.google.com with SMTP id s1-v6so2768458ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 21:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TPnEkbQlxfbO8J4ijXglSp1pvo8yVR6VqI8mB2NuF7s=;
        b=Tr2drKCMJdIeN9xf/6GdjSKgKrvI7qn+cRlCUAWKykDj2N3LJexCBArFkDLFct9Fyl
         HoTZjSCb4MWWaTQf+h86XnKezuMJk7gDyCztblTV5cixLQ0GgipRQ/i05yTF242KARba
         huk1TiPIkbw6BB38cghk+w3j1bzMn59oJdmIN3u3JDlNqskuGdR3esqld5JYDspDO80T
         v/4jwobLG0PcPDSPYC8MJTcbOEPvZuZFlozU2fSIhPeWytbsuQsRecXSc4/LEx2jbdz+
         2c0aK7kE/ri8ZGbM4KoNowWWMlqyAvlsKLnFuKM5n+D0HP0N8d+kBqdvOmB7KiBYe2qi
         LGUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TPnEkbQlxfbO8J4ijXglSp1pvo8yVR6VqI8mB2NuF7s=;
        b=U99tMyPeHU/ti0C8i4oefdsY4aiqZHrf7Fy8sU1MC04GRor5uAf/rxAc7DYWC+4sRr
         sDQIMWqGyDJWeMhVtBa1FQZFhgRbyQvoLfcTCxAj28B8G96v1HS8uunabQc5aCDeiL0b
         TyTV+9rnx5+A0pUHHAKTzUj42qinlU0OtOBGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TPnEkbQlxfbO8J4ijXglSp1pvo8yVR6VqI8mB2NuF7s=;
        b=ew61Ohbm062rQLeUpsituRHMyP2Bo5ZLjhG4AVzT9u5bcAAl2bl5DhrPi+gsKqrf+L
         UC2hdrRmZZ1poXaGm3YVBLY8zuKT7sOKHrnBatQvrWrrIYelL/1x2o3T+vx77zjA0duV
         XBUmwIqhObZLIW5bYkrZ3vhQr25LOBJ6IjCnEtitXW/tCJlHBUF+xUD5u1FktsWByfWI
         woD94VKXeVaUCtA879Kog7RWdMPmzkJm923tZghpI/ndNNA50ENDaSGe/5ubM1VJ3MFP
         pkLS+7E4uuR81tBSKDPtIjSBwGfxgmmszPcC/wgXIDP25xWsP2rY9Ch2LIl1WR26xlTz
         GDJg==
X-Gm-Message-State: AOUpUlFwqg5s80bHXbcEVJ6K41aNjpmiIxxfCd4RvwAFjtccDjxQ1SPn
        vOAcnCIgg3T8Hqf/M+TqQNTA6ZytEaYxGYsrqFuPjg==
X-Google-Smtp-Source: AAOMgpc9VtH/EURAnXgcZu1OaYt+PDrXPGs7/f6MKH5bbdd90NArRVoUM+/9BK0Ec9TYg+9pn4tIpdszXw+rMpdk4Qk=
X-Received: by 2002:a25:15ca:: with SMTP id 193-v6mr4761555ybv.484.1531974579009;
 Wed, 18 Jul 2018 21:29:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 21:29:38
 -0700 (PDT)
In-Reply-To: <CAK8P3a3Owx8SMtenkOwXtqLCk_P8B18CNRkLfyL+GFUW9rYU1w@mail.gmail.com>
References: <20180716034947.GA32022@beast> <CAK8P3a3Owx8SMtenkOwXtqLCk_P8B18CNRkLfyL+GFUW9rYU1w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 18 Jul 2018 21:29:38 -0700
X-Google-Sender-Auth: o7TqV1k9C1XG9rhTs2qH8BySKeA
Message-ID: <CAGXu5j+PirJXbeaawd0gXc-NfWBtS4-9tR85=XTQ0+oFdC8XuA@mail.gmail.com>
Subject: Re: [PATCH] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 3:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jul 16, 2018 at 5:49 AM, Kees Cook <keescook@chromium.org> wrote:
>> The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
>> (when less than 2048) once the VLA is no longer hidden from the check:
>>
>> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>
>> This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
>> functions for reuse. Two requests allocated on the stack are not needed
>> when only one is used at a time.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> This looks like a very nice solution to the problem.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Since the large stack usage could already cause problems in older kernels,
> should this be backported to stable kernels as well?

I don't think this hits the bar for doing a -stable patch, but if you
think I should, I can do it.

-Kees

-- 
Kees Cook
Pixel Security
