Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96306C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C62064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z6A1Ha4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309C62064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeJDRVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:21:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46881 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:21:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id q12-v6so5342185qkl.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6KfDIFYHNIcMGbHKij2RBTOK+US6yvxz2XS38T4Gr0=;
        b=Z6A1Ha4ejB8JjB5ZZHTJr7sT8W10mY6MV6WJM9DZNBce2OaaFPTH6uuZywByPJY20O
         WKHpj2PcsdL+cVxMV3yydSa/QBw307KDKeoCxF1EKJ2+0qy3RAjf92tPhfBgD1DjQia8
         Km6HGVsWmQDZR+POneDlCwGOZCWB0TfBvJzts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6KfDIFYHNIcMGbHKij2RBTOK+US6yvxz2XS38T4Gr0=;
        b=g7xtAXVYh7AB8a+IgyCakkzZ7DXOOPk2GGo231lXat1u6A4NisIfa+rz5Erf89Y41s
         O0oIq1FxcuvaL3QcHuOpx752sJmFuS9oyrR+LfuH1t6WKtyEY/Tv2R5C5rEsg3dgnB4Y
         qhHqhqs8L7pI9WoTV4cBmNR8FdnyAde17tTtiXF880ZryUtCg2nVMK5dwan58ZZOZITm
         0OFLnVS4V5YkqFKLe35X8pO9XG7u7sG202tqiZYhPUgRL+QseozlE//tPuCynt0M7z2d
         +XXeuCl2jnZ5awi3zLLdvgSN/KH2/vsCwz+UBmL1sXKaFA8/ai0G6N8uHBBwequpE+E5
         c0Og==
X-Gm-Message-State: ABuFfoheEgG42ImfvCkHzQPptrxboTmbee+pCm58t+JLEotwMHvpjCzI
        ByB8FWYhOwIUOzBDT705luXx2k5m4xqEX7GBQSYejg==
X-Google-Smtp-Source: ACcGV61UrvWjcYU4UK/OyRZt9vLHAMnEgtG+dN1AX3Nl9t116K9aLk3rV/allUQiQO/CmnSBrnatAxnTeB2MpxsdQbk=
X-Received: by 2002:ae9:f106:: with SMTP id k6-v6mr4602402qkg.34.1538648910795;
 Thu, 04 Oct 2018 03:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537183087.git.joe@perches.com> <71b9656aa46ec31a9991587d7ff204e0877a336e.1537183088.git.joe@perches.com>
