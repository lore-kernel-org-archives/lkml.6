Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04560C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBDF20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B6op/dR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfBEFPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 00:15:53 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:18841 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbfBEFPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 00:15:52 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190205051547epoutp04bfea6601a1f5055385e3a1d63dd800a5~AX_4E7jTG2943629436epoutp04W
        for <linux-kernel@vger.kernel.org>; Tue,  5 Feb 2019 05:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190205051547epoutp04bfea6601a1f5055385e3a1d63dd800a5~AX_4E7jTG2943629436epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549343747;
        bh=BVOcYNPKeP1Jl0zRLWjSm2pEQvjxerc78uNHwSH97oA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B6op/dR9Oxk4dB5qCQI82OaELEiNevlUQ/7pRiwj5Swmq6Ozzb3R5+8J1iTsgz/zs
         C13kpjXHrBJQBzkoDln26GaSasZDNx8rCVgnjAmz+dIUD9GEtqD6Z9tU0xGRAAnKgH
         llbgqTs7V1ws8/pjcZPPkckaL3ofJUnf20nVeaDE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190205051547epcas5p32a86dc052ce1e0c4893a9f28ceea3f75~AX_3qhd6Z1388713887epcas5p3q;
        Tue,  5 Feb 2019 05:15:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.66.04137.30C195C5; Tue,  5 Feb 2019 14:15:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190205051546epcas5p2ac8d9c1a4931de5a4d6aef45bea63458~AX_3UqFE70957409574epcas5p2L;
        Tue,  5 Feb 2019 05:15:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190205051546epsmtrp1aea90073af1ca17f67edd73a5587b1a8~AX_3Te8ZX0299802998epsmtrp1H;
        Tue,  5 Feb 2019 05:15:46 +0000 (GMT)
X-AuditID: b6c32a4a-aefff70000001029-19-5c591c032a08
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.5D.03601.20C195C5; Tue,  5 Feb 2019 14:15:46 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190205051544epsmtip1f107e24d40962e2f2909e3b31a69207f~AX_1YalE21542215422epsmtip1A;
        Tue,  5 Feb 2019 05:15:44 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] Revert
 "scsi: ufs: disable vccq if it's not needed by UFS device"
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
Date:   Tue, 5 Feb 2019 10:28:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuTuzs+Nj5bZanjR7bApZpJUGE5UGRYzlh/wSlZIuOqjprrLj
        o6QPRmni5ivwsbtakilaUSZmvnJN8ZmG4iPTUjMhLFyjLVOirHFW8tv/nPs793/+l0sTigmp
        Cx2tSeC0GlWskrIl69o9PfcSW86H7NPrbZiVHh9mbnmEYl6ZzCRT8HWZYL6UZiGmv+IlxaRN
        FUqY4Y+RTJ6pX8YMNRZTjO5NPcXUWfoJ5kbnD5IZK2ugjjmwQ8OnWWPqIMkOZWdJ2JzHFin7
        brSZYmtNFsRaarayN1t1kjP0BdsjEVxsdBKn9fYLs40qmewk440el29OSVORzi0T2dCAfWG6
        qFqSiWxpBW5C0DLw1lp8Q5BTaZSJxSKC3qcrsrWRhcIMK/UCQZlOLxWLeQTdVa2EQDniUMh9
        MPKPomknnAw/23YJDIEbCJi4vUAKDIX3wPvCWomg5dgPPnXdlwqaxO6wnKtbvWcjPgftWWYk
        MhugRz+7OmuDD0NVRi8laAI7w/jsXYmot8Hz+WJCMAN8Twathl4krn0CmkYHpaJ2hM9dtdY4
        LjCXky4TFgUcA7cafcT2VSi/00mK2h9ah4tJASGwJzxp9BatHCDr16xEnJRDRrpCpD3gunnE
        OukKeTqd1ZSFl+2DlPhUJgQZA2nSXLTdsC6ZYV0aw7o0hv/OpYh8gDZz8bw6kuMPxh/QcMle
        vErNJ2oivcLj1DVo9cvtPlWPKl4HtiFMI6W9fMn3XIhCqkrir6jbENCE0kne8PtfSx6hupLC
        aeNCtYmxHN+GXGlS6SwvcSsJVuBIVQIXw3HxnHbtVELbuKSi3I5gJtT12nxitXpcf5TPDzM6
        xAThSo/k/R93pM/YBXkUGZoDxixNGn/Ob9rc69md0/n5DtGREnG2u6UvoCgwYEf42Z3ui1pD
        17TR3u1RRJfp06DvQk3d90Mz1QNJ2X+M5e0fLqEzSyl9xw3v7cz52rHQi5sWnp6sfPbQebKs
        QKYk+SjV/t2Ellf9BY2ffvhuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSnC6TTGSMwcsGQ4v/J40tXv68ymZx
        ev87FotpH34yW7xe0MtocXbZQTaL1vvTmSyuPE63mLj/LLvF5V1z2Cy6r+9gs9j2+SyzRcux
        rywWNxbvZHPg87h8xdtjdsNFFo/Lfb1MHv3rPrN63Lm2h81jy/7PjB6fN8l5tB/oZgrgiOKy
        SUnNySxLLdK3S+DKmHvvGEvBbNWK9vusDYzdsl2MnBwSAiYS76d3MHUxcnEICexmlFg5eTcz
        REJa4vrGCewQtrDEyn/P2SGKXjNKvDu/hBUkISwQL9HXdArMFhEolzjX+pYNxGYW2Mkscfhb
        AogtJLCfUeJfSzSIzSagLXF3+hYmEJtXwE7i+XGIOSwCKhI/J3SDLRYViJD4+HQfVI2gxMmZ
        T1hAbE4Ba4mVHaeg5ptJzNv8kBnCFpe49WQ+E4QtL7H97RzmCYxCs5C0z0LSMgtJyywkLQsY
        WVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHpJbWDsYTJ+IPMQpwMCrx8P4wiYgR
        Yk0sK67MPcQowcGsJMK78y9QiDclsbIqtSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTU
        gtQimCwTB6dUA6Pd3fW7q786p+pcll+2xOXruo3v9lu4TLh5f/LqF1db8y+dVa3e7uWZuvab
        1vvsR7JbqvfezlwSwCjMdXn5ndNTMyZe/rSc3cSpUCEuxNlCraHb/9OET1s/H2+8vv7IOi+b
        9wU/vOUf6nnEXTzKq9exryDr+Ykim7RPhqvzM822HM2fMW2P8T0FJZbijERDLeai4kQAPuer
        GcUCAAA=
X-CMS-MailID: 20190205051546epcas5p2ac8d9c1a4931de5a4d6aef45bea63458
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
        <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
        <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 04/02/19 11:12 PM, Marc Gonzalez wrote:
> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
> 
> Calling ufshcd_set_vccq_rail_unused hangs my system.
> It seems vccq is not *not* needed.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---

AFAIK Samsung and Toshiba UFS devices does not use VCCQ (this pin is 
either floating or connected to Ground, at least on the devices that I 
have worked on).
You said your system hanged, I believe you have set UFS_DEVICE_NO_VCCQ 
quirks, in that case VCCQ regulator should having been disabled.
So you mean your system hanged because vccq regulator got disabled?

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
