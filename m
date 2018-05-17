Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEQSvA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:51:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32806 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeEQSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:50:58 -0400
Date: Thu, 17 May 2018 14:50:56 -0400 (EDT)
Message-Id: <20180517.145056.1635507477734784563.davem@davemloft.net>
To: mmullins@fb.com
Cc: ilyal@mellanox.com, aviadye@mellanox.com, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: don't use stack memory in a scatterlist
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180516174841.2119-1-mmullins@fb.com>
References: <20180516174841.2119-1-mmullins@fb.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mullins <mmullins@fb.com>
Date: Wed, 16 May 2018 10:48:40 -0700

> scatterlist code expects virt_to_page() to work, which fails with
> CONFIG_VMAP_STACK=y.
> 
> Fixes: c46234ebb4d1e ("tls: RX path for ktls")
> Signed-off-by: Matt Mullins <mmullins@fb.com>

Applied and queued up for -stable, thanks.

I'm surprised this problem wasn't discovered sooner.  How exactly did you
discover it?  Did you actually see it trigger or is this purely from code
inspection?
