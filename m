Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-88466-1525238465-2-1156101177503390493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525238464; b=JfDeW1joIlIjlHbUf2mVpoSaxkuexkf7cnBdawb7TCfWT7uBFE
    hr7SDxmS71O3DfII9aK1tvbp1jKIFR/GVegsexf5n1ieOx03bkF7q+lvTGd2jm9C
    bBa+HedxJtuo0I29Ezplu8FFPx/WphSU641lcOam8KF1ATuhx4Iq9UP+d0jgZVxf
    kZCmKHu8GnNi7w4zAA3n51RAQwcWRkRCME2h2lSikIoQ9ahf8X/Z619v/WpSTwHu
    QH2wMcooEIZJ2MWeYpDTw51YT+0ml2EFJQWy7jBac2tEVSZAfL2nUr5P4f10x2DK
    iYssO41YZjAMYE7gBU0jBTdyoqGoDl0tDfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525238464;
    bh=1xYgAKt2iJfS/CL1Md/DCtQA3KujGSVyfz0fEAUftc0=; b=iDl4HWQ/h9mV
    sjEb/2lbVCJGi31O1LZppz8YmW/A0qDkYrg9izps7nLFefwzhkkq30DC/3scwltA
    jq3w9pg2rJQz+BiehAIXVjy5NAXz08stT5UW0o9ZjcoDdDHWp6ecoOotGiP+9qif
    7NHmH9NkU9ivXqAg8jLw7j5mna/9TAcN29a3/hbAgUSR8Gn2ITvOLCn8/JqKbqLM
    8+Gn8fJx57VwbZ+rl2RqC1YwsA15hqpbjQ7RseWm4pYguV6YkkfdGAgDIxEjHcDQ
    mc/vfj6jOy2MicqAbRCATA69sW6IHfOaxQGT9vegEI2r18b7WnKQ2l2uFfa1Z6Hy
    7ixIknghSw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=VxHxG8Xf x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=OOtK6m6Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=VxHxG8Xf x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=OOtK6m6Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLW+J9AdvedE0ksfjl/qEOn+yzk7JlL3MEQZZWsM9C0mkk+JKnZMFuFZI7DyRhLJOPRpv8vWWT0r9bNrcp90gO8tBCG5v5YIDHwf1GQ6xWOz1ucwzEIr
    ifksn8lrVYMOH3pbkg5Vv0zVUWIY5wMJDDXlVJdRTuBjjDXfUwJjeK4H8Cr2I+rD2jx2xJhE3LcyrUCHApXcqS0qMuR6dyhxUzFA/+T6jaJA549EZw7/3clT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=FrHkxrfzMM0A:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8
    a=gc9acZ-2TVUN36RL1IsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeEBFVC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 01:21:02 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39148 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeEBFVA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 01:21:00 -0400
X-Google-Smtp-Source: AB8JxZpD/ZbQGzsfjVdO8+NsUIrTkuoZol/07T3jrqjQedp4LGQgUIquU3NBx7PpRAr8g/WAd3fvBQ==
Subject: Re: [Xen-devel] [PATCH 2/6] xen-netfront: copy response out of shared
 buffer before accessing it
