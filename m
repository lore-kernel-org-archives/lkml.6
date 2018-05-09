Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeEIE3r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:29:47 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:55520
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751000AbeEIE3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:29:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Change codec to channel link as per hardware redesign
Date: Wed,  9 May 2018 12:26:26 +0800
Message-Id: <1525840011-14077-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::30)
 To DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b4::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2357;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;3:YgGEXua9Yi0KfI2m8OnYDwSrpodL0PAT8PoWPf8VKOrOIPwIprpaln9doPAa/XIbHBisVHWWFWEDVS3NDdOHEzRoNuqRN0fyUvw/leDjYIBW7m0P0zikVGDGrJlwpzl6Wr0legwQ5J7HhwMXVQSUpojn/wtEZbvZJ9MAgYMk9J2yoGG/R9z5o4dzjy5XQfjcfk6mJg8axBl59mzaFFF+eMw6NtW/hCZjmXKVht14rM8wCLa3OTw7MkfIYEet2/DT;25:aTrUK6AX+hsx/GOmYNXELMfMTCPoQkHkwEqF+NcfK8qjkVQKLA6QSIWdrOBr16MApT7gQ0gfYVJ5BgIl64nxztUkUWbDMnkIY3YYlRZMFLVRhQDpbEN0oTjNWc9qsRby7GQ58ZTKQICHfGD9rfN4F+KC81yhnbk2oqbgON2aG/2NS/tGDZ169AfnyXvUgTK7JspVIC9guXFPC0TI3o5aP8ji8obeTAcKmQ1JtJvpVgYngAMxbaUVekBi8Vt0grJsh7E8Pr3UGb4XfuU13nfJnXwlCFGwxnBG0Cjqphxtlno9N62ao4io4iK411N71eASrE18f9rhsOUaXA0/hTif7Q==;31:ggqlWP8vPsXDjI7fJH2KxCsOGMsI4unxC57PbE3p9Nx7i0y9JiGCDFvDxTOpCqvRBa3+OG/T5eSMwt8z1KbJ3g2cXT7UVJow5ji8afSKfu9Nzjp6cQZkAPd4Mzbo2xCEsqVStfRwoMmjOwIRUZrviPCQ+20QpcNuh1qc1hT9PlLBieqL7PszJ3QpWqv90buAZzzgmYBpEEQgnuMHDom0TkchZsc9IqLGpItQN+qBxU8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2357:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;20:GVrPBGlQDIO4mlnMMbl+V8n3IR+45ahYDnR6PoNbk8plPg/y+jcE+7JtG7I7XL27hZJt4yKi8mG8uJZg8IETpbJKmCMehkdqoBdXPZES0g+vorQByIG5dSCNqH721jBXpHaqBhcqKZRa98Zyf36Al2TM9LxGTHkIhjCUqx3bi3Ecea4vDJbXdc2/DIvERlZyWTFcdTGoKAJTFu1ovtD4sHwPrGzA39AU5dWsXPd3MLz4cNbnR8RcX3R+Yrb+pIiOv6croCvxEgm/jui66c/OM+Z1ZuKCUSkwYzf1PVz0AiZ5Jb1d6S4XK5wnT7pWSqmuFVa4+lbPVeeFCSmQe3r3z88C5OFkGRItmsIl7cdg2VDQtZHq6RIbUjWfz4NM/l2hF6Pzc3dOPhg/M3uCSrVPE0hduO1KDp+1bciWRYJbPbVbUG8twsmXfbqNRvzst4q45rKQvRXSjKjBAZDsqGHz9jmnu3XwKg8OZ2Sk7nuOUihuB5c/RmX4wjauI6or5l8K;4:bVafUkrSSM+gHAl+K4i7aDoFn3WZzouW2Nc3U4vHZ5pOl9FenlcDNyaR13gcDDVDZOpsbaOJjkNR8aDmWL8Og11Nr00RqvOCv6BiOqd8HOCJk9gEWVQnSe/h+ESzMPK5JXpE+ZNVIOvKdY3bHGvxlz0l5JaEpJdDrwsCIK4R+wwdIPXv6NVnxHidnsdh9RxIuNe0JdOiB2320h/P8hLyXmQUUqBVl9WACXnp2J/f5lU4CF5FzRMti0kIAHyN1bQELMgxkKNfRSnko8GgZVDappN8JIq3i2c5NogI1SdC8E60dIeiRqsHq5aPlzJJRjnV
