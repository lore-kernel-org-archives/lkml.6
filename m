Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeDQE6S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:58:18 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:33696
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751086AbeDQE6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:58:15 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ASoC: dwc: I2S Controller instance param added
Date: Tue, 17 Apr 2018 10:29:51 +0530
Message-ID: <1523941201-15665-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(376002)(396003)(2980300002)(428003)(199004)(189003)(72206003)(5660300001)(39060400002)(48376002)(68736007)(356003)(86362001)(2906002)(50466002)(305945005)(7416002)(1671002)(106466001)(16586007)(6666003)(2616005)(97736004)(316002)(54906003)(11346002)(446003)(426003)(47776003)(36756003)(53416004)(105586002)(109986005)(81166006)(478600001)(53936002)(4326008)(104016004)(81156014)(51416003)(7696005)(8676002)(486006)(476003)(126002)(8936002)(26005)(186003)(336012)(76176011)(50226002)(77096007)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2431;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT012;1:OdVVG1d/9sJTcGKiwp0WRrF2SSEtgehkime6+wmrEC83+V/im4tPl4NYbS7aAV20yadfPNqeMMoWPhB+PnJ+9Srb/zSLoL5Q7lmZl/C7KYK4J9EMK3E7A9sMZSSaXQDj
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR12MB2431;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2431;3:NWltbvwitJet6vpTMzHeFnT3i+sbleEsUlcCJb9gGakuHnb9MkB4HiwaWnXbtlMZilraegwfPCOA8jKno8rlq0LWbj+h914Sv4K0IyX9lZBHERlyGY4ajcGvA44bQ9gjM/OIdrorbiVn1uPFyJ/juBF4i1F6/pAIUcRdPqcJDPpXCKSwKjEBChJDsoZL6l3XK6OLnVO8LPY+VREfagOHxFD9QSq3PCExLepiwjvAqLaXN5o7b7LXmBmmObEiRqLqCIbW0VOQMGtx6ifxRC4m2KOUWmAFWYeRWrG3g7J8SE1bdLBrhHxlAk0mDuwcQ3E0GqWuIo16neuqWwr6/UPs+6ZgMF0edXLrd3vZshYjDmw=;25:xfCi13d/7bp/cj+bhUc6j/L9Eo1KITgAo9BicEf9e70jeNdTe+a+Q7N8pCS6kmjL0TDEQNNdZI/PB48KpvSAegvcXR/R27bgflmTVSi8hXCF+QKmAIOqbS865Y1ZvU4vBuGEJMt35I/XwTsC00KAPu1uAiEKrJTeSwN0uC5FI4L9DXIrmGP/WdR74fXyQUs+MpPtstrLSg1a5g87WN4NM8gBBYjCLStjHu1Z8osyQg3A6PZb0/zHGVkiTbvM4V0x0CrBLgBGXOug4fDHRHDxOBuZ9JqAFFGXvo9I97X48mQTlCeIxejaeeL/cSR4wraDqb2ewLoLVSRUNc8cmSYjrQ==
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2431;31:+yKmp/rCZpfV3XiFc1VMPz6V9tgeGynjLrJz4O2ivMUASBjFYiupUit4Zi/8m54EP3QzLeLrqwo2EtU+kgId/KTSPN8IqNcEUl57vIYfIbP/JSKZ0jtypTXTmNlXI46GZ07onxJLh4Fb7Xlb32cnr+D2rmdxW1sAgFOQ7F+KqC0zdg8wwPVVDKwXBZr7uewl6f8HhOZMjMcCoxTKn9YQw6Cq9qZYgq0OzAQ+JsD2K3g=;20:A+M8NHS2YakEf1lNYLBwnrrL+3FvonLNo8JTkaHss+7vQSMFJ25VWeTu3Mx6wASapQrugdgnLbTityhE1TwTIx5F3ffx+0DHsD8zVAgp2rgqGdkRHXKUVzsqfgj6PFsxTO6gVZ9/JaoKVw2HqHxoSbI7qyrQKYm77DB73bO+yNiAB8molyz/AqCoOpDnah+r9ieKYFskdHsNpNjilHZ3nLOMx7W+1L8Sj+kQ/NVi2Q7bEMrSnH61fbAox9AhTuZottkMMNe0O9g9LFi9o3XSf3AcVV8pBhtcZG4g5yE+iV51j3LznAC+FVPniK57NjnKISYyUfd0O/U4MGLi/Xh5qLlU26ouqveOMi9s4lid1wKqkGWCysnvkso83c+9wvBgkZQNMqXfmXwqSLkghAGeQeNKT+xSzI7NyC7lDmC2fBd9qzhby/c6nmLRs0Q2i1ZUFsdWf53XkrxKfSnDd81HpPg9Vzar8n+cq3/OYBhjEXRnve+ve1JatIqwuEWPlFni
X-Microsoft-Antispam-PRVS: <SN1PR12MB24311C791CDE4294454B254897B70@SN1PR12MB2431.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(93006095)(93003095)(10201501046)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB2431;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2431;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2431;4:/XyxrKs69iwIsQYnRvUmZXzk5i+sczhTreSJ08l0axJJDBUwzC/jFEt/MbL/Sr/WTWS8MOtZ+nQBBwJBRxekjbl79wtODOsT6+Yd5MLnEVl8TyAxZX0fRdt0j2N0D5ELVAFNMfAJVXLCEDAjXRDgksT+WT1C6y1Czc9uWRbYfoZWMge9hZAGsyFttGv7gOP8BMdl+jlsFkjzHapaZ5JVhKod9LmAZAQBXNWea2+SojNxENHgeIZ0rKMJxZwfBDV5LmTiuTvtrzH0o2OonE6pfLlgxkKflkAnMVy3TWVl+LiCMfFI9z9Zr2lJHxBjhANv
X-Forefront-PRVS: 0645BEB7AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2431;23:XfxyKX6+E7yyF7aqLmusPhF+p/ahVQ5TLNkrr4eeO?=
 =?us-ascii?Q?xWbDm8XGk+libnLQI1yzGdsCPje/1rQS7An4kJ2+FqK6pw7VYzFaHWdsGX4o?=
 =?us-ascii?Q?JLUomvl2Cx6HzT0QmCrfpgiVbHHgYw17BIEK7qQqbHEqbH/ucO9gJCwLtDx1?=
 =?us-ascii?Q?wfz9XhjsZz2BQFPPNYOP4llI4KY2lj4V7S6bL/JC23NBFEKQUEG+aSO0YBBU?=
 =?us-ascii?Q?o0TmUCOM/yT8FthMH34sEwHFpkmd8d2mjGcaPD0930/Sv5DxxRG0h8rXFzvn?=
 =?us-ascii?Q?GU+6ZgjF60oBla2xRePljJ0vQJcUEkFoVltYLbGipF0UbWEU20f6e793t4ea?=
 =?us-ascii?Q?5MCoWmW9HHymUFywoKyZw6dwarjSdoRN2tVGxlmDVo3PDuHH0iIFyya6BPCn?=
 =?us-ascii?Q?xFq1FijHYr1a/2PuY6fQaIxVh1s19nYjW1uxCjN6VOYr3ldh7GuQR2wikVif?=
 =?us-ascii?Q?arxuMuXs0VP65qZUgpD42lwGbVKyMUb/3Vc5otlzXF9KSPKW2cWqMSgGhb4S?=
 =?us-ascii?Q?9k0AXQvnA17sh5iTzhPQGjHm6oESm6IHyKEn676PyBGPggjoh9Wt59L4ZfHC?=
 =?us-ascii?Q?A5HypjorULaqB63FoG0aalGktNqWF2ZOr38pohFUsJyYSOzswSalTeUVb9UO?=
 =?us-ascii?Q?rMuNU0WYaZCgK4CIXGH2LQ5v7CN+dIup65ANpF9QE5NApi/66OQaGFcgPUxC?=
 =?us-ascii?Q?PNqnv5/bN8EUMpqQFgLzkIGp/zV9Fs5FjQNRlEZX0fZfZogcPrW9Kib/CwzK?=
 =?us-ascii?Q?fF1znF+DOLLILFb1WriWS+jaUDyJSav5zl/W6tm/m6ENNEaEqkraGivYC2wK?=
 =?us-ascii?Q?XVYJCs36XnkRD+cmi/MBh9SR+8uMMVsW36HLtOuq7iXi9CQfRv67cuXUp8L2?=
 =?us-ascii?Q?N7vtfys6mEY4B34ACm21NMVDj68xidzUpyUusfc0OUJyl+PSRwGy8ZWkaPmk?=
 =?us-ascii?Q?JETEvvMdQ3mXwpE/+LKBzuO8GBB6BUfJHCXU1U1bNRB52A5QmnqCByQCyjPz?=
 =?us-ascii?Q?1yKwb34cDpmim2CjOkB/xaJVoPLSeAKFin9+tvEGjhpGnlQm2Mbl5jL1z71X?=
 =?us-ascii?Q?g8jKipSoAlKsSHUXuYq3FMxJyN3DSi0Oqf9+YYuMRQ0SZmmoIQec1vegNMGs?=
 =?us-ascii?Q?h/z/Kvf7GADDdYigPp1uqM8cqul76guvlU/G1kcJJdmvyD3NzmiBg8sB6hP6?=
 =?us-ascii?Q?74imr4DgRli/bccXNwHaKZFsVH3BQi+Xva5OYsWfBff4J4seCDwkiTjDxnYW?=
 =?us-ascii?Q?ntKQG6LTLqX+heGfRc=3D?=
