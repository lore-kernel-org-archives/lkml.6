Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeCVISb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 04:18:31 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:22704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752723AbeCVISO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 04:18:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
From: Robin Gong <yibin.gong@nxp.com>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v1] dma: imx-sdma: add virt-dma support
Date: Fri, 23 Mar 2018 00:18:19 +0800
Message-Id: <1521735499-29138-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0185.apcprd02.prod.outlook.com
 (2603:1096:201:21::21) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31111087-8dfa-421a-a174-08d58fcd7263
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:pHDFZPf1JN4NnTvVBtwp+MuqdenNejnD9eHjUDEI0vPB3DD5SYw72q4eqpZG9YnIaZjQjRg8YCPgaIXuiyK6G8Sz0F4+GQiqssPRv6dX24VATrHGJHyUBLjlInjni0yUd5M+kJ1GTihjdgmW0rXjNOy8yaaMg6rojBx5Tbx0ZJvjMLOO2AJnnw4M53Jy7ESAfb6OyUO4rUIjAbu0cAtYL8ACKBb3VnBXBJ7iXm1NDhv5Bg7lqWZ7Wsssbd2QnRxo;25:pRZLolsIXHi07Yz1KMDwtej2pdiDbDy07sU4yvyEiNNwbWkqpsZbkvVUGL3H8LDThiVxdlX7TEGLut0ow+L8NXIwyDDs9vumyn7F0diZKuPvYj/Jifh0Z2bFWqfFM4ewmuRhiA9ZRSuNdrrNRlWiMNL7QN2q8VS7t5vIN4TxJrUh6k1z5uM1PAIIOkl7+9ekh7Lz/XFTWevq5itsml0DDWeQ5Kg0RKfqJKD0/wVkj16ENDy2n8JKEPa0bU7BZ68nrA3i3i2HGzJpsAbPrEj4Re3nX4teR9J4DZepeFwnLcNy07hnWGxH0KDRUh4nkMWFXr7IUZvA6d1CXiXDoxRwMQ==;31:aqnWJ79gnYUQxlh4Py8iV7bWMRysar38xF6oHKp3MnQYRh1H5UVjdOLAcjLlcB0dhsXT7EDCZNe4QroGAQNM26SocG+1ZuxM+GbyQHNDRwz5UwDqlrwCv9+AKO1kL1I7Z3WQtrT5qF1tVZln4Y3sFg2CQl+pGBX0z32Hz2IyOHuAQ9xzg1DPYYKJaMYStlPbJ+fkyI6PiJnlfH7r1awy8wk9znBYeb8NnBBxJA+i2lg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:myg4xXYnlVjq3volDcP/f0NEnnW6J6m/sCfjG3VFuCnyeI12JvG1BxTYAA/L6LhAWI5Z1+FBgOJAuCAyv+l4ZEba74hUzreaXqwfW0/mRD31uill9uouYVDTHqA5RAX96fn6ZOemIffUWq7Glaaz00/QeiYjDX0VrMFQsBQ3565fmELi404TeHbpMedbpz+CNv0GL/GBkfnDfzNmvRgIXHj+upjWeL9c7RAG4lyChNJkgKWpN9UiDbMkXraQN7441T9pw4BhvqcXNKaRcRAvJgpbJ/g/yiDgoCqsKKxw99PQrHPNG+AgEcpjwU0tSESP1Tu970f3LVjth+wuZcLb/3tYHbscf4AQ/k4J458CRvP97MC71HDbtx6aOVZyehXY7fCHngdfwq8/xC4Edaoh+Gy290Kd9qPfJcll+Ciwr2taknzs5E5A76VgsryAVGaJP+ceabNMNTsIlUPjCi8XL5vd0A50rQ9j9Nelww3iRAGehaPKF5/G02FBRLMhk7Va;4:jPbI7ZXtCpKdOLDL4JzHWdomCvXpuyx3+XPeJo6MeZmgWoPme6L2eauMMzVUm1jiSsnzTYwq3auPjY6uYblZpbzAGN7Odib3YxFatqm3ghP8KUhQJvc30fdC1T5LGpJnwd02dJ0GPM/QdUvnafgyGPy0y6DX6RzSZ8z+kVk71YAgNIou4Sa3qrv600TK0yanl4cMEu6HRLUD0RRRB6ab6YiJK5NkwuV9dzZXlqDNeQHATTTAT3k7rkPPOFY1jsN0O0KXL2xim4Az+ntEITq9hs56uthm6S0KVgo6CU3yolSsjnwQNr5E+aXjDOkwZ0Ur
X-Microsoft-Antispam-PRVS: <VI1PR04MB323216065FBD00DE1603528F89A90@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(199004)(189003)(105586002)(51416003)(551934003)(52116002)(16586007)(16526019)(26005)(186003)(106356001)(25786009)(4326008)(86362001)(575784001)(6486002)(36756003)(6512007)(6116002)(68736007)(3846002)(97736004)(81166006)(6666003)(8676002)(478600001)(2906002)(6506007)(81156014)(316002)(53936002)(386003)(8936002)(7736002)(50226002)(305945005)(66066001)(59450400001)(50466002)(47776003)(5660300001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:5/b0ZUV3aKJeb6jQGMvu171v2vEhCfhtNhiwAnDl7?=
 =?us-ascii?Q?87xWaQFmlZ/jLHcwcl5af2qLsHMLOr6uwC1ciDT3D7CnR2zySPv7iC+oR37N?=
 =?us-ascii?Q?bfWEhpg3Jz5BtudU8VVPTYzD8JccuIWOFFqY7SnW71T81z6+wsULYmhIhy9B?=
 =?us-ascii?Q?Oa/Xcr64h4x1pAofWxxE1QWMwDYcEII+ztnhAxqNBRkMpoIeNOE/l/N2eSG5?=
 =?us-ascii?Q?46+wiH9GbBpU4nf7/P7lsASVZWc/NxESlibKgha1t3ZFYQNrFm8pbaARZNBh?=
 =?us-ascii?Q?Ym8GYXbeU8+efxsoYnU7PoDlLOWH4polTDj6YfpRp4Tz9TKSfIHtfbYS601V?=
 =?us-ascii?Q?zs+Y7QS0/xJM970VAzPN/Hnt6Gr3kTkh3W5Nde2qSGHPSiKFC/fO5svVdaiw?=
 =?us-ascii?Q?BDL/qXYQB3M9+ce7Ecvskpr/BluCph6jFhdaobqAphx91/OPUGJHUJ2KTXrm?=
 =?us-ascii?Q?ElytiKsUo0sqZbxBQeU0Mu5k+dOVWThVDRj34yE/0FD8Wae8xCCPKlsiuiM6?=
 =?us-ascii?Q?+otWbnvYWAlPqrbw4XDHqZGTwoNyr3nQOBmWogb6uqYwUn/H54AMGhB0osL4?=
 =?us-ascii?Q?Wg47n/fzrNfQ8TyMGz1DolPfWWtgmxXYuK0Vd0CX+iRkBbPY7ncmwv0yqWM9?=
 =?us-ascii?Q?l9crRNOkUlb+/fMOQ9rApRtepIBzIrpbtdEpKsHDfBc5bhkXpv1pis/y4RU3?=
 =?us-ascii?Q?hQX14/xFL7AUlDD0mjBCEl0JKqpnrHoY7dwg/R1RoMnNvqj5UP6v9A6uiU+5?=
 =?us-ascii?Q?nBQlfl0jRbrkqEtrKGop+fL+OZRA5Q8JI3+3sjgXAjkR4buYFTYX+/WLUEjT?=
 =?us-ascii?Q?IcYLXh0gdnB4OcxINaHIevg7WpW2+38GF2F9cR6h41mtibxpBVTeVlyJlE1s?=
 =?us-ascii?Q?ABeJMVOrbuBbr8Wpd4k36EW5JYPqL1Mked3Rk1cYZENAScqKwNmDcVxvFJE5?=
 =?us-ascii?Q?HkTruhBmi8ArUXkmwwWv3oCkVfjj9d+7eFc8BbM3G64Zw53Tirha9uyG+1NA?=
 =?us-ascii?Q?em2zPCthQK3HCGEHjfsVW1IawbHlBZDtlQis9HFoucrdDBosN5Sj2t1u2ICS?=
 =?us-ascii?Q?imwxkqK7q8/I9+u6aRLE9DPboqEJ/2judHfLFWjEypbzEgbLD7aVybTYOAT/?=
 =?us-ascii?Q?+KjmPK5n5o=3D?=
X-Microsoft-Antispam-Message-Info: vlDkxEYi3Ce1o/E5rL7Vs6sHpsEV8lxx2ykuvgUj6euOE8INnTSN264vWUXyFVz1SdzOAsg9raEuMssuLDQvGvObNvJE94aLk5/El2EJgC3m7ikGWpJjnauxKTN4VHESyS8HgUsJxO/8ardEqpmyurlZXQ1eHSMQvbCmuv5Wk+DcXU3a1ns1WIQpCXd9j4bM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:SXeMUqn5zSr/Ms9NsQjGXT0fOLgkeQ/+tw0akLHhUfuoodeZSZYia5M0aV+JSBUx1ozUzT17CV0IeJpEhUFsqbvuLQfN/qDeI7vbrpJR92iWc/XoqTyaBt1Pm5EtbuMQbIJ8Byzf3ZbqsoLWHh2oC3uINE1TgPp5aEW0bSZGt2Xxr9UXk7PNhLAS7OsbQgMardNltSCgfBGjGuA0PlfVaQdqV3FGhwBQuGSYrSoLrAUfcSu3QcoMn/Y5G4MwW6cA8njX/3orvxTkM1qZvCIB/uTCe7SRKxglm27az7nhvhbrfv9oWQ5BlQVbnXY+QmiCnD5LLAi4iZ0o0TUG2m7fOVx+IZdNjyMoeW9J21fjqhQ=;5:IhjC5XAFBuGFvqN83f/6ViQYYOXGPBP/lSjGmwrCBzlwD8R8pAGZ+g/V0pd6kDrNNj3TykGYDIn56lbARPwg13fk1i0JITGAznRf6D6MpWK8iE6wNKt181AnwW3Bl3xr9EXCO+FyaRE85L/O9eupDfapmqrOf+Oj5fPsB+0q2CM=;24:EmLtu6nhruZd9XK8jMJajFMCW2SkaV38Zji6Jaf53szL3mCLc+VNborpbnZ/Pv1xXTIqZVR0YEFOE9y4U0D7P3x7p3pH4CtM7QOsjP+dEUg=;7:IVqzR/9lTM/0QmV7FgjjttYUG1LSu5bxq8wN6CWGrEzGiXafD7rAu7ueH967xzNwZ+IDLYusrsK8zgSuPJ78YlJ/hBOQu7KOSQIP9E/B9li1Z1fC8G9VcWuIQYAN6jwb4tpuhwTU6JiF0jTPcJyYN7B0zYRsdXOP+cUAfPppm/qskTsTXMsavNZTuTjD6vUAlYMCOuOfwCDlqPnB6SM91zbDg3F/u6NeN2f8fZAGEYeGPT74o5WC55npJ5VcWAop
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 08:18:07.3098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31111087-8dfa-421a-a174-08d58fcd7263
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 395 +++++++++++++++++++++++++++++++------------------
 2 files changed, 253 insertions(+), 143 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 27df3e2..c4ce43c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -247,6 +247,7 @@ config IMX_SDMA
 	tristate "i.MX SDMA support"
 	depends on ARCH_MXC
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the i.MX SDMA engine. This engine is integrated into
 	  Freescale i.MX25/31/35/51/53/6 chips.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ccd03c3..df79e73 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -48,6 +48,7 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 /* SDMA registers */
 #define SDMA_H_C0PTR		0x000
@@ -291,10 +292,19 @@ struct sdma_context_data {
 	u32  scratch7;
 } __attribute__ ((packed));
 
-#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
-
 struct sdma_engine;
 
+struct sdma_desc {
+	struct virt_dma_desc	vd;
+	struct list_head	node;
+	unsigned int		num_bd;
+	dma_addr_t		bd_phys;
+	unsigned int		buf_tail;
+	unsigned int		buf_ptail;
+	struct sdma_channel	*sdmac;
+	struct sdma_buffer_descriptor *bd;
+};
+
 /**
  * struct sdma_channel - housekeeping for a SDMA channel
  *
@@ -310,19 +320,17 @@ struct sdma_engine;
  * @num_bd		max NUM_BD. number of descriptors currently handling
  */
 struct sdma_channel {
+	struct virt_dma_chan		vc;
+	struct list_head		pending;
 	struct sdma_engine		*sdma;
+	struct sdma_desc		*desc;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
 	enum sdma_peripheral_type	peripheral_type;
 	unsigned int			event_id0;
 	unsigned int			event_id1;
 	enum dma_slave_buswidth		word_size;
-	unsigned int			buf_tail;
-	unsigned int			buf_ptail;
-	unsigned int			num_bd;
 	unsigned int			period_len;
-	struct sdma_buffer_descriptor	*bd;
-	dma_addr_t			bd_phys;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
 	unsigned long			flags;
@@ -330,15 +338,12 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	struct dma_chan			chan;
-	spinlock_t			lock;
-	struct dma_async_tx_descriptor	desc;
 	enum dma_status			status;
 	unsigned int			chn_count;
 	unsigned int			chn_real_count;
-	struct tasklet_struct		tasklet;
 	struct imx_dma_data		data;
 	bool				enabled;
+	u32				bd_size_sum;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -398,6 +403,9 @@ struct sdma_engine {
 	u32				spba_start_addr;
 	u32				spba_end_addr;
 	unsigned int			irq;
+	/* channel0 bd */
+	dma_addr_t			bd0_phys;
+	struct sdma_buffer_descriptor	*bd0;
 };
 
 static struct sdma_driver_data sdma_imx31 = {
@@ -553,6 +561,8 @@ MODULE_DEVICE_TABLE(of, sdma_dt_ids);
 #define SDMA_H_CONFIG_ACR	BIT(4)  /* indicates if AHB freq /core freq = 2 or 1 */
 #define SDMA_H_CONFIG_CSM	(3)       /* indicates which context switch mode is selected*/
 
+static void sdma_start_desc(struct sdma_channel *sdmac);
+
 static inline u32 chnenbl_ofs(struct sdma_engine *sdma, unsigned int event)
 {
 	u32 chnenbl0 = sdma->drvdata->chnenbl0;
@@ -597,14 +607,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = &sdma->channel[channel];
-
 	writel(BIT(channel), sdma->regs + SDMA_H_START);
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = true;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 }
 
 /*
@@ -632,7 +635,7 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 		u32 address)
 {
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
@@ -691,23 +694,16 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
+	struct sdma_desc *desc = sdmac->desc;
 	int error = 0;
 	enum dma_status	old_status = sdmac->status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	if (!sdmac->enabled) {
-		spin_unlock_irqrestore(&sdmac->lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (1) {
-		bd = &sdmac->bd[sdmac->buf_tail];
+	while (desc) {
+		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
@@ -726,8 +722,8 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		sdmac->chn_real_count = bd->mode.count;
 		bd->mode.status |= BD_DONE;
 		bd->mode.count = sdmac->period_len;
-		sdmac->buf_ptail = sdmac->buf_tail;
-		sdmac->buf_tail = (sdmac->buf_tail + 1) % sdmac->num_bd;
+		desc->buf_ptail = desc->buf_tail;
+		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
 
 		/*
 		 * The callback is called from the interrupt context in order
@@ -735,15 +731,16 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * SDMA transaction status by the time the client tasklet is
 		 * executed.
 		 */
-
-		dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+		spin_unlock(&sdmac->vc.lock);
+		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
+		spin_lock(&sdmac->vc.lock);
 
 		if (error)
 			sdmac->status = old_status;
 	}
 }
 
-static void mxc_sdma_handle_channel_normal(unsigned long data)
+static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
 {
 	struct sdma_channel *sdmac = (struct sdma_channel *) data;
 	struct sdma_buffer_descriptor *bd;
@@ -754,8 +751,8 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 	 * non loop mode. Iterate over all descriptors, collect
 	 * errors and call callback function
 	 */
-	for (i = 0; i < sdmac->num_bd; i++) {
-		bd = &sdmac->bd[i];
+	for (i = 0; i < sdmac->desc->num_bd; i++) {
+		bd = &sdmac->desc->bd[i];
 
 		 if (bd->mode.status & (BD_DONE | BD_RROR))
 			error = -EIO;
@@ -766,10 +763,6 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 		sdmac->status = DMA_ERROR;
 	else
 		sdmac->status = DMA_COMPLETE;
-
-	dma_cookie_complete(&sdmac->desc);
-
-	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -785,13 +778,24 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 	while (stat) {
 		int channel = fls(stat) - 1;
 		struct sdma_channel *sdmac = &sdma->channel[channel];
-
-		if (sdmac->flags & IMX_DMA_SG_LOOP)
-			sdma_update_channel_loop(sdmac);
-		else
-			tasklet_schedule(&sdmac->tasklet);
+		struct sdma_desc *desc;
+
+		spin_lock(&sdmac->vc.lock);
+		desc = sdmac->desc;
+		if (desc) {
+			if (sdmac->flags & IMX_DMA_SG_LOOP) {
+				sdma_update_channel_loop(sdmac);
+			} else {
+				mxc_sdma_handle_channel_normal(sdmac);
+				vchan_cookie_complete(&desc->vd);
+				if (!list_empty(&sdmac->pending))
+					list_del(&desc->node);
+				 sdma_start_desc(sdmac);
+			}
+		}
 
 		__clear_bit(channel, &stat);
+		spin_unlock(&sdmac->vc.lock);
 	}
 
 	return IRQ_HANDLED;
@@ -897,7 +901,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int channel = sdmac->channel;
 	int load_address;
 	struct sdma_context_data *context = sdma->context;
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	int ret;
 	unsigned long flags;
 
@@ -946,7 +950,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sdma_channel, chan);
+	return container_of(chan, struct sdma_channel, vc.chan);
 }
 
 static int sdma_disable_channel(struct dma_chan *chan)
@@ -954,15 +958,10 @@ static int sdma_disable_channel(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 	int channel = sdmac->channel;
-	unsigned long flags;
 
 	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
 	sdmac->status = DMA_ERROR;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = false;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
-
 	return 0;
 }
 
@@ -1097,42 +1096,101 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
 	return 0;
 }
 
-static int sdma_request_channel(struct sdma_channel *sdmac)
+static int sdma_alloc_bd(struct sdma_desc *desc)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
-	int ret = -EBUSY;
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	int ret = 0;
+	unsigned long flags;
 
-	sdmac->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdmac->bd_phys,
+	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
 					GFP_KERNEL);
