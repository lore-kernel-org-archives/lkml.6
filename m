Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967550AbeEXPHs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:07:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46136 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967396AbeEXPHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:07:45 -0400
Date: Thu, 24 May 2018 11:07:43 -0400 (EDT)
Message-Id: <20180524.110743.522760687215216591.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: ganeshgr@chelsio.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] cxgb4: Check for kvzalloc allocation failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522070718.12864-1-yuehaibing@huawei.com>
References: <20180522070718.12864-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 22 May 2018 15:07:18 +0800

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 130d1ee..019cffe 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -4135,6 +4135,10 @@ static int adap_init0(struct adapter *adap)
>  		 * card
>  		 */
>  		card_fw = kvzalloc(sizeof(*card_fw), GFP_KERNEL);
> +		if (!card_fw) {
> +			ret = -ENOMEM;
> +			goto bye;
> +		}
>  

On error, this leaks fw_info.
