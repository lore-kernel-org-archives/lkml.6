Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbeE1DtU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 23:49:20 -0400
Received: from mail-by2nam01on0083.outbound.protection.outlook.com ([104.47.34.83]:9622
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751118AbeE1DtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 23:49:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-kernel@vger.kernel.org (open list)
Subject: [v2] ASoC: AMD: make channel 1 dma as circular
Date: Mon, 28 May 2018 11:48:22 +0800
Message-Id: <1527479306-12658-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::26) To DM5PR12MB2360.namprd12.prod.outlook.com
 (2603:10b6:4:b4::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2360;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;3:k7kF8Cvca7ncYvHQjKAec/+5H6aJXnyf70pMDtDnAHqgzO15aOR4VkGL/ncRYAQVn8UaJEPI25PCr2NCdT/22nlxO2AEYkEo3VqdC8PQ/xa8VdZIxR09u6SoCfc4xEVPTbelsdlINs5+lhgG7dxKXm54WZXvMgt73U3nI7mw0Jm13nSSptNcbKhYHxx9oM7e2CJmfkSoMpD6obJW8t/ouWmYNjr0dGn3dkq2udugugfXEwHV0cAO4pToeYFKwHsW;25:7PY6Qj9QhTYYJ8VZ1nVjs5l04EZHX5hpf4kD58SPhtR5H+/Zg/mvizJn4tdG+VnTLPXXLMzzXFrGgjWZi8UVbZUpG1zl0XJPyp6pb8F3llkoxpeJ2z8la4RvkqPiu2F9RQiuxjbOqFWpFqbM11SfgqQpL0hCJwm1gMmh5IqOHp0dyldPU4QPK1urgPDbyZGdGMmYFB6oPS4lMFlbDCXm34CJqIDk0P5mWQRmqLzCUZK6SIbr9gBX8U7ViBXdOkMsCS/djagzB6JgqxygIO55Vgt5V4mJlMoCibAxFFAJaofT3Rdb7S8+Jcttok+VKHabvRFpBupsIEPuIo9v7Rke3Q==;31:VIH5fE+G6LbV1cYzM8XsW5HSfubpeBSqX/Z+IymDccpRjDaPyF5Y9BN8dsnPLDnobrqtpVLuaatqxwOIyRtni06cR7D88X6P80gQgCZM4l5MqR/28GFg5HD2uYj7/m6YrbyngfqZG8VKwaeH6P3aijplkUsN1WYOSQNEl5EzgQP++O7vPQSYWV+b9e8a5c7lfHt1W6cqYiKUyNhEHmN2VVILbch5JsyM/7xK28fx0vU=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;20:5Of39tAThEHtJgA0H8kPt2VcOK0up8haD6nkncUgy/K/kBc0tuD2hohhYEEVbiFwYeB1epi0RJjvj7C+wk4Bu8nLYIpq7QcaFPaT2fboK2JlVDlaIeekQpI0rPg1dbVv52ELslH1TBiUJD5zXjiQLpb3wqLfV/YJso8fCtCJIKIFixDhJFIGv3fxrwcNnLzjutTKfCoP/ssd+VXk++eZW5Jebm5R28UXhKfYcwYCMwVr1f1DGG6NZCxTsUk4YL4tlIM4pdRyHGi5u0iKAvme5Ntt6sr3iDiyxJEsWCIMK8wJp28nhqVAlqFu+5650r/99gi5GPdy3Lzik/LlQ7Qs60Ro8cg8X/IRLcoQMJQOrX2C0w82/Ivt7oBezPnQfD3rMeXieQa2Pg6PMQuvwxL+C6lECAU8/FyzZBOU2/IRwyQTfcMc8zW6d7geGGqhZmI1Fwhuvrvw8vH1c5UEXO73sDTKJQEY05qKhGRwBKCJcKhYnOM0VuGeR4TkMx3dn3la;4:3UkZwQtys1Gta7N+FKQ8wtISPEwRm7FWw2Vtg1JCHj79hxMkuWg91NDGFEyGupWhjjShwJEmucSAs3CMGsetb296EC/z//zslE9b6wtvjIEBPCOGjjl6OgZMFcXWlGpEtgKCsQRcK2fPpKnIHgtL6/pD5ejAC2Hi7ahnTYHiM9mfasCPCqAagzPtml1UpKPVABpEYhE7urwcQsR17zZ1tk7NRJbn2Y8q/2enJxS9OP+hr74KjqNJiARn6rX7RwHhJM/SQnQSIROqL2R1CiKpIlNUEzlf/a0URTZTUuex1XU4kR072Kv0Vp12YcyZJ9fN
X-Microsoft-Antispam-PRVS: <DM5PR12MB23609D3E390E935D5729B4F1F86E0@DM5PR12MB2360.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2360;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2360;
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(39860400002)(366004)(189003)(199004)(26005)(50226002)(2616005)(86362001)(81156014)(52116002)(8676002)(2906002)(4326008)(476003)(6116002)(105586002)(956004)(3846002)(106356001)(48376002)(25786009)(7736002)(39060400002)(305945005)(109986005)(50466002)(7696005)(6666003)(53416004)(1671002)(81166006)(8936002)(53936002)(51416003)(66066001)(5660300001)(186003)(47776003)(16526019)(44832011)(36756003)(486006)(97736004)(72206003)(316002)(16586007)(386003)(68736007)(6486002)(54906003)(478600001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2360;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2360;23:lEmupK4GRwYLdfLk0BBpNkmLCjFzJGKDNn+skW5i1?=
 =?us-ascii?Q?4FTWotXUONpZTI23QxKueH/SP1MxWpP5EQSrBA9QsdSSAMx8F9Vno/qTsNf0?=
 =?us-ascii?Q?ZHooBDlJi3UEzg7WhTuGjVywskDc1C3LCrqpNzyyDGsUMFyDEKsGs1Yx7HIC?=
 =?us-ascii?Q?Sa+rL++XCWAojHp96KheCfD3BsMcf1ml0oiL3k0bVXJLVdxI3Tmi0C5MBt2b?=
 =?us-ascii?Q?Epu++SpdS+1xmMkVpRccshKwZnBFvkYtvqmKBxxXAt3kOFpOS68wiSXVtDym?=
 =?us-ascii?Q?VGf2Z8whITn00ODaASnJ+jbaSQn4ATbtn7oTqWmnCzJYWhJepK+N+Cylj4wv?=
 =?us-ascii?Q?pE2/tOdfK2RPhxL3R4iIyGOpja1AeqMLM/yuyNQoZkwedMJyldwtbWIYdbc+?=
 =?us-ascii?Q?LYdPMoxP1hTJzHrxNWVWqAP9k5tussAkV0dOk2Nzjjh2NgkLBkOdeQ2XHAqo?=
 =?us-ascii?Q?iAEAyW2zpBvmSaOoUuPuK5Y094W8DxwznkJ/silotlrGh5kWHcenLwGemEvK?=
 =?us-ascii?Q?QfBqSHkRLS/Hd022nnu/Q7oBkMQn+kMhKnUdlItAPGGzMflwZRFHIwqPWpUf?=
 =?us-ascii?Q?1lC25a5k2Uj9JDQDHwI5Bw9TlhgTQCX2AkXd1fF238xGVNAXtRVWbNVNKfIn?=
 =?us-ascii?Q?0+JHF3Tp3FT4SK1z483WR8x3cfSYw3f52Q6khaIBJvFpbwFT9k4QyMx/omMV?=
 =?us-ascii?Q?W6pou55oCuEXD7TTffndnESSAgSJ+19T0/o+ijmzaNVX0pMYKxDcg8VY1jb3?=
 =?us-ascii?Q?r5N9vLZ/SblHQ9PKXpNl09Y9AdY5saV1y0W+NwGF5Gw1ELCabaWAirXaBldj?=
 =?us-ascii?Q?tVWHsqTPsWmcDkF7BpjFHG5voqY6yVtd9Ms/h6UHdkdgxDjLFjFxw8rt0CIF?=
 =?us-ascii?Q?xdRouWEmmLug3iTE/BYz3zxKCYPcI0+gGnTJXH5vNoMgZ4VzeQg5pS44eG/N?=
 =?us-ascii?Q?ETPoBIsW67wZ/wDdohWJBMznOlZoMNA35JAEUmCRH7FdvA3ugjdheSvB0ram?=
 =?us-ascii?Q?QfRdk3H7M+fRZi93kRuIW69wGcpDvntrC56+TLprNexc9DZbNP/anXn7fprg?=
 =?us-ascii?Q?a2WD/lQQ9F+xnedX8GK/ojlmaQY2XQ2z22p7ZeQCcL28k9DhOCn/ffOqllas?=
 =?us-ascii?Q?jlsnEVa0cmChLdFzy5Vz+AQlIXWjQBaqCq0ZAjVvGaJbKxVcEneigYn47/Sk?=
 =?us-ascii?Q?9irP7WBhkMeTvKb4VwZiwl6k6UbpA5gKcHyqQFt7MJgucl2u3mqHbWZ2sfke?=
 =?us-ascii?Q?ZOLbyk7n5jQPXyQ6RQ=3D?=
X-Microsoft-Antispam-Message-Info: YmTvo+KFOpNdVeHcKU8eBGolzk2cUqizks1YqTndnmmOX6hSVR6AF3IfroA3P74s/qa/FR6sVY4lJDDZ9fSJA99YvWboaMvcr/O6YIHn21TR5YuUlEqp3nA0m8DqfFny7Xr6W4Da66byaYIzu6XhDW0X2n8pzsHarKVGhdWDiO24B6rtjtu59NXPD6/rrbCI
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;6:9CYOmPguhqcLhknCTLexx/DIcQ5+A08BxXdHg9Dn+3UinwgeDhucSxtzeJJ3LEu0CTxVEpBiww4aVeGjHZSCscugoVXz68Z/C5n2m2pidXj07/ll3Euoypruq3UXKX4A/7yrHIy4pARsZRNPt3FxcjhqjxmVXO1PRbR5nrpPyv6KWjdH0kRR/3WR2hxP1K+cSjwSXvEC7mMsqz83HgAcw+D3LF17D24zvFJh9bku8ewh++Ghuy87aKeqhPF/UE5FojT4hX/X4MP8qNNVP3ZhAXBrWDTYhXo7aYCKBr+d5rPgauT6t9J9sJNl6jFKlCUMsiucvp+7O8NAqzxVKKdnODzwuQrnBHmKMhauoJR4C4m2L//x13O8UEBSyJcHRCLZG8gstTK4ty9HH0JYYMDTdgbBOKOiEK5Ge3I0/0aamofvP8+FznHOwxyhOb/0DvHNBqrYfbZkguft+AYf3at3Mw==;5:/j9uu/cNgv6RM8ySOa5bJfaNW7Lwe6tSwfT1C8UXh7x88YX1FE+6LpNrPFk0iVQbfAr+Nb8c6D1mUm/sIoNSjnq/UWCWCNXDHS4ZJ/80ZVg2Qfbq5e5x85YzgZrkQe0fgpYH2eqpombK5i1MgLl7tsx6lM2IzUjUI+txalSahGs=;24:4+LA8UTzfTIyxUI9sVRi6b/98epvAFEhheCzOjBXDe5X3TUTpIiaKTkCZMVL0wEMJftw411xyezjfYgMaa2NOcivORuGjaEmuaFVA91DSX4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;7:7p7JEx7384SFqiByTnStlBJIAxyPCHyJreM+1RfviaVvLCJerUikrtqB/6g1HJ6NGx5LR2WmkXxC4m8pe4T7spu5zc+8mmCLcy4yvnWUFJdIdFzup/AKlIL/56CkubkHRwXJTlffPP6Nq97R1hG6YnAqiF6AkO7oMqfiQQTVu+adXSl6rqKwMAzfYcJGF+XPI7QxJkOUuHoJJH4wztVZhidg4oxSoWWijQh75WW+noxCyf6hpX2LgtkFXUuJZ4A9;20:BP35p950V2dP/VKPjqQn9xaWVozk3Bc+B09iIaOM7qSgctTJAgyjksTAeb3xFPk0BZhVvV2Ueg/jOftJ/T1WOzRNxqi184IOuklOfUyvZkdip8z9puHmdeIJteDb2VcxpozODF8WGd30MoKJb+b3EZLPo3AZ2SIpPnhgxcjEanVQEYrSt4EYKeCFKckebNQGKe6ZMom4gXFfXGEZQp4KonDAsa8WfNkwhP8+bR6kDTHEkRux1DImr02f6l7sTja0
X-MS-Office365-Filtering-Correlation-Id: 3118fe6b-7d70-4c9b-85fe-08d5c44dfbba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 03:49:07.2939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3118fe6b-7d70-4c9b-85fe-08d5c44dfbba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

channel 1: SYSMEM<->ACP
channel 2: ACP<->I2S
Instead of waiting on period interrupt of ch 2 and then starting
dma on ch1, we make ch1 dma as circular.
This removes dependency of period granularity on hw pointer.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>
---
v2: Fixed kbuild error

 sound/soc/amd/acp-pcm-dma.c | 74 ++++++---------------------------------------
 1 file changed, 10 insertions(+), 64 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ac32dea..7720384 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -337,8 +337,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
 }
 
 /* Start a given DMA channel transfer */
-static void acp_dma_start(void __iomem *acp_mmio,
-			  u16 ch_num, bool is_circular)
+static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 {
 	u32 dma_ctrl;
 
@@ -369,11 +368,8 @@ static void acp_dma_start(void __iomem *acp_mmio,
 		break;
 	}
 
-	/* enable  for ACP SRAM to/from I2S DMA channel */
-	if (is_circular == true)
-		dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
-	else
-		dma_ctrl &= ~ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
+	/* circular for both DMA channel */
+	dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
 
 	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 }
@@ -617,7 +613,6 @@ static int acp_deinit(void __iomem *acp_mmio)
 /* ACP DMA irq handler routine for playback, capture usecases */
 static irqreturn_t dma_irq_handler(int irq, void *arg)
 {
-	u16 dscr_idx;
 	u32 intr_flag, ext_intr_status;
 	struct audio_drv_data *irq_data;
 	void __iomem *acp_mmio;
@@ -634,33 +629,13 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_13) ==
-				PLAYBACK_START_DMA_DESCR_CH13)
-			dscr_idx = PLAYBACK_END_DMA_DESCR_CH12;
-		else
-			dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-		config_acp_dma_channel(acp_mmio, SYSRAM_TO_ACP_CH_NUM, dscr_idx,
-				       1, 0);
-		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_CH_NUM, false);
-
 		snd_pcm_period_elapsed(irq_data->play_i2ssp_stream);
