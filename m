Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206BBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A79B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A79B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbeHALEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:04:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732437AbeHALEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:04:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2C148F54E2A4C;
        Wed,  1 Aug 2018 17:19:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 17:19:13 +0800
Subject: Re: [PATCH net-next] rxrpc: remove redundant variables 'xcall','sp'
 and 'did_discard'
To:     David Howells <dhowells@redhat.com>
References: <20180801073251.9808-1-yuehaibing@huawei.com>
 <15081.1533112094@warthog.procyon.org.uk>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-afs@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <22b396e6-1e8d-cfc1-8dfd-955ca23f7db8@huawei.com>
Date:   Wed, 1 Aug 2018 17:19:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <15081.1533112094@warthog.procyon.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/8/1 16:28, David Howells wrote:
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>>  		while (*pp) {
>>  			parent = *pp;
>> -			xcall = rb_entry(parent, struct rxrpc_call, sock_node);
>>  			if (user_call_ID < call->user_call_ID)
>>  				pp = &(*pp)->rb_left;
>>  			else if (user_call_ID > call->user_call_ID)
> 
> No, this is an actual bug.  The if-conditions should be using xcall-> not
> call->.

yes, I will post a new patch, thanks.

> 
>> -		sp = rxrpc_skb(skb);
> 
> Yeah, that's fine.
> 
>> -	did_discard = true;
> 
> Hmmm...  It looks like I intended something with this, but I don't remember
> what now.  I think it can be removed.
> 
> David
> 
> .
> 

