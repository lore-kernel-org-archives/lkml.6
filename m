Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E1D206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjykyJrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E1D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeK2Ngr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:36:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54968 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2Ngr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:36:47 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so402288ita.4;
        Wed, 28 Nov 2018 18:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFOoTaXGj6tYMsmgb+co40WYY8rw9ywKV88XkDGKqXg=;
        b=mjykyJrDmKWW4T6KbYazTr512Eutk/JOojLMJ6zN5c3IgTWTCSgtI/B7kqBecPS/ts
         Xk8Q5s/Om57wWpSgKuoA4tFy9P9kqvXucnHdYYAGsC6Pf5519veXscOl7dBz+7e+3S5f
         tkOd5YaQqTW1+Rp7ngdll5cA8UrNX78JajyEUfG2QxX6gT6SBiJjfn4bVke7O173hYZ/
         3+xA0eBOv30xTs0YLoO+RvQm2RJKCtwRDJ7p31mTiqMgYGhqDaavqKUQJIvWmd8Uzx9S
         NuA97oXRr7lDIjzSYBR6AfPVNNSb1Vo1QNQtT+x3Khz1cSsv3M7Qc8NqtzTzI7gglbt4
         UcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFOoTaXGj6tYMsmgb+co40WYY8rw9ywKV88XkDGKqXg=;
        b=QCE1YzHZ92WShWEh+pgEVm3ssPZ5dbBfKJA10fbkFWNmDfbQcFeakuBP0MB/d3TgJE
         aSYkE6WN70Ozn3HctuhXLNnunYHVPNWOyzYBB59nmGRGIP2+ShXtsTFom5Fzlc9qAqOS
         tz2gvzeYo/F7tObu2kvZwO2B/KobZP/6Gn5IMlmn01UfhJxJllhT9QBAyCVOfhn7fanK
         PnBQZG6sbfLl4bZvbPAy11Vja3sc6Rmd1DE4dWCEIHvXZdvY2mQS5fUpqFJ9BRQ4cTWo
         5/0AFnItTxnssWPORt3+xmhInO+TDa+Y+Brd5yrgT1FH61iG4bcsl9W/I6UsPtCyHD+g
         ttTg==
X-Gm-Message-State: AA+aEWaIR11zXXQ1ArW0CwmwgjZvgfkhgByDsP/qsJc6hjBp1wOjsVLj
        sAlavUB3EaR5IHUK0spZVh6ikgtJDTjTXpy0cYQ=
X-Google-Smtp-Source: AJdET5fbVVQICnGBU9A6BJqsYK1JgsOfU5+ZYBwmaGoh8aB9pLl33JxhMkjGGQAB8WjV6/7OCLyrhS9a4lvz12DwJOY=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr32985628jak.11.1543458781965;
 Wed, 28 Nov 2018 18:33:01 -0800 (PST)
MIME-Version: 1.0
References: <1543407379-3144-1-git-send-email-laoar.shao@gmail.com> <60467855-ea5f-3351-8b88-ffdfa60501e0@gmail.com>
In-Reply-To: <60467855-ea5f-3351-8b88-ffdfa60501e0@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 29 Nov 2018 10:32:25 +0800
Message-ID: <CALOAHbBGtJmwrT4pNbia1SX12NjVQjx49YbG=yJ7-o1FaP-g_A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce skb_rbtree_walk_safe() and use it
 in tcp_clean_rtx_queue()
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

On Wed, Nov 28, 2018 at 10:44 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 11/28/2018 04:16 AM, Yafang Shao wrote:
> > When walk RB tree, we'd better use skb_rbtree_walk* helpers, that can make
> > the code more clear.
> > As skb_rbtree_walk() can't be used in tcp_clean_rtx_queue(), so the new
> > helper skb_rbtree_walk_safe() is introduced.
>
> This makes things slower. Let me explain inline.
>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/skbuff.h | 5 +++++
> >  net/ipv4/tcp_input.c   | 5 ++---
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 73902ac..37ff792 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3256,6 +3256,11 @@ static inline int __skb_grow_rcsum(struct sk_buff *skb, unsigned int len)
> >               for (skb = skb_rb_first(root); skb != NULL;                     \
> >                    skb = skb_rb_next(skb))
> >
> > +#define skb_rbtree_walk_safe(skb, root, tmp)                                 \
> > +             for (skb = skb_rb_first(root);                                  \
> > +                  tmp = skb ? skb_rb_next(skb) : NULL, skb != NULL;          \
> > +                  skb = tmp)
> > +
> >  #define skb_rbtree_walk_from(skb)                                            \
> >               for (; skb != NULL;                                             \
> >                    skb = skb_rb_next(skb))
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index f323978..ab6add2 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3043,7 +3043,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
> >       struct tcp_sock *tp = tcp_sk(sk);
> >       u32 prior_sacked = tp->sacked_out;
> >       u32 reord = tp->snd_nxt; /* lowest acked un-retx un-sacked seq */
> > -     struct sk_buff *skb, *next;
> > +     struct sk_buff *skb, *tmp;
> >       bool fully_acked = true;
> >       long sack_rtt_us = -1L;
> >       long seq_rtt_us = -1L;
> > @@ -3055,7 +3055,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
> >
> >       first_ackt = 0;
> >
> > -     for (skb = skb_rb_first(&sk->tcp_rtx_queue); skb; skb = next) {
> > +     skb_rbtree_walk_safe(skb, &sk->tcp_rtx_queue, tmp) {
> >               struct tcp_skb_cb *scb = TCP_SKB_CB(skb);
> >               const u32 start_seq = scb->seq;
> >               u8 sacked = scb->sacked;
> > @@ -3126,7 +3126,6 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
> >               if (!fully_acked)
> >                       break;
> >
> > -             next = skb_rb_next(skb);
>
> We call skb_rb_next() here only, not at the beginning of the loop.
>
> Why ?
>
> Because we can break of the loop if the current skb is not fully acked.
>
> So your patch would add unnecessary overhead, since the extra sk_rb_next()
> could add more extra cache line misses.
>

I thought this extra sk_rb_next() doesn't add much overhead before,
since it won't take long time to execute.
Seems I made a mistake.

Thanks
Yafang
