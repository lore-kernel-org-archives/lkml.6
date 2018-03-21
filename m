Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELsPOiyTUgbwHvDV8Lc9BZaBO6I/v1L7YQ2PVNVzKIcvMVIXThwNxp2upLHaESlqFlWEVsLF
ARC-Seal: i=1; a=rsa-sha256; t=1521615384; cv=none;
        d=google.com; s=arc-20160816;
        b=k1jBx5vjg2FQd0DZypGDnOWL2ZYqiloF+A2hv7fPjbeTZGrBy9D17pjBOr0eIMrdjc
         ZpRHJqa42jbowco/pVep/SweFN0F3IhK7KlJLcQ30v7k/vFlbfLyVil6ybzwhmvd39PA
         ErqoyVhVtFcqza1JBtd3mvls+cmJoh776sQmq+S0gMBXYyCx4nh/wi0nHlirBaDdPaaM
         bucHflG3sBCYlUmaczydYkY6Mm1pQJ/W7SBIvUsFUBJBGSebZwuCHRoabb0liybC49Bs
         o/3MzuYvNa/sc/8RBeX0DZTBGjG1+vP2agFbsuyUbN+3VAeO4C7ICZdEg4JipjK7Vxsr
         7lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7gTQp27VhQEorgvP76OLbB7MxPSdzM8+uND9L3ssi3I=;
        b=Z+nVJijtWN+L6EABt5BSr/hbFeNAyzvVgtlBW1654rXTsSLKSzbpkRH9uwuEK03dMx
         EMzc8pRMN4zxMPLAToUCApmAkbF+mWPDO62bD+R4kIw2aF7Gf9E+tsnjCZUdA71RiTU9
         8PgucMj/c729v6UxVw/5P22Lsp/Z+8JnVGy1e7x8ueGXjEmRaAPJP7eQCri2g03UtNPo
         AT/vURW60TWJx7AF7OcuZYvk7DkuGAoW1BJYhFIQMV7mPJ3ihiC/KlY7/GE1bWbH5p6W
         JYzNr1T9u3eaUBHV5bE6Y0DgxEam/USqqY66Acpg4+AY1M4ew+6F8cvZAGGIAAOZbNrj
         CH8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=vXHtFH6l;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.52 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=vXHtFH6l;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.52 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	hch@lst.de,
	linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com
Cc: bhelgaas@google.com,
	zajec5@gmail.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	dan.j.williams@intel.com,
	vinod.koul@intel.com,
	thierry.reding@gmail.com,
	robh+dt@kernel.org,
	frowand.list@gmail.com,
	jarkko.sakkinen@linux.intel.com,
	rafael.j.wysocki@intel.com,
	dmitry.torokhov@gmail.com,
	johan@kernel.org,
	msuchanek@suse.de,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH v2 2/2] drivers: remove force dma flag from buses
