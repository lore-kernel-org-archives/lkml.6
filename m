Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C46C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049FB208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERxAbjGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049FB208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeGJMi7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:38:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35033 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeGJMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:38:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so1994785pgv.2;
        Tue, 10 Jul 2018 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/o4BSnZp1UM6uFQpeH0adSASPNhivj83VTU1n2jJ2n8=;
        b=ERxAbjGlOD12JAhi+VLOFjAsm8n6kFe3VRqK6q4be54Uxp9S0QVBA71yKwnhsKuay6
         ylCvsEqOdCpn2xaQRRI3gPhZc3sIzHozPzQtwxXO59DmeFeApVXb+wqnGwwmD2dGk1YK
         NVAqW2SAsPE84aiAoFNBBVFOT/uer8/IyKDUQTrl0JAnyU1qRAP+kGw4YkaFnRgYteWR
         za6riANlvQaSSNAwDKfzb/5Lb6ykOyP2Ohc9lZdio3HDiXCbYFPEs2+Nz1gg7SOHguV+
         sr0Ow4A0iW3X252jslMuYAkAr3owwPi3SI5sVDJumDeWptAtlchobtqXvanJH0NavJWA
         UDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/o4BSnZp1UM6uFQpeH0adSASPNhivj83VTU1n2jJ2n8=;
        b=cQKtn8YvspvYik0flh5F2Tw1FyJ2KbH6S0Heafp6jvp0tKJqkZv0YgtMDrfsxAfBiR
         0ske1MswW+3WG2NZ9tDFx6iG2ri4TVD+PctKxQKBjbJMzXlHUPrEK7GC/72xdDBnhvUl
         E5PkebhoXi4qu4PAL8yze0tSNtvkqdTwY5h4rxIlDfchEPea1X1HYGzSLV2JDxnoc2AK
         GTRXmg3XyHF32PaWW2ZykSuYpy9pwhX8/Q6dwgNkSArftWGWw1vOJwXRgO0b5NodO8Wk
         rRCoSpl9jqSznZyi32BHAnT7JfT/oJJto4NxpaDtl2DQxzdakyswYBTxSon9uQn8dTIg
         fMDA==
X-Gm-Message-State: APt69E3TkTnY0UcJyncIzBOiQ9yz0rsToglYWDWEgp/YDSPs23jOJe03
        M7Oi6FUTyD7m/RfD8gI/1AI=
X-Google-Smtp-Source: AAOMgpf8Bvy7shcvHFEERNws5yxuopvJ43XvWOL6WDRySO/qeu/5jgsk8U/ptjwzae5yZ2z12r9KIQ==
X-Received: by 2002:a65:4545:: with SMTP id x5-v6mr22466201pgr.4.1531226337297;
        Tue, 10 Jul 2018 05:38:57 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id t21-v6sm5285701pfh.45.2018.07.10.05.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:38:56 -0700 (PDT)
Subject: Re: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
References: <20180710065147.27647-1-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <3f856638-52bc-6630-a3d2-2b50f1bf7e48@gmail.com>
Date:   Tue, 10 Jul 2018 05:38:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180710065147.27647-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2018 11:51 PM, Jon Maxwell wrote:
> v3 contains the following suggestions by Neal Cardwell:
> 
> 1) Fix up units mismatch regarding msec/jiffies.
> 2) Address possiblility of time_remaining being negative.
> 3) Add a helper routine tcp_clamp_rto_to_user_timeout() to do the rto 
> calculation.
> 4) Move start_ts logic into helper routine tcp_retrans_stamp() to 
> validate tcp_sk(sk)->retrans_stamp.
> 5) Some u32 declation and return refactoring.
> 6) Return 0 instead of false in tcp_retransmit_stamp(), it's not a bool.
> 
> Suggestions by David Laight:
> 
> 1) Don't cache rto in tcp_clamp_rto_to_user_timeout().
> 2) Use conditional operator instead of min_t() in 
> tcp_clamp_rto_to_user_timeout()
> 
> Changes:
> 
> 1) Call tcp_clamp_rto_to_user_timeout(sk) as an argument to 
> inet_csk_reset_xmit_timer() to save on rto declaration.
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
>  net/ipv4/tcp_timer.c | 49 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 3b3611729928..93239e58776d 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -22,6 +22,38 @@
>  #include <linux/gfp.h>
>  #include <net/tcp.h>
>  
> +u32 tcp_retransmit_stamp(struct sock *sk)

