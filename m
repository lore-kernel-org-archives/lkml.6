Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbeDZLNf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:13:35 -0400
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:39552
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755169AbeDZLNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:13:30 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Jason Clinton" <jclinton@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] ASoC: amd: rename audio_substream_data variable
Date: Thu, 26 Apr 2018 16:45:47 +0530
Message-ID: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(39380400002)(2980300002)(428003)(189003)(199004)(8936002)(106466001)(105586002)(86362001)(97736004)(53416004)(6666003)(68736007)(47776003)(5660300001)(50226002)(81166006)(8676002)(50466002)(81156014)(48376002)(426003)(486006)(476003)(126002)(36756003)(2616005)(1671002)(305945005)(336012)(72206003)(26005)(478600001)(77096007)(186003)(39060400002)(109986005)(4326008)(51416003)(53936002)(7696005)(59450400001)(104016004)(54906003)(316002)(2906002)(16586007)(356003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0759;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT052;1:n3Ax6IFBnYiGyQGltlpOMNZa3c+mQmNmOFyeRFrnJ1Sb1+4QsnO2xfaKlNjQTJ3KhCq1MpypdhSDMCJbfj4X3EcCsfMbCZLUw1fhopLxsI/iI6ypnmNfXWXSRTHaDWv4
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0759;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;3:6CKy62/Kw+yvem9I1GLh6Ue09me/wz81Mrfin6uQPkaWngkbuvix8+4lcWzBcAcarKlHwrzau77j6loj8B+mPsANW4vR/hqp2y963+9qH6i3jIh7HHnBf4ArAyLGzo5IJeTuR5HyUHmqMu4zFufz719ecKo9geLSu07mH0xJ9lm0ro2ZZUgVibAtjG2ojHeT6kEKs4heMHKYw5QwC0Uh9dgDl7RSSMBwTwqpkA4tT2j1NeEUh3joxNejvGGmCTpa/6UJSv8pjCkLu4TGZx2JRgU2sNsxqHPJWhOpGu1nw3JzTrGV5DJ6yrxF/P9RGINmghH8bQW0waH04VyxrrD3Q7Z3zpb7qlNETYEkeyEcMzA=;25:UUpIeBFtAUMkSJPCEHfnCznJFFVF2YB/AQ+Af/tPj83jNgQub5Z2WUxbEhra1B25bSl4eqPLeTViyXGnWekCcpq4T2ucWRRW0tKHnucEZ2hYHJPcQlfz6Ytl2VGjq3vUUX+39rxFaUMz18y5mfMjpx8SUk3MIKHT44ovki1LGib0oaN7Ttny4mFFEx2QjVoNjSl3MaJ9N6UOHxi9FnFoCmpDEJDJvL26C0cQ6A1T4CPo0HKvwJbg8AyMgtbhfE99DnUofZOUYMljYtf3pJIufVaKtp3ODHDzb0G3CQZeSq/DO55plHICbYafXw0nS5XHaq16nREd/q+wroJfLFqdmkwjqCWIrymbAu8uI8JrFHg=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0759:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;31:CtDIPgcKCghDABk4XHE7K9mMllrPDX2hOD7UnvYN5wMTRMS6NsGh+oDFPSNeIBRCyPo85039Eyf+XYlrPbrdi6K/WxcMjxN9bvbNH4cw7fworpC/yvQ7vW7Gjw5r5+GST9aU5l+xQrnQUp2mxA2eeXSPtSsLost0vN7b2lq5VaEDpk63DITqdi71pVk4cG91n/GrOCwmf9rsZ7ZP7ueJgg1+dQsxePgqBCg7s8GWEck=;20:RMh+hXEWjkoR8ogHGEU+T8sGBmYh0jRtxwls5zxvwDtBLDwd+TMGQJqlus/yaQN0iM0JHltr9jxADRV+O/vykIvcxE38S77zV67uKCy9p+eT4CVh15+ZKetd50W8CGCAkjye+8ulR6ssq4tqIftKXhYsx1GbfULnPWS/OJbqN6wyMPwGbpmjuRFTH7XbZNp9siiHA4H4oYJAf6LgcQ+CVrb6ozAgtRdVXwwDNg320MA8oZKBJmIz9gGPVuJoo1/u84vE8SzI5OytbsKwWx1P6ciozTeCrdQEqxQ+zeJl0h8VpdgFS2fVSbFiYuDlHFjF2Az78c++/GMNTcKFFsHAwJ6JCHFIWPhGIceAOCBQJfH2e3WhZ/i3XMp1Th0KMrI9D3Wq70fnBdvcUAq6U4TT8CeF50V0Lk3DwEafbU08LZkixedY/4igwRHkpFu3O5m4o20TmghchbO1gY3duNP0zlILEp96iwqUez8+eaZ5zDeBLiV/ZtX2rqwCRqOVPXQu
X-Microsoft-Antispam-PRVS: <CY1PR12MB07592DA6876C5FF1CFE02529978E0@CY1PR12MB0759.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3002001)(3231232)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR12MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0759;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;4:cvuWIuJA+PwQUm/zpa+UABLpe6KPpagBF+OxQqJSdJD3BE5sU5Zh0jIAC4wb1h8Deu7eetfOMqgp6PA+kNxCFT78A7k1hVDQCtAisCXCJlpEGsK1VmE/8+KPrhAxfNkzspiFxP6ueYPmciu8JA03s2Bhd4pmbY4jN2Up/QUvyEZeCSy6/JdUR2nFYPQZLwHmdzLRBayB5dAaTrWUqMtw6/e49TPFu7sxmgzggV2814HVDTp/mhdK+a5k9OC+BbHWxiDR6YUumhJn6B54z7sMnMXC43wXEaMeeMRHMckG3QIOrvr+WgqoaR0KrhiuznYV
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0759;23:lBBZf/3T5KeK3+N1rQtJo7WWIaFoaVkaQJgoVES/g?=
 =?us-ascii?Q?/xpGEYUToWXqjxQ2fJ2+wW6hzld/1y3R1mRczH5mkL6p2y4wy+T8zZXP16FM?=
 =?us-ascii?Q?xZhNiE+txpDyhxGd37r9cBkk/ohQLuS3ZgkXWYLk0Gob6QoRW4KeWWRwH9nF?=
 =?us-ascii?Q?HNOuJanyAXHLHPXJNmkMoxMl61D06pHseytGouCLztZcuPSqIXbY3NJFznaL?=
 =?us-ascii?Q?gLMCtGv2kAgET87i7w7hW6WEJl2XthLCv05GksD+mKH8bLNJ5wpHSKrJRJeq?=
 =?us-ascii?Q?deWJ3TlWvP7MXxSaGBa2V1mbYmBleogI6HHoxb/AU9wRS1Ju0UgLyDbedU8j?=
 =?us-ascii?Q?bECgnxxrOV1TwdxV8InLFCL32+v9sC9jxJfIrfViysLVM6a7K7VTjL6UzFqX?=
 =?us-ascii?Q?8gmoBfNMt7NG/WsyMjEfvPMgwYFEyDUZT4XX+bJLA1nsYW+2U6P9SKJOyKy6?=
 =?us-ascii?Q?pjSaAw+SfRYS1H110Aoz78VN3my2iMbiGug6u7V2JDwlPLlowd2AtXBWEnuh?=
 =?us-ascii?Q?Wf5Sb2lwoWL5hLKcGkMojZ26U6xWXpb+uqZGWw1XG+pfkEeDnCl1aEQuXTs3?=
 =?us-ascii?Q?yZUycxB9eA7hY5uZLpgUcdtZzSIgtCxjpGMepJHM5LkcaG6D/UX/jMzpWLFy?=
 =?us-ascii?Q?ANp3GtEh/7C7JMxze5IwnmF4SzHuiDu0DAkG/onYU+qwJNLK3hwzzy3VBhgb?=
 =?us-ascii?Q?QAA7Wuw34jtEpRIUBoBLVtCrUDWFUe/2d/OrOCylBYZN1DJEVmL9F0ubOY6i?=
 =?us-ascii?Q?H9wXXDe94W9UScO04lXfpdeujseM24a+W3BioiA3hvmTFRg9NSt+kTw9nMkA?=
 =?us-ascii?Q?GA3qckuRe5EBx/zGVuAiskE1gd+/Jbo1nXKqs3I3K3St1/zmzIegWpicIdPX?=
 =?us-ascii?Q?CSiS9P7q3BRnx2r/Co/QTnUn+NorfihHR+BAYMaEXf35W7jVc11m1LVBBB3y?=
 =?us-ascii?Q?aw0WZhrqdanDQtcXmjC9VxiDCWbe4LOViMwk3zOrGE2OI9REE9K2tORQV3jp?=
 =?us-ascii?Q?Z5dpHNoj6YbFrGAnaynfwAyWe5pa4yGs1c8Hs0lQZCv5km95xcVFfCeAq6gF?=
 =?us-ascii?Q?PN57ZBd/OW9Ni54UM2kfak1Id2B9P+xoYRJDz+TOK/v9trHHP/8r6V+ZqAby?=
 =?us-ascii?Q?A4/EGIBa9b/P7afvn5mmDmMdb6wjmDcw6SktZ5XKcFr0HZnmfQIeXCDEjo3a?=
 =?us-ascii?Q?aQkAG0xhvqwygMg5WdA4aPXnzm9LaQ+5Fuk?=
