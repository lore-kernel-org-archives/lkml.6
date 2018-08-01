Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA7BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71610208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfLFwMWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71610208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbeHALwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:52:49 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41602 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389034AbeHALwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:52:49 -0400
Received: by mail-vk0-f66.google.com with SMTP id o82-v6so9006754vko.8;
        Wed, 01 Aug 2018 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vgxTkOaoM9r8OAuPjMh35kxS51UfUofhltHjomqRTgA=;
        b=sfLFwMWj55pj7ECWM2cXwK7kOOCUtm/0kefCuRwDXpaVUZhNT5KfoEIwboNoE2hYmZ
         qufo76ZJzKAyQDnX/9gVGunQ51xQEXR3j0okhaNylf6XN3LMAAdIpfNXnv2v6zQQF+77
         fB7a8a1BaJ86jwySw009MjtXNKWagYeWA7/btky+8Y/K6g+FLV8/ZseWDOL7GI54EVbb
         2yk1/ydfUASuq6aXJyoWctbGjz7wRnwDre9oErsj2QWE2mcU6LYukdOlD4COIcEZEH6F
         X63Ue3nnnxRU1nkP5l/INT50rZyftMV6Da8w7ETZeTCGc6Np8hXS3VOmn+iVtUNFi8n2
         BSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vgxTkOaoM9r8OAuPjMh35kxS51UfUofhltHjomqRTgA=;
        b=OwF/0UXEB4zAv9kd1rizBrLZF48Zi1HuFpB8mLPQ3AUzRSNGprCoxJ2Ta6nisWhx7I
         EJp68dJP8gocUJa/bi4utLBlxI+TMyoY2zqpifA8n5BO4eMLu66kH3i1r54LVvT+sSDI
         ImIR5kAVxCZj7muRIbZUxfvDAd6jdIOAlWgwaNgJJOyujjXLoPiKGJ7ODva/UJ+6s0Ja
         kJbrzk9VtsBrttK2GRzTjYMdO/gTZZaMA4jp54OHr/JMcQ9chvLdk3cTFc6FLiPfXs3D
         IHAVz8T2ujsWws5wsgvx6sT/oXdkbgl6HxxBp9+MfafdLq/iO/7ePjB+LVxUPUJPoggg
         3ZvQ==
X-Gm-Message-State: AOUpUlEsL36miLzCf0yvht1d4vAoULZV8JD95DwvMu5trZeiH1fAYmB0
        HVqMTmYkqWyzp2fZ7ISkuXz6GgvLP/dzHMC2FSo=
X-Google-Smtp-Source: AAOMgpejl4kGUVkKQxniOZqf8rTRqHfzpuIu+AgOfRueCAJZJNWlXZE7oWU3Z/ourOEr6NMsbWQ3QUg4IMRZik6z85c=
X-Received: by 2002:a1f:5442:: with SMTP id i63-v6mr15500458vkb.153.1533118068723;
 Wed, 01 Aug 2018 03:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 03:07:48 -0700 (PDT)
In-Reply-To: <1533107309-7073-1-git-send-email-zhongjiang@huawei.com>
References: <1533107309-7073-1-git-send-email-zhongjiang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 13:07:48 +0300
Message-ID: <CAHp75Vf=Mfhvq1==F=tXHf+2hA84+jPwHPNmFGmhxq_LrrERHw@mail.gmail.com>
Subject: Re: [PATCH] driver/scsi/pmcraid: Use pci_zalloc_consistent instead of pci_alloc_consistent+memset
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:08 AM, zhong jiang <zhongjiang@huawei.com> wrote:
> Pci_alloc_consistent+memset is better than pci_alloc_consistent+memset,
> and it make the code concise

It should use dma_*alloc_*() functions directly. PCI ones are not for
new code AFAIK.

>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/scsi/pmcraid.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
> index 4e86994..8a6facc 100644
> --- a/drivers/scsi/pmcraid.c
> +++ b/drivers/scsi/pmcraid.c
> @@ -4736,11 +4736,9 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
>         buffer_size = HRRQ_ENTRY_SIZE * PMCRAID_MAX_CMD;
>
>         for (i = 0; i < pinstance->num_hrrq; i++) {
> -               pinstance->hrrq_start[i] =
> -                       pci_alloc_consistent(
> -                                       pinstance->pdev,
> -                                       buffer_size,
> -                                       &(pinstance->hrrq_start_bus_addr[i]));
> +               pinstance->hrrq_start[i] = pci_zalloc_consistent(pinstance->pdev,
> +                                                               buffer_size,
> +                                                               &(pinstance->hrrq_start_bus_addr[i]));
>
>                 if (!pinstance->hrrq_start[i]) {
>                         pmcraid_err("pci_alloc failed for hrrq vector : %d\n",
> @@ -4749,7 +4747,6 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
>                         return -ENOMEM;
>                 }
>
> -               memset(pinstance->hrrq_start[i], 0, buffer_size);
>                 pinstance->hrrq_curr[i] = pinstance->hrrq_start[i];
>                 pinstance->hrrq_end[i] =
>                         pinstance->hrrq_start[i] + PMCRAID_MAX_CMD - 1;
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
