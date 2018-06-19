Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B95C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFDB20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFDB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937695AbeFSLjg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:39:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:35777 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937477AbeFSLje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:39:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 04:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="233765049"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga005.jf.intel.com with ESMTP; 19 Jun 2018 04:39:29 -0700
Subject: Re: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay
 values from DT
To:     Manish Narani <MNARANI@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
 <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
 <SN6PR02MB49595D9202DDF98DA16C495CC17D0@SN6PR02MB4959.namprd02.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6d3b2f29-fe8d-b084-3e1f-631cf20796b9@intel.com>
Date:   Tue, 19 Jun 2018 14:38:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <SN6PR02MB49595D9202DDF98DA16C495CC17D0@SN6PR02MB4959.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 08:38, Manish Narani wrote:
> Ping for RFC

What is eemi?  Why aren't there patches for that?

> 
>> -----Original Message-----
>> From: Manish Narani [mailto:manish.narani@xilinx.com]
>> Sent: Thursday, June 7, 2018 5:42 PM
>> To: robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
>> will.deacon@arm.com; mdf@kernel.org; stefan.krsmanovic@aggios.com;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> mmc@vger.kernel.org; devicetree@vger.kernel.org;
>> adrian.hunter@intel.com; michal.simek@xilinx.com; ulf.hansson@linaro.org
>> Cc: Manish Narani <MNARANI@xilinx.com>
>> Subject: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay values
>> from DT
>>
>> This patch adds support for reading Tap Delay values from Device Tree and
>> write them via eemi calls. The macros containing these tap delay values are
>> removed from the driver.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 131
>> +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 131 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-
>> of-arasan.c
>> index e3332a5..fc0fd01 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -36,6 +36,8 @@
>>
>>  #define PHY_CLK_TOO_SLOW_HZ		400000
>>
>> +#define MMC_BANK2		0x2
>> +
>>  /*
>>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
>> @@ -90,6 +92,10 @@ struct sdhci_arasan_data {
>>  	struct sdhci_host *host;
>>  	struct clk	*clk_ahb;
>>  	struct phy	*phy;
>> +	u32 mio_bank;
>> +	u32 device_id;
>> +	u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
>> +	u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
>>  	bool		is_phy_on;
>>
>>  	bool		has_cqe;
>> @@ -160,11 +166,36 @@ static int sdhci_arasan_syscon_write(struct
>> sdhci_host *host,
>>  	return ret;
>>  }
>>
>> +/**
>> + * arasan_zynqmp_set_tap_delay - Program the tap delays.
>> + * @deviceid:		Unique Id of device
>> + * @itap_delay:		Input Tap Delay
>> + * @oitap_delay:	Output Tap Delay
>> + */
>> +static void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8
>> +otap_delay) {
>> +	const struct zynqmp_eemi_ops *eemi_ops =
>> zynqmp_pm_get_eemi_ops();
>> +	u32 node_id = (deviceid == 0) ? NODE_SD_0 : NODE_SD_1;
>> +
>> +	if (!eemi_ops || !eemi_ops->ioctl)
>> +		return;
>> +
>> +	if (itap_delay)
>> +		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
>> +				PM_TAPDELAY_INPUT, itap_delay, NULL);
>> +
>> +	if (otap_delay)
>> +		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
>> +				PM_TAPDELAY_OUTPUT, otap_delay, NULL);
>> }
>> +
>>  static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int
>> clock)  {
>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>  	struct sdhci_arasan_data *sdhci_arasan =
>> sdhci_pltfm_priv(pltfm_host);
>>  	bool ctrl_phy = false;
>> +	u8 itap_delay;
>> +	u8 otap_delay;
>>
>>  	if (!IS_ERR(sdhci_arasan->phy)) {
>>  		if (!sdhci_arasan->is_phy_on && clock <=
>> PHY_CLK_TOO_SLOW_HZ) { @@ -200,6 +231,16 @@ static void
>> sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>>  		}
>>  	}
>>
>> +	if (host->version >= SDHCI_SPEC_300) {
>> +		if ((host->timing != MMC_TIMING_LEGACY) &&
>> +			(host->timing != MMC_TIMING_UHS_SDR12)) {
>> +			itap_delay = sdhci_arasan->itapdly[host->timing];
>> +			otap_delay = sdhci_arasan->otapdly[host->timing];
>> +			arasan_zynqmp_set_tap_delay(sdhci_arasan-
>>> device_id,
>> +						    itap_delay, otap_delay);
>> +		}
>> +	}
>> +
>>  	if (ctrl_phy && sdhci_arasan->is_phy_on) {
>>  		phy_power_off(sdhci_arasan->phy);
>>  		sdhci_arasan->is_phy_on = false;
>> @@ -456,6 +497,7 @@ static const struct of_device_id
>> sdhci_arasan_of_match[] = {
>>  	{ .compatible = "arasan,sdhci-8.9a" },
>>  	{ .compatible = "arasan,sdhci-5.1" },
>>  	{ .compatible = "arasan,sdhci-4.9a" },
>> +	{ .compatible = "xlnx,zynqmp-8.9a" },
>>
>>  	{ /* sentinel */ }
>>  };
>> @@ -641,6 +683,74 @@ static void sdhci_arasan_unregister_sdclk(struct
>> device *dev)
>>  	of_clk_del_provider(dev->of_node);
>>  }
>>
>> +/**
>> + * arasan_zynqmp_dt_parse_tap_delays - Read Tap Delay values from DT
>> + *
>> + * Called at initialization to parse the values of Tap Delays.
>> + *
>> + * @dev:		Pointer to our struct device.
>> + */
>> +static void arasan_zynqmp_dt_parse_tap_delays(struct device *dev) {
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct sdhci_host *host = platform_get_drvdata(pdev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_arasan_data *sdhci_arasan =
>> sdhci_pltfm_priv(pltfm_host);
>> +	struct device_node *np = dev->of_node;
>> +
>> +	of_property_read_u32(np, "xlnx,itap_delay_sd_hsd",
>> +			     &sdhci_arasan->itapdly[MMC_TIMING_SD_HS]);
>> +	of_property_read_u32(np, "xlnx,otap_delay_sd_hsd",
>> +			     &sdhci_arasan->otapdly[MMC_TIMING_SD_HS]);
>> +	of_property_read_u32(np, "xlnx,itap_delay_sdr25",
>> +			     &sdhci_arasan-
>>> itapdly[MMC_TIMING_UHS_SDR25]);
>> +	of_property_read_u32(np, "xlnx,otap_delay_sdr25",
>> +			     &sdhci_arasan-
>>> otapdly[MMC_TIMING_UHS_SDR25]);
>> +	of_property_read_u32(np, "xlnx,itap_delay_sdr50",
>> +			     &sdhci_arasan-
>>> itapdly[MMC_TIMING_UHS_SDR50]);
>> +	of_property_read_u32(np, "xlnx,otap_delay_sdr50",
>> +			     &sdhci_arasan-
>>> otapdly[MMC_TIMING_UHS_SDR50]);
>> +	of_property_read_u32(np, "xlnx,itap_delay_sd_ddr50",
>> +			     &sdhci_arasan-
>>> itapdly[MMC_TIMING_UHS_DDR50]);
>> +	of_property_read_u32(np, "xlnx,otap_delay_sd_ddr50",
>> +			     &sdhci_arasan-
>>> otapdly[MMC_TIMING_UHS_DDR50]);
>> +	of_property_read_u32(np, "xlnx,itap_delay_mmc_hsd",
>> +			     &sdhci_arasan-
>>> itapdly[MMC_TIMING_MMC_HS]);
>> +	of_property_read_u32(np, "xlnx,otap_delay_mmc_hsd",
>> +			     &sdhci_arasan-
>>> otapdly[MMC_TIMING_MMC_HS]);
>> +	of_property_read_u32(np, "xlnx,itap_delay_mmc_ddr50",
>> +			     &sdhci_arasan-
>>> itapdly[MMC_TIMING_MMC_DDR52]);
>> +	of_property_read_u32(np, "xlnx,otap_delay_mmc_ddr50",
>> +			     &sdhci_arasan-
>>> otapdly[MMC_TIMING_MMC_DDR52]);
>> +	if (sdhci_arasan->mio_bank == MMC_BANK2) {
>> +		of_property_read_u32(np,
>> +				     "xlnx,itap_delay_sdr104_b2",
>> +				&sdhci_arasan-
>>> itapdly[MMC_TIMING_UHS_SDR104]);
>> +		of_property_read_u32(np,
>> +				     "xlnx,otap_delay_sdr104_b2",
>> +				&sdhci_arasan-
>>> otapdly[MMC_TIMING_UHS_SDR104]);
>> +		of_property_read_u32(np,
>> +				     "xlnx,itap_delay_mmc_hs200_b2",
>> +				&sdhci_arasan-
>>> itapdly[MMC_TIMING_MMC_HS200]);
>> +		of_property_read_u32(np,
>> +				     "xlnx,otap_delay_mmc_hs200_b2",
>> +				&sdhci_arasan-
>>> otapdly[MMC_TIMING_MMC_HS200]);
>> +	} else {
>> +		of_property_read_u32(np,
>> +				     "xlnx,itap_delay_sdr104_b0",
>> +				&sdhci_arasan-
>>> itapdly[MMC_TIMING_UHS_SDR104]);
>> +		of_property_read_u32(np,
>> +				     "xlnx,otap_delay_sdr104_b0",
>> +				&sdhci_arasan-
>>> otapdly[MMC_TIMING_UHS_SDR104]);
>> +		of_property_read_u32(np,
>> +				     "xlnx,itap_delay_mmc_hs200_b0",
>> +				&sdhci_arasan-
>>> itapdly[MMC_TIMING_MMC_HS200]);
>> +		of_property_read_u32(np,
>> +				     "xlnx,otap_delay_mmc_hs200_b0",
>> +				&sdhci_arasan-
>>> otapdly[MMC_TIMING_MMC_HS200]);
>> +	}
>> +}
>> +
>>  static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)  {
>>  	struct sdhci_host *host = sdhci_arasan->host; @@ -776,6 +886,27
>> @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>  		goto unreg_clk;
>>  	}
>>
>> +	if (of_device_is_compatible(pdev->dev.of_node,
>> +				    "xlnx,zynqmp-8.9a")) {
>> +		ret = of_property_read_u32(pdev->dev.of_node,
>> +					   "xlnx,mio_bank",
>> +					   &sdhci_arasan->mio_bank);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev,
>> +				"\"xlnx,mio_bank \" property is missing.\n");
>> +			goto clk_disable_all;
>> +		}
>> +		ret = of_property_read_u32(pdev->dev.of_node,
>> +					   "xlnx,device_id",
>> +					   &sdhci_arasan->device_id);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev,
>> +				"\"xlnx,device_id \" property is missing.\n");
>> +			goto clk_disable_all;
>> +		}
>> +		arasan_zynqmp_dt_parse_tap_delays(&pdev->dev);
>> +	}
>> +
>>  	sdhci_arasan->phy = ERR_PTR(-ENODEV);
>>  	if (of_device_is_compatible(pdev->dev.of_node,
>>  				    "arasan,sdhci-5.1")) {
>> --
>> 2.7.4
> 
> 

