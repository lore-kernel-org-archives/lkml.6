Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeDXDDM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:03:12 -0400
Received: from mail-by2nam01on0054.outbound.protection.outlook.com ([104.47.34.54]:5095
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932762AbeDXDDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:03:07 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown
Date: Tue, 24 Apr 2018 08:34:37 +0530
Message-ID: <1524539088-9043-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(376002)(346002)(2980300002)(428003)(199004)(189003)(9170700003)(2906002)(476003)(50466002)(336012)(36756003)(106466001)(1671002)(48376002)(8936002)(50226002)(47776003)(8676002)(81166006)(316002)(77096007)(356003)(446003)(11346002)(54906003)(5660300001)(16586007)(26005)(426003)(478600001)(53936002)(72206003)(39060400002)(109986005)(4326008)(86362001)(51416003)(76176011)(2616005)(53416004)(7696005)(104016004)(126002)(105586002)(186003)(6666003)(305945005)(486006)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0758;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT048;1:OlvhnwlE6n087DI507ivIJw15cvou7gLa0DEoiGqABxNqjevbNQNr7NuImuAlQc0p4wj2xCHFl4ZLgxcir3JJqRoI7n+x8MEODmvDT5VBTb56Mc1BX2ia+amxMshMsrI
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0758;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;3:vplTgVqULhtGY88LEBaJcG/djNO4HgSCPjIRZEipUNC+qaqCUPnZVZpKH2eReTd74a9fA9BCcISG/b1m9bbqGAkUUSv0/IPJvjdGvf7ul01lIv6xDw15Ps5hzcxSA/qKUXn8b7DaydFBukzXj5YEA3PvvyleFzRjZX6eBOqhOWz7y8Wbs7hohUASTLssQXJlgh+m7vebdeN1uynXbzlA/ZzI7moLJddSHsi+MtEryaD19sU/QZ2BTS52lIeG6tfjmqPyk+UsA5RwfuHkIe5vGsuzqRovkD/VGJrRFzcxGu6titxaq/zJDL3tPnmc7p51mPQc0CS5nqFyeRMZZXM3ZzW8K+IleRFZp4TQ2zbyb5A=;25:zWV9QeDQuZWgTpnC7yR62Hp2f6VyZK11HtZbFqjpSHarPlcY9ttalPyTLdBUY768IbGd/v+8KXy98ewbivgiXdywVMtOV8otLgxtDrJVDcfE35hD1LLpCGtm4lcoKlvL5NsRZwbYNquOucM+48xsUEe1xxLUpIwMVo0cQstd7Mez4m3CN5E1ETwCY5mRv71Uk9EujXCE7a8L5+sTPSElzvyACm5LRFjYOuweCfLkEqDm+nWOq08tvO0ssdmAply0XXsarFUYMfmrEigEig4jkb64DU67nmTFM9Qwt9B49GsWEsI61nxoyDAYZ22ZzKLC5XI0+HNMJRODnpepCK96DQ==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0758:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;31:YM6etItJKW06MH02FWgtN82NnNaUo0khZzNF689f1G69W6s4xaizBNa00t0oRaPOjHGJisjLU5zrc8FNi1GbsiCw7aC3eitiPQWfmMDJWkTTRRfkfxhFbm3fj2lDAvVf0TAMi7etNreyzjHipVaOUQq8krIHnJJcxbRYfH88frHYm+ccmkj0bymfTIUcq66O2r4YcDxbtiINz4MbL3A43kgQeRsSTMzxYgwhjLAN9WU=;20:XWYTLlt+zdgvvMwb/8IdA9AGXbZprsOlWxadc9ZN1TU0CZjp3vKa+xbhepABK1Kaj0dy7B74dKWGt+MSYNSZeH0shuKyZCPchH67eznNkaY1R6Kaqqh43iMLgqGDypGwoBdml2tl8cWB1BycFaYVg0VdGJiLrfHyXY3KlJy4MTBkBmeg79dMu4Hccr3wPDI/OcHZux8tCb8iJyb9MlCnnS880ZKEPtVMWPf9DC2T+JeinpXjBLwn+UCax9t4thkokF1orUNei4z/J7iJkG5UZvcxKzEqwrQ6CgL2FuWh1f5Vru5NMqUHo6gcL/6UW1Nz5xlsMsHutnzaG6/P7VADy/3gnWw5vosg17kv0W4maygzbLJn0fk/qenWAMqH0Z1PKW8wkq16sXlS3J1DpZeWa+bvfkN/+FKsMyt0/R9cKs5iYpbdHWriEo4O9sRv9LR7aRCsmvcoPZ5DV44ExeRm6W9DZBMiia3T4MKzYEXVR5lxWk+mXO5oL40NUvHhR0NQ
X-Microsoft-Antispam-PRVS: <CY1PR12MB0758937C9545BB34789476D097880@CY1PR12MB0758.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR12MB0758;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0758;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;4:gfE77lQcv1GoH6zEowRaiik8sNAos1/mbf4Hepvfpg9RiH0zHpnS6VdKE7beKKxhl4lW3qJdEpim0Fozi2mwjMB/G4JzPZAR/eSozmRmXw0OvCybfTmpR7PI3M3xsLhw8d3zNRP2eCVdeBaMn7WjUnskVTTLh+JjHtgjEQTHSzx99uNlvMrnwNd22dU5Dzpu3pZ7kOECmilR8d4jlYEO/NaFON2JIjxoSYHEX46l/aVjwh9tn+CZyx4ET+At60eFxLDYuBnpL9DZ1HXDZWhQN45kwlt9lm+vmhwqHPeQs0Cf3Am15UXPPAsJplWo91JV
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0758;23:gbOxoHHYPsAQiwAV9iYFJm1Z0hjGC2shaPbWUHgtE?=
 =?us-ascii?Q?QQCSCu1VthC9eXq2iswzSwynF5JdocZ7Ybs9qLI6aNJqwBrximcdOfqJT8p/?=
 =?us-ascii?Q?l1z/mTyfyneuRwxQuzP56Nls3c0Lq4QF4io/wxgBQCV25Z9tgkCL9c1FDT9M?=
 =?us-ascii?Q?aTZRxNs9ZU6IhWSdFNkG7LIKfPlYVm/eCECaS9yFLhXXIILgfjgdy1K/rkhk?=
 =?us-ascii?Q?ZP5c4IWXGl+sMVJ1hR1LDQLgvUOoNaH1aH6gUbz/odBi+daKEq9ahxfCXZJM?=
 =?us-ascii?Q?OoHZ4LiU0hTOQO55YoVPZyUYgggLR4Nh6lGnCmVmXl7Xnn3QekJIv1Kk5Ocj?=
 =?us-ascii?Q?fYxJpa56GqVsH4xnMZDg/hmKaFWh95g7bNR+Jcw+1Iqbv0+XWSGei1ykShsq?=
 =?us-ascii?Q?9htk4lkoV0Ixcyl1WYO3hvQTzNyMI6MuqT+DTr2PpNS4dkO4a2A+RshTlHtL?=
 =?us-ascii?Q?4nvijYzW4DJbLRsydMk4XvSE5Y4Ji0XTHfg/y2i/4MxXHXhbq18bb5wpoFIO?=
 =?us-ascii?Q?rYxow4DdNH1pFx/CMp6Llsbp3+Npg4Wk2sKg3DQZ+Py3IcRINIsHu6R9LLzo?=
 =?us-ascii?Q?dkbg94a1vmuR5HirY2QC0bUzzj951vNWeVUnQux9vjcRxwy0Wf9QL2rgTi5v?=
 =?us-ascii?Q?nu+r4epPHDqUeDh02DXaNZxp1mYkynlyNrADP2zEM5Nm103J5soTO3fdsnOd?=
 =?us-ascii?Q?egZoZ5UhAghAQadwCSgtNpzsvwqhwWf8QBOOsOug+3/mLqsYS80wTf7vIOG5?=
 =?us-ascii?Q?XPP0NeXDoJl/6A7zZ8Z64SG1qBnGOj2KcOjYq0tRyjVIUzyTnZsM8vCf8MEv?=
 =?us-ascii?Q?vV0Oxkjtk2lD9hnJDmpDhY4zgnzPkaqK6coWP50vhmOuCLK3E5tZjYSkezsq?=
 =?us-ascii?Q?sPAE4srzQAqbP2o32f9/tkuNsot3aABFiWuCyfL1Gm6tMq7Dn+bUAyZwSlAk?=
 =?us-ascii?Q?W0rwA3ae0BVDdKyYLtTQ1SHGBFx2Ba3HBXCSq0PpAQrgswSSeozBEgWo0p6w?=
 =?us-ascii?Q?lmBvk0uNLZlKIGMer5CqFlxKjBq4He9tpFG+clj1ULE+IjqUpc1diil0Ct8O?=
 =?us-ascii?Q?QSD+9usVdlCXbcszCTapvZyKBoBzvjZI9zIJ5Soy+tGOxs3RP8LphtGfKWdC?=
 =?us-ascii?Q?/4k6OymphQbDZf8DXyazC2m2YqvRtAC41Z1vsQdSBXN2x0mD5hEHuJjJ2aT+?=
 =?us-ascii?Q?UnAysXxsoLtTok=3D?=
X-Microsoft-Antispam-Message-Info: hKUG8NKXDjbIMjWCp8EoUB5Tvv6W6sR5F6L+9zHET3vmXRc4cbmRkXqaDLBKw7PEm+7Q1Lu/KXFaVe32zZ9H/kqbpMonSiQXaPrvUuxtKHPaOedISfn1ROnDx/eF2YX2w/56bWkmAJATXU/bJYrx1DOZ35QdNxEE5DlhdoL6LD+5ELY/kKYTA6my6YoCeF7r
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;6:Q6KX6fGyx5GN9x6+brFjIkZXxeOdIxsK0Iu7s3YSTX32hweeGm377e2LS1P/HKYNGAv4HXwRF9Q327oDiidcP0j+ptHOnnkK/yBFTzLKY1F/oTDzx3ezaQlqV99Ubzwsqc8d4Fe0OqjTvD75MpRr4fnxLzJkJ4+7jEF7a35hyO2A9X2L6dnbID/l9VMiuKMidodBFcwJguDmTgr2t9PEA+DTcV2nq5FA9hOTQif64kiwIUJC+C/bLN2w8x6P7/3lK+4ruB2R66AAyATaq32CzbXG8iZuuxFlpyT3q5DOzGYkNm5stnTAIHZyXu+d2NZ1YIu6YlXiRp0PRIZzsFedr7Mnx0ImYmFRDsiAQNmCGh8bMjFgpvZQheXX251MPmJJ+Izj7LXtxYcQjl7YD81AG1ujpJ2gY74yTfrysFlHy5TWo7RQfUguD63WM52vjAsMn++rSEErImxE1oUBEqsM3w==;5:W/a7EBOm1Y+jx6KH+MXxs2EtkZMggoSEN561J8RzUOWPhNkefvEww6RGcBpl0b+Mbx0qrSI+IiU9S7+obOh/MvIj4y68zg3ms7UW9p3Ono6hGA1tsPKVMnQMXYlSFXxX2VjmhZWcqxd4S1bzx5trbsBFC8iyxcJXVdjLFHPw1xg=;24:CWdrRc9Yxy6sEPe8rXkRwLKy/8P369m5hzIcbDsrkV84M5BCeE5cDPKlSLkmkVxf8MEe3h5+zTZXUqY/QovLU3seKqX2oSDqNjQMeQDbNWU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0758;7:mUqQ96KCnfJxhAukOoPTgpq4Uq6LCblTYgp4LID1h+ftpu9keeYtx13sApseXJIIM+UbXxnQk/aOWG3IlF9Hp3u1yh4aZEn7J+9zNh7w3pVZLJJI1kP6iP8fMZ4TbIB7qZce6l/6P3XWLy0lWRXZS4LWknvp2DNrful8HdXDausqntdTl4qz2ogChSAWcEVteiOoFd4txqwERaWCO8n5binOhUC043at2I5idbLNBcrhOn8GdBSkCKW2+zWvEGDZ;20:kdBGeqNXato6RL9oj4VVJAqTBBPPpYeOQPry2tHx5/7rSfXRiiy9hTqFSDE1NmyCSlEykchoGrfjN2XibayjvPC3ZCyNmO5nOD51NsXKRfSVoRN5H9SVgt86xCTmn/z1HcA0qklF8+Srjqkeel5aBM3HEYfNTtThQCJ0NKJw2r0Zy1NurXPqTWp0YVbEXNY3B2epv6XvVyGj4jnLtRfgbWxeRHv+e2+GtLuZy5Df+GJkRgrWDWDEl7TtedGv8H5Q
X-MS-Office365-Filtering-Correlation-Id: e9c80dba-e6a5-41ed-8567-08d5a98fe6b2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 03:03:05.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c80dba-e6a5-41ed-8567-08d5a98fe6b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0758
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

hw_param can be called multiple times and thus we can have
more clk enable. The clk may not get diabled due to refcounting.
startup/shutdown ensures single clk enable/disable call.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 54 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..0f16f6d 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -38,8 +38,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 24000000
-#define MCLK_RATE 24576000
+#define CZ_PLAT_CLK 25000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
@@ -62,7 +61,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
-				  CZ_PLAT_CLK, MCLK_RATE);
+				  CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 		return ret;
@@ -85,8 +84,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -100,11 +98,9 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
+static void da7219_clk_disable(void)
 {
 	clk_disable_unprepare(da7219_dai_clk);
-
-	return 0;
 }
 
 static const unsigned int channels[] = {
@@ -127,7 +123,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int cz_fe_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -141,23 +137,47 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	return 0;
+	return da7219_clk_enable(substream);
+}
+
+static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_max_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_max_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_dmic_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
 }
 
 static struct snd_soc_ops cz_da7219_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
-	.startup = cz_fe_startup,
+	.startup = cz_da7219_startup,
+	.shutdown = cz_da7219_shutdown,
 };
 
 static struct snd_soc_ops cz_max_play_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_max_startup,
+	.shutdown = cz_max_shutdown,
 };
 
 static struct snd_soc_ops cz_dmic_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_dmic_startup,
+	.shutdown = cz_dmic_shutdown,
 };
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
-- 
2.7.4
