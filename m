Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A70C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53642176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dCLpShDF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eVglANJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfBDSLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:11:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfBDSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:11:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E45260791; Mon,  4 Feb 2019 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303869;
        bh=KfUt4JUFUxnU0KQqxLpwm1YUgcBp655GnmnQBGJWJ6I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dCLpShDF8nAuLxraLUGL+A2HVCm1hNBkZyqDVLp+Gn1kbFG6PCjUgOpIh8pEJC+2+
         5aJ5cz+5H7yswaYpgkbdTSzLf/j9JDxwBFqqKpJpCnhBlgHwfBEUueXv8hcrdgP6Uy
         p8GcIaEiLLCgoZ/os4R9ijNOh3qD6cEW1X9KSTiA=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F31A760734;
        Mon,  4 Feb 2019 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303868;
        bh=KfUt4JUFUxnU0KQqxLpwm1YUgcBp655GnmnQBGJWJ6I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eVglANJwqfkAbq6Ci11HdpTMKhrgnA1ZqTQgNbDslgUFgSaEZdnFeUOu8cgXlnfe9
         oW0T+/CmPefVzvXRNJ4ZErO1XVg5dWB8aHsygPZtmWY3y7GcveLPb0fFh7zXq6RTxd
         8TzOBejChKhws12qHmL3QCZX+W+NxghuG8CXq1QU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F31A760734
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <53ac0ac5-9b98-e9d7-08a6-0cbde1c1edb0@codeaurora.org>
Date:   Mon, 4 Feb 2019 11:11:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2019 10:42 AM, Marc Gonzalez wrote:
> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
> 
> Calling ufshcd_set_vccq_rail_unused hangs my system.
> It seems vccq is not *not* needed.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

>   drivers/scsi/ufs/ufs.h    |  1 -
>   drivers/scsi/ufs/ufshcd.c | 59 +++------------------------------------
>   2 files changed, 4 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index dd65fea07687..7da7318eb6a6 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -514,7 +514,6 @@ struct ufs_vreg {
>   	struct regulator *reg;
>   	const char *name;
>   	bool enabled;
> -	bool unused;
>   	int min_uV;
>   	int max_uV;
>   	int min_uA;
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 9ba7671b84f8..8b9a01073d62 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -245,7 +245,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba);
>   static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>   				 bool skip_ref_clk);
>   static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
> -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused);
>   static int ufshcd_uic_hibern8_exit(struct ufs_hba *hba);
>   static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);
>   static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
> @@ -6819,11 +6818,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>   	ufs_fixup_device_setup(hba, &card);
>   	ufshcd_tune_unipro_params(hba);
>   
> -	ret = ufshcd_set_vccq_rail_unused(hba,
> -		(hba->dev_quirks & UFS_DEVICE_NO_VCCQ) ? true : false);
> -	if (ret)
> -		goto out;
> -
>   	/* UFS device is also active now */
>   	ufshcd_set_ufs_dev_active(hba);
>   	ufshcd_force_reset_auto_bkops(hba);
> @@ -7007,24 +7001,13 @@ static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
>   static inline int ufshcd_config_vreg_lpm(struct ufs_hba *hba,
>   					 struct ufs_vreg *vreg)
>   {
> -	if (!vreg)
> -		return 0;
> -	else if (vreg->unused)
> -		return 0;
> -	else
> -		return ufshcd_config_vreg_load(hba->dev, vreg,
> -					       UFS_VREG_LPM_LOAD_UA);
> +	return ufshcd_config_vreg_load(hba->dev, vreg, UFS_VREG_LPM_LOAD_UA);
>   }
>   
>   static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
>   					 struct ufs_vreg *vreg)
>   {
> -	if (!vreg)
> -		return 0;
> -	else if (vreg->unused)
> -		return 0;
> -	else
> -		return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
> +	return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
>   }
>   
>   static int ufshcd_config_vreg(struct device *dev,
> @@ -7062,9 +7045,7 @@ static int ufshcd_enable_vreg(struct device *dev, struct ufs_vreg *vreg)
>   {
>   	int ret = 0;
>   
> -	if (!vreg)
> -		goto out;
> -	else if (vreg->enabled || vreg->unused)
> +	if (!vreg || vreg->enabled)
>   		goto out;
>   
>   	ret = ufshcd_config_vreg(dev, vreg, true);
> @@ -7084,9 +7065,7 @@ static int ufshcd_disable_vreg(struct device *dev, struct ufs_vreg *vreg)
>   {
>   	int ret = 0;
>   
> -	if (!vreg)
> -		goto out;
> -	else if (!vreg->enabled || vreg->unused)
> +	if (!vreg || !vreg->enabled)
>   		goto out;
>   
>   	ret = regulator_disable(vreg->reg);
> @@ -7192,36 +7171,6 @@ static int ufshcd_init_hba_vreg(struct ufs_hba *hba)
>   	return 0;
>   }
>   
> -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused)
> -{
> -	int ret = 0;
> -	struct ufs_vreg_info *info = &hba->vreg_info;
> -
> -	if (!info)
> -		goto out;
> -	else if (!info->vccq)
> -		goto out;
> -
> -	if (unused) {
> -		/* shut off the rail here */
> -		ret = ufshcd_toggle_vreg(hba->dev, info->vccq, false);
> -		/*
> -		 * Mark this rail as no longer used, so it doesn't get enabled
> -		 * later by mistake
> -		 */
> -		if (!ret)
> -			info->vccq->unused = true;
> -	} else {
> -		/*
> -		 * rail should have been already enabled hence just make sure
> -		 * that unused flag is cleared.
> -		 */
> -		info->vccq->unused = false;
> -	}
> -out:
> -	return ret;
> -}
> -
>   static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>   					bool skip_ref_clk)
>   {
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
