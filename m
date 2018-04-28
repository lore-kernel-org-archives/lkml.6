Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZq3oyqQifVpnrEpR48WsuiZYmZLhkrKYRjbZ74wStdS4eRD0LfP4rnF8FY7dGNW5fd83JTd
ARC-Seal: i=1; a=rsa-sha256; t=1524883960; cv=none;
        d=google.com; s=arc-20160816;
        b=hfq2UUS/MRlvsRUjGAFwUwGgirXWIBx6QMNUw/40nZIXWKt3bJURCQrKj6XJ1VzqQG
         RgOnZWAyQeqCooQ+intF+yUWevUxvwMKSAOxBl2rTzXSklanxMwNV45sivgUJmxeWXQ5
         iZnx6AcFPkZkxTslRLeuxKm6nQpcuJvarbSgdtVA6nKZ+GVCtsipnvkC4qN3eomFH+VN
         4fhY2Ic0LyoRzU/MYuEYNMdYR+J6a9WdxPSEkSQVgPDUJd5kuaOXt6OD6Pvp1Obe/FQ2
         gLpq3r+Ss8XdRHAAZOBc0lFTfqN1sVRqo3ewlP2ZkrA614sy8ppMqp/AQcPd51ubtMWp
         m6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=+w2qmxxQVRe1f3ycUSORXheLvhJJRyD+gMSa0ADmtaI=;
        b=SYDttGuMQVrYLE+NJBe0WEJP5Tg1uYLQClCv5Y8rt9FsJ5pFAIB/CnXrSL//IgPa6c
         FZWvPFIiQvuvAzy2s0+bNjbJGqNO/UXWux7q5KOZNffvlAXFfXeudPnja7bZITcgWey+
         GyWQ+dLnim3zixV/v2L7JiiszneMpqKvFwGkufaIN+S+9or7DWeI/A2AYE8e3BY8nUlq
         WUQjndqdNC6IxFy9ZXSH010lmfS8ztSCu6NN25gtUzGcct7CrPXGGZDF2OoRpYrjt8Td
         CdzPZn9smH2TNXN260MK6B2UksN/7Wze6tM3irkqTWC8eC8QEbtX6phtcRZr0WLCX/cF
         V+Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=EPRRKxhB;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.88 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=EPRRKxhB;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.88 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH v4 2/2] drivers: remove force dma flag from buses
