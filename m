Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE355C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C9620875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxkK6cQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C9620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756905AbeFSJXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:23:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44627 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756838AbeFSJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:23:48 -0400
Received: by mail-lf0-f68.google.com with SMTP id p23-v6so17334843lfh.11;
        Tue, 19 Jun 2018 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5qcCCrCI8Kn4e3FfGF6DTmcuEnTkcooxg2UyaOpShZo=;
        b=XxkK6cQoGOrd0BFNmuQ7XQjRB82uVX/l/Y7XNicilqUp+wjojaonYxaLBBcadF7oa6
         3UQodUAc1Q5C3TunNgxz2WlDBYkQSCpm66KVbGndn/utPfihxHi3jwnHpjKS8yY8Xkf2
         cb0rcwr4jh0veS6JSAYOUWOWySdDNEm0hHxcab4ddVrjBAN+2mF1JCSIbRcburw6lPN5
         eLQOmU2LzckqNfm4gDdnpOHzkf0kwY2RCBE0aaRMEZbUgbyxoabUC6LAy/1nHSoo88YV
         3rb4OhQUBTiOuGWMRJpnh4/Xusek2GAoxaN4zhqgaS1TFWFRst33Zvs2D7FEEUPScvr8
         3juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5qcCCrCI8Kn4e3FfGF6DTmcuEnTkcooxg2UyaOpShZo=;
        b=Q+nipzzRHeUlLOyZL1dwrvv6ptJtvo8VTfzLgE4AXfwPL04wzRr479NaqBF/YvIQzc
         d0Bo6iKnDctoyL41iJfykKXDnmoKArouz+EZU6UvaJnp7lY53dtfUKurgrrBF3PIHC5M
         fVq3jYm9oRcB/Gdq+U5SBSs1a8cnRuJFu0EVPdAj8f0qYg2KuBY543dG6GroOOINfEhZ
         Q1l97Bxw7ZleY3mK7JCbemUTvc55iBuYkGoa0yKzdl2pcyX4zDWYrfg3b4ooD0ZClbM/
         F42dbLaySD5kEOfwDKpkJB/kt/mfNQhkKuCv463feVSbWaSz7GJaAQx3Pk60E2CUnZBU
         kwZA==
X-Gm-Message-State: APt69E1IHrRdO2+PZLn+JYllTJVSL+GkGZw32OOTZ7QrSztYZx+pVuYd
        yBZGzMksVu31Qxr4JSiffgLwtn42jEDaIWS0y2g=
X-Google-Smtp-Source: ADUXVKIvcIVAGX64PeFJWqOWWEmO5G+1WIXWo5s4W2Dr+ptI892VGvKjmyZVK1cXZbwFdHlYlkwS2WINj3v69+Pj1Qg=
X-Received: by 2002:a19:dd16:: with SMTP id u22-v6mr1325952lfg.48.1529400226250;
 Tue, 19 Jun 2018 02:23:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 02:23:45
 -0700 (PDT)
In-Reply-To: <67ebb94d-c73f-6c9f-493b-00c86f595120@gmail.com>
References: <20180618152242.1566661-1-arnd@arndb.de> <20180618152242.1566661-3-arnd@arndb.de>
 <67ebb94d-c73f-6c9f-493b-00c86f595120@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 11:23:45 +0200
X-Google-Sender-Auth: dGAF9nr9SBxCH6lntEIkJxxnM_4
Message-ID: <CAK8P3a2Z+H7r=dWqYmKbJ2mAMZEdvT6GdKjSMbweabqBwOZYEg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: use monotonic timestamps for PAWS
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Atul Gupta <atul.gupta@chelsio.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Michael Werner <werner@chelsio.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Florian Westphal <fw@strlen.de>,
        Christoph Paasch <cpaasch@apple.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Ivan Delalande <colona@arista.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:59 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 06/18/2018 08:22 AM, Arnd Bergmann wrote:
>
> Please use the time_after32(), since ktime_get_seconds() is time64_t while ts_recent_stamp is int.
>
> Same remark for tcp_twsk_unique()
>
> Lets clean up this stuff, thanks !

Sure, no problem. Note that as ktime_get_seconds() uses CLOCK_MONOTONIC, it is
guaranteed to return a number that fits into a positive 32-bit number
(for about 136
years after boot to be precise). Most users of time_after() or
time_after32() are for
jiffies values that do overflow regularly, but it doesn't hurt to use
time_after32()
here for illustration.

        Arnd
