Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeCTNMN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:12:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25237 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbeCTNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:12:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,335,1517846400";
   d="scan'208";a="74053415"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Szymon Mielczarek <szymonx.mielczarek@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: RE: [PATCH V3 1/1] scsi: ufs: Add support for Auto-Hibernate Idle
 Timer
Thread-Topic: [PATCH V3 1/1] scsi: ufs: Add support for Auto-Hibernate Idle
 Timer
Thread-Index: AQHTwEyf6/ox3b0bCE6eB0oySVuM9KPZGTog
Date: Tue, 20 Mar 2018 13:12:06 +0000
Message-ID: <MWHPR04MB1137BAC16378A1CE7BBD9B679AAB0@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <1521551258-4027-1-git-send-email-adrian.hunter@intel.com>
 <1521551258-4027-2-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1521551258-4027-2-git-send-email-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0542;7:2OnnEm+Cge98rz5YGin18LjeBVGapHgEO2PfrIccPkbs4TActPFpwVOCAWBUwIB8j8Ol1mxWWVzMWVyAkPiydSaDRlhabDAuDui6f9pknOXp3QOjrm5525VCOeEJBkA/Z/DDjhGC17I6GSDsBOOZpx1fSo6n5DP4pJ9EyL9cyP7iY/iEG0OcjeTSkqYuASxHhUlIBKrgX1KAM/dGEy9C8uhplneJO9+CduyABbKAVW0Ew/y8no7ioRMRuhxEayi4;20:nSkFbl5Toq4ZtPqHosJMEqXfesSv4bo51iWoHEPPj7rwp0gsHFw3fiCuPWM6EFJTlDVgglTMdgwHcXvgfkXNr9qo6djMSKBlD+Z3zgINkzPuxlyuq8xFVTjILiPQ8AatT0qHpDqJHj99SICcIvTeiWAO8UfAkRTbDzlzpdN5ZjM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffd1a7b7-c279-48d2-17d6-08d58e642e8e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0542;
