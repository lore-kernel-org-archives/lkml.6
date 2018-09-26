Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7976EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220C920843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Aa9i87Kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220C920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIZRbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:31:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45252 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIZRbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:31:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id h6-v6so60082eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=jbQNypApR/BGHV6XZZxh8y80R1pViq9Tb/WOPO3JT3E=;
        b=Aa9i87KrPo9AX6fS44hElhk7PKRrsuBSR1sT1UPGW2zninfhnecM7ADGkWA1qdZN9T
         d0MTpeSO68OUMK41LICZ/a0b9ZcxFdP9z04hQr55mKaZ74AdYEdOYkFO55U1E5jG24o7
         B/j2n9KCXGpXR1QXaz2mvWtlEvnTl9tyGGIDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=jbQNypApR/BGHV6XZZxh8y80R1pViq9Tb/WOPO3JT3E=;
        b=bceDFVwL0zqN7S5iJhCfZqZcKMsga0fz4z+/3ONNFNWxPqef6MNmzqJHYvhMSGrN4m
         vFJZZguqTX+l/yRP0M846tQ9NZCnAZdskOYeydM9ZQC41XDih3U3tv5kHYl/GqqCwlVc
         Phy1V/UDLVVBzsQICDfAsbZuZg0PGHAcad53DQgWorG597ZSNi7QrXdC4EkBeSbaNbrR
         8OVdkFt6fHeAyLIxDWrrTF6n15Oy/jVB8l1D0JPm8Sv2FG6hM0zv/coJ0JN7+axV2ZZq
         qmhlqDVEkjoE71vg6P7PAuDzjgMUh3rHBRxPzCZ5sAvV1FTgkdqO5yJlTiiB8Yk34cY3
         z38Q==
X-Gm-Message-State: ABuFfohjiKTo21eY4ubC2zjuEglqqNb/zOvFzpniDWywuMA0Kdq0w7bA
        LsBMzZ3AyYpDyIwFiq9yOks6EOp8tm1P9jIEobQumQ==
X-Google-Smtp-Source: ACcGV61PiERchTDY7PV9T6bjKd9auhsulJocQcVFyrKj9Zk5uhfflQqfyXYHu461xFGN2Ai4AS1Tv5+0FmT937CtRR8=
X-Received: by 2002:a50:b4b0:: with SMTP id w45-v6mr8693200edd.254.1537960751486;
 Wed, 26 Sep 2018 04:19:11 -0700 (PDT)
From:   Sumit Saxena <sumit.saxena@broadcom.com>
References: <20180923222548.7908-1-colin.king@canonical.com>
In-Reply-To: <20180923222548.7908-1-colin.king@canonical.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQG53s5Tb7+9AMaG0ntjNxx3ahOHAKU3V2gw
Date:   Wed, 26 Sep 2018 16:49:10 +0530
Message-ID: <2517be92121ace5f4a42276bce2a413b@mail.gmail.com>
Subject: RE: [PATCH] scsi: megaraid: fix spelling mistake "maibox" -> "mailbox"
To:     Colin King <colin.king@canonical.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Colin King [mailto:colin.king@canonical.com]
> Sent: Monday, September 24, 2018 3:56 AM
> To: Kashyap Desai <kashyap.desai@broadcom.com>; Sumit Saxena
> <sumit.saxena@broadcom.com>; Shivasharan S
> <shivasharan.srikanteshwara@broadcom.com>; James E . J . Bottomley
> <jejb@linux.vnet.ibm.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; megaraidlinux.pdl@broadcom.com; linux-
> scsi@vger.kernel.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] scsi: megaraid: fix spelling mistake "maibox" ->
> "mailbox"
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in warning message and comments
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/megaraid/megaraid_mbox.c | 4 ++--
> drivers/scsi/megaraid/megaraid_mbox.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_mbox.c
> b/drivers/scsi/megaraid/megaraid_mbox.c
> index 530358cdcb39..2013523605c5 100644
> --- a/drivers/scsi/megaraid/megaraid_mbox.c
> +++ b/drivers/scsi/megaraid/megaraid_mbox.c
> @@ -484,7 +484,7 @@ megaraid_probe_one(struct pci_dev *pdev, const
> struct pci_device_id *id)
>  	// Start the mailbox based controller
>  	if (megaraid_init_mbox(adapter) != 0) {
>  		con_log(CL_ANN, (KERN_WARNING
> -			"megaraid: maibox adapter did not initialize\n"));
> +			"megaraid: mailbox adapter did not initialize\n"));
>
>  		goto out_free_adapter;
>  	}
> @@ -950,7 +950,7 @@ megaraid_fini_mbox(adapter_t *adapter)
>   * megaraid_alloc_cmd_packets - allocate shared mailbox
>   * @adapter		: soft state of the raid controller
>   *
> - * Allocate and align the shared mailbox. This maibox is used to issue
> + * Allocate and align the shared mailbox. This mailbox is used to issue
>   * all the commands. For IO based controllers, the mailbox is also
> registered
>   * with the FW. Allocate memory for all commands as well.
>   * This is our big allocator.
> diff --git a/drivers/scsi/megaraid/megaraid_mbox.h
> b/drivers/scsi/megaraid/megaraid_mbox.h
> index c1d86d961a92..e075aeb4012f 100644
> --- a/drivers/scsi/megaraid/megaraid_mbox.h
> +++ b/drivers/scsi/megaraid/megaraid_mbox.h
> @@ -117,7 +117,7 @@
>   * @raw_mbox		: raw mailbox pointer
>   * @mbox		: mailbox
>   * @mbox64		: extended mailbox
> - * @mbox_dma_h		: maibox dma address
> + * @mbox_dma_h		: mailbox dma address
>   * @sgl64		: 64-bit scatter-gather list
>   * @sgl32		: 32-bit scatter-gather list
>   * @sgl_dma_h		: dma handle for the scatter-gather list

Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> --
> 2.17.1
