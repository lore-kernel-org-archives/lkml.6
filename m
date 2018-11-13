Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D89CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D5E224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UItIfc2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D5E224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeKMKIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:08:55 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:41147 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeKMKIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:08:55 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 16cb7b4a;
        Tue, 13 Nov 2018 00:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=W2nyqXYDbbzq+EXZ4daB15tscI8=; b=UItIfc
        2eAqIrLS4Jcv1aqAO20tVgAhXhJCXXCIpO47sUvFm1pJnXqSeLek2rxwAlj9/x7C
        E7rItm5OOhtYT2S8O5UH2eUWXw3wLq6q9Z2Cj+Es+loF/y7SVRwCKUcMo7XmihaB
        20fUy4MqmjKq5D0ZGzmV4OUN7jokuC+GF8oBjbdt0rM8Sw2fTxOVFarthlKDqK+Z
        O1c65UbCzIyxUO9s+XEbKDjMwOx67QSl0Awq8o2pfRPA+glWhhdutbbH/VVGhFmq
        JIM1q1BZ5Z+6tHIoWvJkB3vfUzEvkT/K6nO3h1WAXzTuBvNGntd7OlShXkyQLKS+
        MjX8FVn+/gYmjYlQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 33e941e8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 13 Nov 2018 00:08:16 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id a202-v6so666973oib.1;
        Mon, 12 Nov 2018 16:13:25 -0800 (PST)
X-Gm-Message-State: AGRZ1gICvzMIgCj6yyE+czv0EEukpckcSsAtG9XRHXB5Akjnrb9uc29m
        JcZvnEnUAVfSeWk7nmxEfQMqRDnbi/Skx2hi//Q=
X-Google-Smtp-Source: AJdET5fRm1eInt6psGxM1Ybx1gDWsrRxx0S9OOi4SGYEAt1NBelu+e2b4jOOTISYhGEsm1ilW6XrQhpBtGQta1ttTnQ=
X-Received: by 2002:aca:3117:: with SMTP id x23-v6mr1856686oix.74.1542068004764;
 Mon, 12 Nov 2018 16:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <7830522a-968e-0880-beb7-44904466cf14@labo.rs> <CAHmME9oQJ9y51Pv7U=+=5uDA_tb+U1zWZdsLcyNMhdcFZmjM8Q@mail.gmail.com>
 <e4b500e9-f24a-43c5-c2df-834dafc3aae5@labo.rs> <CAHmME9q8tp3Ch43o3D6zYTVujcjBWLVpNdzVw6RqYqHisd_suQ@mail.gmail.com>
 <CAA93jw7e61mbbLMoDwshxpWWK+oGUz71pGrsUYVX8uWM-s5Krg@mail.gmail.com>
In-Reply-To: <CAA93jw7e61mbbLMoDwshxpWWK+oGUz71pGrsUYVX8uWM-s5Krg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 12 Nov 2018 19:13:13 -0500
X-Gmail-Original-Message-ID: <CAHmME9rOhBwsGhFXP8qmfX-0XooJ+CLekLZ7+mNpy3kw9oq0jQ@mail.gmail.com>
Message-ID: <CAHmME9rOhBwsGhFXP8qmfX-0XooJ+CLekLZ7+mNpy3kw9oq0jQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     Dave Taht <dave.taht@gmail.com>
Cc:     labokml@labo.rs, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 7:10 PM Dave Taht <dave.taht@gmail.com> wrote:
> you have a speling error (ECM). :)

Thanks.

>
> side note:
>
> I have to say that wireguard works really well with ecn and non-ecn marked flows
> against codel and fq_codel on the bottleneck router.

Yup!

> I'd still rather like it if wireguard focused a bit more on
> interleaving multiple flows better
> rather than on single stream benchmarks, one day.

We're working on it, actually. Toke has been running some tests on
some beefy 100gbps hardware he recently acquired, and after v1 lands
we'll probably have a few interesting ideas for this.

Jason