-	if (!sdmac->bd) {
+	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	sdma->channel_control[channel].base_bd_ptr = sdmac->bd_phys;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	spin_lock_irqsave(&desc->sdmac->vc.lock, flags);
+	desc->sdmac->bd_size_sum += bd_size;
+	spin_unlock_irqrestore(&desc->sdmac->vc.lock, flags);
 
-	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
-	return 0;
 out:
-
 	return ret;
 }
 
-static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
+static void sdma_free_bd(struct sdma_desc *desc)
 {
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 	unsigned long flags;
-	struct sdma_channel *sdmac = to_sdma_chan(tx->chan);
-	dma_cookie_t cookie;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
+	if (desc->bd) {
+		dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+
+		spin_lock_irqsave(&desc->sdmac->vc.lock, flags);
+		desc->sdmac->bd_size_sum -= bd_size;
+		spin_unlock_irqrestore(&desc->sdmac->vc.lock, flags);
+	}
+}
+
+static int sdma_request_channel0(struct sdma_engine *sdma)
+{
+	int ret = 0;
+
+	sdma->bd0 = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
+					GFP_KERNEL);
+	if (!sdma->bd0) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	cookie = dma_cookie_assign(tx);
+	sdma->channel_control[0].base_bd_ptr = sdma->bd0_phys;
+	sdma->channel_control[0].current_bd_ptr = sdma->bd0_phys;
 
