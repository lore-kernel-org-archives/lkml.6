Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeCPNtd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:49:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59806 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:49:31 -0400
Date: Fri, 16 Mar 2018 09:49:28 -0400 (EDT)
Message-Id: <20180316.094928.699803274284942791.davem@davemloft.net>
To: colin.king@canonical.com
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc: remove redundant initialization of variable
 'len'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180312172538.31707-1-colin.king@canonical.com>
References: <20180312172538.31707-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 12 Mar 2018 17:25:38 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable 'len' is being initialized with a value that is never
> read and it is re-assigned later, hence the initialization is redundant
> and can be removed.
> 
> Cleans up clang warning:
> net/rxrpc/recvmsg.c:275:15: warning: Value stored to 'len' during its
> initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Hehe, if the diff provided just 2 more lines of context at the bottom
we'd be able to see the overriding assignment :-)

> @@ -272,7 +272,7 @@ static int rxrpc_locate_data(struct rxrpc_call *call, struct sk_buff *skb,
>  			     unsigned int *_offset, unsigned int *_len)
>  {
>  	unsigned int offset = sizeof(struct rxrpc_wire_header);
> -	unsigned int len = *_len;
> +	unsigned int len;
>  	int ret;
>  	u8 annotation = *_annotation;
>  
> -- 
> 2.15.1
> 

Applied, thanks Colin.
