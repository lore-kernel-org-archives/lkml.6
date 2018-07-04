Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC0BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ED922427
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYeK3K9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ED922427
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeGDOOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:14:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54537 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGDOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:14:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so5948672wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROZLDKQ/3ed5KSDetkjMa2yR/VRR1pqSCvqld/x69F4=;
        b=RYeK3K9D2y5fN7PuIEu84RK7mu+wERaPGGGW5IN1E5NyDBe2l+QEn5NBM0s8ZJo3gx
         5gt3pVQxKAlc+6HdQuVcdPqFOyxWvqJEk2EN9sNcybpG4FIRhib2TL+GuFW2oiKzizFj
         xJWXHXnba+oPqLUY4mkVygNnvewbdpsLQmiayT0pxlQoNJCVCNPbWaZ2E7ExKnpRy05l
         uD6cprX81MucFnJv34oBi8FracfGxBhZedQB4arqDoubxyxFFFLCmNs6WmTUL01IDHS1
         vQ5APeoBTXxgz++U24Wnqy/f8S2c6UvB1Io9bkaqUfrg51uC/8RURD/LLZumpFIowShK
         IpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROZLDKQ/3ed5KSDetkjMa2yR/VRR1pqSCvqld/x69F4=;
        b=tgjP4bbm5YKqzZB/9VFNFIdBwJAjZSymWeWiJ5Y/ATde7ZEWrOAMm0fuTdeHCTRuZc
         2Wix9krRcRZNjhMbQatqzUmD72hA5F9DdCm4rR+0yuMQJJE591J+XUTPJiN2W2OLAbtm
         xPES3c0+oAnN1fT/Xxc5of6OcuuSeIA37FhhFVgmd+Wq/HKLFSCeF637e3rqSTneoNFu
         ewuKTlBPExIdhaN7CGB2OoXBbkdDilVZMq8vyQyA/xmAX0BnCzsM3yAvkaatyViluj7g
         hDfsU/4YWZBEryfokP0WXpGeT/+HR8dSj4OxMV2qr7qhgRw8CR5P1a9vvRejsDTYTHn9
         B/nw==
X-Gm-Message-State: APt69E2MiKwiBxFPI4LbiM4Ke4ccCl3VN0B4+/k+uJTq8dEXCrDu/yMV
        gO3xvQyBqXN9O3HjMTfSYX0I82NQB47W50fvNMTw9g==
X-Google-Smtp-Source: AAOMgpdYPdCwdfIv1U0iGyOSyMRF3j0pRbkt0vQQjpwZaXZIZD0tqBaCWpkqCdlX7+Ua7wF9OI5PGYmJMaB3bpNl2sI=
X-Received: by 2002:a1c:2482:: with SMTP id k124-v6mr1597165wmk.87.1530713653369;
 Wed, 04 Jul 2018 07:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180704000608.17360-1-jmaxwell37@gmail.com>
In-Reply-To: <20180704000608.17360-1-jmaxwell37@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Wed, 4 Jul 2018 10:13:56 -0400
Message-ID: <CADVnQykfvmWyOJxT7_nHPOvfNEwi7+Hz2qJPooPpNLmdMWChYw@mail.gmail.com>
Subject: Re: [net-next,v2] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Jonathan Maxwell <jmaxwell37@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jmaxwell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 8:06 PM Jon Maxwell <jmaxwell37@gmail.com> wrote:
>
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
>  net/ipv4/tcp_timer.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 3b3611729928..d129e670d02a 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -22,6 +22,39 @@
>  #include <linux/gfp.h>
>  #include <net/tcp.h>
>
> +unsigned int tcp_retransmit_stamp(struct sock *sk)
> +{
> +       unsigned int start_ts = tcp_sk(sk)->retrans_stamp;

Since retrans_stamp and tcp_skb_timestamp() are both u32, I'd suggest
using u32 for the local variable start_ts and the return type of the
function.

> +
> +       if (unlikely(!start_ts)) {
> +               struct sk_buff *head = tcp_rtx_queue_head(sk);
> +
> +               if (!head)
> +                       return false;

Looks like a copy-and-paste holdover: since this function is returning
an integer, I would suggest returning 0 rather than false.

> +               start_ts = tcp_skb_timestamp(head);
> +       }
> +       return start_ts;
> +}
> +
> +static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
> +{
> +       struct inet_connection_sock *icsk = inet_csk(sk);
> +       __u32 rto = icsk->icsk_rto;
> +       __u32 elapsed, user_timeout;
> +       unsigned int start_ts;

I'd suggest u32 here for start_ts (per the rationale above).

> +
> +       start_ts = tcp_retransmit_stamp(sk);
> +       if (!icsk->icsk_user_timeout || !start_ts)
> +               return rto;
> +       elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
> +       user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);
> +       if (elapsed >= user_timeout)
> +               rto = 1;  /* user timeout has passed; fire ASAP */
> +       else
> +               rto = min(rto, (__u32)msecs_to_jiffies(user_timeout - elapsed));

My sense is that min_t would be preferred here, e.g:

  rto = min_t(__u32, rto, msecs_to_jiffies(user_timeout - elapsed));

> +       return rto;
> +}
> +
>  /**
>   *  tcp_write_err() - close socket and save error info
>   *  @sk:  The socket the error has appeared on.
> @@ -166,14 +199,9 @@ static bool retransmits_timed_out(struct sock *sk,
>         if (!inet_csk(sk)->icsk_retransmits)
>                 return false;
>
> -       start_ts = tcp_sk(sk)->retrans_stamp;
> -       if (unlikely(!start_ts)) {
> -               struct sk_buff *head = tcp_rtx_queue_head(sk);
> -
> -               if (!head)
> -                       return false;
> -               start_ts = tcp_skb_timestamp(head);
> -       }
> +       start_ts = tcp_retransmit_stamp(sk);
> +       if (!start_ts)
> +               return false;
>
>         if (likely(timeout == 0)) {
>                 linear_backoff_thresh = ilog2(TCP_RTO_MAX/rto_base);
> @@ -407,6 +435,7 @@ void tcp_retransmit_timer(struct sock *sk)
>         struct tcp_sock *tp = tcp_sk(sk);
>         struct net *net = sock_net(sk);
>         struct inet_connection_sock *icsk = inet_csk(sk);
> +       __u32 rto;
>
>         if (tp->fastopen_rsk) {
>                 WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
> @@ -535,7 +564,8 @@ void tcp_retransmit_timer(struct sock *sk)
>                 /* Use normal (exponential) backoff */
>                 icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
>         }
> -       inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, icsk->icsk_rto, TCP_RTO_MAX);
> +       rto = tcp_clamp_rto_to_user_timeout(sk);
> +       inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto, TCP_RTO_MAX);
>         if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
>                 __sk_dst_reset(sk);


Thanks!
neal
