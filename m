Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeEDQyQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:54:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35518 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeEDQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:54:14 -0400
Date: Fri, 04 May 2018 12:54:13 -0400 (EDT)
Message-Id: <20180504.125413.1422728285544894387.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atm: Fix potential Spectre v1
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180503184558.GA9705@embeddedor.com>
References: <20180503184558.GA9705@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 3 May 2018 13:45:58 -0500

> ioc_data.dev_num can be controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> net/atm/lec.c:702 lec_vcc_attach() warn: potential spectre issue
> 'dev_lec'
> 
> Fix this by sanitizing ioc_data.dev_num before using it to index
> dev_lec. Also, notice that there is another instance in which array
> dev_lec is being indexed using ioc_data.dev_num at line 705:
> lec_vcc_added(netdev_priv(dev_lec[ioc_data.dev_num]),
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied and queued up for -stable, thanks.
