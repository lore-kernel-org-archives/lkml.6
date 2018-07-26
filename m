Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05E32083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISy1Q6te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05E32083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeGZFVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:21:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeGZFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:21:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so283925pgv.3;
        Wed, 25 Jul 2018 21:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aVdHGqkdCeIRo8JNoaS7G2vqJCUi6DGd7iM5TlW7vnU=;
        b=ISy1Q6teffmyk72W1k+K82z5rHpjmCy8IoBGI7dA0D31CrMIT/AVgB17ZenfbOkpsy
         nh2FliWb9N3MTOg2yWuDDGzRKGmc6l4GTxew6TwSR0QAbJE+7OG3VJFW70sWdL7fkp6+
         1hJsKcnvtTXP+Oa3/ih6sfNZifDpJ3q5tjsC1sc7UZL/gYBLuMskWyhmbUl4Q4afZFzn
         NKKRCdCWYrPJiW4iPix/s3WbKn1BVI/3jR1O8u+MRxA1lp7PNnn5QZPrmu/O0yyYU29U
         b6OBs/TOfGxdU8R5uwVEklU95S20bHUzZwwiVzHGQRXVremi/Y/tkH2/N8U9qe1+Jj6G
         3F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aVdHGqkdCeIRo8JNoaS7G2vqJCUi6DGd7iM5TlW7vnU=;
        b=d3c4B3gaB55mcsGiWNm6QZgxKYUS0gjbeZOd92ZBxLOSkDT6bZlT9v2Y7a5kNli42O
         +Vn8Tltq0v7k5x4cVRXR9qvwqbi0xCLwGVVC89NDrbdhuPiR1narW/jVTDqvByhL/8z1
         rFiidEG6sqm8hWZGhCdV55ml8DoMZV7uM7TglgaEyKDFiwifE6E+18B2e1KgEh4FgZDQ
         gyonsucqD4gilX9jFUNdqqhujNyiUMei2Py/0li9ZJOwtPvO2HenBZp5/i7awmad0Koa
         Wg0wt6kR8wDLk/qofjingnNZRRnx4Bfimlp7LVfUNpoDfmDlER4HMMo4MmQeWEqUP1YK
         NFpQ==
X-Gm-Message-State: AOUpUlHRnv1uJh6/7C1wlPwINzUoTH2T3tewrqOocR5vbT+53GQRChBT
        +0FtB4PVVjtSiMSgO6p4rCVQJ0HP
X-Google-Smtp-Source: AAOMgpdHXTYrbWUzx8N6Wm7MuheYYZ8Jd1w/+7npzpOAq+GwP25jHoBfSeQJWMdgvbZjB3RbSHJTVw==
X-Received: by 2002:a63:4106:: with SMTP id o6-v6mr336366pga.453.1532577971743;
        Wed, 25 Jul 2018 21:06:11 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id 86-v6sm372656pfh.0.2018.07.25.21.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 21:06:10 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: add SNMP counter for the number of packets
 pruned from ofo queue
To:     Yafang Shao <laoar.shao@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
 <047bc12f-9eb5-e512-10c5-6334c494c77e@gmail.com>
 <CALOAHbCC=oWgzcA=VhkXq0rVLBa5_TvtbKtTqESGrgxvYTtH6w@mail.gmail.com>
 <096a8a2f-ea32-2107-b2af-c246450cc3b9@gmail.com>
 <CALOAHbASvcEdudqpit-c=RRZ8xVD+G+0jU-ynp9PsH4_mU7xjw@mail.gmail.com>
 <CALOAHbAHgEF_=w_hbd_03NOH3h9m-4W=UJ0HCYGK0BtEyq=5Tw@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <70428ad9-5d59-faed-4384-36190939a19d@gmail.com>
Date:   Wed, 25 Jul 2018 21:06:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbAHgEF_=w_hbd_03NOH3h9m-4W=UJ0HCYGK0BtEyq=5Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2018 06:42 PM, Yafang Shao wrote:
 
> 
> Hi Eric,
> 
> LINUX_MIB_TCPOFOQUEUE, LINUX_MIB_TCPOFODROP and LINUX_MIB_TCPOFOMERGE
> are all for the number of SKBs, but only  LINUX_MIB_OFOPRUNED is for
> the event, that could lead misunderstading.
> So I think introducing a counter for the number of SKB pruned could be
> better, that could help us to track the whole behavior of ofo queue.
> That is why I submit this patch.

Sure, and I said your patch had issues.
You mixed 'packets' and 'skbs' but apparently you do not get my point.

I would rather not add another SNMP counter, and refine the current one,
trying to track something more meaningful.

The notion of 'skb' is internal to the kernel, and can not be mapped easily
to 'number of network segments' which probably is more useful for the user.

I will send this instead :

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d51fa358b2b196d0f9c258b24354813f2128a675..141a062abd0660c8f6d049de1dc7c7ecf7a7230d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5001,18 +5001,19 @@ static bool tcp_prune_ofo_queue(struct sock *sk)
 {
        struct tcp_sock *tp = tcp_sk(sk);
        struct rb_node *node, *prev;
+       unsigned int segs = 0;
        int goal;
 
        if (RB_EMPTY_ROOT(&tp->out_of_order_queue))
                return false;
 
-       NET_INC_STATS(sock_net(sk), LINUX_MIB_OFOPRUNED);
        goal = sk->sk_rcvbuf >> 3;
        node = &tp->ooo_last_skb->rbnode;
        do {
                prev = rb_prev(node);
                rb_erase(node, &tp->out_of_order_queue);
                goal -= rb_to_skb(node)->truesize;
+               segs += max_t(u16, 1, skb_shinfo(rb_to_skb(node))->gso_segs);
                tcp_drop(sk, rb_to_skb(node));
                if (!prev || goal <= 0) {
                        sk_mem_reclaim(sk);
@@ -5023,6 +5024,7 @@ static bool tcp_prune_ofo_queue(struct sock *sk)
                }
                node = prev;
        } while (node);
+       NET_ADD_STATS(sock_net(sk), LINUX_MIB_OFOPRUNED, segs);
        tp->ooo_last_skb = rb_to_skb(prev);
 
        /* Reset SACK state.  A conforming SACK implementation will

