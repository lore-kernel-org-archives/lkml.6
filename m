Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E283218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfAaNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:32:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732271AbfAaNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:32:28 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VDTT3l085624
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:32:25 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qc1pv92y6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:32:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 31 Jan 2019 13:32:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 13:32:20 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VDWJYc6685060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 13:32:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A038842047;
        Thu, 31 Jan 2019 13:32:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BA234204F;
        Thu, 31 Jan 2019 13:32:19 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 31 Jan 2019 13:32:18 +0000 (GMT)
Date:   Thu, 31 Jan 2019 15:32:17 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v2 07/15] habanalabs: add h/w queues module
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
 <20190130220617.4862-8-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130220617.4862-8-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013113-0008-0000-0000-000002B9577E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013113-0009-0000-0000-000022255A45
Message-Id: <20190131133216.GL28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=872 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:06:09AM +0200, Oded Gabbay wrote:
> This patch adds the H/W queues module and the code to initialize Goya's
> various compute and DMA engines and their queues.
> 
> Goya has 5 DMA channels, 8 TPC engines and a single MME engine. For each
> channel/engine, there is a H/W queue logic which is used to pass commands
> from the user to the H/W. That logic is called QMAN.
> 
> There are two types of QMANs: external and internal. The DMA QMANs are
> considered external while the TPC and MME QMANs are considered internal.
> For each external queue there is a completion queue, which is located on
> the Host memory.
> 
> The differences between external and internal QMANs are:
> 
> 1. The location of the queue's memory. External QMANs are located on the
>    Host memory while internal QMANs are located on the on-chip memory.
> 
> 2. The external QMAN write an entry to a completion queue and sends an
>    MSI-X interrupt upon completion of a command buffer that was given to
>    it. The internal QMAN doesn't do that.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
> Changes in v2:
>   - Add goya_async_events.h in this patch
>   - Add return of -ENOMEM in error path (was originally missing)
>   - Replace /** with /* in all functions
>   - Add comment about stopping QMANs
>   - Better error message for failure in sending CPU packet
>   - Remove Authors: from comment at start of file
>   - Remove bitfields in interface to F/W and use __le16/32/64
>   - Remove bitfields in interface to QMAN and use __le16/32/64
>   - Move enum goya_queue_id to uapi/misc/habanalabs.h as it is uapi
>  
>  drivers/misc/habanalabs/Makefile              |    2 +-
>  drivers/misc/habanalabs/device.c              |   75 +-
>  drivers/misc/habanalabs/goya/goya.c           | 1529 +++++++++++++++--
>  drivers/misc/habanalabs/goya/goyaP.h          |    7 +
>  drivers/misc/habanalabs/habanalabs.h          |  175 +-
>  drivers/misc/habanalabs/habanalabs_drv.c      |    6 +
>  drivers/misc/habanalabs/hw_queue.c            |  404 +++++
>  drivers/misc/habanalabs/include/armcp_if.h    |  292 ++++
>  .../include/goya/goya_async_events.h          |  186 ++
>  .../habanalabs/include/goya/goya_packets.h    |  129 ++
>  drivers/misc/habanalabs/include/qman_if.h     |   56 +
>  drivers/misc/habanalabs/irq.c                 |  150 ++
>  include/uapi/misc/habanalabs.h                |   29 +
>  13 files changed, 2919 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/misc/habanalabs/hw_queue.c
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
>  create mode 100644 drivers/misc/habanalabs/include/qman_if.h
>  create mode 100644 drivers/misc/habanalabs/irq.c

[ ... ]

> +/*
> + * goya_stop_external_queues - Stop external queues
> + *
> + * @hdev: pointer to hl_device structure
> + *
> + * Returns 0 on success
> + *
> + */
> +static int goya_stop_external_queues(struct hl_device *hdev)
> +{
> +	int rc = goya_stop_queue(hdev,
> +			mmDMA_QM_0_GLBL_CFG1,
> +			mmDMA_QM_0_CP_STS,
> +			mmDMA_QM_0_GLBL_STS0);
> +
> +	if (rc)
> +		dev_err(hdev->dev, "failed to stop DMA QMAN 0\n");
> +
> +	rc = goya_stop_queue(hdev,
> +			mmDMA_QM_1_GLBL_CFG1,
> +			mmDMA_QM_1_CP_STS,
> +			mmDMA_QM_1_GLBL_STS0);
> +
> +	if (rc)
> +		dev_err(hdev->dev, "failed to stop DMA QMAN 1\n");
> +
> +	rc = goya_stop_queue(hdev,
> +			mmDMA_QM_2_GLBL_CFG1,
> +			mmDMA_QM_2_CP_STS,
> +			mmDMA_QM_2_GLBL_STS0);
> +
> +	if (rc)
> +		dev_err(hdev->dev, "failed to stop DMA QMAN 2\n");
> +
> +	rc = goya_stop_queue(hdev,
> +			mmDMA_QM_3_GLBL_CFG1,
> +			mmDMA_QM_3_CP_STS,
> +			mmDMA_QM_3_GLBL_STS0);
> +
> +	if (rc)
> +		dev_err(hdev->dev, "failed to stop DMA QMAN 3\n");
> +
> +	rc = goya_stop_queue(hdev,
> +			mmDMA_QM_4_GLBL_CFG1,
> +			mmDMA_QM_4_CP_STS,
> +			mmDMA_QM_4_GLBL_STS0);
> +
> +	if (rc)
> +		dev_err(hdev->dev, "failed to stop DMA QMAN 4\n");
> +
> +	return rc;

Is is possible that one of the first goya_stop_queue() calls will fail, but
the last would succeed? Then rc will be 0...

BTW, the goya_stop_internal_queues() seem to handle this.

> +}
> +
> +static void goya_resume_external_queues(struct hl_device *hdev)
> +{
> +	WREG32(mmDMA_QM_0_GLBL_CFG1, 0);
> +	WREG32(mmDMA_QM_1_GLBL_CFG1, 0);
> +	WREG32(mmDMA_QM_2_GLBL_CFG1, 0);
> +	WREG32(mmDMA_QM_3_GLBL_CFG1, 0);
> +	WREG32(mmDMA_QM_4_GLBL_CFG1, 0);
> +}

