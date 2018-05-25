Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934182AbeEYMiF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:38:05 -0400
Received: from mail-eopbgr50120.outbound.protection.outlook.com ([40.107.5.120]:45132
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751949AbeEYMiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:38:03 -0400
From: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Cc: alexander.onnasch@landisgyr.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/phy/micrel: Fix for PHY KSZ8061 errrata: Potential link-up failure when Ethernet cable is connected slowly
Date: Fri, 25 May 2018 14:37:33 +0200
Message-Id: <1527251853-22218-1-git-send-email-alexander.onnasch@landisgyr.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.239.165.1]
X-ClientProxiedBy: VI1PR0701CA0069.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::31) To AM0PR01MB4257.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:6c::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR01MB4257;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR01MB4257;3:luyp6TWGge53RNu6hymx+FqFF8O4n9Ps2XwkI647LP2C0lgawFWUHC2zMBW9nRGyarr/4dFiX2OeGJlRNWdLhxwR6fDTaqU9upZtmueJVcL8v13broifIOPk+1G0Im9d0Q7plwV/VEb5c3TWarxyDWT+HGJQGoVsTxRdCVYREKZDDRYlTbM7f0dHh2qHDtYTj6ejxlNav/QpT5G0aiFB01PGjDoPMmsIoVAHEgmOASgENlVHdFok15ez+8U3DsfQ;25:fLJK79ZCJi4WoocTE7dx0j0phqEoHeXP9j3UZcobO4iJt/qmPcKDlegtpGKup39xhX22sWVVaiikMTxO1dDQ4BafuRi8v3kJHzviAD4SOwQiX8S4QC/F1h/ueYAnUg+Pi/ixe/OU1FT1/018mro2M8lhjbh/lJTJD6aeAtywnh9q6t9R+snRVkH0Ruz+nMQFh6YmNWjh9ZRLe36R6dagsdAjMHBN8WTU99oyr3yLjrXvqDYKCBkW5oBX1InfqRojEaTbMpWQHN39d94rS5+mgbosUNFw05K77kAI59gY65dDeFRFTob5pkcszFtB3Y2gXiXFLYYhjFwZ+6rILiE8jg==;31:KbqpC1lVPO4BCimBfZB1EwLoGBZZxdg3mep1n8zd1L3AGnA0aixuJnCJeTGDzsieNxJckGgcP0yHrRLj/LkzM6hgQrIzI1qUB38nkd5RzZE/mydGyg9zHgXQ8RxPnoyync/3MiHpLWNo0y6R/EsfnpHUXaA7q7YacSDwYh5BOO+6l2Xkfy46wXiNfv9q/bl50oScVfbydRMTA3/CCZoGe6UxPK5gBYJPIXqJ0GBkv30=
X-MS-TrafficTypeDiagnostic: AM0PR01MB4257:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR01MB4257;20:kfw/kejYytjYfteAS9Vfyv+GYXsCCStJaW209nqP1ZGeUNI+SoMq7Z1kwrgHDwgWFhYFu5q/RGqSgqXiSZiYdawtVUlEisW9DH0hPZ+tq71V7KJlGH/0NJCSqtlC4315/eRWWkWZGT6q0RGRxcYw+6n02I+p/LcnD2+2+bo+GbBkGuclyhaZXULIsqmyjOCbtemfbEC4irekcysr0IvfRvlflEEIUT+GUtWkUQaCHprcCj9wbl+5eAntsLVy66FVLBbwrP2eRSVtihzkCXzQdXPh3wiILfQwY95wd32D6Rbas9XqVwhSg0AdItOb9OBiRz6Hhjf+XDxua9lqAaRLZxKdXBdq8vVZ1dsqBC5Gx1GbHesC9RCo6Xgoo2sNJCRDIAPfno0a3ZObcT3yH/Th4hImAWCcMeKjktiocWwEdgv8Bo526Aq+79rU0uHVJ9btG/CKrK4UTEVcCQfBhm7bFZ3ToA3RGIuv4v5csiRvWT/OQ6gMW+no+KavXrN2NJe6;4:wX0OrqEg/XxoK3uGQ9cx/uE+KQ7cIAw8uskFRdVL8+rAokkGQY3b11F72InlhLIwdjxIv5HFx34B1o5DakXrHAUM4xc4jFW8kefeWbSxhejZWuYi5dd2w597l4+uCwkwJShm3PhwX9D/iSkVCfRo0QlVUJgPJ7R93RWpodshyDVZgS7NscECOJub/xzIyNTshhpCoLZSBDDIFoSwIZOQlio5S/RHhiHSKQTRrr+WrUHJJ18l3HXphxuH8RBk+CZCN6AdxDl2Ybrf1kHTcsZQ8g7SXHJ3TboKhsOqzHIxtrVn8oE+86Bv1KCXNxyhln1h
X-Microsoft-Antispam-PRVS: <AM0PR01MB425751E9D99166330DEF7B36F0690@AM0PR01MB4257.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(144836121648609);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR01MB4257;BCL:0;PCL:0;RULEID:;SRVR:AM0PR01MB4257;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(44832011)(2616005)(956004)(1857600001)(476003)(86362001)(575784001)(52116002)(51416003)(16526019)(6486002)(26005)(59450400001)(6346003)(36756003)(386003)(6506007)(486006)(1671002)(48376002)(50466002)(47776003)(5660300001)(68736007)(66066001)(2906002)(6666003)(6512007)(4326008)(109986005)(39060400002)(53936002)(5890100001)(478600001)(106356001)(97736004)(6116002)(305945005)(3846002)(7736002)(316002)(81166006)(81156014)(8676002)(72206003)(8746002)(50226002)(105586002)(54906003)(8936002)(25786009)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR01MB4257;H:CHZUGPC352.eu.bm.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR01MB4257;23:EESKeUC+UTo6pOalPuWz+hVwJC1245l0Cm6DdO/nA?=
 =?us-ascii?Q?jAblYVydzciPrzP0hmFkWbhslsBIeEU6JQrXa+QVrSsBHKYhomNg8tFOS0gh?=
 =?us-ascii?Q?DukDz4oq2gTkQ2x8xCoI5xRv6iwvcrEBqKpLf+FbabOgJ0h/axzZfv6vb5l5?=
 =?us-ascii?Q?5jCflvkx2O9JbuUq1YH8yWkhrDqMS2BX4k4LHMCumFJ2zWeX04DGjAshI15j?=
 =?us-ascii?Q?XM3kHGAfseKmrE1CUo0rfi/42Jiy3JaqZZSwlPsZpnEfkh0tandkF+8tagjK?=
 =?us-ascii?Q?tXa5Im175xJb5nj/jfrtQz6eEy2wtRC0THAl8jce5Fdu9upWoW7BjP8D/JPg?=
 =?us-ascii?Q?oXodujRFHmLC/pKXZVJjyh0vX7AeotcGBjDJyHjZZRb2NFCs9+1FwYV6o2zX?=
 =?us-ascii?Q?5ZPY2Im0RlX+e662Mo9AsASg/XQDc9edAKslqj5TUtL/C5lP3LRAJM0SONlP?=
 =?us-ascii?Q?H3BHVE206tqYpkW2Fi4YSo2c5XQCNkZYe+QwtdWo8/RAZ4ORFu9cDq/LYd9S?=
 =?us-ascii?Q?7mlaVT35YAdgDZhhJP3iXVhL2h39bUKejdodi7XKet6dV0qxpM8dlyCVLUz8?=
 =?us-ascii?Q?eFK8VGb/Rk/byomSjQULGMmcciOCYs1vdSqy2kIuuTlg56QXPhmX5ZrS3V/T?=
 =?us-ascii?Q?+yY7JFg2jNO6wRx/eItYgh4V+KdEOfxK6sO8O4HoNm7HYjCUAjC90hHnSlur?=
 =?us-ascii?Q?4H+qbZnZ1564FsrM3/c2ZWLIaJRePZQhY+3jGXgwoQ+9Cr/WuSzih5OR2sTk?=
 =?us-ascii?Q?DVx780KUHNmKNuS/VnX1FY2vcgZuPWf/24i1SbKjbfNUcfrcbGXRzI0xbyCR?=
 =?us-ascii?Q?A6yHE7890kXp4b+jgdVQp2qGTPKjM1CyPUhGFNvVcje8UsE+xjCQQlSOGIxR?=
 =?us-ascii?Q?UZ5J2WU+SsTp/XZ/ZlnJqEfDXOQY/JqMiuopate2l9zQFiDkRe6f4jYqg37Q?=
 =?us-ascii?Q?ccH14VCZanG5CD617INmU4xmJe7peC3lDEJkYXsTnIKvGog223BXaTvBC9tQ?=
 =?us-ascii?Q?Rm2qSlCHaWzmHRUFDHVUyD2elSsWN9rQ3bZ1rlw0VofXg5fSB5RdQfqUlUjq?=
 =?us-ascii?Q?ug8ziNztsQcip2reA3641bGaiL/B3DwWZlFuewIl5aUEgh2m0oLl0KFUdqkp?=
 =?us-ascii?Q?5+GzR1ZoNxKlak2Uj6hJJwNaf7TOQGMEpJo9J87d2YlCLTxVeNX6uVBqKuy6?=
 =?us-ascii?Q?MrTis1hNEhFb+iS8+eWRP2N7qYoVuxOAA23vsmO3ggGCbzLIOVM2z8+BqMY8?=
 =?us-ascii?Q?q113rOdrvnoNeFUpsFbaxt6tA89gEY4gF9eRy6cjK+WIw8zv7z1dGp1vzcG4?=
 =?us-ascii?Q?5I86gsgsOj2RVy73LPWFIl72RI67PrZlzZ3y4K6hIXG3yU7EFJpyN6H1HVZ7?=
 =?us-ascii?Q?WWtTA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 96Vi3ok6R0PVSJJS8YdvNaydWJVdTgXV49SBFKKjkj8YITPxdgBTq0yV5YFZ66fy8+z4CmjUaNc5NOTnr1rpuVHnghSIDHsQ2VB2CXRlJKTDFgnhcYAq0zhIKpOgXLIUgwG37v1wz+TOdqwQ9U16cBGsHyBUTX3cblhLHJGBliBDIzi7ES6ZbgTjSLLvMM3B
