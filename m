Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeEPNGK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:06:10 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:63537
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751595AbeEPNGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:06:08 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH] pci: cadence: Host and EP driver updates for PHY and power
 management
Thread-Topic: [PATCH] pci: cadence: Host and EP driver updates for PHY and
 power management
Thread-Index: AdPtFc2vnFzYcg6RQhysml9lib2iIg==
Date: Wed, 16 May 2018 13:06:05 +0000
Message-ID: <SN6PR07MB451229DF639238CD7F15FDCFD8920@SN6PR07MB4512.namprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lNzFmNWU3Mi01OTA5LTExZTgtODZlNi1hNDRjYzhlYzVlY2RcYW1lLXRlc3RcZTcxZjVlNzMtNTkwOS0xMWU4LTg2ZTYtYTQ0Y2M4ZWM1ZWNkYm9keS50eHQiIHN6PSIxMTUyNiIgdD0iMTMxNzA5NDk1NzEyMzQ4MjkzIiBoPSJsN2szZUNZcURYZllNUEhUemhSQm1Ca2plck09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4238;7:a8IpvPEqlsW2xxn+SM336iJiws2W+YuzOxCPt12FoeuPFp9YHuplOWFzbK3hEYYyj3f5vhtIw02lzSw0LqI3YIAmXDQwoOVDONqs5R9iArceRKDFysiQVstL9PUm+bOGE5Fv6xGytsnBojA3PD1QmTgMH7ufg71YgMD1kLMS1bBj9sA6ZL7Hx/xRNdTFuK1JP25uAmsrI1APTcttme6sNcern8pop2gXT7CiJfIZ2G5Fz+BSjdalJDBH3htoVfyn;20:E5aafqkkA7ea2AZsuw88gZzdGxsC4+zliL8gQ3o31KsFmQ+lypvdYdrMoBRaRpA9h98f7QxWCFWHQP9b8ENSZ5mf1aYftyagn4njGgSP/k3r3iEl3+gCafS1E/Td7Pohze3ptPA0Rry33HwsOrxmBwjWJvZ0dEPAUQHqYlCu3lnm6cmyApMg6LUJsmR9hklDjbHmHC7Sm43e09DYinjszJceCjwMS+veTk99QCB+E9qqkXq5M8EIgN0xH4RPuvip
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4238;
x-ms-traffictypediagnostic: SN6PR07MB4238:
x-microsoft-antispam-prvs: <SN6PR07MB42388A512494EC22B573AC10D8920@SN6PR07MB4238.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN6PR07MB4238;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4238;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(39380400002)(376002)(36092001)(199004)(189003)(5250100002)(186003)(66066001)(110136005)(74316002)(316002)(6436002)(54906003)(5660300001)(2501003)(478600001)(8936002)(305945005)(9686003)(7736002)(8676002)(53936002)(68736007)(81166006)(26005)(105586002)(476003)(486006)(33656002)(14454004)(81156014)(102836004)(86362001)(2906002)(4326008)(59450400001)(6506007)(3280700002)(2900100001)(3660700001)(106356001)(25786009)(15650500001)(3846002)(97736004)(6116002)(99286004)(55016002)(2201001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4238;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: AxFOe6ecXV7A5/VRH54kCXSaDJr2/q9to9SKsxRy2GRsrLVuE8ZsM7OaPMnfKS8kLdNgzZAm6VVrMa5M8Rkr0T0WEglMXC5fLjWh8tU5eW21hjm69FFetQu3RHQWJ2zvoqpnv/0qau/iakGTcDyjLF5wp27ynWk45M3lRjoyVixLzHofs/T0PRkxIazrnEaeHEeGHbtOLsh+uYS+S/nBSw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3a63d790-d820-4c64-6bf1-08d5bb2dc87d
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a63d790-d820-4c64-6bf1-08d5bb2dc87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 13:06:05.3440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GD6GwD005163

From: Alan Douglas <adouglas@cadence.com>

This patch is based on next branch in Bjorn Helgaas' linux-pci git repository.

Allow optional list of generic PHYs to be provided via DTS for cadence RP and EP drivers.
Added power management ops which will enable/disable these PHYs.  
Corrected parameters for cdns_pcie_writel function, value to be written had too 
small width.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |    4 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |    5 +
 drivers/pci/cadence/pcie-cadence-ep.c              |   15 +++-
 drivers/pci/cadence/pcie-cadence-host.c            |   36 ++++++-
 drivers/pci/cadence/pcie-cadence.c                 |  123 ++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence.h                 |   13 ++-
 6 files changed, 193 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
index 9a30523..e40c635 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
@@ -9,6 +9,8 @@ Required properties:
 
 Optional properties:
 - max-functions: Maximum number of functions that can be configured (default 1).
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
 
 Example:
 
@@ -19,4 +21,6 @@ pcie@fc000000 {
 	reg-names = "reg", "mem";
 	cdns,max-outbound-regions = <16>;
 	max-functions = /bits/ 8 <8>;
+	phys = <&ep_phy0 &ep_phy1>;
+	phy-names = "pcie-lane0","pcie-lane1";
 };
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index 20a33f3..13be218 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -24,6 +24,8 @@ Optional properties:
   translations (default 32)
 - vendor-id: The PCI vendor ID (16 bits, default is design dependent)
 - device-id: The PCI device ID (16 bits, default is design dependent)
+- phys: From PHY bindings: List of Generic PHY phandles.
+- phy-names:  List of names to identify the PHY.
 
 Example:
 
@@ -57,4 +59,7 @@ pcie@fb000000 {
 	interrupt-map-mask = <0x0 0x0 0x0  0x7>;
 
 	msi-parent = <&its_pci>;
+
+	phys = <&pcie_phy0>;
+	phy-names = "pcie-phy";
 };
diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
index 3d8283e..e74b8a4 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -439,6 +439,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	struct pci_epc *epc;
 	struct resource *res;
 	int ret;
+	int phy_count;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -472,6 +473,12 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	if (!ep->ob_addr)
 		return -ENOMEM;
 
+	ret = cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err(dev, "failed to init phy\n");
+		return ret;
+	}
+	platform_set_drvdata(pdev, pcie);
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -520,6 +527,10 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 
  err_get_sync:
 	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+	phy_count = pcie->phy_count;
