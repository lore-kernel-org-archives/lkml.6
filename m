Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60B420840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a3f2a0VB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390584AbfAPIxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:53:01 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51386 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbfAPIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:53:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G8qqxs126088;
        Wed, 16 Jan 2019 02:52:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547628772;
        bh=k45dxeaNU4bwgfHrBVVuc11ANNgSitIi283yd3AkUZo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a3f2a0VBfq/TvoeARZcO81wZZoQ9BWsnOKI/vqRkXPgsDNtZQYkX2g8WFBQ/Npa/y
         dI2JxF93z5qQZD8g0npZXov/QURGAySQD5CBP3jWQaSPQLINs+GWURh41+MNVBsCnR
         MdAa8fu5tE+Jr3IUZ4hd1YQ6HhwFN5/pJY09Z/io=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G8qqe5040685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 02:52:52 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:52:52 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:52:52 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8qmaL024113;
        Wed, 16 Jan 2019 02:52:49 -0600
Subject: Re: [PATCH v1 5/8] scsi: ufs: qcom: Expose the reset controller for
 PHY
To:     Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
 <20190111230129.127037-6-evgreen@chromium.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a289d841-858d-5583-ce9a-8dc0f2d18a78@ti.com>
Date:   Wed, 16 Jan 2019 14:22:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111230129.127037-6-evgreen@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/19 4:31 AM, Evan Green wrote:
> Expose a reset controller that the phy can use to perform its
> initialization in a single callback.
> 
> Also, change the use of the phy functions from ufs-qcom such that
> phy_poweron actually fires up the phy, and phy_poweroff actually
> powers it down.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Can I get Ack for this patch from SCSI MAINTAINERS?

Thanks
Kishon

