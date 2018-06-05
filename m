Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeFEPVT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:21:19 -0400
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:62048
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751807AbeFEPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:21:16 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for finding quirks
Date: Tue, 5 Jun 2018 20:50:56 +0530
Message-ID: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39840400004)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(50226002)(106466001)(42186006)(36386004)(486006)(316002)(51416003)(81156014)(8676002)(110136005)(107886003)(16586007)(81166006)(478600001)(6266002)(8936002)(52956003)(106002)(54906003)(2616005)(476003)(90966002)(126002)(36756003)(50466002)(336012)(186003)(2906002)(356003)(26005)(4326008)(48376002)(47776003)(103686004)(1857600001)(63266004)(5660300001)(305945005)(426003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2198;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT007;1:ZJ9wtGCPhBc6cyeFnKdiY83FQvYsZEWrq5E9ryWIoTr6HrytYSPyALORVjrbdoPdAjpt8C7J+UOhDiqv6ghM4BLjvX7miJJebLsmzA5iBMtVQkXu+wKsKJpdeJrSKigK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2198;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2198;3:j38bZ0OkGTXIz+pSaDGzxFzjyKyRzE8BZo6ACKqYfFFp0k3N7xd8HaMKcbLxuqiGtS4CyBjmRYMIgkxPrmzCllA9UWO1FbCqiZW37bTSCZCZG1DsZ/fz7dSgLZGZ1q2QP/jLLJkCeL8FtO+gVfOP5ws2SOs1+DgPzR91QKfEsQcPlBqXu8Jrijhry0WYG0bPYYMBDtYl+zvsUopSY7TqMUGmDr/H1XD/lUFgI15wCixLISSMbWxGYUhi5Wc99UlAW0UkBhoK9e69BDOMPMCtEchB2iGe1IoRZ0imKtM83dz0XWZ/oAMkNi5qQFWV8V/aBy/5m0bqsLde/2EPD+ckXu1rfINN6Mqt1M1xkqAPcTw=;25:gDr9UasO26xwYcrh5wafCPIn2qNdmeRxo3H+21VfCRvxJEYsCm0pwwhkCPjwdABgrdmF4wyJHjYZDC9Linx4PnIiES+JinVKdq4bpgSolh3bjquurppz48scLp0lVtqNmYNk1EfzLoUKOddRhvfEGgNJ0YZCpkWRC/1tmQG5CftVY9CkvzXxckq7ftmIav4KaZZlmi2EwXc5+3yFMp3qFjLlPOO3afhUc4zlVAGSUzmk3Rs624JIPpofVKCFe70CPvjvo5NaAqsvkf8zURru+B+DR42XHJy6N910fxkqEZr8zdvz5sncDWNoE1ZXZU0dLY5IBMriB1Mz+pLBvkuKRA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2198:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2198;31:B1Szy2pmLVqHrBIcwrRbu0sTV5xxC23Raw9l68jEXJCPfuL7sd7n0cgrEHc7FLG/pApVMN71CABPcRq50lePPSe0yEBsv+wnDkvB7mkkLvUxs7KpUxsY83XXig4mHU/3BrqrSW1Y6Q5BrBXpaoT9pgeIoOFYEf2eTkB4oFbImfARE1eRg3D4H68SUiwZVYR+W99WgLcegQaiTiOTiPsOdomeZwDO2PzXkW+kCiuvsjg=;20:yNEyhZUiY2WX+VGFqcWDCkzERt/8z64AuUw8m+Ef493jfkyXE0FuPUxdj4iSDWdcRLJ4dweCkVN0pQ28Ch5H8JNplVjX36wB4jdEftsDa5zp2VZQEaJSN7iqLReTxogT38cVLvy7bhHKa2A/Rej9td+6NAmLBT9381OXoJUGd9u/CxxQiZmEw8TGPcurJIN3mD/1smPLEj9jNgkTFnHLsRNqsgCKDdyf5rXNXiOHgowZfQ00ZdS6dB+biylwJuJ2AeAljjxhbg+qOd4BsP/2fX00buOZCGNcY229VEpzJbo/JRHOloThjpFcBkZ1yxOL/VvBVpwayHCmX0fxWgXXG+wBgLNjc2Dq6burK/sFS66esJTfuNKYi6VC8xlKNKGdEwRO8tYoDq4PYG6UdasWXZK958qIwQAF3T4Go3R34VLECcN3hvxPDUpCXGetx/JyX9nDPjEwOzooHGCbEpqXH35DY/UOXl4OgR8VNJd/gOePJDW753dridDeOdtY/KPi
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB21981A9223EC3370DD67F43FA7660@CY4PR02MB2198.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2198;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2198;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2198;4:LJ4NuStlch+6CgSZL5Grwu3N1J3kha7Q9e63E+h4mgF7XFUVMvkklUY5bGsD+5FcK2XvNJfXX3W1lgcyNRUvQT/ekAx2Leb3quOUSSk4uy/tvqgE/bkokN4endyAOClO7+YkFHa82cJ7GOYB+L8iVJpwjVuiUYy8YqEINnew/I4JZ+Eir+6EQSur02fmFnQu3QGuvWVW+2oiyPNhu3pYyUR5AW7VMUe60fX6ivDQDc19HRy1VcPPKhANi4bcJ/Xd1L9uO0LM3WT88kXF64wFT8VDldYTzNSVsCuii+iqIMBoD/Qp6hfbY2fJ06oD0Iit
X-Forefront-PRVS: 0694C54398
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2198;23:rZMVBdUGwRk8cEsbBxP9iFyQYAbcLsd7CB+Cnidqg?=
 =?us-ascii?Q?4UpIi7IbpiX+wDiq4NRfs29gULaeiBjnjWixjX6uwuInfOzTqfXtnQJZfb3P?=
 =?us-ascii?Q?FLi1DuLEqlTp6w7jLitQyCUL4kR0nBkGcIfGay8iROWcimJdipfT7LaXU+ts?=
 =?us-ascii?Q?1NfIAOFIfBd0J2pPh2TxMeX38rRw0b5X07usihz50ciK5Ai8CLXrtxyHYrWV?=
 =?us-ascii?Q?WSpDxEmIIVZzNXuwLSS2rru4qZ54sZCOwyW1iViOCQpbCEz1916HxvRTxLKr?=
 =?us-ascii?Q?p/4z6MNjfbmODqO8QkHE8yXmAP1hq8TmJCv9wJ0j/s5PZUlvVWN1ibxn6Lmz?=
 =?us-ascii?Q?4SClcBFFZe0ksl8XliwgEO8rUls3oGzme+yGH1YFjL6T3fylGvZ0YUQ1G1Gw?=
 =?us-ascii?Q?nGY99ccEFNnkXjQ4p3Ae2EvnSf30ibJcVuR4Ik2dSispyZfNdw8cb70xQB5z?=
 =?us-ascii?Q?KHTas97bS6/p3u3XPZcw7dfIHo4PYl1mU4Bew4/j0cS8vUoZBHut6NFIeNLx?=
 =?us-ascii?Q?Ijsl1CcotXiwcITqBNciMxtpgkoa3PzYRXmm3rFmiX/tEi57rKXf8a//P/E0?=
 =?us-ascii?Q?kykzpe6nuOauW4KREbr3cIMyRwnnqZOnXXFh39VYdvRvpSBLmBJ47qKvj0h4?=
 =?us-ascii?Q?PREMw6iEZ4j+KWaFnweEEMT04q47EsNsByr/evIn0GX+ucwbMX7acoxedksA?=
 =?us-ascii?Q?mlbYwywhdXV+L9zoQ/fS4b9DHEzOnvq9k/OOfFVcmzIlHtntyHCtKtT4U2YO?=
 =?us-ascii?Q?S0igY58nuR+lTCE9T5y79RzrUL8DwPD3MteyZLq6RXPRuHaik2A7ilT1axy7?=
 =?us-ascii?Q?Scj4SxpskrGkjMGiT5NutQ0HOIrx0qHP4hEUFHkRh+rOlyfZmmovWzDo8bU1?=
 =?us-ascii?Q?2A/Raz25nV8QWx1gBxIPDPpepZZVGqbdvx/PPthiybXcpgWxS6Dxr95GCZ+3?=
 =?us-ascii?Q?pf1c+1sWA1cILdKMjcgPlrndoffZVxr70brPra4px4fEjFG7BrGwFqfNuAsP?=
 =?us-ascii?Q?L4pTbU0q5e5bNUp0fdAzsxrNDyrHiwfE6NS5Rhq43bo4OjtFJsVpYS4eoMRd?=
 =?us-ascii?Q?l/LkcfrLwLrzDpfoaWlZUwfSQjwfbdE+FOl8h7JK+CFo7ENeSehQmQmReiNY?=
 =?us-ascii?Q?MBtPmNjfCw=3D?=
X-Microsoft-Antispam-Message-Info: hS1HaKKbmRgRyGY6X1Zx2cFeDDKG2HaPZ9N0LlCZLjb9vmZKJq0AEHGHnmLYG06CH3C3boDuIhh9br0gwcUtkqGLrTgBGLvga0HskHu3aAts8eNgBmhIcm/niksQtAk6jGuY8JaahUiY8LB7SSO5CcsXoUVRnrEyzTNRiSVE1ffbMoiwPU10/AYQmMnCzgRv
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2198;6:lSe5qU7xQB+FOdmPdvUBEZgbHLUTZx+/qOp/D6XgwEzAW8+7nneEK+8cQ2FidWGGmXZj6n0jsC9aAOdmkIXJB3Ox0j8IU8Q8KpLI68THpanU5SyAh/MB9K1Iq4ZTLSk6l9cpssMXFiXKLvFSBsXgFegyFQgKWlHa1wNxlasqwtGbciAvYi2LHI+RovzCqkezbQo0E1YGM2mxM5X9+0iBMHsKiIU5wY2/Uf7aVWbLRnxEU9DG1kvYRkHJY01glotPrs3T1mAjNF1BHAKq02OAg1NDNvnPPVr9rXEqhBe/k/z1Cc5iKmJnzdDTdFuXvMDJFkNmESFiTE1BynwKaceSHF3Vr0wPW5Scl8sIM0xyQWznBHKedovslpKpf/i/Dc+qGJAY+J0f56WeRgCwPTzO/4whrrfTnQ7qBD2U2j+8dYH1fxhGh5Kaoxwse48lBfdkOpwnqCTr48BH3svQXtA4qg==;5:kRgy4EBSzqJsGYHBQnLWN1zty0dcTWq4X7ozMRpijJd8Shn1ikyszN2xpz63S44kbDfpcEaZ5GeSJnH/Me2STHckh+rCzpIJQuAqrnhxnF3NYeBgcrmsAVPOSsd8vpiOrgy01mgh6g3jrzeehY+5Cyls6g+4hKywhD1JwgPgXNA=;24:jW8HOd4ppj1RCU3Lpi6BlA1Azc62S2WlKV78/sVGANg28uxqDLOZMsyU6vxzo60jcLvtanpgZN4lT1DYOa//YPqVQYo+Fk35l1EAiqL9UFQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2198;7:JigGXWY93mVBg4ZWFyuc134aNugafsoV9rNCclYqIC6/W+IE67vhqldZyWfuUHIaUmn03e+A00OyvJLgVSzwbRZsYRORxEviFDvh2I1wEnMxP15mGIK5h7cGCwQxCBa0CPhyPUwiPc3okp/I0RSBAtd/sZtVFqcXsMapMZRUIY+HvATgcRZYQ7Ov0qoG3n4TfdhcXQFRpvLeTZlu4bRyWvxt7iQnHs0xmmci4to+yrFjeHKNd1pk+e18QxUk0B6l
X-MS-Office365-Filtering-Correlation-Id: f352a2d3-1b05-4c95-3aa3-08d5caf7f9f7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 15:21:13.9442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f352a2d3-1b05-4c95-3aa3-08d5caf7f9f7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2198
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xhci_plat_probe() both sysdev and pdev->dev are being used
for finding quirks. There are some drivers(like dwc3 host.c)
which adds quirks(like usb3-lpm-capable) into pdev and the logic
present in xhci_plat_probe() checks for quirks in either sysdev
or pdev for finding the quirks. Because of this logic, some of
the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
host.c driver is getting missed).This patch fixes this by iterating
over all the available parents for finding the quirks. In this way
all the quirks which are present in child or parent are correctly
updated.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/host/xhci-plat.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1b22fc..0cd0489 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,7 +152,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct xhci_plat_priv *priv_match;
 	const struct hc_driver	*driver;
-	struct device		*sysdev;
+	struct device		*sysdev, *tmpdev;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
@@ -272,19 +272,26 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
-		xhci->quirks |= XHCI_HW_LPM_DISABLE;
+	/* Iterate over all parent nodes for finding quirks */
+	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
 
-	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
-		xhci->quirks |= XHCI_LPM_SUPPORT;
+		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
+			xhci->quirks |= XHCI_HW_LPM_DISABLE;
 
-	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
-		xhci->quirks |= XHCI_BROKEN_PORT_PED;
+		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
+			xhci->quirks |= XHCI_LPM_SUPPORT;
 
-	/* imod_interval is the interrupt moderation value in nanoseconds. */
-	xhci->imod_interval = 40000;
-	device_property_read_u32(sysdev, "imod-interval-ns",
-				 &xhci->imod_interval);
+		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
+			xhci->quirks |= XHCI_BROKEN_PORT_PED;
+
+		/*
+		 * imod_interval is the interrupt moderation
+		 * value in nanoseconds.
+		 */
+		xhci->imod_interval = 40000;
+		device_property_read_u32(tmpdev, "imod-interval-ns",
+					 &xhci->imod_interval);
+	}
 
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
-- 
2.1.1
