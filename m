Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D972C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7EC25A71
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7EC25A71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934048AbeFYNbe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:31:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52718 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933583AbeFYNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:31:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so9323694wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 06:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XiHh7+uN9N0z77VUkr3XU/2w6Pu764r0gb6TbwrW6N0=;
        b=rLPUzsBckmIud2J8nHGg1uQPul1vdNM12PuSHIHHG3Qaj8U9SmANrZEkA2MORHzxAW
         DOG8yZ+Hcwia4x5nEg7kI3L/NePn0ker0Jq8DPKLwLo3uyxkpav1L1LJuuXC4uKhGc5q
         dl8JPt+GYzCnwtMNRNI58YS5FtqCfDVb0yvOnSRVFSYQrOxn3vxwLQZlpV7Wxru4xbpv
         w/y0RWUQmDdLuIw5/zAUAeupTEdtCQN74X9evUbdMnlXxu2eTPPx+4yH9k0TTP/THKfx
         gmDwe3Z2d9DuR5gSPzeRjzJ4WewSMEnzmdfBmnQ42cqP7yicLUVe+jLXaseHP41xgOb3
         lEBg==
X-Gm-Message-State: APt69E3x2D1xGiYQilcpo7WVcC+dMN2UIPEnQR2hpg9eenqutTgcMzWY
        gLsidG7C3O+OZJa+xIQ4RmE=
X-Google-Smtp-Source: AAOMgpeS31/O+C/Kck0SerHwPg4KWy+mI1/idiARIvPQZ/TnxBShMf+ky+8kcVxixrQYsHyqYdZD6Q==
X-Received: by 2002:a1c:c189:: with SMTP id r131-v6mr1087216wmf.125.1529933491484;
        Mon, 25 Jun 2018 06:31:31 -0700 (PDT)
Received: from [192.168.64.169] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a184-v6sm10404821wmf.30.2018.06.25.06.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:31:30 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20180611184630.3435-1-jthumshirn@suse.de>
 <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
 <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
Date:   Mon, 25 Jun 2018 16:31:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 10:08 AM, Johannes Thumshirn wrote:
> On Tue, Jun 19, 2018 at 05:09:27PM +0300, Sagi Grimberg wrote:
>> We are going to need it for traffic based keep alive to update
>> that we saw a completion to extend the kato.
>>
>> But I suggest you simply keep a ctrl reference in struct nvme_request
>> instead so you don't need to pass it to nvme_complete_req (that's what
>> I did for traffic based keep alive).
> 
> Do you have a patch for this around? IIRC I started this (as Christoph
> also suggested it) but it turned out to be quite a big refactoring
> work.

How about the below? patch #1 is what you are looking for, patch #2 is
a slightly modified version that applies on #1. Let me know what you
think...

[1]:
--
     nvme: cache struct nvme_ctrl reference to struct nvme_request

     We will need to reference the controller in the setup and
     completion time for tracing and future traffic based keep alive
     support.

     Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e8cdb5409725..f53416619905 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -390,6 +390,7 @@ static inline void nvme_clear_nvme_request(struct 
request *req)
         if (!(req->rq_flags & RQF_DONTPREP)) {
                 nvme_req(req)->retries = 0;
                 nvme_req(req)->flags = 0;
+               nvme_req(req)->ctrl = NULL;
                 req->rq_flags |= RQF_DONTPREP;
         }
  }
@@ -622,8 +623,8 @@ static inline blk_status_t nvme_setup_rw(struct 
nvme_ns *ns,
         return 0;
  }

-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-               struct nvme_command *cmd)
+blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+               struct request *req, struct nvme_command *cmd)
  {
         blk_status_t ret = BLK_STS_OK;

@@ -652,6 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
struct request *req,
         }

         cmd->common.command_id = req->tag;
+       nvme_req(req)->ctrl = ctrl;
         if (ns)
                 trace_nvme_setup_nvm_cmd(req->q->id, cmd);
         else
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b528a2f5826c..99f683ed079e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2274,7 +2274,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
             !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
                 return nvmf_fail_nonready_command(rq);

