Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDBC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8C2218FC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFx9U9zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfBCNsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:48:16 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36277 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfBCNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:48:16 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so3671522uap.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 05:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3WnKjmxGBCzimGi0KrW0RgZzs/xIADsyyUWKFoChSg=;
        b=XFx9U9zBZUeZN/u9vSZZ1mSY6ulBNgscisUwdUXoB4jgGw0kkm3cv0L28jUkmgOD4E
         Fkhdq6fY0+sjOT2ERSzp7beqPIaerymdsvcUsZaPD/btj8YE0AtKnJ6S0W6iBBjCuVG2
         tJ1S/QbXnnU6/esHIOlMMYkEyBkSx37cVprIM06kpOA4TBeRzLG3R98rBftPE5cxxpzV
         W8XzrlKWVPz3q8RskvEkeA6nvcTM4rpAQaWNacqhXmzyLejQ4Z5nw+HzPGlyMv7FZH5e
         oCGuWlZb/XfP6eNNXPm1Ug2e9wlmAQXKjVCqwSL4PGRF2sZ29HqlQ/+QwruMxZrWoLY3
         r4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3WnKjmxGBCzimGi0KrW0RgZzs/xIADsyyUWKFoChSg=;
        b=d+nXFeTDF+lBMIKzXV7IO/sA6zi5lkhRxXOS3AP0PEjwvP6elqvApMOZ+G/HfW/efX
         2dwVAVI9kAXzCfAJxNAVwcr7swiSpmXMXx8hEmNuMzGUjomSlEnmktbObTMoDMohmamD
         /3PgtlnrNCe6/cpKy7zL+xGpniayIPmeq21cMzoEMTnxB206zjFvfihlQJv4bk9idU9y
         1WAvHR+MH+EJtsjt/dVtdzJ3nBv1csAchmeHpRkyKbjVBCyhctSNROsxT28KkjoG/mDG
         8c8LkD9HGZIlf/eMb9GrN/XL9P94CQULfirmTh0LsIFej1HBnLEqAHdM0FuVPNN/PbrR
         SBrg==
X-Gm-Message-State: AJcUukenHdxUjs0UdTReP0mKus5zobncQ2cEIrCY0WFXR4CdK92RBjFV
        CIrIpilN/HS/hWkSBdMjm4EPUHrTU6tdXxR4D//rxw==
X-Google-Smtp-Source: ALg8bN5sOjeVf2SaZKbtcznKTLS8S7p2Y+wTtEzou/2K1fyNXaGMkzZVoYBsHMHWAu59dhB53XZlbw1kDzo75BF9U1k=
X-Received: by 2002:ab0:7544:: with SMTP id k4mr19158550uaq.66.1549201694397;
 Sun, 03 Feb 2019 05:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20190130220617.4862-1-oded.gabbay@gmail.com> <20190130220617.4862-8-oded.gabbay@gmail.com>
 <20190131133216.GL28876@rapoport-lnx>
