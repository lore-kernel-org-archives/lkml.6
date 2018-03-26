Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeCZMSw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:18:52 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:40064
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751076AbeCZMSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:18:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
From: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        marcel@holtmann.org, devicetree@vger.kernel.org
Cc: madalin.bucur@nxp.com, alexandru.marginean@nxp.com
Subject: [RFC PATCH v3] net: phy: Added dev-addr device tree binding and MDIO enablement of non-standard register addr space
Date: Mon, 26 Mar 2018 07:18:25 -0500
Message-Id: <20180326121825.13476-1-vicentiu.galanopulo@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: vicentiu.galanopulo@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: CY4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:910:4d::31) To AM6PR0402MB3573.eurprd04.prod.outlook.com
 (2603:10a6:209:8::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74ef9253-10d9-491a-04b6-08d59313b918
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3573;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3573;3:fLl2RgaWIyOjt8clMUnypDrF64fDN8deXPmRtE1epV7LgzIVIQTIG3he6NBhhhq2ARoIdLX8mVTiFmPo9oOdynNTJIG9DWhp3M8HTKlhhnkL9rhyTsRjA/lWuRLpySe5kNTwBQUfyqENt4gdxwgpyjnPx68Y54lGVDSAINagDdbRIGrL6rtNe6El9teUUOrJxYvM7c192kjRZijHlmLw+PVkBGgANJ1mPqzK/P5qwMNu0XUfXrJ0L3WMEACvQB13;25:rqIHge1E7QFNcmYWNFFKKb7EiDYh4dya79xt/jcpJmFdu1ZOjkA/Dn6CPXzRW0fBecgX2yQrINpSRmXOcFnH292gkhcZtHIAKOLwT7ey+HVs6iTf/U4nH+f1ttrcgrezxFEgJnJOBpHqizNzduzRc25nMOgyTYwHm3e1ajlC0nVf3sixtEt3gHvjQm6zJEi8vlu9xQjHorxOMW+ffBzuUV2HhyoRpcbbaTDcjEeIFjG8VEVR/snE22Co1F7Hyb/AcAyoKf+fcngVulpO7uQhoV7UxMkOLCZuOSFa3G7frX8r2d1B+RUGJ571aDH9urmFdEGoX5oSLi+xggo0Fs5XMA==;31:t7PPd9feTKpeP5Ua9e6CuCfw/oTmAA+NuPidqvWKHQEo1zxAZtUfbFP2NXwR7zL5xGOd7IxrsPViIp9At9sZ+GvrvGlGdMYR2uiQrqrxWM4KWhpNrWOGcWy/I/kEAEoQGaCcSWlPgiAxfPSjn6CELLr2gD6bIZI/V6//DR2E5awaFKBSQBCNiN3FHXp+z94vUjO1F2fXfN1gTfSOqf8v2mPAYBl476K0DYUGlQzFDng=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3573:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3573;20:Sw7wOeCoAV+fts4onnIXUoNdGQWqombvepPb1Ln5NA386qAwr/h5LUWElHDFQvDsy/YLuU+y8poTsZ8hsZ828fR4TT215ipbTSyjHhAa/6+LAcXx28sm/pxjcqvrOvj/YY/hIs9VrDpSxCPzij5wMohJCI63UjmVER/KyKD5EBM5tNwOxSPPHx3PSE5CWhwxsDG0phmpZt/vFpqow7wzc7iSMelj0dWa3E/88dLJeGfMPQlSyuYwqYf77MKub4MLXcTMqBskya9Vt5T19POeIo0Oi4Q13HgtDKQlrMSo0FR+3KN8AmrOq8nr71YTIiomPO9AqOuJMyXLyQ62g1qKjOybSllQpoSZYLEH15hOfz/FNxqmpvBCzQ1vb2xBDvUjOluJgNiT8ivwdNez1zQhpL7ePJZKcpGjQxeDu7rlLCvxLanp6dgzi7KNjtHfcA5kItypPsvixZqOetf1bHJ4+pz8JL439DFlUOlqnOP2+yzkK9naZ/oWMhwCYPDdJmqP;4:Y6tpvP6v3ggCBLk3rKfpw4L/ZYAQ3Tc2zBf5485P/ULkpcsZ6QISZyqe/HZUNajUmhw0MKySnQPCDkNkW7yZat6/7krQtVofz25vME9EtnH0A+wvHctByD0JISw+OjGwafBmhLHnRioKqWnyMsp8qCQv0GQjrIZDvU66qNhN7VXELIPhk6RJjio01JXIP/3+Owiijc7aumfdyauBNPz+iU84HdTT6EeITBNLplmnwOJcxTQiwyOBCS7bWZ5K8dKFO8sMt49ekNfRrzsCTjdLG2HZIDra/CJxuJ83WtinqiU2+wJuaFE1omcJdrA1IfOy
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3573ED57813BBBE49F9F3BCEEEAD0@AM6PR0402MB3573.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR0402MB3573;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3573;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(199004)(189003)(50944005)(68736007)(575784001)(2906002)(7736002)(478600001)(1076002)(305945005)(5660300001)(386003)(6506007)(4326008)(16586007)(25786009)(36756003)(316002)(3450700001)(50226002)(97736004)(8936002)(86362001)(81156014)(81166006)(8676002)(52116002)(43066004)(47776003)(51416003)(2616005)(956004)(106356001)(50466002)(48376002)(59450400001)(105586002)(6512007)(6116002)(3846002)(66066001)(53936002)(186003)(16526019)(6486002)(26005)(6666003)(217873001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3573;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3573;23:FOeBlmxQ4Fa3ITIC/xr2fPhe6eZYNOSMKciSZdl?=
 =?us-ascii?Q?fJkErbbiPkK2HLdvIfA7OSlAm24EdZIoIbyp0XmVhgGZ7g9xUU+fU4ebda1j?=
 =?us-ascii?Q?Xu5eeMc7zBozijYBjZ5WCitwAdXWA9u2FksBYnMbDilIqxMfP/hrB3VY/CIg?=
 =?us-ascii?Q?nKVBlXoaJXBRv0f99FDKnad6zCZzi3IM884UCM3/Iscw1gznobfclChcZWCA?=
 =?us-ascii?Q?IjBAAc3R5GQxJcWxhdSOA7Cnto+PUmE4i8wAs1BFAfh4meOECu2XqVoLJ17O?=
 =?us-ascii?Q?DAWmk/shBBh7yx4nE9HF2AoYU6DlYArjUULa70fzagw/tl326amUo3LRF8mA?=
 =?us-ascii?Q?ZtSCo7ypiy1sxX284POZqjJIPZxD7Zk6XwA8Gs0eGq2SHvN5WeF1066IKhbX?=
 =?us-ascii?Q?yUwaXtuDwKx+P/2NbFKGZw06+zPuAjJW72gSZb8TwvB/B+L67TuBc/SuYGTU?=
 =?us-ascii?Q?jm/9jHVtIc2RkENewSUgvWDajmSSjaWE3t9ZnuF67dedfcrpTshyRR42H16I?=
 =?us-ascii?Q?EdhPq9c5uFHT13oCZ6ITvfEsrzfD/kyA+xouxmmWfasBiruNIHMAFh46ojsn?=
 =?us-ascii?Q?Fy0NOmGgZoauM/+nemzm81E3RCun8NgQPf+AQsfrjefSC8EmrTLcvCX1rtsG?=
 =?us-ascii?Q?R4biTWuvNrIzs1C7xb2HfsfflSVvNe6jNY/LJGGdqH0oQZX7WH6iTQ8LdyX/?=
 =?us-ascii?Q?tyHTmJY0DG14SyE+R0h1GWyh/xGpUjec74ZZx5G2coFaM0p6YDlUgvADqtEv?=
 =?us-ascii?Q?FQC4UHr7Ge7IwAQCyXK45/N7Q28QmMtis0/DrregACpXfJrYMtu1TvCFlVLm?=
 =?us-ascii?Q?YCsA2ymyRUgW4Oz8sdqxV/RFaZn0pvKJ3k1qr1eXfK6p7+3q4nh5FQioLJDg?=
 =?us-ascii?Q?fgBaPSSJI55dFZ43uacO1kVv+EL58Sic7BIVpPByU+vdX94rYIMn3CKOIAJo?=
 =?us-ascii?Q?3nBnZpiqC3Lrlj+WMNZ1V1qfBQ4YNtt5Wt155xIytYw6lfKiy4c3jk2VUoTO?=
 =?us-ascii?Q?szxyPHb+w5XS3XQzwdpZVuhwit9WTzyIKIjQOJT+qVqPVFLivfeCwaluT20T?=
 =?us-ascii?Q?WGw2cie22o2bT/urBZ41aNY0doXYVBDojj59bQLuamGrnebe6u7R6zAqAEj1?=
 =?us-ascii?Q?JuzYRTlLEIiZRhJ7CLWY25SkQt7Ph8uWX084gx1WGBFlXrnJS2jVeEBrDy5t?=
 =?us-ascii?Q?bAIH6PQ4/r+pHkXBoTMNiJxks/1NqYWHFKl5o7dsYNASrHH/CRRIX3QbOLso?=
 =?us-ascii?Q?HtRATo1ZiQg1rCmg3klI=3D?=
X-Microsoft-Antispam-Message-Info: GP71hRaoJVBEwZOPU55lsJzl6nE/O8rr3dY2rJFX6SDT+IE+3bqqmNmZ2fd3bs/7gKahHLHIzyS6sWUNG0h7bLCoPZVYLClL7QWjGNHhYa56L6IHLDbZgEuowQg/RGB8zdNlIEZdMu1udWrI8ETDFKJPvSiRoWpDITvLSB/vubt0U1eReqjPtwkRHmiZWwHo
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3573;6:BddVQCah+dlpL0nE48qHHEgXHsb3tXxtv5N99fYmZtxmoczPFWh8I/UWlBD5Mfs5UbhIFat7VgnzHvkIexENzkSLwXNlwIzHuACnVDX3dpRopv0zqkmQGhimqhtNvEtxAcKHxNOSvdXsrXs/JVZKU2UeRibZ7VTrRuVd/4feL0io/NTNBfpD8dqYkBmFBPuzLCxojG0v55ODwAZChcnkMdrGy4GL63i4Ap1hZJCIiSAnioBbbRMvl30TqhYzZ6hkDmxmURsmL7UxQOvVm/e7AP0lbkcv12710zT9w9jfuylrvw0Q/RnLvT4/hx49+jIfBiMValHWo+oE8wDwDM7HvW/8t0MEQBAerB2IzY626iQGvdGDjplBHonhTyOK/NdHQ4qtb86jh+dN/xBhFuPgyjtfjIlNN9xtXWSEzeGmQza2qw/1CX87QPU3+vBY3dHjwGOiPYvyHl8sEeaun2UFIw==;5:Ffq5iz2R16idBr1LgWcGyyiTRBegt7wqETp77zFTIkepl1FEC5e6eUgTwaMlTb2fbOKB2NimWclwHhPrl/YERc+vEM2gskL0XA49jKbfvKRAiSk+QINSvJXlKAd/oxkn2czwdRbgS0/bhEg2uwbF0VIvtzUUmCAEwggeecbugn0=;24:1gb3V5+30/HvYTW6XRw11wIDpcoBpHdDH1PXm5sQchHF5IfqprhsmHWHcr/nGxXEuubIb113AtucNwqxjQqYew35bDzgbSebSa+Ce6segfI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3573;7:O/Kt+XHxOlW3G45J2nmnxVG01UpCF6jGriHi5ZibE2iCXOKGo0iUwh/TrJc6etf3i/gktUTzK1zwhg/LmQT2XVcOIpicX4C5Lgeb0NvWvIfXCYRUCpFCiboHLus4mGxuAVocJG01j5CRzZPuDymqfl7puVeYqtAD0Z6mgtQTTDf9tvi4ygl4YfMdzxR09nURkUiP7XZyaON0nSPV7X+N/p3dHtFOTQaEPOW9nD/zlEFf934YWMNV60t56moUQH4S
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 12:18:44.4469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ef9253-10d9-491a-04b6-08d59313b918
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3573
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the discovery on the MDIO bus
of the INPHI PHY which has a vendor specific
address space for accessing the C45 MDIO registers

A search of the dev-addr property is done in
of_mdiobus_register. If the property is found in
the PHY node, of_mdiobus_register_vend_spec_phy()
is called. This is a wrapper function for
of_mdiobus_register_phy() which finds the device
in package based on dev-addr and fills devices_addrs:
devices_addrs is a new field added to phy_c45_device_ids.
This new field will store the dev-addr property on the same
index where the device in package has been found.
of_mdiobus_register_phy() signature call has been changed
and struct phy_c45_device_ids *c45_ids was added.
If c45_ids is not NULL, get_vend_spec_addr_phy_device() is
called and c45_ids are propagated all the way to
get_phy_c45_ids().

Having dev-addr stored in devices_addrs, in get_phy_c45_ids(),
when probing the identifiers, dev-addr can be extracted from
devices_addrs and probed if devices_addrs[current_identifier]
is not 0.

This should probably be in a separate patch but I
found it in the context of enabling the discovery of
the INPHI PHY:  num_ids in get_phy_c45_ids,
has the value 8 (ARRAY_SIZE(c45_ids->device_ids)),
but the u32 *devs can store 32 devices in the bitfield.
If a device is stored in *devs, in bits 32 to 9, it
will not be found. This is the reason for changing
in phy.h, the size of device_ids array

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
---
 Documentation/devicetree/bindings/net/phy.txt |   6 ++
 drivers/net/phy/phy_device.c                  |  49 ++++++++++-
 drivers/of/of_mdio.c                          | 113 +++++++++++++++++++++++++-
 include/linux/phy.h                           |  16 +++-
 4 files changed, 176 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index d2169a5..82692e2 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -61,6 +61,11 @@ Optional Properties:
 - reset-deassert-us: Delay after the reset was deasserted in microseconds.
   If this property is missing the delay will be skipped.
 
+- dev-addr: If set, it indicates the device address of the PHY to be used
+  when accessing the C45 PHY registers over MDIO. It is used for vendor specific
+  register space addresses that do no conform to standard address for the MDIO
+  registers (e.g. MMD30)
+
 Example:
 
 ethernet-phy@0 {
@@ -72,4 +77,5 @@ ethernet-phy@0 {
 	reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	reset-assert-us = <1000>;
 	reset-deassert-us = <2000>;
+	dev-addr = <0x1e>;
 };
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b285323..3cbae4b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -457,7 +457,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
 static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			   struct phy_c45_device_ids *c45_ids) {
 	int phy_reg;
-	int i, reg_addr;
+	int i, reg_addr, dev_addr;
 	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
 	u32 *devs = &c45_ids->devices_in_package;
 
@@ -493,13 +493,23 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 		if (!(c45_ids->devices_in_package & (1 << i)))
 			continue;
 
-		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID1;
+		/* if c45_ids->devices_addrs for the current id is not 0,
+		 * then dev-addr was defined in the PHY device tree node,
+		 * and the PHY has been seen as a valid device, and added
+		 * in the package. In this case we can use the
+		 * dev-addr(c45_ids->devices_addrs[i]) to do the MDIO
+		 * reading of the PHY ID.
+		 */
+		dev_addr = !!c45_ids->devices_addrs[i] ?
+					c45_ids->devices_addrs[i] : i;
+
+		reg_addr = MII_ADDR_C45 | dev_addr << 16 | MII_PHYSID1;
 		phy_reg = mdiobus_read(bus, addr, reg_addr);
 		if (phy_reg < 0)
 			return -EIO;
 		c45_ids->device_ids[i] = (phy_reg & 0xffff) << 16;
 
-		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID2;
+		reg_addr = MII_ADDR_C45 | dev_addr << 16 | MII_PHYSID2;
 		phy_reg = mdiobus_read(bus, addr, reg_addr);
 		if (phy_reg < 0)
 			return -EIO;
@@ -551,6 +561,39 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
 }
 
 /**
+ * get_vend_spec_addr_phy_device - reads the specified PHY device
+ *				   and returns its @phy_device struct
+ * @bus: the target MII bus
+ * @addr: PHY address on the MII bus
+ * @is_c45: If true the PHY uses the 802.3 clause 45 protocol
+ * @c45_ids: Query the c45_ids to see if a PHY with a vendor specific
+ *           register address space was defined in the PHY device tree
+ *           node by adding the "dev-addr" property to the node.
+ *           Store the c45 ID information about the rest of the PHYs
+ *           found PHYs on the MDIO bus during probing.
+ *
+ * Description: Reads the ID registers of the PHY at @addr on the
+ *   @bus, then allocates and returns the phy_device to represent it.
+ */
+struct phy_device *get_vend_spec_addr_phy_device(struct mii_bus *bus,
+						 int addr, bool is_c45,
+						 struct phy_c45_device_ids *c45_ids)
+{
+	u32 phy_id = 0;
+	int r;
+
+	r = get_phy_id(bus, addr, &phy_id, is_c45, c45_ids);
+	if (r)
+		return ERR_PTR(r);
+
+	/* If the phy_id is mostly Fs, there is no device there */
+	if ((phy_id & 0x1fffffff) == 0x1fffffff)
+		return ERR_PTR(-ENODEV);
+
+	return phy_device_create(bus, addr, phy_id, is_c45, c45_ids);
+}
+
+/**
  * get_phy_device - reads the specified PHY device and returns its @phy_device
  *		    struct
  * @bus: the target MII bus
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 8c0c927..52e8bfb 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -45,7 +45,8 @@ static int of_get_phy_id(struct device_node *device, u32 *phy_id)
 }
 
 static int of_mdiobus_register_phy(struct mii_bus *mdio,
-				    struct device_node *child, u32 addr)
+				   struct device_node *child, u32 addr,
+				   struct phy_c45_device_ids *c45_ids)
 {
 	struct phy_device *phy;
 	bool is_c45;
@@ -58,7 +59,12 @@ static int of_mdiobus_register_phy(struct mii_bus *mdio,
 	if (!is_c45 && !of_get_phy_id(child, &phy_id))
 		phy = phy_device_create(mdio, addr, phy_id, 0, NULL);
 	else
-		phy = get_phy_device(mdio, addr, is_c45);
+		if (c45_ids)
+			phy = get_vend_spec_addr_phy_device(mdio,
+							    addr, is_c45,
+							    c45_ids);
+		else
+			phy = get_phy_device(mdio, addr, is_c45);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
@@ -190,6 +196,72 @@ static bool of_mdiobus_child_is_phy(struct device_node *child)
 	return false;
 }
 
+static void of_fill_c45_devices_addrs(u32 dev_addr,
+				      struct phy_c45_device_ids *c45_ids)
+{
+	int i;
+	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
+
+	/* Search through all Device Identifiers
+	 * and set dev_addr in c45_ids->devices_addrs,
+	 * if the device bit is set in
+	 * c45_ids->devices_in_package
+	 */
+	for (i = 1; i < num_ids; i++) {
+		if (!(c45_ids->devices_in_package & (1 << i)))
+			continue;
+
+		c45_ids->devices_addrs[i] = dev_addr;
+	}
+}
+
+static int of_find_devaddr_in_pkg(struct mii_bus *bus, u32 addr, u32 dev_addr,
+				  struct phy_c45_device_ids *c45_ids)
+{
+	u32 *devs = &c45_ids->devices_in_package;
+	int phy_reg, reg_addr;
+
+	reg_addr = MII_ADDR_C45 | dev_addr << 16 | MDIO_DEVS2;
+	phy_reg = mdiobus_read(bus, addr, reg_addr);
+	if (phy_reg < 0)
+		return -EIO;
+
+	*devs = (phy_reg & 0xffff) << 16;
+
+	reg_addr = MII_ADDR_C45 | dev_addr << 16 | MDIO_DEVS1;
+	phy_reg = mdiobus_read(bus, addr, reg_addr);
+	if (phy_reg < 0)
+		return -EIO;
+
+	*devs |= (phy_reg & 0xffff);
+
+	return 0;
+}
+
+/*
+ * Finds the device in package and populates the c45_ids
+ * if any device is found at dev_addr address. After this
+ * the PHY is registered
+ */
+static int of_mdiobus_register_vend_spec_phy(struct mii_bus *mdio,
+					     struct device_node *child,
+					     u32 addr, u32 dev_addr)
+{
+	struct phy_c45_device_ids c45_ids = {0};
+	int dev_err = 0;
+
+	if (!dev_addr)
+		goto register_phy;
+
+	dev_err = of_find_devaddr_in_pkg(mdio, addr, dev_addr, &c45_ids);
+
+	if (!dev_err)
+		of_fill_c45_devices_addrs(dev_addr, &c45_ids);
+
+register_phy:
+	return of_mdiobus_register_phy(mdio, child, addr, &c45_ids);
+}
+
 /**
  * of_mdiobus_register - Register mii_bus and create PHYs from the device tree
  * @mdio: pointer to mii_bus structure
@@ -202,7 +274,10 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 {
 	struct device_node *child;
 	bool scanphys = false;
+	bool dev_addr_found = true;
 	int addr, rc;
+	int dev_addr = 0;
+	int ret;
 
 	/* Do not continue if the node is disabled */
 	if (!of_device_is_available(np))
@@ -226,6 +301,14 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 
 	/* Loop over the child nodes and register a phy_device for each phy */
 	for_each_available_child_of_node(np, child) {
+		/* Check if dev-addr is set in the PHY node */
+		ret = of_property_read_u32(child, "dev-addr", &dev_addr);
+
+		if (ret < 0) {
+			/* either not set or invalid */
+			dev_addr_found = false;
+		}
+
 		addr = of_mdio_parse_addr(&mdio->dev, child);
 		if (addr < 0) {
 			scanphys = true;
@@ -233,7 +316,14 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		}
 
 		if (of_mdiobus_child_is_phy(child))
-			rc = of_mdiobus_register_phy(mdio, child, addr);
+			if (dev_addr_found)
+				rc = of_mdiobus_register_vend_spec_phy(mdio,
+								       child,
+								       addr,
+								       dev_addr);
+			else
+				rc = of_mdiobus_register_phy(mdio, child,
+							     addr, NULL);
 		else
 			rc = of_mdiobus_register_device(mdio, child, addr);
 
@@ -248,8 +338,16 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 	if (!scanphys)
 		return 0;
 
+	/* reset device found variable */
+	dev_addr_found = true;
+
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
+		/* Check if dev-addr is set in the PHY node,
+		 * for PHYs which don't have reg property set
+		 */
+		ret = of_property_read_u32(child, "dev-addr", &dev_addr);
+
 		/* Skip PHYs with reg property set */
 		if (of_find_property(child, "reg", NULL))
 			continue;
@@ -264,7 +362,14 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				 child->name, addr);
 
 			if (of_mdiobus_child_is_phy(child)) {
-				rc = of_mdiobus_register_phy(mdio, child, addr);
+				if (dev_addr_found)
+					rc = of_mdiobus_register_vend_spec_phy(mdio,
+									       child,
+									       addr,
+									       dev_addr);
+				else
+					rc = of_mdiobus_register_phy(mdio, child,
+								     addr, NULL);
 				if (rc && rc != -ENODEV)
 					goto unregister;
 			}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5a9b175..f665945 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -357,10 +357,13 @@ enum phy_state {
  * struct phy_c45_device_ids - 802.3-c45 Device Identifiers
  * @devices_in_package: Bit vector of devices present.
  * @device_ids: The device identifer for each present device.
+ * @devices_addrs: The devices addresses from the device tree
+ *		   for each present device.
  */
 struct phy_c45_device_ids {
 	u32 devices_in_package;
-	u32 device_ids[8];
+	u32 device_ids[32];
+	u32 devices_addrs[32];
 };
 
 /* phy_device: An instance of a PHY
@@ -904,6 +907,9 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
 				     struct phy_c45_device_ids *c45_ids);
 #if IS_ENABLED(CONFIG_PHYLIB)
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
+struct phy_device *get_vend_spec_addr_phy_device(struct mii_bus *bus, int addr,
+						 bool is_c45,
+						 struct phy_c45_device_ids *c45_ids);
 int phy_device_register(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
 #else
@@ -913,6 +919,14 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	return NULL;
 }
 
+static inline
+struct phy_device *get_vend_spec_addr_phy_device(struct mii_bus *bus, int addr,
+						 bool is_c45,
+						 struct phy_c45_device_ids *c45_ids)
+{
+	return NULL;
+}
+
 static inline int phy_device_register(struct phy_device *phy)
 {
 	return 0;
-- 
2.7.4
