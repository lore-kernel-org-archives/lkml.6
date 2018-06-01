Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbeFAF2y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 01:28:54 -0400
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com ([104.47.32.45]:14359
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750750AbeFAF2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 01:28:52 -0400
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Configure channel 1 or channel 0 for capture
Date: Fri,  1 Jun 2018 13:27:05 +0800
Message-Id: <1527830849-12524-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (10.174.56.146) To
 SN1PR12MB2367.namprd12.prod.outlook.com (52.132.194.148)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2367;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;3:vNMvznfliVR1au/AIvJjJFcGJUs2EZSdE/3adZXwn84jmOfxcxu4JrUbUfUzJl9X7n2ej6Y4saF3TNOsTeaMXHOCCTI2+fdqxgeDMpkkk9S2Id1MV/LtJQ+02AVk1Ip1n7X6X1u9RpBQJ4UB1M6ggE9kWcGW6ENvX1riANiJlN7rWCAolYr9L4xlOubEJcpXI6z9yprY7bD5vzPH3VTbKXkrKnOkglc1jCxWKpJJejM9vtpcNXXIfgFoNXsxJgGY;25:VCbEGk/a8minnicYL+LfsEp55dlGZBycASm4lia8hmg9NU6LEPU0d/TfSQelRhAsvmBsX7rrTL51gQ+qp9Ac2x4qqrFclVsFJpaZGwFsFZ/0RF6zecBLwf701rFIhFXjVfdBW0/OZO8K5RYw9p5QuxQRv5nUkuz8fnraWq+hGi3nOqwAoD47EWHgJQ+9/klTQLhqC++jWCavn+nAe3n9WjYOBCvwnmmlsUg9HC5SmmEkhy7jp4rbTNbxsm9auUCLtTUz16zQE8E5D7IRJFMl8KwBVQhW+Brjmb8QE6MeCUV48BbCYtXsyFAMIENhJ3Ey67wBLIWz6fm6gFR9HfGhSA==;31:SWZ6+rn9XckqghiKKx2S0CaZgHCqvPc9U2F31MUnleZIqT+s+d0qebwTKwDAyMZdbPrJYcoBGy7dZqhAUebjyzggBr9YvpaVseN7+9TJ8HXdo+Q1hVab7wtNFOXzTGoT9VPxTz1XL8ZNRZNiWCMjg8M+X5t+KlZzo3gKr8AGbc9tuEbsW35tzLhfkCPFM5drik9953dTnf54hu6XjWsmYN2ZckcA6m6TTKKUlWyhrnw=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;20:d6eqm7Z5ioIWkWrOpco43jy9SwlnX1vj+d3GtEOoxD+Q0JP5PB4XNdmgpnPt7OlZEPcRUwqrFfNqRsjQ4FqzDC5aP8aeJfTp9ccsqLQcDQrvxkdcpxlJ6uU3cOJ7B3ZJCAxqnOGCGVd9FRj0KEjhLm+SgrgHW5OOhVcNSjwccCx9KxE0Yq91gQb7EWVvRjEEhnZ+NiWeXuqJqxddqwkk9LxWqQ6FFL576lJzJo3iJ1y9hbtEec0QDMDniBx0PAL+DA7eyBO2oLLANZXsO5n2gfqAUUrFTyNNs23uVBbJZgzh0OYvXmunTQxURoEOTE9GerIO58YAeGWEA/H5oV6/qAAY3y3FtosB1MbPOgPmGhd//Vp0+/9TtyJZwnEKYlM9ocBnsLLRhyp+RE8srYAygvEI3tcn1+iDezwfVVkYDrFraZHYQsOV3BjoXqhECHnvyg0g7WrQchbpiZFLwVl5+b/fkR9YxEmG/DM7RqCy80wjDlc2SShsiAjb6Y5IGfNH;4:b3KHEvOpRbIJyH+BQ2CUPGO6jUIq4u+8VjlOK1KyqqsSzvGq/gdMvDjDv7Z+EO5ydzZr5g78kELrr3Z7cA/7itUPnQZX0BZeCVYP9zT03fMzo8FPnK+BcLMSiGImzWv2FkqYiiF39RWd7ymag1GwVx4Ot4zNHJ8ar0SPWapcbjIB4CO3UjEiZ9Zfy/StJ1r3DV/ICJB7O/UX5f3/XQTGdDYPll2n5/SoNrFvRC481+bQhx6lsKVyyMxVQgurG7boqOnT0/zw/g0qOk6/42HcrcU/cYXH1HbcvEEBNPG9vgBjHFmhIdAXmgV4NAiKINNA
X-Microsoft-Antispam-PRVS: <SN1PR12MB2367DE0D87BB6D415DE6677BF8620@SN1PR12MB2367.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2367;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2367;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(39380400002)(396003)(346002)(189003)(199004)(44832011)(97736004)(2906002)(6666003)(486006)(7416002)(2616005)(476003)(305945005)(1671002)(50226002)(25786009)(316002)(7736002)(48376002)(8936002)(47776003)(8676002)(81156014)(81166006)(54906003)(50466002)(66066001)(36756003)(51416003)(4326008)(186003)(6116002)(53416004)(3846002)(6306002)(109986005)(39060400002)(16526019)(7696005)(966005)(86362001)(68736007)(16586007)(1857600001)(26005)(386003)(106356001)(5660300001)(72206003)(6486002)(478600001)(53936002)(59450400001)(956004)(105586002)(52116002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2367;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:3;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2367;23:ELcjADklxMzB8nsxLoKh/XzrQlJ3Fuqh6nG+gNH0l?=
 =?us-ascii?Q?7532zdrWqLPoQxUhjUW4bvCBK8KtTnogDSEwVXMtagRmDRb/ayOFSGZ5l2cE?=
 =?us-ascii?Q?BraCbmAeHcur8pL3N+2eeBTuz0FJdm1keaWXn2ZdhbqfTZWeG+RD6uf00fYY?=
 =?us-ascii?Q?w5BTDDlIiBn9bwhID0726TSUE+4nOaz2HPeKNGgPFScVR8lKKEdq1a5640AL?=
 =?us-ascii?Q?VWFuwwMQvjhgIVrtrD29H0kGpNOeL2pyWoCCLqd1xIXWoZJUIRDaBkFmx77W?=
 =?us-ascii?Q?X2/elc1YIUfYZNINeHKA/0zmFXSLCv3j2TJPlOXIoXnk1XpWd/s1rij/LTRC?=
 =?us-ascii?Q?m8UkRtyNJpw2mOoI7JBSnI13H2i5G/S5Imu1rAokmcf5iPzcmMRnwhe0Ph1n?=
 =?us-ascii?Q?OAZPrHsb2BEAPegHrPmAZBhSjfX0bDDFyleqG+9fZ2tukpXaJ0KmJsxKZ+ZS?=
 =?us-ascii?Q?Tjubu1nUr7K7F0+lQGC/CEjNF/TSC5XXaN/HaC2S2bWmpgi4lvCs90RBoe3X?=
 =?us-ascii?Q?GAMuQjrHYJM0UCrw8B4aMfYBQrFEKDlAxE+II9jBuOMnxezceIEvLI1xBYph?=
 =?us-ascii?Q?nYC/kQAyEGv12IQKvZWO3U23aMCJXORYtOoHlwjwwLO3YNwiSh19E/RO6CeH?=
 =?us-ascii?Q?vZJ92Qi0OWyg+mozSruMUqeZB/LtBWCLjXMO8iwu17GjwAYXOm02/BZZZbNk?=
 =?us-ascii?Q?vLYQKvIy4sxLWpIanOBAzxOGef1cULJX7O4AxCcCxOjZe9qSuAy4JC3+chBW?=
 =?us-ascii?Q?0zEY5k2WssB78GMrQ5vYcUqnAUTyM+qPOpIP3FCvXdlZQv37VDJIuT71slxQ?=
 =?us-ascii?Q?KNKq442ZsvaePgmlJtO1s2c9Y3QsQGtHT47mki1Rs/IJdKcHFqrebZfUuIOh?=
 =?us-ascii?Q?VbiFKs2dbdCHzw27moG5qFqMvkcGkSjdJCsn70T2o7mTubg7LL1ENEl8a2di?=
 =?us-ascii?Q?Dh0X/ODDSbEeq9uMiU4oxxuTqLT6t1+F3aO9EDopS5FAdMETw6aWreu3skrM?=
 =?us-ascii?Q?prxf0e2fIzL24JZ9MiscfMo/qeQY0h0eJDzjQGxJ8INhqahWCAgee32/hyxZ?=
 =?us-ascii?Q?jhCSE0CboEVhOO+Ggdv7bM4R0J4YUItXZYTFs5fSUVcWV0wJAsbvx0t+kS2g?=
 =?us-ascii?Q?IOBULsakwDVb40NdnYK/RZa33Omg1AJgaLFCSxgVRJbNFkGFlsv+u1zzckt8?=
 =?us-ascii?Q?eufchz8XNJbAwUTF7hLEue+e6qz0j/xPJn389pVrkZFafOnXKoCXR0gBeRSc?=
 =?us-ascii?Q?1zF76/kQrg9oNaKtBgwHbN9maNmhNpUydobQCRcbG2ZyA4yXRYhch0Fx/ksk?=
 =?us-ascii?Q?gwF0ilkCkYK+Y1Np1TaD/K9mw9/XOmda95RRxVfVTL6cqPhoOcD/+WoQjEB+?=
 =?us-ascii?Q?3Nr1A=3D=3D?=
X-Microsoft-Antispam-Message-Info: m4/E3d51YxlItgTWqPG0+2RjOiOwgDRCcZTqJbzdrL+rFGugm9/IiWfbfQyCqoIan84q4DVbGTbvROtoiSQQ6xpocjQPNk6+2fYjX1xHTiCcNbqJKpodVoUo9fsTMHfKmbPRYFEbYq4ZK3RyIR4g+/1TW6qxrvnTRiEWyHVK2QEOltLE6Byo99C73gN0DpSw
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;6:4bwVGzPuDsJvLlhCgZOpGu+zSv3E64mk56pXx3jHwwWT2rG93LTgxviM8DpwxnzsZiS2h8uX7hPqDHvT3+An/Jj3wQMTc8UEy51wuQmD8ABuF3ho0/mVxkMksoAjeaJXx+YM3taa9k2TEJ0t42p5p/MjSxiwSF2TO2lYaZmx9RRBaLFsD8wEOqpfG9SVgmbhz6XTDy+IZJg57v0que57j3Hqz1yihAWO97Z0FXQml/Ocptc6ifpOvBFxlbbzulNGe94+nkeh1JRyKRGqle/65/5Q3y+yYqvX1laUw0nTL2ZNgWpCu+8ipMZ2L/eH0bW0N7yvyw8U+YlzjYgRIKt8PxZtOZdxfkGvJ0d7mcA1bJyMPH0BEoDZZkJE6R4QcM/WtvJfq0wElSL6CBxdZVtHk7eTnbxTm6GNNRyilA7qM7xqaXCwjddlOs5xkIzDBRI5WHCgehrj08hqN9zqSxkPtg==;5:4eHCbwnqPgoiweVMbs+hoFAhnzCq6s39I6HKTud8sqgl4OKcF6hK0mVNxfUA5FgtVLsFf+8W7rEnD1PNa4+XZL/d3p5U7KUKL4+jHolSX1WhjM/SD70BGRqvF5IyPanB8nT0l9J9S6stdTU6emJgd0+fWrBJ66Ihp6rlBLkztb0=;24:mDD2UhvFetGe1U+1JoCucbbWdf3WdnTJrUgQ/ErkBvcPXmCa90QxDIYGS5mRzsw+XolFHfo81tHUK1i4mNpWFPYJUbLUjyo75P+Fn8i0UDs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;7:Ta9ii/GcVuvYDDmpp695NS8k1SvwxhYtbPODAKGLWcNtzxg+1kEHdWKGlJ3ZnwWWSXEc89AY+Ewhvu6YFn460BsEXhiEIWFuUT8Oq+cNtDq14feDZWHHpG8hKPSo/+2jWIfb0pMg3fzwp3yjCeLk4lkQ4oQ+3CowLSBHuqbl/LufSEcW8mp8aalGRuCZAUTu3rZgj9+eE3SvErt4eWHPHQ/xYHJ8rMVRIvufTa1Fe69soQ2B/dF6BU8eCcKtV+3L;20:Cx7zdMzsRbwS/Fghmkv0yqlBrs+Qj/W72ETPUiPAkaYlHItIvSC5zYYxcwLJ6FGKhUySdJQmDWammsjmD0Am8mc1Ez+rJhxnUnHmH/SeqmHh5z6msA4BhnQYa2uaod91QHKm9zN23YopG7gpgkTj0HjYE1NqkZL7wrw91f4Mxx+cz1Yfg46kqCA/pTlhA7eD2KXOJTrfc8UP3KokyhORvd8e73ZC1MHqAJt8k6kI8jfx4ebp7cb3fYw7xPcnthwG
X-MS-Office365-Filtering-Correlation-Id: d026c866-2c7b-42f5-e8b6-08d5c7808d68
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 05:28:39.5464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d026c866-2c7b-42f5-e8b6-08d5c7808d68
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST/CZ SoC have 2 channels for capture in the I2SSP path.
The DMA though these channels is done using the same dma
descriptors.
We configure the channel and enable it on the basis of
channel selected by machine driver. Machine driver knows
which codec sits on which channel and thus sends the information
to dma driver.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
This patch is dependent on ASoC: AMD: Change codec to channel link as per hardware redesign
https://patchwork.kernel.org/patch/10388099/

 sound/soc/amd/acp-da7219-max98357a.c | 43 +++++++++++++++++---
 sound/soc/amd/acp-pcm-dma.c          | 79 +++++++++++++++++++++++++++++++++++-
 sound/soc/amd/acp.h                  |  4 ++
 3 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 566bd26..f42606e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -149,6 +149,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->capture_channel = CAP_CHANNEL1;
 	return da7219_clk_enable(substream);
 }
 
@@ -172,7 +173,7 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
-static int cz_dmic_startup(struct snd_pcm_substream *substream)
+static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
@@ -182,6 +183,17 @@ static int cz_dmic_startup(struct snd_pcm_substream *substream)
 	return da7219_clk_enable(substream);
 }
 
