Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276D520854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I5mr+9Ah";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EBbV8bCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276D520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeGUA4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:56:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeGUA4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:56:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 43B2B6074D; Sat, 21 Jul 2018 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532131559;
        bh=8pQN6Q79oBbodIwh6irOo/wpzM5/bFYUqOqzN+1sNa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I5mr+9AhGDa9C92fFYx2kL7eMkgDMROvaPLkh9MBHmgv99T6JOuzDOO3n+jnhl16Z
         Q0Zc3TxQ0tEJ5JXxvXQoqrmpA7XE6Re4CcqmZWDAdYXZ6wCAF0aUt435y5Rw6gR9WW
         /ybR/N43qF3k3fyyJIoYidalqcR3WmxiA4VXOYxQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9BFC06063A;
        Sat, 21 Jul 2018 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532131558;
        bh=8pQN6Q79oBbodIwh6irOo/wpzM5/bFYUqOqzN+1sNa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EBbV8bCeVIjQkRV8WZNEaZ8eroSMcTC8MywSEgRM659IlnNbxP5ZSOOx4Qe29Hfw2
         OYm3kj84lQujuFnzCjMtxv2B0NZUR5OM/w508OeBAiNi/dH/HVkVR+hG4CgBA4JVn2
         FXXCxT4DZ3fpXF932K2xHLnDf8fh3p9WgWy6F63s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Jul 2018 17:05:58 -0700
From:   Subhash Jadavani <subhashj@codeaurora.org>
To:     Asutosh Das <asutoshd@codeaurora.org>
Cc:     cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Gilad Broner <gbroner@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi-owner@vger.kernel.org
Subject: Re: [PATCH v1 8/9] scsi: ufs: enable runtime pm only after ufshcd
 init
In-Reply-To: <6f1fd2b0fbfb73d977a1063bda598d8b9b6005b7.1530880007.git.asutoshd@codeaurora.org>
References: <cover.1530880006.git.asutoshd@codeaurora.org>
 <6f1fd2b0fbfb73d977a1063bda598d8b9b6005b7.1530880007.git.asutoshd@codeaurora.org>
Message-ID: <5109aeb8c6db50adc5131ad3ef13ca37@codeaurora.org>
X-Sender: subhashj@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-06 05:30, Asutosh Das wrote:
> From: Gilad Broner <gbroner@codeaurora.org>
> 
> Previous code enables runtime pm before ufshcd_init() is completed,
> and before the hba struct is stored in the platform device private
> data. This means that pm runtime calls will have null hba pointer
> as well as partially initialized driver.
> Instead, enable pm runtime only after ufshcd_init() is done and
> after hba struct is stored in the platform device private data.
> 
> Signed-off-by: Gilad Broner <gbroner@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd-pltfrm.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c 
> b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index 7dba799..8332d99 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -354,24 +354,21 @@ int ufshcd_pltfrm_init(struct platform_device 
> *pdev,
>  	}
> 
>  	ufshcd_parse_pm_levels(hba);
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> 
>  	ufshcd_init_lanes_per_dir(hba);
> 
>  	err = ufshcd_init(hba, mmio_base, irq);
>  	if (err) {
>  		dev_err(dev, "Initialization failed\n");
> -		goto out_disable_rpm;
> +		goto dealloc_host;
>  	}
> 
>  	platform_set_drvdata(pdev, hba);
> 
> -	return 0;
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> 
> -out_disable_rpm:
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
> +	return 0;
>  dealloc_host:
>  	ufshcd_dealloc_host(hba);
>  out:

Looks good to me.
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
