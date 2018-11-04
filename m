Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D7ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6697020843
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmCL8Evz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6697020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeKDKlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 05:41:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52516 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeKDKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 05:41:15 -0500
Received: by mail-it1-f196.google.com with SMTP id t190-v6so2429713itb.2;
        Sat, 03 Nov 2018 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0IDGKvVfVf9V0yuQdQ3MQoGoM2oWH/WQ8URjpCdwWU=;
        b=WmCL8Evzo/u08fxhWcyHiSI5OxwFrRilw/ymuoodwFuamIlOcMaRuF0/LblI0/Xc5t
         9pFK8toGyB/VML5IfGPgLadjI339C8EOampizIibMVtmKzmZxfKVfdpG4vazOYcVkarC
         tQ498tQc741Ynrx6nvkno+AG+HEhOpEps1GTiG53r/JRMoTnUCThvsBpY5ZOGE28WQMD
         QmfLIz6QUl2lGX+BdsbarP8AZ8RDRTnFNSKlgt3msqAoutOUt7t8DLWJT3SEhtWI0/jD
         ehgl9MV9AfaEr1rOJDP6vksLlevtGBrdl+lez8GV6yWrNsO8gjgJDux7NgE9M/ikjDmZ
         iO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0IDGKvVfVf9V0yuQdQ3MQoGoM2oWH/WQ8URjpCdwWU=;
        b=r9On9rAwGnorz8m0YM/U+WnXD4YyeZyfe6n0Vt0lwoz9BDcPHEkmrssaTvRQ5geW4m
         yk2Ce7mNjg0PSgv9dk5KK5kXIlbUkWq3zc7ZEqWE6+XprpXRfvlIredWGdJhv84ul1wx
         rsuzOSjWKYfswRsCwKoa/FCT3rtJWoustwwXwAu/9D+KacEWdN1rtoqX16/TAUhFTiUj
         zqEUwt7W/QSfxa4W8ZY5TsJ1wGJfVp7NHBulRKOhnU0kQI4LtnmT0Ll3WvRMgXN/NIPv
         yyG3qFupYknxWRb8SZgP101KK5hREGO2nEadm+B7cYWdZSSDV6395x3FwVIBJBuanpcU
         XGVw==
X-Gm-Message-State: AGRZ1gLAE18+1IInL7KbCU/B+FB/o3rtTwzn2vPjSMOxD5tGYMfG1MKZ
        raCsWrCB6d6DaE+DNUfFkmsqGXQaca6A28zwBK148MHL
X-Google-Smtp-Source: AJdET5eU9Ci7l3gZdsWDLTmFM/8TYMi9F+1p5127ouy7fVIPzj+Pgm9X37GQEtjc/YGhSwfzfteZTZVB5jfRhZvdQ74=
X-Received: by 2002:a24:41db:: with SMTP id b88-v6mr2425119itd.97.1541294891559;
 Sat, 03 Nov 2018 18:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <1541264071-9905-1-git-send-email-laoar.shao@gmail.com> <945a90d62aa45c4b53349ba0a104574759d40efe.camel@perches.com>
In-Reply-To: <945a90d62aa45c4b53349ba0a104574759d40efe.camel@perches.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 4 Nov 2018 09:27:34 +0800
Message-ID: <CALOAHbB0CQkXfi6Xt-S8u0jQNGpbwFN0aEQz4gxnrYr51Fmd+w@mail.gmail.com>
Subject: Re: [PATCH] tcp: do not update snd_una if it is same with ack_seq
To:     joe@perches.com
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 1:04 AM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2018-11-04 at 00:54 +0800, Yafang Shao wrote:
> > In the slow path, TCP_SKB_SB(skb)->ack_seq may be same with tp->snd_una,
> > and under this condition we don't need to update the snd_una.
> >
> > Furthermore, tcp_ack_update_window() is only called in slow path,
> > so introducing this check won't affect the fast path processing.
> []
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> []
> > @@ -3610,7 +3611,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
> >       if (flag & FLAG_UPDATE_TS_RECENT)
> >               tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
> >
> > -     if (!(flag & FLAG_SLOWPATH) && after(ack, prior_snd_una)) {
> > +     if (!(flag & FLAG_SLOWPATH) && flag & FLAG_SND_UNA_ADVANCED) {
>
> stylistic nit:
>
> While the precedence is correct in any case,
> perhaps adding parentheses around
>         flag & FLAG_SND_UNA_ADVANCED
> would make it more obvious.
>

Sure. will change it.

Thanks
Yafang
