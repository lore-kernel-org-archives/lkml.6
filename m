Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030218AbeEYUnk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:43:40 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37612 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968277AbeEYUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:43:39 -0400
Date: Fri, 25 May 2018 16:43:37 -0400 (EDT)
Message-Id: <20180525.164337.1433478215018599363.davem@davemloft.net>
To: jmaxwell37@gmail.com
Cc: dsahern@gmail.com, mschiffer@universe-factory.net,
        zhangshengju@cmss.chinamobile.com, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: Re: [PATCH net-next] ifb: fix packets checksum
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180524213829.15208-1-jmaxwell37@gmail.com>
References: <20180524213829.15208-1-jmaxwell37@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Fri, 25 May 2018 07:38:29 +1000

> Fixup the checksum for CHECKSUM_COMPLETE when pulling skbs on RX path. 
> Otherwise we get splats when tc mirred is used to redirect packets to ifb.
> 
> Before fix:
> 
> nic: hw csum failure
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>

This definitely seems correct, but I am really surprised a bug like this has
lasted as long as it has.

So I'll let this sit for another day or two for review.