+	while (phy_count--)
+		device_link_del(pcie->link[phy_count]);
 
 	return ret;
 }
@@ -527,6 +538,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_put_sync(dev);
@@ -535,13 +547,14 @@ static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
 
 	pm_runtime_disable(dev);
 
-	/* The PCIe controller can't be disabled. */
+	cdns_pcie_disable_phy(pcie);
 }
 
 static struct platform_driver cdns_pcie_ep_driver = {
 	.driver = {
 		.name = "cdns-pcie-ep",
 		.of_match_table = cdns_pcie_ep_of_match,
+		.pm	= &cdns_pcie_pm_ops,
 	},
 	.probe = cdns_pcie_ep_probe,
 	.shutdown = cdns_pcie_ep_shutdown,
diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/pcie-cadence-host.c
index a4ebbd3..992ebe2 100644
--- a/drivers/pci/cadence/pcie-cadence-host.c
+++ b/drivers/pci/cadence/pcie-cadence-host.c
@@ -37,7 +37,6 @@ struct cdns_pcie_rc {
 	u16			vendor_id;
 	u16			device_id;
 };
-
 static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 				      int where)
 {
@@ -46,6 +45,7 @@ struct cdns_pcie_rc {
 	struct cdns_pcie *pcie = &rc->pcie;
 	unsigned int busn = bus->number;
 	u32 addr0, desc0;
+	u32 link_status;
 
 	if (busn == rc->bus_range->start) {
 		/*
@@ -58,6 +58,11 @@ struct cdns_pcie_rc {
 
 		return pcie->reg_base + (where & 0xfff);
 	}
+	/* Check that the link is up. Clear AXI link-down status  */
+	link_status = cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
+	if (!(link_status & 0x1))
+		return NULL;
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
 
 	/* Update Output registers for AXI region 0. */
 	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
@@ -239,6 +244,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
+	int phy_count;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
 	if (!bridge)
@@ -290,6 +296,13 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	}
 	pcie->mem_res = res;
 
+	ret = cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err(dev, "failed to init phy\n");
+		return ret;
+	}
+	platform_set_drvdata(pdev, pcie);
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -322,15 +335,36 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 
  err_get_sync:
 	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+	phy_count = pcie->phy_count;
+	while (phy_count--)
+		device_link_del(pcie->link[phy_count]);
 
 	return ret;
 }
 
