Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeDQJDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:03:31 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:47712
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752609AbeDQJD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:03:26 -0400
From: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
To: andrew@lunn.ch, robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org
Cc: alexandru.marginean@nxp.com, madalin.bucur@nxp.com,
        vicentiu.galanopulo@nxp.com
Subject: [PATCH net-next 3/3] net: phy: Enable C45 PHYs with vendor specific address space
Date: Tue, 17 Apr 2018 04:02:33 -0500
Message-Id: <20180417090233.21548-4-vicentiu.galanopulo@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
Reply-to: vicentiu.galanopulo@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To AM0PR04MB4116.eurprd04.prod.outlook.com
 (2603:10a6:208:65::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4116;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;3:QmfzAaEBmq0DHQPuYkQwx90we+QEOJaVxvHxSm+K2gr8HtbtU3to6d8IhZkb3E/c7VXzm5cqAInQo1NgCVWD0yvkPPo3l4hBAfyomNqnTHcwVYOljPAbFE42MKfl2aTFIhTAipWAD6+dcwjDLfv+O8kBHH6TgvH/8kpc1oma5XyowsIMwbzqGUx7u+Aa6uFWZLB2nQ++uxwYivhc3BocTxEqPAkwHKomjIOyAd+16gtw5cRv14BQufvhvA8//Asz;25:3uD9VhFbaLvThsUdQaEGWbzCF0oJsntlpOVt+qNUAtUaGezNVyG8gwEjUQigqfzcsaarxMTPJX2P2VklhCKqVIq4Vn3CDYXloluLkqEdpNXrXzYqKbuKUz2K0sbMgHPC6mU0v9T8hNapK0sUWWoS+p0F++CAyB2kzuk8aySBPvKB0P9kLvqj65M+GQXICQoVv8kZb96V1zeUjccusnsa0CO7pVVE84ms7FD2q8OHfoNExr+vucIPM0hRci7AOVRypc5uPU8LcQD7wz93D3loACsTBMYiSuVUMI0SmGw51wK/s2xTnM8gjEHGVp61ehgeG7u+j1Se/XQBQrm+PMk6UQ==;31:5wT3PxrFHzRsT1uMeek21auROw5hPBuBBwI2j7x/xr+IbszZIn1o5Vf756+pBctPaoGnYCemUkrJbHsrCAwOBwWqCGHqeWlgPU4BD+7dU3I89z+wgnbnL6OPg+lVJDK5WlcOHVFx/ecpJsVwHRLOPYgIm8Om5AlkUKgnPOP2AwOlu/JqAwnwRuoQQIGQS3vOulS08stVWjMWgw4tX37W/4lhwjI1azstKqXOaVTst7I=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4116:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;20:EjiM5VJOrLpBmUG6Kk1JFcdXmylRn89/W2WHa/I8CACd3c+JilRMwG4PuTVPSd8tlYGkYGV/3rf5swV30N2eptB+Rr9+p8Y9IUyYPjAGo9BJRVgA2IYFdJNbggL1yoWwpyWXWznFvH+RqFkgMuWTTpjZw8QrfIzYQ9xUzcW3Ct9qmxBVSCvHvi+kl44lITFtwuIbSXpmNFkrT2ZGG6fY6vDLtsudJCLzi1e6B4ghRwSdEkNBrovKUXM+RfsV/SgQ46M8uBFVVzUKCpSD0jnfc3oufYFgdw3glFXcv8nZZZoBI7uA7rjnyt9/sbgFbfAJc2/Z0+z73XNQ5gVx6z2hZ3c5+czYgJBhI0vpjW1dhSyPbnhh4NPwUD8+Q9ZN+HJ3a4pEHQMJN79yFUWMt8LQCmX0njh/Wv94N8+2tsmCBwCRsHeDqBpY2CkoQJ1LFKPAWCEwt74Ow+/JsfmuHmCZhxpmPj/YWeZsbEEAPe2FXlLHCLraRrzQmp0PkMhC5VeH;4:07JgzifiqBBPCgHex6Tr6fAhUp6L/PXgN8jTFxpuu2KQU4FYYqaKZ57VVoAoagXKVTEhoRS/cLbyNP23Mnkhxa9KxNZPmyD+SYxB8oghf909S9RV5xh9hpg8zwa3ZZaqHNcfrUhu5QNbmqONcGc8kVZQbkGv3pxT0kkWxkE7rhaNyJtMxyYylHDNzs/xYslxtd3kHtwNQX0avB+cukHi3UfibcWbSw0IrqB7ebdQnmuJuOI5r/D8gifjkJ7UNJXfWeRAQ0xVwniUSczz4E5HrpJaM4XvMFbNF6s4VSXHnWjErm+KizYea4GkEsOZcdn1
X-Microsoft-Antispam-PRVS: <AM0PR04MB411651D7AF6522BCEDC1A92BEEB70@AM0PR04MB4116.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR04MB4116;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4116;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(50944005)(956004)(6506007)(11346002)(47776003)(105586002)(50226002)(305945005)(16526019)(8676002)(81166006)(81156014)(8936002)(2906002)(48376002)(68736007)(25786009)(50466002)(478600001)(386003)(97736004)(66066001)(6116002)(106356001)(316002)(16586007)(52116002)(3846002)(53936002)(36756003)(51416003)(1076002)(186003)(76176011)(6512007)(4326008)(59450400001)(44832011)(446003)(2616005)(486006)(476003)(7736002)(5660300001)(43066004)(3450700001)(86362001)(575784001)(6666003)(6486002)(26005)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4116;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4116;23:/LFWDRmMpB6kyV6ObLubP+QGZauH2UztUKCz+V/+s?=
 =?us-ascii?Q?/5qQVweT+RaS4eyv8ZR19suhUQ2kEIE9SlcjsRN4MTTs8bgk+tRoT9c8uYpN?=
 =?us-ascii?Q?F5LVY71GEHiXViU/RFNt5z/XWEihkDAuIZ7YVLwGVtufAcpK1oNSqluCrK61?=
 =?us-ascii?Q?a9kUvCB6YSq0Qvk2oSoMh3FVW2WogNaF4W3jaCgoPiziFNiFXVAxrnD1GMkq?=
 =?us-ascii?Q?GkPQeR6fYFf4nb62O5NtGX4/YXbEvPDGFXmxi9rvn+ohTWHOFCxLqLdeZmfV?=
 =?us-ascii?Q?zKI9CVi3VVfTS8WAk4W+RnlNBCiAkT/imevoXvntURp7s3X7W3o1dvxRkcK8?=
 =?us-ascii?Q?I8iXTzPQ1bbtUc0tzMTTOfrD9juh/MNwDnyKiHO0PnqZpgyxIDZoCjbKpuq3?=
 =?us-ascii?Q?mwAbKZnW6UeBOc/mCTc83Jv0AoMqowkMN1Ko7WsOYwdo2b8uPZXnSrqRLGFJ?=
 =?us-ascii?Q?3Denchj5rShRzlv739F3Ej57WKI/bIORUMu5nX5ppaCxSBtomskifV1jofpY?=
 =?us-ascii?Q?ww8UvDTvj00UdzTkAmUBPs2f9k6qJXldzg5V/vQBt9fnJVxqDqS+MbWWv+s/?=
 =?us-ascii?Q?hvd4ktOIlMC81Oj4bIaixcfsDwzFO/ho9NuCNlVQOQR+nRb0gaRIdpPw3NQb?=
 =?us-ascii?Q?R7rzuYFxnHbg5hgY4VvLCE5VwurWSjOM729Lh0Qxjcd5Qp5cWewSP4AiDMif?=
 =?us-ascii?Q?xtniR8V3imb4ciZeDlAZGGCxsaE9oYYS0BCUwVJLZuVSrszlv5iqs4RwGhzi?=
 =?us-ascii?Q?y3r/nF2GaPQ6ChDCJGvbm1EGSqWXzHJ4az7z24ClCOA/hmf+kqFaBDqvrh1/?=
 =?us-ascii?Q?bhg1U8W+zAOUnP0I0UBCKnXifDzUrHCsLB5YJvuauERE7qMOc+wrgWtYizS/?=
 =?us-ascii?Q?mlAhIy8DI7q2m6JCHISwTucLTDukRPc587jLkt0DuN7IAgsoXUWMGwbYcE4S?=
 =?us-ascii?Q?LdVT0kePBXwiVVXHTy0FgJdwOZOtTD4NG37vkPaFot2tTrStR5CFrfrYRM5j?=
 =?us-ascii?Q?juoaptsztMuBgIKCkHaenCzCCap7VNmgLn+9UTs3vYAGHeFjOhni/9E4zUsV?=
 =?us-ascii?Q?fdQG+fl3PCl5pHA9hyGhtizipvab4fJw+tOcX+MKgNWh8ljMonRJXggL5gMs?=
 =?us-ascii?Q?GGN4jNwrdm+BEo45FM1GjJnwP/fy/21bsF+o72tXQWy5xFxbk2VPI+6BisN2?=
 =?us-ascii?Q?uZGa+e9Z3y8hohiyz2U36kb0SepF8BK29W0OJydKPwz2Pmf6W97M4teewv5a?=
 =?us-ascii?Q?4+1vuPF0k02wMoCe6HiNTgjM1AyBP/flScBaTTGDqQIT1RdJhqrf9deiJtNC?=
 =?us-ascii?Q?XatUmNsEtqa5w/MLMwnOrH9/XHciZ+rmQTbayvzKV9q?=
X-Microsoft-Antispam-Message-Info: rY6hBIGxmFRfXB+sDAADBdzsUlAv5Ya/4pnHTtBsVbLnP9Cdxe4MK4W2QIs0ZLeA9rv3v8pfjSIqZBKSlhpP+NHefOtOj2JBqVXvaxtqznrdXjMrZsUijobRKCcbpII9kUBFrhE/TLJMEu6S4t7O8BjYHQYg9iGuDonsAyLs9CNRdOZeExyabOuJfUrHYcEg
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;6:QUYycMDg/X9g2rYCoBpXt4rUXD+XOq1a5R1PMKC05nE1bxypSz7AFKwc1nvIXQGXOpepJVO5f6lLVFBLnTOcpmSwRjDyCJvgOPalfIeOtqKnk9Jr4oNT6TRh2LtPDdfBvIhyRSFJa46Ka4iSyFm+PWEV5zUM5HNuwQH9P4z1aHalaglQuLrBuF22nQUtGwTrGtTLqw11Yl/OWxPXyywulxSBh76LOpDj0DPLtARsQ9rmDXLqQbsUhg+roozLq+2fzIg3HS2EfjJrP9OvQK1SFJIF6bt+mDJSPEImM/zLSvbQIEYijcr5QfRyMAtttwwABWMFepT6xaFoQ/7/6MmF/rU7jRfSi5UhLtGBDpGgQRoPTfFImROmKcXDs/NyZXXWNung8FSgLe+l0PCR20+kP+I6QXX7e9zqT4+1V4ESiQTYcjXDLUv0gSUeJZu8PMcqEoP+KvA/YfSy+zDfxod51A==;5:rS8eV9Kb5d4bSBXHrfQlc8vSDeT9jFI4T62fP3exFiytDVBU0fqemzThMfV4g9HNnXXoSPNh/Fr4lEnz/SZ9W0APUmbFR+S0Y+zN2Lxui9xB5sqQY4RLfKid9WGOCgaio/sbyT5cRcHqYbwLF08w3QIuK1JbFrQm3nBjiKtdKUQ=;24:9yQy7Stz4CIy+S+0H9a9rKr3QWwOb2JoLLYxvyLWGkO3eS0hlg7n5OiCKvxruSGU0/5lVTU87d6zKVL/4qYoFj43yfzLEvE8r9+fn1K+KmA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;7:5LTRwnuo5oec+Bz4NeqWFxAYT2yjLRgQywhdftGupwjsfsJ/UWaGEDQF77QC+oAtGS63ma3QpyLIlbSfajB9TXjyBCf7+i7p/soPuXvnkrxAHg0PKZQStj7mf4ofgDVOSNMUajOiSdwGOCsHgetL2/LwJp5RJcBe1RZH4I2E6wg8frkVl1WkP27mWO2LpABrEFlq70MZ0g9PZMDGXXGbxCR80phprNsiMatSnQvJ/DPOH6tQbQcHVwDNYggd8gJI
X-MS-Office365-Filtering-Correlation-Id: 7db30442-c543-4af5-30bb-08d5a4421262
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 09:03:19.9295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db30442-c543-4af5-30bb-08d5a4421262
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A search of the dev-addr property is done in of_mdiobus_register.
If the property is found in the PHY node, of_mdiobus_register_vend_spec_phy()
is called. This is a wrapper function for of_mdiobus_register_phy()
which finds the device in package based on dev-addr, and fills
devices_addrs, which is a new field added to phy_c45_device_ids.
This new field will store the dev-addr property on the same index
where the device in package has been found.

The of_mdiobus_register_phy() now contains an extra parameter,
which is struct phy_c45_device_ids *c45_ids.
If c45_ids is not NULL, get_vend_spec_addr_phy_device() is called
and c45_ids are propagated all the way to get_phy_c45_ids().

Having dev-addr stored in devices_addrs, in get_phy_c45_ids(),
when probing the identifiers, dev-addr can be extracted from
devices_addrs and probed if devices_addrs[current_identifier] is not 0.

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
---
 drivers/net/phy/phy_device.c |  49 +++++++++++++++++--
 drivers/of/of_mdio.c         | 113 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/phy.h          |  14 ++++++
 3 files changed, 169 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ac23322..5c79fd8 100644
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
index 26aa320..889d85e 100644
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
 	u32 device_ids[32];
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
