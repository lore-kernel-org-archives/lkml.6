Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx48CwYTWK37rutlJE+Zz6xg9VaFwd9gnNX+iSKs2fxFB/M8k9TSmkQXWcx9Brx945YcFL3j/
ARC-Seal: i=1; a=rsa-sha256; t=1522396532; cv=none;
        d=google.com; s=arc-20160816;
        b=wE+Tl1eAcN5NNAGxQYgGfU+54Hq7RxYYpXl58Qq7FS4RHTN2a3fRugL45bVqBdqPKZ
         LXkex2ZNH/DigcY4xmfVGAg8Lo/V64gLAFdYR1M2xsgZ2sJ3HQ8JxnVGWQleytxzcg3/
         vjVDooQGIUW2qrL/twyHUat2DL2uEtJClvlb0TNNY2ILCEOXFUS2vJuBLPQq/3YejeoQ
         PH1kXpsLExKlXco2RNW3H2FfjtKBZ7n3s5kkZHtSpZJoDP3YQ9oMhgjf2iZ1DWwRnB1q
         idG8830MBCOYm+0g6iu23s7WF8VasuRDOYTvpl8oAfmJFeglXk9Qv/B19xP2HFS9c8tu
         UGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=5CF1MtVejoSfpwbDanFYmD8QjuYv4IMRof26woZQ1os=;
        b=rEB9zghacKQDUclp23jyKaDgPjSM7YN6BYsMUy21GCOPLlGkT2HPxU5DHXLqh19V0z
         DqbgNT8jfaeOk3kEiYMfbsgRULor8qKMvbScj3/yg/eq5AZTgOt4YQoWN/j4muikWmvo
         BhI3ftKMyKdx2t8JyHZZq+c7ehG+IU+1h5ji5xk5SALI9RnYweXKGYUce0bmR8dzQOe6
         340jmISo+arJwSdvoogG/Abwwxphvmc/5gye+5NGL892GjYEO0Bb1kO8GXtGqfHRhRBO
         mUmg6CmVYIPr8YwoinnPOUISvmdFWO9UsnwcLAmCg4VqmyZ1fVlesvRmNuBFYgE+IYMM
         6diQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=oGqONPX1;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.1.55 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=oGqONPX1;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.1.55 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH v3 2/2] drivers: remove force dma flag from buses
