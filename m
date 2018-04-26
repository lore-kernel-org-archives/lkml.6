Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755807AbeDZLSK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:18:10 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:9568
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755788AbeDZLSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:18:05 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] ASoC: AMD: Add const to snd_soc_ops instances
Date: Thu, 26 Apr 2018 16:45:56 +0530
Message-ID: <1524741374-13523-10-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(346002)(376002)(2980300002)(428003)(199004)(189003)(39060400002)(109986005)(336012)(4326008)(105586002)(106466001)(86362001)(53416004)(81166006)(104016004)(81156014)(8936002)(8676002)(16586007)(53936002)(426003)(26005)(316002)(11346002)(77096007)(186003)(126002)(50226002)(476003)(2906002)(446003)(2616005)(486006)(1671002)(6666003)(50466002)(68736007)(356003)(478600001)(5660300001)(72206003)(97736004)(54906003)(51416003)(47776003)(36756003)(7696005)(48376002)(76176011)(305945005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0764;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT040;1:mWR3P2NZg2PHDDMLbBBymzSYHSlTLLPu/oRhEMo7OKGC9u87/KBcIqD7QRwqEgI6PjO5nGsRUVGtZ0VQdTZhSN3g9EsnisipXtRCZSYEWXF+comZmGyHkrTrYFUXB+kB
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0764;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;3:iXCujYAIbycS+WxuHpGzkPnSIwNc6zuYhq+Szbk6qbANAoDqW+Un9w1CEPNSmJx03LMDtmpPG3gTkW8B+CszpKGJSmtJJZiTAc0mzxgKLmU4czurK4rXWjD6LU4oZY4Fs4QByl/YVF+OIS5GEhcFXo/Fwd+ZJ/bxFro+FdM1JJ+UVrayqjbPhdQzepQbUUYWsj5kwyP/cazRHJYzUqyDraBZqDV3k1zv+aZBMZwGGE2UYu3WF/nUIQWMjFG2Zg4cVrHvymywFhWJwOG8LEGAuKRGim8wiqPy4oarOH8Qad+nRA7avNTcnsGmN+ppqxv8DhPIDdw9laqHs6ldhp5wygqca5BRW0yMvr8BoJcFYfw=;25:PBUkh/DbKOb3PRZuv/oGtmBNrWq90re67uwNq5i760u46BzZPwJvixTrIvuj6LorZ2fOxM5iWqE8n5E2s3YPRX/7ppm5u+5nB24dsdzdiSei5Ly5fgeX6dw6iDB55PEX8F/xMtgfzpTrAGcImVIkYLzdYnqK97HT8Bza0Gr5udkZd9UlhNgSjl/Jej9J7m6clI0vNynU65L20SJP4FXJTm5nDRbLv8wYw7GyP7yfvaOoVCgqPhHIMQZ3YLIZ/YJvO3OeuTw7y3rrEsXyI8bdNbJLZhyWgxFlyzBEAl++BLhMQr2bxsOcVwRwgsyTibitenSXFCWJqoUIgfvkq3MGzUsVN6ka5nfO0Wbvm6P/WYc=
X-MS-TrafficTypeDiagnostic: DM3PR12MB0764:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;31:rqZNLtKAlQvfMerz0XpPPUXKvlrWAAqeso+L/dRZ5BlWm1ZhAK3iEg90YK0Q//VbV6UQls1qkT4FMR55Kf6Z/S0zPMb6lPMK5/nIq+MAsO2gjWT+Ck3LtFYt9PfA0cl4lFxz5Xwl9vYIBvxgZnbcLQo6rP5htN5fr+Cog5JgoBIhBYMfdnvX6+YgRd/ZA7FWGatMmaCkkXpPIL0yFL8uxGhD1NVPCM/UAlHez2n9xLk=;20:Sy2p250m2HHLhLC2MNDvzTeN9Cr/zIJcb7OuHoHk0CEnZ8GSP2838Y1/r8XUyq9peBYCwiJa5xkVOk267BC9CyJF5Jtys0kao5hOqMvo++RbgrTbatb54mCCz6kNbixNeCIIDXUxbcZv6PcUo6XC7BTE3ROCIehFhQe4XVkPdSOb3pByUsFCwU/WZ104GNjfxXP/DEpnuj5HlY7a4rdGxBMhFUNVRPCs1S5cCttaCttqAok77dEDG9GcPEBMBP3cF+syF8ISfqo/hZybsCYSZ2cZyxcg6seGwCw+NiXLkLPNTVQLzwCwWYVGBG4fEILvgl0BIqOwZeXfoov8TCjl7VG+eb3wC4HB93P9hQKNqxExb5tmITOMbhwYS0OHg3sj86nYRViiT3HBghNqFwjGGX8Z2Ltp16sJf1bqKf+Dfr7LR14zyILtF3nujI3dTjh+GhsWxklha72vk5IDdgNPzpksGj/OIllHWpTi9b3GMGhBV2ZFWMtYrrFCxdxXy97U
X-Microsoft-Antispam-PRVS: <DM3PR12MB07640E4C02640A262E857746978E0@DM3PR12MB0764.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM3PR12MB0764;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0764;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;4:zh6ibugbyA9Do5TE+yQL0Ay7Ekn0EErD7MuCivAdDaRbJ7r45lc13QbE97UH702jcphu1PzYpeNDiKx9PhKmvbhQyVPv+LHtxi005qnKbaWw/ZwMMRIIIJgwhLGwfh1+blz4KLimLnxdF6YIzTkkpzzwVKweMKCQoxFyH3V//PoycPVpAqqZ0YP4RQlqhafOyr4ZI+vZe73fJm79yEd6dLgWiGl3WnllIbh+NRSAE5cHdHpQ+GCSjdwf3lYVthFBIJDvbjc2GMr8pIDxqbDOogSjSsorzA16wM0zu5wIK5nwnqHztyTG6PcHsArgGmfs
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0764;23:Z/DOaGp8k8NKSGtZnbstegL/+MehyqF4YaOi+EzfT?=
 =?us-ascii?Q?21lMfleb9ieWVpjuRTTA3Ay9OGtLeYVi44zXN01V1I8EzAZDrVS0OLlmPNiB?=
 =?us-ascii?Q?pDB1/SztDIxsAIY6rT93Tdt7YOzsyCRp/7Tc0QwWgYQP2YweB6Btk5FbjwjI?=
 =?us-ascii?Q?bxAl0f1vFTgGe2TEKiZkURBxqs+n2daT5dEVZse+rQEskHvV3NsxgMYvDzjP?=
 =?us-ascii?Q?9HFvtEM/QH7n6TxfghErynIpEU/CUnn0toE96t0M9+mO+YQPPcOjsDm2U4+t?=
 =?us-ascii?Q?hsc8VWO2BLlC9hYZ5JUaAHPLD7oBicBLFUx45r8ZYVjHWWS1g7uSW1gV+k4/?=
 =?us-ascii?Q?/0S/AAI894ixH+Cxv1wJZTcwWUYiaVB6vdhkFfyw1Jp0oih7vThi9BznA6LO?=
 =?us-ascii?Q?j8aYikq2kYj2ND6PAhl57jmj3WE8KN9Cyk4BRB+HL3zIt7E7GxQxYcywCO4/?=
 =?us-ascii?Q?ovJWMI7SkIv1E+W11jMm4OpzlI6h8OC3Qe56txca6APN9uITn6Vp9n8gWQ9d?=
 =?us-ascii?Q?H96L2zsRSGVj+XE5hOLLtuVemITgsRS/UGJ+5imoJAkVH8z/jsslVqfrF7bS?=
 =?us-ascii?Q?yfsWbNS0rjVhliR+Zn86fMZa1koU+3ykQWS3hk9fT8vUDYpBinaDPPALjHr0?=
 =?us-ascii?Q?UOKc+dr3i3xm1yUwNbxue8Z/If5ss1SZHZPGhxq9K9nOalDXw4ms2e7mz4wQ?=
 =?us-ascii?Q?tJl4/aU4K6g98mtvqkWZRw/UxEdFgYysM1LOsc72XKgNfN01+quDW2Ouwbcn?=
 =?us-ascii?Q?3sAbHRNPFbo4WwjpjOCRvT1y7f+2v5o2JFoTz3/3NFX4z6W+h0xqN3nS4rr7?=
 =?us-ascii?Q?Z8D6CJuE/akXRw1zJDFI6DSTnikQfEDYFuMEq1tl5KqPgfPcP9iY87qbaCd8?=
 =?us-ascii?Q?LTJSGGrNRnhbOniyIE03ag5oyDeww6hj/VtuaxyKNMVNATRgaWtzOcN0mg82?=
 =?us-ascii?Q?95ubmdZOhoUf2GkRRfDBlejfGdW87qnaHfENCWOBWYIOQjMzumHMlSc44zeW?=
 =?us-ascii?Q?fEB1hAcPqZabzJfDKIHypcDl1wxp9LuQ/mdSJ3c1JeG0R6UbAGx+6Eo7j9fO?=
 =?us-ascii?Q?XRqCcEu1RGJ3ZXNpX73waqdyiC1PZ+p1pGloEguyYGS+T8ENXqrK8d3wRJ/3?=
 =?us-ascii?Q?u5xCp1giAf3zmXzAS8Bdjq8sWBloZOhKUdAxoanqVEvNnZQE0YLzrBScJ3BR?=
 =?us-ascii?Q?19UAVVr5OsHJ2cRSt15gdoM3qceMmbGGomUxOFP7Olfk6dikqaBjelnGA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: tQyAg+NN5+6xqWh/YtrVQS+8Mdi29+LpS07iR3YwAB202mY9Q4RmvmbbD4mSKKg/nSl9hZuPspXL0fm9XxjeLqrSREx5F/eCyxSFfKEx+s9whpW0uQk8H27duWgP5eplkMTpYU+KRGKNk9PzyyvuXGSOtr8Z3CHiH2KdrM73pxb0rxjjFW/IxK5q287HbEkP
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;6:A2BpJm6l3McOtIduqF+M3prFcBxO7zHnGAxPldyYs3FTvr/hWzOEz/LBh1ALMn4cq44A5pROYgyaNxOQ3ZLyfG0h5PUbEyBkNehUKEVNXwLrphIDzgQ+LCo/T9Sys1F3lxw1fhO3OB/a3Ze1GpYZXAiuFKcBw9TkVIN2H0qygsa+cWlKiseIDqYzdrAkq42CHuoC3/8RUUfB4ouSv8s2kB2XEGNWF3qf3qY7PJDhg7T4hcbIdc5RxMhZjYsu4yoyqYHB4TP7M8ClrPC8hD/9Gr1WMJNn5BzsK7sTthX8aRPhSn9KTKO5ZmNGXUU8/Y0+wM9sRj3csuBJauApAnzo3Nt9KoVzyQA6lhF/7nyyQHii0AMo0p/NuLqhxjWfCj6zXC5/1Jji318MUK61k6fDRe0TyQS4coWfJh//fXZbrK5q8HBeuPuDwgXKtCdA19Tlp+xj97aDzgfpagrHcKhMew==;5:wmpxPFDgH7QjjAhBzXJxZnx3OAcFAywa8cXELJjXwSRZUg0cPU7ToU8nAjGJPKAX0Wsl/QqFY58C6NOwonQ+/zQj4R1WaNoboPCpNMF2ug8CnieUyJopxlulBOl6Lf9rMyZIQjjhrTKkAfBhpExKt6dMV5oQP5wgQszwDvGAMM0=;24:p0P7toRB95ik3P77x8micfJtH2YvSCFcBMRLSEk5kpstb8cWmhI2uQEREdb/qEmqOQ3em/WwQ4okFDHZ3Ih99fIcbL2l5mXRfzfAsU4+7Ik=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0764;7:XkbHeSnGUG4iucmIOMbY9Fl/Xb40qfXig5Cg2vH4WkjlODhLQbxvMcyQ7n2svuqB0JCcNOBd6g49kJDeleFyZtGQHzZDE5Pmn0ZsEDlBtsMkYYqJ+vif+TX+P/v4jrEMt6wHX5lEQD/dwzPNeEakHl6hAfioEEgDd89Ud7wQxF8LmuuAIUFcs+EUBlnLEfbps8yyz21HvRX8GsWq+6l8Z+id47LqbBO4++YX8AxiamBguPccNJwz5R03Xo2Rb7gb;20:/wdDV5Na8wR59o4gJz2qCjjN6JU6GphaAp8Q28FFrMGO34numsARExfyPU9nR4cI2J7leyYGwDirx/PuvS/C1DoEJcdzThpm5rJqU8rh2x1sqyR5BJ7f9a5qa7jE54lr2sS6AGW2F2YCm6xpNyBXDtIJN1Xfy5XvWK8HQB3T1L85bKioH430WfSMBEgDrxBFVZDIMNqtaXuCEzJrDVNaAcoWv7005Rqgl3lCPA+RllERIOkFBlKeY82PXtaIrHn/
X-MS-Office365-Filtering-Correlation-Id: d071a7f9-15e4-4926-4cf6-08d5ab67600a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:18:02.1093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d071a7f9-15e4-4926-4cf6-08d5ab67600a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0764
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

Marking snd_soc_ops instances const

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index fa5ad5b..133139d 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -171,17 +171,17 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
-static struct snd_soc_ops cz_da7219_cap_ops = {
+static const struct snd_soc_ops cz_da7219_cap_ops = {
 	.startup = cz_da7219_startup,
 	.shutdown = cz_da7219_shutdown,
 };
 
-static struct snd_soc_ops cz_max_play_ops = {
+static const struct snd_soc_ops cz_max_play_ops = {
 	.startup = cz_max_startup,
 	.shutdown = cz_max_shutdown,
 };
 
-static struct snd_soc_ops cz_dmic_cap_ops = {
+static const struct snd_soc_ops cz_dmic_cap_ops = {
 	.startup = cz_dmic_startup,
 	.shutdown = cz_dmic_shutdown,
 };
-- 
2.7.4