X-Microsoft-Exchange-Diagnostics: 1;AM0PR01MB4257;6:AMTIJL8FFP7GbLPgGetTfey7jvY0uu8SJqtufBt0e/ied5NoZhaKH9mhwCv4mPhFE1mhmObl116oJwWLYVbWExr1ML94OqofS0qYLnAm310j+gY6nDnTQfLBKs1YqI7gLwL4zJf7s8vyAAkQ5KL3Y4aD+9VXdWeT7fmJM4m/z+pSng072X9NYqsZOh5/BTiYN4D9o7Mgy573Z8A3i5kACMq36HKBVyErKfZG4OnDRXfXFpAuiCImQDtXmaqWdQDL8o+5twjtmo8n9FAyq0afWfIRjMN75n0Js2QCIXx3GiTPDF2rtQNoYcGQkg0/S/4SO/X6d3XAde4TaU+xw/J+tgHxW/6Ful5+71/HzMdnJ3NEJXGJm93SHPBDOsuIL+ZJJsXAfNl1rQ5Bdxh03G9uF1jaxd4+qFiZ/7aDCH9wgkiZGZHTfarJqNZ8McNXMk7BF+l4+NPyOnRcGKksb7TYcQ==;5:9geSRMlvKHX/gvZ0IX6RPOXSUIbUeQ+o2AUSe5tb1AxCRQ/j4UgsnboHd4HekFQVbfIS738KiFViXwH1rDwH4saOpwjxucY89QjlO42bEcz44Al68Uf/lJmAIJisHE+nsDEg0R8evdlOQlL+xkJqPJLxW96CZE76rlrZykKkHeQ=;24:CEb34dHWCeBS2/7u2tI6yazTJ6W1Izc4g2oAiOxG2Fz05sRyvl32YMQcJ2SCZLUwJfnn6fJ1zaqtPIDW85B7050MuTVI1GWY6GywtNwjDsc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR01MB4257;7:6rNiBfZofDkZoPoSTjFRe76NNfkYm2tEKAmtLCwJxg/bEX83K4t1JF4XIrv3NCv8phzhxrZAEiy3sLGtVzA3r7glBenhusNWiAhnxX4q4BEl7/0Kl1828VFFFe7GqDrbJP1TZOXMxPgzN17NNMYwJuBb5fW54evIJVYZ5DbES2LWGV6mllJ+q+19hl3BE+yWp0Pe5fDzAfC+4lyp8z2fX/5rNuIh/gpx80IyuGMz7KBHTMzc498orrg2oF3qN1+F
X-MS-Office365-Filtering-Correlation-Id: 4d4444de-dbb8-48b4-c23f-08d5c23c5a21
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 12:38:00.4875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4444de-dbb8-48b4-c23f-08d5c23c5a21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB4257
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PCcD8g019114

Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
---
 drivers/net/phy/micrel.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 6c45ff6..7d80a00 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -339,6 +339,28 @@ static int ksz8041_config_aneg(struct phy_device *phydev)
        return genphy_config_aneg(phydev);
 }

