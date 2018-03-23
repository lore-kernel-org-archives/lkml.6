Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeCWPFr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:05:47 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:39325
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751687AbeCWPFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:05:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
From: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        marcel@holtmann.org, devicetree@vger.kernel.org
Cc: madalin.bucur@nxp.com, alexandru.marginean@nxp.com
Subject: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr and dev-addr code check-up
Date: Fri, 23 Mar 2018 10:05:22 -0500
Message-Id: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: vicentiu.galanopulo@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: BN6PR20CA0052.namprd20.prod.outlook.com
 (2603:10b6:404:151::14) To AM0PR0402MB3571.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6d23a81-d519-4ac5-d7e0-08d590cf8b63
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3571;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3571;3:EBfVs0cWSokkG3lpL8S4n3LPhjS4dqlFgJguQCqpaA45StNz9RzuhdcnQ/QyZHjmDoT0wqEihixavSP7/qcYuxuHvAcdMlIDOoX1ybQwoegGAhckbRkY8K4PG1z2O2J6RcDKVDAQ+bHSgTMOiZYWU+xrNJP+JX9AXNmgefY7/WaT5C0Te4xdfkxZVMFxl3icz+ek2ad1L4P/+0G2hdX6p7g4W5FgCfqMOVheuN7AX9lBGz0fDDMVA/iKR6yKdK2g;25:mjFVt3Ki4H3sGf7H1yOXqdvICq1k3aFo1i16GLaDYQQlZN26ZXfNdYAfb0A52kVXxC77trJImLgrbCPEil6NKhC5Dcyx50c58nC9Na+MrIsq804U58ppulk1t5wcPbK1QDmaMh21CaG/gsoQt3AHeSaD4/bwvZjemoIhThME7JoxEPWcGp5n6fq36QRF5yi53A2T642Go63xSxB3TB4wS+ig8nP9s5qyLNyQt81+xnjhHjHmpO0XrwYT///oijHVCxG/mzaRSrado+DGOi8soeZn+bar7kVsvmtBvJ2gXMzWcBjS6MmcgWq7oYkrU5bvG2w0mDrho9r/DZZ/5GETtQ==;31:z3itA7YZRUhqOKPP4Xz2ZseHfdP/Lb8q9hnp3h9KSasZPch7OoClVk8MytjNPStOLXjTDgVuSkKta6c7yxLR0IZ/S8Iw4ZzDH0AqeRUg/KcD7LFKwZxBtWJGNUdHySJptsixFoCaTIJnGVA1mCKlBgGQ1pAqv2ivmvFdY8NK239/8dJ1Uj8qpnsdRvQrzonxLegITjj2cnY3qxoYUas2Uwo/Bl7QzDZI5b16OEZ89EA=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3571:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3571;20:xMHuVFrqYh3JOebM6qy8kg7N34xyffY7Vt8BSmbnrkB3/1ccxtcbJE6PsFhrPfaHiQkIrmkFTIi0qnLKOoe8SUPWMBaWD1Za/RDXxUq2eXoAxPcLp874WAoYHbgrKagdAixOfr0gPGM6bWhuc5d85pAfA4/6pjifxZZrUaEp2iCQJOLbDbFoht1jmVEfVxlJRkE389MqD1ESIv1DAduT6sHNXUw9e3jj3EXKepNdvNLA5PnesYDU6L7yaJPgvxvmZ0ZVJ5sf8OF050BBFc7/O511+gETv5OwfgDRPJcGXyWI8wWHnWrQoWEapnfh5LAShehocpqRGtgpPnuVMwl/3v+NeBCU4Vbj50VG2DxCKW7E6qc+qzrsmRXkdiUumUSNeAn7HyRZ2o74QqhJ8MJDZHcaP4gIWB3fmdguhjnM+l7syE7/79AKfHLH7uk440Hpzrz5Yngd3++AIpmLDMHjwqhphE1v4MWcjoXwELdoBSn5BYjsKOPrdBCopYEO39rb;4:XBvEluAK+qo+OGjzaBTl757lcJ01NQkytx9/gcbn9y0J0OjyB/TEWv5y49Eji9GP5ONHIpFVoKXtvreZaHnu4g4gz2rqSX++vtcA44H0bI9SMTTTb/2gGPYSmkGFPSohJ5+v5mriBdGG/2TmMGhM5zLG39smzJ4oj0fFstBVXBVCXy/sAAZuvNrhm0yUc0cOWWDjwRWFw/s2L5mqkNJYmaSxKi6i1kAPK57KxgiSmeOAi1XeECYd+8dppakTn1/Fmo4KO1suhlg/bgsXrlqln7lqgKHvI5TaBPLtt8qiGm7cOmhKe52KuV0bObGGC19L
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3571C6F12DE69E8B5348C998EEA80@AM0PR0402MB3571.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM0PR0402MB3571;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3571;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(396003)(346002)(199004)(189003)(86362001)(48376002)(50466002)(105586002)(68736007)(575784001)(478600001)(3846002)(6116002)(52116002)(51416003)(26005)(6486002)(25786009)(97736004)(6666003)(6512007)(4326008)(53936002)(5660300001)(106356001)(8936002)(16586007)(16526019)(47776003)(186003)(316002)(66066001)(43066004)(3450700001)(8676002)(7736002)(1076002)(36756003)(305945005)(50226002)(2906002)(81166006)(6506007)(386003)(81156014)(59450400001)(217873001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3571;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3571;23:6rPPx0QLMtamPc3WtqpsPiGHv613q3sn8HuM3gn?=
 =?us-ascii?Q?5LE6PJ7nqDNF7IdDnYimCoAS03gjQ1AFA3KVHXWSxhTZiK6r3ms3+Pa94J9Z?=
 =?us-ascii?Q?iKwPzLABVia4HszAm1iwZ5d02pLzbyjyjax+2Xr6kE2TYmVCIi7jfgwQ/qlm?=
 =?us-ascii?Q?+9lJEiyk7VSJ+Yz0aSN10EoQtYJd+gMbcX/G8QZIZ9E4+Mx/BxRegpoeWy12?=
 =?us-ascii?Q?C2V2uZOzlSvew+atIZWGstG7FbO3um3M9G7kuolDEU+BAWLxoYxXTtlJezdB?=
 =?us-ascii?Q?IYMrTygS1Rlb3PFhGiQge9zlKFrNVoPc5JMIvmt/NeeOMUclBk3zJwFf8W7H?=
 =?us-ascii?Q?JEkWvhmDsuC8flamNLt6bSBuyFxIbvIBFphSbPeawxEmSrAuaswm7r5bvXR6?=
 =?us-ascii?Q?TkM4hiZChrzyW0f23GkJodWmKLoIMCnqkCsG9Bq+iwCKP6eESFIvMQJ2v+Dw?=
 =?us-ascii?Q?9AXkeDby5Q5fFo/hUcu6c8s8Uap/85998cPRSq6dfovbLSvVtsXaQlrUTObV?=
 =?us-ascii?Q?hhsM7SVTJ/jKTFllFeUsjjeSARJj0Z5uJTnM+bDg+srqYQ8L06ZBqsVESqfu?=
 =?us-ascii?Q?C3GMoU9N59NYA7hhEtoB4bF4lNBqUn5BmfizHh9823y4dQF+zDCLaSfhp+5R?=
 =?us-ascii?Q?K1xIgKV8A+/6XFrlk8iGOJKIIKemVXvHPZ2aZ0LBS3C8feH27AkrJ+FJI9zz?=
 =?us-ascii?Q?G1jVZLe2eQKMjLy2cKC9RzaeLS2H6L18YMlF1Jyn5Ofx+4XnXNvXVvyx1Pez?=
 =?us-ascii?Q?q7gvRwx3CZv+AtSoW8qCeUjDOq9djQiK3121UiRjzf3P+IGPsrlhILDPp7ju?=
 =?us-ascii?Q?6OIKDTpURfwZBbVwpT70ZZ8ooTM3Cgwx3QvSDOdZ5yuaPPKrCAKFR7xvwtFf?=
 =?us-ascii?Q?kon6rmw5XxvitoTnY9U0kXqe3cda9NzKduduNimLwAcWd8yOP0qZvq3az/rm?=
 =?us-ascii?Q?Ebw7Os7ON9Abhe01BaJYstBfGdlnZ2EEyTLMD79hyrntCOQDyhD/i2qhrX56?=
 =?us-ascii?Q?XdqcX6YKiKWYWUTe7/I3zUEPKmcQSq5MnsI5iwmTz5JaYPctylrOT+F0iP3k?=
 =?us-ascii?Q?o9NFbWG2cDDnqxs2s4XTmSMefMCPNrboi6Cyt79J0YhnS4UYjieraPVsRP2i?=
 =?us-ascii?Q?62qhRmnLTBVFsftiIio3At0r9jx6K3EHX/HtLhD558NS2zw/qZgr9lWbjyDj?=
 =?us-ascii?Q?EXpO3yNU3+tCjaTDxdwUbt+ZFZ2YwenP+8LSZ?=
X-Microsoft-Antispam-Message-Info: SYg3+G7qefQC600O6N0AUqK9M56dBwd4VmHpxQyS2sUThznNjinwvZnA3K7s0dazVIBKM25RdrfvXyUM81ciSgoDOPbLS2sc72bCyrjmwl2fVJf+rKJ2cG7GYWoAZ7bek4RmbaZS7abSfCTgFtaZ9E9U/d+LyLjh6UWjhF20mNL1cKPtYHW87AcqZREknDKC
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3571;6:sslVS2QoP447sv0L5VbncqTF5SrsSZyYhag5wLPIUzEmJ29xkauvL+CrSzEK7cRdKWhr2GYf8T1OzqMxbMSMHEHcYVyIsAl1zrY/XRVgdmvuz27bPSXE+9Z/MAmJd0N2SHDpBr2Ud3haticV+6CatRjuYxYcC7unZN4WeqsmYGzTWZn9KApPX8WSK0YDAr+vNYpQFj2+OGJXrlKqrDBJxVUAgmubgd9dfN3DUlAbtPhJzq07688hUKZLBEhG0BCJ5HoQktbXtfM4c5D1wRY03QwQySXCrYjhqk8VAgS5l7E+m+d7IPwupikt4bJXix+MAxRk9pG1M0KmHFnXlfPDP7UfeDpRrp33h/lE8B41yUpVWzHE+fa3Cj39ub3WpM9QSOyWIcLnyqaxIM7FhnjX37BPAUgakhd6KsCsLFjK5p9rsbcMRot6by4Unk0CyrqtWWWyxznfZaFahVSK+sGBcw==;5:iGK8yB5c/D8P6lFoIwCLzdH8SwZ1lYSYJJufj/BdziZ9J5TGoGP1ApgGRelnbzCMu5lbg5WoZV67g7rvp8h33okhVMJ7uSRqAhme2dZngzJlBM50dSt8AMOpieQ9BoD9jM96eSz/NqdNVSwyEEL5VarTV7rHBunQjEOtalUjSrs=;24:EMJnxOd4QhDCUp6+UzubIX20gkbfpQf07CrgBC1GmZZNvYuVNI9/nmS6AfYG2dfI/k1fSINlEyMnYdD3xUU88yGdMAmRMdqhn001p+HW8bc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3571;7:UzDnOZRw4+yPoKDwAUi2HGNhtude9fWbMSFvoP5qCy1mBW+tEBqJYl9zXrZXTZQq2BZ68UlmVUWGtkq7NxV2UH2vBUjfwX1UrXB6jqYbLD/drIESP/Pps1Lwh1baAKxBYFdidQEoTmF+BXwfo5cOnrGlFaxqBay77uA/Yh1zPP4E2N1ygjEa0VWsQZpSQDnumXjDZyVeUF25AMLaBOBf1QOKBFfIhYRyH1NFV7GXj8uAUDO4Q8M6pbUM7DFaZEw5
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:05:39.9936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d23a81-d519-4ac5-d7e0-08d590cf8b63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3571
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reason for this patch is that the Inphi PHY has a
vendor specific address space for accessing the
C45 MDIO registers - starting from 0x1e.

A search of the dev-addr property is done in of_mdiobus_register.
If the property is found in the PHY node,
of_mdiobus_register_static_phy is called. This is a
wrapper function for of_mdiobus_register_phy which finds the
device in package based on dev-addr and fills devices_addrs:
devices_addrs is a new field added to phy_c45_device_ids.
This new field will store the dev-addr property on the same
index where the device in package has been found.
In order to have dev-addr in get_phy_c45_ids(), mdio_c45_ids is
passed from of_mdio.c to phy_device.c as an external variable.
In get_phy_device a copy of the mdio_c45_ids is done over the
local c45_ids (wich are empty). After the copying, the c45_ids
will also contain the static device found from dev-addr.
Having dev-addr stored in devices_addrs, in get_phy_c45_ids(),
when probing the identifiers, dev-addr can be extracted from
devices_addrs and probed if devices_addrs[current_identifier]
is not 0.
This way changing the kernel API is avoided completely.

As a plus to this patch, num_ids in get_phy_c45_ids,
has the value 8 (ARRAY_SIZE(c45_ids->device_ids)),
but the u32 *devs can store 32 devices in the bitfield.
If a device is stored in *devs, in bits 32 to 9, it
will not be found. This is the reason for changing
in phy.h, the size of device_ids array.

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
---
 Documentation/devicetree/bindings/net/phy.txt |  6 ++
 drivers/net/phy/phy_device.c                  | 22 +++++-
 drivers/of/of_mdio.c                          | 98 ++++++++++++++++++++++++++-
 include/linux/phy.h                           |  5 +-
 4 files changed, 125 insertions(+), 6 deletions(-)

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
index b285323..f5051cf6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -71,6 +71,7 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
 
 static struct phy_driver genphy_driver;
 extern struct phy_driver genphy_10g_driver;
+extern struct phy_c45_device_ids mdio_c45_ids;
 
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
@@ -457,7 +458,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
 static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			   struct phy_c45_device_ids *c45_ids) {
 	int phy_reg;
-	int i, reg_addr;
+	int i, reg_addr, dev_addr;
 	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
 	u32 *devs = &c45_ids->devices_in_package;
 
@@ -493,13 +494,23 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 		if (!(c45_ids->devices_in_package & (1 << i)))
 			continue;
 
-		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID1;
+		/* if c45_ids->devices_addrs for the current id is not 0,
+		 * then dev-addr was defined in the device tree node,
+		 * and the PHY as been seen as a valid device, and added,
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
@@ -566,6 +577,11 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	u32 phy_id = 0;
 	int r;
 
+	/* copy the external mdio_c45_ids (which may contain the id's found
+	 * by serching the device tree dev-addr property) to local c45_ids
+	 */
+	memcpy(&c45_ids, &mdio_c45_ids, sizeof(struct phy_c45_device_ids));
+
 	r = get_phy_id(bus, addr, &phy_id, is_c45, &c45_ids);
 	if (r)
 		return ERR_PTR(r);
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 8c0c927..cbc34f6 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -24,6 +24,8 @@
 
 #define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
 
+struct phy_c45_device_ids mdio_c45_ids = {0};
+
 MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
 MODULE_LICENSE("GPL");
 
@@ -190,6 +192,71 @@ static bool of_mdiobus_child_is_phy(struct device_node *child)
 	return false;
 }
 