-	spin_unlock_irqrestore(&sdmac->lock, flags);
+	sdma_set_channel_priority(&sdma->channel[0], MXC_SDMA_DEFAULT_PRIORITY);
+out:
 
-	return cookie;
+	return ret;
+}
+
+static struct sdma_desc *to_sdma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct sdma_desc, vd.tx);
+}
+
+static void sdma_desc_free(struct virt_dma_desc *vd)
+{
+	struct sdma_desc *desc = container_of(vd, struct sdma_desc, vd);
+
+	if (desc) {
+		sdma_free_bd(desc);
+		kfree(desc);
+	}
+}
+
+static int sdma_terminate_all(struct dma_chan *chan)
+{
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vchan_get_all_descriptors(&sdmac->vc, &head);
+	while (!list_empty(&sdmac->pending)) {
+		struct sdma_desc *desc = list_first_entry(&sdmac->pending,
+			struct sdma_desc, node);
+
+		 list_del(&desc->node);
+		 spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+		 sdmac->vc.desc_free(&desc->vd);
+		 spin_lock_irqsave(&sdmac->vc.lock, flags);
+	}
+
+	if (sdmac->desc)
+		sdmac->desc = NULL;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&sdmac->vc, &head);
+	sdma_disable_channel_with_delay(chan);
+
+	return 0;
 }
 
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
@@ -1168,18 +1226,11 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ipg;
 