In-Reply-To: <20190131133216.GL28876@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 3 Feb 2019 15:49:49 +0200
Message-ID: <CAFCwf12_g1KzrUBHoaKAr-muktwzzNAvosRDkNpfHEfmnPuD5g@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] habanalabs: add h/w queues module
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 3:32 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Jan 31, 2019 at 12:06:09AM +0200, Oded Gabbay wrote:
> > This patch adds the H/W queues module and the code to initialize Goya's
> > various compute and DMA engines and their queues.
> >
> > Goya has 5 DMA channels, 8 TPC engines and a single MME engine. For each
> > channel/engine, there is a H/W queue logic which is used to pass commands
> > from the user to the H/W. That logic is called QMAN.
> >
> > There are two types of QMANs: external and internal. The DMA QMANs are
> > considered external while the TPC and MME QMANs are considered internal.
> > For each external queue there is a completion queue, which is located on
> > the Host memory.
> >
> > The differences between external and internal QMANs are:
> >
> > 1. The location of the queue's memory. External QMANs are located on the
> >    Host memory while internal QMANs are located on the on-chip memory.
> >
> > 2. The external QMAN write an entry to a completion queue and sends an
> >    MSI-X interrupt upon completion of a command buffer that was given to
> >    it. The internal QMAN doesn't do that.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> > Changes in v2:
> >   - Add goya_async_events.h in this patch
> >   - Add return of -ENOMEM in error path (was originally missing)
> >   - Replace /** with /* in all functions
> >   - Add comment about stopping QMANs
> >   - Better error message for failure in sending CPU packet
> >   - Remove Authors: from comment at start of file
> >   - Remove bitfields in interface to F/W and use __le16/32/64
> >   - Remove bitfields in interface to QMAN and use __le16/32/64
> >   - Move enum goya_queue_id to uapi/misc/habanalabs.h as it is uapi
> >
> >  drivers/misc/habanalabs/Makefile              |    2 +-
> >  drivers/misc/habanalabs/device.c              |   75 +-
> >  drivers/misc/habanalabs/goya/goya.c           | 1529 +++++++++++++++--
> >  drivers/misc/habanalabs/goya/goyaP.h          |    7 +
> >  drivers/misc/habanalabs/habanalabs.h          |  175 +-
> >  drivers/misc/habanalabs/habanalabs_drv.c      |    6 +
> >  drivers/misc/habanalabs/hw_queue.c            |  404 +++++
> >  drivers/misc/habanalabs/include/armcp_if.h    |  292 ++++
> >  .../include/goya/goya_async_events.h          |  186 ++
> >  .../habanalabs/include/goya/goya_packets.h    |  129 ++
> >  drivers/misc/habanalabs/include/qman_if.h     |   56 +
> >  drivers/misc/habanalabs/irq.c                 |  150 ++
> >  include/uapi/misc/habanalabs.h                |   29 +
> >  13 files changed, 2919 insertions(+), 121 deletions(-)
> >  create mode 100644 drivers/misc/habanalabs/hw_queue.c
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
> >  create mode 100644 drivers/misc/habanalabs/include/qman_if.h
> >  create mode 100644 drivers/misc/habanalabs/irq.c
>
> [ ... ]
>
> > +/*
> > + * goya_stop_external_queues - Stop external queues
> > + *
> > + * @hdev: pointer to hl_device structure
> > + *
> > + * Returns 0 on success
> > + *
> > + */
> > +static int goya_stop_external_queues(struct hl_device *hdev)
> > +{
> > +     int rc = goya_stop_queue(hdev,
> > +                     mmDMA_QM_0_GLBL_CFG1,
> > +                     mmDMA_QM_0_CP_STS,
> > +                     mmDMA_QM_0_GLBL_STS0);
> > +
> > +     if (rc)
> > +             dev_err(hdev->dev, "failed to stop DMA QMAN 0\n");
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmDMA_QM_1_GLBL_CFG1,
> > +                     mmDMA_QM_1_CP_STS,
> > +                     mmDMA_QM_1_GLBL_STS0);
> > +
> > +     if (rc)
> > +             dev_err(hdev->dev, "failed to stop DMA QMAN 1\n");
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmDMA_QM_2_GLBL_CFG1,
> > +                     mmDMA_QM_2_CP_STS,
> > +                     mmDMA_QM_2_GLBL_STS0);
> > +
> > +     if (rc)
> > +             dev_err(hdev->dev, "failed to stop DMA QMAN 2\n");
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmDMA_QM_3_GLBL_CFG1,
> > +                     mmDMA_QM_3_CP_STS,
> > +                     mmDMA_QM_3_GLBL_STS0);
> > +
> > +     if (rc)
> > +             dev_err(hdev->dev, "failed to stop DMA QMAN 3\n");
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmDMA_QM_4_GLBL_CFG1,
> > +                     mmDMA_QM_4_CP_STS,
> > +                     mmDMA_QM_4_GLBL_STS0);
> > +
> > +     if (rc)
> > +             dev_err(hdev->dev, "failed to stop DMA QMAN 4\n");
> > +
> > +     return rc;
>
> Is is possible that one of the first goya_stop_queue() calls will fail, but
> the last would succeed? Then rc will be 0...
>
Thanks, fixed.

