Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E0D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G15UP0rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E0D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJDRWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:22:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33167 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJDRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:22:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so9260085qte.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1i+BT3mWGnIQN9DpYCKMRTDWxqk2foS3Bah5ESduan4=;
        b=G15UP0rC07pMv1GEF+Yrf8ZVOra6qECPdMTBXNCwTXPc2xPV8+hZJwO2Q79WmMk7/+
         15ywiR3H84kDPwxHTl7TSdaUwkcrclRfIlxhvya7lqotHZ9qq4nPnV2SmyKk41bGUzR0
         nzuKJ/TDymWJlC02Ts6L1vGDHx132bAQs1RhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1i+BT3mWGnIQN9DpYCKMRTDWxqk2foS3Bah5ESduan4=;
        b=bIXhpqJydM65uA6yQ9OFHjHZlktLJ3W9kUVjuKgPeX3PP+8defEOVJs1UmvdUNN97V
         zed95ZRYBWaL+aRjVWOVsxydQDrAumlxqCIj4SKhSO8Oaf0GIi4wEVlyFGjSWVaiOFCc
         YQj27/q3aURTe8DkHJuQQPM3O79j0VcuFoUQP3ykK3ST+L9nDHAy3/AJT9n1pZhbvIwy
         P7beVzvV5MAHjCsKvN6QRuHh4+DPdSo2SOq3xsTm75qw91dVCsyYbaZ4jXZNuh+V5fD7
         SEkgFKRd/Jn8gjPK5iDDIKMowq19J9glTZipdZJWRUPZIRFzJOCxziNt/A5iOGE+1szp
         rW3w==
X-Gm-Message-State: ABuFfoiHbHDD/sNAuKzXxG16E+S4UbQONWiFOsCGe+9EdBqj4GvMhGL1
        uiwEtKHSrzD2LYQPPPo2qlys8zQ1JI1gJZr5vnZq9A==
X-Google-Smtp-Source: ACcGV60aGH+79p8bwIZxzPYlyhysuL10Xwe42aSaV2mKi/lrnBTdFi92pnqXt8ZunxT1lgaNg4QwkpxOVYr5aGU8je0=
X-Received: by 2002:ac8:7119:: with SMTP id z25-v6mr4765115qto.270.1538648992405;
 Thu, 04 Oct 2018 03:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537183087.git.joe@perches.com> <f2eb641cb919f46a16871593d35e4a83c9d13324.1537183088.git.joe@perches.com>
In-Reply-To: <f2eb641cb919f46a16871593d35e4a83c9d13324.1537183088.git.joe@perches.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 4 Oct 2018 16:00:21 +0530
Message-ID: <CA+RiK67Yg01QB+aFVdRqZ-cEg+RHO-9qGd2n-NxZWcwGfQFvzw@mail.gmail.com>
Subject: Re: [PATCH 6/7] mpt3sas: Convert logging uses with MPT3SAS_FMT
 without logging levels
To:     joe@perches.com
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please consider this patch as Acked-by: Suganath Prabu
<suganath-prabu.subramani@broadcom.com>

