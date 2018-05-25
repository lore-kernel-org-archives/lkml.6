Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754992AbeEYJXb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:23:31 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:43232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751960AbeEYJX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:23:29 -0400
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
Subject: [PATCH] ASoC: AMD: make channel 1 dma as circular
Date: Fri, 25 May 2018 17:22:39 +0800
Message-Id: <1527240163-9804-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::26) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:Km1DlOkmAQKuHiKh0L2ofM6zFAraDDE/wSfS8BvVBzmtS8yWAPgFlXVV8Y/6TLgG6FJS6OCQejIuPHCye0KAEt7nT2Liyqp0c4T56I+kUDCmJ/QOgsnPWN32FLG8Vq/GAIKZe7pWJXsxQU/BK1ZEGRLJhwnuNhVUylYR8qXJKkqQBwJ78rqkCoeVbxZsR7hP+okbLZALryJiwrr8wGhSc4PdO/j0tvbsE6K8iu1ElmTwELGj1yv/A9TjPfRQCnAm;25:y9aZbsiBBf+ruH65wjZcNIflwsLhwVIFsVvnWPeXXlpmTR3W3xgrQSIpA6C4rjXxLT+xWiaizWXbA7MRQ6tnTB7KBxTjlG8fpC1RVNvw0/frfnIdADkmdExG9sqZy3kC2WlHb+XBfYArOMM3zfV0hywv0CHvS4Y+42NqrL5ydaFiaWP3ZEViyz8BRDsMu9UWfg41hgKuAg/ojVpwylooT/uM8+rE3VWjzHrSIIkT2bY/ZWzp1NxF6dtblAl7nHy4c3RMA/O2diTB5w9fXAMPOGTZ2WsMXL6CFFHEVRjPh3MfpzO8Tats8OMMYWcSkGn+bst8IZWjlG5MBtDchqODnw==;31:ZNekJ1sqrILV3HqQoxOGk0O1Oguaz5oE/QBMCPZ5VFplAK8i1QK8WSYTya8oUY+RfD4ay97BwCp1k2cZ1tu+pqKH8ftHVUecEAGIfot0L6IMKHPLlIqnD5CNDbbH87VRGGviMwIVCsjOKA6aAVPS5s7eRHtEez9BxGF9PjawMm50mVNWCiRdlFvB4EIHApAplfspdX+k8UvypK8a/kk7PxrdzzMdCM1+4HBCyYshLsA=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:2cPKeh1G2X2rpX29uUhUGG8jFi7B23CWu9G8MJCNR4AizHXw6YkqCoOkB4+3U0oPqV5ZWBVoiC+FSvYe6D1Dmqi+oO8MDYtKQTZHuIeze96vWA1CxPRCpKJ63NyMFOLf1dTB9EqhvaOzxyiUsbzhI9qp+T5WU6JvJuM1M4tEwC5kSJWyO+RktJtW7vMwshy+gOgIBczF0Fg+pkF7F2tBLDwpqy596ulUHB66njguV2VhTznXki2bxXWMYwpBQCGxAhnr4Oj+JZuS1aM1M32kIkFfKsmpRWrjmSiGoh6M/It9E1+u3JXMdJIC3EYqqnWTLrh11i2bJlayFaoriTYbZSLt5SDf1jr3WPnsD8soIlTt88ajOH5hkRLHQYAKTh3/12w6OZ18/+iUdsWq7Pc2Xz8m1N9p+9W8NzE2a7ozyr2UJ7N+4kFNDfF4OMmmd0aIhyatm40TLfD466sffLJbUx4yEugvBjqHEQdvbvKd6cYIalTcuLhfmeu9ORWWDEUb;4:a/VeaSxjw5jEuzIRjPJrtPhPWDWthLYYd8hnXyTFhgg1pmjqY4sbTH9IlEgpjrtTdnoJ/wn4vuuYyQGhqKoKatDYZaLhnj6XVcnT1vP4m7KoAptjy6eWEaOtHXR3dJvkpZ0XA9QZrmUpTcePZb09Youndmb6ZVQQaU5xcrrLHYG60RLZCTnIx/FUixgPm5QOEYTa/vtCENXEDTBVCd8skdgkoRxpFQwzg0muJoCLQN1CCB25V3t/syPhCICv3+VZDZUIC4uKoq1/G1wSbCo9LQKOqFa+Uym97KVR9Rddnu5/pKa5wLHEjFHiW0JxDyYH
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355E0B92A70A67FA84AC6C4F8690@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(189003)(199004)(6116002)(3846002)(25786009)(956004)(6486002)(36756003)(2906002)(16586007)(2616005)(476003)(316002)(53936002)(54906003)(109986005)(4326008)(39060400002)(97736004)(72206003)(47776003)(386003)(50226002)(51416003)(48376002)(50466002)(81166006)(7736002)(6666003)(8676002)(105586002)(86362001)(5660300001)(44832011)(1671002)(66066001)(53416004)(8936002)(68736007)(1857600001)(81156014)(26005)(186003)(16526019)(486006)(478600001)(305945005)(7696005)(52116002)(106356001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2355;23:P2DhnBuzxcDG+K3x6ze2HB4oJoOaLEiksPJ1qcoJD?=
 =?us-ascii?Q?Pf2ElgMgGY+IAM9HZRLeNpHlbk7jYK55sY+psm8k30AdNabk0yPr5VbOYWkQ?=
 =?us-ascii?Q?oaY7k0ROFBkLOhVBOfrU31vqIUkVSP2KXTGJOr+YZTx1u6UFhXF/2A/0SSnY?=
 =?us-ascii?Q?mMGHVNr25x8rIJdfQmjPdY3DbUP7vw+GBJQcFTx2DlaZZWxTWBI3YpPTMEnM?=
 =?us-ascii?Q?0TENC6+ADKgni03PjczrgHiM47gLyRtX2T5zY9p7khv07TjQd8d2gShqg8ke?=
 =?us-ascii?Q?YjfqyBAZ2sKdwtwiKktMy1ffb6j3XvFiPqbsolWIFkG58v5m6fFLXNf1vFv3?=
 =?us-ascii?Q?DXlkqSAyJRCIkZYOCHfFlOS/d4Gv1GplVtWbgth1el2t+aiTkRUqK4bKoAHj?=
 =?us-ascii?Q?ULvx8iad4KVoBSb7DkmUH1SrMzy9gTEzQUxgQdIubQC5MbuZVmgJKFmw2FBO?=
 =?us-ascii?Q?YHC02IZWbcHJ0zg/VqKEBBeHa371CBoovxEgl8pbhVPCgekOq3+XTUMzg5ze?=
 =?us-ascii?Q?wcIS0ofrCexAHd7QsXzunv1S9tklNQEdeIGo2W8VW+8vU+2PxE94TTkgeWRP?=
 =?us-ascii?Q?k0Y7wNHQ6+VC2iXjtjOqN8oGgOtWifTGvTQpmOvVkoKso2oneT6tSmd+/Z/G?=
 =?us-ascii?Q?NV374JM/wVBvcyQ9Dqfkz96IHRh+298SDJMWWkRtd4Zk53jpNVwdrwIwOupV?=
 =?us-ascii?Q?MH3MA/cFrPhhu9em5MFOQwBcqNY90jbJkO4vz0WA6kkeopq7XJmmgESalioM?=
 =?us-ascii?Q?RoCHe5o0hmZHWaDMGiB7Pw5abtA6OgaFtN2A5S+L6EgpfQXFejNFd30qkz2B?=
 =?us-ascii?Q?1gJWPg90YT+QZ6Ruzjj0kKzx6EcYIaayY6hCz/8j5ICg7vbVcV+M0v+gVCKV?=
 =?us-ascii?Q?CXhQR4shrVFByrdCr8sTdUdH50Eovfbi2FtnrmDej1/gGDclsGCSrOXGlAG2?=
 =?us-ascii?Q?xBfhe0JRJaR7GXFRcCpn5lN/vNLodYOAFYFIS3V0HvSUzApw/O8l6KL9Fk5t?=
 =?us-ascii?Q?u3K9cofMAvzwuTDgrC6F1Poz7Gx7igYiibQin4Pek3bCjh+fHeLVDYhl/1Gb?=
 =?us-ascii?Q?wBd5IbJhLEMTseBqD0/qWbs2sVmm6XsUIrP2HxYIscXAhr0XkJEmlM+gJPvd?=
 =?us-ascii?Q?AC0ksa93q9T0NpEMefdLrhl8lSHrlZlWDdq21cHi+ljwCFy9mTVgSQZmn92Q?=
 =?us-ascii?Q?Fg0ICUhxNHhnJCNbY5ut2dI2OHqlpHj/W6jadToqh8jr3V4ljjFF7ENb7WpT?=
 =?us-ascii?Q?jFFw4phzEuOvmFSv3G7Z8PRSQI6GROqxg4Xu5kg?=
X-Microsoft-Antispam-Message-Info: wO0SL54hBd2Xx01l322zbjazcG9Vpxv/FZTIfn/2S2MGO5AbihgHe62o4oKCb7jTSgqY2qQirUmxIK22+MKtcaeMNwf6K2Nd9gFUOkKwVDKqFX2w8Vy3XlXuG5mV7kCbKeMbcdbtHbRJ4eyaFh1EnqTMlppStrhAoo4dfXEzMgG91kf1AC+Sj9HrBTlzcyuv
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:NPBpK5YFFAWQZpzaQ4tjWTwT6NV66AmEjik8faFMnBEboaMnAMTRB3xr14LDdStplvOkJ59PigtpP5vdBWYJY+NC2OWefZPKg6YXUvmT5GuqmCb1JfTaZZQr0v5lBAkom0j4V6GMndkxMOEND2Bk8A/tAk+RNBqKCz6yX967G3Rw8tlR0u7EpNPPlVddnkOX2/trlcZqlspdgiBPIFqwTz5M2kr8Yi5N+UywKdN7M8FsXnjlO025cYa4VUqtudPaPl3FgALnslMNuiTSOahe/NHIJeDhsxvZdLVjLCf4aR7DxaOfh6wrmRb3wvmyL7Btn/c2DWIUJr9mXQbVHyleaAIxddFN8v/Kqh1tg5WEcf7vG1rtHR+7Y4CW6LVxG1uRF1ak4a00tXnV4MriuOSQLufo9LrmNXlUxOV9QcYzFAUjriW9CrPNECZjyZA5Yp6afwUHLcMg0mC4dXdpUeH8oA==;5:nQb6pRGO4v7WdYgPUdpGB9IL3N3BgDmAptbHNvKeaps4rzgo9ODxfppsNBuNMO4E5Hka9B+1eHP4+YZN3m5C98cTobYMbWsn01ZKIjXOj+DVY1I7ob1+F/gp9E7vquGFQiixgarOWGSFoTdPjSsWnQEPkujJoJJKs6OkAWA46BY=;24:iQzGWRgBGGVH3+0z8th168pvLbjUZL6j5sbwiuRWYNwuTyKT65cseZfSRouPBfWPj28tS3+1hYciXKkM+VFcNZ7kBQW+GvtmiGo1GVFdSMo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;7:Oh9ugz0r2rTFj2oKeMntj1zscwu7Vfx1XB5x71N/c4hEnBedn8OXl4jJAg0rsyP9LSaL3xEKlGXOvEK8lX2sevvdADNNttcHoMtxRRAI2CGGOoukJgKkbxwR3K6jUcsjgWtLFH+3BKNvjFrhf0bU+IQdCrKkr53oDyc7DJxy+/30ecoLNCLOe8AWfWJ8s1NjRvC3CdjIoHXVqfXmKBKA7jLjEj8B3EmXZAPopCNPX5Se/LmNfYJXLoEIVcrgC1o7;20:PI8o4HDL3kGA0NsxPEf+J4vaoD/83rx8+a1eb4sCAQo3KqTEvA9qOpJZEmd0Bt2gxoyQFOv6gnmK9a3SrVa8t+TyKImgzNRjRjipP4BEXHkZclMUKJi6GkE6i5sddHKvKj7Wk6lGXJ1gmyB0sGkqvwtkrD36W806tG3rKP2C6EPC2dlCi7cfiTvw/eJ1z0LIFJA+hLaxtTnNczZaipbScjL1uTI7S4rXlaOBR42ssI2p4WMZQUcopbV2WiVDnQuJ
X-MS-Office365-Filtering-Correlation-Id: 0f082e59-8a7b-4150-11c0-08d5c2212b1d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 09:23:16.9419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f082e59-8a7b-4150-11c0-08d5c2212b1d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
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
---
 sound/soc/amd/acp-pcm-dma.c | 72 +++++++--------------------------------------
 1 file changed, 10 insertions(+), 62 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ac32dea..f1d8678 100644
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
@@ -1015,11 +971,9 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
-	u32 loops = 4000;
 	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *prtd = substream->private_data;
 	struct audio_substream_data *rtd = runtime->private_data;
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
 								    DRV_NAME);
@@ -1034,18 +988,12 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
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
