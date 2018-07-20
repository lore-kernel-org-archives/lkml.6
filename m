Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF96ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48D22084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JYa+XnNc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JYa+XnNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48D22084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeGUAmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:42:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeGUAmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:42:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91E9360274; Fri, 20 Jul 2018 23:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532130702;
        bh=kdjpIjxztyui1/JPdYl+iBdjCETDLIgmjpFaFOJSf5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JYa+XnNcQOpi39nC+0zbLyKfngXlvoOpj+Ftc4gCBDOFI+UZ3/Z/muNYBI3VnZLYQ
         7mIkPWVYyqJh4ZT7HsjT23hLj0iw5KMx8XPyQYw62mW857En552gt6+cEp8PVGlU0i
         XMlQ7r+kJkj74GoiAFDFU4lvbpNboqw1ap7ltDIk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EADFA6071B;
        Fri, 20 Jul 2018 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532130702;
        bh=kdjpIjxztyui1/JPdYl+iBdjCETDLIgmjpFaFOJSf5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JYa+XnNcQOpi39nC+0zbLyKfngXlvoOpj+Ftc4gCBDOFI+UZ3/Z/muNYBI3VnZLYQ
         7mIkPWVYyqJh4ZT7HsjT23hLj0iw5KMx8XPyQYw62mW857En552gt6+cEp8PVGlU0i
         XMlQ7r+kJkj74GoiAFDFU4lvbpNboqw1ap7ltDIk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Jul 2018 16:51:41 -0700
From:   Subhash Jadavani <subhashj@codeaurora.org>
To:     Asutosh Das <asutoshd@codeaurora.org>
Cc:     cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org,
        Sujit Reddy Thumma <sthumma@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Gilad Broner <gbroner@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-scsi-owner@vger.kernel.org
Subject: Re: [PATCH v1 3/9] scsi: ufs: Override auto suspend tunables for ufs
In-Reply-To: <6981189193244970a912c8b3f390a00bc37ed14a.1530880006.git.asutoshd@codeaurora.org>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
 <6981189193244970a912c8b3f390a00bc37ed14a.1530880006.git.asutoshd@codeaurora.org>
Message-ID: <0dc1fca230941323aa6c904cc88713e5@codeaurora.org>
X-Sender: subhashj@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-06 05:30, Asutosh Das wrote:
> From: Sujit Reddy Thumma <sthumma@codeaurora.org>
> 
> Override auto suspend tunables for UFS device LUNs during
> initialization so as to efficiently manage background operations
> and the power consumption.
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Gilad Broner <gbroner@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 77e2b3e..b03f3ea 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -89,6 +89,9 @@
>  /* Interrupt aggregation default timeout, unit: 40us */
>  #define INT_AGGR_DEF_TO	0x02
> 
> +/* default value of auto suspend is 3 seconds */
> +#define UFSHCD_AUTO_SUSPEND_DELAY_MS 3000 /* millisecs */
> +
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
>  	({                                                              \
>  		int _ret;                                               \
> @@ -4528,6 +4531,9 @@ static int ufshcd_slave_configure(struct
> scsi_device *sdev)
>  	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
>  	blk_queue_max_segment_size(q, PRDT_DATA_BYTE_COUNT_MAX);
> 
> +	sdev->autosuspend_delay = UFSHCD_AUTO_SUSPEND_DELAY_MS;
> +	sdev->use_rpm_auto = 1;
> +
>  	return 0;
>  }

Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
