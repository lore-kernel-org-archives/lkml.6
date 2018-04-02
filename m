Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeDBKje (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:39:34 -0400
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:55461
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754256AbeDBKj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit
Date: Mon, 2 Apr 2018 16:09:04 +0530
Message-ID: <1522665546-10035-5-git-send-email-radheys@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(39380400002)(396003)(2980300002)(438002)(189003)(199004)(63266004)(47776003)(126002)(90966002)(2906002)(446003)(106002)(486005)(54906003)(16586007)(52956003)(2201001)(59450400001)(11346002)(36756003)(51416003)(110136005)(316002)(476003)(42186006)(2616005)(76176011)(486005)(26005)(186003)(426003)(103686004)(50466002)(81156014)(478600001)(4326008)(48376002)(8676002)(81166006)(36386004)(6266002)(5660300001)(8936002)(305945005)(6666003)(50226002)(356003)(106466001)(336012)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2263;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT033;1:DQOu0VICGaMMiBRr+ff7NDOAHU335xr/HeOmyOxXCCdqJ5R3S8vfmCAQ6rcc5L1asNUodk9K4QWZyoGr1baRl5lV4pkXmNXU4Um9dzejo+laZ5fL+U75MZcgpW/ZJdhe
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16291310-d8c3-469b-b18e-08d59886009d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2263;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2263;3:3D3P7gCwIS8uZmbcqQqMEin/qEei+hOZLfEnwCYbLiECSx+m12a+Hv1Xn4yOtCGPYZgkS9QoyGf6zBfsZRDcVDmdelqR7K4Q1KVqaGTUrBhFJIRC/tIINfp9QNwbet3plepGr6x61gQM08vAah/iwYiVXziQHaqz5Nmd3RKHTJoZP6ekyjJ0wjYENTf78MYnZYklezqR5LiD/1LzO/kljpFQXRgu2Hp2NkZihWaiLqol7nvHPGJysy55BRVNmyqwtHdIg5vPXrp4vmpSS4FGPxshRp8hrBtf6/NWwVImCdA3qveNIdsX3djhGYoEVoUPrftuUBKQON/7C1EXT1PuvbCrGuvISOVKYX8GYVlhkPc=;25:/ewTYLgF86oB/AgNkX+KTcTLj+kO0uu42lTH8JXUsUWAUdISbUu3yIy06jqXt+w3lI3A9LsIqJIf957dD/Zb3SkUHnCD6XjzJ/DbFqMg8M79k+IXitlxczkZdrVg+zuV/+tqPTc9RluQdulBFjk6tKUuR6D6/9eFP56DoJO5BhhWbb+sQxEK15KWvQ3CBK5ShoNlcvv5Z5WWeNlmxgXMwsD+nnKsR1Fw47KnVDE2QXd4A8ExQWrV3uWvaAuv2H9gJ2OM5AxSNOf3RXR+GxXNw2xJWtLsJ7gAISBPP9NyrKm44CAfCBoCaj5c95z3VMKXWC1mfLtkD16QMbKW2mys0g==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2263:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2263;31:FwlEDZ5RmypuLdDRDSi89o+3WkHmSOcOs9s1+V1yzHG6ZWWFp7lbMp+juB5yTIaKUcxL4bFBzGuOT77Mo1zkoPsS5M1kJhcggplkjlOcaDEvhFFarGljT4o7ZRjkLloU/GtLn+rsA4yQxUkcBpdsNDlm5ArjGTZwmb3S6EvuCHUYyolxa6v+k0Jtrlg1ZatRgfaBy2ccbaM076BEnyJ/e60AFF/euiBWVfNRJ7/La7A=;20:pKeAqx5bRXJZieDxz2mA/5v0VPiCSloAh18RegtUHOrlcgwrKuow8xGt1QCf66MpbX46NZwhlAfOt0UG3U66hswzTp3UrGKQ7134Gorgc+2o2NB50/pTVS3eyB7uCmOG4jdai6CdOZMxdLZEoF1vRrYZBYQ6IPbAGguQyAxq2LOJ04z17rAUXG+9Tut3j7dTBmT94+zxxhH7EHehnXK1lMfXfNEpJZZXKkrWy0fo/wwhxZeTL3kZAs/XsMd+b/tTGbCvpFJolDUhOs0BP5BbgVpleQDnydTVFvY1IjHu53G9hgEkn5/VSSlrAmIx5FoqFwIHED5E/Vnhq1ysr9qWiDvb+HMa/f90EE2gVMp5zpXb1ehzd6loLmjMrHpiOJ5tlhpu6jOtfPdfUw0c2MKcQFqsdGnB224rqZh9ltnu8awAXAQtdTaeM9LX/BC1o4hSXLz0ct6SLo9jfc2pgQ19jZTbX7azG51S8QjVjPVcARMIjytjd9pl1S3ypjScyvyl
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2263694E8D77278EECDC8A97C7A60@CY4PR02MB2263.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR02MB2263;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2263;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2263;4:5uPR2o+9ICbkCWAEm7rADH5sJ1H2EDQtmg4t+ufPuC/pFVpOUL4xALvBMqJGHsfm3aJ2JvXB+TxdLoY61ffQUk5GM57twGxvExNgTCp2fx76VFXeqg3IS4AGU9fDH+FomaZxYao2wK5rklJrXS71C4ETbjHvt/2cy2jhB/DbsjAhaTTmx7j99YWG0dTLunHkPkY0ZSGJV7cfGiw3kafCZ+2azVisBfScZqt+Tdly/MbgJYzhKAF1qtPMohlXF1WBjHhpqSeUseDJnX6E5980gM2Es8kx6xXW1n4EcZF42MEtNyrKrEcM2owuhw62Qjoj
X-Forefront-PRVS: 0630013541
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2263;23:t/L1WYFl3TGtTAPRCiGsdIw9ptGdEcS/VAWVU4XdV?=
 =?us-ascii?Q?kwrOy2Em34oC6kuDU8EWkEIwzuzlYoqLQ4y5J2z0WDjZjEFkCknVgXNOCmsm?=
 =?us-ascii?Q?rc/m6Wh7pPAkKnJhAEVbWwqNxYAV1eDKZQl+l/yAgo6Or1HNek9SsgzTUq5D?=
 =?us-ascii?Q?mgUfqBt3MSbk5o01SmBBg4SaKyHw827PHSTmx2mB716pln42r+cydLK3vU0L?=
 =?us-ascii?Q?jhSqBoebdEMnW/MNkoroI59WA0wT20tXQrELGootvdgsYhPSgDjVRm0trzfI?=
 =?us-ascii?Q?HIVBWSCUtVBdUyl58haHF5F2rKpLLb/gTmT0Dy7Bdcw+YEamqxBKqlRpQz11?=
 =?us-ascii?Q?IajN2o16Ks/WzZfJfx3d29yQHazhT72y4vxd6kSPPZtSSy7H++S4mU2Fakom?=
 =?us-ascii?Q?f7O8/RITLW33I/+cVOGJ4b3J4DRGEXoPqDS4k6dj5/n3Yw7aVAzYvg8Cqkmx?=
 =?us-ascii?Q?6nZLeQsdFqTmvZCfoG4flycFVL5hz1YpUkUArsdCQQvP9R7jEYL/YNoauvKA?=
 =?us-ascii?Q?ZN6mtxifap6iWqZF3cRGgerpEkpJXIzAsCmNY2UWoNXl9TPXya7RZCENitki?=
 =?us-ascii?Q?15i7N8YOdVhatG1Av094+qN/tGTQs5oxkO7bQ845AkUR3vC+mDKGTpcg8kp7?=
 =?us-ascii?Q?QbzfQxIBotT7iiA9DkanjZfFi81gItR5VAYHwjqeTPnBWe/SCcPIVwxhF5T3?=
 =?us-ascii?Q?BOLK1u2XxUmiQNS8sAMlZmsWV6755WligQ+mjXL3e696YuxZLUjnLe+rjVdo?=
 =?us-ascii?Q?q+IPGvhowjnYkBqyZ5fsIS54LMW4ZJ57eTOkS2WfSuveYmf5Nd4Iuivrh4nN?=
 =?us-ascii?Q?jCKYYDlx4Jy32o6mMSaS8HuIM6rBHD5GKYUxgSfifQ/DHSZ0Op+QOeBB8oBu?=
 =?us-ascii?Q?86M5A27vtC1gxdPnroLD2Warhf3vVQtCv/CPbXODFvZzkqqi3yF3aM1wNCH0?=
 =?us-ascii?Q?9kRzh4VwHy5st7AvjUoMkjW+53wq7Lgw8SJhvaSYwNu/LWkh9Ht+JbiUVSK3?=
 =?us-ascii?Q?+6yf3Hx3dcQtAw53KZ/Yk+WaYuo38NX8F98tdhNE6nnf3YFZ1S6o0LhJLy84?=
 =?us-ascii?Q?3o1pfJaN8zdS5qBmvYqGYY4eLFXS22k8w2VpkvluG+Tt9VdOlWE5x0B6Dwub?=
 =?us-ascii?Q?lzx2dC03esRjApWykTNP9DiG0KWZ0GsRoG5iDbztPwDqbws3Z25o3C+H7KJo?=
 =?us-ascii?Q?OQEKcceT/J8B5+sqpvHY8qR5xcrMitthuK8?=
X-Microsoft-Antispam-Message-Info: 52VaWXrE3QoCmFksQWySaSs6tLmdI3i4DO3JcTRyEEVXurKGT1J8diGDfAp7CjihKg6U4OyRFY4RGYlstCaAP1PWfLxSMS0mJYK0JPumEJDyUyfxBKm/BYwPkVh/Nv+1r8YIgnXDMCtkzcGWuNdQq2iXFM7DvOQwuSbeKlf8DECe0dRnjouBFgYBSu2obcn5
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2263;6:jvjuu5CEu4i1hEcM/YLMkCp50qw2Mwwzveeg9Gn2K6WIoPIBhupjYeFETMEPmxzo5xVYcWYLZukTRKuvQmGKdmKn51EBgSfcN53tBPg5qwvhoafg/SiCYiOB+0pn7EcUl3luuR4Gc+rM5Da2V4Md2r4j7vxNWXhR3HLI/7T2fHu4eGUSf/fe5e3kG84vqj/SEzsJOm0wrU1zaBBXJIAQ/k9mp9YLnm1S4vWXNohN6zGmTS2YQOOfWhU2M/wTKEZIuLxXb8pMKSdnbbe73tcTI4fJ0j+oNvkhd6tvcnHvY5QQnGAn7OeEB9cLq+tuLvQOIxXnSpfoOeQTJt9leewD6Psg+vbop2lEYUHcjdgqQn9/fU67KqK/iKSzlLSLxmvEM0jORuz+fIxRhSmPEGCDJUuVFQksAjumVHOgq7McF2Q0aWyQVuMIlxSznH0GZGbpl9xfdTWEFJWn0rpKz33uzA==;5:DkILS7be25g08MUg3PZYSyO+kx10rRU4cdtBaeNHyXVYF6gny0aozyThjrnoMsi2VaigWIS3sroQIoZeUgrVaxZWveiR1rXQFcTShcNXZi7CpwVxrpISuKReNbn7L1LXSRy/XgeIn1uG8QIFS0mFx2BBo1JjucTpQyF5GO59lUA=;24:oCRgMQISQ1+5GZLUH2zENYBpzD2JJ5PaRac77dTRK+FsVjfxIo2TqFX107ES5bziD+W+z8gvkFpGsKPQSV7uKC7Rdc8bDJnQGtmwdmGjAO8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2263;7:q/hMH2ZA0gmd5Fdyz6j3yUh/Bk40xT7K+ZflbybPO6vAgq9jKLLJ6l5NwzBLLghPhyS1Qsilj5GcwP0mEskfWHTVG7TQnw7Xb2WjXvboch4JiFUWoaSm12uJovH7K3aK0pUaHgmBLgLyZJcXVS84tRcBXttXPmpBWC0s3sD5ddJNMBGDET+hTIOFg40VfEvJpy61e2Qw8SOUnQH88HKd/OOa9PZ9vT/BCagHTFYjMyQuH0ngWoCTIQVu3waPjzLq
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:39:24.2573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16291310-d8c3-469b-b18e-08d59886009d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2263
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXIDMA IP sets completion bit to 1 when the transfer is completed. Read
this bit to move descriptor from active list to the done list. This feature
is needed when interrupt delay timeout and IRQThreshold is enabled i.e
Dly_IrqEn is triggered w/o completing Interrupt Threshold.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 36e1ab9..518465e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -103,6 +103,7 @@
 #define XILINX_DMA_PARK_PTR_RD_REF_SHIFT	0
 #define XILINX_DMA_PARK_PTR_RD_REF_MASK		GENMASK(4, 0)
 #define XILINX_DMA_REG_VDMA_VERSION		0x002c
+#define XILINX_DMA_COMP_MASK			BIT(31)
 
 /* Register Direct Mode Registers */
 #define XILINX_DMA_REG_VSIZE			0x0000
@@ -1387,16 +1388,25 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *desc, *next;
+	struct xilinx_axidma_tx_segment *seg;
 
 	/* This function was invoked with lock held */
 	if (list_empty(&chan->active_list))
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
-		list_del(&desc->node);
-		if (!desc->cyclic)
-			dma_cookie_complete(&desc->async_tx);
-		list_add_tail(&desc->node, &chan->done_list);
+
+		seg = list_last_entry(&desc->segments,
+				      struct xilinx_axidma_tx_segment, node);
+		if ((seg->hw.status & XILINX_DMA_COMP_MASK) ||
+			(!chan->xdev->has_axieth_connected)) {
+			list_del(&desc->node);
+			if (!desc->cyclic)
+				dma_cookie_complete(&desc->async_tx);
+			list_add_tail(&desc->node, &chan->done_list);
+		} else {
+			break;
+		}
 	}
 }
 
-- 
1.7.1
