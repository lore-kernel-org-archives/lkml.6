Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE3BC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F7F214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfA0PLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 10:11:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbfA0PLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 10:11:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0RErZRv064336
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 10:11:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q95s85yqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 10:11:15 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 27 Jan 2019 15:11:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Jan 2019 15:11:10 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0RFB9pl56033516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 15:11:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D87042041;
        Sun, 27 Jan 2019 15:11:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3D914203F;
        Sun, 27 Jan 2019 15:11:08 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.102])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Jan 2019 15:11:08 +0000 (GMT)
Date:   Sun, 27 Jan 2019 17:11:07 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai
Subject: Re: [PATCH 11/15] habanalabs: add command submission module
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-12-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123000057.31477-12-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012715-4275-0000-0000-0000030586D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012715-4276-0000-0000-00003813881A
Message-Id: <20190127151103.GA21117@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901270123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:00:53AM +0200, Oded Gabbay wrote:
> This patch adds the main flow for the user to submit work to the device.
> 
> Each work is described by a command submission object (CS). The CS contains
> 3 arrays of command buffers: One for execution, and two for context-switch
> (store and restore).
> 
> For each CB, the user specifies on which queue to put that CB. In case of
> an internal queue, the entry doesn't contain a pointer to the CB but the
> address in the on-chip memory that the CB resides at.
> 
> The driver parses some of the CBs to enforce security restrictions.
> 
> The user receives a sequence number that represents the CS object. The user
> can then query the driver regarding the status of the CS, using that
> sequence number.
> 
> In case the CS doesn't finish before the timeout expires, the driver will
> perform a soft-reset of the device.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/Makefile             |    3 +-
>  drivers/misc/habanalabs/command_submission.c |  787 +++++++++++++
>  drivers/misc/habanalabs/context.c            |   52 +-
>  drivers/misc/habanalabs/device.c             |   16 +
>  drivers/misc/habanalabs/goya/goya.c          | 1082 ++++++++++++++++++
>  drivers/misc/habanalabs/habanalabs.h         |  274 +++++
>  drivers/misc/habanalabs/habanalabs_drv.c     |   23 +
>  drivers/misc/habanalabs/habanalabs_ioctl.c   |    4 +-
>  drivers/misc/habanalabs/hw_queue.c           |  250 ++++
>  drivers/misc/habanalabs/memory.c             |  200 ++++
>  include/uapi/misc/habanalabs.h               |  158 ++-
>  11 files changed, 2842 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/misc/habanalabs/command_submission.c
>  create mode 100644 drivers/misc/habanalabs/memory.c
> 
> diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
> index b5607233d216..d2fd0e18b1eb 100644
> --- a/drivers/misc/habanalabs/Makefile
> +++ b/drivers/misc/habanalabs/Makefile
> @@ -5,7 +5,8 @@
>  obj-m	:= habanalabs.o
>  
>  habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
> -		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o
> +		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
> +		command_submission.o
>  
>  include $(src)/goya/Makefile
>  habanalabs-y += $(HL_GOYA_FILES)
> diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> new file mode 100644
> index 000000000000..0116c2262f17
> --- /dev/null
> +++ b/drivers/misc/habanalabs/command_submission.c
> @@ -0,0 +1,787 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2016-2018 HabanaLabs, Ltd.
> + * All Rights Reserved.
> + */
> +
> +#include <uapi/misc/habanalabs.h>
> +#include "habanalabs.h"
> +
> +#include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
> +#include <linux/sched/signal.h>
> +#include <linux/wait.h>
> +#include <linux/mm.h>
> +#include <linux/highmem.h>

[ ... ]

