Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC260ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833AC2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833AC2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeIQTVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:21:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:52610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbeIQTVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:21:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA66BAFEE;
        Mon, 17 Sep 2018 13:53:36 +0000 (UTC)
Subject: Re: [PATCH 1/5] scsi: libsas: delete dead code in
 scsi_transport_sas.c
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, zhaohongjiang@huawei.com,
        dan.j.williams@intel.com, jthumshirn@suse.de, hch@lst.de,
        huangdaode@hisilicon.com, chenxiang66@hisilicon.com,
        miaoxie@huawei.com, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-2-yanaijie@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <4218aff0-92d5-dee2-2d60-8f24b71c4ad9@suse.com>
Date:   Mon, 17 Sep 2018 15:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912082946.34814-2-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 10:29 AM, Jason Yan wrote:
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
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
