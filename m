Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FE720818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FE720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407659AbeKWIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:30:53 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34656 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeKWIax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:30:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id BA8AF28DF2;
        Thu, 22 Nov 2018 16:49:33 -0500 (EST)
Date:   Fri, 23 Nov 2018 08:49:39 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Sasha Levin <sashal@kernel.org>
cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 09/36] scsi: NCR5380: Return false instead
 of NULL
In-Reply-To: <20181122195240.13123-9-sashal@kernel.org>
Message-ID: <alpine.LNX.2.21.1811230849180.305@nippy.intranet>
References: <20181122195240.13123-1-sashal@kernel.org> <20181122195240.13123-9-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is not relevant to any -stable branch. Please don't backport.

-- 

On Thu, 22 Nov 2018, Sasha Levin wrote:

> From: Finn Thain <fthain@telegraphics.com.au>
> 
> [ Upstream commit 96edebd6bb995f2acb7694bed6e01bf6f5a7b634 ]
> 
> I overlooked this statement when I recently converted the function result
> type from struct scsi_cmnd * to bool. No change to object code.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/scsi/NCR5380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index 90ea0f5d9bdb..fbcbd6db371f 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -1190,7 +1190,7 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
>  
>  out:
>  	if (!hostdata->selecting)
> -		return NULL;
> +		return false;
>  	hostdata->selecting = NULL;
>  	return cmd;
>  }
> 