> +static void cs_do_release(struct kref *ref)
> +{
> +	struct hl_cs *cs = container_of(ref, struct hl_cs,
> +						refcount);
> +	struct hl_device *hdev = cs->ctx->hdev;
> +	struct hl_cs_job *job, *tmp;
> +
> +	cs->completed = true;
> +
> +	/*
> +	 * Although if we reached here it means that all external jobs have
> +	 * finished, because each one of them took refcnt to CS, we still
> +	 * need to go over the internal jobs and free them. Otherwise, we
> +	 * will have leaked memory and what's worse, the CS object (and
> +	 * potentially the CTX object) could be released, while the JOB
> +	 * still holds a pointer to them (but no reference).
> +	 */
> +	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
> +		free_job(hdev, job);
> +
> +	/* We also need to update CI for internal queues */
> +	if (cs->submitted) {
> +		hl_int_hw_queue_update_ci(cs);
> +
> +		spin_lock(&hdev->hw_queues_mirror_lock);
> +		/* remove CS from hw_queues mirror list */
> +		list_del_init(&cs->mirror_node);
> +		spin_unlock(&hdev->hw_queues_mirror_lock);
> +
> +		/*
> +		 * Don't cancel TDR in case this CS was timedout because we
> +		 * might be running from the TDR context
> +		 */
> +		if ((!cs->timedout) &&
> +			(hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT)) {
> +			struct hl_cs *next;
> +
> +			if (cs->tdr_active)
> +				cancel_delayed_work_sync(&cs->work_tdr);
> +
> +			spin_lock(&hdev->hw_queues_mirror_lock);
> +			/* queue TDR for next CS */
> +			next = list_first_entry_or_null(
> +					&hdev->hw_queues_mirror_list,
> +					struct hl_cs, mirror_node);
> +			if ((next) && (!next->tdr_active)) {
> +				next->tdr_active = true;
> +				schedule_delayed_work(&next->work_tdr,
> +							hdev->timeout_jiffies);
> +				spin_unlock(&hdev->hw_queues_mirror_lock);
> +			} else {
> +				spin_unlock(&hdev->hw_queues_mirror_lock);
> +			}

'else' can be dropped, just move spin_unlock() outside the 'if'

> +		}
> +	}
> +
> +	hl_ctx_put(cs->ctx);
> +
> +	if (cs->timedout)
> +		dma_fence_set_error(cs->fence, -ETIMEDOUT);
> +	else if (cs->aborted)
> +		dma_fence_set_error(cs->fence, -EIO);
> +
> +	dma_fence_signal(cs->fence);
> +	dma_fence_put(cs->fence);
> +
> +	kfree(cs);
> +}

[ ... ]

> +static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
> +			struct hl_cs **cs_new)
> +{
> +	struct hl_dma_fence *fence;
> +	struct dma_fence *other = NULL;
> +	struct hl_cs *cs;
> +	int rc;
> +
> +	cs = kzalloc(sizeof(*cs), GFP_ATOMIC);
> +	if (!cs)
> +		return -ENOMEM;

Does this ever run from a context that cannot use GFP_KERNEL?
This applies to other allocations below.

> +
> +	cs->ctx = ctx;
> +	cs->submitted = false;
> +	cs->completed = false;
> +	INIT_LIST_HEAD(&cs->job_list);
> +	INIT_DELAYED_WORK(&cs->work_tdr, cs_timedout);
> +	kref_init(&cs->refcount);
> +	spin_lock_init(&cs->job_lock);
> +
> +	fence = kmalloc(sizeof(*fence), GFP_ATOMIC);

kzalloc?

> +	if (!fence) {
> +		rc = -ENOMEM;
> +		goto free_cs;
> +	}
> +
> +	fence->hdev = hdev;
> +	spin_lock_init(&fence->lock);
> +	cs->fence = &fence->base_fence;
> +
> +	spin_lock(&ctx->cs_lock);
> +
> +	fence->cs_seq = ctx->cs_sequence;
> +	other = ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)];
> +	if ((other) && (!dma_fence_is_signaled(other))) {
> +		spin_unlock(&ctx->cs_lock);
> +		rc = -EAGAIN;
> +		goto free_fence;
> +	}
> +
> +	dma_fence_init(&fence->base_fence, &hl_fence_ops, &fence->lock,
> +			ctx->asid, ctx->cs_sequence);
> +
> +	cs->sequence = fence->cs_seq;
> +
> +	ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)] =
> +							&fence->base_fence;
> +	ctx->cs_sequence++;
> +
> +	dma_fence_get(&fence->base_fence);
> +
> +	dma_fence_put(other);
> +
> +	spin_unlock(&ctx->cs_lock);
> +
> +	*cs_new = cs;
> +
> +	return 0;
> +
> +free_fence:
> +	kfree(fence);
> +free_cs:
> +	kfree(cs);
> +	return rc;
> +}
> +

[ ... ]

