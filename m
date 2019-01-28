Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84662C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305572087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9fiNp/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfA1Ntp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:49:45 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40785 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1Ntp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:49:45 -0500
Received: by mail-ua1-f68.google.com with SMTP id n7so5594009uao.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/92ch+7JkiSh23SQiWvivbulCH6UIFhKFpjaYBF9UQQ=;
        b=Q9fiNp/xPVs0x1sidf/6aQmXDaD2ndzgu15i3aPbu/kmi9t2kFkMjmd5frd/HOsMAp
         DDkuEhBmAr2Hrf8suiBjOc6kSYVNn555Lnds5rkEGYIRoKNnNiSiksIP0BSWEyX+RdrX
         nWRBVhRqE4JsTUpScV3Cw6DBY5eVXeAd704vnzD6NOOo3DZTMZt7/mffsVBD1hGJFk4M
         /hJu1VHfWLL+OEWiV6J7s8Mjk9xQc4fAnqsvIJT1q2xOD8s9IydxPYT0wIwj1nMsLbIa
         ud3FhmkDSefrCJhPEf5DaKBjJR6HuGNgEcsf5L/HpS+QSmYAGSs1DWCUwb1VLx9C1sYI
         5HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/92ch+7JkiSh23SQiWvivbulCH6UIFhKFpjaYBF9UQQ=;
        b=OxteeP36XEnhCEOwadgcC4FS2YHzAUD7UatfwPCKGX2TUfrDo7pLTwkmMuNJi1FHqu
         V46IKBu691ke6ZrDgaap9HqEoCOrBkcEmnTnjtUYt7zt7toPD55pzN8d1PIdiuNFGm6U
         qhxyg8FUBNSA0wHi7jMqtMGlkJf8OXfikKVetW65R/XjwTqCtLPjVVYBezo1DlRmBBs2
         B2TWjlZZDJDk5gPSGsGnHd1BiQqWRuXrRSM28Jyl9NQWG7uf0EVuvUYNXclU0SOb2+kp
         N7w/CmZwBjjvqjxDR0scUBGpbfZYPHfP5KEr6llWyVCjGrnjhX+/C1YXdtNXGf+znC5g
         BkGg==
X-Gm-Message-State: AJcUukcXc0q6ObJRLVnkIxS9j2YputXXO5T1QlOCTPSFOW6MLd51Zoew
        P2vSmurl/O8Oj8YnkyyuO/AVDgPklEO7wpcmsEKUuw==
X-Google-Smtp-Source: ALg8bN4RNznW8MBwVQWTMyIDWEqPcIyM3AmDShavNX7EQzZBsDELdeqQHSt8PTT9mPGqI+YXtIRQYcOPd0dfWJ32H8g=
X-Received: by 2002:ab0:69ca:: with SMTP id u10mr8545224uaq.57.1548683383073;
 Mon, 28 Jan 2019 05:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-12-oded.gabbay@gmail.com>
 <20190127151103.GA21117@rapoport-lnx>