> 
> ---
> Note: This change depends on the remaining changes in this series,
> since UFS PHY reset now needs to be done by the PHY driver.
> 
>  drivers/scsi/ufs/Kconfig    |   1 +
>  drivers/scsi/ufs/ufs-qcom.c | 110 +++++++++++++++++++++---------------
>  drivers/scsi/ufs/ufs-qcom.h |   4 ++
>  3 files changed, 71 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index 2ddbb26d9c265..63c5c4115981f 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -100,6 +100,7 @@ config SCSI_UFS_QCOM
>  	tristate "QCOM specific hooks to UFS controller platform driver"
>  	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
>  	select PHY_QCOM_UFS
> +	select RESET_CONTROLLER
>  	help
>  	  This selects the QCOM specific additions to UFSHCD platform driver.
>  	  UFS host on QCOM needs some vendor specific configuration before
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 3aeadb14aae1e..db46f9a64b54c 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/reset.h>
>  
>  #include "ufshcd.h"
>  #include "ufshcd-pltfrm.h"
> @@ -49,6 +50,11 @@ static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>  static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>  						       u32 clk_cycles);
>  
> +static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
> +{
> +	return container_of(rcd, struct ufs_qcom_host, rcdev);
> +}
> +
>  static void ufs_qcom_dump_regs_wrapper(struct ufs_hba *hba, int offset, int len,
>  				       const char *prefix, void *priv)
>  {
> @@ -255,11 +261,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  	if (is_rate_B)
>  		phy_set_mode(phy, PHY_MODE_UFS_HS_B);
>  
> -	/* Assert PHY reset and apply PHY calibration values */
> -	ufs_qcom_assert_reset(hba);
> -	/* provide 1ms delay to let the reset pulse propagate */
> -	usleep_range(1000, 1100);
> -
>  	/* phy initialization - calibrate the phy */
>  	ret = phy_init(phy);
>  	if (ret) {
> @@ -268,15 +269,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  		goto out;
>  	}
>  
> -	/* De-assert PHY reset and start serdes */
> -	ufs_qcom_deassert_reset(hba);
> -
> -	/*
> -	 * after reset deassertion, phy will need all ref clocks,
> -	 * voltage, current to settle down before starting serdes.
> -	 */
> -	usleep_range(1000, 1100);
> -
>  	/* power on phy - start serdes and phy's power and clocks */
>  	ret = phy_power_on(phy);
>  	if (ret) {
> @@ -290,7 +282,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  	return 0;
>  
>  out_disable_phy:
> -	ufs_qcom_assert_reset(hba);
>  	phy_exit(phy);
>  out:
>  	return ret;
> @@ -554,21 +545,10 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  		ufs_qcom_disable_lane_clks(host);
>  		phy_power_off(phy);
>  
> -		/* Assert PHY soft reset */
> -		ufs_qcom_assert_reset(hba);
> -		goto out;
> -	}
> -
> -	/*
> -	 * If UniPro link is not active, PHY ref_clk, main PHY analog power
> -	 * rail and low noise analog power rail for PLL can be switched off.
> -	 */
> -	if (!ufs_qcom_is_link_active(hba)) {
> +	} else if (!ufs_qcom_is_link_active(hba)) {
>  		ufs_qcom_disable_lane_clks(host);
> -		phy_power_off(phy);
>  	}
>  
> -out:
>  	return ret;
>  }
>  
> @@ -578,21 +558,26 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  	struct phy *phy = host->generic_phy;
>  	int err;
>  
> -	err = phy_power_on(phy);
> -	if (err) {
> -		dev_err(hba->dev, "%s: failed enabling regs, err = %d\n",
> -			__func__, err);
> -		goto out;
> -	}
> +	if (ufs_qcom_is_link_off(hba)) {
> +		err = phy_power_on(phy);
> +		if (err) {
> +			dev_err(hba->dev, "%s: failed enabling regs, err = %d\n",
> +				__func__, err);
> +			return err;
> +		}
>  
> -	err = ufs_qcom_enable_lane_clks(host);
> -	if (err)
> -		goto out;
> +		err = ufs_qcom_enable_lane_clks(host);
> +		if (err)
> +			return err;
>  
> -	hba->is_sys_suspended = false;
> +	} else if (!ufs_qcom_is_link_active(hba)) {
> +		err = ufs_qcom_enable_lane_clks(host);
> +		if (err)
> +			return err;
> +	}
>  
> -out:
> -	return err;
> +	hba->is_sys_suspended = false;
> +	return 0;
>  }
>  
>  struct ufs_qcom_dev_params {
> @@ -1118,8 +1103,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  		return 0;
>  
>  	if (on && (status == POST_CHANGE)) {
> -		phy_power_on(host->generic_phy);
> -
>  		/* enable the device ref clock for HS mode*/
>  		if (ufshcd_is_hs_mode(&hba->pwr_info))
>  			ufs_qcom_dev_ref_clk_ctrl(host, true);
> @@ -1131,9 +1114,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  		if (!ufs_qcom_is_link_active(hba)) {
>  			/* disable device ref_clk */
>  			ufs_qcom_dev_ref_clk_ctrl(host, false);
> -
> -			/* powering off PHY during aggressive clk gating */
> -			phy_power_off(host->generic_phy);
>  		}
>  
>  		vote = host->bus_vote.min_bw_vote;
> @@ -1147,6 +1127,39 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  	return err;
>  }
>  
> +static int
> +ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> +
> +	WARN_ON(id);
> +	ufs_qcom_assert_reset(host->hba);
> +	/* provide 1ms delay to let the reset pulse propagate */
> +	usleep_range(1000, 1100);
> +	return 0;
> +}
> +
> +static int
> +ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> +
> +	WARN_ON(id);
> +	ufs_qcom_deassert_reset(host->hba);
> +
> +	/*
> +	 * after reset deassertion, phy will need all ref clocks,
> +	 * voltage, current to settle down before starting serdes.
> +	 */
> +	usleep_range(1000, 1100);
> +	return 0;
> +}
> +
> +const struct reset_control_ops ufs_qcom_reset_ops = {
> +	.assert = ufs_qcom_reset_assert,
> +	.deassert = ufs_qcom_reset_deassert,
> +};
> +
>  #define	ANDROID_BOOT_DEV_MAX	30
>  static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
>  
> @@ -1191,6 +1204,15 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	host->hba = hba;
>  	ufshcd_set_variant(hba, host);
>  
> +	/* Fire up the reset controller. Failure here is non-fatal. */
> +	host->rcdev.of_node = dev->of_node;
> +	host->rcdev.ops = &ufs_qcom_reset_ops;
> +	host->rcdev.owner = dev->driver->owner;
> +	host->rcdev.nr_resets = 1;
> +	err = devm_reset_controller_register(dev, &host->rcdev);
> +	if (err)
> +		dev_warn(dev, "Failed to register reset controller\n");
> +
>  	/*
>  	 * voting/devoting device ref_clk source is time consuming hence
>  	 * skip devoting it during aggressive clock gating. This clock
> diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
> index c114826316eb0..68a8801857529 100644
> --- a/drivers/scsi/ufs/ufs-qcom.h
> +++ b/drivers/scsi/ufs/ufs-qcom.h
> @@ -14,6 +14,8 @@
>  #ifndef UFS_QCOM_H_
>  #define UFS_QCOM_H_
>  
> +#include <linux/reset-controller.h>
> +
>  #define MAX_UFS_QCOM_HOSTS	1
>  #define MAX_U32                 (~(u32)0)
>  #define MPHY_TX_FSM_STATE       0x41
> @@ -237,6 +239,8 @@ struct ufs_qcom_host {
>  	/* Bitmask for enabling debug prints */
>  	u32 dbg_print_en;
>  	struct ufs_qcom_testbus testbus;
> +
> +	struct reset_controller_dev rcdev;
>  };
>  
>  static inline u32
> 
