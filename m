Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED345C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F120247A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/ujwB/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F120247A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932914AbeGDCHx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:07:53 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:29248
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932489AbeGDCHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/I2NJ/7s2MyRzNbrXXs8T7Ahb1NrpzwIRuBE/nBCXo=;
 b=O/ujwB/l9Bm/ZnDoTZCKR5Br9fg6ZaQR5QvmaC2JgZmsHf2xF94dAi6WYZZ8dOfI/tL5GvqGIBUr/LweHauoEtRN5nVVyibmH5ycrUflCNf3uu4i4jfnsFGa08LYlu970vMaN0E/1wcR+5o4LgE+kzQ7KPAmK8bEaLLi7Frvmkk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Wed, 4 Jul 2018 02:07:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2] dmaengine: imx-sdma: add missing structure description
Date:   Wed,  4 Jul 2018 18:06:42 +0800
Message-Id: <1530698802-23468-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0047.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::35) To VI1PR04MB3231.eurprd04.prod.outlook.com
 (2603:10a6:802:6::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d94e47-5a35-40b1-8d03-08d5e152efdf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:dd0CcUfuJDP52546a5zVOlGNJipwKC2hXX1aBeTSlymRuuieQU7LVeCFpQNemAzOtPCRmlhNn9aYEemZjeXq1lXZikgVZFhHRYbAcqpHr+ZrUvSbrp63ltN/wgkXp+pmK8tj1aX4opjCdNNCNM+mm89LHNUDU9sJIMOjB+tthw8PviGPt/Am+zBeJi+CJP/K5c+QV5uxCQ+Zzv1eVPEBtopA5DzlURFLg9wes2s/3qxLajWKC31PvlSqOfO+7rqK;25:JG7n+buuKUJaog/qwkiVxbx5dFFFiYDxuVzY2he6Iv5vLenjx4IMmeaMdkpW+0ZPuujomF5nSLzw8wYk3OwWt+Ho4r3fhVgQUmYZ3eSagDZ1jENy4IakUu0g0Fk2zU8krVDPEoa82IxhWUrnlolGNTYhwGr2qkaM/qpRBe86juovEuOe5G6wgl1x0cyg5zYPnefziVs2qjsV/3h71Dyp8zpvYLsz5OQvIN0RntV0DVeZVsLQZqJI8LpukalvtqhZmz2tAaWfUsiyNSjly/rsB4AcHLYQ16g5f3z9WLw+5n6gs3kXLC9yaK3zUNxpnwb5LDbcSswDWZAU3duVE95/tg==;31:t31XjaJur1NTm+YXxkZzIyrrxLUtujR7++xHfMYkkx0y+RUL1IcBVuId2FUO5RgIQ0P5OK+WuT24EYO0y7AEZR4fwxFmjPpNUAzQyEl5kec2m0aVihthcg0WWzf59hVYKT3BYt0XqE1Zjc8WRWKztt3vt9jfA5aKOY3pGaPAGmjp0XbmQOtzbazeR18j1NAG9u6ojU8dKg/PYqrbV7bP80IGInBlqyZ+OxFZ+/bOXvk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:alOpVkTVXyR9wWxu8ftPWFyGpu5Pmzbwqg0i9u9tW7YY7oO0jspgsyZ52hucj/1NM2podx/lbHUBxOjG4sXN0VNxybfSVoEPzv4huR81xpfnO21XA8Zw0OwyiiGNlySM4Rmb8C45aEGcOERKCP99DNfih0QEw50oT2T51I+pu3QBeZgTaghL/MrQRvj6jGicWosjKnSVFNwY6WvC9SYDLqdx4wvMu84dErkI90PLMKOB+XaoVuFX4S/Bzukv/UZeqmBuyF17g5bt5Y+fOG0TOYHTzVd5BzbNys12p+nqa+s6MZAYmF1CsSMTAMbdb+tAvdWxwx03zi0y2SYDGIlAZ26NMCS9YiqDMqOzZsplrIVacMF431BlnmxxE5fl3qj3cBwnnX/ZB9d1aXGU8/wDQoqgKUdOlImxM1yXduxmDV1t6zWbh6vupguI+I/yyK9a/DiX+CaBzbUyAsYDoPRkqaOn3g2HYSbKcUzDiEIcUjXDHfWFC7j/4C/oCVWDMvCS;4:Pg77b/7oICPsgGqs+DfNGbr6SBzpx8J5j8knBnOj383iS9k5OIxwCMkM36bNP4T9CjdDm66olps/iA+ydQrGm2fiGnwnRgBYH5wt6GBT/+FT8ojP6Iw+Alu0Z5ngoWCYSwcUz8331cPdxSEN24JTREHsu+3jToZLqU4bDiMl4oPLr+aAt5x4p6GR6gTrdzNs4vE7xDs0qUFdv30piM7oQDwyfUThDiwFuS3ogIVCv5lte6mJf2HxuKID1KS4EO4ULXmBulbg94DbtfT4G4PcbamJ3One9VaATP2iDFqIAavbMTsVAsdJf3aORCZP1g/J
X-Microsoft-Antispam-PRVS: <VI1PR04MB32316DF377D8AAE669342A5889410@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39860400002)(346002)(199004)(189003)(51416003)(305945005)(486006)(476003)(956004)(2616005)(105586002)(7736002)(8676002)(8936002)(52116002)(3846002)(81156014)(81166006)(26005)(6116002)(16586007)(316002)(106356001)(6486002)(2906002)(4326008)(68736007)(86362001)(5660300001)(6666003)(66066001)(47776003)(48376002)(478600001)(6512007)(50466002)(386003)(6506007)(53936002)(186003)(16526019)(36756003)(14444005)(25786009)(50226002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:3;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:Zl5Nx32RVl5g7/fe4ShsjWeJ7qurijlNxg4n59Wkr?=
 =?us-ascii?Q?nvVdMZJmZS83KZA68uQA23HrvtpXnwKDmLeAvbeSCi0epS65kURyjfGVqSC5?=
 =?us-ascii?Q?o6ghhTEVqaGf4fynhcUce1ExHzRv59RKQrD6LsDzF7acHMlzmpFLXQaGcbMj?=
 =?us-ascii?Q?eGbolctBEgddiMuUXIMMrkR8JmX0WtM9q8H8XAGOl3y23ZQUg5vNyOyWcTCB?=
 =?us-ascii?Q?IF5t9ugrJU1gF5fayg5WjzT7DDfEdTNfRK3OzlaRa40lYuDyBg59w1gxIvbP?=
 =?us-ascii?Q?REZVDg/9H1pC06oHWvba8UfZ100P99hmhR5hBwHxgyMfbNiW2JHAVEUmH7cD?=
 =?us-ascii?Q?y/lCSYNsbuLOF7f9wcZSL144ne0RlDDYgefF1Kq/DGbHrc+Sr7EFBKp1LO8C?=
 =?us-ascii?Q?xmQbhv3nY5jDuh/TPKLKUqoWL3ELwmXHADQcQSVqe6WIofs1dW7UhTjPmp3i?=
 =?us-ascii?Q?6h3SGdxsDmMJdjSNGqNNC9Ud/HwULJnidbSTxviPfTSWVk0LGodYmt4ZZkDq?=
 =?us-ascii?Q?oWlu20tuOwLm/D5msqmH7oS5f6QY/oZ/56+3g27JbnqRpsOWfkwGaxHqrhTC?=
 =?us-ascii?Q?wUmIYjaPm+julYf1oEGucTEmqO0/nsadDDUXK5DCYnn8H16Ie86vV5q2s4+I?=
 =?us-ascii?Q?/kEwFkNG/sWC3RMql6JE9GLUZBro437feEiUlhw3ZmDUsrxhLHbZ0np4PHir?=
 =?us-ascii?Q?+SSDIcTWrEkUEbWV1HHv+308BPRt+lTdyZ8diZ3l1+4y4hD3wJWobZS92fT1?=
 =?us-ascii?Q?eI2DZ0sbo3mLIn5AS5rbV+N1MKh1QQeBPwPVKl6p2uK7YRZDnbX8dME/dse/?=
 =?us-ascii?Q?HMk0mdlFcCsN6RfiYK4UOOp64LaARKoWwNgI1GknYQiQl1eGZLSTcdFKn+En?=
 =?us-ascii?Q?IV3Av4pIB7tdX2HSkAjd40y/9TjHgVLjEgw20n8QKF9XlCAVQGmMMm78ct2d?=
 =?us-ascii?Q?+PNlq4aRGXPDsBmFOt3qY5pecDHhyeGT70ENzVuCW3KHG2q4FPb6pf/TsPuU?=
 =?us-ascii?Q?aQGlCrwRG1GewLljSDJez4GCD5BewyYu1OdqsZ4nHWTPUpSBFpCFpzjH9fnX?=
 =?us-ascii?Q?VviYMHDFteW7hdbKNXi49eVsSkghJq5aqN/pQYv4UOzR6uFH2uDV7lPCAi5u?=
 =?us-ascii?Q?mHu8cWeU2E=3D?=
X-Microsoft-Antispam-Message-Info: m6fmtv16Vukz/O1ZawaKpDY6pR4ADhyqjVwrh4gC4EbISJeGtS9+GNuQeTLp/wsRyYVrdycAC73FB4PctpQCCKt+x9e9r6e8p+8MsGO5eFdrmXTTkBySL0yVSXQjgFAK/LvL6M1X6A7RbrbSXVk45R6gll0II1nbTGAYxCYn+4RRes9hfbwzZOfnHJsDHpf7zfCkheHUXl1FbOpXfTGhdWNv/s6CMRNjpbBhRT/eA/MP6JDOCZrDBYiNEZ0Jamqf9VRLi53eVaI/bPEqriRA0saYjrZvp7NfyunPTwSvEmd9W3OWtLYv1kVQphRLTyIItyE8mAp4kqL+eLedGhEquKdr7VGO2ZbLeAhAbCgLVUA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:H4kBkmkJxMNDg1+UQsV2F9ABsYq+UUZmt9QrneunP+L4+lmcY/Q4racxT10qGuH5Rb7MQ1ZC2kbpbrH1wVe/zxpKKodgS0HO6T2kLiMEDP6kx1iaf51SL/AncZFD9VAeUBiaoYrAEpiXVIr0/0A78aaZyNfw5mzUrWxoVf6BkjBnQPVKW+RfAjmt4u5c91m8uptl6KNiJQlXhtACkCYqbrCKzPnR6JOzllW9cfsudXeWARMSNY1HJoYgN0zg2SLpIu3YSntAXgT3VNAtihXb0FRxr95Pacp1Nk/ydDuw8tC9/qhM5bD2Kht6WsTQhO+oKTrUv6/i5djMDR2yDx5W+A6Vza/ErMssQmukDdLRWMRL13pn5SHeK3KBi6YpgRAYhnDeVWUoWB/38G8iDoP3b2myBFv/7A+p3GeWzoW3AdT8Y488w2NjdbkJOhmRPtt/zuEq+MEufNX2spA6AG/6kA==;5:hsKpAFm1z9AFOMOc4v77nXgF5vBBDipPawDMGWHwdRGJuUz5I/s5RSRhrZY91DxnZG3VY1EIS5fQdul6lZ27T3Uf6ZswBz8xIWLFmBor3CSwy94rKQHI0fzhpe7ZjgOtM4V4QsUcRGTtym2fwU3pkiBwTXHKL7EPd9eqR7PFHOs=;24:vkXsN/RS+roNjKLxWa9KhL14xxgAuTXLVwVqMV3M1QZWkPrrqYe17R25fdV5eYdiL80SMWDY+hf5GNIT6J1Ij1DYBZCZBdLUNqXg0P8AnHs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:DdxU8JkZ3Y5Nzh3seEcaPx9i060xGeuuJZhGaZdzrMq1pNcrObx4BbUxrRaX1D2X1fTZnKb7gpSKz1O5OfvDVy5Y2CIs5V0NS0eh3FAt5cKtx22Nh9L14absp5s0dI6NWPTCp0dxtvYywdFs4cnsZRmwgOKuUSPZinz8c42flPqfJeljnlCJwasbBZ//zA69lP2rvlm851u9FX4iN0EnecUq5wjWdCAobJa6Oym9pgnD5GCawTGFrGijpcil1Lrx
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 02:07:45.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d94e47-5a35-40b1-8d03-08d5e152efdf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some member description or colons missing cause build warning with
'W=1' as below:

drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'vd' not described in 'sdma_desc'
drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'num_bd' not described in 'sdma_desc'
drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'bd_phys' not described in 'sdma_desc'
drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'buf_tail' not described in 'sdma_desc'
drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'buf_ptail' not described in 'sdma_desc'
drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'period_len' not described in 'sdma_desc'
drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'chn_real_count' not described in 'sdma_desc'
drivers/dma/imx-sdma.c:326: warning: Function parameter or member 'chn_count' not described in 'sdma_desc

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 85 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3de3281..c24baf9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -202,9 +202,9 @@ struct sdma_buffer_descriptor {
 /**
  * struct sdma_channel_control - Channel control Block
  *
- * @current_bd_ptr	current buffer descriptor processed
- * @base_bd_ptr		first element of buffer descriptor array
- * @unused		padding. The SDMA engine expects an array of 128 byte
+ * @current_bd_ptr:	current buffer descriptor processed
+ * @base_bd_ptr:	first element of buffer descriptor array
+ * @unused:		padding. The SDMA engine expects an array of 128 byte
  *			control blocks
  */
 struct sdma_channel_control {
@@ -217,10 +217,13 @@ struct sdma_channel_control {
  * struct sdma_state_registers - SDMA context for a channel
  *
  * @pc:		program counter
+ * @unused1:	unused
  * @t:		test bit: status of arithmetic & test instruction
  * @rpc:	return program counter
+ * @unused0:	unused
  * @sf:		source fault while loading data
  * @spc:	loop start program counter
+ * @unused2:	unused
  * @df:		destination fault while storing data
  * @epc:	loop end program counter
  * @lm:		loop mode
@@ -258,6 +261,14 @@ struct sdma_state_registers {
  * @dsa:		dedicated core source address register
  * @ds:			dedicated core status register
  * @dd:			dedicated core data register
+ * @scratch0:		1st word of dedicated ram for context switch
+ * @scratch1:		2nd word of dedicated ram for context switch
+ * @scratch2:		3rd word of dedicated ram for context switch
+ * @scratch3:		4th word of dedicated ram for context switch
+ * @scratch4:		5th word of dedicated ram for context switch
+ * @scratch5:		6th word of dedicated ram for context switch
+ * @scratch6:		7th word of dedicated ram for context switch
+ * @scratch7:		8th word of dedicated ram for context switch
  */
 struct sdma_context_data {
 	struct sdma_state_registers  channel_state;
@@ -291,15 +302,16 @@ struct sdma_engine;
 
 /**
  * struct sdma_desc - descriptor structor for one transfer
- * @vd			descriptor for virt dma
- * @num_bd		max NUM_BD. number of descriptors currently handling
- * @buf_tail		ID of the buffer that was processed
- * @buf_ptail		ID of the previous buffer that was processed
- * @period_len		period length, used in cyclic.
- * @chn_real_count	the real count updated from bd->mode.count
- * @chn_count		the transfer count set
- * @sdmac		sdma_channel pointer
- * @bd			pointer of allocate bd
+ * @vd:			descriptor for virt dma
+ * @num_bd:		number of descriptors currently handling
+ * @bd_phys:		physical address of bd
+ * @buf_tail:		ID of the buffer that was processed
+ * @buf_ptail:		ID of the previous buffer that was processed
+ * @period_len:		period length, used in cyclic.
+ * @chn_real_count:	the real count updated from bd->mode.count
+ * @chn_count:		the transfer count set
+ * @sdmac:		sdma_channel pointer
+ * @bd:			pointer of allocate bd
  */
 struct sdma_desc {
 	struct virt_dma_desc	vd;
@@ -317,13 +329,30 @@ struct sdma_desc {
 /**
  * struct sdma_channel - housekeeping for a SDMA channel
  *
- * @sdma		pointer to the SDMA engine for this channel
- * @channel		the channel number, matches dmaengine chan_id + 1
- * @direction		transfer type. Needed for setting SDMA script
- * @peripheral_type	Peripheral type. Needed for setting SDMA script
- * @event_id0		aka dma request line
- * @event_id1		for channels that use 2 events
- * @word_size		peripheral access size
+ * @vc:			virt_dma base structure
+ * @desc:		sdma description including vd and other special member
+ * @sdma:		pointer to the SDMA engine for this channel
+ * @channel:		the channel number, matches dmaengine chan_id + 1
+ * @direction:		transfer type. Needed for setting SDMA script
+ * @peripheral_type:	Peripheral type. Needed for setting SDMA script
+ * @event_id0:		aka dma request line
+ * @event_id1:		for channels that use 2 events
+ * @word_size:		peripheral access size
+ * @pc_from_device:	script address for those device_2_memory
+ * @pc_to_device:	script address for those memory_2_device
+ * @device_to_device:	script address for those device_2_device
+ * @flags:		loop mode or not
+ * @per_address:	peripheral source or destination address in common case
+ *                      destination address in p_2_p case
+ * @per_address2:	peripheral source address in p_2_p case
+ * @event_mask:		event mask used in p_2_p script
+ * @watermark_level:	value for gReg[7], some script will extend it from
+ *			basic watermark such as p_2_p
+ * @shp_addr:		value for gReg[6]
+ * @per_addr:		value for gReg[2]
+ * @status:		status of dma channel
+ * @data:		specific sdma interface structure
+ * @bd_pool:		dma_pool for bd
  */
 struct sdma_channel {
 	struct virt_dma_chan		vc;
@@ -359,15 +388,15 @@ struct sdma_channel {
 /**
  * struct sdma_firmware_header - Layout of the firmware image
  *
- * @magic		"SDMA"
- * @version_major	increased whenever layout of struct sdma_script_start_addrs
- *			changes.
- * @version_minor	firmware minor version (for binary compatible changes)
- * @script_addrs_start	offset of struct sdma_script_start_addrs in this image
- * @num_script_addrs	Number of script addresses in this image
- * @ram_code_start	offset of SDMA ram image in this firmware image
- * @ram_code_size	size of SDMA ram image
- * @script_addrs	Stores the start address of the SDMA scripts
+ * @magic:		"SDMA"
+ * @version_major:	increased whenever layout of struct
+ *			sdma_script_start_addrs changes.
+ * @version_minor:	firmware minor version (for binary compatible changes)
+ * @script_addrs_start:	offset of struct sdma_script_start_addrs in this image
+ * @num_script_addrs:	Number of script addresses in this image
+ * @ram_code_start:	offset of SDMA ram image in this firmware image
+ * @ram_code_size:	size of SDMA ram image
+ * @script_addrs:	Stores the start address of the SDMA scripts
  *			(in SDMA memory space)
  */
 struct sdma_firmware_header {
-- 
2.7.4

