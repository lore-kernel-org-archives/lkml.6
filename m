Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEDQyI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:54:08 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35514 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeEDQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:54:06 -0400
Date: Fri, 04 May 2018 12:54:04 -0400 (EDT)
Message-Id: <20180504.125404.2298451507679774278.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: zatm: Fix potential Spectre v1
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180503181712.GA7443@embeddedor.com>
References: <20180503181712.GA7443@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 3 May 2018 13:17:12 -0500

> pool can be indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/atm/zatm.c:1462 zatm_ioctl() warn: potential spectre issue
> 'zatm_dev->pool_info' (local cap)
> 
> Fix this by sanitizing pool before using it to index
> zatm_dev->pool_info
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied and queued up for -stable.