[ ... ]

> +/*
> + * goya_stop_internal_queues - Stop internal queues
> + *
> + * @hdev: pointer to hl_device structure
> + *
> + * Returns 0 on success
> + *
> + */
> +static int goya_stop_internal_queues(struct hl_device *hdev)
> +{
> +	int rc, retval = 0;
> +
> +	/*
> +	 * Each queue (QMAN) is a separate H/W logic. That means that each
> +	 * QMAN can be stopped independently and failure to stop one does NOT
> +	 * mandate we should not try to stop other QMANs
> +	 */
> +
> +	rc = goya_stop_queue(hdev,
> +			mmMME_QM_GLBL_CFG1,
> +			mmMME_QM_CP_STS,
> +			mmMME_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop MME QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmMME_CMDQ_GLBL_CFG1,
> +			mmMME_CMDQ_CP_STS,
> +			mmMME_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop MME CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC0_QM_GLBL_CFG1,
> +			mmTPC0_QM_CP_STS,
> +			mmTPC0_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 0 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC0_CMDQ_GLBL_CFG1,
> +			mmTPC0_CMDQ_CP_STS,
> +			mmTPC0_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 0 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC1_QM_GLBL_CFG1,
> +			mmTPC1_QM_CP_STS,
> +			mmTPC1_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 1 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC1_CMDQ_GLBL_CFG1,
> +			mmTPC1_CMDQ_CP_STS,
> +			mmTPC1_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 1 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC2_QM_GLBL_CFG1,
> +			mmTPC2_QM_CP_STS,
> +			mmTPC2_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 2 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC2_CMDQ_GLBL_CFG1,
> +			mmTPC2_CMDQ_CP_STS,
> +			mmTPC2_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 2 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC3_QM_GLBL_CFG1,
> +			mmTPC3_QM_CP_STS,
> +			mmTPC3_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 3 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC3_CMDQ_GLBL_CFG1,
> +			mmTPC3_CMDQ_CP_STS,
> +			mmTPC3_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 3 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC4_QM_GLBL_CFG1,
> +			mmTPC4_QM_CP_STS,
> +			mmTPC4_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 4 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC4_CMDQ_GLBL_CFG1,
> +			mmTPC4_CMDQ_CP_STS,
> +			mmTPC4_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 4 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC5_QM_GLBL_CFG1,
> +			mmTPC5_QM_CP_STS,
> +			mmTPC5_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 5 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC5_CMDQ_GLBL_CFG1,
> +			mmTPC5_CMDQ_CP_STS,
> +			mmTPC5_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 5 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC6_QM_GLBL_CFG1,
> +			mmTPC6_QM_CP_STS,
> +			mmTPC6_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 6 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC6_CMDQ_GLBL_CFG1,
> +			mmTPC6_CMDQ_CP_STS,
> +			mmTPC6_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 6 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC7_QM_GLBL_CFG1,
> +			mmTPC7_QM_CP_STS,
> +			mmTPC7_QM_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 7 QMAN\n");
> +		retval = -EIO;
> +	}
> +
> +	rc = goya_stop_queue(hdev,
> +			mmTPC7_CMDQ_GLBL_CFG1,
> +			mmTPC7_CMDQ_CP_STS,
> +			mmTPC7_CMDQ_GLBL_STS0);
> +
> +	if (rc) {
> +		dev_err(hdev->dev, "failed to stop TPC 7 CMDQ\n");
> +		retval = -EIO;
> +	}
> +
> +	return rc;
> +}
> +

