Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDPFU7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 01:20:59 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:3656
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752387AbeDPFU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 01:20:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Samarth.Parikh@arm.com;
From: Samarth Parikh <samarth.parikh@arm.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, Sudipto.Paul@arm.com,
        Arvind.Chauhan@arm.com, samarthp@ymail.com, Sudeep.Holla@arm.com,
        Samarth Parikh <samarth.parikh@arm.com>
Subject: [PATCH] mailbox: arm_mhu: add support for mhuv2
Date: Mon, 16 Apr 2018 10:50:17 +0530
Message-Id: <1523856017-10706-1-git-send-email-samarth.parikh@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.105.40]
X-ClientProxiedBy: MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::12) To AM2PR08MB0067.eurprd08.prod.outlook.com
 (2a01:111:e400:841e::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM2PR08MB0067;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR08MB0067;3:ZeDYH65f7+vqcG7kSPnYpfkJCEaZafQWJZRIG8UD8BnIGSS9WWBzacDWhpnkLGyRo/6Lo+8u7T8++FR8yFxKe2vCRXKsnGFJ1ra1h9RHBe2KBSUlE76KZGn+57yWGuEncwrwkYLCrs5wrnzn26Cnj+rEurmPCyXGJLz/yqyZiPMKlIlm5MBExPLUGP6geBB+xTfMy/GGnwKm2airffHPe2o08+BzgIUNL7GPwJT9vokNwnWC/2J5xLj2OVuXcLUK;25:freGNN/uwAD671yqhj+IEXal6AbCZ7Kpjv2pXRv/tSkUO0KxbdHDyxX6lS1BaYZl55CBkkePhR2jgVIu6qwc3fiLCeTmYzjgn9CvuoITDzSIDYunOfCWNlqIpIin1B8ektybUsubZ0TAlwjnIzAs8wLZmZJDSWWA+DDQHRszcAp2J1Lfq8hJYb7lTA5qU3kxu/aYgDOPykyx7g58v4fiFA/7Hp4qbsnEeog8Vd9peHLDjrSVfhZA68QOvy/RlmJDwn4mqMXpRuUGaeZxjYaErj4nnKPPSgq0j0Dh4LjAMuKV7Is6a6tR2QZTdqwTLyUhApTTNcngKaLZmSsHkSnnIQ==;31:Z8k+SoSQGfLTzhMzwERbVne+BjBj41XJbuiGI9nF9VAART0q/aycjyLfzZspSPBngF/7CRW5tkYUXrAs+E/HjKiUR+ZX06Ol8VFMa8iyQotOPdrXN8ytURDn43KqVqNUMw21nQQ25iN3t1KKV1LUicc6Z5kahRFspbBdQK61t3WOZYkcLQmaT0NojMne3hhXKkXTtNeqU6Z8q3U6N0PikOBtnYTaK9DWAWQcLl3QW48=
X-MS-TrafficTypeDiagnostic: AM2PR08MB0067:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR08MB0067;20:SxTt+9yedmE2T7CaSXVNtEEB/PLNstUPDvsjIo6DE/gnNLGBiKzvqaD2nQg5qeoR7tvoBT10v2VWnLlf6DRMGZC/B2g92cf1hMxycKGx36cQsNxZketKLFF9ynQVx2+AtNgSyuWrurYzHD7AqNjUUH7xLpcxGgWsOmtUNAV2/V5j0xmkZZP1Wo5ycdLDMEeN2GqJIKXIlfyOMRW/vzfTy41XwRMlBbnP1LHD7kJckW2NzVS2SSsoXqInIvqqr1480TiaZOe1/VQ98I5f/jvpWmVJITTMBX9vG9WolDUzFoM7DeSXQ2y4Hz/py1zIpO5fnu136qmDoErxQUvM9BD9ETv8T6k+FJbo3tw7jW0Cjfh3wq2NJBSwTE23105RQ7rDBdCT8mmTXn1x+GNv+ezYYNOUXMVV6ETukNyYRWHdwBquR4cYF1//+NOCwv3rVj+GCROce871noaj2bahqSN5JYnai4qTph2OYcyFZWqXCqS58h5BkJDIhMYff4r2Q2ns;4:3FO+6BFmyVO2VqSCk31xZgBAeyguPYcfOvEUZvUd4frvbXBA0Bi4udJRuoI52TWnEL9wWWm5uLj/o/xltaiWU0x4CUIAZkoEU8l42vSDdAaxCAINUk95z+k/P1U9XlEaxwehctOY8xfRLeb1MF98mZPzNjMkBOt2im7eBAz/SzEBk0SqBqv0DgiWAHQvy0ns6pghMd/WynT6yCGUEQnACfWq+1X0EM9+mj63NdfkTUs58o8yC2mAOGe+9h52BjO9vk7L0QdY0jFBw+umsCSx1MnNGRg12olRQjAvHoUEJHC1i3T5H8fkgwSt/OuDfXLF
X-Microsoft-Antispam-PRVS: <AM2PR08MB00671F2D558C3E25057F2CC29CB00@AM2PR08MB0067.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM2PR08MB0067;BCL:0;PCL:0;RULEID:;SRVR:AM2PR08MB0067;
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(346002)(366004)(396003)(39380400002)(40434004)(199004)(189003)(68736007)(6916009)(575784001)(86362001)(6666003)(50466002)(48376002)(2361001)(2351001)(5890100001)(316002)(478600001)(4326008)(6116002)(72206003)(3846002)(25786009)(36756003)(105586002)(2906002)(106356001)(5660300001)(8676002)(52116002)(7696005)(51416003)(81156014)(81166006)(53936002)(7736002)(305945005)(6486002)(39060400002)(50226002)(2616005)(476003)(956004)(47776003)(97736004)(486006)(44832011)(15650500001)(66066001)(1857600001)(8936002)(16526019)(8746002)(186003)(26005)(59450400001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR08MB0067;H:a74742-lin.blr.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR08MB0067;23:CDTIqv9xZohwy0muObAyRRLRM0ZPnKu+Acx06IEiA?=
 =?us-ascii?Q?+IOyPJFMqNp0chXi44YJpvPI8rzvvDYmHS/1OTCv7FEHVCEqJlW0rkinOHW4?=
 =?us-ascii?Q?jsUEO8Z7et6swG3YqEQKFKOMja49hEq8DTh8tP4sKgkpoHHITPj2mzaeCu4y?=
 =?us-ascii?Q?66AoAAm6uu7K3fEeQjwKym6egWqUp1iYphV6j5X7NkFTxEuxUcaa6ZfjL7/X?=
 =?us-ascii?Q?ED2stQrSKYxpeZIZRIsS2Xfn0oq1PkuVYgD++QwqA1qoT+nnNvx3Nuw4n7q0?=
 =?us-ascii?Q?zcwu/XuPd3ElqMbcX2zR4IRPjLVLlx7bHf2qYJY43nNxw4hn3gTno5uCEyMG?=
 =?us-ascii?Q?wwXTKeHRabLKZawqKAInQLjQp5TALmaRT4H1Xst58xyIGXo9SspHpbaPPOSp?=
 =?us-ascii?Q?Jp85gvuXoOBRH93esMUG0ncCKf4eAE/eB67crOSHkep47sIchymh1D/mFOX/?=
 =?us-ascii?Q?SOwC2B5phcPxhHucP7vzPoTF4hjf670oS0QHQ32sE14PdZs4FPasDF/9+fzF?=
 =?us-ascii?Q?E5AHMcW7ZB3qHiRQrpL9Ii5zgOYGxJnwozw6Cpa7P49EWBaxYBaJCNyWu23c?=
 =?us-ascii?Q?BNLYkVo1E/846ZUKXZyM+xu74rCJHBdE/BsJs5isONlNCY3lhkCJi8f+TH4B?=
 =?us-ascii?Q?7VZ+02A8fQ1SiEEoDlRaqeg9/FHZrUjo4kbMuYK61bhfVsd1f5uFqYBbAM+q?=
 =?us-ascii?Q?1W8Mqlac6JBZOJdKPmkW1VLjj5hIZrUIH/FBkMrXlda1aKyE91O69iOQuO3Z?=
 =?us-ascii?Q?HiZVDFkr2cXmRxtLYnlEiz+N95xLoESWe6+akTh4G4v2R0sXcMXJKtR9N28P?=
 =?us-ascii?Q?Hvf0V95yTmNWcQZC6ZLFF/7PHtNd26Ak5eLu3jjL7IBmT1MC4jUWojleSC2J?=
 =?us-ascii?Q?Ri3eVCf7BLIXf3OV8KVu72tZhnYfAijcKZ9IP8SySKNyTAOk1iA4EKFio+ij?=
 =?us-ascii?Q?nyteqIY4yWYffK15tZxIX5qCK4wJphMRNrj66tlT4QVKr3rK2gduCheuKUrg?=
 =?us-ascii?Q?R645EEiOLNZOHmQvknVnZJ2B3lcMUslcgjkgSW1k4TT2MvukuUwh2pOTRTZv?=
 =?us-ascii?Q?L0lh7MvPai5qzhkGDI4gPRHhPZEaYDcwp17MNsC7CPNmQOKsUbiz6Ay9CkU9?=
 =?us-ascii?Q?D3lm/lcJP5MXoef6zwfoi4UJ8OY3PU2mroW29CuSnkylSIbyEyM7DHt3vr20?=
 =?us-ascii?Q?SvDuyG+zWhmo0jSrF0waIg2/1/yg6UnBhF6CBU+zy9hpg6DhX+OJ7iWJ/9WX?=
 =?us-ascii?Q?4kSw1CqhBRsgjRWY5Mqxb4Ekcp20443Ga/mRRoi3MBadyspiMHmH1eq64Q1M?=
 =?us-ascii?Q?Qm8FyiPNIhHyo2CEOBE7mg7OFxpi55Lh6ZcSWW1cHNVIQu+XYmEwzS5o2of4?=
 =?us-ascii?Q?bgmOg=3D=3D?=
X-Microsoft-Antispam-Message-Info: XgZoDqdgR+gDcXAptkd/5fziCz0Gcw0shldTVn7fRKUvLf+13BEGZdRuDGM0bLlO7Y0qFkG6bPR0l2jXz2LvkxKygCvVfpTYUl26a7aCNC9IQukYQSfBl1DKRNGzfru2LIpteQCuvy8uNB0Sw8B9pojhL0NDZHUqY+cTt+apG4k4DYVOKW3KMUHYDgReVH2x
X-Microsoft-Exchange-Diagnostics: 1;AM2PR08MB0067;6:AydxOqr3FPHiQTQq2hbDwd1394Scy613HyPUOU5mmJ2kzTAES17zrzzYWgNNHSjj+FdqlDbSV1POedD57ApigeN4frZR1zBNjV5pYfQMcBB2/Xf2MUv/xdc7KwaPeNQyJN75437XYySSvixnwy+gFfVPmYKNOugKZ9TCp/JiyZcmj3mZeEmLGAxnAMoCyuwBdmYmvgL3qxHHbsulNzfh3iOUIe6qOf1x6Ravm2ck7M54BqgXACXHR58OVqS0Z3WW1w9CzBBGgicVqtae3AJ/QdeAYTuoUVMTk+73UFrASvQVhCdf1a78RSOjmGhXLwz81W4hs+u13Pp7NE3DeBFy1WcE2fsyfnfpaMRHgUAIr/oV2UMol2Qf3EEi0ZsFSb+SEpB9afyYDRUdz/kcE+0omooWmlUt7uUuHTjBahh1P+Dghf4jDFJDY1b2xptObWhBdN+gAqEIwmUsRXBLBFSDBA==;5:BK5cuIy231YiKYZWGXTQ8K5+sagFnjkUQzUUmJCr+QvmUHB4lWRZXXu7TINMggL0c/2II8lmmJGRSC0wOAiKmbz3RgyfAVWQufX8Yt0oY3eGtM8ZejlF28CUgyTOBmnyJiKpPFB+LNuA1/jMHpcAHPSM/WXqW5HTo2uose0jE+U=;24:Y6eJZHJY64r3zkf5CcAf2isjAR4i3NMJaicsgWdkgaQV9YKsv/3MBCoADwnZoRL5fWcMFstGx68+vCVZ89mRlQAN8NQe0ITcT0eNxolZ58U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM2PR08MB0067;7:5CZtZMp6hvAi1Jc7o/P8hh1s9+FVkfJcEZ82eLBb4iYcyOe7XPFT9FOdXNvvmM7uBrTwSwD+VEMUZoW9FT90g5Q4I8w2o8rtxBXdzp8lCYaNTO1MlyimKnXJeFjgo6oiPmLrxz9sjePOJrzUytQlOX5ueP3sYqwKoSGvFp67OKHhwmhGOI0/gvfiDLmSlqtMMUQUdC2tnkU1py3yyspIUkFYSGi2a8Ay0mcx/Db46ub4H6iwl08VwCoSsj7YKUPs
X-MS-Office365-Filtering-Correlation-Id: fe713ae8-1972-4904-4c6c-08d5a359d360
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 05:20:52.1562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe713ae8-1972-4904-4c6c-08d5a359d360
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR08MB0067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3G5L5nO029125

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

This patch adds necessary changes required to support the older
version of MHU & the latest MHUv2 controller. This patch also need an
update in DT binding for ARM MHU as we need a second register base
(tx base) which would be used as the send channel base.

Signed-off-by: Samarth Parikh <samarth.parikh@arm.com>
---
 drivers/mailbox/arm_mhu.c | 163 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 151 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 99befa7..d8825c5 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -23,6 +23,8 @@
 #include <linux/module.h>
 #include <linux/amba/bus.h>
 #include <linux/mailbox_controller.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>

 #define INTR_STAT_OFS  0x0
 #define INTR_SET_OFS   0x8
@@ -33,12 +35,69 @@
 #define MHU_SEC_OFFSET 0x200
 #define TX_REG_OFFSET  0x100

+#define MHU_V2_REG_STAT_OFS    0x0
+#define MHU_V2_REG_CLR_OFS     0x8
+#define MHU_V2_REG_SET_OFS     0xC
+#define MHU_V2_REG_MSG_NO_CAP  0xF80
+#define MHU_V2_REG_ACC_REQ_OFS 0xF88
+#define MHU_V2_REG_ACC_RDY_OFS 0xF8C
+
+#define MHU_V2_LP_OFFSET  0x20
+#define MHU_V2_HP_OFFSET  0x0
+
 #define MHU_CHANS      3

+enum mhu_ver {
+       MHU_V1 = 1,
+       MHU_V2,
+       MHU_VER_END
+};
+
+enum mhu_regs {
+       MHU_REG_STAT,
+       MHU_REG_SET,
+       MHU_REG_CLR,
+       MHU_REG_END
+};
+
+enum mhu_access_regs {
+       MHU_REG_MSG_NO_CAP,
+       MHU_REG_ACC_REQ,
+       MHU_REG_ACC_RDY,
+       MHU_REG_ACC_END
+};
+
+enum mhu_channels {
+       MHU_CHAN_LOW,
+       MHU_CHAN_HIGH,
+       MHU_CHAN_SEC,
+       MHU_CHAN_END
+};
+
+/**
+ * ARM MHU Mailbox device specific data
+ *
+ * @regs: MHU version specific array of register offset for STAT,
+ *        SET & CLEAR registers.
+ * @chans: MHU version specific array of channel offset for Low
+ *         Priority, High Priority & Secure channels.
+ * @acc_regs: An array of access register offsets.
+ * @tx_reg_off: Offset for TX register.
+ * @version: Version of MHU controller available in the system.
+ */
+struct mhu_data {
+       int regs[MHU_REG_END]; /* STAT, SET, CLEAR */
+       int chans[MHU_CHAN_END]; /* LP, HP, Sec */
+       int acc_regs[MHU_REG_ACC_END];
+       long int tx_reg_off;
+       uint8_t version;
+};
+
 struct mhu_link {
        unsigned irq;
        void __iomem *tx_reg;
        void __iomem *rx_reg;
+       unsigned int pchan;
 };

 struct arm_mhu {
@@ -46,21 +105,24 @@ struct arm_mhu {
        struct mhu_link mlink[MHU_CHANS];
        struct mbox_chan chan[MHU_CHANS];
        struct mbox_controller mbox;
+       struct mhu_data *drvdata;
 };

 static irqreturn_t mhu_rx_interrupt(int irq, void *p)
 {
        struct mbox_chan *chan = p;
        struct mhu_link *mlink = chan->con_priv;
+       struct arm_mhu *mhu = container_of(chan->mbox, struct arm_mhu, mbox);
+       struct mhu_data *mdata = mhu->drvdata;
        u32 val;

-       val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
+       val = readl_relaxed(mlink->rx_reg + mdata->regs[MHU_REG_STAT]);
        if (!val)
                return IRQ_NONE;

        mbox_chan_received_data(chan, (void *)&val);

-       writel_relaxed(val, mlink->rx_reg + INTR_CLR_OFS);
+       writel_relaxed(val, mlink->rx_reg + mdata->regs[MHU_REG_CLR]);

        return IRQ_HANDLED;
 }
@@ -68,7 +130,9 @@ static irqreturn_t mhu_rx_interrupt(int irq, void *p)
 static bool mhu_last_tx_done(struct mbox_chan *chan)
 {
        struct mhu_link *mlink = chan->con_priv;
-       u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
+       struct arm_mhu *mhu = container_of(chan->mbox, struct arm_mhu, mbox);
+       struct mhu_data *mdata = mhu->drvdata;
+       u32 val = readl_relaxed(mlink->tx_reg + mdata->regs[MHU_REG_STAT]);

        return (val == 0);
 }
@@ -76,9 +140,11 @@ static bool mhu_last_tx_done(struct mbox_chan *chan)
 static int mhu_send_data(struct mbox_chan *chan, void *data)
 {
        struct mhu_link *mlink = chan->con_priv;
+       struct arm_mhu *mhu = container_of(chan->mbox, struct arm_mhu, mbox);
+       struct mhu_data *mdata = mhu->drvdata;
        u32 *arg = data;

-       writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
+       writel_relaxed(*arg, mlink->tx_reg + mdata->regs[MHU_REG_SET]);

        return 0;
 }
@@ -86,11 +152,18 @@ static int mhu_send_data(struct mbox_chan *chan, void *data)
 static int mhu_startup(struct mbox_chan *chan)
 {
        struct mhu_link *mlink = chan->con_priv;
+       struct arm_mhu *mhu = container_of(chan->mbox, struct arm_mhu, mbox);
+       struct mhu_data *mdata = mhu->drvdata;
        u32 val;
        int ret;

-       val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
-       writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
+       if (mdata->version == MHU_V2)
+               writel_relaxed(0x1, mlink->tx_reg
+                       + (mdata->acc_regs[MHU_REG_ACC_REQ]
+                       - (mdata->chans[mlink->pchan])));
+
+       val = readl_relaxed(mlink->tx_reg + mdata->regs[MHU_REG_STAT]);
+       writel_relaxed(val, mlink->tx_reg + mdata->regs[MHU_REG_CLR]);

        ret = request_irq(mlink->irq, mhu_rx_interrupt,
                          IRQF_SHARED, "mhu_link", chan);
@@ -106,6 +179,13 @@ static int mhu_startup(struct mbox_chan *chan)
 static void mhu_shutdown(struct mbox_chan *chan)
 {
        struct mhu_link *mlink = chan->con_priv;
+       struct arm_mhu *mhu = container_of(chan->mbox, struct arm_mhu, mbox);
+       struct mhu_data *mdata = mhu->drvdata;
+
+       if (mdata->version == MHU_V2)
+               writel_relaxed(0x0, mlink->tx_reg
+                       + (mdata->acc_regs[MHU_REG_ACC_REQ]
+                       - (mdata->chans[mlink->pchan])));

        free_irq(mlink->irq, chan);
 }
@@ -122,7 +202,15 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
        int i, err;
        struct arm_mhu *mhu;
        struct device *dev = &adev->dev;
-       int mhu_reg[MHU_CHANS] = {MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET};
+       void __iomem *tx_base;
+       struct device_node *np = dev->of_node;
+       struct mhu_data *mdata = id->data;
+       unsigned int pchans = MHU_CHANS;
+
+       if (!mdata) {
+               dev_err(dev, "device data not found\n");
+               return -EINVAL;
+       }

        /* Allocate memory for device */
        mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
@@ -135,20 +223,45 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
                return PTR_ERR(mhu->base);
        }

-       for (i = 0; i < MHU_CHANS; i++) {
+       if (mdata->version == MHU_V2) {
+               tx_base = of_iomap(np, 1);
+               if (!tx_base) {
+                       dev_err(dev, "failed to map tx registers\n");
+                       return -ENOMEM;
+               }
+
+               mdata->tx_reg_off = tx_base - mhu->base;
+               pchans = readl_relaxed(tx_base
+                               + mdata->acc_regs[MHU_REG_MSG_NO_CAP]);
+               if (pchans == 0 || pchans > MHU_CHANS) {
+                       dev_err(dev, "invalid number of channels\n");
+                       return -EINVAL;
+               }
+       }
+
+       for (i = 0; i < pchans; i++) {
                mhu->chan[i].con_priv = &mhu->mlink[i];
-               mhu->mlink[i].irq = adev->irq[i];
-               mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
-               mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
+               mhu->mlink[i].pchan = i;
+               int irq = mhu->mlink[i].irq = adev->irq[i];
+
+               if (irq <= 0) {
+                       dev_dbg(dev, "No IRQ found for Channel %d\n", i);
+                       continue;
+               }
+
+               mhu->mlink[i].rx_reg = mhu->base + mdata->chans[i];
+               mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg
+                       + mdata->tx_reg_off;
        }

        mhu->mbox.dev = dev;
        mhu->mbox.chans = &mhu->chan[0];
-       mhu->mbox.num_chans = MHU_CHANS;
+       mhu->mbox.num_chans = pchans;
        mhu->mbox.ops = &mhu_ops;
        mhu->mbox.txdone_irq = false;
        mhu->mbox.txdone_poll = true;
        mhu->mbox.txpoll_period = 1;
+       mhu->drvdata = mdata;

        amba_set_drvdata(adev, mhu);

@@ -171,10 +284,36 @@ static int mhu_remove(struct amba_device *adev)
        return 0;
 }

+static struct mhu_data arm_mhuv2_data = {
+       .regs = { MHU_V2_REG_STAT_OFS, MHU_V2_REG_SET_OFS, MHU_V2_REG_CLR_OFS },
+       .chans = { MHU_V2_LP_OFFSET, MHU_V2_HP_OFFSET },
+       .acc_regs = { MHU_V2_REG_MSG_NO_CAP, MHU_V2_REG_ACC_REQ_OFS,
+               MHU_V2_REG_ACC_RDY_OFS },
+       .version = MHU_V2,
+};
+
+static struct mhu_data arm_mhuv1_data = {
+       .regs = { INTR_STAT_OFS, INTR_SET_OFS, INTR_CLR_OFS },
+       .chans = { MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET },
+       .tx_reg_off = TX_REG_OFFSET,
+       .version = MHU_V1,
+};
+
 static struct amba_id mhu_ids[] = {
        {
+               .id     = 0x4b0d1,
+               .mask   = 0xfffff,
+               .data   = (void *)&arm_mhuv2_data,
+       },
+       {
+               .id     = 0xbb0d1,
+               .mask   = 0xfffff,
+               .data   = (void *)&arm_mhuv2_data,
+       },
+       {
                .id     = 0x1bb098,
                .mask   = 0xffffff,
+               .data   = (void *)&arm_mhuv1_data,
        },
        { 0, 0 },
 };
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
