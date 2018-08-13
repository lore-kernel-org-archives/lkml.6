Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A988DC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6124B21870
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6124B21870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeHMJbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:31:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbeHMJbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:31:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5316427FD089F;
        Mon, 13 Aug 2018 14:50:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 14:50:45 +0800
Subject: Re: [PATCH] cxgb4: remove set but not used variable 'spd'
To:     <ganeshgr@chelsio.com>, <davem@davemloft.net>
References: <20180813064851.912-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <1cd1bf32-e4a6-c0ae-c5c0-f991968b4ba0@huawei.com>
Date:   Mon, 13 Aug 2018 14:50:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180813064851.912-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this should be for net-next

On 2018/8/13 14:48, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c: In function 'print_port_info':
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:5147:14: warning:
>  variable 'spd' set but not used [-Wunused-but-set-variable]
> 
> variable 'spd' is set but not used since
> commit 547fd27241a8 ("cxgb4: Warn if device doesn't have enough PCI bandwidth")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 69590cf..961e3087 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -5144,17 +5144,9 @@ static void print_port_info(const struct net_device *dev)
>  {
>  	char buf[80];
>  	char *bufp = buf;
> -	const char *spd = "";
>  	const struct port_info *pi = netdev_priv(dev);
>  	const struct adapter *adap = pi->adapter;
>  
> -	if (adap->params.pci.speed == PCI_EXP_LNKSTA_CLS_2_5GB)
> -		spd = " 2.5 GT/s";
> -	else if (adap->params.pci.speed == PCI_EXP_LNKSTA_CLS_5_0GB)
> -		spd = " 5 GT/s";
> -	else if (adap->params.pci.speed == PCI_EXP_LNKSTA_CLS_8_0GB)
> -		spd = " 8 GT/s";
> -
>  	if (pi->link_cfg.pcaps & FW_PORT_CAP32_SPEED_100M)
>  		bufp += sprintf(bufp, "100M/");
>  	if (pi->link_cfg.pcaps & FW_PORT_CAP32_SPEED_1G)
> 

