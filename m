Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mfrpEloHG1uJPwAAmS7hNA
	; Fri, 08 Jun 2018 22:48:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 462BE6089E; Fri,  8 Jun 2018 22:48:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A6A0860590;
	Fri,  8 Jun 2018 22:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6A0860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeFHWsR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:48:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49446 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeFHWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:48:16 -0400
Received: from localhost (unknown [50.234.174.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7240C133E8160;
        Fri,  8 Jun 2018 15:48:15 -0700 (PDT)
Date: Fri, 08 Jun 2018 18:48:14 -0400 (EDT)
Message-Id: <20180608.184814.2215583284330084945.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: fddi: fix a possible null-ptr-deref
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180608025825.25716-1-yuehaibing@huawei.com>
References: <20180608025825.25716-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Jun 2018 15:48:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 8 Jun 2018 10:58:25 +0800

> bp->SharedMemAddr is set to NULL while bp->SharedMemSize lesser-or-equal 0,
> then memset will trigger null-ptr-deref.
> 
> fix it by replacing pci_alloc_consistent with dma_zalloc_coherent.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v1->v2: move from pci_dma* to dma_* as Christoph suggested

Applied.
