Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZprX0ofvPJAzEWLagdgDXXkQ77YcaPqiLF8eLNbemMVwogZayFiO9BogBcg2B+ItORBnf/s
ARC-Seal: i=1; a=rsa-sha256; t=1526298891; cv=none;
        d=google.com; s=arc-20160816;
        b=KrfW4LCfl1QrtVYuwOx5HYeqG09Cq7HOBNsZk90yziOdYHJsEiGGvACdkdhOeJgESh
         CkD1r7sKIcgRllwoarPhgHT4i5vLn7oYLCRjS/HZS7kcvkSYIv+An3+ZiZPew12nES8J
         7fh226kCui4sHtb0iZPHce8/rTR9E9WSDQi+3/Pcs3tfpvwtGggZ/s+3kuOzje1J6umX
         gKdNTCzAgtJ20RDoqyEmy8OvdfQI0E7mVR0bBXt622LH2AGC9E2yiAZgDC6qF8aIFNKa
         uXI3ywYxhTQg6EW1w5WZSfzNdpVOYbZKiQ9udS9+J1YXje/RSvbxssnZxVCkxt2az389
         NsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BUz82NxT8aD2q6/2u6uaAM5iTP5YL9X8p9yfg5JmYtY=;
        b=087VlYHS2mswa+q1tDPLJRd6uaFg6/y/cX6mcZzVNHiYBQj4MtPasu0sVNf/22PLZW
         5fx+TIO0XvglMLIAapNIh7Y7yCTuP/pTAVFisMsfvko/dUC93I/4+6lpIM2RuXo5MJtI
         rLjvuJKZMOLqcp1wtej+RM6ajtemkXnwJ5jXWAnPw/GidHG2aT9bDmIBTm2VhSRes24S
         Gw6imqdjCT3kkn78GBqaIXBkTo1bZsu1yMlzycDtDSW8x3saDo47QGuabJj8Z/Ckf9Dh
         ueg3Tks2/0UGzFfjgzmDzCUM2wLFk++4csldasJex45K9hzVGl4ZBPGsrIHBrhpZVMnL
         UIGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=FXsAAcXR;
       spf=neutral (google.com: 104.47.32.73 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=FXsAAcXR;
       spf=neutral (google.com: 104.47.32.73 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
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
Subject: [PATCH V2] ASoC: amd: modified dma pointer callback implementation
Date: Mon, 14 May 2018 17:27:36 +0530
Message-ID: <1526299075-31475-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(39860400002)(376002)(2980300002)(428003)(189003)(199004)(478600001)(186003)(8676002)(81156014)(47776003)(97736004)(8936002)(104016004)(356003)(72206003)(86362001)(7696005)(51416003)(77096007)(36756003)(16586007)(126002)(476003)(6666003)(81166006)(54906003)(305945005)(486006)(2616005)(105586002)(39060400002)(4326008)(50226002)(106466001)(53416004)(26005)(2906002)(426003)(5660300001)(68736007)(1671002)(316002)(109986005)(48376002)(7416002)(336012)(53936002)(50466002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0764;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT032;1:0zPtF/cWZVhdGd5u9Brt7S1nJWiXjGMxhtg17ZiP5fOF97ZYQ1+fNTu3Hgj/P0uaxqsYXW8hXMpR0hR+FOu1MKYZpZGWaYiOo1l24tjbo86IExiFDltkYAoaf8TFX8SS
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0764;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;3:xLeLwqglfD65jc4GiBpaYqOSzHdentkT/xEB5r0ZZ8NQJMDVpYNyV2EudpO71grcSPS1XRB2umxsEXTxKeYbZ19jsi3iT77otEh8iOtWMuT5eMQbaowkOp3g9o+fCOH2cmiT7Lh+YAUY+ADzwATeBTTa9iVMN0Rvm+8lUHejESuE731VFpsdoTWKh7WqvT61md7o52lFSleZCU6dNXQ42kVo1/vO76j9YfkW19i7o6Ws3cRxI/fCxDcpSdbUSNa+YBATbvDDYYauEpR9UboqWjFcyy2HDfFQbO5nQ+WHGIgVaHbqYGPVZUlhDZMBqxckzXiik7DgiJucmmfX5qiMzBvX0GKst0TfLotHZzhkWaQ=;25:KxLCFm3os+pvBBMkwpI05KtpVcv1zfTprUH86mkFU1A5wTI5GZG5QXpGAFpxYOgiYQxUg24rrerIFOgPeh0z5mO7m0ouDQ4Vbh2wzu/PSeY8hSWxSU13/iG8PTvCk56QWldpNZl/ewZtE8a1icGWjMVs0AksPBDYM5vXzBh7ZUNj5+48ddZx5ujmiYRpRYvF2NhdWpegXQcGJmBBg5Lq8jwDD+TnbkU8wm/lJKaCF5zjzuNdFhy0h1i4ubgAoq5EzNF1DZKHBKHpVPfvO/itqLAI1TkVrXG2gI77gVtIZ6rNrcXXiAPLt+PaczlMrjRKfOrMhWnN1nXtmlqVPoljU6zhElRgfAVpkVAZwwmHOYo=
X-MS-TrafficTypeDiagnostic: DM3PR12MB0764:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;31:DUR3BoGwhWe1cYZnZpx21a9h1xlli5AP3F/cCwZtdSpUiEeTFVoj0adi2H0brcHgT0ohKqpDpmPnL8glnVy9X4kV3mZBsYlBdGxnTC0q3BAV089KWK6XF0YF9kqPnRd+Z6pTaClqxJ4KmrClHhQBx4u0Tdjl8Y/0MT9jNP/YAJOhsACQ3OMCLOKYtGX305HiqhSZERDT4Ifx/2nwFKehGCRW/XJjf0inWsxP1toFFMI=;20:ZZfIgmjVSp6XcKZAvzqvylIT0G72T2drZB6+IiXu/4X3QnlGm9ZFsFhm4D/Sqp2O2ujONGaO2TVdLJcEM0lYFgbPVEnTU3VevHDJOVnxe1Ug0UY/hz+NbkWcZPkhJmcf7BnvebblNIuU6a8m0PZZenEzQkc/xBIiLilh/7UHFzDGvuoVRTH4I8QUb1PWuoSt0BxlHbaqx2yfn9elByfJtUreISX0/J/4WeSMDk17sCCObXp8kz+5t9d0fhPU877+314mlgE3RA43wQWEBqaGp+0jCoDKxOshjDeePy1IbFXBa1nZ+kNdXZeHVauTGFiXzYCTOEE9JhAJ3yFyaHdbzManittzFZtnt4a6QWE/4Qm3dsFPT8IqfJj5rrxloECw9yLcJSREfrBNn4tKzFaDT3s6OEgLFHyd+enu5dYV/JFySSF78FDXMGnVxpst60gpHeYgFtkyeHgzTggV18sYJjhWpmazvjA+YhUYnvS1l9hxJDECyKHoj0RVVbfyGfCl
X-Microsoft-Antispam-PRVS: <DM3PR12MB0764B2C45BA5F0CD8ACCD1CD979C0@DM3PR12MB0764.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM3PR12MB0764;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0764;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;4:9pObodnN/DvrJ20uDZ8FqQzAmwoRen/5Vx8XtJ7pShtcpGLriUmR7/Occ/WtPe4Lycz7Uiq2howqcoGYmvHm3NNiwPAyhBQCNh7KVzu08b8ABTBJTbc1mjH6zI7GGIfsFcFsxkVzEuwdTsWmOEVSkMkgehQuOQdTLBKLhpeQiWhc4W5ky7U7K57t8l5ZzvQgINYtd28C/xaXUzWn3cR6RH7kPpUTXL6+mgR5J6Sl3BLx7Um3qlvEfSqI2fY1ClxBGiLrSyEGHb86IOF9ezxjYpZL/yEWvulCElRtGEoI1IJ1mp28Tss4W1iM+Ridpbjz
X-Forefront-PRVS: 067270ECAF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0764;23:4J7aTf149WaJg05ffJock5uF16q+CH9DTJC3pVvTS?=
 =?us-ascii?Q?+7NPLKIE3ctMHcU2Rwm2k42c73PTwlXEzY/sx6FNYuDYXreZ6V2KP8c28JRL?=
 =?us-ascii?Q?anixyJHquYqkeRSqVH8kZOfCJf0Wvoa3SYlSg2q8f6UVZpjNrySRaPT5K95M?=
 =?us-ascii?Q?3oUI1YbzbHZ+GdtanKyoO+USfsaE+p2I70MR3AaXd8gEKc8Ur6bxJyU1IPoG?=
 =?us-ascii?Q?L8O+wKVcLjZxMLZxoP0J9gPBplqyCV64LlnV4mRTziuC9iV2CZM47rRdE9p1?=
 =?us-ascii?Q?f/qHLIUtCl82oNkq6sdzDYcy+nj0GjZ456nA82r/biqYAV+d8K5n/yf1Ad+n?=
 =?us-ascii?Q?SG20F6EVkE086YLFwmXzPR61fG9SJ86Ihd74wpVVQy65rfDI+sZASHvl3M/e?=
 =?us-ascii?Q?XklO3SzhbomHy6L2lezmxPlhVxrCnielkcBpfbd37skFP00xe7uUo8lZmuEZ?=
 =?us-ascii?Q?whJM7TfDBvdEpEzSqZGRy35EsYHR6+muxaZJaswCU6gHVqPaK6Hd1ifZT9dI?=
 =?us-ascii?Q?gRv4JVLGW5Qbmsb5e1ysZg/4WiNERfFb+/EYphuVah1KSeEt1PF0FCI4CE43?=
 =?us-ascii?Q?D9gVqJsIs2AoRK9vKKWKLwuVYgJvY8lfVCAq4QwJnugs+3FkTez5GzXZK0ue?=
 =?us-ascii?Q?/vjfkezGwWJFOFGJkfKr+8f4GBGVGJ0IDiNuvMHlxvsd5JYDmW2yYpits2ds?=
 =?us-ascii?Q?AUbo/0cVnpptOWqsHRxIU0uWavBnCC7pv1TIJOX7C+cMdoEX1J31HbSy7Tkz?=
 =?us-ascii?Q?PNdKd4hUUcpwL/4WsCwwwFEPmbanFSPenggJuuBrd3jM1EnGjJSW1SX6CQTv?=
 =?us-ascii?Q?vPKA0TbJKTYOal1nRs+/i+odinS/y7xPUk+SWKDbl/SHWUVJGVVdXD8kSIHX?=
 =?us-ascii?Q?l88atPq1aefImOZpaREH1omrJazW7STNZZuxoBp1NGRqJEm1ghzBAs7K7aqA?=
 =?us-ascii?Q?g5zHuCtRaCrtmiW9I9EVskqeNw37jNqniVDbKiBrprPVweJxLO6KeZX46d5Q?=
 =?us-ascii?Q?dWHlK2vctNdW01kGguSg5MV44kPYx1yZe4DJmqPblwL4HKSgS8hcGmZHaIrw?=
 =?us-ascii?Q?27Kw8rfvoNH3NyzO6R5XjDMqP3KDALgBFjSb5ULVd3sGCj7NHOAw+rAQJRH9?=
 =?us-ascii?Q?iin2Lu4hwYettO9V9Q/FZcrBe/75c4n4Fba/gvguYzbODU5JF6np5/ltvZPf?=
 =?us-ascii?Q?Y5pY3C0RQs4AVI=3D?=
X-Microsoft-Antispam-Message-Info: pYx+/aZHSZnZ9o6uScktaBVsSO1vbHedPkCPZlv90ZXwEoKAipncAEEAAf8st3K82Xm/ouc1xpQKPzWHn6H5fe40IN4CP41FEL51OxmFhYptEN3aQ3TY5n63qq3lT9KKspIR0Grt76kWq17Y2kcvJdzCAl+kwxp7cyJzKTillnvldPQcU9sDbXwhBA7ZsW0R
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;6:jiJcdCRlsiBMWYs69wee8B5cs5gGe+FEokzdhFALEK7lMnDgNOAdCmZZb+wKKBGsLgGBCpAW4rMTxpInq63Z1DHGdpeEM2YvoGIkCViHQbiDSr4d6M9quoe6YS45TwM/LFAtRQb4YRS2w4BQa5I38kKeoq/eJqVHnc4IWHq4YI9Kn73xMzeyodsC48xRIYp4v2QqLx3lJPrxYrhbMGCeklftujuz5TbjCILUet7Wj9GVRsmsG+3hLVMdlNHJy7XOENiNDYmfChTYA5O6tg4XPGmrNTEVY9UlBKBf+5m0i2ZL4U1hWzVZmONK0hkobmSYcho8m2hk3B3GjHbcEFDNFdzK+kkHZgFUBLc8DioxJNMUfYrIVsWI7xVvLeLSM+xbXu/9VqZaY+HMLEGMktLn/iD1DZOJQnIXsXyW0UCZYbztQGeOeHSv9/OAoJOCLT9rjfBG2rHcBdTkGHKFD7Nulw==;5:KIZtBMZ/vhRruWaA844fqOTOrrJ+iKTairyvFdEP1hpr9VmvgPj9kuvVk7ihdYNv+vJ35E2hE/TqcjekPk8cj0MMiTEh9LnLef2EkihLp4lpExsxhGyoa3RpRMmfWN9VeGzxDMxJDH0ZrxJmg3hnjh0lys+ygHrx6hPbbUmuqWA=;24:5vKa6IQ3ZvPNj3cidjg61r1adDp8OK+f7kwms0h7EDTSI+7xg3KarNL3vICsT5UvXMKvz3j6M0CSHCWwjWOVchDPkYcfcjb8HgvRw6fxlzg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;7:cD18/lxip0n+BbAbFaS3fXzixRoercDyRAzDQr7lgrASPIOiuLlAjqZjKQlNbu94Binhs2HjKmMynPVLmL7GMOmYALyWwm9MwmpDi90bodkdw4Arrk+TdcC/GDEHY9da88uZi4QSQyyTl/nGqXWHCpzLm35BF8ruNEz344SF+WJfIkuzCDJcwbQDfc/fHSaNTjSbtFVVRVTkdSJvdaU+34peLtd4IV/kb0M90r+4YVTf+nV0PfPuLQCf2j6Z0EsX;20:/skdwvAtf19Rdl4VLA1WDb4ByiMU64++5naqGiJubV0v0pi6eIYiR1DhMzpXRfRtFahk1sSAGPkO8aP068qT2mlYaW0rEQI6q23aUiMQs+nDAfVLa9COaRr/Qn8OAl+J6byY02OdEhscvjK9XsLihogsGjRsQgtYwkvE4cFUvBWB2BFT7gXcWFHhgpwhzO8QtzhCkGAnjWIHwDL3mNpnUZEVyr5yDpbOhzfLjsqvZ9w1d2lBQWpEZYvhd7kYgvr9
X-MS-Office365-Filtering-Correlation-Id: 26d9b453-c634-4469-d5d8-08d5b9917e49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 11:54:47.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d9b453-c634-4469-d5d8-08d5b9917e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0764
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600440386358792663?=
X-GMAIL-MSGID: =?utf-8?q?1600440386358792663?=
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
v1->v2: removed hard coded values in acp dma pointer callback
	declared dma varaibles in rtd structure
 sound/soc/amd/acp-pcm-dma.c | 66 +++++++++++++++++++--------------------------
 sound/soc/amd/acp.h         | 15 +++--------
 2 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 906eb77..34a88ab 100644
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
@@ -854,10 +854,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_8;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_8;
+			rtd->end_dma_dscr = PLAYBACK_END_DMA_DESCR_CH8;
 			adata->play_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -875,10 +874,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = TO_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_12;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_12;
+			rtd->end_dma_dscr = PLAYBACK_END_DMA_DESCR_CH12;
 			adata->play_i2ssp_stream = substream;
 		}
 	} else {
@@ -891,10 +889,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			rtd->dma_cntl = mmACP_DMA_CNTL_10;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_10;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_10;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH10;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -914,10 +912,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			rtd->dma_cntl = mmACP_DMA_CNTL_14;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_14;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_14;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH14;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -955,22 +953,13 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
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
+	u16 dscr;
+	u32 period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -979,11 +968,15 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	if (bytescount > rtd->bytescount)
-		bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) &&
+	    acp_reg_read(rtd->acp_mmio, rtd->dma_cntl) == 0)
+		return 0;
+	dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+	dma_count = acp_reg_read(rtd->acp_mmio, rtd->cur_trans_cnt);
+	if (dscr == rtd->end_dma_dscr)
+		dma_count += period_bytes;
+	pos = dma_count % buffersize;
 	return bytes_to_frames(runtime, pos);
 }
 
@@ -1016,7 +1009,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
 	u32 loops = 4000;
-	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -1030,9 +1022,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd);
-		if (rtd->bytescount == 0)
-			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
@@ -1066,7 +1055,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		}
-		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 9cd3e96..4740804 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -131,12 +131,13 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u16 end_dma_dscr;
 	u32 pte_offset;
 	u32 sram_bank;
-	u32 byte_cnt_high_reg_offset;
-	u32 byte_cnt_low_reg_offset;
+	u32 dma_cntl;
+	u32 dma_curr_dscr;
+	u32 cur_trans_cnt;
 	uint64_t size;
-	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
@@ -157,14 +158,6 @@ struct acp_platform_info {
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