> BTW, the goya_stop_internal_queues() seem to handle this.
>
> > +}
> > +
> > +static void goya_resume_external_queues(struct hl_device *hdev)
> > +{
> > +     WREG32(mmDMA_QM_0_GLBL_CFG1, 0);
> > +     WREG32(mmDMA_QM_1_GLBL_CFG1, 0);
> > +     WREG32(mmDMA_QM_2_GLBL_CFG1, 0);
> > +     WREG32(mmDMA_QM_3_GLBL_CFG1, 0);
> > +     WREG32(mmDMA_QM_4_GLBL_CFG1, 0);
> > +}
>
> [ ... ]
>
> > +/*
> > + * goya_stop_internal_queues - Stop internal queues
> > + *
> > + * @hdev: pointer to hl_device structure
> > + *
> > + * Returns 0 on success
> > + *
> > + */
> > +static int goya_stop_internal_queues(struct hl_device *hdev)
> > +{
> > +     int rc, retval = 0;
> > +
> > +     /*
> > +      * Each queue (QMAN) is a separate H/W logic. That means that each
> > +      * QMAN can be stopped independently and failure to stop one does NOT
> > +      * mandate we should not try to stop other QMANs
> > +      */
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmMME_QM_GLBL_CFG1,
> > +                     mmMME_QM_CP_STS,
> > +                     mmMME_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop MME QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmMME_CMDQ_GLBL_CFG1,
> > +                     mmMME_CMDQ_CP_STS,
> > +                     mmMME_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop MME CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC0_QM_GLBL_CFG1,
> > +                     mmTPC0_QM_CP_STS,
> > +                     mmTPC0_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 0 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC0_CMDQ_GLBL_CFG1,
> > +                     mmTPC0_CMDQ_CP_STS,
> > +                     mmTPC0_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 0 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC1_QM_GLBL_CFG1,
> > +                     mmTPC1_QM_CP_STS,
> > +                     mmTPC1_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 1 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC1_CMDQ_GLBL_CFG1,
> > +                     mmTPC1_CMDQ_CP_STS,
> > +                     mmTPC1_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 1 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC2_QM_GLBL_CFG1,
> > +                     mmTPC2_QM_CP_STS,
> > +                     mmTPC2_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 2 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC2_CMDQ_GLBL_CFG1,
> > +                     mmTPC2_CMDQ_CP_STS,
> > +                     mmTPC2_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 2 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC3_QM_GLBL_CFG1,
> > +                     mmTPC3_QM_CP_STS,
> > +                     mmTPC3_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 3 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC3_CMDQ_GLBL_CFG1,
> > +                     mmTPC3_CMDQ_CP_STS,
> > +                     mmTPC3_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 3 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC4_QM_GLBL_CFG1,
> > +                     mmTPC4_QM_CP_STS,
> > +                     mmTPC4_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 4 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC4_CMDQ_GLBL_CFG1,
> > +                     mmTPC4_CMDQ_CP_STS,
> > +                     mmTPC4_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 4 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC5_QM_GLBL_CFG1,
> > +                     mmTPC5_QM_CP_STS,
> > +                     mmTPC5_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 5 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC5_CMDQ_GLBL_CFG1,
> > +                     mmTPC5_CMDQ_CP_STS,
> > +                     mmTPC5_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 5 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC6_QM_GLBL_CFG1,
> > +                     mmTPC6_QM_CP_STS,
> > +                     mmTPC6_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 6 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC6_CMDQ_GLBL_CFG1,
> > +                     mmTPC6_CMDQ_CP_STS,
> > +                     mmTPC6_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 6 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC7_QM_GLBL_CFG1,
> > +                     mmTPC7_QM_CP_STS,
> > +                     mmTPC7_QM_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 7 QMAN\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     rc = goya_stop_queue(hdev,
> > +                     mmTPC7_CMDQ_GLBL_CFG1,
> > +                     mmTPC7_CMDQ_CP_STS,
> > +                     mmTPC7_CMDQ_GLBL_STS0);
> > +
> > +     if (rc) {
> > +             dev_err(hdev->dev, "failed to stop TPC 7 CMDQ\n");
> > +             retval = -EIO;
> > +     }
> > +
> > +     return rc;
> > +}
> > +
>
> [ ... ]
>
> > @@ -1494,6 +2370,104 @@ int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
> >       return rc;
> >  }
> >
> > +void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
> > +{
> > +     u32 db_reg_offset, db_value;
> > +     bool invalid_queue = false;
> > +
> > +     switch (hw_queue_id) {
> > +     case GOYA_QUEUE_ID_DMA_0:
> > +             db_reg_offset = mmDMA_QM_0_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_DMA_1:
> > +             db_reg_offset = mmDMA_QM_1_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_DMA_2:
> > +             db_reg_offset = mmDMA_QM_2_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_DMA_3:
> > +             db_reg_offset = mmDMA_QM_3_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_DMA_4:
> > +             db_reg_offset = mmDMA_QM_4_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_CPU_PQ:
> > +             if (hdev->cpu_queues_enable)
> > +                     db_reg_offset = mmCPU_IF_PF_PQ_PI;
> > +             else
> > +                     invalid_queue = true;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_MME:
> > +             db_reg_offset = mmMME_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC0:
> > +             db_reg_offset = mmTPC0_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC1:
> > +             db_reg_offset = mmTPC1_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC2:
> > +             db_reg_offset = mmTPC2_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC3:
> > +             db_reg_offset = mmTPC3_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC4:
> > +             db_reg_offset = mmTPC4_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC5:
> > +             db_reg_offset = mmTPC5_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC6:
> > +             db_reg_offset = mmTPC6_QM_PQ_PI;
> > +             break;
> > +
> > +     case GOYA_QUEUE_ID_TPC7:
> > +             db_reg_offset = mmTPC7_QM_PQ_PI;
> > +             break;
> > +
> > +     default:
> > +             invalid_queue = true;
> > +     }
> > +
> > +     if (invalid_queue) {
> > +             /* Should never get here */
> > +             dev_err(hdev->dev, "h/w queue %d is invalid. Can't set pi\n",
> > +                     hw_queue_id);
> > +             return;
> > +     }
> > +
> > +     db_value = pi;
> > +
> > +     if (hdev->ifh)
> > +             return;
>
> This could move to the beginning of the function, /me thinks.
>
I think I'll just remove this completely as this is a debug mode which
is no longer needed.
Thanks,
Oded
> > +
> > +     /* ring the doorbell */
> > +     WREG32(db_reg_offset, db_value);
> > +
> > +     if (hw_queue_id == GOYA_QUEUE_ID_CPU_PQ)
> > +             WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
> > +                             GOYA_ASYNC_EVENT_ID_PI_UPDATE);
> > +}
> > +
> > +void goya_flush_pq_write(struct hl_device *hdev, u64 *pq, u64 exp_val)
> > +{
> > +     /* Not needed in Goya */
> > +}
> > +
> >  void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
> >                                       dma_addr_t *dma_handle, gfp_t flags)
> >  {
> > @@ -1506,6 +2480,316 @@ void goya_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
> >       dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, dma_handle);
> >  }
> >
>
> --
> Sincerely yours,
> Mike.
>
