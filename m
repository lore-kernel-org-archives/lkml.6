Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E73C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD0024E86
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6o9dX5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD0024E86
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbeGCDA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:00:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51187 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbeGCDAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:00:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so639375wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6DY/LY6V7DWmnaEvwaSJgQ5AND7ibUG2sv7vSo7ewU=;
        b=n6o9dX5mH2g85EOX8Lkh/kKuuahcyX3hiPiqlqqVtzuA/K72TV1J4/HDEhYrNdMNje
         SfBBWF92IN0cBEdylBEEvBjgHtGCkcVdZqRqcX/HxsxO2luRkRQCo+R5S63U+prrXKOW
         ncGM3n7EiwRBfjkDierPDIt5Q6GMEljNWhcHxokwGQKOcxEAPirpTMVtVeXrWUsPjitB
         WnCK2oSJwVC6xTWdyWqZrPUrP1xv/LxrYYFcDiFW1WbHjaNrv5cwqENMUisHr1jEvPSo
         0aS5rAoinJzBCJLW7whTZGHJsNE1CxCNKcuiTXFWRR+K0/CrJZq/r4JwMXwgv6ENtvln
         ZGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6DY/LY6V7DWmnaEvwaSJgQ5AND7ibUG2sv7vSo7ewU=;
        b=iF05QDKvvauVpTmzsEKxPjBTPNFHhZFkc4NtsqNBwsyFJLJ9RxK4F8UIAKgZ9AjL2h
         po6jVNru7Jl5+Qutpn/uI8p2t5oyJKjuc2BoU2X49p9/IdJrgfnoihmjywbN8jhcUQX9
         AJtZFh1GHJ13N36PGptSmohBnXoT/gw46+uKsxSa+H/gIsM0M15QQrQYASvwT9KK84u2
         dl2Bcb0tuDZVJI3b/xk0dRxrXCzYiZOdtjlawPBTBlGRaq9j50CYcITzrvD6Q4QIMscH
         iQhFzQ3MuZmzyIhOOnyZ1jnAmAIfegZSmxZN8lg054tQqrZuFuAEA3z45bYuU1h3jCT2
         VBYg==
X-Gm-Message-State: APt69E3+AwmxrGHOV6s7Tu+U/4ndpCa9h/3qg7hnjVbiyKU+qoSNa1MG
        HrH89haRPcM2yC7y8KGUyK2Z3Pko67dP/LHHwNAflA==
X-Google-Smtp-Source: AAOMgpf15GihOm2477nyj5unuuzUIrClyZ4riVdovmKbjpiILn1I82v0obUIxJW9zH1x+IqbABix4Y3FHCnCVsUQk6I=
X-Received: by 2002:a1c:17d4:: with SMTP id 203-v6mr9238059wmx.75.1530586821417;
 Mon, 02 Jul 2018 20:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180703011726.8301-1-jmaxwell37@gmail.com>
In-Reply-To: <20180703011726.8301-1-jmaxwell37@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 2 Jul 2018 23:00:03 -0400
Message-ID: <CADVnQynNGbmBvheBdzzr5K8BVUXewzr61ZNsTz-mteE3eGUm3g@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     jmaxwell37@gmail.com
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