Date: Sat, 28 Apr 2018 08:21:59 +0530
Message-Id: <1524883919-29484-2-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::11) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:12ME/HbqGs6Of5PRfk7JiuWnzUNSe+LgVqO2acmJb4eRlZXaAxfmMlvmIMkrHZ1bE16uAP3j9quurNLzfEvfQH0LeSPesJ0mYw/UNZBEFoorzlZiVR5jXDX2R3bdZywSbDDKYee0c8+9UywNVW1yPYRPhACFaNhFnKz1a4r4c8/WvoO5gKjYmleMK2p+hSbet6a5Cj2aHD0VP3qIU6Y1TzOAXU6dvxNLIChPHtcIgqvOha+XeJPKCdHj/EY9fIOo;25:cFiQzW5ZMMomzM8yuCMS928ZYzQgE5QvuybldL7ShjO5Gca7f6KYUqOUiSlnVj0qFRYhdWgp4F+ffY8QzDhK4HNNRJ4VhBtEE8mltJFIig8EbcfcN5o64arPdH5Oj7CPNbd8Z2kcklnRIAyrLvWocB1igkELWQz4shz4Hx+GAhneUdkbxXJW0o61E7McNlUhODxKm5uSUwlgv9/dgdsuWNN8gcNwNYT+z9Oj79AH41drsxVSZaGOwIE2W6zvx4THtEDA1NFJjjveNgZZ6d+rMT78oil5Mex6ZbdvlyQEtB16YNcHqfuPh6JJzHi49txnWyOryEhs7EeU4AoanRfrZw==;31:3OuddoQVO59GW4VZO2tazJp/y7aUURrgSgr77ehs4jAtbumyE76r6zr4siN4OZp4TCn6m+UcsS8XwmI+keF/nHFXQtvlPSKdFcmlNhYgVqxZxI0EMYdTouDMu/ChkZswDFE7qHb3WQD5InnGsvLC/g9FjhwLC1M1KzI7MZo28CB8jTipo9kAAulILDQiqx7YJedFwTWCsmpzeLefxMf8CE+58wT3E6Zjuik7r5TXdvs=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:xIj2rPcFCEpE0V4eZfBjcwbjuR2I+LGC7TmBqnVPlbgJsdbGbR0h23LDEn6DXnF0MWP/ak252hb3EoHQ+J8BoG+D93diyCDfW+k6iWXoZvGpdC+oBnbo/YT9phkYrItiD7rROIDDaYgxHnFZDzOcfSMzyPzkvHGy1UOyUNoz1cbJRh6XI348PkW+bd2/Ou671QJT7tgKaiIgqkTP8MWGPsnL0SfIY6ecrats6AwtbhjL25weSohHx0sDezFwpuNGkJo2+YBeYcWsUPuFExBqvbZVpGFFcD2sO7nwCZFiwawlhBgkbojDn8MACd1we+gBGIOmToUubw+CKCcmlcDPqlvaMEmnI0uPXUUNPkP+DVqhoAP39aLgo4fCHFsKpv96sCDL+ZCJdYv5rpTm69uELya4ZpfbZ2GKLKvAP94a5IFdNIG0caMz9ZWHQyiJfdtLATx9AyJowih2DzAsbx5cexBz2cMhUVQACpM8GcktX2qr4xqCTY+AQVLJzwtaUjKP;4:BkZ45Fz6XhIB8+MMrkn+Ngi7StRfJLxsXE125BgqZl8F8y71dM8Y9UnmbslfFPMV3zupi2GEJNTahGlLiJ98uUypC+63gcf+zK2oq29GloGqWgMXGpb6BrfUcEY3c/sTU2ZcbZmOJZzIj4SgHj5Lq9eHjUVHRQX3Cg+lLmxGn/0K3c7zRHKLkNYZREfAq1mOjUDMTJy3KADov8ZysYIvlyOGV1oc2FeNcFuctbhmNXRh0y5ZWcxxPMkBVqWAiQf1dEZcUzYZvJBMeolQ49j1AVi317X8r0tWS4ovz4mE24h0COwQqACmYMj8d5Bsrg/E+6P6V1o8QM+utEvhK7o5CwYk2iglSKPNBGrnVB6RPeMLEQHbkQ89GFwXuyNDWn1q
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2425ED7D4B099B4D12D2E878E68C0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 0656A4403B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(376002)(346002)(39860400002)(199004)(189003)(26005)(16526019)(39060400002)(5009440100003)(86362001)(486006)(105586002)(956004)(2616005)(11346002)(476003)(8676002)(575784001)(186003)(305945005)(6666003)(478600001)(446003)(25786009)(81166006)(8936002)(44832011)(81156014)(4326008)(106356001)(7736002)(76176011)(53936002)(97736004)(16586007)(316002)(50226002)(50466002)(59450400001)(36756003)(6486002)(48376002)(55236004)(6506007)(386003)(5660300001)(6512007)(66066001)(7416002)(3846002)(47776003)(2906002)(6116002)(68736007)(52116002)(51416003)(110426005)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:w5KxoBazi/TgzvvdwGe7Fc2a2lkAEQuvg4UKda7?=
 =?us-ascii?Q?Ue/8xuan//LSfJnsYv0EoRSRMOObo1c0akHjDj3ABfbRW997/nFCHq0szktg?=
 =?us-ascii?Q?4JH1k+gEv2tRqZiNn8291tV+OtdPLcjsZX71+nV7EMkTCaajChCCUIoVBJ1Y?=
 =?us-ascii?Q?8V1NRzUBX1hsJIwtvwECqYiuYsziSZO4nYcKimjMjnQMFD5fqge8VgCmHYba?=
 =?us-ascii?Q?7BbDvjx2xxB+aQ0g3ZZWK2eKFAEG4+YXf3BzNbX4BeEG2Jg3Zab29hgdooWt?=
 =?us-ascii?Q?X+5psUWXYVaOizXJjMUggxiZlKhxDlY4eqeYcrCckRPY+g1CqDGPWcS2Afq2?=
 =?us-ascii?Q?bJy3ekgTqkp0Ma+5zCnwv/aARqY+lxNFkgoRJyrOwrz50j7W8L7IaAmBU7bi?=
 =?us-ascii?Q?t8EZ9zjs84BvXd3JrBYMoTHu1XkBH/L+19BOesphG+/k9qKEQwJ/9E4yI1e/?=
 =?us-ascii?Q?V8aiVkiyiP0faPg2ySPoW10xdOpEbN/nUvz4lImkxsXEh9J9qgVUxG4m0Z2Q?=
 =?us-ascii?Q?+BXybyNlJQVh6v8OrHoxm8SUTFDRCrY+fKfE+M8IdMCXd4CbDKcdXqEG6bru?=
 =?us-ascii?Q?pClXZPBxinBBiGA+1wmFCNe9A3VEVP9ALd2QtZfpVfqeN00ZsmdxVZa5sngG?=
 =?us-ascii?Q?lQmGXq4gFZLEH84ueGKg+udrCVrBWAs+icF49zmpdJwsZyNix9fbUrtPcm+h?=
 =?us-ascii?Q?f/4/VHESTYAJx7si6OUpyIotpnAZnjFFECNkZxszDLIhxgLJmCW7TWNw13j8?=
 =?us-ascii?Q?XWhZjVWu3EAG5PDL/B+sRzUlMSt6/ZnKeQxau7pe8Ygf7MbNdfRx5ixP+vlw?=
 =?us-ascii?Q?NRemIV8+7YKw7S6mR6bjL21SpjiKgwOWEExrVbubc4L/J97Hd6rvggXfevyq?=
 =?us-ascii?Q?rDADSEHnJrCDmCymnMfQHMjv6vNQg7iffp16paIl9hL9ViweXHP8J0vEIdAv?=
 =?us-ascii?Q?bmi/CWLyCsDFW5Sku+CqjeOPvruJD2YOQnAl/GJ3ftoXkC3JfaGuJdZtVHQN?=
 =?us-ascii?Q?eEJVm+nv1xo97SyjfY3n1TZj/ATF+ohCUiLuxmrF1pXuo2dbfleUT/UOqnfe?=
 =?us-ascii?Q?r9i8aYzwUBG1XLNZBeO4rqyqhkEDpt94JS1AcT4boI1Qn+ztc2YZfCNb81uc?=
 =?us-ascii?Q?HXQm6cM4LFIiJQgH9rjLERE5TSRG2qZSv43Omr4c1EuZstt5tLOh4rXfeIJj?=
 =?us-ascii?Q?fvi49jFwQSCXFX+Jlzf/3tlhcLjEKTZvFyLYZPxIYtbtzClAWG1+A9N7kCI1?=
 =?us-ascii?Q?3wVoKnTiZRPO/h2Zgu/ZTaDBEON/2am1hEPg0rRLWsgQE0iIxOMQ3Lzb/eUU?=
 =?us-ascii?Q?BsuCi9PMRsYtTzHO43cwXKrOIDWWVcb+uOvC4kvzAb2FMdTUBzUlyXWd4Mnb?=
 =?us-ascii?Q?6BjA1hKdNambJ4lZDE48rPps0Mtg=3D?=
