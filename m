Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeEYEmU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:42:20 -0400
Received: from mail-sn1nam02on0105.outbound.protection.outlook.com ([104.47.36.105]:26732
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750964AbeEYEmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:42:14 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, <claudiu.manoil@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 2/5] ptp_qoriq: move some definitions to header file
Date: Fri, 25 May 2018 12:40:35 +0800
Message-ID: <20180525044038.37756-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180525044038.37756-1-yangbo.lu@nxp.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(39380400002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(77096007)(39060400002)(2906002)(5660300001)(105606002)(106466001)(4326008)(6666003)(8656006)(16586007)(51416003)(59450400001)(110136005)(86362001)(316002)(53936002)(26005)(76176011)(36756003)(2201001)(50466002)(498600001)(126002)(486006)(48376002)(85426001)(44832011)(81156014)(2616005)(476003)(446003)(11346002)(50226002)(336012)(8676002)(81166006)(97736004)(8936002)(1076002)(356003)(305945005)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR03MB3108;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD013;1:z42V0/+a+MMMzsG+/s0W375ii9ZAjjfjKQHHJIpiMzWVfi41bZ4+SN215ZfhBhD0fNaPSicjqS0tB4/y5JigZEnDncqJwm0hZMFa1dKTRzH2uTzqKhjrJYBrshGPNxvv
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:BN6PR03MB3108;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3108;3:n61ig2sX2+b4YEOhRoy5pF7K8Cdf2GhgPYv4eqHNYXWNO1QOTDVsUET64CqHfvVXV42m8P2qF1Xe2SWz1DAhytUh1lN5oCCi0MjElRrNeYPspvmggg4HeoFePydUFSVR9x7HZxllI2lBmvZTo+SAPCObrxrGhPp0UdfnYpofsbpLOqKs+WbW8yYxYIOHx60IPbjPF0fv8seUvo2bdIMpOTLZYdsg+xRZNVbXb6LuKj6Z4awEhQo6HPN5Jkk/8UEgccc3/SCG2S6tGAexvwpW+AAxetABb2V9gBgMF7yIt1WamfgKGHcbkQRUJa0fXOZqVargEcLXhQXq7QN/vMKoMYC2eE1ZtLf3Nz36/h3tMCE=;25:thhgC62SWY3+oV8DC1aN0xGV/SrdneWoVwI9qL9sz29VezZAsOvnGYq2f4/AZpInEEs0jTUonbH7vEQtQbA4hJBF/zSH9HzXOrJEtpr3gaC6cIAzOjUau2MGSuKz7kAcao0VU1bNhEuPuUeZ6dvzw+P1KrIZPJDgaohWphCglldvjAWWe5vNYWDmVsDSeM7sqAy93WeZOvI3Fkv5clGj36Toft1zOD6ojPfzfSEssREmZ2BFS3HsFNvgLeFrtSIKh2wpyeBFEyh7GpQau1EcBUBGyC5syZeMGlHaWCP5J/n+wmDa90K/RMqFzPUjom4H0Ez6r0vQqIFDN2ysp8LF0w==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3108:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3108;31:66+kcGaKDEFB7lWtJl6/XVDZAtdtAmH3QT+do8328o3h9KqHJ5vvM/H4NdlaL0YHX3+y8j1GAzuWH8V1WPw0q5CtikbPZgKsNOrHc6fGIFtMswrmvtMIEFM6CkuoJ3V39ro8OKn4ATsQqH29MQwUSfVXau42BgKClE8imzcTJq5mU5DNyL4gwAIT3OQ9KY10ZU62FhuQgocgdphsOG0Ai6msdw4D/BtIxT+PPIqZEPg=;20:GAbMkPxmszgo4M7QRzcrkgKd/6hOX6lD0n4bNhyFPkJTP473V6mdF7PY9Hrgh82rk1W3/FiPjP10PKqR7ltbxqzk/wduijL2VKqghySx+qEzojrXv+mI+bwmGkdRJqA0HVP77DGkR/G2hMqH+nCgNLjZro4Wuz4RXTLhp/9grBVs5rKDt1k41pC7vSKMwhfT8UugWduGCyFrxj7nSueNVG1iWY3JK4N3dxm/hJImv4AhjNUtJRN2ZKp5nuQiHdp5q1CsXCDgLhhCpYnjysplkeuTqC7IwgVrD2iB6CA3DeHqtnPcthLEOK40U0lMX6JeE5t4nC26C8KOnuFfaqqBs1qyAHMYoVVUEVLAP5Y8iWPS/EoSbkMe8bMUSekWnxsV97T+6UGPim+F1tq8jZqw6uHuwYLcqoFvgKu42NMIBuUP+PqGpwzbAUbiTT5jXCTLGP4YR8s98QhDJdakt+al3LSH3ryOhyiZuhbg08g04YvtMTIvRhVSSM1SxZQRszW145DnLuwqsZEF5QwJSV4zJrXl7OZc3e4YRY3ipWEm1bx3kLcgfTdSvj9+udzK+TbEUOxU0wv3I85lafx5Qs7TD+RKM2SzDXL+i3qCryuZCjY=
X-Microsoft-Antispam-PRVS: <BN6PR03MB31082279B5C17A508CEA8C2AF8690@BN6PR03MB3108.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3108;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3108;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3108;4:kEInL/KMc9q4zhYir2yM73+R4UMx75FYw79kqe/1NZ/HEpIr1tCihhb4AdKatFgI3Gpvk59tl3L98ff28s1MWAY6y3cwxvwg/qsu6ruyYxhGoCO2Yf2MGbCaIglfyhGy+EYD07FlfhMbnfEosjFs7SQv13yQHYRbXXoqbTmOqs9+OBpbdy36LzskiRnfRaxeyW1kKeKPRdAoYtjB4DCNyqj1nAZRjJ7nIA1nPxi7QIWFi2bbVe+r1POxMMtlDtyng5AYu/RptDu9mz/YY2EGntzh8xjKzSI3Nbg+GQYbTqdMjg6Piqo1MK88nvCaLRte
X-Forefront-PRVS: 06833C6A67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3108;23:9SYD9NFt9Qe6q+W6MhOrF73CTXDxDNujM2SvbsjMZ?=
 =?us-ascii?Q?/bJmlTWXiV+UJEEvCCwvmaKRt6OwyIX3nlxVQLrhJLUEsCKkBv9MvUGNFLx7?=
 =?us-ascii?Q?ffRIAl8iGVwHoWKYlNn1GhUkfFRWf14ZL6Cu6kJBnVKsiYRzweOUxUABPQ1m?=
 =?us-ascii?Q?DKou7JO+XBLGBejFjcvzC4t8Aj44dauKQUhKe6SrgBlYSygk4meww2K0gmxg?=
 =?us-ascii?Q?nhsw79T8m2sKQhd9NedOXePoUZ8YNZBS6JIAyzrinU5YBk8tgCF6VkO/WqA6?=
 =?us-ascii?Q?kTDMQd9B8+QLXge3/HXr/NP1vEn6cETtnvajVLD7yVjyKyaAw3MZZauJUiFh?=
 =?us-ascii?Q?WIwGaeADdKpdu2GNLW2ffiuNV0MvlHNZRxxFtu61hlgSQLqJjc3d/rfIfby7?=
 =?us-ascii?Q?UiOl6+5tju1Zi316G73Wr/RKOI0ut/AQcXMN7wRMra2sjtwSHpw9a/I7C5r8?=
 =?us-ascii?Q?q2kja0OXzS6AtwhePPRj/l/mUSwCJTg63Bk4t8gQlGDAHlaMq01uRzOUTpTd?=
 =?us-ascii?Q?iQSD9RHTgR5dz6upiYFwYpbfTBXMi4N4EgqZGYOwA0Rz6bO0vePUc7tPQua/?=
 =?us-ascii?Q?79x3o1Jf8UMdlaO8gX//D301Cc2Wz2XmbR8IlBrMpg0nrk5AgQ0OqVxRw3h1?=
 =?us-ascii?Q?u1kD4Kh5yhvmL8UUFD4uOXOvdCCGxDWuf/vJDX8MT53lIGQBeZIJiwsFxUql?=
 =?us-ascii?Q?HzoRr8+JeDUL2NDc56akXtOmnRMCiquZMv3hKOfQPIwn+NF9M6g4wgnfJxhS?=
 =?us-ascii?Q?GlbTWJ7RBPrqJnmk+VL0WbKVtgGBNafDtxEOWivNWefyBacIbb6MT7BpdCUN?=
 =?us-ascii?Q?4jYRlmFaPFZnsr0Rer/mLOzc55PPsVYeHmELrMpO9+MTl0lXSLFcSwsQivjh?=
 =?us-ascii?Q?rjddagref66+yRASUdNdZDLNZ5fxZvr1f7PQDwOsXOK+j9u10fuQqAGyMJzJ?=
 =?us-ascii?Q?xNXD9o3zfCdD9mUVKhOL1aH8LNUdPldWkPvEQgh4EFy5VzUaf7LNDbR1yNEG?=
 =?us-ascii?Q?fXdSevqIwOOiM7QE6sd1uPu/ioYgoAzQdzH/MMRojN++t9SePVrNdCV/QXX2?=
 =?us-ascii?Q?Sotm7Dv4OJ9zwVDXEbWNhbFJkVKJlPFl3asIsa7uVj3CD2BD65Ed0e8wKaoG?=
 =?us-ascii?Q?A65dCn7zmBXDpO3DdU8jjQal9jYnJbVFTj7/ujzliccU6DMeQo+YjtcU8YGV?=
 =?us-ascii?Q?/YwwozEv9SpEy4QGy1LTc6dxIlw45pLbz+g?=
X-Microsoft-Antispam-Message-Info: FqShDfakQrxoWAt7uwzlHT98icI4Bi7KbiNKFvCM/D/8TivAbaMdBLcB8y1XoT0gCCSgg/njWnMMKemcM5DcXYJeBAKYFqIi7pF3AN6vVNDP40jNEUDBAwN3C4mdku3ZMacY4HKmH8pqL3Lauu79ejAAEzPWCbCqpkX9bvKOOTxeHxCNUzJ38CT1RKySa737
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3108;6:21dfIudRKhhWQh/o/gMqYB4mVmjgsimmVhiiPtFsbXO+OV8DcOQi5X6SGru7h01Z3tqO7ZJN3JLvs8rDhXlQMf71wQCf9etu1XciLGtol9INz1bqnxs5oHQDVXsz1lcgdCKZWd6NerfHkl7pGB5OYtD8z7mNeSYR5XOPOG9VK3zOEhL4W+J0i2y19rBITxZVn6P9UGEjmma0brCX15M/HcE9vWTycRcNSqF6VH9ek8GlULyfDeXaftIK0Z7KwLymh/u//aiMWpZ3npOeowIU5Kr2tAitSkOBDfThdM8SLKwlRgzYMYHxyyVutOS5d70D7ZkhE3ke2k81zJcVYM04kTn/uPiMWngms2oBKGy7A6TGbmQfwK5u3Y0mSDWLPBKW5EndZMUeC0/p0liQ7o4NFS7JaktJqgpZI8v88hs9KODLDBpDhVHuZCn1qFgGtUCPtATZAetUE29C6NGPCzi+8g==;5:3J67YKe9eBeT4CjcVmVBlrHB5rWJUqzSsCkLba0jlRB/f4gdMp2HpVxhlEhJI73l0bOkBBSC1m98NhHv+nfQU8Q6zHrAQGAx4l6plpPUQq1AGQDTwmx8gbVIiKHUV9Qm1SMhTWPK75h38k65Eh0TEVleWW0Mfh1j0Q+q6Ih8/G8=;24:wjv4E/FOHe+icVWCxz4HU3/JbftcFyjCzkN6JQfgDgUWYMis2k0qlzVVcElRRJh30tb5UuSy70ILSAo7OALwAitg/ZnGyhwq6Do5jpPHrNM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3108;7:niP4tOX/rFNMo+ewER/WIUvsNuis0r8LpSdyDBE7lQzN2tNmnFbqSS3wErlpV4IniRglg+3CE++Mr7f1lmqq5cyBPQivIryWLQ5Jj0K9NM0cP9JN1PCYPRP0HTW6EONXe/L7CM+/ZOOaNYaqXIQD9NsPqZIBc97w8Xaf1rLr5irQqn/CwzjHiZH/c2BiOLrXggb5UYeDV0RcRzrnIA3tZUZOI0pfVKkqnvAlq4VZ1fHdczq/WP0X6EAhz1q/s25Q
X-MS-Office365-Filtering-Correlation-Id: 9eec331b-dfbe-4f36-2ff7-08d5c1f9e02a
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 04:42:09.2955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eec331b-dfbe-4f36-2ff7-08d5c1f9e02a
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to move some definitions in ptp_qoriq.c
to the header file.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/ptp/ptp_qoriq.c       |  132 +--------------------------------------
 include/linux/fsl/ptp_qoriq.h |  141 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 131 deletions(-)
 create mode 100644 include/linux/fsl/ptp_qoriq.h

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 5110cce..1468a16 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -28,139 +28,9 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/timex.h>
-#include <linux/io.h>
 #include <linux/slab.h>
 
-#include <linux/ptp_clock_kernel.h>
-
-/*
- * qoriq ptp registers
- * Generated by regen.tcl on Thu May 13 01:38:57 PM CEST 2010
- */
-struct qoriq_ptp_registers {
-	u32 tmr_ctrl;     /* Timer control register */
-	u32 tmr_tevent;   /* Timestamp event register */
-	u32 tmr_temask;   /* Timer event mask register */
-	u32 tmr_pevent;   /* Timestamp event register */
-	u32 tmr_pemask;   /* Timer event mask register */
-	u32 tmr_stat;     /* Timestamp status register */
-	u32 tmr_cnt_h;    /* Timer counter high register */
-	u32 tmr_cnt_l;    /* Timer counter low register */
-	u32 tmr_add;      /* Timer drift compensation addend register */
-	u32 tmr_acc;      /* Timer accumulator register */
-	u32 tmr_prsc;     /* Timer prescale */
-	u8  res1[4];
-	u32 tmroff_h;     /* Timer offset high */
-	u32 tmroff_l;     /* Timer offset low */
-	u8  res2[8];
-	u32 tmr_alarm1_h; /* Timer alarm 1 high register */
-	u32 tmr_alarm1_l; /* Timer alarm 1 high register */
-	u32 tmr_alarm2_h; /* Timer alarm 2 high register */
-	u32 tmr_alarm2_l; /* Timer alarm 2 high register */
-	u8  res3[48];
-	u32 tmr_fiper1;   /* Timer fixed period interval */
-	u32 tmr_fiper2;   /* Timer fixed period interval */
-	u32 tmr_fiper3;   /* Timer fixed period interval */
-	u8  res4[20];
-	u32 tmr_etts1_h;  /* Timestamp of general purpose external trigger */
-	u32 tmr_etts1_l;  /* Timestamp of general purpose external trigger */
-	u32 tmr_etts2_h;  /* Timestamp of general purpose external trigger */
-	u32 tmr_etts2_l;  /* Timestamp of general purpose external trigger */
-};
-
-/* Bit definitions for the TMR_CTRL register */
-#define ALM1P                 (1<<31) /* Alarm1 output polarity */
-#define ALM2P                 (1<<30) /* Alarm2 output polarity */
-#define FIPERST               (1<<28) /* FIPER start indication */
-#define PP1L                  (1<<27) /* Fiper1 pulse loopback mode enabled. */
-#define PP2L                  (1<<26) /* Fiper2 pulse loopback mode enabled. */
-#define TCLK_PERIOD_SHIFT     (16) /* 1588 timer reference clock period. */
-#define TCLK_PERIOD_MASK      (0x3ff)
-#define RTPE                  (1<<15) /* Record Tx Timestamp to PAL Enable. */
-#define FRD                   (1<<14) /* FIPER Realignment Disable */
-#define ESFDP                 (1<<11) /* External Tx/Rx SFD Polarity. */
-#define ESFDE                 (1<<10) /* External Tx/Rx SFD Enable. */
-#define ETEP2                 (1<<9) /* External trigger 2 edge polarity */
-#define ETEP1                 (1<<8) /* External trigger 1 edge polarity */
-#define COPH                  (1<<7) /* Generated clock output phase. */
-#define CIPH                  (1<<6) /* External oscillator input clock phase */
-#define TMSR                  (1<<5) /* Timer soft reset. */
-#define BYP                   (1<<3) /* Bypass drift compensated clock */
-#define TE                    (1<<2) /* 1588 timer enable. */
-#define CKSEL_SHIFT           (0)    /* 1588 Timer reference clock source */
-#define CKSEL_MASK            (0x3)
-
-/* Bit definitions for the TMR_TEVENT register */
-#define ETS2                  (1<<25) /* External trigger 2 timestamp sampled */
-#define ETS1                  (1<<24) /* External trigger 1 timestamp sampled */
-#define ALM2                  (1<<17) /* Current time = alarm time register 2 */
-#define ALM1                  (1<<16) /* Current time = alarm time register 1 */
-#define PP1                   (1<<7)  /* periodic pulse generated on FIPER1 */
-#define PP2                   (1<<6)  /* periodic pulse generated on FIPER2 */
-#define PP3                   (1<<5)  /* periodic pulse generated on FIPER3 */
-
-/* Bit definitions for the TMR_TEMASK register */
-#define ETS2EN                (1<<25) /* External trigger 2 timestamp enable */
-#define ETS1EN                (1<<24) /* External trigger 1 timestamp enable */
-#define ALM2EN                (1<<17) /* Timer ALM2 event enable */
-#define ALM1EN                (1<<16) /* Timer ALM1 event enable */
-#define PP1EN                 (1<<7) /* Periodic pulse event 1 enable */
-#define PP2EN                 (1<<6) /* Periodic pulse event 2 enable */
-
-/* Bit definitions for the TMR_PEVENT register */
-#define TXP2                  (1<<9) /* PTP transmitted timestamp im TXTS2 */
-#define TXP1                  (1<<8) /* PTP transmitted timestamp in TXTS1 */
-#define RXP                   (1<<0) /* PTP frame has been received */
-
-/* Bit definitions for the TMR_PEMASK register */
-#define TXP2EN                (1<<9) /* Transmit PTP packet event 2 enable */
-#define TXP1EN                (1<<8) /* Transmit PTP packet event 1 enable */
-#define RXPEN                 (1<<0) /* Receive PTP packet event enable */
-
-/* Bit definitions for the TMR_STAT register */
-#define STAT_VEC_SHIFT        (0) /* Timer general purpose status vector */
-#define STAT_VEC_MASK         (0x3f)
-
-/* Bit definitions for the TMR_PRSC register */
-#define PRSC_OCK_SHIFT        (0) /* Output clock division/prescale factor. */
-#define PRSC_OCK_MASK         (0xffff)
-
-
-#define DRIVER		"ptp_qoriq"
-#define DEFAULT_CKSEL	1
-#define N_EXT_TS	2
-#define REG_SIZE	sizeof(struct qoriq_ptp_registers)
-
-struct qoriq_ptp {
-	struct qoriq_ptp_registers __iomem *regs;
-	spinlock_t lock; /* protects regs */
-	struct ptp_clock *clock;
-	struct ptp_clock_info caps;
-	struct resource *rsrc;
-	int irq;
-	int phc_index;
-	u64 alarm_interval; /* for periodic alarm */
-	u64 alarm_value;
-	u32 tclk_period;  /* nanoseconds */
-	u32 tmr_prsc;
-	u32 tmr_add;
-	u32 cksel;
-	u32 tmr_fiper1;
-	u32 tmr_fiper2;
-};
-
-static inline u32 qoriq_read(unsigned __iomem *addr)
-{
-	u32 val;
-
-	val = ioread32be(addr);
-	return val;
-}
-
-static inline void qoriq_write(unsigned __iomem *addr, u32 val)
-{
-	iowrite32be(val, addr);
-}
+#include <linux/fsl/ptp_qoriq.h>
 
 /*
  * Register access functions
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
new file mode 100644
index 0000000..b462d9e
--- /dev/null
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 OMICRON electronics GmbH
+ * Copyright 2018 NXP
+ */
+#ifndef __PTP_QORIQ_H__
+#define __PTP_QORIQ_H__
+
+#include <linux/io.h>
+#include <linux/ptp_clock_kernel.h>
+
+/*
+ * qoriq ptp registers
+ * Generated by regen.tcl on Thu May 13 01:38:57 PM CEST 2010
+ */
+struct qoriq_ptp_registers {
+	u32 tmr_ctrl;     /* Timer control register */
+	u32 tmr_tevent;   /* Timestamp event register */
+	u32 tmr_temask;   /* Timer event mask register */
+	u32 tmr_pevent;   /* Timestamp event register */
+	u32 tmr_pemask;   /* Timer event mask register */
+	u32 tmr_stat;     /* Timestamp status register */
+	u32 tmr_cnt_h;    /* Timer counter high register */
+	u32 tmr_cnt_l;    /* Timer counter low register */
+	u32 tmr_add;      /* Timer drift compensation addend register */
+	u32 tmr_acc;      /* Timer accumulator register */
+	u32 tmr_prsc;     /* Timer prescale */
+	u8  res1[4];
+	u32 tmroff_h;     /* Timer offset high */
+	u32 tmroff_l;     /* Timer offset low */
+	u8  res2[8];
+	u32 tmr_alarm1_h; /* Timer alarm 1 high register */
+	u32 tmr_alarm1_l; /* Timer alarm 1 high register */
+	u32 tmr_alarm2_h; /* Timer alarm 2 high register */
+	u32 tmr_alarm2_l; /* Timer alarm 2 high register */
+	u8  res3[48];
+	u32 tmr_fiper1;   /* Timer fixed period interval */
+	u32 tmr_fiper2;   /* Timer fixed period interval */
+	u32 tmr_fiper3;   /* Timer fixed period interval */
+	u8  res4[20];
+	u32 tmr_etts1_h;  /* Timestamp of general purpose external trigger */
+	u32 tmr_etts1_l;  /* Timestamp of general purpose external trigger */
+	u32 tmr_etts2_h;  /* Timestamp of general purpose external trigger */
+	u32 tmr_etts2_l;  /* Timestamp of general purpose external trigger */
+};
+
+/* Bit definitions for the TMR_CTRL register */
+#define ALM1P                 (1<<31) /* Alarm1 output polarity */
+#define ALM2P                 (1<<30) /* Alarm2 output polarity */
+#define FIPERST               (1<<28) /* FIPER start indication */
+#define PP1L                  (1<<27) /* Fiper1 pulse loopback mode enabled. */
+#define PP2L                  (1<<26) /* Fiper2 pulse loopback mode enabled. */
+#define TCLK_PERIOD_SHIFT     (16) /* 1588 timer reference clock period. */
+#define TCLK_PERIOD_MASK      (0x3ff)
+#define RTPE                  (1<<15) /* Record Tx Timestamp to PAL Enable. */
+#define FRD                   (1<<14) /* FIPER Realignment Disable */
+#define ESFDP                 (1<<11) /* External Tx/Rx SFD Polarity. */
+#define ESFDE                 (1<<10) /* External Tx/Rx SFD Enable. */
+#define ETEP2                 (1<<9) /* External trigger 2 edge polarity */
+#define ETEP1                 (1<<8) /* External trigger 1 edge polarity */
+#define COPH                  (1<<7) /* Generated clock output phase. */
+#define CIPH                  (1<<6) /* External oscillator input clock phase */
+#define TMSR                  (1<<5) /* Timer soft reset. */
+#define BYP                   (1<<3) /* Bypass drift compensated clock */
+#define TE                    (1<<2) /* 1588 timer enable. */
+#define CKSEL_SHIFT           (0)    /* 1588 Timer reference clock source */
+#define CKSEL_MASK            (0x3)
+
+/* Bit definitions for the TMR_TEVENT register */
+#define ETS2                  (1<<25) /* External trigger 2 timestamp sampled */
+#define ETS1                  (1<<24) /* External trigger 1 timestamp sampled */
+#define ALM2                  (1<<17) /* Current time = alarm time register 2 */
+#define ALM1                  (1<<16) /* Current time = alarm time register 1 */
+#define PP1                   (1<<7)  /* periodic pulse generated on FIPER1 */
+#define PP2                   (1<<6)  /* periodic pulse generated on FIPER2 */
+#define PP3                   (1<<5)  /* periodic pulse generated on FIPER3 */
+
+/* Bit definitions for the TMR_TEMASK register */
+#define ETS2EN                (1<<25) /* External trigger 2 timestamp enable */
+#define ETS1EN                (1<<24) /* External trigger 1 timestamp enable */
+#define ALM2EN                (1<<17) /* Timer ALM2 event enable */
+#define ALM1EN                (1<<16) /* Timer ALM1 event enable */
+#define PP1EN                 (1<<7) /* Periodic pulse event 1 enable */
+#define PP2EN                 (1<<6) /* Periodic pulse event 2 enable */
+
+/* Bit definitions for the TMR_PEVENT register */
+#define TXP2                  (1<<9) /* PTP transmitted timestamp im TXTS2 */
+#define TXP1                  (1<<8) /* PTP transmitted timestamp in TXTS1 */
+#define RXP                   (1<<0) /* PTP frame has been received */
+
+/* Bit definitions for the TMR_PEMASK register */
+#define TXP2EN                (1<<9) /* Transmit PTP packet event 2 enable */
+#define TXP1EN                (1<<8) /* Transmit PTP packet event 1 enable */
+#define RXPEN                 (1<<0) /* Receive PTP packet event enable */
+
+/* Bit definitions for the TMR_STAT register */
+#define STAT_VEC_SHIFT        (0) /* Timer general purpose status vector */
+#define STAT_VEC_MASK         (0x3f)
+
+/* Bit definitions for the TMR_PRSC register */
+#define PRSC_OCK_SHIFT        (0) /* Output clock division/prescale factor. */
+#define PRSC_OCK_MASK         (0xffff)
+
+
+#define DRIVER		"ptp_qoriq"
+#define DEFAULT_CKSEL	1
+#define N_EXT_TS	2
+#define REG_SIZE	sizeof(struct qoriq_ptp_registers)
+
+struct qoriq_ptp {
+	struct qoriq_ptp_registers __iomem *regs;
+	spinlock_t lock; /* protects regs */
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	struct resource *rsrc;
+	int irq;
+	int phc_index;
+	u64 alarm_interval; /* for periodic alarm */
+	u64 alarm_value;
+	u32 tclk_period;  /* nanoseconds */
+	u32 tmr_prsc;
+	u32 tmr_add;
+	u32 cksel;
+	u32 tmr_fiper1;
+	u32 tmr_fiper2;
+};
+
+static inline u32 qoriq_read(unsigned __iomem *addr)
+{
+	u32 val;
+
+	val = ioread32be(addr);
+	return val;
+}
+
+static inline void qoriq_write(unsigned __iomem *addr, u32 val)
+{
+	iowrite32be(val, addr);
+}
+
+#endif
-- 
1.7.1
