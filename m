Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeA3VlO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:41:14 -0500
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com ([104.47.37.49]:63584
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751755AbeA3VlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:41:12 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
From: Andrew Cooks <andrew.cooks@opengear.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC),
        linux-kernel@vger.kernel.org (open list)
Cc: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 1/3] i2c: piix4: Fix port selection for AMD Family 16h Model 30h
Date: Wed, 31 Jan 2018 07:40:28 +1000
Message-Id: <be68c29f603153cf047cd893c6b9d6423073632d.1517285239.git.andrew.cooks@opengear.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517285239.git.andrew.cooks@opengear.com>
References: <cover.1517285239.git.andrew.cooks@opengear.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME1PR01CA0134.ausprd01.prod.outlook.com (10.171.9.147) To
 BLUPR15MB0018.namprd15.prod.outlook.com (10.161.124.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c2c7c66-93c9-4bae-78d5-08d5682a2d04
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BLUPR15MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;3:DAFSG8MlW+9LFM1wd/NfoW1o3KaCoRNVviI8UjP2Gkz/dYliakktM66QWQNjfW7zcH1yyFdqQwvNy3EjxSXoIO9rXEDJbrtkj+bNqDGXMv292SMOG1MW13FiY4qLitnTBZmVGP+cQvZNl8KeI6mHQqbsNvGAv8Pm5t8L/fWM9KAbeAanLLbQkXjC0h1L1h80GULGmTOYtunX+KRD9Pw/UDGjqn+eNdQzEmUoEnHaiT2jmmXAL13t2aMEpUpJDSzY;25:pjnyqSMIqGVNF5eI09/FEcLpNX7PjbZynqBqUsSitQEQHAtozqC5zKWlc8idTj33aTQPKCaYm+HY90tbuW/5hX6EK9/lq1Y+7ro+Tc1m3eQZaSac0BopGFsbDR7S48x+kcZt2cr5icn7EtgLtDzx1obnnhVr4qQn98JOa+pBNBxoBUL+98lcxkLBoXIFBj6XJbLpi3CiG3OHb5wFCSKHTAwe6NxkUcYkkmNLc12oWahCvtdhTbHIWFpV+Jn3kejxCJgfe/+VDZOwcph2OtTuCw9MvONZaW6nBZyy8qX8zv+OGdZpdayoJ6aQFcrPZ450irDXLjJ1zaNM7MNj8cklUA==;31:AWcipTo+7iznhE6CdI51Gep0fGD5GytAs5siQd82++K9wWRo+042BnHP1rfigNYGk4wqyOZNV01a4jk65PXDGJXbel95/zwS3yoaBfVWlryX5yKJh97LqxBVpY6U/jf/RDZMTb7vkQQ79eDprLSBrZVNITaKJ/p/gPiIKhBz2igCW+CzfQXZF+KHFg6VF7dVvU55B88OILZBQth28cv8krhcih2k8nLiRbZGjgcnZAc=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0018:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;20:1itMvEyoS6it7/6WPSuC+BoaDrtKWEs+Y1cGTCEUje7+grEIfzQBfvLKi4Jw1M3n+bSTshRepM22RHPSt5puchjTaAY77M+pDeKm9qGLmsMjlsZdiFkTDiuYZdwQN8uGbExOEgxJ/z4BVFVygV1HFMvH8Od5S0L561I6YYZRX+I=;4:OD7Z8C3F6FyLZ+sM4jYdRG+0XmbjHXNDIw2bqNFrhyXt9oUi77FzKwmQlx4uSPNMEbzlUwDDbX1CkKmiW7FIqOUwTBMg9MOP42AKNrMzv53if/w2/HRGkhuJEj1n/iJAclGZuAiKgBB0xD4v/VcgDQRc22Itf0SUeN8+j21rOIeNav6fnVsaVa/ilA0PIxb/L/UHYaVCtx8CoIv2SFpyp7BxH3UGn1G9UAAqek9PwvIe8jpF91pzcq24uKPg1CXR2sQPwdkOXxL+wVNqh9T4Vg==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0018638B6A5761EFDCEEE72DEEE40@BLUPR15MB0018.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR15MB0018;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0018;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39840400004)(376002)(396003)(346002)(189003)(199004)(76176011)(50466002)(107886003)(97736004)(48376002)(2906002)(16526019)(8936002)(81156014)(575784001)(8676002)(47776003)(3846002)(86362001)(316002)(50226002)(16586007)(81166006)(53936002)(66066001)(110136005)(118296001)(105586002)(6116002)(186003)(26005)(36756003)(68736007)(7736002)(4326008)(106356001)(305945005)(6666003)(6486002)(2950100002)(386003)(25786009)(5660300001)(59450400001)(51416003)(52116002)(7696005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR15MB0018;H:andrewc.bne.opengear.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0018;23:3s7CDKdD/Om5sxQ8ds9YVwunapay/qkXPgNlHFG8T?=
 =?us-ascii?Q?nub5UpGo2aKxFT/z7jvR7lHBQQ4B7YYiboSh9FGqYNW0RTjB5SxUUUUiPrt5?=
 =?us-ascii?Q?lZi+R85Jouicts9gi4OTmMHQ46ergk3tz0utsF+Z8RO40QGoLewUp7B6FhjN?=
 =?us-ascii?Q?jIxFS8K4OIzUFfX1JrOBhq/+Y2mAcWd8CUwl/hMFEYEGRpVUgW4DD0LTF5mE?=
 =?us-ascii?Q?4z4UP9/Ch2QmKlA4nCBoens4dDPUas1wlXfdorsIdgmDj7l55yLlqm6Qa5T8?=
 =?us-ascii?Q?AmxobhYxuvyGrDAuKKP58jVFQW8t98Cka4I6SJ84rRlOqDwkKs0xP9PDmnQy?=
 =?us-ascii?Q?j28yqTGxnfaMimDsj6oS8JS1dcqKy+ozqp6LH4kjL7NtTj9qrtQMI+STGjp+?=
 =?us-ascii?Q?0vNhw1GK1bk9yPzUJLehmgtOh+YK6287g1djeYlMJcq7idsZF9s8Fsk1Movd?=
 =?us-ascii?Q?7LiuwdgQzu3UjRbNluqAF16pjmwWoNiMJQ0ltTMeGEAo+ndlWnMMMNud56ZC?=
 =?us-ascii?Q?Y/EmEy4kdLYr15dbE8WmLJyD+fl9j3TbDMDzRXiOFuVthIKJyHFa1lLyv2bc?=
 =?us-ascii?Q?IBerDJkFoP7xcon0WZLjux69POm52vP0nW/m3jDP5AiBg8CnZAIKKxbT7a7z?=
 =?us-ascii?Q?Vf4TVg818d39L7vKmL3Az4rrefBMhNUWNXCDFoQQx+Rup8e0Gk0E/Wv6QGzZ?=
 =?us-ascii?Q?3PKgZPrO2WG2k1f2rmSolGuxOUANSxBH2+PrlvQEKxp7hqfTCj9bkAH+ji0i?=
 =?us-ascii?Q?ahzeNWSFb23b3J9E6hFq0gKWyYq+1r/AXmT6RAd0XpZlMiF3g/Je942rhNZB?=
 =?us-ascii?Q?Y4SDYwEx/rGkjqB8fl+Xp3/Bp6DxLS0KkSMeh9g5i10jmOuGaxONlQrkLAUN?=
 =?us-ascii?Q?T2rnIIFoH/E22U2q/+ktV8G+Q1qWBp7XaiKji5yljnIAeruuZE8hGuVCLbYW?=
 =?us-ascii?Q?nf0BQYqZaII75m4/l5y40/GQUEZML6/ZSnfgRGzIBx99qZrUgoFs0AjCRvQd?=
 =?us-ascii?Q?mePa9KR8q0/fkG0TCdY37SfCnLIQ3XLR/8QcPzrZAhq6VqdH+TG30UQZt6Zc?=
 =?us-ascii?Q?sw5kHL+XNwpzeJt2RhvXT71k564ZndMiioficxHvcbjGUobdRmFRLcOJgz0y?=
 =?us-ascii?Q?Gwqnlp++h94cDaiPdYSEgyLATmMD1WJDXJOOmCVv96Ya1PiAkSESyxM/r/Tk?=
 =?us-ascii?Q?Vr+KpdP2aXac8k=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;6:jS3px0WeAOMW9xUcS5qYDESXbIkgYxvLtwlP4p/Z8ndARJKaaVPhsB+/xGA3XCCnjDVUBVB2EPE3gdL4HrS0YtXDLonMb0sJ7HrS7WaHbRZ2IgIbpTNkHuhbRe1Xg3MZigNJPcpzRVKPziv5+Th+Vfj2/D5+DLZ7F0W8xRA8TrODAMjrw0U5v0PpzCdat0jbfYR1fOOo4+LziU7AUSPlpb6qR+sXApH+fCWIzcY+nushzvBiI7hmXTrJ3SepfSmxg5yZArFMaJoD8wuy8DUir7KIfeX7u2Gl28G2EgC7iHFuM346WNrxr4O73MYjrNJ+2NwEfLoRAbh6CbrI7E1PQtz0XlXuHOIsVOzG90fLGo4=;5:QSrdJwWJ5ql2YZv5+h8kXz3z/ONf8Gh5dOHR6jovuzbotUxYtS5fNGhvOmCeL9t/vY2kUd9NzxzUCQJ4/VIdfTZSXRMd7c6Rg5n/v/58ZkAqNshaTCnn94vH0E3BTuuQ1eU3ywTAJaazxBbfoAcivJPTkwRlQQXDcBPFcIfqrYQ=;24:/eCBzKUp1/MJX/uhRzk3nPTuqW/Z26VWKWGBs7dlZUMr9Mf0d0R/I9SYPP8z2zlzGvdhHBlAs1VxUpFySpi+B/M/eukWOIP6Oge+mQrWUt8=;7:8pgt4vfoxK+SU2xm5Xi3MPNyTgLQ3gNK4vFwEdNWGx43BzUgq+O/aAQveLV250PF2iNeaGcuP9Lv6T3aH6vVSTnQ5b/meaPpdTA5SOHzKGrk1XzOZ9VTC6Sg29kxCfUgzeNESvipJwEjbN2ZRX66zMnTGofwH6x/ezl0hlta6uq0J+GsGh4Yw8A4y4NHUwmzogYplQE/J8RK4F1PjXl0GOVnRAvf0R1VsTGsDupfNPGeSoRADZnosovkn+dfqrcP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 21:41:07.9882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2c7c66-93c9-4bae-78d5-08d5682a2d04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Family 16h Model 30h SMBus controller has the same port selection
register as described and fixed in commit 0fe16195f891
("i2c: piix4: Fix SMBus port selection for AMD Family 17h chips")

commit 6befa3fde65fe ("i2c: piix4: Support alternative port selection
register") also fixed the port selection for Hudson2. Unfortunately the
AMD naming and PCI Device IDs aren't particularly helpful here.

The SMBus port selection register is common to the following Families
and models, as documented in AMD's publicly available BIOS and Kernel
Developer Guides:

 50742 - Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 55072 - Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 52740 - Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)

The Hudson2 PCI Device ID (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) is shared
between Bolton FCH and Family 16h Model 30h, but the location of the
SmBus0Sel port selection bits are different:

 51192 - Bolton Register Reference Guide

We distinguish between Bolton and Family 16h Model 30h using the PCI
Revision ID:

  Bolton is device 0x780b, revision 0x15
  Family 16h Model 30h is device 0x780b, revision 0x1F
  Family 15h Model 60h and 70h are both device 0x790b, revision 0x4A.

The following additional public AMD BKDG documents were checked and do
not share the same port selection register:

 42301 - Family 15h Model 00h-0Fh doesn't mention any
 42300 - Family 15h Model 10h-1Fh doesn't mention any
 49125 - Family 15h Model 30h-3Fh doesn't mention any

 48751 - Family 16h Model 00h-0Fh uses the previously supported
         index register SB800_PIIX4_PORT_IDX_ALT at 0x2e

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 174579d..5c90a44 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -99,7 +99,7 @@
 #define SB800_PIIX4_PORT_IDX_MASK	0x06
 #define SB800_PIIX4_PORT_IDX_SHIFT	1
 
-/* On kerncz, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
+/* On kerncz and Hudson2, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
 #define SB800_PIIX4_PORT_IDX_KERNCZ		0x02
 #define SB800_PIIX4_PORT_IDX_MASK_KERNCZ	0x18
 #define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ	3
@@ -359,18 +359,16 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 
 	/* Find which register is used for port selection */
 	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
-		switch (PIIX4_dev->device) {
-		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
+		if ((PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) ||
+		    (PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
+			   PIIX4_dev->revision >= 0x1F)) {
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK_KERNCZ;
 			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ;
-			break;
-		case PCI_DEVICE_ID_AMD_HUDSON2_SMBUS:
-		default:
+		} else {
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
 			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT;
-			break;
 		}
 	} else {
 		mutex_lock(&piix4_mutex_sb800);
-- 
2.7.4
