Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZqvMZxChAUk3x+55WudWempwdaBU/lTbx62yc8jhEB6g1yaXZGunp1cesVndqaDtkKILkPp
ARC-Seal: i=1; a=rsa-sha256; t=1525754783; cv=none;
        d=google.com; s=arc-20160816;
        b=vFSo3qL+uSNDZPJRDoItW+BTFWfwVYyYO1rcP4n9uHjqYxE1N6Tb4eqq6aBuQwssF3
         a7PivrN+f92R21mDNsCLQ184IiF3DRKzzlzJDjCQxMBsY5S+Ek4Yqji4hAHOZFVk2Gc2
         ahuVhixayvdBk2aSEWbldUhpxBJKsEocxRYnozvOL0uWxgCCml181aCe1w62gsJYJidf
         4vHcLrTsD465KiirBxxXz7BvpDMXHsNr3ebB1tuGYIq7BZorRwCXnENXRzBQ2O6VW480
         S6YN1B/RpA9mp8D7ppv4uxi4P2oJVXxLCXUukNTQQGSvVmgmU/8/1wUy95mvVWiodv1m
         SZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hug+f1PkxHWLTcZAPsvjEKEapIGc7tyVWeUuwvIOarw=;
        b=u//rNmSBYPCibvGkU4ztXuiQqCc39zyJ9NkTVDdJwL/4JbiS+5A7JJYi1MQzmkbMg/
         vokfB9zNTLiuczzLgoCLZN45KDAjzxkJ03ELy3VSYrNRqweaDEj6M/rsW5ObexsAdVit
         9I2yYzZCzS1fBMsFoE2XdFAJhHQyJdu7/RqqBNSwtszuQyUHcZbjAZTwPnPihhhdqwyC
         NQCvsBcg2k2oDGEVD4XgmdRCajAOFDYeOxd60Eaq4flit02ouHtrw0oy8MHa07qdiXX7
         0vPRFOu2DqKSIPwrqR6MtXiI+G90xjSUTQxDf6sAfmUPP8qbjQ/juUv8BdtlumnSoubv
         vHJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=RqFitHnI;
       spf=neutral (google.com: 104.47.38.68 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=RqFitHnI;
       spf=neutral (google.com: 104.47.38.68 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Daniel Kurtz <djkurtz@chromium.org>, "Akshu
 Agrawal" <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] ASoC: amd: sram bank update changes
Date: Tue, 8 May 2018 10:17:48 +0530
Message-ID: <1525754888-14124-5-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(346002)(39860400002)(2980300002)(428003)(199004)(189003)(11346002)(47776003)(316002)(53936002)(105586002)(50226002)(76176011)(2906002)(36756003)(51416003)(86362001)(7696005)(104016004)(6666003)(53416004)(426003)(72206003)(97736004)(5660300001)(478600001)(106466001)(486006)(476003)(2616005)(446003)(81156014)(15650500001)(4326008)(77096007)(26005)(48376002)(16586007)(336012)(1671002)(356003)(54906003)(186003)(8936002)(305945005)(50466002)(39060400002)(68736007)(81166006)(126002)(8676002)(109986005)(172123003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0761;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT039;1:14YQ39Ep3UYSS73jFfKZ7zCZ1XulOOxtTmi5KIIZzsTfbJ6C6vJPRPNlduBaIzKQ+fYU1FiOhkkrrNoIWi8uP/V90VF0963y7wn1jOy98sJlYr4/jDhOPZ9+OWJD2/LZ
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0761;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;3:qZIoqbAepT0s0/MBui6XXFLPiQMRMahh3r3ZmzI5qFX3pU9FFipc5WTBT/u/r4Y3Fc5bptT+WFwgK9IlW8aXM0sISxFxf0zO2rI28nQQbpoPOyGoMDvuaHtv4wzTjH/AndNTii5ZpydGwUDud4telZoTDzFRSOaphH5PhQn6ia7KOZOVLxxbp48cV44/RZHDpV8WXWDRRq+RycbJvAAb/Z1pNy203OORyL3r9yeaKzq+ObmPD6rLI0IK4CPlaD8LEUqjYLoMF60Nh2XhQ8NNWkgGaK9czqPQvve0zqn81idi5iaBIVeN15hJdlnTn1fg01T06yeWpnf2Okhf3KIgFcIXaxeA/OgsLicmEB6QqGw=;25:dP0lAHQ5nuWdJ/8qsDZjq3nslIbq+l3MPPDMVuG2bdTPgz8kyAj2F62W9Y4QYcXhobViLh961cFp1gLWd4kMMx1IoNRpT5p8qh2IQIshd0zhPa3RbSRUuYJaKN8l84hJRIVuHVdBfGlzvIBfNo8Pbi/ovkHuqr8WqSrpQkDzdXJe6vaoAK8z46QUhuAG2iVqCZ5hZ9Kz7/UoerROwQGuy67JtGUoJ1XohNo5i5SkZSXxqDPAuzduzydSB+fy60WyxnyP6daBgaSTfhJN6CfpxSQgOFQ3K49/gAw9anZgTPG8EncV8BQaVQXMiRb89PEGU+x0vFJsUzwFP35qCxFDVg==
X-MS-TrafficTypeDiagnostic: DM3PR12MB0761:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;31:vQ2FMrlknfz8u/fcVMm+ZkFZmTt1Y8YCMYVYnAwMrxucIZ4U2SUPFin0KN4QwDw03IYgI/XbFBXAjxZknn9SiSoZsrLPigevCOgC/ovObwkC2RzeH44Oqw4I9wvZCY15MkRTFzoRs2tSZbp7xcCyKRSBCLeBVqtveqKYjcfoIFcvk4doNPKic75n/NWMUtU6ombtwsQ5UWDcFgvHN9TWeNBw98BuZsGxOem1ckeUmXg=;20:bcjJo7RtyHuybubmLsHHml5V6m9SNBChPmzBgrUp2Ll4ZNd+Z3O6A4R1oG/79lXBTQNa1A3PgyQuMOqxqBV20BgTgnBP4NS95hKfkeZJPp1O/GpYqibWOebBvoFMzpS91vpm40RNqR7E4TYBgygIueB7PGciRUSNkznpp8p7xiNsaivCu6XvYqX65D0VJJknoNVlLKjJLAjLua3OeIrxm9UVQVBrQrwjByXvGAUC0GEgUugr3iCmiZYGvH+tRDIeisqcpvWzXxK9EN1WPpAoJ4qJiOvedg0LsMQk9O+GoyO2xyq4hAZMSxLTynNfYludIM3tvxUHq6hBtdTYJCWjy3NvOl2zllWEo3D2xkSUb9UjDJwv1+5/oMiHCwYgH4JOfxkzp/d5/nIKX3VFJoCFOabvS44kifi+v29icxvgZEL5cOyBsOU1ehZeFqzmE1PPa9xbvbjiwNq73jXonWYflWGpx/loTT5Zn2cZRs9jJa2DEK+pBkeSTgCt/0/BL0l0
X-Microsoft-Antispam-PRVS: <DM3PR12MB07613D46EED003EFD32039B3979A0@DM3PR12MB0761.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93003095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM3PR12MB0761;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0761;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;4:iH94U5CjBKjeh4YhphmGjkl1dwaqtnkxTcJSjcGZebfoaz0LyIFWbsHztkXaz39Ikg7cQqkN5RlHkPHOtaxvxXgmByh/HyGOst16NwG4vGRh1xkXIEvYgaDf+rVgk6u9iCmqMlUKRb1KMo4bl1vN4zE1BXjZJDGK1+fvrPUm31Fcxy4H9/G12IkgdCbD8jiNGbL0Xkye84K2UeS5J4bMrMkXXA6OfLObitCapcQH/qGNvs89DVH5F7VNXeggaZWoppSfrZIkDcyK2HP/MrzTOCQY0Dh6qyCVvq3IG5mN+86wNCECrbpnQ4hARcE4r9zE
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0761;23:E1YBi+sNBdSWx5DV8o/R3dZsFT1juHZKuSaEYJtSK?=
 =?us-ascii?Q?g33NAJfvDMDhzuuzisWWYcxJeZ1Gbm9RkV+SOc6EcdnJt4KOLW/Q3+W73rsK?=
 =?us-ascii?Q?SPHWcWmq4sUPajxxGF8hMU7wrZKsPLdSUIMx9lUSfOSXzZINXVDFd2ZIwLy8?=
 =?us-ascii?Q?U19y+DE6au+MXZ9ng8vTzxFTUK5yjgpS3zIrXXshEbvgNSixTbQMINJ44Tr9?=
 =?us-ascii?Q?xS86TX5XBqFxiTZbXy9gyYy2tQ3k+U709rVy6YlnYgRnoTTAVFH3F97z+XGb?=
 =?us-ascii?Q?wLIcKeQmDCUXsfZPyii7xM3Jd53Ztqx2POc0yHRAWcUQSpLvmiTPL5k1jF0b?=
 =?us-ascii?Q?Boh5CwReP3soJ+9R4PzONCspTzCH7UVhtMzD8W07bEd5hM8r4wyRCrvnZW/J?=
 =?us-ascii?Q?cwCSlxAK76YvkrI7wKH3Y9IXj7F79sFEgW33p3Y9+gvlev9AlfEMaM+7qYfH?=
 =?us-ascii?Q?hDcZdT/a2ODGGFux8+xMYQ7g6w4UQNErn7bGeu7X8pcjNH75um7VOOOKgVeQ?=
 =?us-ascii?Q?a6sYvw34KQiene22bFgdcHjZD7dBSSlpqIL5uBKSt6CwcDqOCVyBuj63eNME?=
 =?us-ascii?Q?joT35zAIaYPR/FbzYgqNFH0J3P5cjZsVd9EgiiC6dNOCND2W37mhEpU8oRlb?=
 =?us-ascii?Q?bkpv67WW2X6vJjG1hw3eoW61SSpT99U0kV/p6JGP2nJ7b3HUao88r9HYvKQa?=
 =?us-ascii?Q?1SCYq367T+R9VQbkrzsKQN27+ORCw2NH9IcHj8EsI9Ji50V123yAoymCYfCl?=
 =?us-ascii?Q?13N8z+5HT6h9O11F1AIrUEE8IPd8UsLp6v/wlkEdNzs4yJuksEBK5m8Q/ew4?=
 =?us-ascii?Q?Z8wD9J23xfcVxuK0pNOc1/4kSjU7fY20i9yksKqycApcQuI2USdWi9ofJI+s?=
 =?us-ascii?Q?ObfFbiIUNcAfkrjSnovWzLAoUDoZhF66hs8VuJ5y1rkqpuOUBz76b56j07hS?=
 =?us-ascii?Q?dbG88LlTYoi6qZvtrH1WIXLjTRQv17zaKafDu0cNmQJpv2GELEbIvurj/+m5?=
 =?us-ascii?Q?d7H0RaFAw54yl+kgXLSOlXrjw5salllQCKiM7CIu+QcDbFzUz+R9ingAMI2O?=
 =?us-ascii?Q?6/X9XAzAdvW5pKwjZFyn6dQrPWQx0pSlY0Jd4an6cGacAIpks0/tnLhBPcqv?=
 =?us-ascii?Q?GXXMeE/wg64wJSg7USAcX2gqof300PnAmkV6R4LE/38r4KYa+Fmih1oP011V?=
 =?us-ascii?Q?w6qQk/yzubmEiEAg2SctUHxuo3fKiSxBtzvuN4BZQYzopz+/uMmCDw73NLxU?=
 =?us-ascii?Q?EX3dDVREHvIofTHyIj43nKzzexMaEG8Z2b9kFgO?=
X-Microsoft-Antispam-Message-Info: xSnW5cc98+iast08Lw/m6ogmJdW7JNIUlZ/sawtrTA/gOkFxZKdGIMOqE5vfWhTXb9610aWf/jB6MmJ1t5I9cGMjZxL4ik55bqVdUupa2GhD9k/nNGdyCH9MFRiuIP+lTv0G0OJ79j4siCLRg62ivNwsHysItlWtAJYYS5GpRtYEhd4r/TKIDRuds7WiTjaR
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;6:t0uErKRaMrjpcLuhXuHkjDK15hsmQklJejW35zw8McIcQuGlV93mba7nVlLdF1hI3I+MRxdSfz8JTfoBvYvrJo4qVgOznWFUHi1HLgPaq6JQpw90+oRyoUuens9SYDdxjv+AuoEukiO9RijY5OZRrBeYApJ+sGs7p8d7yR0tKnZaqW7SwNOrKmHpYtMdU/5lQhrybr90apm0C6gHKW+HwwRWVCiX6qrpPyH1eTEAk3SvKECGSghaW1N2uS5qFAAvsFoW5sWwm7KfjoM4cogLjX8o2oNlkkvX+vVcdcHaX9wrFGPhEm39W/2HP/hN2ERxainB6IPdpwPO25KOU5vGN2NPkEzzWV4uK89MGZP7/NuwQvwRzh8rh0trBJlBmlaWM8F722fpNrD2xtyN3La+cxJAgWsglHRvCbC00mD5sg+3k0bU8Et7UQSUIFzzr7sd2D+ACG7meIRwl5W6tSGhWw==;5:T/sl5Cggnqq2en0FBV7xjPBold+Sn6meT2RsWkkFSTRRIe6Uvp5TRp9X9HPnujZQAquWdWEfXdm5TWMQa4tOOCDCs2CY55LZ8baZI5SUUcVYII6FS2UabtMO2Z5Vcxe9iYAOT8YQs9lBOQK0RZn8dHzmu6Z6XQD/svbUOqtb12U=;24:HYhkswvfpN5B+QclBz+FVw9XIFZLziR26JZKZ0wF4fjEaMe0yKqHjv+gUr9TMA+VSB5EKRMLNtvLfp+oTVvNiuWxnP67rBoYDMR9cprvJog=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;7:GaORyhFAzttHQEfHLvpuCny5CFrgpgSz3EDNP1QiwEamnu/0ozu/n72gRVTX27FZTRgyhjdpGYKgzXA/dBYgFyJtZqVSJHPqAFlbExLYtT1phs+uqLW/X0/uA9Wn/hq0rbO4BOz2hgviraxB18QPjlqhExjO09u9O766S7mJguf6SR7C7uECXRt9IL7GZwbDt3/qtWNkKp3fCuc5RF4YzAPdP0p0Njl7FQX3PAewd1B6gArtZg+E+Kwsk7Y2oElU;20:nG+VS5Oa0ivN90TWyaOxIBpN+uFtLa1fVUpgDIfNem0NTZyQ/AyqYuJ1uK41hWiXYZuBwnhUIblHIoPppeJwG58yQpe3I9wZ8NE5bUnx0zVsiZZ9bfxhxC3BiM+/t+Reij24fH2pVh4anB3+TN0h0WOU3AmcMcT5H4bBYW4hteE6CuzxzR/+zrgrLf/F1gW8+htD5b4qjzOETSl7Pu6yOcwdkX2+WQM4QzeWxarf/xvqru6u0jwvkg/XU0KSy7r6
X-MS-Office365-Filtering-Correlation-Id: 93192a2c-ad72-480b-d5e9-08d5b49ea5e1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:46:21.7572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93192a2c-ad72-480b-d5e9-08d5b49ea5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0761
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869848215623702?=
X-GMAIL-MSGID: =?utf-8?q?1599869848215623702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added sram bank variable to audio_substream_data structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 20 +++++---------------
 sound/soc/amd/acp.h         | 20 ++++++++++++++------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 39597fb..8236116 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -320,29 +320,16 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 sram_bank;
-
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-	else {
-		switch (asic_type) {
-		case CHIP_STONEY:
-			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
-			break;
-		default:
-			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
-		}
-	}
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->pte_offset,
-				       rtd->ch1, sram_bank,
+				       rtd->ch1, rtd->sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, sram_bank,
+				       rtd->direction, rtd->sram_bank,
 				       rtd->destination, rtd->ch2,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
@@ -795,6 +782,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		}
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
 		rtd->destination = TO_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
@@ -805,9 +793,11 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		switch (adata->asic_type) {
 		case CHIP_STONEY:
 			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+			rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
 			break;
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
 		}
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 2f48d1d..62695ed 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -19,12 +19,19 @@
 
 #define ACP_PHYSICAL_BASE			0x14000
 
-/* Playback SRAM address (as a destination in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_1_ADDRESS		0x4002000
-
-/* Capture SRAM address (as a source in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_5_ADDRESS		0x400A000
-#define ACP_SHARED_RAM_BANK_3_ADDRESS		0x4006000
+/*
+ * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
+ * playback and SRAM Bank 2 for capture where as in case of BT I2S
+ * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
+ * be used for capture. Carrizo uses I2S SP controller instance. SRAM Banks
+ * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be used
+ * for capture scenario.
+ */
+#define ACP_SRAM_BANK_1_ADDRESS		0x4002000
+#define ACP_SRAM_BANK_2_ADDRESS		0x4004000
+#define ACP_SRAM_BANK_3_ADDRESS		0x4006000
+#define ACP_SRAM_BANK_4_ADDRESS		0x4008000
+#define ACP_SRAM_BANK_5_ADDRESS		0x400A000
 
 #define ACP_DMA_RESET_TIME			10000
 #define ACP_CLOCK_EN_TIME_OUT_VALUE		0x000000FF
@@ -95,6 +102,7 @@ struct audio_substream_data {
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
 	u32 pte_offset;
+	u32 sram_bank;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-- 
2.7.4
