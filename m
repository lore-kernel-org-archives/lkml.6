Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FADC6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D062075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vwNOVFnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D062075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJHIPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:15:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41115 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHIPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:15:40 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 16f4f068;
        Mon, 8 Oct 2018 01:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=IVybW6zc5ONKjaKJWA6coY4mbbE=; b=vwNOVF
        nvs7fW8HFgwZaGPLOfbqE2YBaz2VEs4DtHdJY9YjakD5SApFJPuNqWwwxPMGa7FT
        NdyvbOT8QCr5pAykW6+rj6VTYCjZbiaw5TBZNkQzJ1mntwUujOvgYu1A4T8CXLz4
        2gHnBQYzGf6WooGL2T/FC67M3CcyhIWBgiZ40ikzRHh9NE0qLMcvV2pEIo/L4EpD
        7PHz+d7Q6Jivh914OzA4lRCOMsHUqSiJMmA3z4VUQAZa9htI6IaTzYbqM7SIJ1EY
        ++EDViZlh5Yfwv2hg0uGyn6U3EASUDINFfjVAsoyrl1IYeHwDXjynrvGYlXrTL48
        TBKjGzjKBIdlSdvw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a54f42b2 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 8 Oct 2018 01:05:47 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id o21so17730777otb.13;
        Sun, 07 Oct 2018 18:06:30 -0700 (PDT)
X-Gm-Message-State: ABuFfoi2CteFYbHLwxpE4SR9a7xp9QokYRsbyBAxVLzV3oLeOUm9dn8j
        GjAAwdjEtpDLgRh1Cv6MQ6E3bz9R0e1wLICVs3Y=
X-Google-Smtp-Source: ACcGV61tjrxPM7Pv/+xsWKzj5B2LiQ7kM8vJjEEsuMf5hDjkbAxDJjuomZ/SwbyqrvTOb2NLMdWOky6Z5acO2dbmnRs=
X-Received: by 2002:a9d:2992:: with SMTP id n18mr6238060otb.54.1538960789008;
 Sun, 07 Oct 2018 18:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181006025709.4019-1-Jason@zx2c4.com> <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006194348.GK32759@asgard.redhat.com>
In-Reply-To: <20181006194348.GK32759@asgard.redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 8 Oct 2018 03:06:17 +0200
X-Gmail-Original-Message-ID: <CAHmME9qyEuO8Or=oACw49ijWBUo2BTmKe55ByA8Xz=5zT6jCpQ@mail.gmail.com>
Message-ID: <CAHmME9qyEuO8Or=oACw49ijWBUo2BTmKe55ByA8Xz=5zT6jCpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
To:     esyr@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eugene,

On Sat, Oct 6, 2018 at 9:43 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> On Sat, Oct 06, 2018 at 04:57:09AM +0200, Jason A. Donenfeld wrote:
> > +static int get_allowedips(void *ctx, const u8 *ip, u8 cidr, int family)
> > +{
> > +     struct allowedips_ctx *actx = ctx;
> > +     struct nlattr *allowedip_nest;
> > +
> > +     allowedip_nest = nla_nest_start(actx->skb, actx->i++);
>
> Second parameter of nl_nest_start is an attribute type; (ab)using it as
> array index leads to special handling of such structures in parsers.
> It's better to have some type like WGDEVICE_A_PEER_ITEM and provide an
> additional attribute inside it for index (WGPEER_A_INDEX?).
> See, for example, commit v4.12-rc1~119^2~131 ("nbd: add a status netlink
> command").
>
> > +static int get_peer(struct wireguard_peer *peer, unsigned int index,
> > +                 struct allowedips_cursor *rt_cursor, struct sk_buff *skb)
> > +{
> > +     struct nlattr *allowedips_nest, *peer_nest = nla_nest_start(skb, index);
>
> Same here.

Good point. Actually the index aspect is totally arbitrary and not
useful at all, and so that part can just be entirely excised.

Jason