-
 		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
-			PLAYBACK_START_DMA_DESCR_CH9)
-			dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
-		else
-			dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
-		config_acp_dma_channel(acp_mmio,
-				       SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
-				       dscr_idx, 1, 0);
-		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
-			      false);
 		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
@@ -669,38 +644,20 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
-				CAPTURE_START_DMA_DESCR_CH15)
-			dscr_idx = CAPTURE_END_DMA_DESCR_CH14;
-		else
-			dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
-		config_acp_dma_channel(acp_mmio, ACP_TO_SYSRAM_CH_NUM, dscr_idx,
-				       1, 0);
-		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_CH_NUM, false);
-
+		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
-		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
-			CAPTURE_START_DMA_DESCR_CH11)
-			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
-		else
-			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
-		config_acp_dma_channel(acp_mmio,
-				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
-				       dscr_idx, 1, 0);
-		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
-			      false);
+		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
@@ -708,7 +665,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
-		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
@@ -1015,14 +971,10 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
-	u32 loops = 4000;
 	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *prtd = substream->private_data;
 	struct audio_substream_data *rtd = runtime->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
-								    DRV_NAME);
 
 	if (!rtd)
 		return -EINVAL;
@@ -1034,18 +986,12 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (rtd->bytescount == 0)
 			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
-			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-				BIT(rtd->ch1)) {
-				if (!loops--) {
-					dev_err(component->dev,
-						"acp dma start timeout\n");
-					return -ETIMEDOUT;
-				}
-				cpu_relax();
-			}
+			acp_dma_start(rtd->acp_mmio, rtd->ch1);
+			acp_dma_start(rtd->acp_mmio, rtd->ch2);
+		} else {
+			acp_dma_start(rtd->acp_mmio, rtd->ch2);
+			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
-		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
1.9.1
