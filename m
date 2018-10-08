Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3472C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9E72089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chgqXJcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9E72089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJHXlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:41:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38164 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJHXll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:41:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id g89-v6so14376135lfl.5;
        Mon, 08 Oct 2018 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzEFgDxbvzgsYwd/zX59XlhwyonPFgc4Yd0NVZdOiVw=;
        b=chgqXJcMihQkdDkGVFF3CFuHjwgjKajY7KIWGh9fmKnfRZnTN7dtjfUS1uuLXBsUUu
         tL5aegoB91Sz0cmKkmiE2OskT8MQItoI/PNNRzwGohVwNeDNI1SSjLmCPx+mCMcN4R1V
         7zjC/pIA/os9yOebbT6RadQB1lvXJwEhJtUWKKH94cm9YuOSMGj6AhYs+GSuKKA0saLI
         Fo9pc66C7dFBgKM2Sv7Es3L9X2VurTNru6ZrviCgM+NEsmt6kMo9lo1QQzyBeg0OCeL2
         g3C13brezRTsr0eOcYdLb7OMt1oFvee9i66Qz+V/j1yj5R6DDprTub5tlWBm0w4M4png
         rccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzEFgDxbvzgsYwd/zX59XlhwyonPFgc4Yd0NVZdOiVw=;
        b=Iv+UJ0d1konAcsSf1/VFuFOB+bSh74roXKQKYGzK5LFJi/yeSkytwVbwyie5tmYDA0
         gDBLbUOnMXUBI9BJJqDl4jcfuEg/0gS5vxB3tLxCh+IbfU+hXjIefLand3lRHSAzrCPz
         GXIy6g/TtvJSCTh5Y/Qgk7/UIKCYTzmlTPrSUNG24n+eYFIujdU1zLryrqOkaDW+TCdj
         WvgcdSW8A0gtr7D3uZKz1Kw1OpxtoWmXY7SaRaENLp7k3KHFOapiZB98WLDDzSO/woHs
         JJ9IZeg58p4lCBrjSBb+uHHJLEXEWM8YY4yEXMQgQV5g0w1XWceNf9j5u0TDxds+wHtD
         8bdA==
X-Gm-Message-State: ABuFfogj0kezFBEFM8/f+nJXVl4BH8QxuB6w++TrLM1zQsk0GEJoFwVF
        MQGUlL5ub+1zyVK04TtArczl1zlbwcZ48k4XzsM=
X-Google-Smtp-Source: ACcGV60B98aN3kpCMZ7RMEC00/+3WmaSd6zZNTJB4uQu3uQjxnmh6Fq/aND7f4/Z/WzxiizKmJQgGbxuHvdb4D1wiPY=
X-Received: by 2002:a19:e44b:: with SMTP id b72-v6mr13626632lfh.77.1539016148802;
 Mon, 08 Oct 2018 09:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181002052631.GA2853@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181002052631.GA2853@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 8 Oct 2018 21:58:56 +0530
Message-ID: <CAFqt6zbnVTc2EHQR7Bc8LJjix+23o9k5_qYbJfiWmL3tz5+6=g@mail.gmail.com>
Subject: Re: [PATCH] scsi/pmcraid.c: Use dma_pool_zalloc
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 10:53 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Replaced dma_pool_alloc + memset with dma_pool_zalloc.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  drivers/scsi/pmcraid.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
> index 4e86994..84a2734 100644
> --- a/drivers/scsi/pmcraid.c
> +++ b/drivers/scsi/pmcraid.c
> @@ -4681,7 +4681,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
>
>         for (i = 0; i < PMCRAID_MAX_CMD; i++) {
>                 pinstance->cmd_list[i]->ioa_cb =
> -                       dma_pool_alloc(
> +                       dma_pool_zalloc(
>                                 pinstance->control_pool,
>                                 GFP_KERNEL,
>                                 &(pinstance->cmd_list[i]->ioa_cb_bus_addr));
> @@ -4690,8 +4690,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
>                         pmcraid_release_control_blocks(pinstance, i);
>                         return -ENOMEM;
>                 }
> -               memset(pinstance->cmd_list[i]->ioa_cb, 0,
> -                       sizeof(struct pmcraid_control_block));
>         }
>         return 0;
>  }
> --
> 1.9.1
>