X-Microsoft-Antispam-Message-Info: 0tWUWMQoSWarU//rVhOZTH+PwTp/ZCg8zxwA5nC7YQruLtnzB+U+wOig7qxDAvI2X9p8jmfJYLyjFh2dVyaDDViAZCtu7HayrDiHfI6k478BqG4H+SFZC0A2HrEcLrJZ+Rc10HgW3fwxCNaIzn7JUb4V3P5KGsRC9vZe4yMO/KMCrDgV28mm42FmPVHgvyzc
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;6:QInPKXvPIwUUnuHo+Bgyj1+cHX8TMupp5JVpKSn0M8r69IDJGGmO3NJVCgQPyDqHddsudhQhkpJJevta51R+LhFwIcv5+h/0MjvQEFwTYjkDCy2XRtxNw+KaV8kMnRraJszE0ZQlrGPd8pz9zP2mSWp0EvGcvZEp7Fckbx3fH17ZUv0Ze4swvlw9Wx+o6Gr40fTs7YjRwAyG1QMgL6zhJmnei2B8T4sTCWFcPI5M9h4yB7BWoKhvIWu7kNovmggc2AXGg2Re3u2tl9U85tgowYB28req+WGfMF+zGVcUdiveHOii8MYZ0DX5EwlLT0YTABg3HxEly0Y0RgQhMbFyx+8Xetir0274xyfLjDNSW1lNyO+YZB/dnVIAWhvyjaDkZ/5p5ZPEGcKtf8xiL8WoKfdcJThE+CmFCKWZiFJ6ecJmDcT0J+d1lR9sprn0j5n/N6CO/dJXFy7CNP2O0wAaVQ==;5:kCNepQ21WKB/8qvgaP1WawVKwmjzwABj67XRq18kaKQUB/GvLyHkyjatnl2skQ4mrNOr9JyI+B9M6lJM9cTvYdPKspy6U82pcmuXrbwf4StwEhuinp1uSr655EbhJyTllUMigfcBv+g6BlIldK13eOKggXS0NnZUxXA0np80ugs=;24:lI1fcmDn0fqttbivd0/29GD4meRMGo6qeSJxFPWX3Ri+lwg4YXbM38oyqf4eEQea+hcSj8QxgzNJ8L+CTBkHTBavZR2/W9jl30Km8aLn5rE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;7:2NgVJpVaO6fgK/79FIQdBqBVq0Xrlrr6xBSTruCuwJohGdqdOHdVAFGrenlH30PwTNZ2KN9pdybkyzCmqqbV38jkAwsaf/UwwNke0UQKocTg+a/2PVEx8AkHK7TzcKkA6UYbDZWGxMu0w/c0zfx06wQRNHgBL26uivhCv9OHkMg1xbePJxUwYFHUatTbISgaQ/sFasPflsYGNJt1dop1iKttNMy7KuavV/EoLAJqW15RmaIaY0sZVWWEgi1Syido;20:Suuilt/fIeqcPiHhR+vm9ux7Vg+KzggUgx/R02PF8v62mOjWjsPdwQ67UJgSrYV3y/nYf6Jmxvozk5I1k/crF7ii7kwC+b7L0jBOBGvAzfMra1UG2X4bMXpjfNadH98vZRzkHxESzK3DZAuJJJaGMDVEaE1exeUkXUuboeNaMmySyu7CoPAwOYGpngu15+btLmcj7GI7HP0t7tJnBlp4YVDPDlTPGDk2Zn584STvp4i6UwA7KJPaysUpJGki7qNm
X-MS-Office365-Filtering-Correlation-Id: 47d16960-c8b1-4ab5-87ae-08d5ab66bc4c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:13:27.3970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d16960-c8b1-4ab5-87ae-08d5ab66bc4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0759
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make audio_substream_data structure variable
consistent throughout the code, changed the name from
audio_config to rtd wherever applicable.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 5ffe2ef..9c026c4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -317,13 +317,13 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			   struct audio_substream_data *audio_config,
+			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
 	u16 ch1, ch2, destination, dma_dscr_idx;
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
 		ch1 = SYSRAM_TO_ACP_CH_NUM;
 		ch2 = ACP_TO_I2S_DMA_CH_NUM;
@@ -344,25 +344,25 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		destination = FROM_ACP_I2S_1;
 	}
 
-	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
+	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       pte_offset);
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
 	else
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
-	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset, ch1,
+	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, pte_offset, ch1,
 				       sram_bank, dma_dscr_idx, asic_type);
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
 	else
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
-	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, sram_bank,
+	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, sram_bank,
 				       destination, ch2, dma_dscr_idx,
 				       asic_type);
 }
-- 
2.7.4