In-Reply-To: <20190127151103.GA21117@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 28 Jan 2019 15:51:15 +0200
Message-ID: <CAFCwf10nWg20+KyNFah_M1ea8bjVad_uAp=s5i15NMQsQWAyUQ@mail.gmail.com>
Subject: Re: [PATCH 11/15] habanalabs: add command submission module
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 5:11 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Jan 23, 2019 at 02:00:53AM +0200, Oded Gabbay wrote:
> > This patch adds the main flow for the user to submit work to the device.
> >
> > Each work is described by a command submission object (CS). The CS contains
> > 3 arrays of command buffers: One for execution, and two for context-switch
> > (store and restore).
> >
> > For each CB, the user specifies on which queue to put that CB. In case of
> > an internal queue, the entry doesn't contain a pointer to the CB but the
> > address in the on-chip memory that the CB resides at.
> >
> > The driver parses some of the CBs to enforce security restrictions.
> >
> > The user receives a sequence number that represents the CS object. The user
> > can then query the driver regarding the status of the CS, using that
> > sequence number.
> >
> > In case the CS doesn't finish before the timeout expires, the driver will
> > perform a soft-reset of the device.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/Makefile             |    3 +-
> >  drivers/misc/habanalabs/command_submission.c |  787 +++++++++++++
> >  drivers/misc/habanalabs/context.c            |   52 +-
> >  drivers/misc/habanalabs/device.c             |   16 +
> >  drivers/misc/habanalabs/goya/goya.c          | 1082 ++++++++++++++++++
> >  drivers/misc/habanalabs/habanalabs.h         |  274 +++++
> >  drivers/misc/habanalabs/habanalabs_drv.c     |   23 +
> >  drivers/misc/habanalabs/habanalabs_ioctl.c   |    4 +-
> >  drivers/misc/habanalabs/hw_queue.c           |  250 ++++
> >  drivers/misc/habanalabs/memory.c             |  200 ++++
> >  include/uapi/misc/habanalabs.h               |  158 ++-
> >  11 files changed, 2842 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/misc/habanalabs/command_submission.c
> >  create mode 100644 drivers/misc/habanalabs/memory.c
> >
> > diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
> > index b5607233d216..d2fd0e18b1eb 100644
> > --- a/drivers/misc/habanalabs/Makefile
> > +++ b/drivers/misc/habanalabs/Makefile
> > @@ -5,7 +5,8 @@
> >  obj-m        := habanalabs.o
> >
> >  habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
> > -             command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o
> > +             command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
> > +             command_submission.o
> >
> >  include $(src)/goya/Makefile
> >  habanalabs-y += $(HL_GOYA_FILES)
> > diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> > new file mode 100644
> > index 000000000000..0116c2262f17
> > --- /dev/null
> > +++ b/drivers/misc/habanalabs/command_submission.c
> > @@ -0,0 +1,787 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2016-2018 HabanaLabs, Ltd.
> > + * All Rights Reserved.
> > + */
> > +
> > +#include <uapi/misc/habanalabs.h>
> > +#include "habanalabs.h"
> > +
> > +#include <linux/sched/mm.h>
> > +#include <linux/sched/task.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/wait.h>
> > +#include <linux/mm.h>
> > +#include <linux/highmem.h>
>
> [ ... ]
>
> > +static void cs_do_release(struct kref *ref)
> > +{
> > +     struct hl_cs *cs = container_of(ref, struct hl_cs,
> > +                                             refcount);
> > +     struct hl_device *hdev = cs->ctx->hdev;
> > +     struct hl_cs_job *job, *tmp;
> > +
> > +     cs->completed = true;
> > +
> > +     /*
> > +      * Although if we reached here it means that all external jobs have
> > +      * finished, because each one of them took refcnt to CS, we still
> > +      * need to go over the internal jobs and free them. Otherwise, we
> > +      * will have leaked memory and what's worse, the CS object (and
> > +      * potentially the CTX object) could be released, while the JOB
> > +      * still holds a pointer to them (but no reference).
> > +      */
> > +     list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
> > +             free_job(hdev, job);
> > +
> > +     /* We also need to update CI for internal queues */
> > +     if (cs->submitted) {
> > +             hl_int_hw_queue_update_ci(cs);
> > +
> > +             spin_lock(&hdev->hw_queues_mirror_lock);
> > +             /* remove CS from hw_queues mirror list */
> > +             list_del_init(&cs->mirror_node);
> > +             spin_unlock(&hdev->hw_queues_mirror_lock);
> > +
> > +             /*
> > +              * Don't cancel TDR in case this CS was timedout because we
> > +              * might be running from the TDR context
> > +              */
> > +             if ((!cs->timedout) &&
> > +                     (hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT)) {
> > +                     struct hl_cs *next;
> > +
> > +                     if (cs->tdr_active)
> > +                             cancel_delayed_work_sync(&cs->work_tdr);
> > +
> > +                     spin_lock(&hdev->hw_queues_mirror_lock);
> > +                     /* queue TDR for next CS */
> > +                     next = list_first_entry_or_null(
> > +                                     &hdev->hw_queues_mirror_list,
> > +                                     struct hl_cs, mirror_node);
> > +                     if ((next) && (!next->tdr_active)) {
> > +                             next->tdr_active = true;
> > +                             schedule_delayed_work(&next->work_tdr,
> > +                                                     hdev->timeout_jiffies);
> > +                             spin_unlock(&hdev->hw_queues_mirror_lock);
> > +                     } else {
> > +                             spin_unlock(&hdev->hw_queues_mirror_lock);
> > +                     }
>
> 'else' can be dropped, just move spin_unlock() outside the 'if'
>
Fixed
> > +             }
> > +     }
> > +
> > +     hl_ctx_put(cs->ctx);
> > +
> > +     if (cs->timedout)
> > +             dma_fence_set_error(cs->fence, -ETIMEDOUT);
> > +     else if (cs->aborted)
> > +             dma_fence_set_error(cs->fence, -EIO);
> > +
> > +     dma_fence_signal(cs->fence);
> > +     dma_fence_put(cs->fence);
> > +
> > +     kfree(cs);
> > +}
>
> [ ... ]
>
> > +static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
> > +                     struct hl_cs **cs_new)
> > +{
> > +     struct hl_dma_fence *fence;
> > +     struct dma_fence *other = NULL;
> > +     struct hl_cs *cs;
> > +     int rc;
> > +
> > +     cs = kzalloc(sizeof(*cs), GFP_ATOMIC);
> > +     if (!cs)
> > +             return -ENOMEM;
>
> Does this ever run from a context that cannot use GFP_KERNEL?
> This applies to other allocations below.
>
It *always* runs from a context that cannot use GFP_KERNEL, because we
mustn't sleep during command submission due to low latency
requirements.

> > +
> > +     cs->ctx = ctx;
> > +     cs->submitted = false;
> > +     cs->completed = false;
> > +     INIT_LIST_HEAD(&cs->job_list);
> > +     INIT_DELAYED_WORK(&cs->work_tdr, cs_timedout);
> > +     kref_init(&cs->refcount);
> > +     spin_lock_init(&cs->job_lock);
> > +
> > +     fence = kmalloc(sizeof(*fence), GFP_ATOMIC);
>
> kzalloc?
Can't waste time on memset

>
> > +     if (!fence) {
> > +             rc = -ENOMEM;
> > +             goto free_cs;
> > +     }
> > +
> > +     fence->hdev = hdev;
> > +     spin_lock_init(&fence->lock);
> > +     cs->fence = &fence->base_fence;
> > +
> > +     spin_lock(&ctx->cs_lock);
> > +
> > +     fence->cs_seq = ctx->cs_sequence;
> > +     other = ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)];
> > +     if ((other) && (!dma_fence_is_signaled(other))) {
> > +             spin_unlock(&ctx->cs_lock);
> > +             rc = -EAGAIN;
> > +             goto free_fence;
> > +     }
> > +
> > +     dma_fence_init(&fence->base_fence, &hl_fence_ops, &fence->lock,
> > +                     ctx->asid, ctx->cs_sequence);
> > +
> > +     cs->sequence = fence->cs_seq;
> > +
> > +     ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)] =
> > +                                                     &fence->base_fence;
> > +     ctx->cs_sequence++;
> > +
> > +     dma_fence_get(&fence->base_fence);
> > +
> > +     dma_fence_put(other);
> > +
> > +     spin_unlock(&ctx->cs_lock);
> > +
> > +     *cs_new = cs;
> > +
> > +     return 0;
> > +
> > +free_fence:
> > +     kfree(fence);
> > +free_cs:
> > +     kfree(cs);
> > +     return rc;
> > +}
> > +
>
> [ ... ]
>
> > +
> > +static int goya_validate_cb(struct hl_device *hdev,
> > +                     struct hl_cs_parser *parser, bool is_mmu)
> > +{
> > +     u32 cb_parsed_length = 0;
> > +     int rc = 0;
> > +
> > +     parser->patched_cb_size = 0;
> > +
> > +     /* cb_user_size is more than 0 so loop will always be executed */
> > +     while ((cb_parsed_length < parser->user_cb_size) && (!rc)) {
> > +             enum packet_id pkt_id;
> > +             u16 pkt_size;
> > +             void *user_pkt;
> > +
> > +             user_pkt = (void *) (parser->user_cb->kernel_address +
> > +                                                     cb_parsed_length);
> > +
> > +             pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
> > +                             PACKET_HEADER_PACKET_ID_MASK) >>
> > +                                     PACKET_HEADER_PACKET_ID_SHIFT);
> > +
> > +             pkt_size = goya_packet_sizes[pkt_id];
> > +             cb_parsed_length += pkt_size;
> > +             if (cb_parsed_length > parser->user_cb_size) {
> > +                     dev_err(hdev->dev,
> > +                             "packet 0x%x is out of CB boundary\n", pkt_id);
> > +                     rc = -EINVAL;
> > +                     continue;
>
> For me !rc in the while statement was blind. Please consider break here and
>
>         if (!rc)
>                 break;
>
> after the switch
Fixed
>
> > +             }
> > +
> > +             switch (pkt_id) {
> > +             case PACKET_WREG_32:
> > +                     /*
> > +                      * Although it is validated after copy in patch_cb(),
> > +                      * need to validate here as well because patch_cb() is
> > +                      * not called in MMU path while this function is called
> > +                      */
> > +                     rc = goya_validate_wreg32(hdev, parser, user_pkt);
> > +                     break;
> > +
> > +             case PACKET_WREG_BULK:
> > +                     dev_err(hdev->dev,
> > +                             "User not allowed to use WREG_BULK\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_MSG_PROT:
> > +                     dev_err(hdev->dev,
> > +                             "User not allowed to use MSG_PROT\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_CP_DMA:
> > +                     dev_err(hdev->dev, "User not allowed to use CP_DMA\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_STOP:
> > +                     dev_err(hdev->dev, "User not allowed to use STOP\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_LIN_DMA:
> > +                     if (is_mmu)
> > +                             rc = goya_validate_dma_pkt_mmu(hdev, parser,
> > +                                             user_pkt);
> > +                     else
> > +                             rc = goya_validate_dma_pkt_no_mmu(hdev, parser,
> > +                                             user_pkt);
> > +                     break;
> > +
> > +             case PACKET_MSG_LONG:
> > +             case PACKET_MSG_SHORT:
> > +             case PACKET_FENCE:
> > +             case PACKET_NOP:
> > +                     parser->patched_cb_size += pkt_size;
> > +                     break;
> > +
> > +             default:
> > +                     dev_err(hdev->dev, "Invalid packet header 0x%x\n",
> > +                             pkt_id);
> > +                     rc = -EINVAL;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * The new CB should have space at the end for two MSG_PROT packets:
> > +      * 1. A packet that will act as a completion packet
> > +      * 2. A packet that will generate MSI-X interrupt
> > +      */
> > +     parser->patched_cb_size += sizeof(struct packet_msg_prot) * 2;
> > +
> > +     return rc;
> > +}
>
> [ ... ]
>
> > +static int goya_patch_cb(struct hl_device *hdev,
> > +                             struct hl_cs_parser *parser)
> > +{
> > +     u32 cb_parsed_length = 0;
> > +     u32 cb_patched_cur_length = 0;
> > +     int rc = 0;
> > +
> > +     /* cb_user_size is more than 0 so loop will always be executed */
> > +     while ((cb_parsed_length < parser->user_cb_size) && (!rc)) {
> > +             enum packet_id pkt_id;
> > +             u16 pkt_size;
> > +             u32 new_pkt_size = 0;
> > +             void *user_pkt, *kernel_pkt;
> > +
> > +             user_pkt = (void *) (parser->user_cb->kernel_address +
> > +                                                     cb_parsed_length);
> > +             kernel_pkt = (void *) (parser->patched_cb->kernel_address +
> > +                                                     cb_patched_cur_length);
> > +
> > +             pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
> > +                             PACKET_HEADER_PACKET_ID_MASK) >>
> > +                                     PACKET_HEADER_PACKET_ID_SHIFT);
> > +
> > +             pkt_size = goya_packet_sizes[pkt_id];
> > +             cb_parsed_length += pkt_size;
> > +             if (cb_parsed_length > parser->user_cb_size) {
> > +                     dev_err(hdev->dev,
> > +                             "packet 0x%x is out of CB boundary\n", pkt_id);
> > +                     rc = -EINVAL;
> > +                     continue;
>
> Ditto
Fixed
>
> > +             }
> > +
> > +             switch (pkt_id) {
> > +             case PACKET_LIN_DMA:
> > +                     rc = goya_patch_dma_packet(hdev, parser, user_pkt,
> > +                                             kernel_pkt, &new_pkt_size);
> > +                     cb_patched_cur_length += new_pkt_size;
> > +                     break;
> > +
> > +             case PACKET_WREG_32:
> > +                     memcpy(kernel_pkt, user_pkt, pkt_size);
> > +                     cb_patched_cur_length += pkt_size;
> > +                     rc = goya_validate_wreg32(hdev, parser, kernel_pkt);
> > +                     break;
> > +
> > +             case PACKET_WREG_BULK:
> > +                     dev_err(hdev->dev,
> > +                             "User not allowed to use WREG_BULK\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_MSG_PROT:
> > +                     dev_err(hdev->dev,
> > +                             "User not allowed to use MSG_PROT\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_CP_DMA:
> > +                     dev_err(hdev->dev, "User not allowed to use CP_DMA\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_STOP:
> > +                     dev_err(hdev->dev, "User not allowed to use STOP\n");
> > +                     rc = -EPERM;
> > +                     break;
> > +
> > +             case PACKET_MSG_LONG:
> > +             case PACKET_MSG_SHORT:
> > +             case PACKET_FENCE:
> > +             case PACKET_NOP:
> > +                     memcpy(kernel_pkt, user_pkt, pkt_size);
> > +                     cb_patched_cur_length += pkt_size;
> > +                     break;
> > +
> > +             default:
> > +                     dev_err(hdev->dev, "Invalid packet header 0x%x\n",
> > +                             pkt_id);
> > +                     rc = -EINVAL;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return rc;
> > +}
>
> [ ... ]
>
> >  static void goya_get_axi_name(struct hl_device *hdev, u32 agent_id,
> >               u16 event_type, char *axi_name, int len)
> >  {
> > @@ -4645,6 +5677,48 @@ static void goya_disable_clock_gating(struct hl_device *hdev)
> >
> >  }
> >
> > +static bool goya_is_device_idle(struct hl_device *hdev)
> > +{
> > +     u64 offset, dma_qm_reg, tpc_qm_reg, tpc_cmdq_reg, tpc_cfg_reg;
> > +     bool val = true;
> > +     int i;
> > +
> > +     offset = mmDMA_QM_1_GLBL_STS0 - mmDMA_QM_0_GLBL_STS0;
> > +
> > +     for (i = 0 ; i < DMA_MAX_NUM ; i++) {
> > +             dma_qm_reg = mmDMA_QM_0_GLBL_STS0 + i * offset;
> > +
> > +             val = val && ((RREG32(dma_qm_reg) & DMA_QM_IDLE_MASK) ==
> > +                             DMA_QM_IDLE_MASK);
> > +     }
> > +
> > +     offset = mmTPC1_QM_GLBL_STS0 - mmTPC0_QM_GLBL_STS0;
> > +
> > +     for (i = 0 ; i < TPC_MAX_NUM ; i++) {
> > +             tpc_qm_reg = mmTPC0_QM_GLBL_STS0 + i * offset;
> > +             tpc_cmdq_reg = mmTPC0_CMDQ_GLBL_STS0 + i * offset;
> > +             tpc_cfg_reg = mmTPC0_CFG_STATUS + i * offset;
> > +
> > +             val = val && ((RREG32(tpc_qm_reg) & TPC_QM_IDLE_MASK) ==
> > +                             TPC_QM_IDLE_MASK);
> > +             val = val && ((RREG32(tpc_cmdq_reg) & TPC_CMDQ_IDLE_MASK) ==
> > +                             TPC_CMDQ_IDLE_MASK);
> > +             val = val && ((RREG32(tpc_cfg_reg) & TPC_CFG_IDLE_MASK) ==
> > +                             TPC_CFG_IDLE_MASK);
> > +     }
> > +
> > +     val = val && ((RREG32(mmMME_QM_GLBL_STS0) & MME_QM_IDLE_MASK) ==
> > +                     MME_QM_IDLE_MASK);
> > +     val = val && ((RREG32(mmMME_CMDQ_GLBL_STS0) & MME_CMDQ_IDLE_MASK) ==
> > +                     MME_CMDQ_IDLE_MASK);
> > +     val = val && ((RREG32(mmMME_ARCH_STATUS) & MME_ARCH_IDLE_MASK) ==
> > +                     MME_ARCH_IDLE_MASK);
> > +     val = val && ((RREG32(mmMME_SHADOW_0_STATUS) & MME_SHADOW_IDLE_MASK) ==
> > +                     0);
>
> Huh, these are neat, but IMHO plain
>
>         if ((RREG(reg) & mask) != mask)
>                 return false;
>
> are more readable...
>
Fixed
> > +
> > +     return val;
> > +}
> > +
>
> [ ... ]
>
> --
> Sincerely yours,
> Mike.
>
