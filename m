Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE0920896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTcv/8+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE0920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeGILy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:54:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39883 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbeGILy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:54:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id s21-v6so13538168pfm.6;
        Mon, 09 Jul 2018 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/lH4DXKout/UFWxjLWro/U9NkV1cL/dmID9g6rKKVoQ=;
        b=eTcv/8+LBvCzS9++kzX16ZeGehsxRRg+bjfEdaFIdsL6Afozq6yIvSU/CvAhLL6Mf8
         R3404R78N9C3g4diorwJaTVW/frPgV91eTcNjxVpM9/ktr5CNtKeymbg0h3C7/RiHLW+
         n9viaLCXVTEZIOlYk8WkE6d+NCUC74Pru0/DMUudeaRsNOKsfPHZ4WOukNVeXkIjVb0/
         eGEflOmzeqFFdzc5ZBiuygc/u8OnQL4oq3f8oFaqo0S7kl9XctFzmjyFjLbNCiEEZqQw
         ra18A8v2KbAPm21T4gAYRKeKGPRYb/eJAYPlPlwkNVwz8Ezd11089EW/y3chRRCeTiDA
         7tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/lH4DXKout/UFWxjLWro/U9NkV1cL/dmID9g6rKKVoQ=;
        b=bmLqS/6zR5FP/0q2vhJ4cJzlS6D37P13XlsDgTHhcx6jNrhy3Lg8KTy35bDZyk2fkD
         HR/OWTD4jJ1p79hh/IWoJsr9XDTPQSntqi81CVMgecP0KzNOPeCFB5MjVDBwh+DmdTIY
         n//gWYwWTbFWBkVq4xzX2qVVQfTpPbDP7h5o2enyRzxEJl1evJ6qBauPgKvqeu7QdYtq
         K2uCh1x7U3D1T5R4uQ7rfhLWGJ5SDyxMeCXBqFLkZfgOAmeclEtBfdaqxTwvNez7WT3n
         9Iq0cs/XHPRzri9NcXzOAyUF3gHnul67ICQqahxmvn+RnQ2TVObZzvNsJ+jdw8ocUcmk
         iwmQ==
X-Gm-Message-State: APt69E2Ir+kFaPd6LAMFI6uIQ/kLqqZh//0olAK3ZCfyqfiLfg15Isl8
        bro/rrCS45Yfb2jOBg18Acv35FEG
X-Google-Smtp-Source: AAOMgpei21dIXYoURKxMuroBbvBd+IybMLNKPm6EfDqj+yW/ocnoYutgEZj3vAOYWq27PPmS13EHrw==
X-Received: by 2002:a62:504e:: with SMTP id e75-v6mr21303256pfb.157.1531137296646;
        Mon, 09 Jul 2018 04:54:56 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id m5-v6sm24608521pfm.27.2018.07.09.04.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:54:55 -0700 (PDT)
Subject: Re: [PATCH] tcp: Added check of destination specific CC before
 sending syn/ack
To:     joakim.misund@gmail.com, Florian Westphal <fw@strlen.de>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180709112554.32754-1-joakim.misund@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <39c3ad45-2873-de2a-9204-6f63c6a10e5d@gmail.com>
Date:   Mon, 9 Jul 2018 04:54:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180709112554.32754-1-joakim.misund@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2018 04:25 AM, joakim.misund@gmail.com wrote:
> From: Joakim Misund <joakim.misund@gmail.com>
> 
> Issue:
> Currently TCP stack does not check for a destination specific CC before responding to a syn with a syn/ack.
> The system wide default CC is used. If the default CC does not need ECN, but the destination specific does,
> the syn/ack will not carry ECT(0) which makes it eligible to drop instead of being marked at routers.
> In an ECN-based network ECN marks are frequent (likely) and packet not carrying ECT(0) are likely to be dropped.
> This leads to slow connection establishment, and in worst case the establishment can fail.
> 
> Signed-off-by: Joakim Misund <joakim.misund@gmail.com>
> ---
>  include/net/tcp.h     | 1 +
>  net/ipv4/tcp_input.c  | 2 ++
>  net/ipv4/tcp_output.c | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index af3ec72d5d41..347c59ac0a72 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -545,6 +545,7 @@ void tcp_send_loss_probe(struct sock *sk);
>  bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto);
>  void tcp_skb_collapse_tstamp(struct sk_buff *skb,
>  			     const struct sk_buff *next_skb);
> +void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst);
>  
>  /* tcp_input.c */
>  void tcp_rearm_rto(struct sock *sk);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 8e5522c6833a..973e3b5b0516 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6401,6 +6401,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  		isn = af_ops->init_seq(skb);
>  	}
>  
> +	tcp_ca_dst_init(sk, dst);


At this point sk is not locked (and will not be)

Multiple cpus can handle SYN packets in // so this would be racy.

You need to solve this problem in another way.

Thanks.