In-Reply-To: <71b9656aa46ec31a9991587d7ff204e0877a336e.1537183088.git.joe@perches.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 4 Oct 2018 15:58:59 +0530
Message-ID: <CA+RiK66PjEefHTUD5myFcxQ_w6Vu6qk72HJwzZmmo6EcEt_xmQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] mpt3sas: Convert mlsleading uses of pr_<level> with MPT3SAS_FMT
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
On Mon, Sep 17, 2018 at 8:31 PM Joe Perches <joe@perches.com> wrote:
>
> These have misordered uses of __func__ and ioc->name that could
> mismatch MPT3SAS_FMT and "%s: ".
>
> Convert them to ioc_<level>.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 50 +++++++++++++++-----------------
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 18 ++++--------
>  2 files changed, 29 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 3331eba4b78d..8089be381c72 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -2627,15 +2627,13 @@ mpt3sas_scsih_issue_tm(struct MPT3SAS_ADAPTER *ioc, u16 handle, u64 lun,
>         lockdep_assert_held(&ioc->tm_cmds.mutex);
>
>         if (ioc->tm_cmds.status != MPT3_CMD_NOT_USED) {
> -               pr_info(MPT3SAS_FMT "%s: tm_cmd busy!!!\n",
> -                   __func__, ioc->name);
> +               ioc_info(ioc, "%s: tm_cmd busy!!!\n", __func__);
>                 return FAILED;
>         }
>
>         if (ioc->shost_recovery || ioc->remove_host ||
>             ioc->pci_error_recovery) {
> -               pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
> -                   __func__, ioc->name);
> +               ioc_info(ioc, "%s: host reset in progress!\n", __func__);
>                 return FAILED;
>         }
>
> @@ -3550,18 +3548,16 @@ _scsih_tm_tr_send(struct MPT3SAS_ADAPTER *ioc, u16 handle)
>         u8 tr_method = 0;
>
>         if (ioc->pci_error_recovery) {
> -               dewtprintk(ioc, pr_info(MPT3SAS_FMT
> -                       "%s: host in pci error recovery: handle(0x%04x)\n",
> -                       __func__, ioc->name,
> -                   handle));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "%s: host in pci error recovery: handle(0x%04x)\n",
> +                                   __func__, handle));
>                 return;
>         }
>         ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
>         if (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
> -               dewtprintk(ioc, pr_info(MPT3SAS_FMT
> -                       "%s: host is not operational: handle(0x%04x)\n",
> -                       __func__, ioc->name,
> -                  handle));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "%s: host is not operational: handle(0x%04x)\n",
> +                                   __func__, handle));
>                 return;
>         }
>
> @@ -3811,9 +3807,9 @@ _scsih_tm_tr_volume_send(struct MPT3SAS_ADAPTER *ioc, u16 handle)
>         struct _tr_list *delayed_tr;
>
>         if (ioc->pci_error_recovery) {
> -               dewtprintk(ioc, pr_info(MPT3SAS_FMT
> -                       "%s: host reset in progress!\n",
> -                       __func__, ioc->name));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "%s: host reset in progress!\n",
> +                                   __func__));
>                 return;
>         }
>
> @@ -3863,9 +3859,9 @@ _scsih_tm_volume_tr_complete(struct MPT3SAS_ADAPTER *ioc, u16 smid,
>             mpt3sas_base_get_reply_virt_addr(ioc, reply);
>
>         if (ioc->shost_recovery || ioc->pci_error_recovery) {
> -               dewtprintk(ioc, pr_info(MPT3SAS_FMT
> -                       "%s: host reset in progress!\n",
> -                       __func__, ioc->name));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "%s: host reset in progress!\n",
> +                                   __func__));
>                 return 1;
>         }
>         if (unlikely(!mpi_reply)) {
> @@ -3950,21 +3946,21 @@ _scsih_issue_delayed_sas_io_unit_ctrl(struct MPT3SAS_ADAPTER *ioc,
>         unsigned long flags;
>
>         if (ioc->remove_host) {
> -               dewtprintk(ioc, pr_info(MPT3SAS_FMT
> -                           "%s: host has been removed\n",
> -                            __func__, ioc->name));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "%s: host has been removed\n",
> +                                   __func__));
>                 return;
>         } else if (ioc->pci_error_recovery) {
> -               dewtprintk(ioc, pr_info(MPT3SAS_FMT
> -                           "%s: host in pci error recovery\n",
> -                           __func__, ioc->name));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "%s: host in pci error recovery\n",
> +                                   __func__));
>                 return;
>         }
>         ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
>         if (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
> -               dewtprintk(ioc, pr_info(MPT3SAS_FMT
> -                   "%s: host is not operational\n",
> -                   __func__, ioc->name));
> +               dewtprintk(ioc,
> +                          ioc_info(ioc, "%s: host is not operational\n",
> +                                   __func__));
>                 return;
>         }
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> index d4bf4d5e576e..09034a3fba2c 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> @@ -146,8 +146,7 @@ _transport_set_identify(struct MPT3SAS_ADAPTER *ioc, u16 handle,
>         u32 ioc_status;
>
>         if (ioc->shost_recovery || ioc->pci_error_recovery) {
> -               pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
> -                   __func__, ioc->name);
> +               ioc_info(ioc, "%s: host reset in progress!\n", __func__);
>                 return -EFAULT;
>         }
>
> @@ -308,8 +307,7 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
>         u16 wait_state_count;
>
>         if (ioc->shost_recovery || ioc->pci_error_recovery) {
> -               pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
> -                   __func__, ioc->name);
> +               ioc_info(ioc, "%s: host reset in progress!\n", __func__);
>                 return -EFAULT;
>         }
>
> @@ -1088,8 +1086,7 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
>         u16 wait_state_count;
>
>         if (ioc->shost_recovery || ioc->pci_error_recovery) {
> -               pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
> -                   __func__, ioc->name);
> +               ioc_info(ioc, "%s: host reset in progress!\n", __func__);
>                 return -EFAULT;
>         }
>
> @@ -1393,8 +1390,7 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
>         u16 wait_state_count;
>
>         if (ioc->shost_recovery || ioc->pci_error_recovery) {
> -               pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
> -                   __func__, ioc->name);
> +               ioc_info(ioc, "%s: host reset in progress!\n", __func__);
>                 return -EFAULT;
>         }
>
> @@ -1894,8 +1890,7 @@ _transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
>         unsigned int reslen = 0;
>
>         if (ioc->shost_recovery || ioc->pci_error_recovery) {
> -               pr_info(MPT3SAS_FMT "%s: host reset in progress!\n",
> -                   __func__, ioc->name);
> +               ioc_info(ioc, "%s: host reset in progress!\n", __func__);
>                 rc = -EFAULT;
>                 goto job_done;
>         }
> @@ -1975,8 +1970,7 @@ _transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
>         wait_for_completion_timeout(&ioc->transport_cmds.done, 10*HZ);
>
>         if (!(ioc->transport_cmds.status & MPT3_CMD_COMPLETE)) {
> -               pr_err(MPT3SAS_FMT "%s : timeout\n",
> -                   __func__, ioc->name);
> +               ioc_err(ioc, "%s: timeout\n", __func__);
>                 _debug_dump_mf(mpi_request,
>                     sizeof(Mpi2SmpPassthroughRequest_t)/4);
>                 if (!(ioc->transport_cmds.status & MPT3_CMD_RESET)) {
> --
> 2.15.0
>