-	ret = sdma_request_channel(sdmac);
-	if (ret)
-		goto disable_clk_ahb;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		goto disable_clk_ahb;
 
-	dma_async_tx_descriptor_init(&sdmac->desc, chan);
-	sdmac->desc.tx_submit = sdma_tx_submit;
-	/* txd.flags will be overwritten in prep funcs */
-	sdmac->desc.flags = DMA_CTRL_ACK;
+	sdmac->bd_size_sum = 0;
 
 	return 0;
 
@@ -1195,7 +1246,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 
-	sdma_disable_channel(chan);
+	sdma_terminate_all(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1207,12 +1258,43 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
-
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 }
 
+static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
+				enum dma_transfer_direction direction, u32 bds)
+{
+	struct sdma_desc *desc;
+
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
+	sdmac->status = DMA_IN_PROGRESS;
+	sdmac->direction = direction;
+	sdmac->flags = 0;
+	sdmac->chn_count = 0;
+	sdmac->chn_real_count = 0;
+
+	desc->sdmac = sdmac;
+	desc->num_bd = bds;
+	INIT_LIST_HEAD(&desc->node);
+
+	if (sdma_alloc_bd(desc))
+		goto err_desc_out;
+
+	if (sdma_load_context(sdmac))
+		goto err_desc_out;
+
+	return desc;
+
+err_desc_out:
+	kfree(desc);
+err_out:
+	return NULL;
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1223,35 +1305,24 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
+	struct sdma_desc *desc;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
+	if (!chan)
 		return NULL;
-	sdmac->status = DMA_IN_PROGRESS;
-
-	sdmac->flags = 0;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
+	desc = sdma_transfer_init(sdmac, direction, sg_len);
+	if (!desc)
+		goto err_out;
 
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
 
-	sdmac->direction = direction;
 	ret = sdma_load_context(sdmac);
 	if (ret)
 		goto err_out;
 
-	if (sg_len > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, sg_len, NUM_BD);
-		ret = -EINVAL;
-		goto err_out;
-	}
-
-	sdmac->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = sg->dma_address;
@@ -1262,7 +1333,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
 					channel, count, 0xffff);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		bd->mode.count = count;
