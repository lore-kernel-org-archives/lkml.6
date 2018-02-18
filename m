Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeBRJqG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 04:46:06 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14403 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeBRJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 04:46:03 -0500
X-IronPort-AV: E=Sophos;i="5.46,529,1511798400";
   d="scan'208";a="174600303"
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
CC: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Potomski <michalx.potomski@intel.com>,
        Szymon Mielczarek <szymonx.mielczarek@intel.com>
Subject: RE: [PATCH 1/1] scsi: ufs: Add support for Auto-Hibernate Idle Timer
Thread-Topic: [PATCH 1/1] scsi: ufs: Add support for Auto-Hibernate Idle Timer
Thread-Index: AQHTpx3/OmHTDTQbnUWGhnSFilEwIqOp5/3Q
Date: Sun, 18 Feb 2018 09:45:54 +0000
Message-ID: <DM5PR04MB10857B795CCBBD945062DCCDFCC90@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1518782464-28847-1-git-send-email-adrian.hunter@intel.com>
 <1518782464-28847-2-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1518782464-28847-2-git-send-email-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB1018;20:gLf0dW1M1TPncdVlgcIzKIBsxiuYYq3lILxEQLB48yF4iO+6/tlRO3U+vdvWZ7AeNdzErBz5tbqkhOYoFyRwgi7u6AVIDvBSM8SbqW2cuGuUs23TB6aXOEvAwMA+zLFQPuIgJ9Evt6Qk4TfLte+FB/2OQSDKxMOG759I9KmicWU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7902669e-3cfc-49e3-7c0b-08d576b467b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR04MB1018;
x-ms-traffictypediagnostic: DM5PR04MB1018:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB10180B68A6B3F3378549487EFCC90@DM5PR04MB1018.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR04MB1018;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB1018;
x-forefront-prvs: 058707456E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(366004)(39380400002)(376002)(346002)(13464003)(50944005)(189003)(199004)(478600001)(316002)(2900100001)(72206003)(4326008)(74316002)(8936002)(39060400002)(7736002)(99286004)(5660300001)(8676002)(81166006)(305945005)(6506007)(53936002)(59450400001)(53546011)(6116002)(97736004)(229853002)(33656002)(6436002)(3846002)(2906002)(575784001)(86362001)(81156014)(25786009)(7696005)(68736007)(9686003)(55016002)(76176011)(14454004)(66066001)(5250100002)(6246003)(106356001)(186003)(102836004)(3660700001)(105586002)(54906003)(26005)(110136005)(3280700002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB1018;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fudjOVu5RKogLKoty8FWbJiNxv85amjnXgNL1Xz2Iee00mAIuZsNGXW00KR1GLZxa2sqIzBAQ6TBLboIQC2zxwd/MrePgc6bGH62d5YGeSqYvri0xW48trANKLsPYClJ4I+CjGfMvT63Kv7rPpk+eCfvDv1G6H5KRO7tbcX2D7A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7902669e-3cfc-49e3-7c0b-08d576b467b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2018 09:45:54.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1I9kCmu021515



> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Friday, February 16, 2018 2:01 PM
> To: Vinayak Holikatti <vinholikatti@gmail.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; James E.J. Bottomley
> <jejb@linux.vnet.ibm.com>
> Cc: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>; Jaegeuk Kim
> <jaegeuk@kernel.org>; Bart Van Assche <Bart.VanAssche@wdc.com>; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Michal Potomski
> <michalx.potomski@intel.com>; Szymon Mielczarek
> <szymonx.mielczarek@intel.com>
> Subject: [PATCH 1/1] scsi: ufs: Add support for Auto-Hibernate Idle Timer
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
> ---
>  Documentation/ABI/testing/sysfs-driver-ufs | 15 ++++++
>  drivers/scsi/ufs/ufs-sysfs.c               | 77 ++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.c                  | 26 ++++++++++
>  drivers/scsi/ufs/ufshcd.h                  |  3 ++
>  drivers/scsi/ufs/ufshci.h                  |  7 +++
>  5 files changed, 128 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs
> b/Documentation/ABI/testing/sysfs-driver-ufs
> index 07f1c2f8dbfc..c7f9441079eb 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1,3 +1,18 @@
> +What:		/sys/bus/*/drivers/ufshcd/*/auto_hibern8
> +Date:		February 2018
> +Contact:	linux-scsi@vger.kernel.org
> +Description:
> +		This file contains the auto-hibernate idle timer setting of a
> +		UFS host controller. A value of '-1' means auto-hibernate is
> not
> +		supported. A value of '0' means auto-hibernate is not
> enabled.
> +		Otherwise the value is the number of microseconds of idle
> time
> +		before the UFS host controller will autonomously put the link
> +		into hibernate state. That will save power at the expense of
> +		increased latency. Note that the hardware supports 10-bit
> values
> +		with a power-of-ten multiplier which allows a maximum
> value of
> +		102300000. Refer to the UFS Host Controller Interface
> +		specification for more details.
> +
>  What:
> 	/sys/bus/platform/drivers/ufshcd/*/device_descriptor/device_type
>  Date:		February 2018
>  Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c index
> cd7174d2d225..a0e38776dc92 100644
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
> @@ -123,12 +124,88 @@ static ssize_t spm_lvl_store(struct device *dev,
>  	return ufs_sysfs_pm_lvl_store(dev, attr, buf, count, false);  }
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
> +	int timer = -1;
> +
> +	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT)
> +		timer = ufshcd_ahit_to_us(hba->ahit);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", timer); }
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
>  static DEVICE_ATTR_RW(spm_lvl);
> +static DEVICE_ATTR_RW(auto_hibern8);
> 
>  static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
>  	&dev_attr_rpm_lvl.attr,
>  	&dev_attr_spm_lvl.attr,
> +	&dev_attr_auto_hibern8.attr,
>  	NULL
>  };
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 5d874e303d4e..d5fc2fa65495 100644
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
> @@ -3709,6 +3710,18 @@ static int ufshcd_uic_hibern8_exit(struct ufs_hba
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
> @@ -6315,6 +6328,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>  	/* UniPro link is active now */
>  	ufshcd_set_link_active(hba);
> 
> +	/* Enable Auto-Hibernate if configured */
> +	ufshcd_auto_hibern8_enable(hba);
> +
>  	ret = ufshcd_verify_dev_init(hba);
>  	if (ret)
>  		goto out;
> @@ -7399,6 +7415,10 @@ static int ufshcd_resume(struct ufs_hba *hba,
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
> @@ -7843,6 +7863,12 @@ int ufshcd_init(struct ufs_hba *hba, void
> __iomem *mmio_base, unsigned int irq)
>  						UFS_SLEEP_PWR_MODE,
>  						UIC_LINK_HIBERN8_STATE);
> 
> +	/* Set the default auto-hiberate idle timer value to 150 ms */
Your commit said you are setting an idle timer in microseconds,  Better use usec to avoid confusion? 

 
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
> a57d9bdebfed..763a8e6c98ee 100644
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
>  	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	=
> 0x02000000,
>  	MASK_UIC_DME_TEST_MODE_SUPPORT		=
> 0x04000000,
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