Thanks.
On Mon, Sep 17, 2018 at 8:33 PM Joe Perches <joe@perches.com> wrote:
>
> Convert these uses to ioc_<level> where appropriate.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c      | 41 +++++++++++++++-----------------
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 12 +++++-----
>  drivers/scsi/mpt3sas/mpt3sas_transport.c |  6 ++---
>  3 files changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index 386af6739867..cf5a21717a6f 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -2819,9 +2819,8 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
>         ioc->reply_queue_count = min_t(int, ioc->cpu_count,
>                 ioc->msix_vector_count);
>
> -       printk(MPT3SAS_FMT "MSI-X vectors supported: %d, no of cores"
> -         ": %d, max_msix_vectors: %d\n", ioc->name, ioc->msix_vector_count,
> -         ioc->cpu_count, max_msix_vectors);
> +       ioc_info(ioc, "MSI-X vectors supported: %d, no of cores: %d, max_msix_vectors: %d\n",
> +                ioc->msix_vector_count, ioc->cpu_count, max_msix_vectors);
>
>         if (!ioc->rdpq_array_enable && max_msix_vectors == -1)
>                 local_max_msix_vectors = (reset_devices) ? 1 : 8;
> @@ -2886,8 +2885,7 @@ mpt3sas_base_unmap_resources(struct MPT3SAS_ADAPTER *ioc)
>  {
>         struct pci_dev *pdev = ioc->pdev;
>
> -       dexitprintk(ioc, printk(MPT3SAS_FMT "%s\n",
> -               ioc->name, __func__));
> +       dexitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
>
>         _base_free_irq(ioc);
>         _base_disable_msix(ioc);
> @@ -3007,9 +3005,8 @@ mpt3sas_base_map_resources(struct MPT3SAS_ADAPTER *ioc)
>                      ioc->combined_reply_index_count,
>                      sizeof(resource_size_t *), GFP_KERNEL);
>                 if (!ioc->replyPostRegisterIndex) {
> -                       dfailprintk(ioc, printk(MPT3SAS_FMT
> -                       "allocation for reply Post Register Index failed!!!\n",
> -                                                                  ioc->name));
> +                       dfailprintk(ioc,
> +                                   ioc_warn(ioc, "allocation for reply Post Register Index failed!!!\n"));
>                         r = -ENOMEM;
>                         goto out_fail;
>                 }
> @@ -5438,26 +5435,26 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
>         u32 ioc_state;
>         int rc;
>
> -       dinitprintk(ioc, printk(MPT3SAS_FMT "%s\n", ioc->name,
> -           __func__));
> +       dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
>
>         if (ioc->pci_error_recovery) {
> -               dfailprintk(ioc, printk(MPT3SAS_FMT
> -                   "%s: host in pci error recovery\n", ioc->name, __func__));
> +               dfailprintk(ioc,
> +                           ioc_info(ioc, "%s: host in pci error recovery\n",
> +                                    __func__));
>                 return -EFAULT;
>         }
>
>         ioc_state = mpt3sas_base_get_iocstate(ioc, 0);
> -       dhsprintk(ioc, printk(MPT3SAS_FMT "%s: ioc_state(0x%08x)\n",
> -           ioc->name, __func__, ioc_state));
> +       dhsprintk(ioc,
> +                 ioc_info(ioc, "%s: ioc_state(0x%08x)\n",
> +                          __func__, ioc_state));
>
>         if (((ioc_state & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_READY) ||
>             (ioc_state & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_OPERATIONAL)
>                 return 0;
>
>         if (ioc_state & MPI2_DOORBELL_USED) {
> -               dhsprintk(ioc, printk(MPT3SAS_FMT
> -                   "unexpected doorbell active!\n", ioc->name));
> +               dhsprintk(ioc, ioc_info(ioc, "unexpected doorbell active!\n"));
>                 goto issue_diag_reset;
>         }
>
> @@ -5469,9 +5466,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
>
>         ioc_state = _base_wait_on_iocstate(ioc, MPI2_IOC_STATE_READY, timeout);
>         if (ioc_state) {
> -               dfailprintk(ioc, printk(MPT3SAS_FMT
> -                   "%s: failed going to ready state (ioc_state=0x%x)\n",
> -                   ioc->name, __func__, ioc_state));
> +               dfailprintk(ioc,
> +                           ioc_info(ioc, "%s: failed going to ready state (ioc_state=0x%x)\n",
> +                                    __func__, ioc_state));
>                 return -EFAULT;
>         }
>
> @@ -5498,9 +5495,9 @@ _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc)
>
>         r = _base_wait_for_iocstate(ioc, 10);
>         if (r) {
> -               dfailprintk(ioc, printk(MPT3SAS_FMT
> -                   "%s: failed getting to correct state\n",
> -                   ioc->name, __func__));
> +               dfailprintk(ioc,
> +                           ioc_info(ioc, "%s: failed getting to correct state\n",
> +                                    __func__));
>                 return r;
>         }
>         mpi_reply_sz = sizeof(Mpi2IOCFactsReply_t);
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 8089be381c72..4d73b5e6e2fc 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -4999,16 +4999,16 @@ _scsih_turn_off_pfa_led(struct MPT3SAS_ADAPTER *ioc,
>         mpi_request.Flags = MPI2_SEP_REQ_FLAGS_ENCLOSURE_SLOT_ADDRESS;
>         if ((mpt3sas_base_scsi_enclosure_processor(ioc, &mpi_reply,
>                 &mpi_request)) != 0) {
> -               printk(MPT3SAS_FMT "failure at %s:%d/%s()!\n", ioc->name,
> -               __FILE__, __LINE__, __func__);
> +               ioc_err(ioc, "failure at %s:%d/%s()!\n",
> +                       __FILE__, __LINE__, __func__);
>                 return;
>         }
>
>         if (mpi_reply.IOCStatus || mpi_reply.IOCLogInfo) {
> -               dewtprintk(ioc, printk(MPT3SAS_FMT
> -                "enclosure_processor: ioc_status (0x%04x), loginfo(0x%08x)\n",
> -                ioc->name, le16_to_cpu(mpi_reply.IOCStatus),
> -                le32_to_cpu(mpi_reply.IOCLogInfo)));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "enclosure_processor: ioc_status (0x%04x), loginfo(0x%08x)\n",
> +                                   le16_to_cpu(mpi_reply.IOCStatus),
> +                                   le32_to_cpu(mpi_reply.IOCLogInfo)));
>                 return;
>         }
>  }
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> index 09034a3fba2c..031b420f4d40 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> @@ -717,9 +717,9 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
>                 sas_device = mpt3sas_get_sdev_by_addr(ioc,
>                                     mpt3sas_port->remote_identify.sas_address);
>                 if (!sas_device) {
> -                       dfailprintk(ioc, printk(MPT3SAS_FMT
> -                               "failure at %s:%d/%s()!\n",
> -                               ioc->name, __FILE__, __LINE__, __func__));
> +                       dfailprintk(ioc,
> +                                   ioc_info(ioc, "failure at %s:%d/%s()!\n",
> +                                            __FILE__, __LINE__, __func__));
>                         goto out_fail;
>                 }
>                 sas_device->pend_sas_rphy_add = 1;
> --
> 2.15.0
>