@@ -1307,10 +1378,11 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	sdmac->num_bd = sg_len;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
 
-	return &sdmac->desc;
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1326,39 +1398,32 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
+	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-
-	sdmac->status = DMA_IN_PROGRESS;
+	/* Now allocate and setup the descriptor. */
+	desc = sdma_transfer_init(sdmac, direction, num_periods);
+	if (!desc)
+		goto err_out;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
 	sdmac->period_len = period_len;
-
 	sdmac->flags |= IMX_DMA_SG_LOOP;
-	sdmac->direction = direction;
+
 	ret = sdma_load_context(sdmac);
 	if (ret)
 		goto err_out;
 
-	if (num_periods > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, num_periods, NUM_BD);
-		goto err_out;
-	}
-
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	while (buf < buf_len) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = dma_addr;
@@ -1366,7 +1431,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.count = period_len;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
+			goto err_bd_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
@@ -1389,10 +1454,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	sdmac->num_bd = num_periods;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
-
-	return &sdmac->desc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1432,26 +1497,74 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	u32 residue;
+	struct virt_dma_desc *vd;
+	struct sdma_desc *desc;
+	enum dma_status ret;
+	unsigned long flags;
 
-	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (sdmac->num_bd - sdmac->buf_ptail) *
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE && txstate) {
+		residue = sdmac->chn_count - sdmac->chn_real_count;
+		return ret;
+	}
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vd = vchan_find_desc(&sdmac->vc, cookie);
+	desc = to_sdma_desc(&vd->tx);
+	if (vd) {
+		if (sdmac->flags & IMX_DMA_SG_LOOP)
+			residue = (desc->num_bd - desc->buf_ptail) *
 			   sdmac->period_len - sdmac->chn_real_count;
-	else
+		else
+			residue = sdmac->chn_count - sdmac->chn_real_count;
+	} else if (sdmac->desc && sdmac->desc->vd.tx.cookie == cookie) {
 		residue = sdmac->chn_count - sdmac->chn_real_count;
+	} else {
+		residue = 0;
+	}
+	ret = sdmac->status;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
 			 residue);
 
