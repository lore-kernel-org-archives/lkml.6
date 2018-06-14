Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 838BDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DDA208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KDw5Bsqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DDA208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeFNFjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:39:14 -0400
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:10784
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752100AbeFNFjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQxq+rJYZKptnR0pLatKJaLWBfgK4BaGFi1OZ+owFHE=;
 b=KDw5BsqgxH9V7hd0YfwKp1UaIMKra+iGqc7F7wICALWdBOLcuSyO6RWdtMihybzQSQLUnYvScN/DOox9SpvdJt+gZrqNBX65ZK9Acjv6aHg8+yVeajtS1aY4h7wGKdMorT4Sst7Hs7eUPnCuBGYEjBGz2rhgcYcibaLB7CTClKc=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB4509.namprd02.prod.outlook.com (52.135.121.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.20; Thu, 14 Jun 2018 05:39:03 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::5ce3:b22c:d455:b4b3]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::5ce3:b22c:d455:b4b3%3]) with mapi id 15.20.0841.021; Thu, 14 Jun 2018
 05:38:58 +0000
From:   Manish Narani <MNARANI@xilinx.com>
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
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>
Subject: RE: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay
 values from DT
Thread-Topic: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay
 values from DT
Thread-Index: AQHT/ljITFQme7ObgE2kg4lbhDXBJ6RfRu0g
Date:   Thu, 14 Jun 2018 05:38:58 +0000
Message-ID: <SN6PR02MB49595D9202DDF98DA16C495CC17D0@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
 <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4509;7:o/7l+h8eYBIY0gVvVgnIpRJtM3k+UumLGwVX3aWWzRujmR1Sch7ogeOwA/18+/G1UsTfq77a5AVWzQQHmZjnawLi6Q/7iTfk8+2+7CPZgcReJDxQfpKcO0gGPXJeBbKKpGsHE2Wd1PYtSB01O7n4NxIiB+gcJ0XwSowrvFtBzjXy2pvICKLQgSbecCh0XiYnkHEK6Mu7yT7hciDaO2YHdjdslVTX0LtLVCMIEJCL0/SOw15K0hMa1WSkfguNZl6E
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89cc6f91-932a-469f-b1a0-08d5d1b92069
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4509;
x-ms-traffictypediagnostic: SN6PR02MB4509:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-microsoft-antispam-prvs: <SN6PR02MB45091D68C9FC1E5A56ECAC7FC17D0@SN6PR02MB4509.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4509;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4509;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(396003)(346002)(376002)(13464003)(189003)(199004)(6116002)(2906002)(7736002)(97736004)(107886003)(6506007)(53546011)(99286004)(102836004)(54906003)(81166006)(11346002)(446003)(81156014)(8676002)(110136005)(476003)(478600001)(72206003)(4326008)(53936002)(2501003)(3280700002)(305945005)(74316002)(6246003)(5250100002)(5660300001)(9686003)(7416002)(2201001)(3660700001)(3846002)(106356001)(229853002)(105586002)(33656002)(8936002)(55016002)(6436002)(14454004)(2900100001)(316002)(86362001)(76176011)(26005)(486006)(575784001)(25786009)(68736007)(7696005)(66066001)(921003)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4509;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SM1pDecIrnY+rFjJtLyng217NHT1uZpx2bzuhEQdO8/tcCquDW4qCMUACFgoIkxFJNav184Muwr3xwkWjFh8+8QC7jeDX6JZLgjj1BjeT5+uyCWCSb/ZxiojLoYhbdXTYea70G9/eXT8Hq/J/I4NulFYZUS+4kh2Ri/JbF+aO3i/4k4eON324g/R1Ut5mnfx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cc6f91-932a-469f-b1a0-08d5d1b92069
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 05:38:58.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping for RFC