> +
> +static int goya_validate_cb(struct hl_device *hdev,
> +			struct hl_cs_parser *parser, bool is_mmu)
> +{
> +	u32 cb_parsed_length = 0;
> +	int rc = 0;
> +
> +	parser->patched_cb_size = 0;
> +
> +	/* cb_user_size is more than 0 so loop will always be executed */
> +	while ((cb_parsed_length < parser->user_cb_size) && (!rc)) {
> +		enum packet_id pkt_id;
> +		u16 pkt_size;
> +		void *user_pkt;
> +
> +		user_pkt = (void *) (parser->user_cb->kernel_address +
> +							cb_parsed_length);
> +
> +		pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
> +				PACKET_HEADER_PACKET_ID_MASK) >>
> +					PACKET_HEADER_PACKET_ID_SHIFT);
> +
> +		pkt_size = goya_packet_sizes[pkt_id];
> +		cb_parsed_length += pkt_size;
> +		if (cb_parsed_length > parser->user_cb_size) {
> +			dev_err(hdev->dev,
> +				"packet 0x%x is out of CB boundary\n", pkt_id);
> +			rc = -EINVAL;
> +			continue;

For me !rc in the while statement was blind. Please consider break here and 

	if (!rc)
		break;

after the switch

> +		}
> +
> +		switch (pkt_id) {
> +		case PACKET_WREG_32:
> +			/*
> +			 * Although it is validated after copy in patch_cb(),
> +			 * need to validate here as well because patch_cb() is
> +			 * not called in MMU path while this function is called
> +			 */
> +			rc = goya_validate_wreg32(hdev, parser, user_pkt);
> +			break;
> +
> +		case PACKET_WREG_BULK:
> +			dev_err(hdev->dev,
> +				"User not allowed to use WREG_BULK\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_MSG_PROT:
> +			dev_err(hdev->dev,
> +				"User not allowed to use MSG_PROT\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_CP_DMA:
> +			dev_err(hdev->dev, "User not allowed to use CP_DMA\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_STOP:
> +			dev_err(hdev->dev, "User not allowed to use STOP\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_LIN_DMA:
> +			if (is_mmu)
> +				rc = goya_validate_dma_pkt_mmu(hdev, parser,
> +						user_pkt);
> +			else
> +				rc = goya_validate_dma_pkt_no_mmu(hdev, parser,
> +						user_pkt);
> +			break;
> +
> +		case PACKET_MSG_LONG:
> +		case PACKET_MSG_SHORT:
> +		case PACKET_FENCE:
> +		case PACKET_NOP:
> +			parser->patched_cb_size += pkt_size;
> +			break;
> +
> +		default:
> +			dev_err(hdev->dev, "Invalid packet header 0x%x\n",
> +				pkt_id);
> +			rc = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * The new CB should have space at the end for two MSG_PROT packets:
> +	 * 1. A packet that will act as a completion packet
> +	 * 2. A packet that will generate MSI-X interrupt
> +	 */
> +	parser->patched_cb_size += sizeof(struct packet_msg_prot) * 2;
> +
> +	return rc;
> +}

[ ... ]

> +static int goya_patch_cb(struct hl_device *hdev,
> +				struct hl_cs_parser *parser)
> +{
> +	u32 cb_parsed_length = 0;
> +	u32 cb_patched_cur_length = 0;
> +	int rc = 0;
> +
> +	/* cb_user_size is more than 0 so loop will always be executed */
> +	while ((cb_parsed_length < parser->user_cb_size) && (!rc)) {
> +		enum packet_id pkt_id;
> +		u16 pkt_size;
> +		u32 new_pkt_size = 0;
> +		void *user_pkt, *kernel_pkt;
> +
> +		user_pkt = (void *) (parser->user_cb->kernel_address +
> +							cb_parsed_length);
> +		kernel_pkt = (void *) (parser->patched_cb->kernel_address +
> +							cb_patched_cur_length);
> +
> +		pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
> +				PACKET_HEADER_PACKET_ID_MASK) >>
> +					PACKET_HEADER_PACKET_ID_SHIFT);
> +
> +		pkt_size = goya_packet_sizes[pkt_id];
> +		cb_parsed_length += pkt_size;
> +		if (cb_parsed_length > parser->user_cb_size) {
> +			dev_err(hdev->dev,
> +				"packet 0x%x is out of CB boundary\n", pkt_id);
> +			rc = -EINVAL;
> +			continue;

Ditto

> +		}
> +
> +		switch (pkt_id) {
> +		case PACKET_LIN_DMA:
> +			rc = goya_patch_dma_packet(hdev, parser, user_pkt,
> +						kernel_pkt, &new_pkt_size);
> +			cb_patched_cur_length += new_pkt_size;
> +			break;
> +
> +		case PACKET_WREG_32:
> +			memcpy(kernel_pkt, user_pkt, pkt_size);
> +			cb_patched_cur_length += pkt_size;
> +			rc = goya_validate_wreg32(hdev, parser, kernel_pkt);
> +			break;
> +
> +		case PACKET_WREG_BULK:
> +			dev_err(hdev->dev,
> +				"User not allowed to use WREG_BULK\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_MSG_PROT:
> +			dev_err(hdev->dev,
> +				"User not allowed to use MSG_PROT\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_CP_DMA:
> +			dev_err(hdev->dev, "User not allowed to use CP_DMA\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_STOP:
> +			dev_err(hdev->dev, "User not allowed to use STOP\n");
> +			rc = -EPERM;
> +			break;
> +
> +		case PACKET_MSG_LONG:
> +		case PACKET_MSG_SHORT:
> +		case PACKET_FENCE:
> +		case PACKET_NOP:
> +			memcpy(kernel_pkt, user_pkt, pkt_size);
> +			cb_patched_cur_length += pkt_size;
> +			break;
> +
> +		default:
> +			dev_err(hdev->dev, "Invalid packet header 0x%x\n",
> +				pkt_id);
> +			rc = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	return rc;
> +}

[ ... ]

>  static void goya_get_axi_name(struct hl_device *hdev, u32 agent_id,
>  		u16 event_type, char *axi_name, int len)
>  {
> @@ -4645,6 +5677,48 @@ static void goya_disable_clock_gating(struct hl_device *hdev)
>  
>  }
>  
> +static bool goya_is_device_idle(struct hl_device *hdev)
> +{
> +	u64 offset, dma_qm_reg, tpc_qm_reg, tpc_cmdq_reg, tpc_cfg_reg;
> +	bool val = true;
> +	int i;
> +
> +	offset = mmDMA_QM_1_GLBL_STS0 - mmDMA_QM_0_GLBL_STS0;
> +
> +	for (i = 0 ; i < DMA_MAX_NUM ; i++) {
> +		dma_qm_reg = mmDMA_QM_0_GLBL_STS0 + i * offset;
> +
> +		val = val && ((RREG32(dma_qm_reg) & DMA_QM_IDLE_MASK) ==
> +				DMA_QM_IDLE_MASK);
> +	}
> +
> +	offset = mmTPC1_QM_GLBL_STS0 - mmTPC0_QM_GLBL_STS0;
> +
> +	for (i = 0 ; i < TPC_MAX_NUM ; i++) {
> +		tpc_qm_reg = mmTPC0_QM_GLBL_STS0 + i * offset;
> +		tpc_cmdq_reg = mmTPC0_CMDQ_GLBL_STS0 + i * offset;
> +		tpc_cfg_reg = mmTPC0_CFG_STATUS + i * offset;
> +
> +		val = val && ((RREG32(tpc_qm_reg) & TPC_QM_IDLE_MASK) ==
> +				TPC_QM_IDLE_MASK);
> +		val = val && ((RREG32(tpc_cmdq_reg) & TPC_CMDQ_IDLE_MASK) ==
> +				TPC_CMDQ_IDLE_MASK);
> +		val = val && ((RREG32(tpc_cfg_reg) & TPC_CFG_IDLE_MASK) ==
> +				TPC_CFG_IDLE_MASK);
> +	}
> +
> +	val = val && ((RREG32(mmMME_QM_GLBL_STS0) & MME_QM_IDLE_MASK) ==
> +			MME_QM_IDLE_MASK);
> +	val = val && ((RREG32(mmMME_CMDQ_GLBL_STS0) & MME_CMDQ_IDLE_MASK) ==
> +			MME_CMDQ_IDLE_MASK);
> +	val = val && ((RREG32(mmMME_ARCH_STATUS) & MME_ARCH_IDLE_MASK) ==
> +			MME_ARCH_IDLE_MASK);
> +	val = val && ((RREG32(mmMME_SHADOW_0_STATUS) & MME_SHADOW_IDLE_MASK) ==
> +			0);

Huh, these are neat, but IMHO plain

	if ((RREG(reg) & mask) != mask)
		return false;

are more readable...

> +
> +	return val;
> +}
> +

[ ... ]

-- 
Sincerely yours,
Mike.