-	return sdmac->status;
+	return ret;
+}
+
+static void sdma_start_desc(struct sdma_channel *sdmac)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&sdmac->vc);
+	struct sdma_desc *desc;
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+
+	if (!vd) {
+		sdmac->desc = NULL;
+		return;
+	}
+	sdmac->desc = desc = to_sdma_desc(&vd->tx);
+	/*
+	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
+	 * the desc alloced will never be freed in vchan_dma_desc_free_list
+	 */
+	if (!(sdmac->flags & IMX_DMA_SG_LOOP)) {
+		list_add_tail(&sdmac->desc->node, &sdmac->pending);
+		list_del(&vd->node);
+	}
+	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
+	sdma_enable_channel(sdma, sdmac->channel);
 }
 
 static void sdma_issue_pending(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	unsigned long flags;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		sdma_enable_channel(sdma, sdmac->channel);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	if (vchan_issue_pending(&sdmac->vc) && !sdmac->desc)
+		sdma_start_desc(sdmac);
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 }
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
@@ -1657,7 +1770,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++)
 		writel_relaxed(0, sdma->regs + SDMA_CHNPRI_0 + i * 4);
 
-	ret = sdma_request_channel(&sdma->channel[0]);
+	ret = sdma_request_channel0(sdma);
 	if (ret)
 		goto err_dma_alloc;
 