x-ms-traffictypediagnostic: MWHPR04MB0542:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB05424D499B4A6CC6D18B05939AAB0@MWHPR04MB0542.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0542;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0542;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(39380400002)(50944005)(199004)(189003)(13464003)(186003)(5660300001)(68736007)(3280700002)(9686003)(229853002)(72206003)(6246003)(305945005)(2950100002)(4326008)(74316002)(53936002)(105586002)(39060400002)(7736002)(102836004)(575784001)(478600001)(8676002)(3846002)(26005)(3660700001)(86362001)(97736004)(81156014)(81166006)(316002)(2900100001)(106356001)(25786009)(7416002)(59450400001)(7696005)(5250100002)(6436002)(66066001)(6116002)(110136005)(33656002)(76176011)(2906002)(55016002)(6506007)(53546011)(54906003)(14454004)(99286004)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0542;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cAbjhy3LZ/Kp/28XdolO6MVmOepvRO/zvZTADs4IiFzJUULjYCKbf+Rm5MYF75nFn3ye5I+Ldcq7g06Te4i1Lb8iqQsFsYVBOiC/MrNlCs7ZlGfzgUghATBzQrdlPSkb/78l+DiwbLek2HngyW3/BD2578fjGt2oi8/Sn+NpjYXpvWABFTKLwjYKsKWUVigEPOBX4WRrFwq2iu8aYAgELuNqML1pMlTYmtefxg26HLnsm4DD5ak300X3WsTtW7dxJtaowoy4kav4oVtmhbiYfvdcmkXcV3rAWFBeH3TglPOTN504mNsVDpKA+cNGmms6blRSmo59H/EMLMRFqZwN0g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd1a7b7-c279-48d2-17d6-08d58e642e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 13:12:07.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0542
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2KDCK17012968



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Tuesday, March 20, 2018 3:08 PM
> To: Vinayak Holikatti <vinholikatti@gmail.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; James E.J. Bottomley
> <jejb@linux.vnet.ibm.com>
> Cc: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>; Jaegeuk Kim
> <jaegeuk@kernel.org>; Bart Van Assche <Bart.VanAssche@wdc.com>; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Szymon Mielczarek
> <szymonx.mielczarek@intel.com>; Alim Akhtar
> <alim.akhtar@samsung.com>; Alex Lemberg <Alex.Lemberg@wdc.com>;
> Vivek Gautam <vivek.gautam@codeaurora.org>
> Subject: [PATCH V3 1/1] scsi: ufs: Add support for Auto-Hibernate Idle Timer
> 
> UFS host controllers may support an autonomous power management
> feature called the Auto-Hibernate Idle Timer. The timer is set to the number
> of microseconds of idle time before the UFS host controller will
> autonomously put the link into Hibernate state. That will save power at the
> expense of increased latency. Any access to the host controller interface
> registers will automatically put the link out of Hibernate state. So once
> configured, the feature is transparent to the driver.
> 
> Expose the Auto-Hibernate Idle Timer value via SysFS to allow users to
> choose between power efficiency or lower latency. Set a default value of
> 150 ms.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-ufs | 14 ++++++
>  drivers/scsi/ufs/ufs-sysfs.c               | 76
> ++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.c                  | 26 ++++++++++
>  drivers/scsi/ufs/ufshcd.h                  |  3 ++
>  drivers/scsi/ufs/ufshci.h                  |  7 +++
>  5 files changed, 126 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs
> b/Documentation/ABI/testing/sysfs-driver-ufs
> index 83735f79e572..016724ec26d5 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1,3 +1,17 @@
> +What:		/sys/bus/*/drivers/ufshcd/*/auto_hibern8
> +Date:		March 2018
> +Contact:	linux-scsi@vger.kernel.org
> +Description:
> +		This file contains the auto-hibernate idle timer setting of a
> +		UFS host controller. A value of '0' means auto-hibernate is
> not
> +		enabled. Otherwise the value is the number of microseconds
> of
> +		idle time before the UFS host controller will autonomously
> put
> +		the link into hibernate state. That will save power at the
> +		expense of increased latency. Note that the hardware
> supports
> +		10-bit values with a power-of-ten multiplier which allows a
> +		maximum value of 102300000. Refer to the UFS Host
> Controller
> +		Interface specification for more details.
> +
>  What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_type
>  Date:		February 2018
>  Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c index
> 4ff9e0b7eba1..8d9332bb7d0c 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -3,6 +3,7 @@
> 
>  #include <linux/err.h>
>  #include <linux/string.h>
> +#include <linux/bitfield.h>
>  #include <asm/unaligned.h>
> 
>  #include "ufs.h"
> @@ -117,12 +118,86 @@ static ssize_t spm_target_link_state_show(struct
> device *dev,
>  				ufs_pm_lvl_states[hba-
> >spm_lvl].link_state));
>  }
> 
> +static void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit) {
> +	unsigned long flags;
> +
> +	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT))
> +		return;
> +
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	if (hba->ahit == ahit)
> +		goto out_unlock;
> +	hba->ahit = ahit;
> +	if (!pm_runtime_suspended(hba->dev))
> +		ufshcd_writel(hba, hba->ahit,
> REG_AUTO_HIBERNATE_IDLE_TIMER);
> +out_unlock:
> +	spin_unlock_irqrestore(hba->host->host_lock, flags); }
> +
> +/* Convert Auto-Hibernate Idle Timer register value to microseconds */
> +static int ufshcd_ahit_to_us(u32 ahit) {
> +	int timer = FIELD_GET(UFSHCI_AHIBERN8_TIMER_MASK, ahit);
> +	int scale = FIELD_GET(UFSHCI_AHIBERN8_SCALE_MASK, ahit);
> +
> +	for (; scale > 0; --scale)
> +		timer *= UFSHCI_AHIBERN8_SCALE_FACTOR;
> +
> +	return timer;
> +}
> +
> +/* Convert microseconds to Auto-Hibernate Idle Timer register value */
> +static u32 ufshcd_us_to_ahit(unsigned int timer) {
> +	unsigned int scale;
> +
> +	for (scale = 0; timer > UFSHCI_AHIBERN8_TIMER_MASK; ++scale)
> +		timer /= UFSHCI_AHIBERN8_SCALE_FACTOR;
> +
> +	return FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK, timer) |
> +	       FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, scale); }
> +
> +static ssize_t auto_hibern8_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf) {
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT))
> +		return -EOPNOTSUPP;
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", ufshcd_ahit_to_us(hba-
> >ahit));
> +}
> +
> +static ssize_t auto_hibern8_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	unsigned int timer;
> +
> +	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT))
> +		return -EOPNOTSUPP;
> +
> +	if (kstrtouint(buf, 0, &timer))
> +		return -EINVAL;
> +
> +	if (timer > UFSHCI_AHIBERN8_MAX)
> +		return -EINVAL;
> +
> +	ufshcd_auto_hibern8_update(hba, ufshcd_us_to_ahit(timer));
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RW(rpm_lvl);
>  static DEVICE_ATTR_RO(rpm_target_dev_state);
>  static DEVICE_ATTR_RO(rpm_target_link_state);
>  static DEVICE_ATTR_RW(spm_lvl);
>  static DEVICE_ATTR_RO(spm_target_dev_state);
>  static DEVICE_ATTR_RO(spm_target_link_state);
> +static DEVICE_ATTR_RW(auto_hibern8);
> 
>  static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
>  	&dev_attr_rpm_lvl.attr,
> @@ -131,6 +206,7 @@ static ssize_t spm_target_link_state_show(struct
> device *dev,
>  	&dev_attr_spm_lvl.attr,
>  	&dev_attr_spm_target_dev_state.attr,
>  	&dev_attr_spm_target_link_state.attr,
> +	&dev_attr_auto_hibern8.attr,
>  	NULL
>  };
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 3abcd31646eb..facee2b97926 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -41,6 +41,7 @@
>  #include <linux/devfreq.h>
>  #include <linux/nls.h>
>  #include <linux/of.h>
> +#include <linux/bitfield.h>
>  #include "ufshcd.h"
>  #include "ufs_quirks.h"
>  #include "unipro.h"
> @@ -3708,6 +3709,18 @@ static int ufshcd_uic_hibern8_exit(struct ufs_hba
> *hba)
>  	return ret;
>  }
> 
> +static void ufshcd_auto_hibern8_enable(struct ufs_hba *hba) {
> +	unsigned long flags;
> +
> +	if (!(hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) || !hba-
> >ahit)
> +		return;
> +
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	ufshcd_writel(hba, hba->ahit, REG_AUTO_HIBERNATE_IDLE_TIMER);
> +	spin_unlock_irqrestore(hba->host->host_lock, flags); }
> +
>   /**
>   * ufshcd_init_pwr_info - setting the POR (power on reset)
>   * values in hba power info
> @@ -6307,6 +6320,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>  	/* UniPro link is active now */
>  	ufshcd_set_link_active(hba);
> 
> +	/* Enable Auto-Hibernate if configured */
> +	ufshcd_auto_hibern8_enable(hba);
> +
>  	ret = ufshcd_verify_dev_init(hba);
>  	if (ret)
>  		goto out;
> @@ -7391,6 +7407,10 @@ static int ufshcd_resume(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
> 
>  	/* Schedule clock gating in case of no access to UFS device yet */
>  	ufshcd_release(hba);
> +
> +	/* Enable Auto-Hibernate if configured */
> +	ufshcd_auto_hibern8_enable(hba);
> +
>  	goto out;
> 
>  set_old_link_state:
> @@ -7834,6 +7854,12 @@ int ufshcd_init(struct ufs_hba *hba, void
> __iomem *mmio_base, unsigned int irq)
>  						UFS_SLEEP_PWR_MODE,
>  						UIC_LINK_HIBERN8_STATE);
> 
> +	/* Set the default auto-hiberate idle timer value to 150 ms */
> +	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) {
> +		hba->ahit = FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK,
> 150) |
> +			    FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, 3);
> +	}
> +
>  	/* Hold auto suspend until async scan completes */
>  	pm_runtime_get_sync(dev);
> 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h index
> deb3c5d382e9..8110dcd04d22 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -531,6 +531,9 @@ struct ufs_hba {
>  	struct device_attribute spm_lvl_attr;
>  	int pm_op_in_progress;
> 
> +	/* Auto-Hibernate Idle Timer register value */
> +	u32 ahit;
> +
>  	struct ufshcd_lrb *lrb;
>  	unsigned long lrb_in_use;
> 
> diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h index
> 1a1b5d9fe514..bb5d9c7f3353 100644
> --- a/drivers/scsi/ufs/ufshci.h
> +++ b/drivers/scsi/ufs/ufshci.h
> @@ -86,6 +86,7 @@ enum {
>  enum {
>  	MASK_TRANSFER_REQUESTS_SLOTS		= 0x0000001F,
>  	MASK_TASK_MANAGEMENT_REQUEST_SLOTS	= 0x00070000,
> +	MASK_AUTO_HIBERN8_SUPPORT		= 0x00800000,
>  	MASK_64_ADDRESSING_SUPPORT		= 0x01000000,
>  	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
>  	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
> @@ -119,6 +120,12 @@ enum {
>  #define MANUFACTURE_ID_MASK	UFS_MASK(0xFFFF, 0)
>  #define PRODUCT_ID_MASK		UFS_MASK(0xFFFF, 16)
> 
> +/* AHIT - Auto-Hibernate Idle Timer */
> +#define UFSHCI_AHIBERN8_TIMER_MASK		GENMASK(9, 0)
> +#define UFSHCI_AHIBERN8_SCALE_MASK		GENMASK(12, 10)
> +#define UFSHCI_AHIBERN8_SCALE_FACTOR		10
> +#define UFSHCI_AHIBERN8_MAX			(1023 * 100000)
> +
>  /*
>   * IS - Interrupt Status - 20h
>   */
> --
> 1.9.1
