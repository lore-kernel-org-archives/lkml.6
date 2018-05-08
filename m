Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeEHEsA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:48:00 -0400
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:63668
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751357AbeEHEr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:47:58 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/10] ASoC: AMD: Fix clocks in CZ DA7219 machine driver
Date: Tue, 8 May 2018 10:17:51 +0530
Message-ID: <1525754888-14124-8-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(346002)(39860400002)(2980300002)(428003)(199004)(189003)(476003)(126002)(11346002)(446003)(316002)(426003)(47776003)(16586007)(54906003)(4326008)(2616005)(86362001)(1671002)(486006)(97736004)(50466002)(48376002)(186003)(77096007)(53936002)(305945005)(26005)(72206003)(478600001)(36756003)(39060400002)(53416004)(109986005)(51416003)(336012)(76176011)(5660300001)(106466001)(105586002)(8676002)(104016004)(68736007)(50226002)(81166006)(81156014)(2906002)(8936002)(356003)(7696005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0759;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT044;1:SedSrd0JcZubrSGae1KuTH4QXcNygMa35RjbM73utjKRJsBkbFfpssRXXEGlEWzwsrFd0SCS2ZiBq1wa2fpRKZVa7eOrARtUL8PaJqepTeCrFWTqXejODclE9aN9rRSk
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0759;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;3:WJtewSfsEYaPExfR4ABKYyjkLHKNJ0Z1aVszyLpTevKyANuM8hFt3rLJFzd4sLdK0gzxuGdh3f9aELckh8Bi6bMTabHFWkiv3iJDX9yYZ75a2zv+3+8kQ6ibFrMe7KRX/nW8PrBhMGF2iIaEOhhPXfGRk/Cuk0ELXJ4TTTU1ck7gupl9AaCUTPkQM3td3eDcyyubBb4wggAVp1eGcmXsTdgYCP8REK2QEyTHUtKuaJ8ITOg8m4PtvH4FEuvFf554z0XvNcr5FyUMBWBi8j7BxYJrf7hWwKHNZy+XIGwS3Yi67ZQ63iBMe+qhisDDmkSH+yy7s8jTx4MqdIqij95HCEbzF+/hUY0gOjsPQKn9FNk=;25:GZHQCruMBZHwcuQeBmOi1EefxZnjWezSedah/B45psA3u3slNrx6MOx9J68ogJn3IbZSv4QAXQ6tIlToKpFNOYLD7+8vNkNDh9xYs8VVL0ai0Q/zY2wLiGP4QOSn1xOE0UzDADvR2nv0BEjOZoVTaWeweETEQwlwqAdFjfyNrPHakgZwZfbh7j/uP702ybQ+xxr61BHYKntZrEnyie2S62cf+3SysAK2HF2Hgv6FcTJ8TIm5/kILiqnkp/U7ovTNLvbOFgofi28otCBmAi+Mq8CsrFTcFn0YUa50L/dh1ecKn+tCxucUEsj7qiW66qVxwHhxJuDs73EAXTXshYLkXQ==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0759:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;31:b8lVamr+ZG6B+KvNgyN6bxiesodgXlRkHyvmSlwiH4pfl6vdFEn1zv69ZRITH/46bycczMO9Lz8szvXPai9k7qvumHvCGujSgCMZthfa6h+lAK7xOeb9l7fTfMQrCKTBBHIjSFO5RVPUTGfqssoH4AgGA7zHSWM6IgkvGgAlwsEeQxPX6CGdEvMpGuhXIlO3obf2ySVZxNkYpFueOtxMo0lb81oJwe/rTgDXFMRrPCM=;20:B1EBylVHc8xdMKpJb9d8AyrfiHigyoWWmbB2Yd6uZOwNrGemNjdPfvzGTAsLcSA4Al/IAm2FoL/RaZZRiveTt5aelK/6LTsuJE5sVBSJPoaF/pb2Mh2QcN+zJL6UUEk5d3aDMWzCOgVosP6WagYIxgno411ppcPrWOd8ypGCMihWdLbDwzH/p9LuHArHIfXhCLI92A2thCUWfyS7lUQuuHsttFyglMJqMPWuKu3Du/iROX/Te48/g6yWOKW5LnmKR1FClKd/3F0OCB19Y8jWgzzfAgmrq8ROlGnrOF/Ak9LOhRLqDiv3V0RY69kwWhWrDY/FTPFBmvvIdLRB783mSJ1m+atzbMzZuys+fP2p7P52TPPJlM+Ogo+U7VkOlG31GBf9JO96zoXDQDsgQTVq0ktFpmmIrRs+iWDh4OeFj/wULBWX9bvYHkvFDQlLcgcSdpHvq+VXXe5m/MCZ9g8OHCfxvEsBhqHBcs/Gb1dusD778DQ3FKTDHkcEHjrpS/MB
X-Microsoft-Antispam-PRVS: <CY1PR12MB075948487B68E3124D8A3D57979A0@CY1PR12MB0759.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR12MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0759;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;4:I3yWsTM0esFeBKDd50rU9HPr9LaQLlZekTrSdbUSVCo4KxoVj1VeLvBZZDp/ISELVKtjOaI67xd4tyW4hm+L8B+ho6Fbp+lA1vHMqY9CDDfNFe1Hpwu/IBkKrx747/owk13sXoMz2S7CygPnXpnKGBX4xm9Esx2ZSHru7WpyFtiHQhBpF/ZWzwqtrwDg8YPTcXKWwSGPR8L8tGFGGFMFLUkAQaMyNBTVEkNzv3syfZShnGRiAwCkLhM6A3DEj6LS4dCeextIG5/NFeXGmC32eB2k5CnzJJWQVRlooh1HaCp0sp79LOIGMWApVktYj2Jm
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0759;23:0IJFVgPxWw//Z0XeQzgL530I0TutrTpTd8KdLaVc1?=
 =?us-ascii?Q?In8pBpXSm6cSKHyUVi9yiz/eMsiNXx8rSvHM5RJuX46MdjpDKvxuvIONU/7N?=
 =?us-ascii?Q?DmxWwZfAtclVFhrnoP+bKsA7SJXTFImJoFfm3t5nTPxoYKCSk71vdyTFcjC2?=
 =?us-ascii?Q?7ucZLWfWtNcRGFRs6g8Lngql2M/Zn6mUnW73QMV6ozyMripOwBjnRzqi8xCv?=
 =?us-ascii?Q?/yqbxSmb6PmnEtTu/JmRpo+S/VRSbUp/LcM7Z1SlsmYU4iCNkqoci9lGt37/?=
 =?us-ascii?Q?BTzmS7arJRgAYlmlOv7ZpATgjhJE+9+UZUffdUDAHIe7B2p9FqBywmZH5CRx?=
 =?us-ascii?Q?KCQPpp3sv9CoeSau/cSabUdTaI3rzds7X2/0G5MvZThC8CcQQN6xRiPYncRX?=
 =?us-ascii?Q?4gJHR7s9p7z3k0rXqLTA8MkE+aOFt0QzGm85zBFo7u9Fo5zkHQ7Z44gJfSkT?=
 =?us-ascii?Q?xBgUh1esAluYp07SyEJkaIiS2r2SOeQ+fjQfVWG04DfeLAY0/G5Os095SkHw?=
 =?us-ascii?Q?6duunhvK4HJp29+L/0FUa+2/hFuV3JmTNnxPsYrdQlX4ErJoJ1ztv3r7w6iz?=
 =?us-ascii?Q?dRgDFYI2iVa2RwKHd/uzYgIogvgM8n5uCgr/CjR7Co8fBJeE39SjvOYnpc2I?=
 =?us-ascii?Q?XnfuL9AEF0Ykxc/PNN3YY8wPI/PARP7YxxPTL/NdKC0gMK/4mEg/TDHoD/gG?=
 =?us-ascii?Q?lW0MKcYw1wxEzNpx14NLyp8qgUq61RXOWqeyPVuNjCPVnwdAqHaRab6NyxXa?=
 =?us-ascii?Q?KBKVMZyw8VO7ikqt+xDVBX/YG6IcHi/JaizVTTUr0gkZB1GBHUq874GGrfug?=
 =?us-ascii?Q?RQXfgYJxNvXHx0VR82gFyV2E2zI4NRaFnDn59LxmEL3X7ToEZJPyejPvaLI3?=
 =?us-ascii?Q?1lEWNb42JQgTwX7McI08mi1XArdgKugLNa9aHsc6wlaiKqe8XRxPibe3bt4y?=
 =?us-ascii?Q?wI5nrAtmexpmoIYv4b3RA2RTBrT+2rGsfrESWmUk5VRCJisaA4VrzVRShCR+?=
 =?us-ascii?Q?Cx+aWdFM0lSzoOK/pEX7fnkABSFccZFhfiVkmBnknogwZMb8bnj/we6KFOjc?=
 =?us-ascii?Q?Gweg0AvQkbuqH1wUWEZXw2UMRa3Z4QVaCP+wryw2nezrYFbihLfzU5FkArJK?=
 =?us-ascii?Q?juSGsUDt24B7B51ztaUGfS1Ez4iPRiwBgwQEw+SSHwh1OrQA4WaxymiirJp3?=
 =?us-ascii?Q?n1mzBd8XNtWzoKVC0RRiVsnTYcLTbK/Tzxk?=
X-Microsoft-Antispam-Message-Info: wz60M0Xr2wCgz6wLKRi6a8zdE4yJ1lf2LPXLaVh8jvrCPYNK4Fk59Fv8GF/G3jvrI3xD3xGoqJpiNATiIHFmbuSdp+pm5G3GI13eMp3f8xZrcVC5KJfylRw4PS1uIVWXfpkjuRAcHwPv15t8wIZzNhDpaGdpJ0FDN20P/aAQBswW35PAnuaNThGH0Cwm1QOt
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;6:y32+yQyqvbliAeJYSGXyKAUwwvetqzumwcESZOtaLuZQA4Pkkl4+RXuvqM59IykPSsFYd1jps2dw3He1rBaSPF0vCez5tBtbl84727eHzlVaOziimjdeRlERVgjOzbLQw4u46s16ephoOgDV8a0kyFRBACwXsGG+WFhKzKcpdAYEdbpRXfb4c7GlrNSJNgeMd4jIY9Y72UuiQyJpryiGG2vCK3Q7B7wl8oYdxEp3FwtTBoY3ZN28/r8Hw/CK1/cC3qpB9Ss1dpvMDwQ0uP7NA4M1wWo6btI9G9nyDVGFUCN/Ic9aHJOKE2wC7oC277VYIvVoJZTIvfcIVo93lf7EYBp5B99NrbmAXbOPnMY4USxcJSj6o9fo3/ifnxOK3ktAIWwRxx7D287XrBHixXtY9NHSykmtOlzMJux6QsJVqFwkG6CdyHIdMNWJmzelNmEckvhjxHgHaNhuXCHjU1m3VQ==;5:gaSY2eTKt+bVt03y7vd737HGrHrJ75FVnJ/hcyA/fOvtvjVfuURRxFJ5rslIJZX2SyDxht8ww2BL7kPGXKp7qdoOlLJNaHz7aOu6O9N9GXc1usGKHm4m8tMNDBb0skZdoX9iqeOWI/iZvZ1x1Yzf/n8QGdiyZnJ/uIltEKgzXC0=;24:2bxCvEjoX63q3SrF1wgwdlQ0b0ZvTnghlS3YAyH3YQUM7G+gHQIC8NjzzctPshMjSV9t54A3XGAnINDt+t4t/DvFQucjTUvmj2itcPKH/cw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0759;7:aeZdI830W22SbWoHi0NYKDbxTj3Ofs/SqHr2XA6YwqwugPncexTNGwYX3vWZUrhM0fgsXNThDruOnfITwXLLbZiI0iMF5O3v600FwbJGJHNUfBSBuao3AX+EZAaSgfCe8ipGxXivrawzFZnw1YJUxTT1uDza2LR4ceQWbPG1pj6Sbf1/vg+fSLfPo9JwfmpLZdvp/oUin1dP27lYk+VuOWgTqNPV18mtWuLxPQJUZqlyVNSIBM6zoObEVC6WZW+j;20:OHzvvoCFg/Vm35ZYvrRhNxCbLgiD6g8ki3UCKxSBQPZ+84Tn3lPiHysx8vLN4sflDUqao5gtZGRhWMBycuIs+mSlWhybaqQwa+Uq/A/akGApLZNvkIkqGVas9DoVzZlCeHd8YZAfWbcyKGCCf4/s2To0Tcv6qtZDVFGik8n7MEkgfsTVcvK0jrVHct8ZKXyyPqvq+CY7oKf0N3LlKYRECZ2At5uQeJiRF9oxwliLb+pRZc2n8dSESjBBiv+6002j
X-MS-Office365-Filtering-Correlation-Id: 6b3ac66d-8059-4477-2c90-08d5b49edd6a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:47:55.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3ac66d-8059-4477-2c90-08d5b49edd6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0759
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

System clock on the platform is 25Mhz and not 24Mhz.

PLL_OUT for da7219 codec to use DA7219_PLL_FREQ_OUT_98304
as it is for 48KHz SR.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 6495eed..fa5ad5b 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -39,8 +39,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 24000000
-#define MCLK_RATE 24576000
+#define CZ_PLAT_CLK 25000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
@@ -63,7 +62,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
-				  CZ_PLAT_CLK, MCLK_RATE);
+				  CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 		return ret;
-- 
2.7.4