Date: Fri, 30 Mar 2018 13:24:45 +0530
Message-Id: <1522396485-10248-2-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::27) To HE1PR0401MB2426.eurprd04.prod.outlook.com
 (2603:10a6:3:25::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de1ecec9-c513-4caf-0703-08d596139a0d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2426;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;3:Synvh4c78bSKK9SvCr8di7mwI51p66K6L0Xxi7CN1xR6lLCwaAIxAIWwAde4HPvZuF046n047Kb6Jz3Y6zPxJuNCFsCYqf4xiFNiTtJn4mDErn46BO1lxecPjclTt69OOxnjuhRX3xiQq2V/un3AU6kd3Gix0fzywrjw2p0l9f9u3th2qmbvJj40hJxFItS00aZAsIErKXlF3OhZNhAij85OVH6S39zRkpJwpXzVpNuFV9GkU2wSISdn5xeoSVXV;25:AV80DYt3UlioPPP1bPS5zICCRFwPEPdY8MTFW6mkrPGyU+8SyZDVGQoGI2GNOjbcamYAOd3s4NgJaKGMqZNp2yoLIuXcXcxb0QKW4sKqDk8kGnqSy/XBYNvq7z9GVwzR++rP8/+OflsyDhlGway9E1+sPc+DteGuF1G14kj5fj35pkp15jV/CWqu/ywwl7aFvaAifjxROUyMuVqzz7sycQD01s7NZsT0/i7JcpegTY2Y2SGnokI41d2OA6RsCTH+AT4nwugWs6O6bweleqoZPwc96Ymtm6iNj/qW9WZI89jODSxH6iAZQ6/Tn2YhkXwkfgO30vWlFDSeZaGdk0m+jg==;31:zJBQW7QCHej3jifduf57bUEqxbqWI9jh86oPopZls2t4zgHEC0Be3qbYOogiHJvcUN5IfIFDxVcjfvwXGrJi2OMDmUVpMH7enCCSH0W9LKzpdUo9olmX7uDdidvF2ZwIvIL+UiGw5LbpvwJUl6LK82pvwI3eiJc4cya+5ze2bGIylW4W7fzcxpSvDdxjHmWW8LtHv/mlONiOoGPY6XPZokVqWvMbi6BU8nwLTySqOgQ=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2426:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;20:B45vS2/xosJCaz7oCXQJjGETge4X8AGmsrBOcF980mmSAqs6oQrb7SuIPifWI5/JHTREgQu0G9C8P6l3ECRlG4Ha1vbUY3MmxfaxC6e0wvGXdqE51+Y+IhuaYy4nDs21BYIAQI4hL9hRrdnm+ppTgB3hxUVqlUr48d/WrGNg+eywfw4RLbtRhCit/GYeJVroXSWDozEvUatrU/lTnY9sdcmrTuT6HT5xsZka895HpppK5a59uGc6M853KmubBVK+9QCXWYBxwSByvUEmkwU+rL/HorDNfAoRzeOSUhFPO69hdaXfESh8Nf41KFe8iFVqDSnGejCyCpl2BlWyGChxPMRDta2WE4ohDaq0DinoT9faLht4ba7vcLI4f1rATqyeoYR60aTjxzGkqAysy8tEiQ+zbjXtqA5ov68UtcioSrs9Qujs/K+PtMXKinzrS2E3IxHBQ7optBB9IPhjFrU6H9Ji2Lw5fetIeSy9sbfQx5/p9Ti6lrrG+LfvU4nPqoOM;4:I78ANld/UsCuudKY/EC0kfInEa8V3qKo0sjaDU+cWZLURhTEnH5ryaxfi98GluajEgwFnNIA0SqTJFrAw2WdMhCAVK726UrP0ttdFUiSXIiqWGNLeGPtgsx5370TuxTF4Qle25Cj5bFPs7pEBj/C3Tvo/PKdF8jmaraSu/Lw3/b/spix+xw8/4R3zLNQGeFsIVTLBCl2hLfQWwrYmNBmtChxbH/0rpVo0Tb1r3tVEd01Efco6h6pivjA/+VwgTgZ5U+QQ8f69xzyLQzr/Y6YStch8Zg9JuQ1asr+EF8746AjxVf7eQA8odSNcLL51+DA
X-Microsoft-Antispam-PRVS: <HE1PR0401MB242607230462201AFACA5645E6A10@HE1PR0401MB2426.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0401MB2426;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2426;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(396003)(366004)(376002)(199004)(189003)(68736007)(50466002)(86362001)(7416002)(6116002)(2906002)(16586007)(66066001)(305945005)(6666003)(7736002)(316002)(3846002)(48376002)(5009440100003)(97736004)(186003)(16526019)(486005)(6486002)(8676002)(6512007)(8936002)(50226002)(81166006)(81156014)(476003)(956004)(486005)(2616005)(11346002)(53936002)(446003)(47776003)(5660300001)(106356001)(478600001)(25786009)(39060400002)(105586002)(6506007)(59450400001)(55236004)(386003)(4326008)(36756003)(76176011)(51416003)(26005)(52116002)(110426004)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2426;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2426;23:XLZWX2K9+6xHD7MPISbOsMfNiH9pZPgwupw6hcW?=
 =?us-ascii?Q?tUvjovaAOhLJsQGO19fFVYOBVhJQ0EjpTEW8wMTzarbyXrOG6Z8DFu5j3xzn?=
 =?us-ascii?Q?flprNMaUGZ2JEtedjb1UrdzRL6lzXjq2YE2zASB9LQNjhz+vqprcmkwiZZHE?=
 =?us-ascii?Q?fMuKTsO2fwa/LG7chigEtimkleIsrUMJNdN+xN40cH+/c63Yp9s04siqgXGe?=
 =?us-ascii?Q?QZQE2uu3NURB2OrjnIky5fM88nKU60b3mupvP+3f0scIRJcP8V3ypuUUJ0Kz?=
 =?us-ascii?Q?DqQftb0otVZd8Z30YSY4nviRR/Ks91jYP4vRRrQvOxfU/v2nZx9kATJqo/Xt?=
 =?us-ascii?Q?BuIEOYdOtKC/SWZt9kvdB24Rmw4fL+NJ4ht7R/KSbyJA4ipaXlbet+FrNqOX?=
 =?us-ascii?Q?YXnmBaR1SaF3PKTrX3QDV/7ENuBspHSnsLmdaACWdB/2GWAnHCwJ2YKYTWOt?=
 =?us-ascii?Q?BoqKgZjNypznU1G6UGGo4gVTjjZ5pnEHU70XyyaF8RKlxjLgR10i1zMVyGXf?=
 =?us-ascii?Q?u/ip8oRIcnpm35zuYtcS5C1BDGPzb36eJVkJ9wBC9ulABfzWIWQeEJaZ2kcp?=
 =?us-ascii?Q?70Sx+SgooxJLA5FEKepR5/1QKE5yrQsS0x2jVV/EmasFjurmh0i4aE1yNurP?=
 =?us-ascii?Q?VKIF+lA2uY/ORPMoskvfcutHgz+VlB8hG2EqASCd54by8U1e+rxS54iBesNj?=
 =?us-ascii?Q?wF/DkOQ78DjQSFM/hbuD9hE2zwecdaJ4w+drlq7DZE+7ybN5VWEhNca/N/Ye?=
 =?us-ascii?Q?U31RBZqbEQ5kwSgYK/TZpQUItyUdGk0r4jRv6MuRzuFD/mdkZvb7gmVfqzq/?=
 =?us-ascii?Q?iKJyn9kQScXDiMGMt/gr+88F0uJrTI5tQ/C0tnhEPxVTGnDSn1B+lr+H7C/k?=
 =?us-ascii?Q?QqxqHRo1VeSIlYWWavb8rHfy14hAESX61hkrcUll/zZCG4kX/5jcidy9IEWc?=
 =?us-ascii?Q?Uvg0BiQJmKEX00gmmj2fN+2PnfBfl2/juhCIZGh5IdblIoAch/AJD5rfBrLZ?=
 =?us-ascii?Q?sLpJhtPiQDj4sv6zGaMYJoB0UgcXUxrw0Yzig6qNBjzqLpnkOGRKIGzDQv1c?=
 =?us-ascii?Q?6hV41Tb4RVJjIur5yii5kYt86nzlFHyt0/ZJA6EIvLUgkpgai2mrPq8uvto9?=
 =?us-ascii?Q?OoxCzTdNUXuX/chNe9SImGRRKYzAZORNmj1PmfV04RSA0uCzGxjbI5GnXczA?=
 =?us-ascii?Q?3HtWR9rCgWHksWh53l1zyqUV2xB882GFxAPkSqLwNfxU2jiInCK9Smsz/LLg?=
 =?us-ascii?Q?jPn7T/HQVXnbfXCGoperPugA42TK9YA9iT7FmSNcKG8TLB5GTubjkTrABJPP?=
 =?us-ascii?Q?ykNlsvmSZfC8MJpCtLiW+iznypt+uVXB25wpLMNHoUNI7kEiMpEPh3HYf400?=
 =?us-ascii?Q?NSnziNw=3D=3D?=
X-Microsoft-Antispam-Message-Info: PyettY3SapV9gtZCNXmqkwyLA5AnZ1FvLupFVnwZ8BxPK8BzW/ibzZc9wNxpwA5uo9Hml2+ceQ4zvj9DRaF61WECn2CUiDfYIhoEJQ6o2QfpU6MiwwIpnB52Qn2YQTCx4jmZdLLwjrmmj49dn/jH6ug1fXeqUiP92FFakZkKsNAmhUDWsNrNNciHXKliGHhO
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;6:heJ8PCZo8QO+VYPGQGen2LuFOcQAXuR9KlUzKm1cYsD4nkOz/MZkRm8SALLqgzRJ5ulN7PaQGWnZjzcsoiAqwVlrNT4oYteXjgfN+jCCqXBth3H2n31K11VjyTJRL9DvkX28N5DjBDKHyn3OixjoO8VNjXoSO7080MUDlr0CpLlu2+3Cpyuco5d1zW1Se31gcQ03U9xN/m9nW9AiRent1PCLkslA9fLj/K12fkvDHL7AhELnOCLDE8/znmDhkHUkdDSI/Sc1EyezVMaW7VZNDu9UturEEMXP1jqZCio1SswltIlfWtSWuY4MMVoRiiq74Ie5ByMGTl8cK1FgiWyG8Oo0mPXszuS9xXvNytI4QDKkbAXZjQr1VVEmwr0hZRc+fBbFB1oN4/gGAwQwwZVLsYbqm/BRDPYwEteUtVWDYODxaJR9dDM0wXxsBsHXvzZJkbQBt1ktcAuN/tVALSZbDg==;5:XiLcJl8dGUStuD4ZDW3kx9/0npWeOGa9JmAqwvMC7M3HABGO5PEZAUBQ12TVkRWEI1nnQFxwNOc5GLR4TNfi1lElQKI8gfpxv7osemfWw5r90UE5VJ+Y6Gquj21I+9O5fctjUDWuft7SQWxyf/8hh5IT6WBDPHps0ps6JouoNwk=;24:FIT112lGk1xefREDOpXCOKcH+7iAbNASdsjuSkx2Kwy6V+1W79RjDd1z0cp/x01stOefsDDtKPFBV/k20u3kEC7kGD6lH0xMgOFvwHn5Kt4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2426;7:2Mc0pdOc02FbCjGkO9LQz+nkVjh4ZKbzkuxn4+xmDSlwY4i2wYSUqql7jEcVDZHbsqW2peaPEIc4nIoOLC9vqERKqJ37r01VZUrun77acPsi0TcZtrzIcKwl95Uv3sO0nG7AzdeZ8+gRvtZe/01JGMSvVxcbGw8Fcjb9PcLQmRCz7DjC4MFu+wXio9jjO+IVKE5McmNB9zuMKiALjNoFPxft2bBjNl9hYMD/R0go+m4HYodFbKgs0cKMTTzzXcRy
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 07:55:21.4477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1ecec9-c513-4caf-0703-08d596139a0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2426
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1596348466353264197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With each bus implementing its own DMA configuration callback,
there is no need for bus to explicitly have force_dma in its
global structure. This patch modifies of_dma_configure API to
accept an input parameter which specifies if implicit DMA
configuration is required even when it is not described by the
firmware.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Changes in v2:
  - This is a new change suggested by Robin and Christoph
    and is added to the series.

Changes in v3:
  - Rebase and changes corresponding to the changes in patch 1/2

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
index 72fdbf6..cfbc569 100644
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
index 78e507f..27c832f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1540,7 +1540,7 @@ static int pci_dma_configure(struct device *dev)
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
 	    bridge->parent->of_node) {
-		ret = of_dma_configure(dev, bridge->parent->of_node);
+		ret = of_dma_configure(dev, bridge->parent->of_node, true);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
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
