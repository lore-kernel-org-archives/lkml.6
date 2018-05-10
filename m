Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqwQDAym6cY+iOscfxdBOd19Bu611esyMXdVQ1jUdA63/hAgasJwLOw34T6ZpcGm7GBW9Tp
ARC-Seal: i=1; a=rsa-sha256; t=1525948727; cv=none;
        d=google.com; s=arc-20160816;
        b=yAPJT8RQLgx5ZQyP7NwbZt5s+C9XsaI8+pINXPoBQYbErSYv4A9U8Mf+TISv4UzjCT
         sLVriJjaz8E7hs2i5aalCX1cKkeY7/VlA4LxOzI8fzi9KTKZT8L0/98zFp7GUz42Im66
         ut1wmXl6+Il/IWy9+RVdgMgkLQcCZ68xPcUYxjVoXSz6B0KUfQzmexTkyBxbJpIEqU+l
         EXPuVH7JUkfOZz/ZVUDm1MNOIVuR1UFncQ7Q/FW21I1UquFrAkwnhPLZk1/YgnEsoNC2
         b+gkDnwhw73zEg6GdW43oC15+/u2d0nZ5ErbtR3MlzCO/MCeLZ2H/UORnOIdc4m7+7F/
         czJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=JmnG9vuKTqiDt2ImMLCDj7l8w26WFvIMLkbj55sSYzE=;
        b=WFtUggITgQzGhPEUV84/oWju93hOdzitKhXkG/LszGHjb/6RMABc2dQZ3itk52JybH
         P5ZPq5XNm76oIvtKN2/85ORyWlMQ/2QQ+b56RV/NT03cE5Q1Z/hnLaAWIt/VeRB2xrHn
         HCTYhU5maBHEqboN8zGzJIVdMvXqHICvE1zbwjwb/TEJmeUioJ3X7DFBnskUpg94N96H
         fjwbsN93MIdNwBavshSxmdIoaFaZl80MrUxg2McEdoYe16NdvcNp9wQ1oO1L9avpH0Tx
         Op8FqK/v5KKemWAWLZrAUrW8ENgvXC73f+BnNeZpx1RsgfZxBMSbhUOirsLRDRyMKiW5
         jYCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=goA9J/Zj;
       spf=neutral (google.com: 104.47.32.62 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=goA9J/Zj;
       spf=neutral (google.com: 104.47.32.62 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; nexb.com; dkim=none (message not signed)
 header.d=none;nexb.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, "Akshu
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: modified dma pointer callback implementation
Date: Thu, 10 May 2018 16:11:45 +0530
Message-ID: <1525948925-27483-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(39380400002)(2980300002)(428003)(199004)(189003)(86362001)(81166006)(47776003)(316002)(106466001)(51416003)(5660300001)(336012)(305945005)(356003)(81156014)(36756003)(7696005)(486006)(53416004)(1857600001)(105586002)(2906002)(77096007)(8676002)(50226002)(186003)(26005)(478600001)(53936002)(104016004)(72206003)(2616005)(426003)(126002)(4326008)(39060400002)(8936002)(48376002)(1671002)(966005)(7416002)(6306002)(54906003)(476003)(50466002)(16586007)(97736004)(68736007)(109986005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0323;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT003;1:HLK5ZV8RQ+guoj9CbK+02VxryOElZiI2kZHKdbUdi+6x6yluC724HYWyNAm6MW144WEu4ezw3k0jXTUQNzq1fUGlbRB6xjKw+KVFTStPPBp5Tv02DI1cg0hMK62P1zlw
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0323;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;3:YIL7upF5CO8C5dcbvCi0O6dMQ6+pkA3JpKWNon3JxQKOr81wfeX/GMItLnUgG+mrwnYwEbWg/RdbZ82NRmpC4g829e71+VR7uPCjQUnEcEKZmCNHbtrCikfMvMfG912hvpRUuZtIsxRgkqfyGHeutGAorNX1UU5RoRZpAY6CB4d095a3GW/inEn6S3Lvy9Ks9u77BWsFNDyMvwmrVeXcI0UefT3gceSuXs8UUUt3PqolHwNR4sWf3AX7Ypn718WUWS/dtqxyV2WfrsPQEaJLM0SZS5+HbPZcvSlw8kjJBOe7tVf+zUZB2BxudrlT+rachf791u/qY0YAq8X4PUNi9LgOz7xyC50QOiUhaYIejCo=;25:HUp0hoacwcSaqL26YTaX93RGWSval3F3a/BF8CHTT8vAoA40mIvaiCN/wPDnwDE+Tan8R2tPF8aUbFQWrQCypUw1mPq/s0YIOtVCMKqFINYnr9dqSTqnlacCuD6c84JJdYhLKXgHYeFCsfxjYWimLPmqCgaTKR2AMQ6le9fozXwQxki6XzqyCSERxc8sTyheLg42gmCoTvZmejblx8VLBie5ei2hqQZaSZhAIODwgN8Hs9PvsAmIqWb/QAkNg9s3pg1xpjkjKgyzOrLmuzo8UQWbfOVjA1bpupzDNoiv7AHphOGnowd/FSr5I5Df1rqlDR2e7/04LSXYxKQFtI6zuEBZcZw/aoElQPDZMzJuIgY=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0323:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;31:aiCLkkcpnQXrPKAT7aaPi8+IVBAgML9EuhRWN+d4bLcaWN2PEJMR3haASZ2+tE9eHIIPPNIoldascA49XCQ+BACE4atMyPwEdkKFqCzQwrDjVEVaLoThRhLmePWjWguK7o9O6gNhGq4xEh9v0ptkCjxJMZ4sWbDeqtEEMskaOO2F/PpFV+MB4zoAVGHFwX7Ey7WUUA6ACVvHx4Mbz40uacsJ/7soptGw3gsPySGnm5M=;20:BYc1sM3c1Tq/3ivM1K4e7vGbByMHi0mNDMg4N6uziw68Ov+rykU7pp7atoHTfGMZuItmLX2nNbm2wBcPKlQJSrmvOffYNos8Rtb69eevVZjHhxQDOdkKvf9raI9P9zsQEaVeN93ZooUCsqIr8DhVhtVyeo+Pl+u2a/kcAZ4ckrX5BpMcNT4w30QY3oupGx83a5V8JbmmwtsWqBZzep4dvvHfD8RrlnA73bU06ikVKD1NN478/BD7UrZqnZMQPI3Cx7M/ikKVNTUMT3qrjuqnvhrULADqgK3N7pmxr/886jz8WoKqWgKywnKPGDiAno5hwSiHGvaUbYg1CHEATyb1HKGjMFkt4PZkkrxQ4Dz6aKtp+dM+nm3W3UNZt5M1PBC0JJRoQ7Uwl8Zvv3/nwooKBqtnHKxPisU4/V3msj7L6AgVky1kfcYQyHiirYjrmgFnnqfrPdf3MChsCQqGZ9PPybSPYWqPpBTmy9y2Lw8p2qSgt7+pUuhSrF5GNFrxYV8z
X-Microsoft-Antispam-PRVS: <BY2PR12MB0323242B5CE5315186C52CDA97980@BY2PR12MB0323.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR12MB0323;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0323;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;4:suibkognXpPI0ZFRoCOPBRlhuWF2K1UFKoa7uociWTagrohn6lQP+do2f70aHtTupabD0SIl/3HbZGBdQaYDvsIE/80LPVqhfPif3YUkpq0xCXdx2c1EXPmiZrotjZ1cgBDdP3xyAbBDlOLMsuMf1X589JD/vcR5xy12rGUkqDMc3k2sCnJGyKhLXCd1Yb0/8eR8SK9w/a8MAi0FaClAjbkvN5r6dRQL56oSrPn6AIGatrzckPM5eeXJ7NfElmKIexMyWMo2xlEu5xODfAJ0iNMGlR1uoeUxZbdehrjvkDdeNRW32ppAFNPw5pFOdX+X
X-Forefront-PRVS: 066898046A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0323;23:ZFnKg1j+dascXM2S2ft1Epf1o/MsoAepORDF1vu13?=
 =?us-ascii?Q?pgUJ/7a15Jv1HcnBEg6bF45+w7gnDI2EhHFQ4bmVSNDtfo08Yjt141EQGJmk?=
 =?us-ascii?Q?0sjxIZngjFBIeoeiDLyRVRnVbOkYoWAj8KU1R60FWehzHPV9FcTe3vkXW/if?=
 =?us-ascii?Q?nRTehvsEYtMKVG5YGnCHgYTTXRNzjEephuCuCtBCRihcKS4ytVpjvnx+MTgZ?=
 =?us-ascii?Q?qOOBMepgym8PsdnmGDYi4GvXU82+VnHcRIkgzMVUmjjjoAiQkFwlRL99HwYL?=
 =?us-ascii?Q?CFICeQecXpHT/rnWreN+sfwhOScXEI6aHUSWcf0sjki73r1aYNfZOjVUOtdT?=
 =?us-ascii?Q?ZEFqH2XZRhqdByOFaceH0mDxnvsPeJfz81WmKyInKUD1MaNOgKPVGBpW1Zo6?=
 =?us-ascii?Q?J88ymPKddbwUulUMUxxhW0H8To7b/EeDM+78aK2cv+N/JdxshZXQT/XGLvf7?=
 =?us-ascii?Q?R5quduHdhImQ4QryRi+iBz5nTmz39rPWDrtMqCSt3XmXawo5zYNXjeytKWGT?=
 =?us-ascii?Q?oZjgzzaPqih6Uq6GfP1GWY4obdpsCUZfBMCrRwCiYKhpiogJinDyRh0u2Izx?=
 =?us-ascii?Q?OsU+eoJhxaxihpeHoxXpvbavCskJCOWPaTDE1dENNkk55ha0Ga6Aj7aP6Off?=
 =?us-ascii?Q?O2YmEinFYPI28BhsErylQnUxG4DqFUwL0qYoNEA4gKZQ18BvcZ5zZjFUqcVH?=
 =?us-ascii?Q?xPOJhG0jB0vQYfSb+sKAdqx51zEwr3PjneLYb6mef5lgq2d6301vPoxSHO3X?=
 =?us-ascii?Q?volsk1M/c5eUI24jIGzLAzpsdDh0NnOB7bs1P27+Iljoh+Lz2+c1Dcd5OEEH?=
 =?us-ascii?Q?2oGt5XIkF4KYnD69ADVGoC1rgnXoksWup+WGSJhyz9RmvbKbraLGESUNLrog?=
 =?us-ascii?Q?akkA1/B3l0C73kF4WJ4yefAVder31F0qIWaUL6kGDN1Xdxn8CKwsZEzOWXeJ?=
 =?us-ascii?Q?GOODo9yVYrNL2SoXWmBeEEthRFC8BRV7g7FSBidGlb1Miij3bxdpKgsd9CS2?=
 =?us-ascii?Q?Kc2w6TwFvRJmO5+csfP6IBmjNfuNvWREdGd7DfYjmbkACQTNlF1nDFvDeSYM?=
 =?us-ascii?Q?x6XgZOMt6dJ/997pYUMwBXcCEizxAz1CYl6DewwQkpeqiBk+trMLH6Eb0VgC?=
 =?us-ascii?Q?0ZDrQ3b9S/G28dkZCyfFXzaqcj6WBPSXSifbZ/KdvgHwggoaEodrRsINvH0t?=
 =?us-ascii?Q?1zGmhcxTnsWmWKILmx/a9AVyKpqb2wCJQiOHbX8iHcdOBeDlfrC1wep8Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: r9LNHAF6u3MI3loj53lliShxHZomM7MEehpu2mGl+JxuS6Q8eKZMyKygFbBsJG6BSORdIburuPl+Bcd8Zy19M02UAWkBcywEwGctDwJFWr6V6BrmCI20HxFSTcfkhsVf9vp7b2IgRdGkCXsL/T40MX4TCggDELA5R8sLVokxK+/jlkhupa5qlUffNGYwl7zx
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;6:OWtCgv27vpsvxUdVHkdR/uf/9euTh2FGI+Em9feLP9RJTT4wc0Va1uCKsCy2WfJozV6Z6VSVyooyteNchzOx0EHTOVo2kuk3EZN0Ngz1BLAytXWZ92IS7dwAGYk53yAidzgjb1z/Olht+Z2S4JSClNpQKLK6gWDnKVmwTEjVq65dxG6FdhppeG1wOKdQh0ETsawSoy73CW7L7VTb65zj4mgx4Nu2/lwr59yts/KMfRol9wt3uq+cwmL83F4pM/sxQQClyvxQQe8TxhYLoxenkgsC7Yr7iWTvjLo3IdrOBSpOoIsweYc6riP1mbc6Jp+DhXHx1sxjk2jXXHT5kr7rgAwnNEmkGd587OAztzjH5NllIlMqkDYbvO9rjMXSM5tS7dKgj9tRUb1pBUMq8BrM4DCmhviOtbd1NGpL1Ye8kH5q6u6+ydZLqsi5BskNCUI50Ab3S7T1LTX4fxOk393VNg==;5:JaYb7fuk8HH8tn4yV26087oe7nuWsNEbSKfC1TaT/r7cVCgqN4Hi8Y39v3PD3L5u49E5rv6RwKGxqyJW+6VAlSDu7NxMeGN4N+D0VgTELlkBOi7yZhteRUcQqh9AIaWinhBOrFjPgJ03HV4/qq+fWKfu95jnEeXxQ6ePCk5SlME=;24:LiaTBB/2D4STNzP4SRVYbLbP89jp3tIkpfhcPA55QRgfbnAgnDREUsvVpKnxEeYkxDRpSkremNQt2jT0UPDvG0w61zU76Unr8Miee6H/8ME=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;7:r1Rj95LfG9sMnpxYHuwzk5vynA5cmhYoySvpzQOZA2nF3Z4xVSXgSXtIswlUQOhNfngsL0HkEG4ThX/czN8S694Dd/UxTdfZqK2pI8tmhmg0X6sNV7SOkkz+s4KWAE2mn368JlCv5rA7YOveyic2DvVAQLPFX+jDdbX0puNsS0U8Q7OBRCFhNZTI9WaFXLpQyMVfFyciCOf2k5REwzcIBUtqoJenFDsBQhaoMLF/fpXlixym/weM9y8B9RYiyFhl;20:xdgsrN+Cxq1TpgIFmw5iq8y+4vazos66U8fXASb4XFWxq7mx7DSzEvKzBUxJVmqK4O6/M9Vkdakz1OSCn2oTIH3PWqx/cd3ffAwPcbbOouBGKs87uguDdzK+4bCYRRBLWoOuHTyw/eben9iPrx3nc90VS8hv6V0mJhYlqfvEimkq6MjOvpDXADzkVDc/hMPpRUNB/WmgwWguwsnkX9u9dItnlj9ycKBij7oigvcD7GJthEQ5wzEa5oCEtyl2jwP9
X-MS-Office365-Filtering-Correlation-Id: ce3ca7b4-315b-4523-2cc0-08d5b6623398
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 10:38:42.9735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3ca7b4-315b-4523-2cc0-08d5b6623398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600073212546714377?=
X-GMAIL-MSGID: =?utf-8?q?1600073212546714377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Modified dma pointer callback implementation.
hw ptr calculated based on System Memory to
ACP SRAM dma channel transfer count in case of playback.
Increased min period size for playback to 4096 to avoid underruns.
In case of capture, hw ptr calculated based on dma transfer
count for ACP SRAM to System Memory Dma channel.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
This patch is dependent on [V4,10/10] ASoC: amd: dma driver changes for bt i2s instance
https://patchwork.kernel.org/patch/10385381/

 sound/soc/amd/acp-pcm-dma.c | 94 ++++++++++++++++++++++++++-------------------
 sound/soc/amd/acp.h         | 11 ------
 2 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 906eb77..969c46c 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -28,7 +28,7 @@
 #define PLAYBACK_MIN_NUM_PERIODS    2
 #define PLAYBACK_MAX_NUM_PERIODS    2
 #define PLAYBACK_MAX_PERIOD_SIZE    16384
-#define PLAYBACK_MIN_PERIOD_SIZE    1024
+#define PLAYBACK_MIN_PERIOD_SIZE    4096
 #define CAPTURE_MIN_NUM_PERIODS     2
 #define CAPTURE_MAX_NUM_PERIODS     2
 #define CAPTURE_MAX_PERIOD_SIZE     16384
@@ -854,10 +854,6 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
 			adata->play_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -875,10 +871,6 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 			adata->play_i2ssp_stream = substream;
 		}
 	} else {
@@ -891,10 +883,6 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -914,10 +902,6 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -955,22 +939,14 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static u64 acp_get_byte_count(struct audio_substream_data *rtd)
-{
-	union acp_dma_count byte_count;
-
-	byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
-					      rtd->byte_cnt_high_reg_offset);
-	byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
-					      rtd->byte_cnt_low_reg_offset);
-	return byte_count.bytescount;
-}
-
 static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 {
 	u32 buffersize;
 	u32 pos = 0;
-	u64 bytescount = 0;
+	u32 dma_count = 0;
+	u32 mul = 0;
+	u16 dscr;
+	u32 dma_config, period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -979,11 +955,56 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	if (bytescount > rtd->bytescount)
-		bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			dscr = acp_reg_read(rtd->acp_mmio,
+					    mmACP_DMA_CUR_DSCR_8);
+			dma_count = acp_reg_read(rtd->acp_mmio,
+						 mmACP_DMA_CUR_TRANS_CNT_8);
+			if (dscr == PLAYBACK_END_DMA_DESCR_CH8)
+				mul = 1;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			dscr = acp_reg_read(rtd->acp_mmio,
+					mmACP_DMA_CUR_DSCR_12);
+			dma_count = acp_reg_read(rtd->acp_mmio,
+						 mmACP_DMA_CUR_TRANS_CNT_12);
+			if (dscr == PLAYBACK_END_DMA_DESCR_CH12)
+				mul = 1;
+			break;
+		}
+	} else {
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			dma_config = acp_reg_read(rtd->acp_mmio,
+						mmACP_DMA_CNTL_10);
+			if (dma_config != 0) {
+				dscr = acp_reg_read(rtd->acp_mmio,
+						    mmACP_DMA_CUR_DSCR_10);
+				dma_count = acp_reg_read(rtd->acp_mmio,
+							 mmACP_DMA_CUR_TRANS_CNT_10);
+				if (dscr == CAPTURE_END_DMA_DESCR_CH10)
+					mul = 1;
+			}
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			dma_config = acp_reg_read(rtd->acp_mmio,
+						  mmACP_DMA_CNTL_14);
+			if (dma_config != 0) {
+				dscr = acp_reg_read(rtd->acp_mmio,
+						    mmACP_DMA_CUR_DSCR_14);
+				dma_count = acp_reg_read(rtd->acp_mmio,
+							 mmACP_DMA_CUR_TRANS_CNT_14);
+				if (dscr == CAPTURE_END_DMA_DESCR_CH14)
+					mul = 1;
+			}
+		}
+	}
+	pos = ((mul * period_bytes) + dma_count) % buffersize;
 	return bytes_to_frames(runtime, pos);
 }
 
@@ -1016,7 +1037,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
 	u32 loops = 4000;
-	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -1030,9 +1050,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd);
-		if (rtd->bytescount == 0)
-			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
@@ -1066,7 +1083,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		}
-		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 9cd3e96..b6d52ef 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -133,10 +133,7 @@ struct audio_substream_data {
 	u16 dma_dscr_idx_2;
 	u32 pte_offset;
 	u32 sram_bank;
-	u32 byte_cnt_high_reg_offset;
-	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
@@ -157,14 +154,6 @@ struct acp_platform_info {
 	u16 i2s_instance;
 };
 
-union acp_dma_count {
-	struct {
-	u32 low;
-	u32 high;
-	} bcount;
-	u64 bytescount;
-};
-
 enum {
 	ACP_TILE_P1 = 0,
 	ACP_TILE_P2,
-- 
2.7.4
