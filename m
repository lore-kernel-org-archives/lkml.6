Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754424AbeDBKjb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:39:31 -0400
Received: from mail-by2nam03on0044.outbound.protection.outlook.com ([104.47.42.44]:36445
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754263AbeDBKj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:39:27 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radheys@xilinx.com>, <lars@metafoo.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 5/6] dmaengine: xilinx_dma: Program interrupt delay timeout
Date: Mon, 2 Apr 2018 16:09:05 +0530
Message-ID: <1522665546-10035-6-git-send-email-radheys@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(4326008)(42186006)(50226002)(6266002)(51416003)(106466001)(50466002)(8936002)(8676002)(5660300001)(316002)(81166006)(81156014)(76176011)(36386004)(59450400001)(26005)(47776003)(103686004)(90966002)(186003)(2616005)(486005)(336012)(106002)(476003)(2906002)(486005)(36756003)(126002)(305945005)(6666003)(446003)(426003)(52956003)(2201001)(110136005)(16586007)(48376002)(63266004)(478600001)(54906003)(11346002)(356003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2261;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT016;1:yj+zmnIDDdpUSfGRoXOTAn1cvMJn7NudyiDhuFcTg5N/Xfxhzm3q8VI2T9osIHU/s9iVVzradBmDaIutbmJqR5G96UgzaBN4QVKYByCek428ouv43lSo7O8hFZitBUQX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69153974-e8e6-4df9-33a7-08d598860097
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2261;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;3:sgYdUuc1DO+Q4cVg8ZrMWkjijX/ylYFTTOfAtY/1jxNhlI5eb/TJPDCiCgejItvvEdEuAtHG+UMRKsgmqi9oeeDHZl0cjGZYSIw212ynYn63lT/EchWjsyR03/7FyxJbItmqfs0iDVDu0FE4R5OFiYRu7HkXwfPQfZx3DzUgMJ06pGlOokOOPS0Clib+wdoQXdtEHofSFPVjNlzYrdJKoVrniuVuGn3dMXIOfBi2GQOl+ma8FBReHiHkUea4YjmcmpyPxQZ2PyIJeOeQBDxi5Wftwmhme5mKZLWl+4c+2CV/MauoHuCLcO2FpN42Hfp8rOtcRT4mnraNPygEKXB7hz0+VHxOVdlVHbfi4wka7uY=;25:TQJ4S9pI8zJQAclqvqgmm53CSq6Tuj0BcCsodR0B1/Rqd0bLB+nq8/MCJkPcbHcwkvno1+qVY5NZ6VtYT0Q/YYMmeXcEA2Kgs0YY7lvFw+gZG513pB8rlpWLrvt4JdWKN0kroDpBTScaqzNqQm7YrQ/O+7HCiwBsa62iyDEiGibkMtG8HUjNKxHGIdBS4vOpbzPmecQYcCC1yi9PFH1GAxZLrJZ48TSI7NAKEN3muZXQO7YN9DbVpFNcPCMcSm5dHV+/nSjpB2t7HqUM03PLZFiHUqSBzsFb/Pjt3b13A03Cc/e1a7TK8DS162v8xpCzYT1uXgNWmYfndRX79H4Sig==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2261:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;31:l0WFBC8pgtbn5l+jr4fPE6hM1X32J4X5bDYU3Cn1zwoCH6dRzSrPLMnaAFrFkFZOkyIETt19DWzdGIwAYc1Xna3as80ZROihenS+dVU/LvtnZpNGLg3XgXrAgqQzcl8P9s7PSTmILDqDf3/qYorPZrCtst5V7F+Z92wg6vemwyaRcbLxxrZVWqiQOzrwhA9Bka3Ts7x0s+Xuhfekt8CCZqy0OsD7lnPJP+jq/8Cy/zs=;20:Fc6ib/RZLsuu0JlpO6nDEXAecjMkZv8rdmYFrVglzo0wy/AKu9DbF97C8kD+/Z5SWZ7AqlHEuMn/nkWgUR0+nosSX3BFNJeYf/zAPfuX0VdLUMoOi62njAJ7OpFyRTyPzaDIGaoRgsLrOPEHufJTDuyD0BAhBlLU4rucKawFJbG7mZpTRl6UgMdaQxZRCRPTrIn5b+et/BoxUuUXTLOIeg8G8zE0bUEY8WTevjNUklLLJoKjYxUCymIA4bWw1+WnfkPH6IoCY5TzmbWL9BltGWPwwOLrW1LnxkzVppbi5bKAAfwvWNORQOaBP4h9G0BdlppvjhBezpAhMNIiHUoxSWVhmXrrI8pYEBiYuSUdGDAJuuq7l96WH9IRBIXAt9G5KzkpH606n5if8aBotilXAy+u8Xe2ljf64/ACTVOP/U1fs7bueLawiJrl6VWeLOXLlqqq2QpAr667jr66XaJ0gHRhk6obVv/VykkWQr10ZiewtwexNEET0kVyTJooNu6Q
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB226134FA50E7975454DEC172C7A60@CY4PR02MB2261.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR02MB2261;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2261;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;4:iekyZ76jFL3Woy+YvB/1awohtbF/UVF/K9PY1Yj29wGesqP2b24bKk5C68mr0ULMOKLGK5gibJaQuagbp7/hLQtiuyQMlXRaY6p83N2lGXsZlA5ynNhXVvfTjI8KWotCPKDPGyppQZ6VUIslGKUjf991BDBX8Gel7HTrOu54vLGrBkkzzgSmeWIektFMJCz2jh2LFYI3lelJY5KNXm2y3vO/f4Png9YIG+DXz2MxJLmdEUx+fdRaPhq/4eNKdoWX4o1OeA/bPKpYPJl/0s0+9KaW+K1DecLmMlKy+IktD9FLImnjzkxHAP7WyHmQCDuw
X-Forefront-PRVS: 0630013541
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2261;23:a33voItjh/V8jtFTFtZvxl3gmeRDQaFyZk/HFhpLF?=
 =?us-ascii?Q?PvTo8S7mU1ciWJxrE2+3IhpgpFAGWhc9Vd9RVgBPkVQW2QEp1RXvmKrxoHGN?=
 =?us-ascii?Q?L95MVxrvk4/3FYYAbzUwzytosoO0YB+kjOIIkrXkU+zIUQDUVnY+OVRwgJNc?=
 =?us-ascii?Q?zNWDe2PeE9oNaM6HVihiyZuEgkAFl369km5RspY7rRZzdVWDar5KmCSBKXNW?=
 =?us-ascii?Q?WEq3EWuV9xu2uvpVi924npFt72HYrv3uVsTgFaSKtGB6qQIXDMDFLQiZax2T?=
 =?us-ascii?Q?2R7dtSwlZ0CvtjBt+6WNzudOdwv3SZRMiDs1q+el+y+L2NPkupvx1bS8Fzr4?=
 =?us-ascii?Q?YrTfMZt3T8pETcSRLRKMLqjIvy5iyl/nDphMBbfeU64vDXbGlRNea/9cRC13?=
 =?us-ascii?Q?FDHOdmalA6iA6yIIJMmGHDe2s86IRnyz7YWvpSA28l5Y1HogBkXw6/9s+Cnx?=
 =?us-ascii?Q?t/J2oBRB/FSn09HlIXhcNSkje8aBVjm+ngx+Krqy6AEUUJfCeXxiDbfx2yT5?=
 =?us-ascii?Q?Ob/hEkh4jj+eLFQF3QeQwQQUMSi7yI6Wm1YX42T483VMbz43vG46x4r5CMWc?=
 =?us-ascii?Q?gMk5+ChIVM7pypsggygCZmv52OXA+0kwmDIsuRXdRsDHUbLFMdVQA4zTbdaN?=
 =?us-ascii?Q?pf/vcDfBelNl13mAk4n9Z60AK2aCoW2ndQQq7Lx83hMqgjXsySrRt/wwyB41?=
 =?us-ascii?Q?ehpQknvZp5F1ec5pFmzrXI2SF8utTmoZs+FlapTOnMZPY+sIjd/kym68Hr7Y?=
 =?us-ascii?Q?VnSI7EQnsy4tVELJWvWTndOlqeeeaef/HaSATYVntwk2tji95SWr/SPnZ78Z?=
 =?us-ascii?Q?hIhRkXuAeThx2zF6DdBPxpmW47FJVc9JtrCJQ0t1YtGX0/U8m0RvB2s6Il7B?=
 =?us-ascii?Q?3uwHOrl/kR6WjMvM7Ksw7uWb1WDH/9JBw9BkSsvZSnaPTjS/Vk0nLs3+jFVV?=
 =?us-ascii?Q?XK9eBdWvpc+DtMsHlIIE8fkhlQAdnyfJ4yGoiB6dEpSxaCVHH8US668BvvX2?=
 =?us-ascii?Q?GWUFjV6cyRaxfFw48rFCQeyleKMh61+ZxUQccNjLO/9p2Ngz/O+uEQGJPvuq?=
 =?us-ascii?Q?u7rSmYKjUwXZRavxsl9ve0zhTxmbv9iThyQN1S4oChdGhAjDpNb/6YEIPMn9?=
 =?us-ascii?Q?Nd9xiwY+ZxNdJpXuspHMx2wEIt+xJr/KCXYatGKtykoJ1huMZr+eLqcxt37f?=
 =?us-ascii?Q?IB7QxJ1zAbvhrm4Rh6KuWdfhGorKMH6mmye?=
X-Microsoft-Antispam-Message-Info: xMlHm7fJXx4gLlkskqiozXxjs+mx7yQv2JCLyI002EAgXoAPc+6fv3F/HtY0NPf+ctblX2K8D0rVQRV9TjUXAaVD4Tj125OWsjW1f2Q37wYoSMmfY8Aqn337xiIKK33ojYH8Z7MNXzZwRrAk+UE38thsT1KiG58upDSgU3rkvfarYtvuhfIjXURNHk1tROzW
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;6:GYOUrkEh79XahFtYB7yn3V7+gYmP38C27gDYR8LD44oixCn0kI2bdujFQ8REO3GXNgmyk5j/8ERAvt0b6jzERoyF17I4CaWUevhPbY7/DWMboLHChgZSm/3/TQnEAAk0sZLyyMmB/VwQl56lkqLQcCMguY2c1BebCyOZKpS/MOVGU3LPq35Y/ehrq9nlHkhHpl0idNQs4hkrJ/ZLlPR5U21Bp9ytv85atQLsv1Bq75VXkAbhmEw8P3Y74AK6IWroYQ4hewFmgDjkFD76M1Z68rquVB3W2Q/auLAbkKwpqBPhgLw4rk+Umfkz7QEoFFXO6CmgYtG7fP0ITzWCbZlmwp5iLO7ADR6SIfkbNI2Uo+aZlyvC6mFDbp+GGrVKdnsb93CbMPk1/kokecH/HpQki+SMRR+xXZN5gd94e5YSOiCWjaL4MgxtcuDFquBL+Xky2OTIz8xbp80WUAeZCT9vRg==;5:7jD2jfanofnfR/yMnO8IRg2dyfKBsDNY/p0Flxwxr+BeRtC4nrSFLS8SddkeZ12V8FLER2WJyHI8i+OGE3pB+DtVfbGqsTlmMfoSdnI4WhWMCtEwjt5gGgIuXs9TzVvcY2MhSk4dsd2nCP++PInLe7QiMU3l0dmloj59yZFbUyk=;24:KGq7Ds9vTrt4YTui+XiQNdXtBIQ6wGf9pPLZze2RVEBJl4tlmAeH48wVceMZgApfH42wfqyRqNMN9Np/XPE7Bmf1FwtuaTFsnPDUCrSnSJs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2261;7:b1poW54Gr+HQNuYov+0m4DJBZ4irgPXLPYS7QnH+rKf3FnbmiFsR+bDG0P9TMy87a3brHcOwCYsipTvHwRLwBtMtdffCisPztNLdbcgQK0TN700kau9haWlnYh174AA68OpW+bU2x/k7h6J414Ryj16XIIXIZoK6f9hmZh5xrZfSX2IHbQ2GKACHke9dad6fRpl2lTLHbG8xGK7efPXbccdmxnqTWLot8+O6r9uH1Q8IJR6yGlKT3zvovfNnoUIL
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:39:24.3866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69153974-e8e6-4df9-33a7-08d598860097
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2261
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Program IRQDelay for AXI DMA. The interrupt timeout mechanism causes
the DMA engine to generate an interrupt after the delay time period
has expired. It enables dmaengine to respond in real-time even though
interrupt coalescing is configured.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 518465e..ab8f1b0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -161,8 +161,12 @@
 /* AXI DMA Specific Masks/Bit fields */
 #define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
 #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
+#define XILINX_DMA_CR_DELAY_MAX		GENMASK(31, 24)
 #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
+#define XILINX_DMA_CR_DELAY_SHIFT	24
+#define XILINX_DMA_CR_WAITBOUND_DFT	254
+
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_COALESCE_MAX		255
@@ -1294,6 +1298,12 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
 		reg |= chan->desc_pendingcount <<
 				  XILINX_DMA_CR_COALESCE_SHIFT;
+
+		if (chan->xdev->has_axieth_connected) {
+			reg  &= ~XILINX_DMA_CR_DELAY_MAX;
+			reg  |= XILINX_DMA_CR_WAITBOUND_DFT <<
+					XILINX_DMA_CR_DELAY_SHIFT;
+		}
 		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 	}
 
@@ -1508,7 +1518,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		}
 	}
 
-	if (status & XILINX_DMA_DMASR_DLY_CNT_IRQ) {
+	if (!chan->xdev->has_axieth_connected && (status &
+			XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
 		/*
 		 * Device takes too long to do the transfer when user requires
 		 * responsiveness.
@@ -1516,7 +1527,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		dev_dbg(chan->dev, "Inter-packet latency too long\n");
 	}
 
-	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
+	if (status & (XILINX_DMA_DMASR_FRM_CNT_IRQ |
+		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
 		chan->idle = true;
-- 
1.7.1