+static int cz_dmic1_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->capture_channel = CAP_CHANNEL0;
+	return da7219_clk_enable(substream);
+}
+
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 {
 	da7219_clk_disable();
@@ -197,8 +209,13 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	.shutdown = cz_max_shutdown,
 };
 
-static const struct snd_soc_ops cz_dmic_cap_ops = {
-	.startup = cz_dmic_startup,
+static const struct snd_soc_ops cz_dmic0_cap_ops = {
+	.startup = cz_dmic0_startup,
+	.shutdown = cz_dmic_shutdown,
+};
+
+static const struct snd_soc_ops cz_dmic1_cap_ops = {
+	.startup = cz_dmic1_startup,
 	.shutdown = cz_dmic_shutdown,
 };
 
@@ -241,8 +258,9 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.ops = &cz_max_play_ops,
 	},
 	{
-		.name = "dmic",
-		.stream_name = "DMIC Capture",
+		/* C panel DMIC */
+		.name = "dmic0",
+		.stream_name = "DMIC0 Capture",
 		.platform_name = "acp_audio_dma.0.auto",
 		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
@@ -250,7 +268,20 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
-		.ops = &cz_dmic_cap_ops,
+		.ops = &cz_dmic0_cap_ops,
+	},
+	{
+		/* A/B panel DMIC */
+		.name = "dmic1",
+		.stream_name = "DMIC1 Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "adau7002-hifi",
+		.codec_name = "ADAU7002:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.dpcm_capture = 1,
+		.ops = &cz_dmic1_cap_ops,
 	},
 };
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 7720384..ad85354 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -336,6 +336,68 @@ static void config_acp_dma(void __iomem *acp_mmio,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
 
+static void acp_dma_cap_channel(void __iomem *acp_mmio, u16 cap_channel,
+				bool enable)
+{
+	u32 val;
+
+	if (enable) {
+		switch (cap_channel) {
+		case CAP_CHANNEL1:
+			val = acp_reg_read(acp_mmio,
+					   mmACP_I2S_16BIT_RESOLUTION_EN);
+			if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
+				acp_reg_write(0x0, acp_mmio,
+					      mmACP_I2SMICSP_RER1);
+				/* Set 16bit resolution on capture */
+				acp_reg_write(0x2, acp_mmio,
+					      mmACP_I2SMICSP_RCR1);
+			}
+			val = acp_reg_read(acp_mmio, mmACP_I2SMICSP_IMR1);
+			val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+			val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+			acp_reg_write(val, acp_mmio, mmACP_I2SMICSP_IMR1);
+			acp_reg_write(0x1, acp_mmio, mmACP_I2SMICSP_RER1);
+			break;
+		case CAP_CHANNEL0:
+		default:
+			val = acp_reg_read(acp_mmio,
+					   mmACP_I2S_16BIT_RESOLUTION_EN);
+			if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
+				acp_reg_write(0x0, acp_mmio,
+					      mmACP_I2SMICSP_RER0);
+				/* Set 16bit resolution on capture */
+				acp_reg_write(0x2, acp_mmio,
+					      mmACP_I2SMICSP_RCR0);
+			}
+			val = acp_reg_read(acp_mmio, mmACP_I2SMICSP_IMR0);
+			val &= ~ACP_I2SMICSP_IMR0__I2SMICSP_RXDAM_MASK;
+			val &= ~ACP_I2SMICSP_IMR0__I2SMICSP_RXFOM_MASK;
+			acp_reg_write(val, acp_mmio, mmACP_I2SMICSP_IMR0);
+			acp_reg_write(0x1, acp_mmio, mmACP_I2SMICSP_RER0);
+			break;
+		}
+	} else {
+		switch (cap_channel) {
+		case CAP_CHANNEL1:
+			val = acp_reg_read(acp_mmio, mmACP_I2SMICSP_IMR1);
+			val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+			val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+			acp_reg_write(val, acp_mmio, mmACP_I2SMICSP_IMR1);
+			acp_reg_write(0x0, acp_mmio, mmACP_I2SMICSP_RER1);
+			break;
+		case CAP_CHANNEL0:
+		default:
+			val = acp_reg_read(acp_mmio, mmACP_I2SMICSP_IMR0);
+			val |= ACP_I2SMICSP_IMR0__I2SMICSP_RXDAM_MASK;
+			val |= ACP_I2SMICSP_IMR0__I2SMICSP_RXFOM_MASK;
+			acp_reg_write(val, acp_mmio, mmACP_I2SMICSP_IMR0);
+			acp_reg_write(0x0, acp_mmio, mmACP_I2SMICSP_RER0);
+			break;
+		}
+	}
+}
+
 /* Start a given DMA channel transfer */
 static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 {
@@ -773,7 +835,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
-	rtd->i2s_instance = pinfo->i2s_instance;
+	if (pinfo) {
+		rtd->i2s_instance = pinfo->i2s_instance;
+		rtd->capture_channel = pinfo->capture_channel;
+	}
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
@@ -989,6 +1054,18 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		} else {
+			if (rtd->capture_channel == CAP_CHANNEL0) {
+				acp_dma_cap_channel(rtd->acp_mmio,
+						    CAP_CHANNEL1, false);
+				acp_dma_cap_channel(rtd->acp_mmio,
+						    CAP_CHANNEL0, true);
+			}
+			if (rtd->capture_channel == CAP_CHANNEL1) {
+				acp_dma_cap_channel(rtd->acp_mmio,
+						    CAP_CHANNEL0, false);
+				acp_dma_cap_channel(rtd->acp_mmio,
+						    CAP_CHANNEL1, true);
+			}
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 9cd3e96..3190fdc 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -55,6 +55,8 @@
 
 #define I2S_SP_INSTANCE                 0x01
 #define I2S_BT_INSTANCE                 0x02
+#define CAP_CHANNEL0			0x00
+#define CAP_CHANNEL1			0x01
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -125,6 +127,7 @@ struct audio_substream_data {
 	unsigned int order;
 	u16 num_of_pages;
 	u16 i2s_instance;
+	u16 capture_channel;
 	u16 direction;
 	u16 ch1;
 	u16 ch2;
@@ -155,6 +158,7 @@ struct audio_drv_data {
  */
 struct acp_platform_info {
 	u16 i2s_instance;
+	u16 capture_channel;
 };
 
 union acp_dma_count {
-- 
1.9.1