To: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        stable@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <98a855dceb47dbebd9c87e024084f14a5cb127f7.1525122026.git-series.marmarek@invisiblethingslab.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <ad92ebe2-60f0-eff8-c937-31189e9555d7@gmail.com>
Date: Wed, 2 May 2018 08:20:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <98a855dceb47dbebd9c87e024084f14a5cb127f7.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/01/2018 12:01 AM, Marek Marczykowski-Górecki wrote:
> Make local copy of the response, otherwise backend might modify it while
> frontend is already processing it - leading to time of check / time of
> use issue.
>
> This is complementary to XSA155.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>   drivers/net/xen-netfront.c | 51 +++++++++++++++++++--------------------
>   1 file changed, 25 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 4dd0668..dc99763 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -387,13 +387,13 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
>   		rmb(); /* Ensure we see responses up to 'rp'. */
>   
>   		for (cons = queue->tx.rsp_cons; cons != prod; cons++) {
Side comment: the original concern was expressed on the above counters,
will those be addressed as a dedicated series?
> -			struct xen_netif_tx_response *txrsp;
> +			struct xen_netif_tx_response txrsp;
>   
> -			txrsp = RING_GET_RESPONSE(&queue->tx, cons);
> -			if (txrsp->status == XEN_NETIF_RSP_NULL)
> +			RING_COPY_RESPONSE(&queue->tx, cons, &txrsp);
> +			if (txrsp.status == XEN_NETIF_RSP_NULL)
>   				continue;
>   
IMO, there is still no guarantee you access consistent data after this 
change.
What if part of the response was ok when you started copying and
then, in the middle, backend poisons the end of the response?
This seems to be just like minimizing(?) chances to work with inconsistent
data rather than removing the possibility of such completely
> -			id  = txrsp->id;
> +			id  = txrsp.id;
>   			skb = queue->tx_skbs[id].skb;
>   			if (unlikely(gnttab_query_foreign_access(
>   				queue->grant_tx_ref[id]) != 0)) {
> @@ -741,7 +741,7 @@ static int xennet_get_extras(struct netfront_queue *queue,
>   			     RING_IDX rp)
>   
>   {
> -	struct xen_netif_extra_info *extra;
> +	struct xen_netif_extra_info extra;
>   	struct device *dev = &queue->info->netdev->dev;
>   	RING_IDX cons = queue->rx.rsp_cons;
>   	int err = 0;
> @@ -757,24 +757,23 @@ static int xennet_get_extras(struct netfront_queue *queue,
>   			break;
>   		}
>   
> -		extra = (struct xen_netif_extra_info *)
> -			RING_GET_RESPONSE(&queue->rx, ++cons);
> +		RING_COPY_RESPONSE(&queue->rx, ++cons, &extra);
>   
> -		if (unlikely(!extra->type ||
> -			     extra->type >= XEN_NETIF_EXTRA_TYPE_MAX)) {
> +		if (unlikely(!extra.type ||
> +			     extra.type >= XEN_NETIF_EXTRA_TYPE_MAX)) {
>   			if (net_ratelimit())
>   				dev_warn(dev, "Invalid extra type: %d\n",
> -					extra->type);
> +					extra.type);
>   			err = -EINVAL;
>   		} else {
> -			memcpy(&extras[extra->type - 1], extra,
> -			       sizeof(*extra));
> +			memcpy(&extras[extra.type - 1], &extra,
> +			       sizeof(extra));
>   		}
>   
>   		skb = xennet_get_rx_skb(queue, cons);
>   		ref = xennet_get_rx_ref(queue, cons);
>   		xennet_move_rx_slot(queue, skb, ref);
> -	} while (extra->flags & XEN_NETIF_EXTRA_FLAG_MORE);
> +	} while (extra.flags & XEN_NETIF_EXTRA_FLAG_MORE);
>   
>   	queue->rx.rsp_cons = cons;
>   	return err;
> @@ -784,28 +783,28 @@ static int xennet_get_responses(struct netfront_queue *queue,
>   				struct netfront_rx_info *rinfo, RING_IDX rp,
>   				struct sk_buff_head *list)
>   {
> -	struct xen_netif_rx_response *rx = &rinfo->rx;
> +	struct xen_netif_rx_response rx = rinfo->rx;
>   	struct xen_netif_extra_info *extras = rinfo->extras;
>   	struct device *dev = &queue->info->netdev->dev;
>   	RING_IDX cons = queue->rx.rsp_cons;
>   	struct sk_buff *skb = xennet_get_rx_skb(queue, cons);
>   	grant_ref_t ref = xennet_get_rx_ref(queue, cons);
> -	int max = MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD);
> +	int max = MAX_SKB_FRAGS + (rx.status <= RX_COPY_THRESHOLD);
>   	int slots = 1;
>   	int err = 0;
>   	unsigned long ret;
>   
> -	if (rx->flags & XEN_NETRXF_extra_info) {
> +	if (rx.flags & XEN_NETRXF_extra_info) {
>   		err = xennet_get_extras(queue, extras, rp);
>   		cons = queue->rx.rsp_cons;
>   	}
>   
>   	for (;;) {
> -		if (unlikely(rx->status < 0 ||
> -			     rx->offset + rx->status > XEN_PAGE_SIZE)) {
> +		if (unlikely(rx.status < 0 ||
> +			     rx.offset + rx.status > XEN_PAGE_SIZE)) {
>   			if (net_ratelimit())
>   				dev_warn(dev, "rx->offset: %u, size: %d\n",
> -					 rx->offset, rx->status);
> +					 rx.offset, rx.status);
>   			xennet_move_rx_slot(queue, skb, ref);
>   			err = -EINVAL;
>   			goto next;
> @@ -819,7 +818,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
>   		if (ref == GRANT_INVALID_REF) {
>   			if (net_ratelimit())
>   				dev_warn(dev, "Bad rx response id %d.\n",
> -					 rx->id);
> +					 rx.id);
>   			err = -EINVAL;
>   			goto next;
>   		}
> @@ -832,7 +831,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
>   		__skb_queue_tail(list, skb);
>   
>   next:
> -		if (!(rx->flags & XEN_NETRXF_more_data))
> +		if (!(rx.flags & XEN_NETRXF_more_data))
>   			break;
>   
>   		if (cons + slots == rp) {
> @@ -842,7 +841,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
>   			break;
>   		}
>   
> -		rx = RING_GET_RESPONSE(&queue->rx, cons + slots);
> +		RING_COPY_RESPONSE(&queue->rx, cons + slots, &rx);
>   		skb = xennet_get_rx_skb(queue, cons + slots);
>   		ref = xennet_get_rx_ref(queue, cons + slots);
>   		slots++;
> @@ -898,9 +897,9 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
>   	struct sk_buff *nskb;
>   
>   	while ((nskb = __skb_dequeue(list))) {
> -		struct xen_netif_rx_response *rx =
> -			RING_GET_RESPONSE(&queue->rx, ++cons);
> +		struct xen_netif_rx_response rx;
>   		skb_frag_t *nfrag = &skb_shinfo(nskb)->frags[0];
> +		RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
>   
>   		if (shinfo->nr_frags == MAX_SKB_FRAGS) {
>   			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
> @@ -911,7 +910,7 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
>   		BUG_ON(shinfo->nr_frags >= MAX_SKB_FRAGS);
>   
>   		skb_add_rx_frag(skb, shinfo->nr_frags, skb_frag_page(nfrag),
> -				rx->offset, rx->status, PAGE_SIZE);
> +				rx.offset, rx.status, PAGE_SIZE);
>   
>   		skb_shinfo(nskb)->nr_frags = 0;
>   		kfree_skb(nskb);
> @@ -1007,7 +1006,7 @@ static int xennet_poll(struct napi_struct *napi, int budget)
>   	i = queue->rx.rsp_cons;
>   	work_done = 0;
>   	while ((i != rp) && (work_done < budget)) {
> -		memcpy(rx, RING_GET_RESPONSE(&queue->rx, i), sizeof(*rx));
> +		RING_COPY_RESPONSE(&queue->rx, i, rx);
>   		memset(extras, 0, sizeof(rinfo.extras));
>   
>   		err = xennet_get_responses(queue, &rinfo, rp, &tmpq);
