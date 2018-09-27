Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B41F21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B41F21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeI0Veb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:34:31 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:50461 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0Vea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:34:30 -0400
Received: from localhost.localdomain (p200300E9D7234A78891558B353DFC2C9.dip0.t-ipconnect.de [IPv6:2003:e9:d723:4a78:8915:58b3:53df:c2c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 23C90C87C0;
        Thu, 27 Sep 2018 17:15:45 +0200 (CEST)
Subject: Re: [PATCH] ieee802154: ca8210: remove redundant condition check
 before debugfs_remove
To:     zhong jiang <zhongjiang@huawei.com>, h.morris@cascoda.com,
        alex.aring@gmail.com, davem@davemloft.net
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536901477-28375-1-git-send-email-zhongjiang@huawei.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <1501d440-c509-862e-c945-94665ec75c83@datenfreihafen.org>
Date:   Thu, 27 Sep 2018 17:15:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536901477-28375-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zhong.

On 14/09/2018 07:04, zhong jiang wrote:
> debugfs_remove has taken the IS_ERR into account. Just
> remove the unnecessary condition.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/net/ieee802154/ca8210.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 58299fb..46b4818 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -3044,8 +3044,7 @@ static void ca8210_test_interface_clear(struct ca8210_priv *priv)
>  {
>  	struct ca8210_test *test = &priv->test;
>  
> -	if (!IS_ERR(test->ca8210_dfs_spi_int))
> -		debugfs_remove(test->ca8210_dfs_spi_int);
> +	debugfs_remove(test->ca8210_dfs_spi_int);
>  	kfifo_free(&test->up_fifo);
>  	dev_info(&priv->spi->dev, "Test interface removed\n");
>  }
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