const struct sock *sk;

(To clearly express the fact this helper does not touch the socket)

> +{
> +	u32 start_ts = tcp_sk(sk)->retrans_stamp;
> +
> +	if (unlikely(!start_ts)) {
> +		struct sk_buff *head = tcp_rtx_queue_head(sk);
> +
> +		if (!head)
> +			return 0;
> +		start_ts = tcp_skb_timestamp(head);
> +	}
> +	return start_ts;
> +}
> +
> +static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)

const struct sock *sk

> +{
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +	__u32 elapsed, user_timeout;
> +	u32 start_ts;

Mixing __u32 and u32 in new code is confusing.

__u32 are needed in uapi include files, not in the C kernel code.

	u32 elapsed, user_timeout, start_ts;

> +
> +	start_ts = tcp_retransmit_stamp(sk);
> +	if (!icsk->icsk_user_timeout || !start_ts)
> +		return icsk->icsk_rto;
> +	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
> +	user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);

Note that if we always do jiffies_to_msecs(icsk->icsk_user_timeout) in TCP,
we also could change the convention and store msecs in this field instead of jiffies.

That would eliminate the msecs_to_jiffies() and jiffies_to_msecs() dance.

(That would be done in a patch of its own, of course)

> +	if (elapsed >= user_timeout)
> +		return 1; /* user timeout has passed; fire ASAP */
> +	else
> +		return (icsk->icsk_rto < msecs_to_jiffies(user_timeout - elapsed)) ?
> +			icsk->icsk_rto : msecs_to_jiffies(user_timeout - elapsed);


return min_t(i32, icsk->icsk_rto, msecs_to_jiffies(user_timeout - elapsed));

> +}
> +
>  /**
>   *  tcp_write_err() - close socket and save error info
>   *  @sk:  The socket the error has appeared on.
> @@ -161,19 +193,15 @@ static bool retransmits_timed_out(struct sock *sk,
>  				  unsigned int timeout)
>  {
>  	const unsigned int rto_base = TCP_RTO_MIN;
> -	unsigned int linear_backoff_thresh, start_ts;
> +	unsigned int linear_backoff_thresh;
> +	u32 start_ts;

This seems a gratuitous change, making your patch bigger than necessary.

u32 and unsigned int are the same essentially.

>  
>  	if (!inet_csk(sk)->icsk_retransmits)
>  		return false;
>  
> -	start_ts = tcp_sk(sk)->retrans_stamp;
> -	if (unlikely(!start_ts)) {
> -		struct sk_buff *head = tcp_rtx_queue_head(sk);
> -
> -		if (!head)
> -			return false;
> -		start_ts = tcp_skb_timestamp(head);
> -	}
> +	start_ts = tcp_retransmit_stamp(sk);
> +	if (!start_ts)
> +		return false;

One thing you could do is to make this refactoring in a single patch,
and provide a patch series, with small units, making the review easier.

>  
>  	if (likely(timeout == 0)) {
>  		linear_backoff_thresh = ilog2(TCP_RTO_MAX/rto_base);
> @@ -535,7 +563,8 @@ void tcp_retransmit_timer(struct sock *sk)
>  		/* Use normal (exponential) backoff */
>  		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
>  	}
> -	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, icsk->icsk_rto, TCP_RTO_MAX);
> +	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
> +				  tcp_clamp_rto_to_user_timeout(sk), TCP_RTO_MAX);
>  	if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
>  		__sk_dst_reset(sk);
>  
> 

Thanks !