Date: Wed, 21 Mar 2018 12:25:23 +0530
Message-Id: <1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::30) To VI1PR0401MB2431.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff77168e-31dd-4874-7e0b-08d58ef8d9ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2431;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2431;3:MWaCYzr9H/+fHV89eLRQi1UFbqagGJHw/Zu6kGsrXlmrO+0HD2MvI8Ex6j3IdrS099SfTEP89NPd6aBs/UMHtFbz4xgjMgXP8Hx0Scvx8P/ANo5vOhD45w0Z6BLF5UduYg4hNJ70neypRlxuHRlJP7ePCEaXSuG4eattZPZeXV8/4D5Zeawt2/4wXWwVbWrDxV0yigFsOxiFmhINn7OzXXhxtARbg+EvyQYx2b7kVsKj9ikR2mCdTjtem3UfJxtv;25:MMiUq+vaJhD8ZwQ3DfqJnRzrsaSqnEJDvnbwo5a2O/6Un5yUAZZdud5So1Jv3+oW6mFWGfQn3az4lJH00/arVK/uCt83Kfx1pJhJ8Y2qkp2Qd+DlPRK+1O/G61/J2MuZcbT3u+zFaKsuOnyMkqNP1wMTll70VT3yWoc9di2mPdehF9Un3JEJSiBu1dv8GwVYVcyO7t7VZmNQH8GK+WYeov8DAwmKz9H+aGDe7hwNjgdSHmC1vG+lqMaqGsCtsUJI4WOIayyuUilM/QVE0PgEfjmXQg+bNyLoWm1UMMGhzNH4jB4WXcHznyLo9SZaCUTrVPOpWx1yom0FRF1cL70PUA==;31:DKjS02ULAlR+VQ2g36MYWpNWxFKGXaN7OgqdhwDHHkqvl7/0McRm7CFm3akmmwo+vduhrMvzay/Oz3QfjWpJk/qM2VmDq3WGx5O00MXzStyr/0+GOAu3KVsEDB/KjjCw59opiPHW19t5Z+g7OCyrDjF420yHygHOKJIDEM5zSO3yiz612PxdaDSxQTs/hVgpZ77R9goNrQnhbYWkitkCeTfmOoHx9if4CfOs+AeV5GM=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2431:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2431;20:oc5+pZq3rMt6lZXeUmO3t5L22H4yT/sed1ja15wdMis07j7g6wINs0Zw7z37FAEAMWne3m/MxN43Pqx7Dp9KGIpQTJWLhBtFN950uw3diar5akHaFbuTzsBS4I/hfra5TuNzXgpgQgde41ALtv94Sdg9snyUTs2mej7eUccc4Er4bvgG+Bl4gokZhfjQBWo13TzpBqkBCS1EzzM98xXPE1vQg1lWSRhZ5CGc3yh9jXaSG4YnOPtDbSLZjibh47YsTkICH4VV+AgwiDOj8Hoj99zgHYh6/mBXn0bgjGynH/ZAUjOXam3hYwXAC49thGH+enzrJ0nIgJ965vvhFFqYVoHW+t4XrIyjriY5W27g0M3ehxp1qs8Cgn8KX0Qmo9keYLFFvdvuL9iUf1OwjmVrVt2B0Uvjq5QbJqziCdTJ6MpRdfmq7B/vqaQm+wPkjkgY6hUNuEsFkiWOj6DNO3vwRsolLV3poof4Sr7YRLTFayiWyKr+L79TG5yLjRTjjd79;4:W024Nckfg/HKGhLJbobdSCSmF0PXcFDG8DebMP3IUkBbSP36qmA4hC+FEzmItppHb7NvH0VQ5JnnZVR0DxjtvWJOYvZByy3eyzghvxbHjyd4sJ+SrgcN2HpjU4e/gLllYl5a3GOIrdKEh9GwqOQ9A3g3KZBmHQMhrRauaQXtT7evWQL2VOKpV9m4Hwj/Qj1lKXOMBXAMl4TgIStc46dgVaHvdO081kEbnUyMMu4l6NpocHMCt4ArN3OV/iRXDTQXonrc8K68O/1Ct9CRfqqoEcsdkHT9en6Rq+/3m3jdS7DbFiAzzjecLoaFG+JAHCJm
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2431AB1B5CB0A1345EA5923BE6AA0@VI1PR0401MB2431.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0401MB2431;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2431;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(50226002)(2950100002)(575784001)(7736002)(4326008)(86362001)(36756003)(8676002)(81166006)(478600001)(6486002)(316002)(81156014)(66066001)(305945005)(47776003)(6666003)(2906002)(8936002)(5009440100003)(6116002)(97736004)(16586007)(3846002)(186003)(52116002)(51416003)(76176011)(105586002)(39060400002)(53936002)(106356001)(48376002)(59450400001)(6512007)(5660300001)(16526019)(25786009)(68736007)(386003)(55236004)(6506007)(26005)(7416002)(50466002)(110426004)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2431;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2431;23:dFOXCo+/7BRvjKxNzyUgDnGpZ1yJBDVXBjy14d+?=
 =?us-ascii?Q?qd7pTWLG8429IPvaSnNUNQEksx1Lv0glMvxMseO2l1XtV4YTthtImfqKA3Cm?=
 =?us-ascii?Q?PPch/+pm/zLRsczeptLqkzUl+FueJJ86VH3boKPOwccl4scz0BfuViFr2+yI?=
 =?us-ascii?Q?R2IPOxfIGibUviHLW8T42Chlj0+BPUJciqeOodTbXhVhfMhj8WP4JjKTvqod?=
 =?us-ascii?Q?33CTnwyi1032dkx7b6QPy8eIki7+Dv+ChlwsCnpgIMNrfIW+trMzxQwCwnyJ?=
 =?us-ascii?Q?Gqt68Vk0UBm498YacM2ylcoMBFOBX05xf4IXMXIQUd4bL15p0jcb3rU0BXLr?=
 =?us-ascii?Q?I2wAjsC/hY6LCyfxjTuEFQai49QCDDC7KkyyHDsUOwoiYa/OJ3YtiAeRATFx?=
 =?us-ascii?Q?6BSpAlKshYH339gNGTeZaSflLy9WR3yZPAs9ZXf6hVlsmvMueEQ7XyC5TuMq?=
 =?us-ascii?Q?uI/0H6B/nUPrZTR8mky3Mz5GZGoYFfH3lGVl6lsv+dOdNjZAPhJEnEQJ11Fm?=
 =?us-ascii?Q?7T43BqLtJPSCV0t8JExVKBd5Gjd2J/b9ysIq/Mr5gPnWrF30T65okfcLQuNz?=
 =?us-ascii?Q?qFqTf3FPbjpLgmo8eFy5dpgVAirK84zI205qsaVA2qcAlpPRSVCVncLQdrPy?=
 =?us-ascii?Q?nPKpd/a/vPgK4QCii5E87zCzd+PRs/SFHnG+NKhk0p9BKQ11o9qdBnViGP3d?=
 =?us-ascii?Q?UHUl+UuZ4JE77COe/Z6Z0VSA/5xemqlyxa5Zpy1Xh29Z5w4ZAaPjYQYgBSsr?=
 =?us-ascii?Q?eKkls26GHJV1iL1+1m37ZAozYK/hIp1xVuZD3b3U4S+xjiiiyw8V0kIhogge?=
 =?us-ascii?Q?D1pKAPlnv8YACj8PKZvLOwjTkR57A7BExViPj494yiXV/4LlNDw6AizqKkcg?=
 =?us-ascii?Q?onY/kua5XxWLIAYhfKun5jMjbTAX0p1m5PiHp++sg0vSU/WVMImQsO93hAoI?=
 =?us-ascii?Q?99VI5bGOKTjTXuUcjpnv5ntR9qg9dBxrjt3DslkXSBBttTb7ADHc5qZVxfRn?=
 =?us-ascii?Q?/GKs3Hyo0IDuki0Ji4Q1ITT6eZ5t5k6z7T7KN4K7hwhXohmVEAt4uUPppTwI?=
 =?us-ascii?Q?0HputkK8c9eUIyEMvHa50ezFoT6nBJFMBb9mrUn8fTEacWhphKwvvFGzndpC?=
 =?us-ascii?Q?LayXLHOr4W7QlFTH4+ZL0cV2Hi1isPVbZuPnsIg1+9wnyJjyg8Ruw2bkbe4l?=
 =?us-ascii?Q?UrNrojpfK+OX444eIZwglge2YTFYcIDdpKnjeJSqCYI+l9ItspgeNMKF33fL?=
 =?us-ascii?Q?8Pm8bfv/m/o8lzWv7J1/cPoqdJ+1anYSN4k/dZeXE?=
