Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04DFC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3732084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbfA1QrP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:47:15 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbfA1QrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:47:08 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C800430B2AE1E291356C;
        Mon, 28 Jan 2019 16:47:06 +0000 (GMT)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 28 Jan 2019 16:47:06 +0000
Received: from lhreml702-chm.china.huawei.com (10.201.108.51) by
 lhreml703-chm.china.huawei.com (10.201.108.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 28 Jan 2019 16:47:06 +0000
Received: from lhreml702-chm.china.huawei.com ([10.201.68.197]) by
 lhreml702-chm.china.huawei.com ([10.201.68.197]) with mapi id 15.01.1591.008;
 Mon, 28 Jan 2019 16:47:06 +0000
From:   Salil Mehta <salil.mehta@huawei.com>
To:     yuehaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] net: hns3: Fix potential NULL dereference on
 allocation error
Thread-Topic: [PATCH net-next] net: hns3: Fix potential NULL dereference on
 allocation error
Thread-Index: AQHUtFwEh/NZp5kVnESnQKcS0Nfs4qXE6BVg
Date:   Mon, 28 Jan 2019 16:47:06 +0000
Message-ID: <2ac4844616c6490284e91a0317e807a6@huawei.com>
References: <20190125031333.17196-1-yuehaibing@huawei.com>
In-Reply-To: <20190125031333.17196-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: yuehaibing
> Sent: Friday, January 25, 2019 3:14 AM
> To: davem@davemloft.net; Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>;
> Salil Mehta <salil.mehta@huawei.com>; lipeng (Y) <lipeng321@huawei.com>
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; yuehaibing <yuehaibing@huawei.com>
> Subject: [PATCH net-next] net: hns3: Fix potential NULL dereference on
> allocation error
> 
> hclge_mac_update_stats_complete doesn't check for NULL
> returns of kcalloc, it may result in an Oops.
> 
> Fixes: d174ea75c96a ("net: hns3: add statistics for PFC frames and MAC
> control frames")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 64b1589..7971606 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -343,6 +343,9 @@ static int hclge_mac_update_stats_complete(struct
> hclge_dev *hdev, u32 desc_num)
>  	int ret;
> 
>  	desc = kcalloc(desc_num, sizeof(struct hclge_desc), GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +


looks good to me.

Reviewed-by: Salil Mehta <salil.mehta@huawei.com>


