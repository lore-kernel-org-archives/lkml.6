Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx49taUQ14/DetRdVAHg7XcdB5JiOgEvo77hdYR4K4DqTmSpGDwvGxl0035JVdt1vxS1Bm92J
ARC-Seal: i=1; a=rsa-sha256; t=1524741397; cv=none;
        d=google.com; s=arc-20160816;
        b=qE0fdrZaZabh4s5Jw15dQNZsVn3QznbvNqUVHh5gtXDmp7ESWMgToqX8T+R6ky92Tc
         T3JykFgebIeLD6XK7WjpvetbNJm9yu6SY/7LAqKFM7dMayqMW27DSW7G9ceKuU92Me6u
         lW7wD0f/uaW9SHQWtneO1iKQ1O0PZrdWqjesUsijEGbBZZsO/BE5wbbTFEmFPDzPVlIr
         Qf72FAbBDdCIUd5chSlrGKRK4USa0wwfsy1Z6YClzJOzcrjpqwsmjNiSMdxV1riPPdN6
         doSlJ901C8sRQhBVhh3zVYX8W4Vf21YdnHNzwUuYZZ3RxI+CFdNgF7hEYcZhAoyLMIhZ
         374g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=z3f9G/k4ZYkSflOmieYIHglk4LiJpGzlnZN4f62t1J4=;
        b=MRlLsWJRwRxF6QATIenGTgZYUYajlmYdH+2aXU8X3izeFW91TuBhA07mhL/qbmTVCw
         CyfTU1wGd8sUvPxZ3HjuzxDcOcVCnFCC2lyYYNXORZHDYOmL0dYtF0oalYXeQ11nYHsK
         gLh58mXF/v+6YNfI5toJEjTck8M1ZJJiKVH7siEdNxHhkbhjhyoNOyrYd3qbL7+QM6GW
         ab3t87cx+nCCKHl2+Wjk/GIDH5VVXrfvbJNQOL0qsUViUTLI6ADWPX92UI+tLw6VRu1E
         6MLFsxjUOND95MbzRz7RwPLslsCPzFg0UWhJ5zx554/EzhKLAuEuNYX3ZrC4uUszssT/
         +vVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=hQZYTUwi;
       spf=neutral (google.com: 104.47.42.43 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=hQZYTUwi;
       spf=neutral (google.com: 104.47.42.43 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, "Jason
 Clinton" <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>, "Kate
 Stewart" <kstewart@linuxfoundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] ASoC: amd: sram bank update changes
Date: Thu, 26 Apr 2018 16:45:52 +0530
Message-ID: <1524741374-13523-6-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(39380400002)(376002)(2980300002)(428003)(189003)(199004)(106466001)(356003)(104016004)(97736004)(86362001)(126002)(7696005)(4326008)(26005)(6666003)(336012)(446003)(2616005)(105586002)(53416004)(426003)(476003)(77096007)(486006)(50466002)(11346002)(186003)(36756003)(76176011)(1671002)(39060400002)(51416003)(68736007)(109986005)(15650500001)(81166006)(7416002)(305945005)(47776003)(50226002)(8936002)(72206003)(48376002)(5660300001)(478600001)(16586007)(53936002)(316002)(81156014)(2906002)(8676002)(54906003)(172123003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0325;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT048;1:7iRXNaTMNeDToan1+VPGh/zwuHWM54/TrEIDo2QUm24I3zslIlwkhHpjgp6IUwgNOH+/tDKrjN8yksNJPZs6IuacG/RtUjxNaExyIGBM8op7yYCcKz5fIwubr8FuQu9F
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0325;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0325;3:dBd6WnjW0Lr8+3VfF+bCqbrtpXWjIvZbdKfOeMe2lHQEZ1C9ZrrV5AxK9J/kft3yAruEMlkoKLfAjTPeG5o6x20KQz0bu0549rAzJDvF7kLM+uyIXt6UlE7eg55IBtNQKX73JiPros/Yge//4TZN2WBCVLH5X2zyvrLo2wXQXoK1jp0XUSqJGycvnxmCOw0GBpPnhnYquDLCSDdEW3H1MujPSVcTooBSyEoKJx6HpA4KQypaO1+8L0F/ccSMnRgQamlh3CaukZWiKXRanognFueKUgfa8lLtaX1v5Mj5OXHPpkYOP2CFXgcrokVOQU5zrPz9BWlAXipCfhxcJ2+2GMdCmc1tHbAMenekXZBYLdk=;25:1z/XTIq4qhwq2VH4mxCwxXB4hBoKXP0Bx/V54lUdfThR+n0q4sSvwOGdfdW+zKXWeRSCJIc7VK7d+uHeQkuaDQ3gabtdUEYgItc+aDabQGOk6c4ynfRAv0VqjKr3tf5S3WQhOOdf4cWDk2/bTNL9Jk0AtGJNX+kw+Q9MkRAHqQE5y5lJCKNu+/1zv2OBTx/sXFYghJ611ZC1o+G+MKcLdIrAioepqjdno7WtXzdasxv31A5h6i0GgFayr3yksCnfSL/765bPl1a9BzSN27ABZkE46Z56IWh5DIJLH43U1ad7M6NTOypZb+KL1jFCeWp/Yh4QJwQXIvzax5nRYotMIIdPf9FuOh5o8tBLyn4I3P8=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0325:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0325;31:9z2JDyxZhTYvKs7HkdZYZczv6KZt8LrK0+3X71qpO1O040wGhWYMzPlytJs8Yd9T33/Kmwb5G3wUT2dv3zeaKotL6/vWNGnvwjghbt/ZplJTGT9GgvfZd4qoY/Ol842aC9gSAj3qXIRu+pLdt0nrtPuDoIwLxVr4NcSK2bM9F2RK6uBwzn3n7TpuWQiJuyvbN0y60l1bOmcZuyIc1I8JHc6FfurDjCAAS8D+95Sg8WM=;20:7EIFSHd9FfxKtSTmnooHIG2dPFHGvv/fpDfLycHcMwL1Fm0ucHMMNpE7mErl9/zUpxPJ6bgDc+JVk41G144sC+6spKPubNLfYOvLv+g2p5+c6oYcbZx5DNUlM336e4lNnVXy9tCPC17LH6tOUSBYakwJMygZvXxilPnFYjxwz7ugo1yxbNCWBcJgPHEvIS2A8Cx1a5cfONHus+qTHBIPl/qzMx5Ga5os8BYo5Go4CXRGYIPH5VJdroBxNu74d8tYNHXk0oJV/Kn43s21umibtUu15hFiU7o1mXWvBr7DS4iJZPhBkAZq94OKYoPqnxBlzVVVUIqEWKZoFfEpwKSgEinVmYau+dgPzls8eNarUoqbpFbr2IhGw9c2kH5tquOi6RSfh0+/Bqm1wsE9wVvrfF8kFbfOTMQKHI3V5Io6kmzekZ4HoaQgSnTiE34tWakKpxXsfPd1NIFi+IIYwH9JadUR/jri/Wzm63WiREcRJvrhTNfoOGq4ZIgoEdJ6c2hk
X-Microsoft-Antispam-PRVS: <CY1PR12MB032532320140D0E87435C2BB978E0@CY1PR12MB0325.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0325;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0325;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0325;4:3KJGNzIUi2mS5niGXmAeFhs2vWLCeVO+oDcqkiB+1d9XtxfNcjGfgwjUDlfZAple6jmYa3VEsQRAjkQ7WWooNNd9sPRFaJnEErvo8St8pT7O/njJ+ff2zt6vqjP5KhFbXStqXIBf+yd75mXlpSrPVWRoThnwEq3hAg3YxaWny9lR4d2VttGahnBa0DrTysdaPnXRBL0gGGM55/+WPezKuoSuDz5OnE3HuOhj6un5ej/RO/W7vhM8wYDtZcOqsbkpHp2Vmf2OEVH81qobHaZjhmv3Xpj8SX0VmqV54ZOWPASdZKT2IKwkXeik8eBOEdsh
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0325;23:twU4ypO+XhuxdP+1CDe6eAFy6DohICskeOKtbiCDy?=
 =?us-ascii?Q?1FzZif572HjlgRoWgS8ET/yqIjMbvqBrBV5bL0nKlZ90A9p2p3qdgM1H2wbk?=
 =?us-ascii?Q?vkGC07ivgT0DaB/gAzYwTxvUo1sz3m1+JAEjSWK0dIC68E/woINSEbJeuDJw?=
 =?us-ascii?Q?kem7HEBXY8pL4WjtHXRiMUnQYfK4BRegVGqLrH+CQRUU/10WCKTFNeJwwlwI?=
 =?us-ascii?Q?9q+A2L5ChHkdkIjSHuxwa6nkziFWIGyySP1lcKmiLc/huyjC2R3gwK3HPkoA?=
 =?us-ascii?Q?edgVQKQCb7n1jDmZxgBKaz/sA7TpEpihvfR8NeZnCcNXP2RL4CqazFvYHoUL?=
 =?us-ascii?Q?OCy7WvduaGsOdymBrrNm4Qx3VGDG1nCDzhCSObTz6xsp/VDJEgz18QiDmIIK?=
 =?us-ascii?Q?RpiR4z9yZgHlDbAGxG2oTZPS6gKcOA8XWyQ2ixhhLftm6ufPdwq6+yfLLgMe?=
 =?us-ascii?Q?U1NZ+7xWY+XPKcs+s8ZkrmAVIzLQ/+9bFPJJxF44ZqozvJtLJkXV+Yq4vGom?=
 =?us-ascii?Q?WSbtKRo2EiBJisN19Sl9uP/Ej3YHgi248PFdW0OrZQq65PF2oTTfzS1K6gRJ?=
 =?us-ascii?Q?BJL8PfNIHWwQt1RQEX+0JaY5gqBSxmOIudp29AhiMHqFJwCHtK7w0+1rH2Zr?=
 =?us-ascii?Q?kaSpf/vOjPg905RyrRSdtHxkDM15ofmOWQ7d+Qs6KMrOdN2lT82J2ofCMKxv?=
 =?us-ascii?Q?RQ0s52UNP71M9UH3RibXQfoIv19x2fIk5HCX0VBTEqim/qyb309bTdv3cP7w?=
 =?us-ascii?Q?jukAvNytYF4Zq5JchPsp3jMDeGobY5+nggCtsyTCaSddlKXHktWm/t2vmWQ8?=
 =?us-ascii?Q?ez6R3xuZz9R/Swn76f/jbcjkwNLMeqMcBS4ITgPKF93ynRHViqxGWvUdX+At?=
 =?us-ascii?Q?iehVhZMOPMJLkE8qCQSliwFmse3H43V+mBqGzEwu5w6mjo0hrSYHwfq+lhh8?=
 =?us-ascii?Q?kGOriBsh0N+Ol+je1bk7audU/TM+PA6M9rXAhzRiJcR3+nzt6TKAyTuZS9UW?=
 =?us-ascii?Q?3GFMD0pIqqQBoK3wTPSA9rJ+0frqpzJV2Ud+KwDpDn2heEuJnlF7TMVGhAqU?=
 =?us-ascii?Q?mAPohExv8T4ovLX0Og0PM+i4IJB27p26QFbJk12w2KVOF7wlVPBj3Z97tWAe?=
 =?us-ascii?Q?TfSU6j2zlGmbz3C1hc66mBWDYlZ+41pEX7nnSBmPDbZb/6N9QalciiU1Nb6b?=
 =?us-ascii?Q?hI4KLhZPydj64qgI6uUlYoQhQ/fqBwfjzkcOgnGpGNcxYbRQ5FPrA8DaOp66?=
 =?us-ascii?Q?3DLQX2ABrDApZxbFHQyX0/m8nFL0Is33Ffvf0Hjp4GLzQDKgzNvbBHEQD1Vu?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 6A9kO2mbCc0xhy+5GP8l47HVYTr4ASN3avJ0NeqFlgvcKm+TaSCw5WSzv0qiks3t3ZZa8Xs6bKl7z7bLlqDBY0hdaJS/npcBLaAxbbRHgamoYfLoxdXYS0P4bL4knltDCn0aLmF+JVxnk66WpylbHdVkH04x0tZlM+L9lZnfyp06CIZgKdd5kbnCmzLZ5AsS
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0325;6:+yNN/GbowpamB1bZiemRk8UpWgTrclGjuGc1TKGYn+tkcK3DCFl7xBH6BVHa5/TeubpICISegVYxObtb2imIFk3zbQycAsSJzK2NdPThRDTPOniQIfLws0eMGNNnHmjigj4sMjMgk/U+cyQXtXnUQQ6HSZc8cTm1r5x6UqnYD1XeehsWXmtXHINJcdCfbBaml7nSssx0A+NP8j1rpTUzsQzt/31ahriDBgPIg2NjRz3bzzIt1/30xr85SFa8DMcr2epTFOA9VpqVL03ZDEY/xRO8Zj8Vp/F5p3cgwbENVW3C6ehpXDuevgEdK9aEBg+tr4ReNs+Bya4qqtMRJ/7eO8HiMdjwqXNfNh+oFM1QqUzRtnTxppKHua6mxRXVBbMvn8PCdt3jzpmHmhcFzG89+SPq77LcQPffEnJHJNiW1SMu0y1W58ALt8Sxc5pWoTFKsh/68h57cI3ztoOoicmbqw==;5:v0OxR8lvbPAQjLR3XmFWphdFoG9gAucdvNRL31g+X55gOv4RiRhhLQCYwdnSNRHTXJU45qlbOFLMAXKalrpukEYL9qRbjqd2PdzWYkhqRVTodtA4FZCzceOU/eomD8LnV+L2qtwrzePmbhF/RAMAcD350MB4ardeo+cAB9Q23uQ=;24:Fl7nrp8XGp0HGfGjuD3EoIesKiLGLHxu0ZtGTlt309/voNQ6w2uOAmHuJeSDsxhHFF1MlxOD5a3RJ4kVXUe4RzvtxwzVs44Lzf8ThRbq6Z4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0325;7:OeI3umSlzZ1CwzRpBmfBlSzk0c44iAbjpxVwSQkUVxbmA/K/of8xi4w0PS8qukvqdsH0Giwcz49i0DRaqyAPhvmCb6jD1rsZVCJn6IZCDTJVHzrLkIbp4B7J75lnI3B38kx2TrfCu4QYFeAMrcaefS6Tw/QRCHB8JF1uo6mKPX5G8tK5kKHgI/RUZIIkGMW7DokuZO9zMzOIwlN31S4uYHJjKqh/jyP7O9qRRoB5P2HEYxFQAs4y5m+KbIhx5FVu;20:M4WnzA7Gci5gdj0EptMtSVOq5sPAbGa2bj6EqIJrWkg4lyi6UzaEMez6N5yeI2WbyxO9hiRK3W++lmJ+GmvOQWGEWijfxhIPt6WB7EqJCkPmErsAc22ehR1MjxM/nm8UCzEgMMxFdCEVq0iODzIiHrHZ4zwZ/hAUHnHQ0TSXyvEseEIRHeNS7Tb+/Vy0gLFo7CHosT4iBIJUcqDZZrviEB49TT1JwZ6TwIkUXzPI9J0iTNN5Nlpqs8U+CTiAApAz
X-MS-Office365-Filtering-Correlation-Id: 023f0a6b-88d2-4f7d-04be-08d5ab672b9a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:16:34.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023f0a6b-88d2-4f7d-04be-08d5ab672b9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0325
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807235933868204?=
X-GMAIL-MSGID: =?utf-8?q?1598807235933868204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added sram bank variable to audio_substream_data structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 20 +++++---------------
 sound/soc/amd/acp.h         | 20 ++++++++++++++------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cb22653..b7bffc7 100644
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
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
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
