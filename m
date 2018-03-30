Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeC3Q2O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:28:14 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32808 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeC3Q2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:28:13 -0400
Date: Fri, 30 Mar 2018 12:28:11 -0400 (EDT)
Message-Id: <20180330.122811.462608073364510854.davem@davemloft.net>
To: Jisheng.Zhang@synaptics.com
Cc: thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: mvneta: remove duplicate *_coal assignment
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180329172940.4a5f592c@xhacker.debian>
References: <20180329172940.4a5f592c@xhacker.debian>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Thu, 29 Mar 2018 17:29:40 +0800

> The style of the rx/tx queue's *_coal member assignment is:
> 
> static void foo_coal_set(...)
> {
> 	set the coal in hw;
> 	update queue's foo_coal member; [1]
> }
> 
> In other place, we call foo_coal_set(pp, queue->foo_coal), so the above [1]
> is duplicated and could be removed.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied.

We could make this convention even more explicit by not passing
the coalescing parameter into these helpers, but instead using
the value in rxq->foo and txq->foo.