+#define MII_KSZ8061RN_MMD_CTRL_REG         0x0d
+#define MII_KSZ8061RN_MMD_REGDATA_REG  0x0e
+
+static int ksz8061_extended_write(struct phy_device *phydev,
+                                 u8 mode, u32 dev_addr, u32 regnum, u16 val)
+{
+       phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, dev_addr);
+       phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, regnum);
+       phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, (mode << 14) | dev_addr);
+       return phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, val);
+}
+
+static int ksz8061_config_init(struct phy_device *phydev)
+{
+       int ret;
+
+       ret = ksz8061_extended_write(phydev, 0x1, 0x1, 0x2, 0xB61A);
+       if (ret)
+               return ret;
+       return kszphy_config_init(phydev);
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
                                       const struct device_node *of_node,
                                       u16 reg,
@@ -938,7 +960,7 @@ static struct phy_driver ksphy_driver[] = {
        .phy_id_mask    = MICREL_PHY_ID_MASK,
        .features       = PHY_BASIC_FEATURES,
        .flags          = PHY_HAS_INTERRUPT,
-       .config_init    = kszphy_config_init,
+       .config_init    = ksz8061_config_init,
        .config_aneg    = genphy_config_aneg,
        .read_status    = genphy_read_status,
        .ack_interrupt  = kszphy_ack_interrupt,
--
2.7.4


P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.

This e-mail (including any attachments) is confidential and may be legally privileged. If you are not an intended recipient or an authorized representative of an intended recipient, you are prohibited from using, copying or distributing the information in this e-mail or its attachments. If you have received this e-mail in error, please notify the sender immediately by return e-mail and delete all copies of this message and any attachments. Thank you.