+static void cdns_pcie_shutdown(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_dbg(dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+}
+
+
 static struct platform_driver cdns_pcie_host_driver = {
 	.driver = {
 		.name = "cdns-pcie-host",
 		.of_match_table = cdns_pcie_host_of_match,
+		.pm	= &cdns_pcie_pm_ops,
 	},
 	.probe = cdns_pcie_host_probe,
+	.shutdown = cdns_pcie_shutdown,
 };
 builtin_platform_driver(cdns_pcie_host_driver);
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
index 138d113..7a34780 100644
--- a/drivers/pci/cadence/pcie-cadence.c
+++ b/drivers/pci/cadence/pcie-cadence.c
@@ -124,3 +124,126 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
+
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
+{
+	int i = pcie->phy_count;
+
+	while (i--) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+}
+
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < pcie->phy_count; i++) {
+		ret = phy_init(pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_power_on(pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(pcie->phy[i]);
+			goto err_phy;
+		}
+	}
+
+	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+
+	return ret;
+}
+
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
+{
+	struct device_node *np = dev->of_node;
+	int phy_count;
+	struct phy **phy;
+	struct device_link **link;
+	int i;
+	int ret;
+	const char *name;
+
+	phy_count = of_property_count_strings(np, "phy-names");
+	if (phy_count < 1) {
+		dev_err(dev, "no phy-names.  PHY will not be initialized\n");
+		pcie->phy_count = 0;
+		return 0;
+	}
+
+	phy = devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	link = devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	for (i = 0; i < phy_count; i++) {
+		of_property_read_string_index(np, "phy-names", i, &name);
+		phy[i] = devm_phy_get(dev, name);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			ret = -EINVAL;
+			goto err_link;
+		}
+	}
+
+	pcie->phy_count = phy_count;
+	pcie->phy = phy;
+	pcie->link = link;
+
+	ret =  cdns_pcie_enable_phy(pcie);
+	if (ret)
+		goto err_link;
+
+	return 0;
+
+err_link:
+	while (--i >= 0)
+		device_link_del(link[i]);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cdns_pcie_suspend_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+
+	cdns_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int cdns_pcie_resume_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable phy\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops cdns_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
+				      cdns_pcie_resume_noirq)
+};
diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
index 4bb2733..ae6bf2a 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/phy/phy.h>
 
 /*
  * Local Management Registers
@@ -165,6 +166,9 @@
 #define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
 	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
 
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR0,
 	RP_BAR1,
@@ -229,6 +233,9 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	bool			is_rc;
 	u8			bus;
+	int			phy_count;
+	struct phy		**phy;
+	struct device_link	**link;
 };
 
 /* Register access */
@@ -279,7 +286,7 @@ static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
 }
 
 static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
-					  u32 reg, u16 value)
+					  u32 reg, u32 value)
 {
 	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
@@ -307,5 +314,9 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u8 fn,
 						  u32 r, u64 cpu_addr);
 
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
1.7.1
