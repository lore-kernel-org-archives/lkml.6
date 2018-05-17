Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeEQT5F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:57:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34006 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:57:04 -0400
Date: Thu, 17 May 2018 15:57:02 -0400 (EDT)
Message-Id: <20180517.155702.2252512582618641001.davem@davemloft.net>
To: hpuranik@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        timur@codeaurora.org
Subject: Re: [PATCH] net: qcom/emac: Allocate buffers from local node
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526545680-21650-1-git-send-email-hpuranik@codeaurora.org>
References: <1526545680-21650-1-git-send-email-hpuranik@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemanth Puranik <hpuranik@codeaurora.org>
Date: Thu, 17 May 2018 13:58:00 +0530

> Currently we use non-NUMA aware allocation for TPD and RRD buffers,
> this patch modifies to use NUMA friendly allocation.
> 
> Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>
> ---
>  drivers/net/ethernet/qualcomm/emac/emac-mac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
> index 092718a..c3df86a 100644
> --- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
> +++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
> @@ -684,9 +684,10 @@ static int emac_tx_q_desc_alloc(struct emac_adapter *adpt,
>  {
>  	struct emac_ring_header *ring_header = &adpt->ring_header;
>  	size_t size;
> +	int node = dev_to_node(adpt->netdev->dev.parent);

Please order local variable declarations from longest to shortest line
(ie. reverse christmas tree layout).

> @@ -725,9 +726,10 @@ static int emac_rx_descs_alloc(struct emac_adapter *adpt)
>  	struct emac_ring_header *ring_header = &adpt->ring_header;
>  	struct emac_rx_queue *rx_q = &adpt->rx_q;
>  	size_t size;
> +	int node = dev_to_node(adpt->netdev->dev.parent);

Likewise.
