Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A9220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A9220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbeHAH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:59:43 -0400
Received: from mail.windriver.com ([147.11.1.11]:45409 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733087AbeHAH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:59:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w716FVld024776
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 31 Jul 2018 23:15:31 -0700 (PDT)
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 31 Jul
 2018 23:15:30 -0700
Subject: Re: [PATCH] net/tipc: remove redundant variables 'tn' and 'oport'
To:     Colin King <colin.king@canonical.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180731160137.5850-1-colin.king@canonical.com>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <34f9d78b-cce8-469a-3f5c-a96c1a6a4197@windriver.com>
Date:   Wed, 1 Aug 2018 14:10:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180731160137.5850-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 12:01 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables 'tn' and 'oport'  are being assigned but are never used hence
> they are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'oport' set but not used [-Wunused-but-set-variable]
> warning: variable 'tn' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Ying Xue <ying.xue@windriver.com>

> ---
>  net/tipc/socket.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index 3763bedecf5f..c1e93c9515bc 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -411,7 +411,6 @@ static int tipc_sk_sock_err(struct socket *sock, long *timeout)
>  static int tipc_sk_create(struct net *net, struct socket *sock,
>  			  int protocol, int kern)
>  {
> -	struct tipc_net *tn;
>  	const struct proto_ops *ops;
>  	struct sock *sk;
>  	struct tipc_sock *tsk;
> @@ -446,7 +445,6 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
>  	INIT_LIST_HEAD(&tsk->publications);
>  	INIT_LIST_HEAD(&tsk->cong_links);
>  	msg = &tsk->phdr;
> -	tn = net_generic(sock_net(sk), tipc_net_id);
>  
>  	/* Finish initializing socket data structures */
>  	sock->ops = ops;
> @@ -1117,7 +1115,7 @@ void tipc_sk_mcast_rcv(struct net *net, struct sk_buff_head *arrvq,
>  	u32 self = tipc_own_addr(net);
>  	u32 type, lower, upper, scope;
>  	struct sk_buff *skb, *_skb;
> -	u32 portid, oport, onode;
> +	u32 portid, onode;
>  	struct sk_buff_head tmpq;
>  	struct list_head dports;
>  	struct tipc_msg *hdr;
> @@ -1133,7 +1131,6 @@ void tipc_sk_mcast_rcv(struct net *net, struct sk_buff_head *arrvq,
>  		user = msg_user(hdr);
>  		mtyp = msg_type(hdr);
>  		hlen = skb_headroom(skb) + msg_hdr_sz(hdr);
> -		oport = msg_origport(hdr);
>  		onode = msg_orignode(hdr);
>  		type = msg_nametype(hdr);
>  
> 