@@ -1819,22 +1932,17 @@ static int sdma_probe(struct platform_device *pdev)
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
 		sdmac->sdma = sdma;
-		spin_lock_init(&sdmac->lock);
-
-		sdmac->chan.device = &sdma->dma_device;
-		dma_cookie_init(&sdmac->chan);
 		sdmac->channel = i;
-
-		tasklet_init(&sdmac->tasklet, mxc_sdma_handle_channel_normal,
-			     (unsigned long) sdmac);
+		sdmac->status = DMA_IN_PROGRESS;
+		sdmac->vc.desc_free = sdma_desc_free;
+		INIT_LIST_HEAD(&sdmac->pending);
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
 		 * that channel 0 in dmaengine counting matches sdma channel 1.
 		 */
 		if (i)
-			list_add_tail(&sdmac->chan.device_node,
-					&sdma->dma_device.channels);
+			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
 	ret = sdma_init(sdma);
@@ -1879,7 +1987,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_slave_sg = sdma_prep_slave_sg;
 	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config = sdma_config;
-	sdma->dma_device.device_terminate_all = sdma_disable_channel_with_delay;
+	sdma->dma_device.device_terminate_all = sdma_terminate_all;
 	sdma->dma_device.src_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
 	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
@@ -1939,7 +2047,8 @@ static int sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->tasklet);
+		tasklet_kill(&sdmac->vc.task);
+		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4
