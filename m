Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D290C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A5720896
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XnshHndv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A5720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933582AbeGCJuu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:50:50 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:10252
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754566AbeGCJur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1P/1b347cDPPRac1DTibATkmmMTswi4zUglOJzH6Dg=;
 b=XnshHndvkArzTRG3vSP2JTvob0ABETqhM824lVUnDJ2KPahLmQTnitnTElxKPYsDbZ2ViQ2WC0mVmzWSM88DnTNBsaPPbBib98eM18sl7vS7UTxrFoqTyY0iP03uWL9Uv+3so2uUL1WFIpNh3K1B87NmOt8UeQq10mURHkrQQ1Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB3228.eurprd04.prod.outlook.com (2603:10a6:7:1b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 3 Jul 2018 09:50:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1] dmaengine: imx-sdma: add structure description to eliminate build warning with 'W=1'
Date:   Wed,  4 Jul 2018 01:49:35 +0800
Message-Id: <1530640175-3478-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:203:2f::33) To HE1PR04MB3228.eurprd04.prod.outlook.com
 (2603:10a6:7:1b::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 954f8c02-2594-4d8d-13e7-08d5e0ca7161
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3228;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3228;3:qDutFGQlH6J2BxFsQN0o5psjnlTjocwOtUCBZO6vMzUHFSR7dJig+O2gdbdz2Y9SaaE3637P4HDAicXtyNnx60KG5Uy6azqBwGH6jF5Bo7z+V7rpM7DQ4e8xOgyu3AphmdNhn220sKqUcxMSUj9i6RlJ0qr4bgXW5T6v8RZq4ZisjBujalbmRKWhxGFim9V7PxOf5PcWHgE2nCJ3XzF5dgGtAAEvqH1bVwHWdRKgDnDadxozWVGyDkJCLtJ9Bim2;25:nMmPPa9nGUVTfEDY2ACzb+90+8sLkRlp808JnaNsnmIn0MB3evnieSouYWCyREfqg0E6mgJx7WjLvpbfCDfYwwGaNiLj43zKgOomX5Y4hGlVLZZ9RDBgEsGJe2gT5TL/LuQn25SE8FypoL0VIUiHS2JTQjWyIBUtRVvf/Xqg5g8x6IhUnwcMFPqWTSzKCCbkxffiauHUcC/ZVCG8odB5p+MpG++FUojUq8Eq4DepRrzQcergecN8R6iGDVJI+8/6TxgtKGKx36ZgxkYrfFOUz5I+oIx72ANO3jnjx8a6Z88nmhiA0pkE0ZvBmY7+P/8Nmfy6SpG4rSW554TOGkIdQA==;31:FbPiACvffgVRlTFW+QH8+1f/cTY4aHOKNHG81dPWF1Fh0DWfDMAeJrypkC0PTX2Ds6vLKCAZssL3ildvZyOdfCJn2dek4FN9NcS70DIwF1BrU/y+WjgxyAyMUawjKH1Wa+68jeOmlBjXdwqeYAvuxa9IERIP3UqiOu8aHhFdqMn6Mwvx0HsWhmyY9Y8tHWR1f9EkyxPTeYNFXG1Dmj9EWvbxArNbuQI6GM1m15G6nrI=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3228:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3228;20:zQyerLEJH9O0cU4dZxgZ0kKJKEkpGQDMLTf7nl3pynWcVOEhCaKMqma3Fq3Rp12C1SbTIFqUXKdYfhPm8t8KvkxCjPNZ1bXNreBCZA3FW8XH8Qb73JhjrknZDYfcifdsdNkao8/zZY97c0pticprdN9rf4tsajlHtDugWtN/z7Go+bNJQUp5iuhD8vPq7U7z1N66l0TdhdehBTqDkfiJIcm9rFb/zzj0e5iGBhl+owAwNqbCB667F0G7hf3BhgIWZly0X8sayE8N/Skf3xi6Vtxs7yaXdNqrVLZ5S1f/1377MHfy2Seo2vT8Nt/1MjePLxiWX57lBnEePOGDwS7pACrmEzFZ8EFwEeAVdeiRhD/P8fVeXGtapT9LDA8MI4JMMdDcaGyuVMU3iPjDJxyXIZCljIql9Pc367i2j+vU148AZQEeOwsCrzGt3NBR+INnGTaf1Hx2EHQ8eylJdw+plLgqE+WcQKOqt1bKnFNAFnzKElTXTzasonTXR7TFgRr/;4:i6dSdzu50c82SKWYWhjxqKDtQl8GtdwUaDnF6HLUdQh89RmE22AxHPxda7eGmIjTPEeXliCZ6mCFlBQXy+vtDOChMrIRbkHaAlvzAMETDHq19D28Us+qoRf4AC6/bI12GUL70mDcwH0lFKEKkC8sUykQnB/zFszTcwB0FlLQ5SYvTRiSNr3Tl6yG/a//D/hLXb0FJz+LY7LgdtrLtXIUjhbGN4YAwp4E0pvr0v+Q0x4Mszu4fRBrmp8tT8x2BF3fX74S86o2uRTOyW8sbWyMleWYv3fF0xS4Q7x6VuI7uKIO2A60j0xhQtzKrfxzPlyF
X-Microsoft-Antispam-PRVS: <HE1PR04MB322878299AF9E0E7B750967489420@HE1PR04MB3228.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3228;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3228;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(50466002)(105586002)(106356001)(186003)(16526019)(26005)(6506007)(8676002)(68736007)(86362001)(316002)(16586007)(6666003)(14444005)(81156014)(5660300001)(48376002)(81166006)(386003)(478600001)(50226002)(6486002)(8936002)(305945005)(36756003)(25786009)(486006)(476003)(6116002)(97736004)(3846002)(4326008)(956004)(2616005)(51416003)(53936002)(52116002)(6512007)(47776003)(7736002)(66066001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3228;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3228;23:hqIo3NzNQMdiUgtC9/yqaCjmOPZ4ZRIwyXCUosNMd?=
 =?us-ascii?Q?8f+E4i4JFCuB3yFz//k5frUSByBeHbsbHaTEcPCPBG4vVu6pLW6+eKSMo7gf?=
 =?us-ascii?Q?m+arQtEaGPj5sIEKdAa0a5dbId6XJ0TRrD6GGl+Jj7RvYbZK4v+HZ3zz9HPq?=
 =?us-ascii?Q?G35xmgGshGj93FYLnQ4cWB6JaYR21TCOIwXvijut8Ct6Rh+JfHVGAV75t+ZG?=
 =?us-ascii?Q?SOlQb6aiGAUMWAhtLuHTOEKrsfmM+zrUJWHPbCCx4K7qfhUb7bKZ0Mi2uXFe?=
 =?us-ascii?Q?A6Z3qHnDvLQGYHnetHfrsVILZesyOB/2mukeyihlon6mdLgHAfO5NSlSzkIc?=
 =?us-ascii?Q?LfgPDyltRsC/hvCwnn2+EsmyiI1NSfdAG8Tlx2psTfblJGMRxYRI2Vyuq3Wa?=
 =?us-ascii?Q?b9vupjuGLpfJGjAufYZUBHsrBVempJhi8sdCGKCpLiV1lsi/cTYpEYsl0qoG?=
 =?us-ascii?Q?xlBcbaACMA8ZEmWxVqBev8W/9F4EjjUv80gytvOSMjBDucgZgeJqNvBmAYO4?=
 =?us-ascii?Q?h/AG+lf1bjaxd1u1uldPy8K+EheM28ArleT9kulmQhsgr4XVcGYw5iA2E2BZ?=
 =?us-ascii?Q?v0+COA9+0mkCK0uHMQkNNPgcLxh2mhPR6NuveLUd7uejg7xO7P/IP7Xg4tIl?=
 =?us-ascii?Q?cTa4XGyjohzvHc1kyGJg0P94uMeo1BSsVW8tjJ+LFHcoaS4itce6vWBBh/ti?=
 =?us-ascii?Q?3K59ePSZG+U3s8To1iQsYEUchrl0Vujc5vNPAXeVtTSO8TsljmOtOBpPFrho?=
 =?us-ascii?Q?86GJVGKoJpnPuzY2KJzUWN9GSpcp7UuB+wl10OQnWGjpBHsjDk9vFXYchddQ?=
 =?us-ascii?Q?xCJih3wXnhZVgmXzZXQCXIinFOX7vJzTMeq5RN+gl1lcWF5utMEAgvMb/H6v?=
 =?us-ascii?Q?RMm/6mutocGZGTTbpkywnrZNAuyVwsbjvIwlnXmPMJkhUbAkaSa5Ttq4MzUU?=
 =?us-ascii?Q?evABKyKlVvhRlzv/f5ctKphjw2+cG6SJByNWrdnFTdo7RdtHHwPI4+udyl7H?=
 =?us-ascii?Q?qf/tBPcjwqr7M2ogq06L5uuxmhxKnO+mnsEU7F9stxRjB8T3Uzt85Yg20iEC?=
 =?us-ascii?Q?z8vlsGmK4fSqFXdv1sm3JJkSNuTxVz37fa72shFNQeXWPGX8/KfuZWLUBW58?=
 =?us-ascii?Q?w+0za2wMQM=3D?=
X-Microsoft-Antispam-Message-Info: D2gwwKOJCLHwH6pfTdpH2khoVlAQY2pyO036x8LWFx3YerL5kkiLRucZVVTkUIN1v2HDNjcufxbfOiPtKUIt2uWtzBTQpJlwg6V5/QGno8u3pZLtfQs0/1LTzhzLrg2C3buRjHkbxK6k8WzO76dMD0eOiBppS2LCDVY9HiYWgbOdubJGKPglkoAKIK6KUTq44mEzH0CbI8jk+DL2tL870AeF8/geFZlwxSTR0MfZ8RVEl7isPsZHJPXFIhynF0xv56Vp2zeg+a7BvFPoDGx/gmxxTIGaHoh8WDCUgemBup9VpWwpL8gKE8nfeoCeDnJdu3PVHl2RAdS43a6pWhNkSL+9PmmMtjDoV8caFCPwhFc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3228;6:SpS8A4Bof7v1j8AmOZ2t5jLyIdjS2gRcRC8Ons6GFr6gxcKS7N+owh/kKIwcyTp/MWSC+/F1YwVp6QGoI47AikulwRVu0IIhKgi3OoCPtnzgKRV8GorXINStci1QV+k9W/CQX+qzO5/9qalT7rz5kxO6XxEgWViKWg7gfT0qkvfiF52eVAFoyfMQaw3DRc1P5ELLr/ODpWFfBdCaZ5r3HEhntsLuEkGXv7yLGVAfx6pA4l7gR29pauphdh6G/LgqBjjOeWaVFJmtfKxRbV3xTMZhbP6LevGniN9n7BcYujKSwq2BtYvJrCCofTqdTKlvLhx9Ljorm7xMvocF4kYHzHWIIySIrGSXhIoWcKdMAz9NVGlExBvQlRWAU/e7a8ZbdIp1KhJjW7qLO7+X/zhZqPtX/HyD8A2DhiIMsilp9ykQ05sg2yFw+UXx2CWH6dkXzdplTHBKEr8jvfKgr/1bFA==;5:bQ/NHD8foKRhlPYsdDjO4gWREOAnVKvopOr+CBdUEhXs813bbLSDgJigczzUt7uiCT60vf1zytUdbjspLMDlW5Lmcy7mrUVuY6AomJfgjAOYvydSAzd2Pi9MQobWUK3MwYo8pRG+qDbbfdDdTL00rhVAxcjpaWn+RERGNI3RfOI=;24:rPtTJAHrW1eFrMdEASwA1OOI5Ge7c/Wa/VOIgaC1Fe/K1RAqxhRY0xoiK+GwD2K0Daoh4n6v8wP6JsBJOSZXgfG6XyfhlJMj5vc9HPtwy74=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3228;7:AjAQ8J2Qk0q8qYc6Kwx6rj5SrvL8uiLHQvwi98gcq+eLteQxvBRnmELGYhrY/fm0MkZ+o+UT+TKeHHMC/Inx3ybPM5K9BQN3BrbtY+1kBnGWVXCc5GpptOlzotceDqfiNDGasyudFRpzqPTrolAUVnB8fqCfpljAEoknni2NnD88AGplHw/J4HmxvP56GqVzsdHhxbiwusi1oe9T9lGL4DyexHejUELxF8Q7E79ws4+Whw81pFOpAkNYdXDnXamL
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 09:50:40.8268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954f8c02-2594-4d8d-13e7-08d5e0ca7161
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some member description or colons miss cause build warning with 'W=1'
as below:

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
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 85 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3de3281..5c810c1 100644
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
+ * @num_bd:		max NUM_BD. number of descriptors currently handling
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