On Mon, Jul 2, 2018 at 9:18 PM Jon Maxwell <jmaxwell37@gmail.com> wrote:
>
> Every time the TCP retransmission timer fires. It checks to see if there is a
> timeout before scheduling the next retransmit timer. The retransmit interval
> between each retransmission increases exponentially. The issue is that in order
> for the timeout to occur the retransmit timer needs to fire again. If the user
> timeout check happens after the 9th retransmit for example. It needs to wait for
> the 10th retransmit timer to fire in order to evaluate whether a timeout has
> occurred or not. If the interval is large enough then the timeout will be
> inaccurate.
>
> For example with a TCP_USER_TIMEOUT of 10 seconds without patch:
>
> 1st retransmit:
>
> 22:25:18.973488 IP host1.49310 > host2.search-agent: Flags [.]
>
> Last retransmit:
>
> 22:25:26.205499 IP host1.49310 > host2.search-agent: Flags [.]
>
> Timeout:
>
> send: Connection timed out
> Sun Jul  1 22:25:34 EDT 2018
>
> We can see that last retransmit took ~7 seconds. Which pushed the total
> timeout to ~15 seconds instead of the expected 10 seconds. This gets more
> inaccurate the larger the TCP_USER_TIMEOUT value. As the interval increases.
>
> Fix this by recalculating the last retransmit interval so that it fires when
> the timeout should occur. Only implement when icsk->icsk_user_timeout is set.
>
> Test results with the patch is the expected 10 second timeout:
>
> 1st retransmit:
>
> 01:37:59.022555 IP host1.49310 > host2.search-agent: Flags [.]
>
> Last retransmit:
>
> 01:38:06.486558 IP host1.49310 > host2.search-agent: Flags [.]
>
> Timeout:
>
> send: Connection timed out
> Mon Jul  2 01:38:09 EDT 2018
>
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
>  net/ipv4/tcp_timer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 3b3611729928..94491a481722 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -407,6 +407,7 @@ void tcp_retransmit_timer(struct sock *sk)
>         struct tcp_sock *tp = tcp_sk(sk);
>         struct net *net = sock_net(sk);
>         struct inet_connection_sock *icsk = inet_csk(sk);
> +       __u32 time_remaining = 0;
>
>         if (tp->fastopen_rsk) {
>                 WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
> @@ -535,6 +536,12 @@ void tcp_retransmit_timer(struct sock *sk)
>                 /* Use normal (exponential) backoff */
>                 icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
>         }
> +       if (icsk->icsk_user_timeout) {
> +               time_remaining = jiffies_to_msecs(icsk->icsk_user_timeout) -
> +                              (tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp);
> +               if (time_remaining < icsk->icsk_rto)
> +                       icsk->icsk_rto = time_remaining;
> +       }

Thanks, a more precise user timeout sounds nice. A couple thoughts:

(a) The  icsk->icsk_rto is in jiffies, and the time_remaining is in
msecs, so it looks like there is a units mismatch here in the
comparisons and assignment.

(b) It also seems like the time_remaining could be negative, because
(a) the icsk_user_timeout is not involved in the baseline RTO
calculation, so that perhaps the first RTO to fire might be beyond the
icsk_user_timeout AFAIK, and (b) if the machine is very busy then the
timer handler can be delayed beyond the targeted icsk_user_timeout.
But time_remaining is a __u32, and  icsk->icsk_rto is also a __u32, so
it seems like a negative number in time_remaining would usually be
treated as a very large unsigned positive number in this comparison:

+               if (time_remaining < icsk->icsk_rto)

(c) If the user timeout is changed between RTO expirations to push the
user timeout further in the future,  then it seems like this commit
will have side effects that left the icsk->icsk_rto in a weird state
that does not do the expected exponential backoff correctly.

(d) There are also wrapping issues to watch out for, since the
tcp_time_stamp(tcp_sk(sk)) and tcp_sk(sk)->retrans_stamp are
milliseconds, which will wrap every 49 days or so. Seems like the code
is OK in that respect.

(e) It also might be nice to put this logic in a helper, rather than
growing the body of tcp_retransmit_timer().

What about something like (pseudocode):

--

static __u32 tcp_clamp_rto_to_user_timeout(sk):
   rto = icsk->icsk_rto;
   if (!icsk->icsk_user_timeout)
      return rto;
   elapsed = tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp;
   user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);
   if (elapsed >= user_timeout)
      rto = 1;  /* user timeout has passed; fire ASAP */
   else
      rto = min(rto, msecs_to_jiffies(user_timeout - elapsed));
   return rto;

tcp_retransmit_timer():
...
  rto = tcp_clamp_rto_to_user_timeout(sk);
  inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto, TCP_RTO_MAX);

--

neal