X-Microsoft-Antispam-PRVS: <DM5PR12MB23578FBF7D6246AA36E88EA5F8990@DM5PR12MB2357.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2357;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2357;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(376002)(396003)(39380400002)(346002)(199004)(189003)(106356001)(186003)(51416003)(97736004)(26005)(16526019)(68736007)(53416004)(47776003)(44832011)(66066001)(2616005)(6306002)(956004)(7696005)(476003)(5660300001)(36756003)(16586007)(105586002)(386003)(52116002)(316002)(54906003)(86362001)(1671002)(4326008)(6116002)(1857600001)(72206003)(109986005)(3846002)(486006)(53936002)(2906002)(8936002)(966005)(6486002)(39060400002)(6666003)(305945005)(50466002)(7736002)(81156014)(25786009)(50226002)(48376002)(478600001)(81166006)(8676002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2357;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2357;23:e209hZUuBrkUHEQfO7FIg3kyWbP7qNveeGfmPkP16?=
 =?us-ascii?Q?2J38BpydeSFlOH68YZCpd9nd5GuG0Q7pWMAR0d6pNe4MaE42oNjMH51dY370?=
 =?us-ascii?Q?4iegnXl823gh0kJOYj+wSe6pl5Asl4cl0GusTx3N31y0KHdLNdlPOTLmn1N4?=
 =?us-ascii?Q?9IA7QSRr1jm4yNuBDBLL9KaIQt7GshGaXWcxP0yMqXq8pcAlWUWuDOusal6K?=
 =?us-ascii?Q?y62hr0lK5i8QIHX7HSZT8Ek02eQVv43ACNMow3mwmP9wNcUoGya3Mj6R4Lk3?=
 =?us-ascii?Q?5mF8A5nL+QGSwZuPlT/gm8a3yxuDeHNQrHlXWexm0IeoX9m7mIE6qpqblohr?=
 =?us-ascii?Q?bvmKCHFgNl5+Qs0Y2heSKGtpSk640mph4JguBxqCNWC7BABVFownzXC0dAWA?=
 =?us-ascii?Q?wIOkKNcryXc7ApjDUT96Dc+fKjMRQLhXrKO7G3MPF037oQ1aGv9nY3FfVMGR?=
 =?us-ascii?Q?tH73q+rSKpkCoTPDpiqPdVDCXrERoqO+VCzNfWE+PDyvrgHg2z3otGkRPUdF?=
 =?us-ascii?Q?Yk4xWPWTuBW9Z5GZTpF/joC0qHAzVG36WqaXKsV3wtv9SavC7soVqEthTZYW?=
 =?us-ascii?Q?ndQM/xUeUcwNM1JOaIfa2IM3Lngivu62rBkyierFvAR3Dpf8SKkFEgL+oyTt?=
 =?us-ascii?Q?BuWGBAj7C+ZU8sySmloOirGvGdJyhNW79p+V5dyaTJndq4qsC9LGx/Y3q49H?=
 =?us-ascii?Q?rq0/zKApfXNwdtMJEx+xguZlRCYYDG1A/Yp+RR7N2+xEmdGuaJox8KC2t7lA?=
 =?us-ascii?Q?bA8FX58jsuuKzYyFQ5MzhAUJ9j2PVZge+docyu6qt3KgZAvpC1AOh3YK66RY?=
 =?us-ascii?Q?26cDkxn5vT+Evdvtt7h3cPD4jUu1qH0Lt6tMlHf0T64e2s8mBcUSc7AZLYGr?=
 =?us-ascii?Q?Er/FhwATAoV8CkYjzg4Q8BeIc/nOu2JssEsSDQEmVXaNs0zGyW2bKe0DwAn1?=
 =?us-ascii?Q?aNdWWQR3gBIql8NzYGoJvoW0MlD6d1+PWoK7k0/c2swfS/oxWYmtZ6cs4Wrt?=
 =?us-ascii?Q?5JUUS5uim1ySLUw2xQfns9Wn34VLpZ7r6lqzM347A1Wwh6rjlqXC82fcJRGN?=
 =?us-ascii?Q?RTmSttBDwZeRtpCLSbQG5WE3okir3T3ROp0DFCk5Fng2VoiP43OWuD8lcj7L?=
 =?us-ascii?Q?+xCk5SPy56CpLVuU09PD9F4YXENbmx6SOsBfcUIL8Q0QxEZgzH8iA5x3oI1Y?=
 =?us-ascii?Q?kViQSDqTQQ8i55P5KjI0wcYh5aUatOxBzkivEjT4OKtnUJhJ8vcGjN/6AlKs?=
 =?us-ascii?Q?p7AjE/mGRy2JX7k9jzA2XLKnfQ6Cmso2alrqWkI+8WxYClNeCLzwgnMFRD7R?=
 =?us-ascii?Q?9JvsAUDaxHDJyOnlTvHWls=3D?=
X-Microsoft-Antispam-Message-Info: Pqf+5qN2rlyCjF6oy7+AKnlXEO8L4gQGcmhzv993PshI5ZWQeoybg0xJeFsg5gSArzoYokXwWtkqnPXsxrICvvHO39znpdQJwyobkLgN/9MgOTnZbJjwJzUs+PTCc4WNEtMZiRV/7MS+Dmxn8Pnfr1zwarBfKAh3KKjVJGFJGs7DnGREKRbqrxJ3Blfc2NVb
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;6:An/QK4/ZFHyOm/fhrZVIYdyKMGeDOI5zdhvFy3n6zlgJyqFlldkQBOxx7mIPImTlcHRWXEqMb1MOZcFhBMRXuATv+upVYU4ngVyW5ghI52hM1GohD43AzP+p9MUiJOX0Gk8HgBSncf24s9D5Rhk9YymPzPHP5yu4LpGeCw4FjjTrIwp/tYQSYTAIKcP66JWzhrhJp4E6xU8ER9fNlxHMWlN0LZ1S6mWfMXW9iflSUbpWoYsj4ODkTLsD7Y7XlXMmJzGC5O++ghQydY7qQXGNz7UyhFOySiX0e1CEnCa97BcR787fvUvofjpSGken0v8pzKObPdG0Few1SCJ5q0GhxkK/EKYj7/Kt7dncRhWo0GuMWu2VkLiPn/bonq4c9jSkryzNaSvhzKP19J6tRHReu6p0zObWV19LXtPte7capHjVq3S9nhzSNZ+EP9L37TxwlGElwqxbEXJjIphcA56W+g==;5:wMJ+9lZwH/bAF7bibl/MhZ9J5vX6LhLwsUXblESAt38uzrFGkEFrjKa7RW5dJ0TmBGGpYIUo+FlMhypaIbsVOEx+yp02ltl7dzQYcTFlygMvDab57zoCJU/bP7XL9I0n125HM8YddxX49dJ/BRnGHka7IXfwhEJu59gJC2QPHDk=;24:DdeVsTUSudlzA9mZVtxuvwjVYok3uRi5meDEZHuofDK/dOxsdUgL+tJ7KbReSXgd45XfL6/H3tfkyUyIqzLTc2adQittX867g7A5DgHGQWk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;7:wujRTSulDZZeaCzzRn9fjAc97G8oJllfKCbcTqn31PNoMZiZHpyUQANugkRJevK76wZ79+tPVPvXPbAcMq6+dn6AIseNtQcQD1KUEmK8HW8vXbMFSh2G8R/rxBdYkyx/PqTe7Q6vxK6/7L+tir9dyV9jcBrOVPD8IQPBh9fluUWTGX489GeSxoBNAlNnqpx/5H99uB7np0fxxKsBcZn3BouQbMwvNRgst3Ls5bspg2sNM3BUuQ9ZkZF+I1uQrPSt;20:fTIOSaFfFL1QyzBYkCX7I5TwMwALlQhXYwINQfPHWoiv83kUmNhcGOdOSjhO2rXlIzK+fCEEWlRNYO9MAwUB5V+VrIQEAvSulkzWfWRin3gyO0oLw1NR/cgq9m5tC5vfFPXaJ7HiCyx7F7nwuRb8SM8GPRea80fsgrd2B6aYSgqSsQ62HD9oWpSFuZZdEGrOrsvevOh8FeBO6unmsDDn51t8M1Y+zOf5oHlPkbDFEcR4f+v9TvJam7x5XpccgM+g
X-MS-Office365-Filtering-Correlation-Id: ce682a0c-5ab8-420d-8c7c-08d5b5657c77
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 04:29:39.2892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce682a0c-5ab8-420d-8c7c-08d5b5657c77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a correction to match acutal hardware configuration.
The hardware configuration looks like:
I2S_BT -> SPK(Max) + DMIC(Adau)
I2S_SP -> DA7219 Headset

No actual products have been shipped with previous configuration.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
This patch is dependent on [V4,10/10] ASoC: amd: dma driver changes for bt i2s instance
https://patchwork.kernel.org/patch/10385381/

 sound/soc/amd/acp-da7219-max98357a.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index ccddc66..566bd26 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -148,7 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -163,7 +163,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -178,7 +178,7 @@ static int cz_dmic_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -204,16 +204,27 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
-		.name = "amd-da7219-play-cap",
-		.stream_name = "Playback and Capture",
+		.name = "amd-da7219-play",
+		.stream_name = "Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.3.auto",
+		.cpu_dai_name = "designware-i2s.1.auto",
 		.codec_dai_name = "da7219-hifi",
 		.codec_name = "i2c-DLGS7219:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
+		.ops = &cz_da7219_cap_ops,
+	},
+	{
+		.name = "amd-da7219-cap",
+		.stream_name = "Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "da7219-hifi",
+		.codec_name = "i2c-DLGS7219:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_da7219_cap_ops,
 	},
@@ -221,7 +232,7 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.name = "amd-max98357-play",
 		.stream_name = "HiFi Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.1.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "HiFi",
 		.codec_name = "MX98357A:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -233,7 +244,7 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.name = "dmic",
 		.stream_name = "DMIC Capture",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
 		.codec_name = "ADAU7002:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-- 
1.9.1
