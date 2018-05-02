Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEBHPW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:15:22 -0400
Received: from mail-ve1eur01on0076.outbound.protection.outlook.com ([104.47.1.76]:34256
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbeEBHPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:15:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Samarth.Parikh@arm.com;
From: Samarth Parikh <samarth.parikh@arm.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, Sudipto.Paul@arm.com,
        Arvind.Chauhan@arm.com, samarthp@ymail.com, Deepak.Pandey@arm.com,
        Sudeep.Holla@arm.com, Samarth Parikh <samarth.parikh@arm.com>
Subject: [PATCH] mailbox: arm_mhu: add support for mhuv2
Date: Wed,  2 May 2018 12:44:04 +0530
Message-Id: <1525245244-15336-1-git-send-email-samarth.parikh@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.105.40]
X-ClientProxiedBy: BM1PR01CA0110.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::26)
 To DB4PR08MB0079.eurprd08.prod.outlook.com (2a01:111:e400:985d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB4PR08MB0079;
X-Microsoft-Exchange-Diagnostics: 1;DB4PR08MB0079;3:Qwh2MLFkgp9otp5VoL4pBQra2hKQihnnCkaOjzacOBZ2khBAQt6RFihD/grG0tBX+nDGjPqFXwL5v/8MKT3Yh1BG9uQvSvTo+grp0udEfXFmSC+hw1MR6YjoOdPwGy6L20RMVeIJu3hVpvYjrc7FiD6X9XbHGFtU0IxPAHoJZNa9tx7Ci+llWfZWujwJb0JqnD67gza0u+pzcZ9zCkNhEZBKk+Y4e9cH6OhDQ3X+Oh9tlqe36Hcvw9LzITYD3gif;25:1hY2cnxzYcUsx6+AtAjOFc872QzWzln9RoZSjxyoBU0bAqx7dfu+sDmnylublRF6E3SqGpL3w/6xmQkfSggGvMZLMUw1s2I/hGHQiVnzzx2NncBro9mrB0WZ0a088DUplRZqQYb7SD2Jbrl6RA70oOluKCH19chfa4ZZYFE0UIeqVF+ZSbJfBrUEtxx1S/ol5HeUG0E6QGlHzxuoQRKXKC3YpIGVm0A2mYdIc4I9I6OGZHkdww1J1jIhZyKlqDKakYSoV+KC8W9rZ0raJjlHtJFPkrqoUzSvn/ExwR1s6QwGE3epkMk+fS+NlPJtmimAuzdz2hgT+fcRAs5xz+ZOGA==;31:o9uiuE0UkTO8ns3zqcuGFVxbgHuBVrNccNow8tnMjNZfb8KM5EVi36uIr0aSX3O/XzD/o1XomsEUZDZKGlSbtOdXASTnEnRas3EZZeZryk3UlqMdvdyMn8SyPwzLYEEhqPJWnSkTxRxrMhBpYNEvo+QB27v3sL3wHIJCSrDmE50DPo44qUAFH4PHXi9Hb6kAEBFwDsIye00s0aMIf6GkK/QCrmZfpcr9sno3CXb+zcA=
X-MS-TrafficTypeDiagnostic: DB4PR08MB0079:
X-Microsoft-Exchange-Diagnostics: 1;DB4PR08MB0079;20:yOlMa5x9pO5bJwrrwEGDIfj72dJa11JJn7NcuYNY6YpC9xhUo0r/PaedRl7Vi0eQePISE5CwZT3GyFkgcw3PgMllLSRf2ZSQG49Xhzx3hU1z31k3Ik3y8aCb+oElJrlubZRBITR9HPPlxWgpi+rZQ5RgUrWtYaHbKDpB28KNgF3qcmp5ox0rpQh7Nt8HDLe6QN4gl5YQcQX/Gsq3Q1vawraZAG8iL1eb425PTXyjSJPXJT8tsMfUGukOSwg0QXTbafjAKFW7Icl5enjkZJohTGtxnYkxxA9VAxa6eZUIRO10Hd7jXgzT4ubx0PSy5WkoNhZeJqoY63X/hWlfK8bDqQJvxN03ug1eULlATPjOvEoh14uepBtYxQX0/UXogtqiqG09oTCQguYDqRJpyQnPepgTwwIBH5B5/X2MmZWlh+TqIEYwNcCXMy0l/yxSS3g2Bh60eIx5e3tnxVJPoYHhKne9OcoqE0mRdnuJKHIQ0NALeAXZLTsEVBMcTc8fHRGM;4:Y1QLXfdrNnuNdVUSXSe/BvSf/n/OaT4YbRNTP6FJYNsFBK6QHi51vG6errEK5/zjruNmQQWkqUabLHDKTyJz9z9hQv4lwzjLauz7KwBC3c+r2+SkNQl+cv31L0Z+xQm/Elb0xSSMovt9DG6ol3pcQK3f7Lk2tIZSNAXfVUiebGe7Ie4qfE67tWyURaKbn0AyFFUZT7mHN2jo3CFYXT11yj1IQ63/+/mMdGLnbZyW/mXUa+a7jp6Pb7w0DChsNBkEwt0TopHFFA2rQvqGdpHWQwJoeyz0u9l3T1/pADe2Xx4LXp3UaNUUJ+diq6HxRYZ3
X-Microsoft-Antispam-PRVS: <DB4PR08MB00794F3F8D39B0FB6495380D9C800@DB4PR08MB0079.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DB4PR08MB0079;BCL:0;PCL:0;RULEID:;SRVR:DB4PR08MB0079;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39380400002)(396003)(39860400002)(40434004)(189003)(199004)(6486002)(106356001)(956004)(25786009)(50226002)(105586002)(8746002)(476003)(6116002)(97736004)(486006)(478600001)(47776003)(7696005)(66066001)(81166006)(48376002)(51416003)(50466002)(8936002)(44832011)(2616005)(5660300001)(72206003)(3846002)(386003)(81156014)(68736007)(59450400001)(15650500001)(39060400002)(16526019)(7736002)(2351001)(2361001)(52116002)(53936002)(8676002)(316002)(1857600001)(305945005)(2906002)(6666003)(4326008)(26005)(86362001)(36756003)(6916009)(186003)(5890100001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR08MB0079;H:a74742-lin.blr.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB4PR08MB0079;23:3D1tmM59it2ZGKtXp5ZzvTE8f3ZpYIajzxt7QwQn8?=
 =?us-ascii?Q?O7LcZIW8HtpqUmgECRg0ULx/gHJAAKQcbRQSOU+Zpe7Qh7dKP25Wceo1hrYX?=
 =?us-ascii?Q?kCBYVHILB/UW7kH4wpAJJA9oFKgMxV1jLf0uqwayLNTRtlnN89vgBkalzidY?=
 =?us-ascii?Q?cYU/jY1PR5hLeaz3lVFtu4uCZ0MiDHpYaL7WxZpgL7U/KfzwJIy4k2BIj1Hz?=
 =?us-ascii?Q?8e4bqn47eJ4j6v4MFfhPdrt14qXdybED2c8DFdPSDV0rtq09Gw9w4BO4g8EY?=
 =?us-ascii?Q?N0Aay+iOZ6SN4IQckXa2ZL0LNwK46nOuT6IPKHgSA0C72+ozJ3ql4kMjIKxu?=
 =?us-ascii?Q?FCzuQpHu8E/BUHMQP92IPJYVxfDR0jv7mdVjPxi6R5stZTHSdX9RBKOFTN1z?=
 =?us-ascii?Q?FePdskV3e3V1AiV/E73Ft8xAKN1Cj4z193UjiPrhQacjqPQetbtk3YqHe0hr?=
 =?us-ascii?Q?lCRmPakadGs1vcvqzfSZZw4wgEdhmT1yx8k/R4/S8NLK4FY2c659lhqwpZgj?=
 =?us-ascii?Q?9W0kWnZBSb25FslfPASVSOuLvQMmWMCrOm2MB4RcsFgnC4TiXSQMGGp5I/Mh?=
 =?us-ascii?Q?e1LdUNqMN0l5ASDJBtzFbfp14sdXJS9uPSXfkPa/ZbZdv82WN8h0DwMLfW8h?=
 =?us-ascii?Q?OWSwEZ99QHKNV3/DQQoFlOmvx6YZqdZjLUMY6Fr2bvznaRRFY0cYhEbKYpY4?=
 =?us-ascii?Q?ey7k6GtpyPzh7S7KCYui6RuChQFgKjUGdwkwb9CHMMtDkPEKIbtWJNrVl+Ae?=
 =?us-ascii?Q?9jmeQaskRqurf/R1y0Ucer7JtmtZn82MofA/UHeEs8wmJdULUMUFXuirOOaz?=
 =?us-ascii?Q?lx/5FiXTxc5ynq20MdJXk4yFmhJj17DLOcoBsYjM75Sl456jJ5aUtFZbqLYT?=
 =?us-ascii?Q?WOETb+PSeuPXSm5xMuJe9wqUAybtErtW6kevBxlL++zNlEoKhu15GZRa1IAx?=
 =?us-ascii?Q?CHjkTalkQtm1Zb4iqeKUOOKHcIA02tHINdJ0rWwdQcAucYLQifcZMDHajxcK?=
 =?us-ascii?Q?VVZTvFLTWATDDaY3NVHTi0gf8teccmZRndZ5aF+zZ4YgoxGARj5T51/pyxT/?=
 =?us-ascii?Q?8xuiCzRLs/9VnKxY6VaAw5awOMB+M0ai/ARbIxO/2YblQ7wlUMdZML9EkCBy?=
 =?us-ascii?Q?yJ2xx+Q+VPVTjbFT3+rGxuWYiRsW7wIZy7TZKYxaaJxdsDoFjrZq4iEpS9lG?=
 =?us-ascii?Q?YOCCGnaWeZs6mBJiHT31QkKN+qx/3F7zRxACKP8ml1qze0Q2AjcdYR+vhY9l?=
 =?us-ascii?Q?PH0+GAF+3ZYIbtlhmBJFDWf6ftfapvikcaAtCMQj4hhGOF8t6nvkCAiIZ26Z?=
 =?us-ascii?Q?uG3egrMNu9nT2qw1DHlJ6z6WNx+jcgHzZmPQuU/ja9l6IX1B+de4D+7WXs7Y?=
 =?us-ascii?Q?FsNRw=3D=3D?=
X-Microsoft-Antispam-Message-Info: I51I+hP7dQPfCxqQZhA9x9NBvOx2/rONo5s2hefjuwux7WgNjQohrm+AHsduV+IDo+w2ruwTm1iZNKlfH4Rr0HTTt28ipn6X90HgJq39HYUBkiLrdfHcyDSHXZ8Z5guW/NUe78MWTja6Upha/JGKzctfFKV22fmB9BLBq80MVXod1VJveS2WmfCFi46LGeZj
X-Microsoft-Exchange-Diagnostics: 1;DB4PR08MB0079;6:cLBP8DP+fsr0lAPFC/BS6CgOFJvZPP9CNaLo7cGXY0/3qb6qMYoD27e24nLdW4mkMt4F0wI+a7CL3RESP9aKuoCNpiO/K4qfiycszkB/ydz26919KNMw5/D5bZPXXvrc1CkKfJVocun5Ov8N92o1LMFtkKr/m/khQXFPZpiBDdk16T8P7LZRrbwo1LKGgBOvYIHKI0Hkz7sy/NSdH0P4XETE/y7SXU0oGL9PNhS3gtt/j501nDc9HDpaOMILNForttW7Vr6hjBrSAXxUOqnKpsSHaMHvwPBib+DKSwu0ac7Wvb/MvztUr17+BLx6Jli4A6Ky5TYFgIHDZDUlZcFL7RMB7TnrNvIrr0N1E8NRWR0ddrJoTGkBVRyn+/+f6NOTH4gjHuojsGAcUZU3FYoQnRrcbUrKsVUf1IwTtRfI9dXgslzE3zIpEifeRYyzsd7+Mwm/ojLAgb5vIAsTSxQ7+A==;5:JA8fIDbfDzsvFOO4/iQrXIg3RirkzhUCxDy0bSFhJDRzGMsBKdJOeHsbJPnS7EoF+T0Kj5aYKHciXs5DekMGG9CaqhuYHkFdPpCinQ9zcdYC+FmwqQYTp7KtApDIGrZHxoAu0Ai2eroTcYg4gCop5vt7SgzzKbJVs24MeBFOwIM=;24:has8AIaU7nHuhqiUpXcatCbsdZApwOs3Llhizh9+I8eLujRh4eqFstuV1JTopT3y47E0vByjiNUFE3Z2M2WgUbiiLAWXVE4EU5JlOn6Njo4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB4PR08MB0079;7:S1YVDIvZt3Qf49UrFEOuqSMuGRd+a/PDcxhx7jdzMCLQytMW4hvi80+6kwJx6ycVAkudQSlTKYdQIHpkU7YWcteqFRTH7fRlNZkKXgMQsFubutkq+tkr+uvjudd37zSmAdVGGGxgBhZwdcH4XJT/jVzgCTgdlyACcTEjDi9sYDwsLMSVd2ivXyrTWJTYt6S7OGJDLclEDhb68FpE37pZqnICOwsBIuKBAE5MGnwNDEVYGyEN+ve7nQnMSQGayan9
X-MS-Office365-Filtering-Correlation-Id: 312377bd-e09f-4f7a-fc72-08d5affc70fd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 07:15:08.9636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312377bd-e09f-4f7a-fc72-08d5affc70fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB0079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w427FQv7023995

Hi Jassi,

I am resending the patch for review, in case you have missed my previous
patch. Can you please go through it and let me know your thoughts on
the same?

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
