Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD29C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D43A2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GMhdWSZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D43A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeLGASl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:18:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36623 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGASl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:18:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so2710948qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPMotWnMr3ee+Vazw1rFoN2ZFb1eg2JxesDlb2apOoY=;
        b=GMhdWSZ90PLanK5qsOkWmfLY0rjJVAYCfMfXx6/UmTwdk2jlk6fNSW5F9HvCflBWMZ
         MXkyv38Qdfu86xo1U6Os8/lB0mD9Vz6qLI10vqN8OlgcfNu8K/Pss2wpssg6iAmzvnor
         vt/TqvqWjBEiGyefSjTRvSLEEbjLU68zBSOvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPMotWnMr3ee+Vazw1rFoN2ZFb1eg2JxesDlb2apOoY=;
        b=Gh8lXr1iOD7KpSjOZXUoTXZdv2B9veh5tIf8hP6NFW+VPmDrhllcxobH9Q/kpFnPO9
         yIBklcL5DmW96VBi7T7WJUVRCjq/SC1FjGb5CAUi63m47rZgrXEfhKNXv83G2fazEanI
         bG5kHtYZ5P+5hAs5NUphsBoiaVU6ZwJtgDTOujrwS9cfYiTeQB6c6OwI/YKBGL3cI6yC
         MQegVGIBfmm+doSoYI4WNnnaia5lIG+/Wn0ZKz75rl6ZfPjZu04Z0w1Rf+5S7IhFdrfl
         RbiHWM7djbQViQ+21ttxv1cY8mDi9ZzBstda/us4nJiVkS+FivD8wvRxDAfRohinSePN
         63PA==
X-Gm-Message-State: AA+aEWbpAsyfhAvPtKcCUDPeYX8lNt5GmHb5j2Y1hpmBEsim8biAujqs
        yukRp632ip7t4DW7JQRt4W2mE+MxFKIGrNGLu79Wdw==
X-Google-Smtp-Source: AFSGD/VNmGmrgZf/IulCk2On2xqqyrviVCx52XCGu+r89SIALnRU+1h3jf28MkLipXWth3t6SuIiKQaYXkMIC9vKHsY=
X-Received: by 2002:a0c:9a4a:: with SMTP id q10mr58000qvd.150.1544141919456;
 Thu, 06 Dec 2018 16:18:39 -0800 (PST)
MIME-Version: 1.0
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me> <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
In-Reply-To: <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Thu, 6 Dec 2018 16:18:28 -0800
Message-ID: <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     sagi@grimberg.me
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Roland Dreier <roland@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please take a look at this bug and code review?

We are seeing more instances of this bug and found that reconnect_work
could hang as well, as can be seen from below stacktrace.

 Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
 Call Trace:
 __schedule+0x2ab/0x880
 schedule+0x36/0x80
 schedule_timeout+0x161/0x300
 ? __next_timer_interrupt+0xe0/0xe0
 io_schedule_timeout+0x1e/0x50
 wait_for_completion_io_timeout+0x130/0x1a0
 ? wake_up_q+0x80/0x80
 blk_execute_rq+0x6e/0xa0
 __nvme_submit_sync_cmd+0x6e/0xe0
 nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
 ? wait_for_completion_interruptible_timeout+0x157/0x1b0
 nvme_rdma_start_queue+0x5e/0x90 [nvme_rdma]
 nvme_rdma_setup_ctrl+0x1b4/0x730 [nvme_rdma]
 nvme_rdma_reconnect_ctrl_work+0x27/0x70 [nvme_rdma]
 process_one_work+0x179/0x390
 worker_thread+0x4f/0x3e0
 kthread+0x105/0x140
 ? max_active_store+0x80/0x80
 ? kthread_bind+0x20/0x20

This bug is produced by setting MTU of RoCE interface to '568' for
test while running I/O traffics.

Thanks,

Jaesoo Lee.

On Thu, Nov 29, 2018 at 5:54 PM Jaesoo Lee <jalee@purestorage.com> wrote:
>
> Not the queue, but the RDMA connections.
>
> Let me describe the scenario.
>
> 1. connected nvme-rdma target with 500 namespaces
> : this will make the nvme_remove_namespaces() took a long time to
> complete and open the window vulnerable to this bug
> 2. host will take below code path for nvme_delete_ctrl_work and send
> normal shutdown in nvme_shutdown_ctrl()
> - nvme_stop_ctrl
>   - nvme_stop_keep_alive --> stopped keep alive
> - nvme_remove_namespaces --> took too long time, over 10~15s
> - nvme_rdma_shutdown_ctrl
>   - nvme_rdma_teardown_io_queues
>   - nvme_shutdown_ctrl
>     - nvmf_reg_write32
>       -__nvme_submit_sync_cmd --> nvme_delete_ctrl_work blocked here
>   - nvme_rdma_teardown_admin_queue
> - nvme_uninit_ctrl
> - nvme_put_ctrl
> 3. the rdma connection is disconnected by the nvme-rdma target
> : in our case, this is triggered by the target side timeout mechanism
> : I did not try, but I think this could happen if we lost the RoCE link, too.
> 4. the shutdown notification command timed out and the work stuck
> while leaving the controller in NVME_CTRL_DELETING state
>
> Thanks,
>
> Jaesoo Lee.
>
>
> On Thu, Nov 29, 2018 at 5:30 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > This does not hold at least for NVMe RDMA host driver. An example scenario
> > > is when the RDMA connection is gone while the controller is being deleted.
> > > In this case, the nvmf_reg_write32() for sending shutdown admin command by
> > > the delete_work could be hung forever if the command is not completed by
> > > the timeout handler.
> >
> > If the queue is gone, this means that the queue has already flushed and
> > any commands that were inflight has completed with a flush error
> > completion...
> >
> > Can you describe the scenario that caused this hang? When has the
> > queue became "gone" and when did the shutdown command execute?
