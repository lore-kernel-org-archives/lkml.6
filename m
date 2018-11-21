Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC219C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A7920989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A7920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeKUVga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:36:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728367AbeKUVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:36:30 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALAwfdD119486
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:02:33 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nw59v2vbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:02:32 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 21 Nov 2018 11:02:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 11:02:27 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wALB2QK0655702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 11:02:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E3BFA4053;
        Wed, 21 Nov 2018 11:02:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04AE4A405D;
        Wed, 21 Nov 2018 11:02:26 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.99.75])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Nov 2018 11:02:25 +0000 (GMT)
Subject: Re: [PATCH 3/4] scsi: hisi_sas: Make sg_tablesize consistent value
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>
References: <1542725944-244183-1-git-send-email-john.garry@huawei.com>
 <1542725944-244183-4-git-send-email-john.garry@huawei.com>
From:   Steffen Maier <maier@linux.ibm.com>
Date:   Wed, 21 Nov 2018 12:02:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542725944-244183-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112111-0012-0000-0000-000002CDE590
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112111-0013-0000-0000-00002103125F
Message-Id: <146f7c38-0cd7-a664-31d6-30a27b7a182b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 03:59 PM, John Garry wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Sht->sg_tablesize is set in the driver, and it will be assigned to
> shost->sg_tablesize in SCSI mid-layer. So it is not necessary to
> assign shost->sg_table one more time in the driver.
> 
> In addition to the change, change each scsi_host_template.sg_tablesize
> to HISI_SAS_SGE_PAGE_CNT instead of SG_ALL.

Might be completely irrelevant, so just as information: I once had 
problems due to changing (reducing) SHT.sg_tablesize because block queue 
limits of BSG devices of Scsi_Host and fc_host (not sure if you have an 
equivalent bsg device for your transport(s)) inherit from SHT, but don't 
update (automatically) on later updates of shost->sg_tablesize, which in 
turn affect scsi_devices allocated after the shost update.
Cf. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/s390/scsi?id=5fea4291deacd80188b996d2f555fc6a1940e5d4
("[SCSI] zfcp: block queue limits with data router")
if you need more details.

> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 2 +-
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 2 +-
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +--
>   4 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index d13a662..cbda48e 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -2410,7 +2410,6 @@ int hisi_sas_probe(struct platform_device *pdev,
>   	shost->max_lun = ~0;
>   	shost->max_channel = 1;
>   	shost->max_cmd_len = 16;
> -	shost->sg_tablesize = min_t(u16, SG_ALL, HISI_SAS_SGE_PAGE_CNT);
>   	if (hisi_hba->hw->slot_index_alloc) {
>   		shost->can_queue = hisi_hba->hw->max_command_entries;
>   		shost->cmd_per_lun = hisi_hba->hw->max_command_entries;
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> index d24342b..2d035cc 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> @@ -1815,7 +1815,7 @@ static int hisi_sas_v1_init(struct hisi_hba *hisi_hba)
>   	.change_queue_depth	= sas_change_queue_depth,
>   	.bios_param		= sas_bios_param,
>   	.this_id		= -1,
> -	.sg_tablesize		= SG_ALL,
> +	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
>   	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
>   	.use_clustering		= ENABLE_CLUSTERING,
>   	.eh_device_reset_handler = sas_eh_device_reset_handler,
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index e78a97e..79e58a7 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -3570,7 +3570,7 @@ struct device_attribute *host_attrs_v2_hw[] = {
>   	.change_queue_depth	= sas_change_queue_depth,
>   	.bios_param		= sas_bios_param,
>   	.this_id		= -1,
> -	.sg_tablesize		= SG_ALL,
> +	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
>   	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
>   	.use_clustering		= ENABLE_CLUSTERING,
>   	.eh_device_reset_handler = sas_eh_device_reset_handler,
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 7e2b020..8a08078 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -2224,7 +2224,7 @@ struct device_attribute *host_attrs_v3_hw[] = {
>   	.change_queue_depth	= sas_change_queue_depth,
>   	.bios_param		= sas_bios_param,
>   	.this_id		= -1,
> -	.sg_tablesize		= SG_ALL,
> +	.sg_tablesize		= HISI_SAS_SGE_PAGE_CNT,
>   	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
>   	.use_clustering		= ENABLE_CLUSTERING,
>   	.eh_device_reset_handler = sas_eh_device_reset_handler,
> @@ -2366,7 +2366,6 @@ struct device_attribute *host_attrs_v3_hw[] = {
>   	shost->max_lun = ~0;
>   	shost->max_channel = 1;
>   	shost->max_cmd_len = 16;
> -	shost->sg_tablesize = min_t(u16, SG_ALL, HISI_SAS_SGE_PAGE_CNT);
>   	shost->can_queue = hisi_hba->hw->max_command_entries -
>   		HISI_SAS_RESERVED_IPTT_CNT;
>   	shost->cmd_per_lun = hisi_hba->hw->max_command_entries -
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

