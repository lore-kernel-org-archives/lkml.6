Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479C4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E750F24B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tR8yGiWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E750F24B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeGCON2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:13:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36254 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932208AbeGCON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:13:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so2150979wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGlKcEOD5XK2uvPkvjNpUf/86RjrDr863ELqH1WELFc=;
        b=tR8yGiWSJlYvlcNNYeDUnvdGF9BhFDyXLifMCYGwyTZdAecbh7CIYaMugsXj8Zr7xO
         Ugv5/6RDzNeQjDkJ0sdtQWYhcR+XjdHvK2wmn/Yx0fH6XN9SPL84peoS3hDkhGFVg5WE
         QZ3V7gv7MFTaxFGccOHLTy7xjTuvnGWZ1oHZeIlWRTRpAZykpsVPuivYnm+YzaK0/VdU
         sow+2MBHEnvSYHWNtdF0Y/T2Wx+hNpowc4S/d5HBYQTl1as8YFMMQHvGQ3pRZJFtkM1T
         og9hsGHtLG26kuOX2VgsnR16cd+I1RFk1vrVm78S7Plu5IHrOPLvd8I79uKjllvm79+/
         YTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGlKcEOD5XK2uvPkvjNpUf/86RjrDr863ELqH1WELFc=;
        b=JGvdP8Ga6muOOiGwJm8lujCeDLnJWZ2wtVE6n8owjNvDmEWEkH2DbisRVlfTpYS81o
         re5yGDV7igrNAo2cISP1F4NIbiQy449HiB7GYyDXJKzaTDCn1xW0pGQELJzbXWsFYmOs
         HzHvS4DP8RH5yovswnQLao+6MGBdtMoXIT+rexf50OsTYzlYONFjtxLkeonL/E5n8WTs
         p8DsWb+D5/smRYIWNYwcwKDf/Z9O509NlpPO5tznZQMhqqec5YzbrvIGZwutJ0/xHz4M
         P6d+UWY4CVw2cC7+Z53McXIlB3mZFHXZc8j0Okt41zpY4ZcJaV8SkNsLD+QLxDCihBIV
         J+nw==
X-Gm-Message-State: APt69E0+owm9pyFO6vlA5UKKCGPbVVSQaLiaxsJ4UNdXEhA9B/TXEE1U
        izMn2RpOoYUT12RXtusWRBNIniWdNo7xGZSnHJPOuw==
X-Google-Smtp-Source: AAOMgpcMbqiLqOv2NtGCiSU/JzAf3B6ZmuLrwgx8MUh+UV/LOPY3dfvs4Xz6mkcikaBe6DZrB6zra5qLzzFPDeQWUQQ=
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr22857176wri.124.1530627205362;
 Tue, 03 Jul 2018 07:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180703072113.19910-1-jmaxwell37@gmail.com>
In-Reply-To: <20180703072113.19910-1-jmaxwell37@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Tue, 3 Jul 2018 10:13:07 -0400
Message-ID: <CADVnQymzHMfjLKRRu0AmYa6PX6YXzyZ-2sF9TjyVfLZs6GVZTw@mail.gmail.com>
Subject: Re: [net-next,v1] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
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

On Tue, Jul 3, 2018 at 3:21 AM Jon Maxwell <jmaxwell37@gmail.com> wrote:
>
> v1 contains the following suggestions by Neal Cardwell:
>
> 1) Fix up units mismatch regarding msec/jiffies.
> 2) Address possiblility of time_remaining being negative.
> 3) Add a helper routine to do the rto calculation.
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
> Add tcp_clamp_rto_to_user_timeout() to determine if the user rto has expired.
> Or whether the rto interval needs to be recalculated. Use the original interval
> if user rto is not set.
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
>  net/ipv4/tcp_timer.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 3b3611729928..82c2a3b3713c 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -22,6 +22,23 @@
>  #include <linux/gfp.h>
>  #include <net/tcp.h>
>
> +static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
> +{
> +       struct inet_connection_sock *icsk = inet_csk(sk);
> +       __u32 rto = icsk->icsk_rto;
> +       __u32 elapsed, user_timeout;
> +
> +       if (!icsk->icsk_user_timeout)
> +               return rto;
> +       elapsed = tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp;

Thanks. The local logic seems OK to me now, but from reading
retransmits_timed_out() it looks like at this point in the code we are
not guaranteed that tcp_sk(sk)->retrans_stamp is initialized to
something non-zero. So we probably need a preceding preparatory patch
that factors out the first few lines of retransmits_timed_out()  into
a helper frunction to get the start_ts for use in this calculation.
Perhaps:

u32 tcp_retrans_stamp():
       start_ts = tcp_sk(sk)->retrans_stamp;
       if (unlikely(!start_ts)) {
               head = tcp_rtx_queue_head(sk);
               if (!head)
                       return 0;
               start_ts = tcp_skb_timestamp(head);
       }
       return start_ts;

And then the new tcp_clamp_rto_to_user_timeout() can use the helper:

...
retrans_stamp = tcp_retransmit_stamp(sk);
if (!retrans_stamp)
   return rto;
elapsed = tcp_time_stamp(tcp_sk(sk)) - retrans_stamp;
...

Eric wrote those lines to recalculate start_ts, so we may want to wait
until Eric returns to review this before merging the resulting patch
series.

neal
