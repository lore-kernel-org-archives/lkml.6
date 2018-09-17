Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B1FECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F069214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F069214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIQOCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:02:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbeIQOCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:02:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62828A0779193;
        Mon, 17 Sep 2018 16:35:54 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 16:35:48 +0800
Subject: Re: [PATCH 1/5] scsi: libsas: delete dead code in
 scsi_transport_sas.c
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-2-yanaijie@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <miaoxie@huawei.com>, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1775eed7-7a1a-3e3a-c63c-6047ea5c6cb2@huawei.com>
Date:   Mon, 17 Sep 2018 09:35:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180912082946.34814-2-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2018 09:29, Jason Yan wrote:
> This code is dead and no clue implies that it will be back again.
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>  drivers/scsi/scsi_transport_sas.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 0cd16e80b019..0a165b2b3e81 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -612,7 +612,6 @@ sas_phy_protocol_attr(identify.target_port_protocols,
>  sas_phy_simple_attr(identify.sas_address, sas_address, "0x%016llx\n",
>  		unsigned long long);
>  sas_phy_simple_attr(identify.phy_identifier, phy_identifier, "%d\n", u8);
> -//sas_phy_simple_attr(port_identifier, port_identifier, "%d\n", int);
>  sas_phy_linkspeed_attr(negotiated_linkrate);
>  sas_phy_linkspeed_attr(minimum_linkrate_hw);
>  sas_phy_linkspeed_rw_attr(minimum_linkrate);
> @@ -1802,7 +1801,6 @@ sas_attach_transport(struct sas_function_template *ft)
>  	SETUP_PHY_ATTRIBUTE(device_type);
>  	SETUP_PHY_ATTRIBUTE(sas_address);
>  	SETUP_PHY_ATTRIBUTE(phy_identifier);
> -	//SETUP_PHY_ATTRIBUTE(port_identifier);
>  	SETUP_PHY_ATTRIBUTE(negotiated_linkrate);
>  	SETUP_PHY_ATTRIBUTE(minimum_linkrate_hw);
>  	SETUP_PHY_ATTRIBUTE_RW(minimum_linkrate);
>


