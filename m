Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3975C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1722417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1722417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeGEGCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:02:34 -0400
Received: from mail1.windriver.com ([147.11.146.13]:41138 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbeGEGCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:02:32 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w6562A7M006874
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 4 Jul 2018 23:02:11 -0700 (PDT)
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 4 Jul
 2018 23:02:10 -0700
Subject: Re: [PATCH] tipc: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180704211359.GA9836@embeddedor.com>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <7c9bd75f-a3e4-79fd-b7e7-79aeb42fbb50@windriver.com>
Date:   Thu, 5 Jul 2018 13:57:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704211359.GA9836@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 05:13 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used: -Wimplicit-fallthrough=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Ying Xue <ying.xue@windriver.com>

> ---
>  net/tipc/bearer.c | 1 +
>  net/tipc/link.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 2dfb492..fd6d8f1 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -610,6 +610,7 @@ static int tipc_l2_device_event(struct notifier_block *nb, unsigned long evt,
>  	case NETDEV_CHANGE:
>  		if (netif_carrier_ok(dev))
>  			break;
> +		/* else: fall through */
>  	case NETDEV_UP:
>  		test_and_set_bit_lock(0, &b->up);
>  		break;
> diff --git a/net/tipc/link.c b/net/tipc/link.c
> index 695acb7..6386032 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -1063,6 +1063,7 @@ static bool tipc_data_input(struct tipc_link *l, struct sk_buff *skb,
>  			skb_queue_tail(mc_inputq, skb);
>  			return true;
>  		}
> +		/* else: fall through */
>  	case CONN_MANAGER:
>  		skb_queue_tail(inputq, skb);
>  		return true;
> 
