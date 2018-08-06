Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4821AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67CC219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67CC219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeHFLS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:18:59 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:44920 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeHFLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:18:59 -0400
Received: from [IPv6:2003:e9:d706:d44e:3252:cbff:fe54:190f] (p200300E9D706D44E3252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:e9:d706:d44e:3252:cbff:fe54:190f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 3D0FCC8534;
        Mon,  6 Aug 2018 11:10:50 +0200 (CEST)
Subject: Re: [PATCH] net: ieee802154: 6lowpan: remove redundant pointers 'fq'
 and 'net'
To:     Colin King <colin.king@canonical.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180731154507.5247-1-colin.king@canonical.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <12eda875-e456-6bde-d4c4-8e2cb3189cd0@datenfreihafen.org>
Date:   Mon, 6 Aug 2018 11:10:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731154507.5247-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 07/31/2018 05:45 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointers fq and net are being assigned but are never used hence they
> are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'fq' set but not used [-Wunused-but-set-variable]
> warning: variable 'net' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/ieee802154/6lowpan/reassembly.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index ec7a5da56129..e7857a8ac86d 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -40,9 +40,6 @@ static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
>  static void lowpan_frag_init(struct inet_frag_queue *q, const void *a)
>  {
>  	const struct frag_lowpan_compare_key *key = a;
> -	struct lowpan_frag_queue *fq;
> -
> -	fq = container_of(q, struct lowpan_frag_queue, q);
>  
>  	BUILD_BUG_ON(sizeof(*key) > sizeof(q->key));
>  	memcpy(&q->key, key, sizeof(*key));
> @@ -52,10 +49,8 @@ static void lowpan_frag_expire(struct timer_list *t)
>  {
>  	struct inet_frag_queue *frag = from_timer(frag, t, timer);
>  	struct frag_queue *fq;
> -	struct net *net;
>  
>  	fq = container_of(frag, struct frag_queue, q);
> -	net = container_of(fq->q.net, struct net, ieee802154_lowpan.frags);
>  
>  	spin_lock(&fq->q.lock);
>  
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