X-Microsoft-Antispam-Message-Info: P+ma34PEpnHwS+epDc9IRizNm8+4K4ldCPu+bBTN/pYQBBWNOCj8x4sZLK12FuLcEoQHtsEp4ME4R74IoPUdXeFSGl/utMF+cYojsbFBhForlT5VNR+NMO4RiuL6/Aw0r45Hh4CLnfMQPIFv3P4gAciWUomOdDmFIxq10lyGx6V4TM/zU9ZkxgyEa+Shscme
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2431;6:GCsHIuIhzz9ddSgCD/3Qn8SM0iGzmiJFF2t/hqqPHDj7dA0TIOkdYzuF2XJvLdyE0Q3IBi2H8UFx3sHhwzw5Pl7oD9DqRtlGyhv0slg5AsRQyg7ZcTG8zZX6Ak6f3RNbTm8P8xpKn1U+XhcpEHlcomS7ieDIQuiE32Aeejb1XiIl/HWSSoVrTXQrt1u+wV3qlQh09OlKIJb4j0DmmUEJTXp24qULzaXsXr9GCatVIeNVM9XbkfhCxdfIVZwnQ7THZWaTbgGC29A1Mc5W2Q+Z6BZzs3dmzIZYXDnGWRnVaJJraZlq2Egt1Eooj7xaKWm3LgCzo41vUWtiTLqhjkfFY1mcxYciysHkYXe5FPSRVqDLYh716afJLyY5hWkO+UwojY383MKg9HpKt4TI9+KuNBpy6jYh/SWl4BednHLXqTdZXEhcjnNYitNcs0cHC/k7cMnsnNYHwouWAn+aKyCodg==;5:RcMf8wVjbcS1+5kBaHvaMX7WiSd2TNAzMs3c96j4B8WQGc3QpZ8E2qznvyG4sMqM0NzcBT83BUW1LF5ZnHlEA5R4fQLbSS1uTiEQDQ1HpV4E5y4Gw/Lt+S63ZK1CsIJKMwgvDphmNYu4oIsO+7dFXAxohyd+xGgJIHowoffkt+g=;24:7ZHLgm+JjipN2gVDzGS9Rld80wuxUrnm+iKfK8seIB5fQ6/Vx80Z8norbX13k+x5NuZ37p+QawzXIpfB52EGaEcAC4V3UpKbCPJo8K6U110=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2431;7:KZj0KJhnamT79eRtvhKiGlO/PNy/CWwVwrdiOppBnZQ7sfPKREEPCvlCeMurrVifwhIoNUAmP8DaSpU8y756Rw+sVki6kivjOJZ68D64RLffBn1C4TyUbzL+7jcn88kaDhrt6MOsodhkMYSnqmlkYMjanQ74JlMSbkfop10fofLGbvhUHDucAR+sl3Dkow8PqcSCInpyMG8u7IF/Q3MpqG9uKbIFJF7MGUY227bmN10YkCaLWs2zR2RWTznuYYoq;20:iWL2bXd9sBEi5fPcmH2H8B5jL/Gb7CyjmCYpMwajrA44y8bKlojwUknTkeBhbFcuMFtwf/MJWvxBceNdQUBVK+taBQ7n9QRkPSruaNdjkM5Kbrvm8QyHLKP0018wUuRZSwb8suv+1sdpydThuUDLmqY/CgLrmQN5xJQFziyD/npryTS/hh4Hs2nGuLm0sgcl0Iz6JV0ZpxQrvJQOAbUHPwzApaQjkY/Yj9FcL6+m40v6prsW9YNTKhMmKqLYLhiu
X-MS-Office365-Filtering-Correlation-Id: 78ba559c-8676-4fab-c467-08d5a41fd2a8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 04:58:12.2853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ba559c-8676-4fab-c467-08d5a41fd2a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple I2S controller instances created,
i2s_instance parameter refers to i2s controller instance value.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/sound/designware_i2s.h | 6 ++++++
 sound/soc/dwc/dwc-i2s.c        | 1 +
 sound/soc/dwc/local.h          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 830f5ca..8113759 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -44,6 +44,10 @@ struct i2s_platform_data {
 	int channel;
 	u32 snd_fmts;
 	u32 snd_rates;
+	/* i2s_instance parameter returns I2S controller instance value
+	 * when multiple I2S controllers instantiated
+	 */
+	u32 i2s_instance;
 
 	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
 	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
@@ -74,5 +78,7 @@ struct i2s_dma_data {
 #define FOUR_CHANNEL_SUPPORT	4	/* up to 3.1 */
 #define SIX_CHANNEL_SUPPORT	6	/* up to 5.1 */
 #define EIGHT_CHANNEL_SUPPORT	8	/* up to 7.1 */
+#define I2S_SP_INSTANCE		1
+#define I2S_BT_INSTANCE		2
 
 #endif /*  __SOUND_DESIGNWARE_I2S_H */
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 65112b9..58f81a4 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -553,6 +553,7 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev *dev,
 
 	if (dev->quirks & DW_I2S_QUIRK_16BIT_IDX_OVERRIDE)
 		idx = 1;
+	dev->i2s_instance = pdata->i2s_instance;
 	/* Set DMA slaves info */
 	dev->play_dma_data.pd.data = pdata->play_dma_data;
 	dev->capture_dma_data.pd.data = pdata->capture_dma_data;
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index 91dc70a..e89e464 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -98,6 +98,7 @@ struct dw_i2s_dev {
 	u32 ccr;
 	u32 xfer_resolution;
 	u32 fifo_th;
+	u32 i2s_instance;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
-- 
2.7.4
