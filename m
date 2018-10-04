Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E27DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AAB2064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TT+8qYvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AAB2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeJDRVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:21:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41389 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:21:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15-v6so9222081qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaxISKHojTZBeWA0SGQ6/PLmCxUB5xGq0JQV9IBFR78=;
        b=TT+8qYvJZ5Qb+GMNFUlAbaTQY+drEQxvfUqf7ZdwEWRNDQklL3sSbSJNk8gEue8LR+
         /89fOY7TErL4aRgh+PmyhBksW3gorRLvF1j9VaEh2zgDmoFDU37hp4EL53y3yEIW2KdS
         e2LLk8xZcrFaK6MFkHAOQdxo2bwPPuoVdt0mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaxISKHojTZBeWA0SGQ6/PLmCxUB5xGq0JQV9IBFR78=;
        b=d6mgmVo/alCC91vq2Ln0k7bN2CV5OYBzrkW3WUfsEVdbhvAwB1Dn6UvAObWmoRSzNS
         9T98XyxYQkoA+GP8GijROS4ZF20PQsOokCWSoS8MJsYeqEMXKaW9YKRlTS7Axggjat0m
         8sm25sSFJnj2y/zTDtqJvzuP46p8BmBqsoTgsY+u//tv28+RcdNV0+0TTIvhvfdJauuK
         pgCG1WmpPqqYvoUJyo4G1yhOFc7fYhCEIte8Z/b24q5brjLgeuWk0c3OFfEgPb/xpl7c
         Y+SCPwomOmUIZjoSKhDmX8r5XWqVZgStxm0OfR4nbsBf7oWKoJ+YzFy42NmF2MSlC2Id
         ircg==
X-Gm-Message-State: ABuFfoh6CE5HcJs5Mn2U3PGd+GIjDUKk5Ue8pnx9RR12+6e+OQnVplio
        LANNjwsPuxBJI+FMia43gL/lWGxGA8SkLhuaJ9UftA==
X-Google-Smtp-Source: ACcGV61S7YgRXmTw/LZo01WaFX4gKJr4KPhappnQjFO5vDErNFShZdiWu69icfRtCMQN2rfhaCCkhVprvfIouKDxn9Y=
X-Received: by 2002:ac8:2974:: with SMTP id z49-v6mr4619065qtz.111.1538648947829;
 Thu, 04 Oct 2018 03:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537183087.git.joe@perches.com> <80a0b24fd5be85fcd87b92958691ab19484a4295.1537183088.git.joe@perches.com>
In-Reply-To: <80a0b24fd5be85fcd87b92958691ab19484a4295.1537183088.git.joe@perches.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 4 Oct 2018 15:59:36 +0530
Message-ID: <CA+RiK66nSLgzqt4atCctiH+DkB=2Z=5RgsR_oT8NareCe1e+DQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] mpt3sas: Convert logging uses with MPT3SAS_FMT and
 reply_q_name to %s:
To:     joe@perches.com
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra Basappa <chaitra.basappa@broadcom.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this patch as Acked-by: Suganath Prabu
<suganath-prabu.subramani@broadcom.com>

Thanks.
On Mon, Sep 17, 2018 at 8:31 PM Joe Perches <joe@perches.com> wrote:
>
> Convert the existing 2 uses to make the format and arguments
> matching more obvious.
>
> Miscellanea:
>
> o Move the word "enabled" into the format to trivially reduce object size
> o Remove unnecessary parentheses
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index 5c6634b7ca74..386af6739867 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -2705,7 +2705,7 @@ _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
>         r = request_irq(pci_irq_vector(pdev, index), _base_interrupt,
>                         IRQF_SHARED, reply_q->name, reply_q);
>         if (r) {
> -               pr_err(MPT3SAS_FMT "unable to allocate interrupt %d!\n",
> +               pr_err("%s: unable to allocate interrupt %d!\n",
>                        reply_q->name, pci_irq_vector(pdev, index));
>                 kfree(reply_q);
>                 return -EBUSY;
> @@ -3034,10 +3034,10 @@ mpt3sas_base_map_resources(struct MPT3SAS_ADAPTER *ioc)
>         }
>
>         list_for_each_entry(reply_q, &ioc->reply_queue_list, list)
> -               pr_info(MPT3SAS_FMT "%s: IRQ %d\n",
> -                   reply_q->name,  ((ioc->msix_enable) ? "PCI-MSI-X enabled" :
> -                   "IO-APIC enabled"),
> -                   pci_irq_vector(ioc->pdev, reply_q->msix_index));
> +               pr_info("%s: %s enabled: IRQ %d\n",
> +                       reply_q->name,
> +                       ioc->msix_enable ? "PCI-MSI-X" : "IO-APIC",
> +                       pci_irq_vector(ioc->pdev, reply_q->msix_index));
>
>         ioc_info(ioc, "iomem(%pap), mapped(0x%p), size(%d)\n",
>                  &chip_phys, ioc->chip, memap_sz);
> --
> 2.15.0
>
