Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeCTNqr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:46:47 -0400
Received: from mail-ve1eur01on0069.outbound.protection.outlook.com ([104.47.1.69]:10945
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753620AbeCTNql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:46:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
From: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
To: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org
Cc: madalin.bucur@nxp.com, alexandru.marginean@nxp.com
Subject: [RFC PATCH] net: phy: Added device tree binding for dev-addr and dev-addr code check-up and usage
Date: Tue, 20 Mar 2018 08:46:15 -0500
Message-Id: <20180320134615.17817-1-vicentiu.galanopulo@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: vicentiu.galanopulo@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: MWHPR2201CA0052.namprd22.prod.outlook.com
 (2603:10b6:301:16::26) To HE1PR0402MB3577.eurprd04.prod.outlook.com
 (2603:10a6:7:84::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20242c9a-a51d-41a7-3086-08d58e690081
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB3577;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB3577;3:sfc1GSUFsKfjHbazaVn0QcZEBXKImLaunWBmbe0VYMWfXXt+uM9Pi1jwJtCaNAdihZBu3XwqHUb5M/Bq5S6X1PZr3wNAWdn5bVfpgtMOerXpAQZhofJHvPXmP4Ksl1Jl0oRRwEld6GqabhuLQpJh4FrHyHObOwRVkn9C788jnoe2zcd4X2n8zB9DYQYkReJaQJjC1FxrdfJVqLUjolWiyI/A9Gxn1b8j4GCvjyzze3gn61f4vrwOgqQb+qMWPbme;25:7n2Q1MFVdd4Cj9VZEiOzgc+9u7r9E/XDtfHCXu52DqoR9HFhFnDS4I5y46k1dEMPb70haGN5y4Als5JrAspuPussBb1f/c+OGOrEiAyMVD9IrgXOOfeNSI9WVSeF5XszDjVqBJqMaOUQNnjGy5UFpJRLpCX/8ZY8xMU1l9WRpb6xO3gMlUHEGaZRmcBYTnnFBbsFkk/b9bi902gurcs0RA2g2UPEZkJlnlktriOeDk/ytF8yLYpTQUlnJ7lWspQSuq3G9BngKWU58ISXWGxA4KP3Frexn2EVvQaiWpBni2H+yklnz830YEgD8TnyTN44mHy8PflgOrVlE3h+eoWBlQ==;31:oiopvPsBagkyASkm+T6oLVQNTeR4jKKJZy5e3dI95u7kWJmW49ze3tkAaHTdEPFbI92vffpfuAMSR9Y4OXHNkguWHVMSP1dmQJnp1U+kVvDXDBEeVbirjKavSuAunwxacqcIQdMdwFTCf1IwVWCZAykevJ0IPqfn8Fm+TRSuFA4rF0iPgtDF3rPsXiiEPKjIX+ph1ym09uD3RE/3ibCfj6CvjbLouYLFeKWvWcytFE4=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3577:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB3577;20:3vZ0Ih55UtVUC4Wu87/wQOSDBhhbCNKb2JrOdIksiDIAwVPdZkB/LNrtg0AaL+qnFoDQqxiQXkfzpjSfpF/l/Z75gNLHPb5BPCGUzT8W1OHWkwEz+Ny93l81emrXLlE0hQEenMXpDnkoOC3+yN9aFMvvrwisyzrEs5GKMjuwCpD7VPFnX/p7FsliYwj4zULeMOWF7WxAqV4Gx84MhBWrofmQQpEHjsg6HiEVihhkRY4G04IBqwBOsWC2mj4+FxlnTy0XrPT2Zz3cd5pNXxLTvTsM0prjLjqbE6x2ILlC5Ipq+ZHNEkbiXalN8hMXB29AI8yTWAJBkReIn/vxcjDoaB+G3IV1OCr4VYfBeIhEm/OOR1dqMt01Oy7T4e2NssE2EOlrS9D0q4GUpIwxLU1odzqxhzP46mihllOxeW5xExAp30bhaGjKsNKMhIrilbOxtlKbgjtEFu40/4pzxRhdj2tw1m4o1/G2G5lNlIQZ9bOkKHpelIfa/D6jb0CW9CRx;4:9uCqQI2bpGI1cHNB2fgTD9i6JPCjnZNd+OUIY/yL1mOcIjz93Z0Jfh2COB87SZUU/NtCno5pjRAyusescx/ILZwAd4/VKqbPzESw2BvoGW3ugz3ji5Gju4m/sVsluDwZo/6nvEiLUr8uPzE9Qf0WrvFbOWrQVN2h6J3LMt/NaHNAtIcWVuoLHKNLZTNwRzPgFrG4lIF95uEsGxuHVPjpK3m/PwgB6M4J5OHn2xWTSJ0xsYmzto7mf7TqsXymK3wToHbzJGu5K++IDNd9Luhn2NxAdCkTNojfeVyAT/QZsz6OUDExNB6CC7nDhYCjFzgd
X-Microsoft-Antispam-PRVS: <HE1PR0402MB35775C662E5A4E02DDDC11A3EEAB0@HE1PR0402MB3577.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501311)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0402MB3577;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB3577;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(376002)(39860400002)(366004)(50944005)(199004)(189003)(52116002)(2906002)(478600001)(68736007)(50226002)(105586002)(6506007)(1076002)(86362001)(51416003)(316002)(3846002)(97736004)(386003)(59450400001)(6116002)(8936002)(16526019)(26005)(4326008)(81156014)(6486002)(8676002)(81166006)(186003)(6666003)(3450700001)(48376002)(66066001)(5660300001)(47776003)(50466002)(25786009)(106356001)(6512007)(16586007)(39060400002)(36756003)(43066004)(305945005)(7736002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB3577;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB3577;23:ELdEq6NpZzbj+4O03T54+HOttgV0x57zTi+8SCM?=
 =?us-ascii?Q?lSr9RClc+fQ2DQpDnsObmikxLjkvZ+VU1BAgRIBuMcmPXll9SHnaivPpKCHa?=
 =?us-ascii?Q?xkphsUm+HavcojXnnbYDs9E+gaqYR6IJ87EtKSc2o7CKveU2COXqPuZ/HN9n?=
 =?us-ascii?Q?0eri34vs5WuPUgSKvLARxzs0FOwuqA5dFYe/t3r8PiX/uM6VNE55UC5fAvlu?=
 =?us-ascii?Q?gOaWWNczx4mu7h7EOu/0c+0yymQ58LcFWU/i8rVd3HdxH1dHugUwPPUQynrq?=
 =?us-ascii?Q?3WLijEm5iKipyaBJeUooB9KZ98if7aXgajD+1itxeD1kYmnwN3ufozrNJnCS?=
 =?us-ascii?Q?GOGlhw6xRduUE/omMIEECSZ1/2TBRpN7Wc8dqrjiKj/czlX2Iz6Hn1m4fLmv?=
 =?us-ascii?Q?Od6SiJRmO4R5DPBOmWpPAPvuRwPKrv/TQXiYv+qiOS1OMfOHs8Gpd/yMSvIW?=
 =?us-ascii?Q?xNDc9kK0ec1STCXBXPUPJulRNWoE8MgLNutiQMF2pcwgwZfNEBQ+PHKahUPF?=
 =?us-ascii?Q?BdTMGFtipGUDPZ/FDj+zB81Mn/aq0L3MX/wyfSsqaxYTlvKjeV5QHIb/CtCH?=
 =?us-ascii?Q?zcqIV0rTLK/7g2ZjFk8WAvUnU14qJ52sIzOc3p3LJECHCDJ3t3Up51VbWR0Q?=
 =?us-ascii?Q?1NAFc6NQ2rwJMw8rr3UCOe01zjNe6uUbwGGme/L7ha9+iPEC72ZeXXo/Er6v?=
 =?us-ascii?Q?R7JQQL9jT6WpLyTRz040kSwYWWnRjbORG4So364MdJ2bTA5OAYRUWJOGQrMU?=
 =?us-ascii?Q?34DnLEfTxoIoEK4DO7cncxSCZc3EJhXd57ExUxNLMPhHMB4evTSr2ZNTgxct?=
 =?us-ascii?Q?DmTMnapM4B3eo2vNKAv8Nk0gLj3wBwr/pCiqG+T7zzwwMJJKzCJGK+1/3X/i?=
 =?us-ascii?Q?HqUvserwtHrOB4zSLCO/VnvxKv/coRfl65wF0jzPx3Ek3zWZmSzaOZDSewku?=
 =?us-ascii?Q?6JqEu9V2mP90MRifQNs5FywKgwe+3qCsaILvGjQImVoBZ6jVfj6L3LDEPkE2?=
 =?us-ascii?Q?otDvTKLfWuEeFgwXEUN5bhGDXRpRE9q1wbg6HcpxikkmM1i/wSk4ShiMhTqO?=
 =?us-ascii?Q?5GPyVtWmnMCAJNyTyZQkI5+zFMq2xLit43Dy0YjYwsyTxBqykYbZEmJOnBUf?=
 =?us-ascii?Q?xtkoRpmYWgGBHCqaV5BneWkIFx+fLNh8AcQc+b/l2bvFb87Gv91oE4FZE0SY?=
 =?us-ascii?Q?SvYFXSZ/+gUNtcMQ=3D?=
X-Microsoft-Antispam-Message-Info: lN24/awjMbDc9UFcdrtAKOOplH1tuKbd7NE7o/8p4q7DbFsA9oUrFKP0J0c3pRnXNSGvg+2C7vCmp1SltxOipyAXy1FtlXmK6bBLcVZ2M9F1uNEIt1MU7/bXR1Nkq622Bs6l+CnxCySqYTvCN+dfUTAZe/aPbgdv86hG6IINXR5iHHZ46peDyz9PIopDtZtI
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB3577;6:f1qTky040HrEn9YkrZrWW7nSNWMSuvoXm+/uurcfMNme4n7I0ZE3/8UZx2A9C65v8JuRBOCkTohSTmOQL/v5twJIfd+Y43k1FO1K9Ml4CgpMdIVeBK5GwHqD3JLiSwVZ3NFexW7zkKVR7jJ61a201af0/6n6P7m2yGG5PJhVOAD1JDGufJXVEcEcsYQqsFlWjCtZ/Njh4Sx1cSVYp2b9Q6jwskxm9XKo15MlSFoa0VoebNut81VM7MHkVZXdYnh4wEQaJKRcPBykCZNFYLWueKxlssIHKcgskUhNOTXxaoZEgVeKr6nMjQMXB8ynKu7uQjoxaouAFm+PAZ+LlEePmnagSVYmxXQQKqIGf8f92gA=;5:LwXtWprF9oyjlAYFpkWVWff07VDo+t0hh9/bKoQ6UsjW5QAXZ6fLP2VwlTocKW/DJurpS+G64mMHscLwqcKeUeYFUIpE1mNK0n0ugTyIgzbOhqpMc7aOdhptBz5nOIdyKzA4UaNWJ8WaaD+E/fczrhKK2fAPJ9Cgom/6EMQVnTQ=;24:aBPxeH/YqCzHQA5Kfx9C3bPC8IcZtutvkjoHYHa2fK+pBOKBq4ZBEjB4+Rk1UgMO7VQKl6Uso3wAcHZnyQNRyIz+NC3MRdJ3wz7xWBn1INs=;7:YxET96jo8mUgbeHXzz/VFGfahKfwK6KJIrZCYt+ojeCU6Ew9TANNU/06wbOSAyd5QeuHZctOx0w+WFCsuz4k4ZWKhodzfNIeaLblXBFYVgUSX4CeBWxk/gb87WB7DoPXsY0JNkdKkF565lZ+JnzpBwvU0dAs552nYocDkpbxZ5iFM2987Zbpid3QvZMy0oNTypi1j3ZhGKJHQDNrbVu5QVWcOLbAehnvg71AEE2r9mh6yjyJpu9P5+/QLySFOTc/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 13:46:34.2564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20242c9a-a51d-41a7-3086-08d58e690081
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3577
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reason for this patch is that the Inphi PHY
has a vendor specific address space for accessing
the C45 MDIO registers - starting from 0x1e.

A new function has been added, get_phy_c45_dev_addr,
which loops through all the PHY device nodes under
a MDIO bus node and looks for the <dev-addr> property. If
it's not set/found, the get_phy_c45_devs_in_pkg,
will be called with the value 0 as dev_addr parameter,
else it will be called with the dev-addr property
value from the device tree.

As a plus to this patch, num_ids in get_phy_c45_ids,
has the value 8 (ARRAY_SIZE(c45_ids->device_ids)), but
the u32 *devs can store 32 devices in the bitfield. If
a device is stored in *devs, in bits 32 to 9, it
will not be found. This is the reason for changing in phy.h,
the size of device_ids array.

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
---
 Documentation/devicetree/bindings/net/phy.txt |  6 ++
 drivers/net/phy/phy_device.c                  | 80 ++++++++++++++++++++++++++-
 include/linux/phy.h                           |  2 +-
 3 files changed, 84 insertions(+), 4 deletions(-)

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
index b285323..35b9a2b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -442,6 +442,52 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
 }
 
 /**
+ * get_phy_c45_dev_addr - reads the C45 PHY device register address
+ * from the  PHY device tree node
+ * @bus: the target MII bus
+ * @addr: PHY address on the MII bus
+ * @dev_addr: where to store the device address of the C45 PHY.
+ *
+ * Description: reads the PHY device address in @dev_addr
+ * from PHY at @addr on @bus.
+ *
+ * Returns: 0 on success, -EIO and -ENODEV on failure.
+ */
+static int get_phy_c45_dev_addr(struct mii_bus *bus,
+				int addr, int *dev_addr)
+{
+	struct device_node *child;
+	u32 reg_addr;
+	int ret;
+
+	if (!bus->dev.of_node)
+		return -ENODEV;
+
+	for_each_available_child_of_node(bus->dev.of_node, child) {
+		ret = of_property_read_u32(child, "reg", &reg_addr);
+		if (ret < 0) {
+			dev_err(&bus->dev, "%s has invalid PHY address\n",
+				child->full_name);
+			*dev_addr = 0;
+			return -EINVAL;
+		}
+
+		/* match the device address with the device tree address */
+		if (reg_addr == addr) {
+			ret = of_property_read_u32(child, "dev-addr", dev_addr);
+			if (ret < 0) {
+				dev_warn(&bus->dev, "No PHY device address defined for %s\n",
+					 child->full_name);
+				*dev_addr = 0;
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/**
  * get_phy_c45_ids - reads the specified addr for its 802.3-c45 IDs.
  * @bus: the target MII bus
  * @addr: PHY address on the MII bus
@@ -458,6 +504,9 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			   struct phy_c45_device_ids *c45_ids) {
 	int phy_reg;
 	int i, reg_addr;
+	int dev_addr = 0;
+	int ret;
+	int dev_reg_addr;
 	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
 	u32 *devs = &c45_ids->devices_in_package;
 
@@ -475,9 +524,27 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			 *  10G PHYs have zero Devices In package,
 			 *  e.g. Cortina CS4315/CS4340 PHY.
 			 */
-			phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, devs);
+
+			/*  Check if the device address
+			 *  is set in the device tree
+			 */
+			ret = get_phy_c45_dev_addr(bus, addr, &dev_addr);
+			/*  Exit only when MDIO querying fails
+			 *  or <reg> property is not set in the
+			 *  PHY device tree node.
+			 */
+			if (ret < 0)
+				return -EIO;
+
+			/*  If the device tree property (dev-addr)
+			 *  is not set, the default value for
+			 *  dev_addr is 0.
+			 */
+			phy_reg = get_phy_c45_devs_in_pkg(bus, addr,
+							  dev_addr, devs);
 			if (phy_reg < 0)
 				return -EIO;
+
 			/* no device there, let's get out of here */
 			if ((*devs & 0x1fffffff) == 0x1fffffff) {
 				*phy_id = 0xffffffff;
@@ -493,13 +560,20 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 		if (!(c45_ids->devices_in_package & (1 << i)))
 			continue;
 
-		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID1;
+		/*  If dev-addr is set in the device tree,
+		 *  use that property value for querying
+		 *  the PHY device ID.
+		 */
+
+		dev_reg_addr = (!!dev_addr ? dev_addr : i) << 16;
+		reg_addr = MII_ADDR_C45 | dev_reg_addr | MII_PHYSID1;
 		phy_reg = mdiobus_read(bus, addr, reg_addr);
 		if (phy_reg < 0)
 			return -EIO;
 		c45_ids->device_ids[i] = (phy_reg & 0xffff) << 16;
 
-		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID2;
+		dev_reg_addr = (!!dev_addr ? dev_addr : i) << 16;
+		reg_addr = MII_ADDR_C45 | dev_reg_addr | MII_PHYSID2;
 		phy_reg = mdiobus_read(bus, addr, reg_addr);
 		if (phy_reg < 0)
 			return -EIO;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5a9b175..c3b3633 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -360,7 +360,7 @@ enum phy_state {
  */
 struct phy_c45_device_ids {
 	u32 devices_in_package;
-	u32 device_ids[8];
+	u32 device_ids[32];
 };
 
 /* phy_device: An instance of a PHY
-- 
2.7.4