X-Microsoft-Antispam-Message-Info: bI+KolipytNHdISI9fx45I4Dz0W/jErzQmot2AaV+jZrBWe+//MOCZeSdaE1YCLMBUUur0XnOv9dyoEYQVtEwoTPDVXt9JM6FlAh4RsTkL1+79bhCENd1afuh4YnlC1Fvtki1A4a2KLvKZ/RbCKChG1npfOfCOvvtzdLOZSpEsCHzsDSFRxDOUEvMsyeagxk
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2431;6:Kn02l5zuJbUurOOSVo4KnLCUBftJpOrIY844LEAFBIS2ZfNMe5E09KaDA4UF+9wReTlBo6AAP6960MLKVp3l5rRR70w000zXTyFvlV3TPafhd2TNyzl/46Yk0iLoFIG8IsKK/rzjyQkL07fRyHVftf4/DtlC8P5awP4iIXeNNLWXJt0pMQFuihd67CINELq1TI4xdqi4xF5gYYjBtZBefb1wSjcgFYU/QVn2ZxYjIejSI5bzbNxGapklshQOtj6B6sn+LxPZ8BXUGc88wBNzMPHo58bzl/BIEGc9O5n+8SmKB0I+lTp4beLVQNDUA+W+T/cqN8aKfjThbAtxBTohl3dmyTPaG7wJlmVfwWE/9LE=;5:zYEC1cWxOuZp839hQwchLf4KP/0VGrFDg3fu+tuK6qEoQ8Cu3aBEnKuqwsxtD2adiC049lUWX4tDLZqe5X5k2KAgj36DvdQG07jUJYwZRp4VbKRNIClmQvjrAmADZ7x3UeiRvkE4YEIidBWQ6vIzC/3uF+6LzNXQYg9D3qhS2qU=;24:hX3IP41pkQPJ3huy2ySlXkSjyAtTQecVx/VxoE0Czeo+nBdnNxqojptNB37UguAul8uCjM42tUAVBw4FXi39dTmpu9CO2kaGj9O+Ou9lY0U=;7:LobF48mogWvRQOwbgLooU0DZv/Le+bt2aU0TWyjLxklNQpKJWAAXbwpKKp5eBSBhxfmvSDv6CfR4/Qmi/mDZCinnKOOl2buiWh3lvM4GDFS4HZiRiOuf4SxdtF3bPblY05kWeWgkr7lySighq2+fq5WhuJIp+mdHr8ovN/zYWrTLTVxxJmA8h27ccjHT1rpr+WMQhUKutB3cBoNYM9LJj3bQXUJbGvofQWlQOgaPs/iAOn48xfrrbQ7pxG4puqYj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 06:56:13.9324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff77168e-31dd-4874-7e0b-08d58ef8d9ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2431
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1595529373186786387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With each bus implementing its own DMA configuration callback,
there is no need for bus to explicitly have force_dma in its
global structure. This patch modifies of_dma_configure API to
accept an input parameter which specifies if implicit DMA
configuration is required even when it is not described by the
firmware.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---

