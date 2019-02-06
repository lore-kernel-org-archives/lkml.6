Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C20C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D7D2184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YJas+/qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfBFLnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:43:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59382 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfBFLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:43:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16Bgsu1100619;
        Wed, 6 Feb 2019 05:42:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549453374;
        bh=xLP3PVJDonMm4JsPXozswiKABHdOVloLJaNrE/LI5UE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YJas+/qtVzFicu7LGMlaEXbmR9q1fksT3EyN6cQn3BFfLD5fT+k0lz+Jo0+c7m7oM
         vCeEGTFMHtOObMeBTzPJvXGq/ne267sDPXj14LcY6Jy6osLCUBcEKBHWUWUiapoS5l
         GKeHSgS4WNap7S+UIFmfECfDPff7A8LuSfekFpiY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16Bgsn8013256
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 05:42:54 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:42:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:42:54 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16BgoFO013969;
        Wed, 6 Feb 2019 05:42:50 -0600
Subject: Re: [PATCH v3 6/8] scsi: ufs: qcom: Expose the reset controller for
 PHY
To:     Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
 <20190205185902.106085-7-evgreen@chromium.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <10ea3fe2-e331-0342-cfad-eccce3753d2e@ti.com>
Date:   Wed, 6 Feb 2019 17:12:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205185902.106085-7-evgreen@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/19 12:29 AM, Evan Green wrote:
> Expose a reset controller that the phy will later use to control its
> own PHY reset in the UFS controller. This will enable the combining
> of PHY init functionality into a single function.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

I'd like to get ACK from scsi/ufs/ MAINTAINER Vinayak for me merge it in PHY tree.

Thanks
Kishon
> 
> ---
> Note: The remaining changes in this series need this change, since
> the PHYs now depend on getting the reset controller.
> 
> Changes in v3:
> - Refactor to only expose the reset controller in one change (Stephen).
> - Add period to comment (Stephen).
> - Reset err to 0 in ignored error case (Stephen).
> - Add include of reset-controller.h (Stephen)
> 
> Changes in v2:
> - Remove include of reset.h (Stephen)
> - Fix error print of phy_power_on (Stephen)
> - Comment for reset controller warnings on id != 0 (Stephen)
> - Add static to ufs_qcom_reset_ops (Stephen).
> 
>  drivers/scsi/ufs/Kconfig    |  1 +
>  drivers/scsi/ufs/ufs-qcom.c | 52 +++++++++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufs-qcom.h |  4 +++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index 2ddbb26d9c26..63c5c4115981 100644
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
> index 3aeadb14aae1..ab05ef5cfdcd 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/reset-controller.h>
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
> @@ -1147,6 +1153,41 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  	return err;
>  }
>  
> +static int
> +ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> +
> +	/* Currently this code only knows about a single reset. */
> +	WARN_ON(id);
> +	ufs_qcom_assert_reset(host->hba);
> +	/* provide 1ms delay to let the reset pulse propagate. */
> +	usleep_range(1000, 1100);
> +	return 0;
> +}
> +
> +static int
> +ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> +
> +	/* Currently this code only knows about a single reset. */
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
> +static const struct reset_control_ops ufs_qcom_reset_ops = {
> +	.assert = ufs_qcom_reset_assert,
> +	.deassert = ufs_qcom_reset_deassert,
> +};
> +
>  #define	ANDROID_BOOT_DEV_MAX	30
>  static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
>  
> @@ -1191,6 +1232,17 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  	host->hba = hba;
>  	ufshcd_set_variant(hba, host);
>  
> +	/* Fire up the reset controller. Failure here is non-fatal. */
> +	host->rcdev.of_node = dev->of_node;
> +	host->rcdev.ops = &ufs_qcom_reset_ops;
> +	host->rcdev.owner = dev->driver->owner;
> +	host->rcdev.nr_resets = 1;
> +	err = devm_reset_controller_register(dev, &host->rcdev);
> +	if (err) {
> +		dev_warn(dev, "Failed to register reset controller\n");
> +		err = 0;
> +	}
> +
>  	/*
>  	 * voting/devoting device ref_clk source is time consuming hence
>  	 * skip devoting it during aggressive clock gating. This clock
> diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
> index c114826316eb..68a880185752 100644
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
