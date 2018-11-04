Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE69C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B2D2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSABywpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B2D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeKDKke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 05:40:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34020 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeKDKke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 05:40:34 -0500
Received: by mail-it1-f193.google.com with SMTP id t189-v6so4605908itf.1;
        Sat, 03 Nov 2018 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/b9er5w18faP4SozhpT6Ew/XsBbKbOrZoklPzsCSmno=;
        b=WSABywpdMAPfZ5osJmLJ6U34J6ByOA+W0y1mTm7Pp9+Y9I+jVktgfcld/BoyB2zPzV
         RyxhxeRkcScolDA2zpITyr544zZ5kxpS7A6/rIHBrp1abmwqqG/PqaK9Gnclo+3mYjKg
         fzj8Q7jQL6bmnG/QxZ0Gzfew3ADN1R5Xw3z3RnYmtgWVOQk4aJ3bZIDVax39XLiCoUBZ
         9nUxHQwqHNCi4b016bK7jh9n0SYIvb5ZMCx9wi9Ja4aWO9XqdacjW6vlSz5mrGyZZcZu
         73wYB5BGDMuDciavPB7nKdaZN61UoJjOLLe+vURt5lHI4u0qmYk83CkT3jsmfZ8Dzw3m
         V04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/b9er5w18faP4SozhpT6Ew/XsBbKbOrZoklPzsCSmno=;
        b=bewq4NYIokM5tqnBlm1mA/rTk/kRTZi01FQ9wcY70iPFrJLdvHVecS/J7WNK6P6obM
         e6pwaZeOwDmlIfe2hyFkW2FAn3mqllZaGq8QeYedaue3fhTSRSVBjDjTMvrzuaIugSSr
         zxSliG+61afrJCPkTLdXuoC1pkI/whrsCYLJHRxJFJctkqDo/HVg95MIGG32YSr0LCUM
         rk2TfpBpHdDwi7ZOqdq/4+xwkVZ3Ke4Lq4g7Kdr4OlszCM1YdGRH9qG40JsznP+od0hn
         oprJWae1oQtFJl+xOqhIhSjE6kIJ6Lwtey4tlGayQgL6IuhV6Fkmsyz8us4yxcdFNU1N
         PITg==
X-Gm-Message-State: AGRZ1gIxl0pbb3lOWsIv1UEadk1KQzBhJzDFYRGVqAi1PH133dH5tq+E
        xacShrFeCSZxF92afLUAxuQfZoX8DUSEsbiGPJU=
X-Google-Smtp-Source: AJdET5eH9sR1xiirRZVH8IJ9m0X8+FTD1L1NYucuZ6RjP3Fh6Cw8Q2q1IqoCGHmZFSJN0mnD1zRfA42yqXUuLnQKJaE=
X-Received: by 2002:a24:140b:: with SMTP id 11-v6mr2390385itg.59.1541294849377;
 Sat, 03 Nov 2018 18:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <1541264071-9905-1-git-send-email-laoar.shao@gmail.com> <5f585304-b6f5-5f49-adcf-eaed471c0d76@gmail.com>
In-Reply-To: <5f585304-b6f5-5f49-adcf-eaed471c0d76@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 4 Nov 2018 09:26:53 +0800
Message-ID: <CALOAHbBN6KSwK8sHcz04GC2NdsmyNKxWzYKazVt4ZfGvJQDecg@mail.gmail.com>
Subject: Re: [PATCH] tcp: do not update snd_una if it is same with ack_seq
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 8:40 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 11/03/2018 09:54 AM, Yafang Shao wrote:
> > In the slow path, TCP_SKB_SB(skb)->ack_seq may be same with tp->snd_una,
> > and under this condition we don't need to update the snd_una.
> >
> > Furthermore, tcp_ack_update_window() is only called in slow path,
> > so introducing this check won't affect the fast path processing.
> >
> > By the way, '&' is a little faster than '-', so I replaced after() with
> > "flag & FLAG_SND_UNA_ADVANCED".
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  net/ipv4/tcp_input.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 2868ef2..db5a6b7 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3376,7 +3376,8 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
> >               }
> >       }
> >
> > -     tcp_snd_una_update(tp, ack);
> > +     if (after(ack, tp->snd_una))
> > +             tcp_snd_una_update(tp, ack);
> >
>
> Adding this after() here is confusing, how ack could be before snd_una ?
> That would be a serious bug.
>

ack can't be before snd_una, but it can be equal with snd_una.
Seems bellow change would be more specific,
    if (ack != tp->snd_una)
       tcp_snd_una_update(tp, ack);

> I do not see why another conditional has any gain here.
>
> You are trying to avoid very cheap operations :
>
>     u32 delta = ack - tp->snd_una;
>
>     tp->bytes_acked += delta;
>     tp->snd_una = ack;
>
> Maybe the real reason for this patch is not explained in the changelog ?

No additional reason. I just want to avoid these uneccessary operations.
Because I find that this uncessary operations always happen,
especially when head prediction fails and then the packet can't go to
fast path processing.

Thanks
Yafang
