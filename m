Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeENIDk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:03:40 -0400
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:37439
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751584AbeENID2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:03:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Samarth.Parikh@arm.com;
From: Samarth Parikh <samarth.parikh@arm.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, Sudipto.Paul@arm.com,
        Arvind.Chauhan@arm.com, Deepak.Pandey@arm.com, samarthp@ymail.com,
        Sudeep.Holla@arm.com, Samarth Parikh <samarth.parikh@arm.com>
Subject: [PATCH] mailbox: arm_mhu: add support for mhuv2
Date: Mon, 14 May 2018 13:32:42 +0530
Message-Id: <1526284962-13272-1-git-send-email-samarth.parikh@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.105.40]
X-ClientProxiedBy: BM1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::16) To AM5PR0801MB1251.eurprd08.prod.outlook.com
 (2603:10a6:203:1e::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1251;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1251;3:6T7yu3CVjcmFgKVqBCuJpfRJZalLv3XZXGqpXC8v7uWciPCjaWa/WlaS3KsRHXCNNxFUJ8AjJ6IP/hf0y8fV85DP2TZAxeknPXOS68KVjc38vQGhDsnu8ogoqlG3VDpeSkAkNLwBIl68h/fQyfqA2+xpK+kRy2T3PsH7Il5QpysriQk3fJJbbiQEXATKyXkp+3trab6d2YiwtNudRPl+YNN79izyh2nv9thWPwgADatXrd3jKKW1nRR31PH4Q8tN;25:+zGq4uDn/8/WMH5kTCvmK0259lJhnevAuqIBlmMVbUzSkuqLVvJb9H5h26xdQk9k4YkZjBkyzhqSVO2vOuZas9WTCSh3q80FzM3aCsVnx1jEomyoJkI3UhTgik9h+Ix38h6Q3QdcIDDPSALZiR/dHXIy0zIRHofUvlLCdCxg5F+pkzKlmPr2ml6nCdIetvd7j9c14QH2Ka6Oe+2VPXzHRXGmxWX7PeqxYOM7EbgXvFxjpNGfc4kIwqo4M20wNf12ksO5Xbe1DD5RzDKPN1Ojjfbo/sPHz6pmAqn3nXpKFP/u7NTnZgUdTVp1PBPymicOt5RzvYQ7hZ047XkjBAVojA==;31:9FK2kueD9uDU1wynuFkkHkszdLxcISTJnNfgU4YYV+FQITovUSnyLgk0wwIZsa4qvwL83MLb2KP8DyyjV2f5+eL0jZMkbaEB/Y+2mSKwyDcDspya7VaCN6O1qHn5CRhBBEgpkAi7oqENXSn/dqJkZJ823XQ7XiW9EPqaE1Xc0jQJJzQdhryU3IMCb2gc6yE1gFlERPR+898PQdbgqS2Ig1Ur1tqJTNuhR2cYCzTzCHI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1251:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1251;20:s3U+IWiMfnwILrPRkMbj6WXKR7gCUp06th5uSqdciEy+D1DaX1Q6UlLvGJtyDwI2h27rvZGCfxHFJKr8LqIrl6FuexspdCryh1TPZUAe3lJq7qyEp744rYj+4V1gZ7///ZR8m7tyKldCVflv+trKP3isGc6rTl8YkuhRhvyTOmqn4/TG5RZyNZAZ8mufM9OJiSMGUSQhIJgO89c9QEdSgnrjh74L/bmjvZKiiETF/XIPe/okU8AL0S7kKPBMdJV+S908MiF1zVYJhfZpCBepB+tW94F09otAKAHogRkN4NuUBGuiErMCIoI6DRRil2yjxhtpAo33PPRdFXRv2QsIH8kQSy46LhIdd7eyu1Bz6HOXo+oMnJLpuKeiLLDaMz3GxuaW5hrCdzImq3rcyOn9T2UTMX7f3vRJnPcZUA/zg7QHdM1cCtq2EmRSfxm5hwt46LTwrk+nPvRWlSzTP7O/mojoVLG/kJJgNwandMfOM66kHUEgNQAIS+DHt+ZL2P/b;4:2+XFfmSyxGijoTJslqKq/GCuyCEFWsE2mwMpFRar7j/3Vo+m9SE+KaueRiJ3zLjaa9KZZrOAgFzq+8eOlrT4LCwkGu2WaJutBm6hVYslD3WRI/1Tez8Fh8KJ3fVUEw7MpNLReV+ddrddoNXR1vuWy8OggN3YaXRzi4VdT+M71EiD/OCcuXiTrpKlQ45cvjq3OqfsWzqK+/VhCQEjmDWC4Cz7k05JSoeCdUrouDf3/h3NAnGvDVeq6B0jiH5pxLjlK0+0J/P8xpqYSo3lqsEFsNJplV4p/NZqzs7/ysE0mpIgcrGFSmHeGfoMhvp9Fu2ZOft2gAJ9nHfheaDAD1nnjjKAdTNTFZsiaLZUyDJh9sY=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB125119C6B55F4990F782705C9C9C0@AM5PR0801MB1251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(9584868988793);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1251;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1251;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(39380400002)(396003)(346002)(376002)(40434004)(189003)(199004)(52116002)(105586002)(106356001)(5660300001)(53936002)(186003)(26005)(72206003)(956004)(16526019)(2616005)(59450400001)(478600001)(305945005)(25786009)(66066001)(97736004)(486006)(476003)(39060400002)(47776003)(51416003)(4326008)(7696005)(44832011)(386003)(2906002)(7736002)(6486002)(316002)(6666003)(50226002)(2351001)(81166006)(68736007)(8676002)(6916009)(8936002)(1857600001)(50466002)(6116002)(36756003)(5890100001)(15650500001)(575784001)(2361001)(86362001)(48376002)(3846002)(81156014)(8746002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1251;H:a74742-lin.blr.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1251;23:CGEv83Ewe5KmPfMsfSiy+sIbFiIYGnE0PStjty9?=
 =?us-ascii?Q?CbWoon6ypl1uunJCxJOFpbrlZ3EVI/DUiDJ5cQppGQfEU8XN7e7Mh/lctyjt?=
 =?us-ascii?Q?yHIft+igZ16BS3aMNWC11buU6ZrOgPJUi030fKYvvJyxHlfScRqEie6tBAZk?=
 =?us-ascii?Q?htXKhDpibxhIRzDkt1PBYBn68fcNPVeZQtQ9K6vywOR+N8/IbDg07wHHtzvn?=
 =?us-ascii?Q?jVmO0oci8blo3ZcGms2fk/ebgQ90cEj/8B82C7hT7BwIq5AoIyMVdE1pgs9L?=
 =?us-ascii?Q?/G6EH0QV6NNWyGvDBUtkUiiL8fTj9UgvfmyiD8g+D8/TIp7dw8ZWCcxkyJe2?=
 =?us-ascii?Q?ITG4ufctWp6TBSeWfwk0Fng41Rt5wa0PDtAD5qdqPCAGHmUyEFH25j1+VB9R?=
 =?us-ascii?Q?IN2Cpg9bGJjInIpMEBbPrEilVLoshZ2lzaxU5nIXcFoZxmjkdNAIz92/RZaj?=
 =?us-ascii?Q?9NpRHuKRsX8tbxq780jim6v0YxiNS5K/GKBczKn/YHTs5F1fSs/cSnoUhbZg?=
 =?us-ascii?Q?TwU0ahZaH7H15P0/6lfa22zV0GZ/cljnz1YsQ7nZ3CEI3QkkjcsCUxuZ6Zl1?=
 =?us-ascii?Q?v3DW4NjyzCDmtTvW848J4j8FQZL8y7D8DTzZfLidquTMOUBUgGaUT++9wwl2?=
 =?us-ascii?Q?s532bikTskpNCqT9UGJg2Tg1P53N9Djg97TZ/yF6JdF+1mXVFWJD+vPfVRCY?=
 =?us-ascii?Q?VXJBaodzmWysUp0NNiUSb3wBicrJZKWlcLsMmNCEMrWgR6mIPJFCinvaRFGm?=
 =?us-ascii?Q?OHmn0ctV/P4eOgmOWXsWZIqmH9PJXsM9ejXHpn9gXPlU8IlKDlggAwf4N8to?=
 =?us-ascii?Q?JoeypVbgDqpp5SmnfOfVwEi6KKJf3u4AfoljZ+D8e8tl/SGEoWfrd2J8/559?=
 =?us-ascii?Q?4xdHzNV0cAJ6qXwo9zajTGit3BEdLz4oUS0wzErr0Ni1VKGceT+O/JqSghul?=
 =?us-ascii?Q?5MLZgNnwSOTvkqqq+BscXXM5wEyQ6n/rn5q7KUcANUPOJ0kLSQkw0oF70epH?=
 =?us-ascii?Q?XuWEyM51b2uDoHSeV3MlIw/3aj0VbjgATBaFU9UP0r3okHTmbVIu4VbKJ4Vp?=
 =?us-ascii?Q?kTAm6h047r8rb5bQLEupKW5j9yKXpU7+w5XiBfk4gR5x+L1OG9aOHWvNCTij?=
 =?us-ascii?Q?N3X918kIRO6hmGss7dBDLaC5olmIZ0kfWwA+IX/8KHPyXFA5JsbXILjY5l+2?=
 =?us-ascii?Q?wbhHX8U6+Ds0e2UkKh4u49fHG2HVH6iiDjxKmlxGgsz6UAOcGXnVTOj6ywRR?=
 =?us-ascii?Q?8KbsJDPpT5moqCu1yd7AC6emPCMrY3H+Zs6lyV+DQUrFV6A2S+/eEcdKs9b2?=
 =?us-ascii?Q?g2Fr5IEoxE11w5dDhj4YP8rSWdW0kV7Sc8Kel+yy/YIw6U/obMxsyS0Z78W7?=
 =?us-ascii?Q?aYuX0mQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: wVYG9l6/vf5LuJSbkQrI2XOifgyRjDDY/HChBOwzNAT2yoelY9nDgUPnT6lHXAy4FoS5oHHnQ/0HdpIobLTOkHWZr0T65VZQxjvVOv8Y8Eaym936WmdqcLZePoA3OU2A9Lnbh9B6XLFtaGVaD+tdt6xe7C90RdsMCoCgFvkBsERI0dep3KTeZcXFyn0LGdmo
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1251;6:qay51A0hS1eQN5sT5/XUEqSImg7TZo53YCdmzlmoNWUFCBqZxFBpiQpl5nP3iyQL4s7T9floKzpS0CnCRjzzCU9BWPHZaZC5pLYnrevUijmR2RB/hPqIBo9InFbDCKGQHuHXyB1bVVRKqnHqiV/lWSvdbzWiIfN0oGotb/ezDUWRwyW9sfwZqJCBNqewriPhtIvmI27XYXOZ7V7NDkm8Toj9E4HaVFDyCVh8u4YwUfkGSU5ciu6j28RKK7voub+/fqtHSEzLvMsSw2f3y1KR44XjzyXn7t/u9703rKztCgW8R6mgrHdcG9aYbkk0dEtmbFpb3iBiUsX2vye/GT4NlrOJDs79x3zzBc+VbAI/Rnu3GHva/mL5e/ZnzTQCrTSorS/5AN/Qzokujg3M61cO1sYDD/3fZanPF5LXn5w6vNMMymS6o5/rZWtztNQRKVMf8olPG3dqEI06+ZRf/Wr4mw==;5:lsDo57wxcGntesJZ+SIWlFSD+VQBgF1EZCSdLScX0RKKWlkA1tkXr125P/iu3e6KOkbcnO1H6+xLXpCorQXCgAVRXt9KGZ15t3FWWw1WcaIfOW4vglwCWm36YLrbhbU2vbidx9cJ2b2DXQrhhwx32eIvmH86Kcyk2Jdqld3BaMY=;24:S/Tkt9gRqFTsr9fAHS+s+Xq3KkuJBwM09TPu+lWwS/jFqIs3nS1oOWdeKHqmIJ1bb+vL708pjakEcDWL73PIeeP9q2U/x2vh1GEtPD3fmy0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1251;7:nwchMe1I4Xt1aEqXEdiZkhMdv4rs42STULqh3ZYUd10i1xZu0MN2eaRnHGTZq/5VkOX8N4pupYujNSkFok358NsSI/Y+KQaeLz3xVkk+znZITIX0g91eU4vB0vAOAvIYX21wt+vB8Ian1FcH0hZi+wCYc13mycMc2F8BHFKh0dUWvf2PmUS/Siq4ELBjtA9EJUcpWr5CCjbaMsBOv2P5vPsTTSi5IVXzW4EjxjGl5LauhxIyF80PeWGrPJcQ1IkU
X-MS-Office365-Filtering-Correlation-Id: cce2f64e-8454-4eac-5bb1-08d5b9712b0a
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 08:03:23.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2f64e-8454-4eac-5bb1-08d5b9712b0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1251
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4E83lxa008379

ARM has launched a next version of MHU i.e. MHUv2 with its latest
subsystems. The main change is that the MHUv2 is now a distributed IP
with different peripheral views (registers) for the sender and receiver.

Another main difference is that MHUv1 duplex channels are now split into
simplex/half duplex in MHUv2. MHUv2 has a configurable number of
communication channels. There is a capability register (MSG_NO_CAP) to
find out how many channels are available in a system.

The register offsets have also changed for STAT, SET & CLEAR registers
from 0x0, 0x8 & 0x10 in MHUv1 to 0x0, 0xC & 0x8 in MHUv2 respectively.

0x0    0x4  0x8  0xC             0x1F
------------------------....-----
| STAT |    |    | SET |    |   |
------------------------....-----
      Transmit Channel

0x0    0x4  0x8   0xC            0x1F
------------------------....-----
| STAT |    | CLR |    |    |   |
------------------------....-----
        Receive Channel

The MHU controller can request the receiver to wake-up and once the
request is removed, the receiver may go back to sleep, but the MHU
itself does not actively puts a receiver to sleep.

So, in order to wake-up the receiver when the sender wants to send data,
the sender has to set ACCESS_REQUEST register first in order to wake-up
receiver, state of which can be detected using ACCESS_READY register.
ACCESS_REQUEST has an offset of 0xF88 & ACCESS_READY has an offset
of 0xF8C and are accessible only on any sender channel.

This patch adds necessary changes in a new file required to support the
latest MHUv2 controller. This patch also need an update in DT binding for
ARM MHUv2 as we need a second register base (tx base) which would be used
as the send channel base.

Signed-off-by: Samarth Parikh <samarth.parikh@arm.com>
---
 drivers/mailbox/Kconfig      |   9 ++
 drivers/mailbox/Makefile     |   2 +
 drivers/mailbox/arm_mhu_v2.c | 309 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/mailbox/arm_mhu_v2.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index a2bb274..416bc78 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -15,6 +15,15 @@ config ARM_MHU
          The controller has 3 mailbox channels, the last of which can be
          used in Secure mode only.

+config ARM_MHU_V2
+       tristate "ARM MHUv2 Mailbox"
+       depends on ARM_AMBA
+       help
+         Say Y here if you want to build the ARM MHUv2 controller driver.
+         The controller is a distributed IP with different peripheral
+         views (registers) for the sender and receiver & has 3 mailbox
+         channels, the last of which can be used in Secure mode only.
+
 config PLATFORM_MHU
        tristate "Platform MHU Mailbox"
        depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index cc23c3a..ae899a9 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)      += mailbox-test.o

 obj-$(CONFIG_ARM_MHU)  += arm_mhu.o