+static void of_fill_c45ids_devs_addrs(u32 dev_addr)
+{
+	int i;
+	const int num_ids = ARRAY_SIZE(mdio_c45_ids.device_ids);
+
+	/* Search through all Device Identifiers and set
+	 * dev_addr in mdio_c45_ids.devices_addrs,
+	 * if the device bit is set in
+	 * mdio_c45_ids.devices_in_package
+	 */
+	for (i = 1; i < num_ids; i++) {
+		if (!(mdio_c45_ids.devices_in_package & (1 << i)))
+			continue;
+
+		mdio_c45_ids.devices_addrs[i] = dev_addr;
+		break;
+	}
+}
+
+static int of_find_devaddr_in_pkg(struct mii_bus *bus, u32 addr,
+				  u32 dev_addr)
+{
+	u32 *devs = &mdio_c45_ids.devices_in_package;
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
+ * Finds the device in package and populates the mdio_c45_ids
+ * if any device is found at dev_addr address. After this
+ * the PHY is registered
+ */
+static int of_mdiobus_register_static_phy(struct mii_bus *mdio,
+					  struct device_node *child,
+					  u32 addr, u32 dev_addr)
+{
+	int dev_err = 0;
+
+	if (!dev_addr)
+		goto exit_register_phy;
+
+	dev_err = of_find_devaddr_in_pkg(mdio, addr, dev_addr);
+
+	if (!dev_err)
+		of_fill_c45ids_devs_addrs(dev_addr);
+
+exit_register_phy:
+	return of_mdiobus_register_phy(mdio, child, addr);
+}
+
 /**
  * of_mdiobus_register - Register mii_bus and create PHYs from the device tree
  * @mdio: pointer to mii_bus structure
@@ -202,7 +269,10 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 {
 	struct device_node *child;
 	bool scanphys = false;
+	bool dev_addr_found = true;
 	int addr, rc;
+	int dev_addr = 0;
+	int ret;
 
 	/* Do not continue if the node is disabled */
 	if (!of_device_is_available(np))
@@ -226,6 +296,14 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 
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
@@ -233,7 +311,11 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		}
 
 		if (of_mdiobus_child_is_phy(child))
-			rc = of_mdiobus_register_phy(mdio, child, addr);
+			if (dev_addr_found)
+				rc = of_mdiobus_register_static_phy(mdio, child,
+								    addr, dev_addr);
+			else
+				rc = of_mdiobus_register_phy(mdio, child, addr);
 		else
 			rc = of_mdiobus_register_device(mdio, child, addr);
 
@@ -248,8 +330,16 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
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
@@ -264,7 +354,11 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				 child->name, addr);
 
 			if (of_mdiobus_child_is_phy(child)) {
-				rc = of_mdiobus_register_phy(mdio, child, addr);
+				if (dev_addr_found)
+					rc = of_mdiobus_register_static_phy(mdio, child,
+									    addr, dev_addr);
+				else
+					rc = of_mdiobus_register_phy(mdio, child, addr);
 				if (rc && rc != -ENODEV)
 					goto unregister;
 			}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5a9b175..161ad90 100644
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
-- 
2.7.4
