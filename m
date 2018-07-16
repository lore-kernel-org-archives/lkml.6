Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBAF208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsc8rGE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBAF208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeGPQ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:28:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40268 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeGPQ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:28:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id e13-v6so13124023pff.7;
        Mon, 16 Jul 2018 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sxxkZr3VF/56EjFQW1QrcKwsTV4FRk+Enwi8KLAb6Ko=;
        b=Zsc8rGE3xDoXhvMlSmglsrHvdX+K1IFnst0DAOEnwpCbIWS2900kYJBGJQVFIu18Ny
         VjXl6E/sJVvMqtq/7J59uuTnP4/WnXPhiKUA2wDP+BSHCUf6VImkuTPDjXVDTsbXcUmE
         FLk28fNp2GYCuCd45yghqBrsuifUZkxUTostlpPgrY+fsGjZnoFQfdLTL0hsd0P0/1cI
         gvgCF6jnfxbRhd5fAQuswTdNwW26qjDOTGEj6fTIosxw319iY9DyykV+ukguG1hr2JbB
         M9IKHwjPEZJJ4UJflFcgNY/AI97u7Q4Tk7BOIfIjxlYl8qhDQIvC9kUXO5OyBEXNUDDt
         9lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxxkZr3VF/56EjFQW1QrcKwsTV4FRk+Enwi8KLAb6Ko=;
        b=mgXi22PbztepkSjCFUBSHwcYjVcNGA4KIIh4drfZjRtiOs26222n8smeEF3Pe+4Bl9
         GJg8bhrdOeomlWZnHiNw36A0pmEZl+EhTxdjdmiCdCKEGgGlvD/6KP46Krh2EYXN3dCU
         15252pIOFwr8CSOUhcXbbEzUPTUBfeICRJzNlRpZ0c9ciu6ZM7aozeWdyhaVuw/dQL8J
         Vb6BUFmn7v8tns++un1+nm7KJi8V4WwCY9Ye5Ifk31nwMVfYzHQcTBaxDZ8YIRZ7si2v
         Fl4/JiGflaHQDgt9SlDGbOPunwnck5ch3b7t7ZW5P8cFKM4QL5Edsz+j3g60Rymx2jG/
         GMsw==
X-Gm-Message-State: AOUpUlEt5nwPUwYVOtoBdxvaf687kNjlED1ecuwkF6q2rRYQzE/h+YI7
        Vc24Cf3TZpsbQUoW9xgkuJE=
X-Google-Smtp-Source: AAOMgpcFGwV/wKMs7t7E/3h6luDIij/UtAkxCvekv4cEKbenYcwzsuBSS59TGwnZlE6MBE6UXSIPnA==
X-Received: by 2002:a63:bf43:: with SMTP id i3-v6mr16070071pgo.342.1531756811256;
        Mon, 16 Jul 2018 09:00:11 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id j71-v6sm10998169pgd.23.2018.07.16.09.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:00:10 -0700 (PDT)
Subject: Re: [net-next, 3/3] tcp: convert icsk_user_timeout from jiffies to
 msecs
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180713004919.18608-1-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9a96cc7d-e7bd-5be2-9ce4-e74918773560@gmail.com>
Date:   Mon, 16 Jul 2018 09:00:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180713004919.18608-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2018 05:49 PM, Jon Maxwell wrote:
> The final patch in this series. Create the tcp_clamp_rto_to_user_timeout() 
> helper routine. To calculate the correct rto, so that the TCP_USER_TIMEOUT 
> socket option is more accurate. Taking suggestions and feedback into account 
> from Eric Dumazet, Neal Cardwell and David Laight. Due to the 1st commit we 
> can avoid the msecs_to_jiffies() and jiffies_to_msecs() dance.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
>  net/ipv4/tcp_timer.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 8ab8c9645294..d4d4b30a6bec 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -36,6 +36,22 @@ u32 tcp_retransmit_stamp(const struct sock *sk)
>  	return start_ts;
>  }
>  
> +static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +	u32 elapsed, start_ts;
> +
> +	start_ts = tcp_retransmit_stamp(sk);
> +	if (!icsk->icsk_user_timeout || !start_ts)
> +		return icsk->icsk_rto;
> +	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
> +	if (elapsed >= icsk->icsk_user_timeout)
> +		return 1; /* user timeout has passed; fire ASAP */
> +	else
> +		return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(icsk->icsk_user_timeout -
> +			     elapsed));

	if (elapsed >= icsk->icsk_user_timeout)
		return 1; /* user timeout has passed; fire ASAP */

	return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(icsk->icsk_user_timeout - elapsed));

Thanks !
