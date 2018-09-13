Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09986C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD9C20839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD9C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIMRQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:16:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbeIMRQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:16:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 78120C1B03DCF;
        Thu, 13 Sep 2018 20:07:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Thu, 13 Sep 2018
 20:07:00 +0800
Subject: Re: [PATCH net-next] NFC: nci: remove redundant variable 'status'
To:     <davem@davemloft.net>, <sameo@linux.intel.com>
References: <20180801072020.14696-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <c168a8ff-0736-d21d-9c5c-bde001ad018c@huawei.com>
Date:   Thu, 13 Sep 2018 20:06:59 +0800
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

Ping.

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