X-Microsoft-Antispam-Message-Info: EiiKYz0b9WOsmOxII5Dgp16nDOK+/IC1onIoMMvR91BU93gww/lnqgg9/x3NmJVYBBN/fU2nBMwucMtOEzByJqcQJv8Z21ZgEcYe0MRYzgGLdzU+paJJmszfgK3tAYUWcTE75l2u8/BSQY0ELJqp18iWTOTQYdtdLU4nUb2zYATLhh2G+XI03nzJiBu3W+d1
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:iiuJolBeFkqWLCV0/FjeBy4PVRo+IQMYquq6kNEioQhzvLu/lgdZXurK+OnYd6Uo6m2oc9qyGNRGs4DSPp5+MDxnZeuz1/+o/RFoeXPFNg4duTYBrmCNmGByfwSwKoAKLXPlrxNyLI6S8ic87+PyO+X7c3sSPvpZSL+m6+NnZFB+X58c6r5znx3b2R3GbhfB00cp0cDW+6Du5/VFmJ3zkgZvLPUQfU+witSyqskyJSdZ8fjNIkPelHYduSabIIVETdypZQj1G7j3E4VYl9j+ipuHoQ79OOhO0DdQyGcYM6ARjdPwjLsXMV0JCa1cbMNwuTvUH+HPqbeDDRTEcZNnkZzRIILnxsjHZatGRpRNTPNDFdAo5cfwaZWI6AqSKBz4UefBnDw8T4u+xzdSGMJ5EQ9MrcDO/vQgYBn3scDs3dv3yueGxOX+DpQmanzt6mbOZmxjk2aeiCTsonjNIqRAww==;5:/tRThzWvGRS/BghvEXcihJZ2M3TbCUROZYSFnZH23nXMd8Jct23sx/T/nmnoZh4WzZMrv92a6L4xUZObDLKEtM9OFnojcpNwds0BTS8+XnMdzG1NsdMTjn9szxiuvPjTNnaZvYoO5w4m7FfDpc7WIXl2X+aopJE3ZRK7dJAiBS4=;24:IvvJ4eidfuqBjDms5BP8WxCOuAaZ2AGtMuM8EnZ6grIQ/tldra1jxkdEb8+mwcdlaGFx6tnwMiblEGRKmSk9jetTjn6TvTDo2ZdKHyBCIAM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;7:Fh1N8mV6NavkbaLdxj3nPgYImmOaHosv6TFSPmveulx0SqXot6UHY1AlVo+8GunuYIpBahbaakcT3Dm1prtf2mZNRfD4yvgGukSwPqcmqKFbSP3XYA7S6XdMLVAtenIcLdgcXnMtPtMw2aYWO/MQSrUnoUenokCHIn2IXHiaiaurwnF8rLT2LIz6FLrGXPexnLnfpoblEXfLvwomQ3F0RtkDkYxKIPIUxPlU+bryHE0xvPyLpZLL3LhZpZpGiumH
X-MS-Office365-Filtering-Correlation-Id: 14b22090-3ea4-4398-d72a-08d5acb318a9
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2018 02:52:29.8356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b22090-3ea4-4398-d72a-08d5acb318a9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1598956723509180221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With each bus implementing its own DMA configuration callback,
there is no need for bus to explicitly have force_dma in its
global structure. This patch modifies of_dma_configure API to
accept an input parameter which specifies if implicit DMA
configuration is required even when it is not described by the
firmware.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # PCI parts
---
Changes in v2:
  - This is a new change suggested by Robin and Christoph
    and is added to the series.

