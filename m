Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1467C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C44217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP9v4Cus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfBLPHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:07:31 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38801 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:07:30 -0500
Received: by mail-yb1-f195.google.com with SMTP id x9so1143265ybj.5;
        Tue, 12 Feb 2019 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HDvAGxIoJenry2A9MarN1qHi3OjHsoI8Z2hcVFAwMIM=;
        b=dP9v4CuskASrxW01o/z7hyGY/rezEd+7Hfpnx4OO/9pB8em42dxBqb9EALvMtcT9Px
         eLeFd6bebmnbsp4i6YWjO1caqvk9OYE0X+OOu/jv/AZJAWidC6tto5RvQwy32p/Rehup
         vn2sAmI+3uTFDXHrLHgY8S5MJ5jEc7pzFrOL8cjFMauQUY4kcpyZQfqtYlezdpU8Jdn9
         yFetKWsIKJCIIVuZEK4LqklBaXZP3l3HhEalkDbkwDjjw0Endpm3ODjPqkS5qkdT5gF3
         IL0vUip99350qy4Dxmy35whNx0ZcGRzmmQnEv/FACfWh3Z2rcgLT4eQz5O3G2AuFmIBV
         +pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HDvAGxIoJenry2A9MarN1qHi3OjHsoI8Z2hcVFAwMIM=;
        b=fdEFF88pEJfuOpDbIKdkLTqcoeKtMYKqdkwRP0d+pT4VikdWEAN5Nwdj4RIm0pF4Qr
         cQnI6H9DGIToJ+ecpUMi6o1CNAvCsBDU3uBCsXcl+81q1gZTv6wf6Lf/vdvztGyZKO12
         Gx0Baz5IhMlV18YbLR8uIYltzmwNPimq1IZBz+GVpwHAvs51XOSDv/lrq8ql96o2/N46
         UrtUysK+hVmp9i2d303HSC3ElCI8Z4J8XyXKozQPc9yAul5QjRBsRFJ1JNHZVuRGtpYB
         NCBQ8AM07Y5vLxdQi+2gtFa+3PjAFQZySnDXJjH5A7/CgmIlqxH/Yi5MRU5YcgROCDMY
         Gp8Q==
X-Gm-Message-State: AHQUAuaidz+f3JQSj9mYwG3mX0XeqhjvqqXJbMK5Rlvm6mu7PyYHimDy
        yztX5MgsniteE6eTOkFXKa0=
X-Google-Smtp-Source: AHgI3Ia6X9HfZzv21NMPRN60tqf98wOzjTuMxbFvGju/yuCg7SD7/ITn8h8i0x2DFcNBlUTSG5LeHw==
X-Received: by 2002:a25:d6ce:: with SMTP id n197mr3162655ybg.313.1549984049638;
        Tue, 12 Feb 2019 07:07:29 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id r124sm4811471ywb.39.2019.02.12.07.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 07:07:28 -0800 (PST)
Subject: Re: [bpf-next 1/2] tcp: replace SOCK_DEBUG() with tcp_stats()
To:     Yafang Shao <laoar.shao@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org
Cc:     yhs@fb.com, brakmo@fb.com, edumazet@google.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-2-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <38d07cb3-b767-bfc4-9ae5-48367971d839@gmail.com>
Date:   Tue, 12 Feb 2019 07:07:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1549971097-12627-2-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2019 03:31 AM, Yafang Shao wrote:
> SOCK_DEBUG is a very ancient debugging interface, and it's not very useful
> for debugging.
> So this patch removes the SOCK_DEBUG() and introduce a new function
> tcp_stats() to trace this kind of events.
> Some MIBs are added for these events.
> 
> Regarding the SO_DEBUG in sock_{s,g}etsockopt, I think it is better to
> keep as-is, because if we return an errno to tell the application that
> this optname isn't supported for TCP, it may break the application.
> The application still can use this option but don't take any effect for
> TCP.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/snmp.h |  3 +++
>  net/ipv4/proc.c           |  3 +++
>  net/ipv4/tcp_input.c      | 26 +++++++++++---------------
>  net/ipv6/tcp_ipv6.c       |  2 --
>  4 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 86dc24a..fd5c09c 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -283,6 +283,9 @@ enum
>  	LINUX_MIB_TCPACKCOMPRESSED,		/* TCPAckCompressed */
>  	LINUX_MIB_TCPZEROWINDOWDROP,		/* TCPZeroWindowDrop */
>  	LINUX_MIB_TCPRCVQDROP,			/* TCPRcvQDrop */
> +	LINUX_MIB_TCPINVALIDACK,		/* TCPInvalidAck */
> +	LINUX_MIB_TCPOLDACK,			/* TCPOldAck */
> +	LINUX_MIB_TCPPARTIALPACKET,		/* TCPPartialPacket */
>  	__LINUX_MIB_MAX
>  };
>  
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index c3610b3..1b0320a 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -291,6 +291,9 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
>  	SNMP_MIB_ITEM("TCPAckCompressed", LINUX_MIB_TCPACKCOMPRESSED),
>  	SNMP_MIB_ITEM("TCPZeroWindowDrop", LINUX_MIB_TCPZEROWINDOWDROP),
>  	SNMP_MIB_ITEM("TCPRcvQDrop", LINUX_MIB_TCPRCVQDROP),
> +	SNMP_MIB_ITEM("TCPInvalidAck", LINUX_MIB_TCPINVALIDACK),
> +	SNMP_MIB_ITEM("TCPOldAck", LINUX_MIB_TCPOLDACK),
> +	SNMP_MIB_ITEM("TCPPartialPacket", LINUX_MIB_TCPPARTIALPACKET),
>  	SNMP_MIB_SENTINEL
>  };
>  
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7a027dec..88deb1f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3554,6 +3554,11 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
>  	return delivered;
>  }
>  
> +static void tcp_stats(struct sock *sk, int mib_idx)
> +{
> +	NET_INC_STATS(sock_net(sk), mib_idx);
> +}

This is not a very descriptive name.

Why is it static, and in net/ipv4/tcp_input.c ???

> +
>  /* This routine deals with incoming acks, but not outgoing ones. */
>  static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  {
> @@ -3715,7 +3720,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  	return 1;
>  
>  invalid_ack:
> -	SOCK_DEBUG(sk, "Ack %u after %u:%u\n", ack, tp->snd_una, tp->snd_nxt);
> +	tcp_stats(sk, LINUX_MIB_TCPINVALIDACK);
>  	return -1;
>  
>  old_ack:
> @@ -3731,7 +3736,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  		tcp_xmit_recovery(sk, rexmit);
>  	}
>  
> -	SOCK_DEBUG(sk, "Ack %u before %u:%u\n", ack, tp->snd_una, tp->snd_nxt);
> +	tcp_stats(sk, LINUX_MIB_TCPOLDACK);
>  	return 0;
>  }
>


These counters will add noise to an already crowded MIB space.

What bug do you expect to track and fix with these ?

I see many TCP patches coming adding icache pressure, enabling companies to build their own modified
TCP stack, but no real meat.

