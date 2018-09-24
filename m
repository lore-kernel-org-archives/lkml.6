Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BB6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C44208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXAxFOFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C44208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbeIXXWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:22:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41137 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbeIXXWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:22:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so599961pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u302fKFfvjR4Su78UTIHyKLv0/aGktvMw/1By3CXA2M=;
        b=XXAxFOFEZPkFumXPzEAH5ikrlOI9gNDxrArIdlelxO/dqnxfMP8TOWoyptMBk+zsJy
         wlFp3KBZWSePNaDIvNldzFpKvdao1zzRIxXZSN9xf+cvcc5gyG5gzvggZS/MY4euD8cI
         Y/DUTeJTayBGMqtzmm561mPhhuZM0V9SXDdXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u302fKFfvjR4Su78UTIHyKLv0/aGktvMw/1By3CXA2M=;
        b=ug/E4ZzIDLQRepIVHz375FJCeJ45UjMtNscULfXm+GdaCQGRqY+csGXpXJ1QMmrwVx
         6qHT+JObDIRidyRkgUF/ReEheWFVCeuJxthjEKHKdJYFL2YtDg8zZdm/2fFA8uE3UjJH
         0YkkSdsBH7tTjVtSgRut3MoX77D9nI3sArX020/SL6p779jJa+I4Twi5pG4ALi7Qh/pK
         9Nu2z6jCaHWUQqqFLnuCgqzhvzWY0VRJ2BKK1qzatjcJppfXHpyWDxR/vMAW3s/hl1/c
         Fo5qz3QBSHMcxDiH+Ww5K1ZH4EaSWHPYrLVYgNQgtNV2vpGJgHwG9tjNicsQy/8OM2u1
         GQ3w==
X-Gm-Message-State: ABuFfoiyGDG+i3MO0okRV4mtBacQ1VOCPMKTkHkQfOmIo3odaNpRStaQ
        kZ2LH11D2VwuP0znHZeVORIUAA==
X-Google-Smtp-Source: ACcGV60M2UPhE+PdmOG+fTca7SOKJuhEKPAwhC7MoAObKXdBBNd9a/JB4vY7k42lS0eLejpE+dV7CA==
X-Received: by 2002:a63:1c61:: with SMTP id c33-v6mr10339560pgm.109.1537809562443;
        Mon, 24 Sep 2018 10:19:22 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t141-v6sm48810350pgb.27.2018.09.24.10.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:19:21 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:23:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     kishon@ti.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, subhashj@codeaurora.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: qcom-ufs: Remove stale methods that handle ref
 clk
Message-ID: <20180924172342.GK1367@tuxbook-pro>
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
 <20180904101719.18049-2-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904101719.18049-2-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Sep 03:17 PDT 2018, Vivek Gautam wrote:

> Remove ufs_qcom_phy_enable/(disable)_dev_ref_clk() that
> are not being used by any code.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Thanks for the ping Vivek, I didn't spot these when you posted them.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-ufs.c | 50 -------------------------------------
>  include/linux/phy/phy-qcom-ufs.h    | 14 -----------
>  2 files changed, 64 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
> index c5493ea51282..f2979ccad00a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
> @@ -431,56 +431,6 @@ static void ufs_qcom_phy_disable_ref_clk(struct ufs_qcom_phy *phy)
>  	}
>  }
>  
> -#define UFS_REF_CLK_EN	(1 << 5)
> -
> -static void ufs_qcom_phy_dev_ref_clk_ctrl(struct phy *generic_phy, bool enable)
> -{
> -	struct ufs_qcom_phy *phy = get_ufs_qcom_phy(generic_phy);
> -
> -	if (phy->dev_ref_clk_ctrl_mmio &&
> -	    (enable ^ phy->is_dev_ref_clk_enabled)) {
> -		u32 temp = readl_relaxed(phy->dev_ref_clk_ctrl_mmio);
> -
> -		if (enable)
> -			temp |= UFS_REF_CLK_EN;
> -		else
> -			temp &= ~UFS_REF_CLK_EN;
> -
> -		/*
> -		 * If we are here to disable this clock immediately after
> -		 * entering into hibern8, we need to make sure that device
> -		 * ref_clk is active atleast 1us after the hibern8 enter.
> -		 */
> -		if (!enable)
> -			udelay(1);
> -
> -		writel_relaxed(temp, phy->dev_ref_clk_ctrl_mmio);
> -		/* ensure that ref_clk is enabled/disabled before we return */
> -		wmb();
> -		/*
> -		 * If we call hibern8 exit after this, we need to make sure that
> -		 * device ref_clk is stable for atleast 1us before the hibern8
> -		 * exit command.
> -		 */
> -		if (enable)
> -			udelay(1);
> -
> -		phy->is_dev_ref_clk_enabled = enable;
> -	}
> -}
> -
> -void ufs_qcom_phy_enable_dev_ref_clk(struct phy *generic_phy)
> -{
> -	ufs_qcom_phy_dev_ref_clk_ctrl(generic_phy, true);
> -}
> -EXPORT_SYMBOL_GPL(ufs_qcom_phy_enable_dev_ref_clk);
> -
> -void ufs_qcom_phy_disable_dev_ref_clk(struct phy *generic_phy)
> -{
> -	ufs_qcom_phy_dev_ref_clk_ctrl(generic_phy, false);
> -}
> -EXPORT_SYMBOL_GPL(ufs_qcom_phy_disable_dev_ref_clk);
> -
>  /* Turn ON M-PHY RMMI interface clocks */
>  static int ufs_qcom_phy_enable_iface_clk(struct ufs_qcom_phy *phy)
>  {
> diff --git a/include/linux/phy/phy-qcom-ufs.h b/include/linux/phy/phy-qcom-ufs.h
> index 0a2c18a9771d..9dd85071bcce 100644
> --- a/include/linux/phy/phy-qcom-ufs.h
> +++ b/include/linux/phy/phy-qcom-ufs.h
> @@ -17,20 +17,6 @@
>  
>  #include "phy.h"
>  
> -/**
> - * ufs_qcom_phy_enable_dev_ref_clk() - Enable the device
> - * ref clock.
> - * @phy: reference to a generic phy.
> - */
> -void ufs_qcom_phy_enable_dev_ref_clk(struct phy *phy);
> -
> -/**
> - * ufs_qcom_phy_disable_dev_ref_clk() - Disable the device
> - * ref clock.
> - * @phy: reference to a generic phy.
> - */
> -void ufs_qcom_phy_disable_dev_ref_clk(struct phy *phy);
> -
>  int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes);
>  void ufs_qcom_phy_save_controller_version(struct phy *phy,
>  			u8 major, u16 minor, u16 step);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
