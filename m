Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeD3K1X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:27:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeD3K1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:27:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E844B60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: net: wireless: b43legacy: Replace GFP_ATOMIC with GFP_KERNEL in
 dma_tx_fragment
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1523368459-32128-1-git-send-email-baijiaju1990@gmail.com>
References: <1523368459-32128-1-git-send-email-baijiaju1990@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Larry.Finger@lwfinger.net, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180430102720.D5FC760710@smtp.codeaurora.org>
Date: Mon, 30 Apr 2018 10:27:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> dma_tx_fragment() is never called in atomic context.
> 
> dma_tx_fragment() is only called by b43legacy_dma_tx(), which is 
> only called by b43legacy_tx_work().
> b43legacy_tx_work() is only set a parameter of INIT_WORK() in 
> b43legacy_wireless_init().
> 
> Despite never getting called from atomic context,
> dma_tx_fragment() calls alloc_skb() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

6e1d8d1470b2 net: wireless: b43legacy: Replace GFP_ATOMIC with GFP_KERNEL in dma_tx_fragment

-- 
https://patchwork.kernel.org/patch/10333217/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