> -----Original Message-----
> From: Manish Narani [mailto:manish.narani@xilinx.com]
> Sent: Thursday, June 7, 2018 5:42 PM
> To: robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> will.deacon@arm.com; mdf@kernel.org; stefan.krsmanovic@aggios.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux=
-
> mmc@vger.kernel.org; devicetree@vger.kernel.org;
> adrian.hunter@intel.com; michal.simek@xilinx.com; ulf.hansson@linaro.org
> Cc: Manish Narani <MNARANI@xilinx.com>
> Subject: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay val=
ues
> from DT
>=20
> This patch adds support for reading Tap Delay values from Device Tree and
> write them via eemi calls. The macros containing these tap delay values a=
re
> removed from the driver.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 131
> +++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-
> of-arasan.c
> index e3332a5..fc0fd01 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -36,6 +36,8 @@
>=20
>  #define PHY_CLK_TOO_SLOW_HZ		400000
>=20
> +#define MMC_BANK2		0x2
> +
>  /*
>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>   * each 32-bit register act as a write mask for the lower 16-bits.  This=
 allows
> @@ -90,6 +92,10 @@ struct sdhci_arasan_data {
>  	struct sdhci_host *host;
>  	struct clk	*clk_ahb;
>  	struct phy	*phy;
> +	u32 mio_bank;
> +	u32 device_id;
> +	u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
> +	u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
>  	bool		is_phy_on;
>=20
>  	bool		has_cqe;
> @@ -160,11 +166,36 @@ static int sdhci_arasan_syscon_write(struct
> sdhci_host *host,
>  	return ret;
>  }
>=20
> +/**
> + * arasan_zynqmp_set_tap_delay - Program the tap delays.
> + * @deviceid:		Unique Id of device
> + * @itap_delay:		Input Tap Delay
> + * @oitap_delay:	Output Tap Delay
> + */
> +static void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8
> +otap_delay) {
> +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> +	u32 node_id =3D (deviceid =3D=3D 0) ? NODE_SD_0 : NODE_SD_1;
> +
> +	if (!eemi_ops || !eemi_ops->ioctl)
> +		return;
> +
> +	if (itap_delay)
> +		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +				PM_TAPDELAY_INPUT, itap_delay, NULL);
> +
> +	if (otap_delay)
> +		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +				PM_TAPDELAY_OUTPUT, otap_delay, NULL);
> }
> +
>  static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int
> clock)  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>  	struct sdhci_arasan_data *sdhci_arasan =3D
> sdhci_pltfm_priv(pltfm_host);
>  	bool ctrl_phy =3D false;
> +	u8 itap_delay;
> +	u8 otap_delay;
>=20
>  	if (!IS_ERR(sdhci_arasan->phy)) {
>  		if (!sdhci_arasan->is_phy_on && clock <=3D
> PHY_CLK_TOO_SLOW_HZ) { @@ -200,6 +231,16 @@ static void
> sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  		}
>  	}
>=20
> +	if (host->version >=3D SDHCI_SPEC_300) {
> +		if ((host->timing !=3D MMC_TIMING_LEGACY) &&
> +			(host->timing !=3D MMC_TIMING_UHS_SDR12)) {
> +			itap_delay =3D sdhci_arasan->itapdly[host->timing];
> +			otap_delay =3D sdhci_arasan->otapdly[host->timing];
> +			arasan_zynqmp_set_tap_delay(sdhci_arasan-
> >device_id,
> +						    itap_delay, otap_delay);
> +		}
> +	}
> +
>  	if (ctrl_phy && sdhci_arasan->is_phy_on) {
>  		phy_power_off(sdhci_arasan->phy);
>  		sdhci_arasan->is_phy_on =3D false;
> @@ -456,6 +497,7 @@ static const struct of_device_id
> sdhci_arasan_of_match[] =3D {
>  	{ .compatible =3D "arasan,sdhci-8.9a" },
>  	{ .compatible =3D "arasan,sdhci-5.1" },
>  	{ .compatible =3D "arasan,sdhci-4.9a" },
> +	{ .compatible =3D "xlnx,zynqmp-8.9a" },
>=20
>  	{ /* sentinel */ }
>  };
> @@ -641,6 +683,74 @@ static void sdhci_arasan_unregister_sdclk(struct
> device *dev)
>  	of_clk_del_provider(dev->of_node);
>  }
>=20
> +/**
> + * arasan_zynqmp_dt_parse_tap_delays - Read Tap Delay values from DT
> + *
> + * Called at initialization to parse the values of Tap Delays.
> + *
> + * @dev:		Pointer to our struct device.
> + */
> +static void arasan_zynqmp_dt_parse_tap_delays(struct device *dev) {
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D
> sdhci_pltfm_priv(pltfm_host);
> +	struct device_node *np =3D dev->of_node;
> +
> +	of_property_read_u32(np, "xlnx,itap_delay_sd_hsd",
> +			     &sdhci_arasan->itapdly[MMC_TIMING_SD_HS]);
> +	of_property_read_u32(np, "xlnx,otap_delay_sd_hsd",
> +			     &sdhci_arasan->otapdly[MMC_TIMING_SD_HS]);
> +	of_property_read_u32(np, "xlnx,itap_delay_sdr25",
> +			     &sdhci_arasan-
> >itapdly[MMC_TIMING_UHS_SDR25]);
> +	of_property_read_u32(np, "xlnx,otap_delay_sdr25",
> +			     &sdhci_arasan-
> >otapdly[MMC_TIMING_UHS_SDR25]);
> +	of_property_read_u32(np, "xlnx,itap_delay_sdr50",
> +			     &sdhci_arasan-
> >itapdly[MMC_TIMING_UHS_SDR50]);
> +	of_property_read_u32(np, "xlnx,otap_delay_sdr50",
> +			     &sdhci_arasan-
> >otapdly[MMC_TIMING_UHS_SDR50]);
> +	of_property_read_u32(np, "xlnx,itap_delay_sd_ddr50",
> +			     &sdhci_arasan-
> >itapdly[MMC_TIMING_UHS_DDR50]);
> +	of_property_read_u32(np, "xlnx,otap_delay_sd_ddr50",
> +			     &sdhci_arasan-
> >otapdly[MMC_TIMING_UHS_DDR50]);
> +	of_property_read_u32(np, "xlnx,itap_delay_mmc_hsd",
> +			     &sdhci_arasan-
> >itapdly[MMC_TIMING_MMC_HS]);
> +	of_property_read_u32(np, "xlnx,otap_delay_mmc_hsd",
> +			     &sdhci_arasan-
> >otapdly[MMC_TIMING_MMC_HS]);
> +	of_property_read_u32(np, "xlnx,itap_delay_mmc_ddr50",
> +			     &sdhci_arasan-
> >itapdly[MMC_TIMING_MMC_DDR52]);
> +	of_property_read_u32(np, "xlnx,otap_delay_mmc_ddr50",
> +			     &sdhci_arasan-
> >otapdly[MMC_TIMING_MMC_DDR52]);
> +	if (sdhci_arasan->mio_bank =3D=3D MMC_BANK2) {
> +		of_property_read_u32(np,
> +				     "xlnx,itap_delay_sdr104_b2",
> +				&sdhci_arasan-
> >itapdly[MMC_TIMING_UHS_SDR104]);
> +		of_property_read_u32(np,
> +				     "xlnx,otap_delay_sdr104_b2",
> +				&sdhci_arasan-
> >otapdly[MMC_TIMING_UHS_SDR104]);
> +		of_property_read_u32(np,
> +				     "xlnx,itap_delay_mmc_hs200_b2",
> +				&sdhci_arasan-
> >itapdly[MMC_TIMING_MMC_HS200]);
> +		of_property_read_u32(np,
> +				     "xlnx,otap_delay_mmc_hs200_b2",
> +				&sdhci_arasan-
> >otapdly[MMC_TIMING_MMC_HS200]);
> +	} else {
> +		of_property_read_u32(np,
> +				     "xlnx,itap_delay_sdr104_b0",
> +				&sdhci_arasan-
> >itapdly[MMC_TIMING_UHS_SDR104]);
> +		of_property_read_u32(np,
> +				     "xlnx,otap_delay_sdr104_b0",
> +				&sdhci_arasan-
> >otapdly[MMC_TIMING_UHS_SDR104]);
> +		of_property_read_u32(np,
> +				     "xlnx,itap_delay_mmc_hs200_b0",
> +				&sdhci_arasan-
> >itapdly[MMC_TIMING_MMC_HS200]);
> +		of_property_read_u32(np,
> +				     "xlnx,otap_delay_mmc_hs200_b0",
> +				&sdhci_arasan-
> >otapdly[MMC_TIMING_MMC_HS200]);
> +	}
> +}
> +
>  static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)=
  {
>  	struct sdhci_host *host =3D sdhci_arasan->host; @@ -776,6 +886,27
> @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto unreg_clk;
>  	}
>=20
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "xlnx,zynqmp-8.9a")) {
> +		ret =3D of_property_read_u32(pdev->dev.of_node,
> +					   "xlnx,mio_bank",
> +					   &sdhci_arasan->mio_bank);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"\"xlnx,mio_bank \" property is missing.\n");
> +			goto clk_disable_all;
> +		}
> +		ret =3D of_property_read_u32(pdev->dev.of_node,
> +					   "xlnx,device_id",
> +					   &sdhci_arasan->device_id);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"\"xlnx,device_id \" property is missing.\n");
> +			goto clk_disable_all;
> +		}
> +		arasan_zynqmp_dt_parse_tap_delays(&pdev->dev);
> +	}
> +
>  	sdhci_arasan->phy =3D ERR_PTR(-ENODEV);
>  	if (of_device_is_compatible(pdev->dev.of_node,
>  				    "arasan,sdhci-5.1")) {
> --
> 2.7.4