Changes in v3:
  - Rebase and changes corresponding to the changes in patch 1/2

Changes in v4:
  - Rebased on top of 4.17-rc2

 drivers/amba/bus.c            | 1 -
 drivers/base/platform.c       | 3 +--
 drivers/bcma/main.c           | 2 +-
 drivers/dma/qcom/hidma_mgmt.c | 2 +-
 drivers/gpu/host1x/bus.c      | 5 ++---
 drivers/of/device.c           | 6 ++++--
 drivers/of/of_reserved_mem.c  | 2 +-
 drivers/pci/pci-driver.c      | 3 +--
 include/linux/device.h        | 4 ----
 include/linux/of_device.h     | 8 ++++++--
 10 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 867dc2b..abe73c4 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -199,7 +199,6 @@ struct bus_type amba_bustype = {
 	.uevent		= amba_uevent,
 	.dma_configure	= platform_dma_configure,
 	.pm		= &amba_pm,
-	.force_dma	= true,
 };
 
 static int __init amba_init(void)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 638d42e..c0ff1e7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1136,7 +1136,7 @@ int platform_dma_configure(struct device *dev)
 	int ret = 0;
 
 	if (dev->of_node) {
-		ret = of_dma_configure(dev, dev->of_node);
+		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
@@ -1159,7 +1159,6 @@ struct bus_type platform_bus_type = {
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
index a9ec99d..b39c1e9 100644
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
 
@@ -335,7 +335,6 @@ struct bus_type host1x_bus_type = {
 	.match = host1x_device_match,
 	.dma_configure	= host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
-	.force_dma = true,
 };
 
 static void __host1x_device_del(struct host1x_device *device)
@@ -424,7 +423,7 @@ static int host1x_device_add(struct host1x *host1x,
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
index ba8c6b4..f8269a7 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1595,7 +1595,7 @@ static int pci_dma_configure(struct device *dev)
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
 	    bridge->parent->of_node) {
-		ret = of_dma_configure(dev, bridge->parent->of_node);
+		ret = of_dma_configure(dev, bridge->parent->of_node, true);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
@@ -1621,7 +1621,6 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
 	.dma_configure	= pci_dma_configure,
-	.force_dma	= true,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 607c7eb..31dcb29 100644
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
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8da5a1b..165fd30 100644
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
 
@@ -105,7 +107,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return NULL;
 }
 
-static inline int of_dma_configure(struct device *dev, struct device_node *np)
+static inline int of_dma_configure(struct device *dev,
+				   struct device_node *np,
+				   bool force_dma)
 {
 	return 0;
 }
-- 
1.9.1