[ ... ]

> @@ -1494,6 +2370,104 @@ int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
>  	return rc;
>  }
>  
> +void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
> +{
> +	u32 db_reg_offset, db_value;
> +	bool invalid_queue = false;
> +
> +	switch (hw_queue_id) {
> +	case GOYA_QUEUE_ID_DMA_0:
> +		db_reg_offset = mmDMA_QM_0_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_DMA_1:
> +		db_reg_offset = mmDMA_QM_1_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_DMA_2:
> +		db_reg_offset = mmDMA_QM_2_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_DMA_3:
> +		db_reg_offset = mmDMA_QM_3_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_DMA_4:
> +		db_reg_offset = mmDMA_QM_4_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_CPU_PQ:
> +		if (hdev->cpu_queues_enable)
> +			db_reg_offset = mmCPU_IF_PF_PQ_PI;
> +		else
> +			invalid_queue = true;
> +		break;
> +
> +	case GOYA_QUEUE_ID_MME:
> +		db_reg_offset = mmMME_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC0:
> +		db_reg_offset = mmTPC0_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC1:
> +		db_reg_offset = mmTPC1_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC2:
> +		db_reg_offset = mmTPC2_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC3:
> +		db_reg_offset = mmTPC3_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC4:
> +		db_reg_offset = mmTPC4_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC5:
> +		db_reg_offset = mmTPC5_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC6:
> +		db_reg_offset = mmTPC6_QM_PQ_PI;
> +		break;
> +
> +	case GOYA_QUEUE_ID_TPC7:
> +		db_reg_offset = mmTPC7_QM_PQ_PI;
> +		break;
> +
> +	default:
> +		invalid_queue = true;
> +	}
> +
> +	if (invalid_queue) {
> +		/* Should never get here */
> +		dev_err(hdev->dev, "h/w queue %d is invalid. Can't set pi\n",
> +			hw_queue_id);
> +		return;
> +	}
> +
> +	db_value = pi;
> +
> +	if (hdev->ifh)
> +		return;

This could move to the beginning of the function, /me thinks.

> +
> +	/* ring the doorbell */
> +	WREG32(db_reg_offset, db_value);
> +
> +	if (hw_queue_id == GOYA_QUEUE_ID_CPU_PQ)
> +		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
> +				GOYA_ASYNC_EVENT_ID_PI_UPDATE);
> +}
> +
> +void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
> +{
> +	/* Not needed in Goya */
> +}
> +
>  void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
>  					dma_addr_t *dma_handle, gfp_t flags)
>  {
> @@ -1506,6 +2480,316 @@ void goya_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
>  	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
>  }
>  

-- 
Sincerely yours,
Mike.

