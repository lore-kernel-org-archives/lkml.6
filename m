Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeFCOml (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 10:42:41 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35580 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFCOmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 10:42:40 -0400
Date: Sun, 03 Jun 2018 10:42:36 -0400 (EDT)
Message-Id: <20180603.104236.1164095896276916209.davem@davemloft.net>
To: sam@mendozajonas.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next] net/ncsi: Avoid GFP_KERNEL in response handler
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180531070254.28878-1-sam@mendozajonas.com>
References: <20180531070254.28878-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Thu, 31 May 2018 17:02:54 +1000

> ncsi_rsp_handler_gc() allocates the filter arrays using GFP_KERNEL in
> softirq context, causing the below backtrace. This allocation is only a
> few dozen bytes during probing so allocate with GFP_ATOMIC instead.
 ...
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Applied with Fixes: tag added, thanks.