+obj-$(CONFIG_ARM_MHU_V2)       += arm_mhu_v2.o
+
 obj-$(CONFIG_PLATFORM_MHU)     += platform_mhu.o

 obj-$(CONFIG_PL320_MBOX)       += pl320-ipc.o
diff --git a/drivers/mailbox/arm_mhu_v2.c b/drivers/mailbox/arm_mhu_v2.c
new file mode 100644
index 0000000..259d4a9
--- /dev/null
+++ b/drivers/mailbox/arm_mhu_v2.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 ARM Ltd.
+ * Author: Samarth Parikh <samarth.parikh@arm.com>
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/amba/bus.h>
+#include <linux/mailbox_controller.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+
+#define MHU_V2_REG_STAT_OFS            0x0
+#define MHU_V2_REG_CLR_OFS             0x8
+#define MHU_V2_REG_SET_OFS             0xC
+#define MHU_V2_REG_MSG_NO_CAP_OFS      0xF80
+#define MHU_V2_REG_ACC_REQ_OFS         0xF88
+#define MHU_V2_REG_ACC_RDY_OFS         0xF8C
+
+#define MHU_V2_LP_OFFSET               0x20
+#define MHU_V2_HP_OFFSET               0x0
+
+#define MHU_V2_CHANS                   3
+
+#define mbox_to_arm_mhuv2(c) container_of(c, struct arm_mhuv2, mbox)
+
+enum mhuv2_regs {
+       MHU_V2_REG_STAT,
+       MHU_V2_REG_SET,
+       MHU_V2_REG_CLR,
+       MHU_V2_REG_END
+};
+
+enum mhuv2_access_regs {
+       MHU_V2_REG_MSG_NO_CAP,
+       MHU_V2_REG_ACC_REQ,
+       MHU_V2_REG_ACC_RDY,
+       MHU_V2_REG_ACC_END
+};
+
+enum mhuv2_channels {
+       MHU_V2_CHAN_LOW,
+       MHU_V2_CHAN_HIGH,
+       MHU_V2_CHAN_SEC,
+       MHU_V2_CHAN_END
+};
+
+/**
+ * ARM MHUv2 Mailbox device specific data
+ *
+ * @regs: MHUv2 specific array of register offset for STAT, SET & CLEAR
+ *        registers.
+ * @chans: MHUv2 specific array of channel offset for Low
+ *         Priority, High Priority & Secure channels.
+ * @acc_regs: An array of access register offsets.
+ */
+struct mhuv2_data {
+       int regs[MHU_V2_REG_END]; /* STAT, SET, CLEAR */
+       int chans[MHU_V2_CHAN_END]; /* LP, HP, Sec */
+       int acc_regs[MHU_V2_REG_ACC_END];
+};
+
+/**
+ * ARM MHUv2 link specific data
+ *
+ * @irq: MHUv2 receive channel IRQ number
+ * @tx_reg: Transmit channel register
+ * @rx_reg: Receive channel register
+ * @pchan: No. of physical channels
+ */
+struct mhuv2_link {
+       unsigned int irq;
+       void __iomem *tx_reg;
+       void __iomem *rx_reg;
+       unsigned int pchan;
+};
+
+/**
+ * ARM MHUv2 Mailbox driver specific data
+ *
+ * @mlink: MHUv2 link specific data
+ * @chan: Mbox specific data
+ * @mbox: Mbox controller specific data
+ * @drvdata: MHUv2 device specific data
+ */
+struct arm_mhuv2 {
+       struct mhuv2_link mlink[MHU_V2_CHANS];
+       struct mbox_chan chan[MHU_V2_CHANS];
+       struct mbox_controller mbox;
+       const struct mhuv2_data *drvdata;
+};
+
+static irqreturn_t mhuv2_rx_interrupt(int irq, void *p)
+{
+       struct mbox_chan *chan = p;
+       struct mhuv2_link *mlink = chan->con_priv;
+       struct arm_mhuv2 *mhu = mbox_to_arm_mhuv2(chan->mbox);
+       const struct mhuv2_data *mdata = mhu->drvdata;
+       u32 val;
+
+       val = readl_relaxed(mlink->rx_reg + mdata->regs[MHU_V2_REG_STAT]);
+       if (!val)
+               return IRQ_NONE;
+
+       mbox_chan_received_data(chan, (void *)&val);
+
+       writel_relaxed(val, mlink->rx_reg + mdata->regs[MHU_V2_REG_CLR]);
+
+       return IRQ_HANDLED;
+}
+
+static bool mhuv2_last_tx_done(struct mbox_chan *chan)
+{
+       struct mhuv2_link *mlink = chan->con_priv;
+       struct arm_mhuv2 *mhu = mbox_to_arm_mhuv2(chan->mbox);
+       const struct mhuv2_data *mdata = mhu->drvdata;
+       u32 val = readl_relaxed(mlink->tx_reg + mdata->regs[MHU_V2_REG_STAT]);
+
+       return (val == 0);
+}
+
+static int mhuv2_send_data(struct mbox_chan *chan, void *data)
+{
+       struct mhuv2_link *mlink = chan->con_priv;
+       struct arm_mhuv2 *mhu = mbox_to_arm_mhuv2(chan->mbox);
+       const struct mhuv2_data *mdata = mhu->drvdata;
+       u32 *arg = data;
+
+       writel_relaxed(*arg, mlink->tx_reg + mdata->regs[MHU_V2_REG_SET]);
+
+       return 0;
+}
+
+static int mhuv2_startup(struct mbox_chan *chan)
+{
+       struct mhuv2_link *mlink = chan->con_priv;
+       struct arm_mhuv2 *mhu = mbox_to_arm_mhuv2(chan->mbox);
+       const struct mhuv2_data *mdata = mhu->drvdata;
+       u32 val;
+       int ret;
+
+       writel_relaxed(0x1, mlink->tx_reg
+               + (mdata->acc_regs[MHU_V2_REG_ACC_REQ]
+               - (mdata->chans[mlink->pchan])));
+
+       val = readl_relaxed(mlink->tx_reg + mdata->regs[MHU_V2_REG_STAT]);
+       writel_relaxed(val, mlink->tx_reg + mdata->regs[MHU_V2_REG_CLR]);
+
+       ret = request_irq(mlink->irq, mhuv2_rx_interrupt,
+                         IRQF_SHARED, "mhuv2_link", chan);
+       if (ret) {
+               dev_err(chan->mbox->dev,
+                       "Unable to acquire IRQ %d\n", mlink->irq);
+               return ret;
+       }
+
+       return 0;
+}
+
+static void mhuv2_shutdown(struct mbox_chan *chan)
+{
+       struct mhuv2_link *mlink = chan->con_priv;
+       struct arm_mhuv2 *mhu = mbox_to_arm_mhuv2(chan->mbox);
+       const struct mhuv2_data *mdata = mhu->drvdata;
+
+       writel_relaxed(0x0, mlink->tx_reg
+               + (mdata->acc_regs[MHU_V2_REG_ACC_REQ]
+               - (mdata->chans[mlink->pchan])));
+
+       free_irq(mlink->irq, chan);
+}
+
+static const struct mbox_chan_ops mhuv2_ops = {
+       .send_data = mhuv2_send_data,
+       .startup = mhuv2_startup,
+       .shutdown = mhuv2_shutdown,
+       .last_tx_done = mhuv2_last_tx_done,
+};
+
+static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
+{
+       int i, err, irq;
+       struct arm_mhuv2 *mhu;
+       struct device *dev = &adev->dev;
+       void __iomem *rx_base;
+       void __iomem *tx_base;
+       const struct device_node *np = dev->of_node;
+       const struct mhuv2_data *mdata = id->data;
+       unsigned int pchans;
+
+       if (!mdata) {
+               dev_err(dev, "device data not found\n");
+               return -EINVAL;
+       }
+
+       /* Allocate memory for device */
+       mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+       if (!mhu)
+               return -ENOMEM;
+
+       rx_base = devm_ioremap_resource(dev, &adev->res);
+       if (IS_ERR(rx_base)) {
+               dev_err(dev, "ioremap failed\n");
+               return PTR_ERR(rx_base);
+       }
+
+       tx_base = of_iomap((struct device_node *)np, 1);
+       if (!tx_base) {
+               dev_err(dev, "failed to map tx registers\n");
+               return -ENOMEM;
+       }
+
+       pchans = readl_relaxed(tx_base
+                       + mdata->acc_regs[MHU_V2_REG_MSG_NO_CAP]);
+       if (pchans == 0 || pchans > MHU_V2_CHANS) {
+               dev_err(dev, "invalid number of channels %d\n", pchans);
+               iounmap(tx_base);
+               return -EINVAL;
+       }
+
+       for (i = 0; i < pchans; i++) {
+               mhu->chan[i].con_priv = &mhu->mlink[i];
+               mhu->mlink[i].pchan = i;
+               irq = mhu->mlink[i].irq = adev->irq[i];
+
+               if (irq <= 0) {
+                       dev_err(dev, "no IRQ found for channel %d\n", i);
+                       iounmap(tx_base);
+                       return -EINVAL;
+               }
+
+               mhu->mlink[i].rx_reg = rx_base + mdata->chans[i];
+               mhu->mlink[i].tx_reg = tx_base + mdata->chans[i];
+       }
+
+       mhu->mbox.dev = dev;
+       mhu->mbox.chans = &mhu->chan[0];
+       mhu->mbox.num_chans = pchans;
+       mhu->mbox.ops = &mhuv2_ops;
+       mhu->mbox.txdone_irq = false;
+       mhu->mbox.txdone_poll = true;
+       mhu->mbox.txpoll_period = 1;
+       mhu->drvdata = mdata;
+
+       amba_set_drvdata(adev, mhu);
+
+       err = mbox_controller_register(&mhu->mbox);
+       if (err) {
+               dev_err(dev, "failed to register mailboxes %d\n", err);
+               iounmap(tx_base);
+               return err;
+       }
+
+       dev_info(dev, "ARM MHUv2 Mailbox registered\n");
+       return 0;
+}
+
+static int mhuv2_remove(struct amba_device *adev)
+{
+       struct arm_mhuv2 *mhu = amba_get_drvdata(adev);
+
+       mbox_controller_unregister(&mhu->mbox);
+
+       return 0;
+}
+
+static struct mhuv2_data arm_mhuv2_data = {
+       .regs = { MHU_V2_REG_STAT_OFS, MHU_V2_REG_SET_OFS, MHU_V2_REG_CLR_OFS },
+       .chans = { MHU_V2_LP_OFFSET, MHU_V2_HP_OFFSET },
+       .acc_regs = { MHU_V2_REG_MSG_NO_CAP_OFS, MHU_V2_REG_ACC_REQ_OFS,
+               MHU_V2_REG_ACC_RDY_OFS },
+};
+
+static struct amba_id mhuv2_ids[] = {
+       {
+               .id     = 0x4b0d1,
+               .mask   = 0xfffff,
+               .data   = (void *)&arm_mhuv2_data,
+       },
+       {
+               .id     = 0xbb0d1,
+               .mask   = 0xfffff,
+               .data   = (void *)&arm_mhuv2_data,
+       },
+       { 0, 0 },
+};
+MODULE_DEVICE_TABLE(amba, mhuv2_ids);
+
+static struct amba_driver arm_mhuv2_driver = {
+       .drv = {
+               .name   = "mhuv2",
+       },
+       .id_table       = mhuv2_ids,
+       .probe          = mhuv2_probe,
+       .remove         = mhuv2_remove,
+};
+module_amba_driver(arm_mhuv2_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ARM MHUv2 Driver");
+MODULE_AUTHOR("Samarth Parikh <samarthp@ymail.com>");
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
