Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeBZAaB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:30:01 -0500
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com ([104.47.38.58]:45136
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751817AbeBZA3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:29:55 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
From: Andrew Cooks <andrew.cooks@opengear.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC),
        linux-kernel@vger.kernel.org (open list)
Cc: Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org,
        platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>,
        Andrew Cooks <andrew.cooks@opengear.com>
Subject: [RESEND][PATCH v4 3/3] i2c: piix4: add ACPI support
Date: Mon, 26 Feb 2018 10:28:45 +1000
Message-Id: <d197d95d77afa2054ff1b2c593dae7939030e24b.1519601860.git.andrew.cooks@opengear.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519601860.git.andrew.cooks@opengear.com>
References: <cover.1519601860.git.andrew.cooks@opengear.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME2PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:201:15::14) To DM5PR15MB1210.namprd15.prod.outlook.com
 (2603:10b6:3:b2::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3556f4cd-e8ed-476f-50b6-08d57cb00e29
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1210;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;3:fca5INRss1m4Gc+4nkzJKNAxYBco4k1ip6JpGDpqeX7ciZlwOqfzINvBRaAfCoSkwpgBjqq7guEiz10BDq9LXRzEZkJDmt6dfnCu9pQsIBtiqrw3SnVyA8wTxZOIddtto+tyHDsA3v6CYTb/GoOX++guw23lu3PVE38agL3oHyYV9IaQe5wYjzBavh1JctVDY6WrRAT7E0zN0zMG4ohLe5wbE/4UMGWcQZJCPIagXfiZ6WqZQzOb5cORGdVjJEqL;25:1IiYTpYJjO8sjOxslA8fdJXgx4cHwVoGRsydFRI2uaw/DNe63CijgGqCiJ9FnWxQWFRSi3Vl/38/Lm62Sxj76+NcQ4hO1fxRzFfZQNjgMup5agTYxB50D3eyjiBzQL/hXR/hWJrDfRebZTG11azWEzCKdBKCgdfU9dZeV54Zqqc0jIAkX4f6h0vcxZlB8Q7f5LJ05IsqWDpOE9to31exW+8ecNk7CQ83uJwBuHvGLqZkAq1J21kyqpbqHA6yX6hX2LyE4MklZdT0MffDeSEvcdV228gikL48gMQgJfaz7NsLoGCvvNxGWtL5esrcxpSqH/qx11lruw2pCs9f7DRk/g==;31:TNBOuXS5sSnWwKD4hEz429MJK5AfF3xJKxupzKrvdTMNfURF5wFWOY/AnfW+qr1fys100d7XJP2NSS+1BsvXGrmBFiotMFJorM7yoYqnY95V5eYqbVvHNPbU2GRuh9JcN7hf77F4ef4z8nVqOtxeHrEogbhbErMQLvWhH16KJuuGvrzoqExvmnokeIO8XL3ighZ+zVqxb2lH7+JV6sNeMMTBmJCjaZklsffx/REqQ7Q=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1210:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;20:/XTryZHzxbPw5RgPvQoRVxdkhfItAC2to/V2B7fsxwJTM1oN/+jWNnIFDzKi4WlkcAQQ91fqQh/N5mtb8lw2nIoMwn8aB0XRN2Zj8Qt/o1YSCZyGtZbP+uW4/+Wd6B8ZJFQtI4qTTrtIUJ+ui+GaIQKnjni2oa4WB3lGvvYGyzk=;4:18gCDNbyLv1JaBP/r8R08rvzyWd6u7MqU5TG4QNroY3drAq3uDnPapbP+ocFkOY24HW8nErkHslr6lnl73t+MqcZ5m1tkZCAJj88Qi1+/6G5jGCTA50Xo+mRsNQP6iRDaorHEeaLJF2OaWR35lW2/CoueP5Y5KLISt0mtgYn6PsOSYmQf8vYk3xzeAU22KmS7KycbCD05DeD/PFGBzfQt0NMHaMuzkXJVXhCXcLdQSeqJe/0PhixZv9IIlX0DwiHF+XbQdYiwsL1VwaBVslb3g==
X-Microsoft-Antispam-PRVS: <DM5PR15MB1210509B4F8E90966F4CC027EEC10@DM5PR15MB1210.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1210;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1210;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39830400003)(39380400002)(366004)(199004)(189003)(66066001)(76176011)(52116002)(7696005)(1857600001)(97736004)(68736007)(54906003)(110136005)(118296001)(6486002)(51416003)(50466002)(48376002)(59450400001)(186003)(4326008)(16526019)(26005)(316002)(86362001)(25786009)(386003)(107886003)(305945005)(16586007)(105586002)(3846002)(6116002)(478600001)(53936002)(5660300001)(36756003)(7736002)(2906002)(106356001)(6666003)(8676002)(2950100002)(81166006)(8936002)(50226002)(47776003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1210;H:andrewc.bne.opengear.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1210;23:9N5gfMTddor0NnZ1jOXDwa7spgWjp/gx9gT57j6t+?=
 =?us-ascii?Q?pgjAlAXKF42WeqT5qVnqUgxK7hUGInOnzFL5F7dcX7gx+7NJL81BNkOZXRiD?=
 =?us-ascii?Q?gf5XBzfOeihux09BUOIWZQTeQU5BWfOCKa+DFxMJbwS5EJBttC8QZDDYhOso?=
 =?us-ascii?Q?ad7JTiDlDIntT+iY2LKieUEUIpHclXn86bsDbbtIb33ROVSJ0YFBeHFHTH5p?=
 =?us-ascii?Q?dVRR08nwlEpXI0tijXN7PKjYtyx5ZIZWFnRD/Aw/T3aFniO3eLmPj323fCeh?=
 =?us-ascii?Q?iXREa1GWsX2x89VUnsB8DtwqtZnpdkq4GOoBjELG+4Yv5+DnlID3VWrysO/R?=
 =?us-ascii?Q?DGt5Yqyi9iMPdXW0Hp5+4u6vctmzuAEoFm3YLotp6lI8Iohp47skr9xPq9s/?=
 =?us-ascii?Q?Xo+X5HqfoiW/A0w7WHsPnBmbbAWFpUDSO/lBkBqbwA8Mf3iZaPw3J7jfAT0Y?=
 =?us-ascii?Q?0UrLOtgwZN4nZSxoAT6Vk5JEJxf8SVY1riZYKBX1LZ9wpgLPBLiBe+h6rHNW?=
 =?us-ascii?Q?RZR7XIY8G2BYQUD5G5QfDYPi65Di8i5uFApdOig43DgMPL0mRDez2wY4UmlA?=
 =?us-ascii?Q?DDi1rqpvuOUxHnqXwlYvrqDH7CxoOU8+bzIv05biKQr7kfgUNRvDUExBsfpg?=
 =?us-ascii?Q?kvvJeLDew5kO6C4c9F7FkSNYHU/XhZ4vL9i6MBQDBnvSjm8vnUp1bidPBEv7?=
 =?us-ascii?Q?zAioxmThwN9oJZtp+iFR4n/ihN6JNE1ET+yfLZDS+U/Rqifk90IqdUWVbETI?=
 =?us-ascii?Q?JGu5t+0f+dgOTvT7ucAhSUReg93UwQYAyRCuvQpi1LSGSumNMgvArxzRsyN/?=
 =?us-ascii?Q?Q76miMQZPxLEkEUjD9cz5j8ld2gPI2Ts76FqGq5yo/TzsbcHqo732gEixj0U?=
 =?us-ascii?Q?DBHgOXqSD/zMWYAgPTmPzNWvCKzCulrHiam/EOyHF7FXximq6sbrEb4fSz4n?=
 =?us-ascii?Q?NHFhF2uRsmObMuSVZSU2g7mKwVwC2ST2FzJ9usEvAVINpgq+zw0QZuZIUY48?=
 =?us-ascii?Q?WqNJApBSkEjVUHazBLr76/S8t5dkANCtFHhgGNggXc/nMb3qQdDcUBE+TrSn?=
 =?us-ascii?Q?BNhfpTgNXNwW4VnrkSHCPRQoX59zUKcSUvkXT53HH1I7P7BtQFoLeKd8gDvJ?=
 =?us-ascii?Q?+WONEnmxA/fFKCgBJNWDVl4vR0F7YuzcbrjgaHo4k6xpoo8PrzQzPZV7cHm7?=
 =?us-ascii?Q?aDB0h3uaJGeJTosUnrE+HSiCrsvc8n9q9w7?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;6:Wum29xN1ppu/kbhChnppP4+aMxkCrnI/mkLXXjwJXOMft36s1xSMjkFDbFYD/TIQCRyzX5ktwOpHe+XrWcCv/QtDQAFOhTNFsYOqIdHro6DP1wkCnuJp4XwgJmgYNydap2zCS9jkmQHMki7CZsVl/DmOr1fDmVJVvonGGBKPdlfmBnWy33UznOPtrLAEcdMjLUWirHOGNo30DBbzh2P2DMgOfUvXZJObZrzsuJPbK8mXxZ5llAcrODNlwEOCGUikPUoX9VS2CKeGqlVK+Qs5pbEKlrfdAqlGfO4GQUKxocO08bmz5L7MbKJIX1RU8+KJc0s00LqO/xXkVmM9zOnrPwwXtd8f3PBBXHdlxY8vLi0=;5:5EAfUKc+6dNU6stGnPafHwaN18KHH5Oh+7gNPHGxe/bMBpFAoANwdmFZIIJ0Q/KizsY4QRmnZGySIWqHy0EHpXybuTMzDgiCDw2ftLR/b8JHondfaUGgZPbbJZS6E7N6WCRHsQbJN6cfEywvOQOEG/HIS4tdIIAee8S8uM/6rDI=;24:SpLSp5lFjNN56GY/kZL9O1omvMO2PFBKf88mzm9A+jHBeY0jSDbaMq3U3DaE6Fb9YPJwD9flSCe1jPkqLHuzPS07d2SCBiAFDWo6Mnui16Y=;7:xfdGIaVjvEGaQ3DGyS2LB7780Yu8+XK8ge9hyXbXef1WIflGnBjBMNSCxt+6tPhP21idzYsQ9mIDRlqqmjHR4rnrTCIi43ZKmovVxcDnBoFQUptjK9DtI+62NMv2FllFwptcH028o5VXDbbDULbqgEWaDlJepE1v33BifgnYBMDrK0aaUy3i9KmjQbaaO76P1IglJm9LoXnC2JIr/TDYH0F+TFHo9/oDrWWLDdUOFNBZcFE+Idkh1jZHJuqfAQ/p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 00:29:50.2876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3556f4cd-e8ed-476f-50b6-08d57cb00e29
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the i2c-piix4 SMBus controller driver to enumerate I2C slave
devices using ACPI. It builds on the related I2C mux device work
in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")

In the i2c-piix4 driver the adapters are enumerated as:
 Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)

However, in the AMD BKDG documentation[1], the implied order of ports is:
 Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...

This ordering difference is unfortunate. We assume that ACPI
developers will use the Linux ordering.

[1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
Models 30h-3Fh Processors

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 01f1610..9a6cdc8 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -837,6 +837,12 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
 
+	if (has_acpi_companion(&dev->dev)) {
+		acpi_preset_companion(&adap->dev,
+				ACPI_COMPANION(&dev->dev),
+				piix4_adapter_count);
+	}
+
 	snprintf(adap->name, sizeof(adap->name),
 		"SMBus PIIX4 adapter%s at %04x", name, smba);
 
-- 
2.7.4
