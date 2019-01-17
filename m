Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4970C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E24D20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfAQIS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:18:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbfAQIS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:18:28 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D2F6D69661FF23D89A1C;
        Thu, 17 Jan 2019 16:18:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 16:18:23 +0800
Subject: Re: [PATCH net-next] NFC: nci: remove redundant variable 'status'
To:     <davem@davemloft.net>, <sameo@linux.intel.com>
References: <20180801072020.14696-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a5acdd86-fd8f-f1d1-b5e9-6f01ae323e33@huawei.com>
Date:   Thu, 17 Jan 2019 16:18:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180801072020.14696-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On 2018/8/1 15:20, YueHaibing wrote:
> After commit d8cd37ed2fc8 ("NFC: nci: Fix improper management of HCI return code")
> variable 'status' is being assigned but never used,
> so can be removed. Also make a trival cleanup.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/nfc/nci/hci.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
> index ddfc52a..4debba8 100644
> --- a/net/nfc/nci/hci.c
> +++ b/net/nfc/nci/hci.c
> @@ -370,17 +370,11 @@ static void nci_hci_resp_received(struct nci_dev *ndev, u8 pipe,
>  				  u8 result, struct sk_buff *skb)
>  {
>  	struct nci_conn_info    *conn_info;
> -	u8 status = result;
>  
>  	conn_info = ndev->hci_dev->conn_info;
> -	if (!conn_info) {
> -		status = NCI_STATUS_REJECTED;
> -		goto exit;
> -	}
> -
> -	conn_info->rx_skb = skb;
> +	if (conn_info)
> +		conn_info->rx_skb = skb;
>  
> -exit:
>  	nci_req_complete(ndev, NCI_STATUS_OK);
>  }
>  
> 