Changes in v2:
  - This is a new change suggested by Robin and Christoph
    and is added to the series.

 drivers/amba/bus.c            | 3 +--
 drivers/base/dma-mapping.c    | 4 ++--
 drivers/base/platform.c       | 3 +--
 drivers/bcma/main.c           | 2 +-
 drivers/dma/qcom/hidma_mgmt.c | 2 +-
 drivers/gpu/host1x/bus.c      | 5 ++---
 drivers/of/device.c           | 6 ++++--
 drivers/of/of_reserved_mem.c  | 2 +-
 drivers/pci/pci-driver.c      | 3 +--
 include/linux/device.h        | 4 ----
 include/linux/dma-mapping.h   | 2 +-
 include/linux/of_device.h     | 4 +++-
 12 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 2fa1e8b..1d58348 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -174,7 +174,7 @@ static int amba_pm_runtime_resume(struct device *dev)
 
 static int amba_dma_configure(struct device *dev)
 {
-	return dma_common_configure(dev);
+	return dma_common_configure(dev, true);
 }
 
 static const struct dev_pm_ops amba_pm = {
@@ -202,7 +202,6 @@ struct bus_type amba_bustype = {
 	.uevent		= amba_uevent,
 	.dma_configure	= amba_dma_configure,
 	.pm		= &amba_pm,
-	.force_dma	= true,
 };
 
 static int __init amba_init(void)
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 48f9af0..03f8584 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -335,13 +335,13 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
  * A bus can use this function in its 'dma_configure' callback, if
  * suitable for the bus.
  */
-int dma_common_configure(struct device *dev)
+int dma_common_configure(struct device *dev, bool force_dma)
 {
 	enum dev_dma_attr attr;
 	int ret = 0;
 
 	if (dev->of_node) {
-		ret = of_dma_configure(dev, dev->of_node);
+		ret = of_dma_configure(dev, dev->of_node, force_dma);
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d2d5891..154707c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1132,7 +1132,7 @@ int platform_pm_restore(struct device *dev)
 
 static int platform_dma_configure(struct device *dev)
 {
-	return dma_common_configure(dev);
+	return dma_common_configure(dev, true);
 }
 
 static const struct dev_pm_ops platform_dev_pm_ops = {
@@ -1148,7 +1148,6 @@ struct bus_type platform_bus_type = {
 	.uevent		= platform_uevent,
 	.dma_configure	= platform_dma_configure,
 	.pm		= &platform_dev_pm_ops,
-	.force_dma	= true,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index e6986c7..fc1f4ac 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -207,7 +207,7 @@ static void bcma_of_fill_device(struct device *parent,
 
 	core->irq = bcma_of_get_irq(parent, core, 0);
 
-	of_dma_configure(&core->dev, node);
+	of_dma_configure(&core->dev, node, false);
 }
 
 unsigned int bcma_core_irq(struct bcma_device *core, int num)
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 000c7019..d64edeb 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -398,7 +398,7 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 		}
 		of_node_get(child);
 		new_pdev->dev.of_node = child;
-		of_dma_configure(&new_pdev->dev, child);
+		of_dma_configure(&new_pdev->dev, child, true);
 		/*
 		 * It is assumed that calling of_msi_configure is safe on
 		 * platforms with or without MSI support.
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index fa9896d..211eb6b 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -317,7 +317,7 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 static int host1x_dma_configure(struct device *dev)
 {
 	if (dev->of_node)
-		return of_dma_configure(dev, dev->of_node);
+		return of_dma_configure(dev, dev->of_node, true);
 
 	return 0;
 }
@@ -336,7 +336,6 @@ struct bus_type host1x_bus_type = {
 	.match = host1x_device_match,
 	.dma_configure	= host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
-	.force_dma = true,
 };
 
 static void __host1x_device_del(struct host1x_device *device)
@@ -425,7 +424,7 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node);
+	of_dma_configure(&device->dev, host1x->dev->of_node, true);
 
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 064c818..33d8551 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -76,6 +76,8 @@ int of_device_add(struct platform_device *ofdev)
  * of_dma_configure - Setup DMA configuration
  * @dev:	Device to apply DMA configuration
  * @np:		Pointer to OF node having DMA configuration
+ * @force_dma:  Whether device is to be set up by of_dma_configure() even if
+ *		DMA capability is not explicitly described by firmware.
  *
  * Try to get devices's DMA configuration from DT and update it
  * accordingly.
@@ -84,7 +86,7 @@ int of_device_add(struct platform_device *ofdev)
  * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
  * to fix up DMA configuration.
  */
-int of_dma_configure(struct device *dev, struct device_node *np)
+int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 {
 	u64 dma_addr, paddr, size = 0;
 	int ret;
@@ -100,7 +102,7 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 		 * DMA configuration regardless of whether "dma-ranges" is
 		 * correctly specified or not.
 		 */
-		if (!dev->bus->force_dma)
+		if (!force_dma)
 			return ret == -ENODEV ? 0 : ret;
 
 		dma_addr = offset = 0;
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9a4f4246..895c83e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -353,7 +353,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 		/* ensure that dma_ops is set for virtual devices
 		 * using reserved memory
 		 */
-		of_dma_configure(dev, np);
+		of_dma_configure(dev, np, true);
 
 		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
 	} else {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b473a4c..b15637a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1541,7 +1541,7 @@ static int pci_dma_configure(struct device *dev)
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
 	    bridge->parent->of_node) {
-		ret = of_dma_configure(dev, bridge->parent->of_node);
+		ret = of_dma_configure(dev, bridge->parent->of_node, true);
 	} else if (has_acpi_companion(bridge)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(bridge->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
@@ -1566,7 +1566,6 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
 	.dma_configure	= pci_dma_configure,
-	.force_dma	= true,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 1832d90..92c530e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -98,8 +98,6 @@ extern int __must_check bus_create_file(struct bus_type *,
  * @p:		The private data of the driver core, only the driver core can
  *		touch this.
  * @lock_key:	Lock class key for use by the lock validator
- * @force_dma:	Assume devices on this bus should be set up by dma_configure()
- * 		even if DMA capability is not explicitly described by firmware.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -140,8 +138,6 @@ struct bus_type {
 
 	struct subsys_private *p;
 	struct lock_class_key lock_key;
-
-	bool force_dma;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c15986b..3dba3e6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -761,7 +761,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
-int dma_common_configure(struct device *dev);
+int dma_common_configure(struct device *dev, bool force_dma);
 #ifdef CONFIG_HAS_DMA
 int dma_configure(struct device *dev);
 void dma_deconfigure(struct device *dev);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8da5a1b..b0be3a5 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-int of_dma_configure(struct device *dev, struct device_node *np);
+int of_dma_configure(struct device *dev,
+		     struct device_node *np,
+		     bool force_dma);
 void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
-- 
1.9.1