-       ret = nvme_setup_cmd(ns, rq, sqe);
+       ret = nvme_setup_cmd(&ctrl->ctrl, ns, rq, sqe);
         if (ret)
                 return ret;

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 231807cbc849..e4a2145f3c9a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,7 @@ struct nvme_request {
         u8                      retries;
         u8                      flags;
         u16                     status;
+       struct nvme_ctrl        *ctrl;
  };

  /*
@@ -419,8 +420,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
  #define NVME_QID_ANY -1
  struct request *nvme_alloc_request(struct request_queue *q,
                 struct nvme_command *cmd, blk_mq_req_flags_t flags, int 
qid);
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-               struct nvme_command *cmd);
+blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+               struct request *req, struct nvme_command *cmd);
  int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command 
*cmd,
                 void *buf, unsigned bufflen);
  int __nvme_submit_sync_cmd(struct request_queue *q, struct 
nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804662e7..377e08c70666 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -877,7 +877,7 @@ static blk_status_t nvme_queue_rq(struct 
blk_mq_hw_ctx *hctx,
         if (unlikely(nvmeq->cq_vector < 0))
                 return BLK_STS_IOERR;

-       ret = nvme_setup_cmd(ns, req, &cmnd);
+       ret = nvme_setup_cmd(&dev->ctrl, ns, req, &cmnd);
         if (ret)
                 return ret;

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f621920af823..4de8017da484 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1691,7 +1691,7 @@ static blk_status_t nvme_rdma_queue_rq(struct 
blk_mq_hw_ctx *hctx,
         ib_dma_sync_single_for_cpu(dev, sqe->dma,
                         sizeof(struct nvme_command), DMA_TO_DEVICE);

-       ret = nvme_setup_cmd(ns, rq, c);
+       ret = nvme_setup_cmd(&queue->ctrl->ctrl, ns, rq, c);
         if (ret)
                 return ret;

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f04bd7e..888bd3fefc4d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -164,7 +164,7 @@ static blk_status_t nvme_loop_queue_rq(struct 
blk_mq_hw_ctx *hctx,
         if (!nvmf_check_ready(&queue->ctrl->ctrl, req, queue_ready))
                 return nvmf_fail_nonready_command(req);

-       ret = nvme_setup_cmd(ns, req, &iod->cmd);
+       ret = nvme_setup_cmd(&queue->ctrl->ctrl, ns, req, &iod->cmd);
         if (ret)
                 return ret;
--



[2] (slightly-modified):
--
    nvme: trace: add disk name to tracepoints

    Add disk name to tracepoints so we can better distinguish between
    individual disks in the trace output and admin commands which do
    are represented without a disk name.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f53416619905..14b714ebd31d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -654,10 +654,10 @@ blk_status_t nvme_setup_cmd(struct nvme_ctrl 
*ctrl, struct nvme_ns *ns,

         cmd->common.command_id = req->tag;
         nvme_req(req)->ctrl = ctrl;
-       if (ns)
-               trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+       if (likely(ns))
+               trace_nvme_setup_nvm_cmd(req, cmd, ns->disk->disk_name);
         else
-               trace_nvme_setup_admin_cmd(cmd);
+               trace_nvme_setup_admin_cmd(req, cmd);
         return ret;
  }
  EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0e1671..4e42c03c50bf 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -76,9 +76,10 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq 
*p, u8 opcode,
         nvme_trace_parse_nvm_cmd(p, opcode, cdw10)

  TRACE_EVENT(nvme_setup_admin_cmd,
-           TP_PROTO(struct nvme_command *cmd),
-           TP_ARGS(cmd),
+           TP_PROTO(struct request *req, struct nvme_command *cmd),
+           TP_ARGS(req, cmd),
             TP_STRUCT__entry(
+                   __field(int, ctrl_id)
                     __field(u8, opcode)
                     __field(u8, flags)
                     __field(u16, cid)
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
                     __array(u8, cdw10, 24)
             ),
             TP_fast_assign(
+                   __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
                     __entry->opcode = cmd->common.opcode;
                     __entry->flags = cmd->common.flags;
                     __entry->cid = cmd->common.command_id;
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
                     __array(u8, cdw10, 24)
             ),
             TP_fast_assign(
+                   __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
                     __entry->opcode = cmd->common.opcode;
                     __entry->flags = cmd->common.flags;
                     __entry->cid = cmd->common.command_id;
@@ -93,17 +95,20 @@ TRACE_EVENT(nvme_setup_admin_cmd,
                     memcpy(__entry->cdw10, cmd->common.cdw10,
                            sizeof(__entry->cdw10));
             ),
-           TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-                     __entry->cid, __entry->flags, __entry->metadata,
+           TP_printk("nvme%d: cmdid=%u, flags=0x%x, meta=0x%llx, 
cmd=(%s %s)",
+                     __entry->ctrl_id, __entry->cid, __entry->flags,
+                     __entry->metadata,
                       show_admin_opcode_name(__entry->opcode),
                       __parse_nvme_admin_cmd(__entry->opcode, 
__entry->cdw10))
  );


  TRACE_EVENT(nvme_setup_nvm_cmd,
-           TP_PROTO(int qid, struct nvme_command *cmd),
-           TP_ARGS(qid, cmd),
+           TP_PROTO(struct request *req, struct nvme_command *cmd, char 
*disk_name),
+           TP_ARGS(req, cmd, disk_name),
             TP_STRUCT__entry(
+                   __string(name, disk_name)
+                   __field(int, ctrl_id)
                     __field(int, qid)
                     __field(u8, opcode)
                     __field(u8, flags)
@@ -113,7 +118,9 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
                     __array(u8, cdw10, 24)
             ),
             TP_fast_assign(
-                   __entry->qid = qid;
+                   __assign_str(name, disk_name);
+                   __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
+                   __entry->qid = req->q->id;
                     __entry->opcode = cmd->common.opcode;
                     __entry->flags = cmd->common.flags;
                     __entry->cid = cmd->common.command_id;
@@ -122,9 +129,9 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
                     memcpy(__entry->cdw10, cmd->common.cdw10,
                            sizeof(__entry->cdw10));
             ),
-           TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, 
meta=0x%llx, cmd=(%s %s)",
-                     __entry->qid, __entry->nsid, __entry->cid,
-                     __entry->flags, __entry->metadata,
+           TP_printk("nvme%d: disk=%s, qid=%d, nsid=%u, cmdid=%u, 
flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+                     __entry->ctrl_id, __get_str(name), __entry->qid, 
__entry->nsid,
+                     __entry->cid, __entry->flags, __entry->metadata,
                       show_opcode_name(__entry->opcode),
                       __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
  );
@@ -133,6 +140,7 @@ TRACE_EVENT(nvme_complete_rq,
             TP_PROTO(struct request *req),
             TP_ARGS(req),
             TP_STRUCT__entry(
+                   __field(int, ctrl_id)
                     __field(int, qid)
                     __field(int, cid)
                     __field(u64, result)
@@ -141,6 +149,7 @@ TRACE_EVENT(nvme_complete_rq,
                     __field(u16, status)
             ),
             TP_fast_assign(
+                   __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
                     __entry->qid = req->q->id;
                     __entry->cid = req->tag;
                     __entry->result = 
le64_to_cpu(nvme_req(req)->result.u64);
@@ -148,9 +157,10 @@ TRACE_EVENT(nvme_complete_rq,
                     __entry->flags = nvme_req(req)->flags;
                     __entry->status = nvme_req(req)->status;
             ),
-           TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, 
flags=0x%x, status=%u",
-                     __entry->qid, __entry->cid, __entry->result,
-                     __entry->retries, __entry->flags, __entry->status)
+           TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, 
flags=0x%x, status=%u",
+                     __entry->ctrl_id, __entry->qid, __entry->cid,
+                     __entry->result, __entry->retries, __entry->flags,
+                     __entry->status)

  );
--
