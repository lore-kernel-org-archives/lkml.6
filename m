Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00701224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajrVC0bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00701224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbeKMKGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:06:18 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:38943 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:06:17 -0500
Received: by mail-qk1-f182.google.com with SMTP id e4so16580213qkh.6;
        Mon, 12 Nov 2018 16:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q5Vh8BpfQhaRZB3IW7v6+hYQj9+PR8xSV25V/M1Laqc=;
        b=ajrVC0bh2t5+i6Y5O3G0caD81BnNCrIi5lEbC0lXwWFikzYyPWdRZiZg456XwCQj8s
         WQl2nFxo9Oh+34UKuDk22jZiuI56ZUlyzwMM2HZ0OfdU9DPr8Y+E3cjPwrWofeayvIob
         laXWtWZ9MbzbB0lYKzDJZsrz5NO80OHeisEl31+J4rMr9HXi9Isc1Ja3nZhpRvZ4nJK+
         lCxeQySb1Mdaw175+9k7kpQo8aglrttv6FNnkgg7BgPLU5tnzQoySLwut8iWy2jgt9ZL
         rTxPZZnYOEUuKrxewjQWaxoXSbY/ZmSGJsTvVZKGl366fZqsi0732Ilye5s+g2Ae2DYf
         Vl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q5Vh8BpfQhaRZB3IW7v6+hYQj9+PR8xSV25V/M1Laqc=;
        b=oHo/04VWCZxVRH6Rn6nNIHy5CMqcHKYICmIT15cCYRBPEDHxJolty/FKV4f0CUYN+k
         7P8Oe0X6KtpXTPYhzzKZZcDq59OCAH4TtRcZF7Y53E5uHWZ1PDi5K0+eBxkVPOmP7WEy
         2iwLjgeokEQowzBf3PSM5Fc4fFIoCJkG/bdoK/Mm7Jp9+rcPwEHC3RNGKXB30eSzKaVi
         LPprut46aYwV7lAwh4uJ3qW1P5oJT//nddat93Jsj5sZIq6uCYgHpTPzny9iWs/+OBuf
         OX8f4Mk0CHkuvrSSG+OEbWt+wGbunrWfD+W9hQb5SqmyMyr9lR/HO3KBj8mQt7/1cZbX
         OzJg==
X-Gm-Message-State: AGRZ1gItKwmsBVdj6mdi5AGjk1zCRaY9IpGmCQGAiOTU6B5xV5H6HNyv
        NmIrppz0lv0penDk1tHfeaNpFK5CZhop3ORDt1o=
X-Google-Smtp-Source: AJdET5dpf3m/Cfik1R7V81cEr6RpNBAyjOVmCRskZhqYs0PvMmJ2sUFS8s1DhVSf7wERV2pz4CFJ6bJvep1phtO3gb0=
X-Received: by 2002:ac8:326a:: with SMTP id y39mr2987105qta.175.1542067849106;
 Mon, 12 Nov 2018 16:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <7830522a-968e-0880-beb7-44904466cf14@labo.rs> <CAHmME9oQJ9y51Pv7U=+=5uDA_tb+U1zWZdsLcyNMhdcFZmjM8Q@mail.gmail.com>
 <e4b500e9-f24a-43c5-c2df-834dafc3aae5@labo.rs> <CAHmME9q8tp3Ch43o3D6zYTVujcjBWLVpNdzVw6RqYqHisd_suQ@mail.gmail.com>
In-Reply-To: <CAHmME9q8tp3Ch43o3D6zYTVujcjBWLVpNdzVw6RqYqHisd_suQ@mail.gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Mon, 12 Nov 2018 16:10:36 -0800
Message-ID: <CAA93jw7e61mbbLMoDwshxpWWK+oGUz71pGrsUYVX8uWM-s5Krg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     labokml@labo.rs, linux-kernel@vger.kernel.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 3:54 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Ivan,
>
> Sorry for not getting back to you sooner.
>
> On Mon, Nov 5, 2018 at 8:06 AM Ivan Lab=C3=A1th <labokml@labo.rs> wrote:
> > Any news on this?
> >
> > To be clear, question is not about an insignificant documentation
> > oversight. It is about copying bits from inner packets to outer packets
>
> The short answer is RFC6040 with DSCP fixed to 0 so as not to leak
> anything. I've added a description of this to
> <wireguard.com/protocol/>.

you have a speling error (ECM). :)

side note:

I have to say that wireguard works really well with ecn and non-ecn marked =
flows
against codel and fq_codel on the bottleneck router.

I'd still rather like it if wireguard focused a bit more on
interleaving multiple flows better
rather than on single stream benchmarks, one day.

In this case, codel is managing things not fq and we could possibly
shave a few ms of induced latency off of it in this particular test series:

http://tun.taht.net/~d/wireguard/rrul_-_comcast_v6.png

vs wireguard (doing it ivp6 over that ipv6)

http://tun.taht.net/~d/wireguard/rrul_-_wireguard.png

That said, I've been deploying wireguard widely in replacement of my
old tinc network particularly on machines that were formerly cpu
bottlenecked
and am insanely pleased with it. what's a few extra ms of latency
between friends?

>
> Regards,
> Jason



--=20

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-205-9740
