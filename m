Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755774AbeDZLRv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:17:51 -0400
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:64048
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755511AbeDZLRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:17:48 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] ASoC: AMD: Fix clocks in CZ DA7219 machine driver
Date: Thu, 26 Apr 2018 16:45:55 +0530
Message-ID: <1524741374-13523-9-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(39860400002)(396003)(2980300002)(428003)(199004)(189003)(426003)(48376002)(356003)(50466002)(1671002)(105586002)(53936002)(4326008)(5660300001)(6666003)(7696005)(109986005)(77096007)(26005)(68736007)(486006)(50226002)(54906003)(53416004)(39060400002)(186003)(106466001)(316002)(2906002)(81156014)(8676002)(16586007)(81166006)(8936002)(476003)(126002)(11346002)(86362001)(47776003)(478600001)(76176011)(104016004)(51416003)(36756003)(97736004)(336012)(2616005)(305945005)(446003)(72206003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0762;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT063;1:cPklYH58FZM8gxCgK3LKTQExrDY/QtP78pjOjddmC5B4oSE3R+4OHsWalIkTsbEs/kjcWcAfyazPb6D69xtdCmnFi10Ut4l7zm5re/SwnWY7OzPicN/HyoUlyVTlPM8T
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0762;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;3:IxIaVjJapKI2sfybg/mVZoPSPVEjkojOS+/s7405bHgwnZLv0A7x/tIVrO8jJMuQRYahmlj7Gc2oQPY9L2qfjjqrSe/8uxx37oea/O9lfBhHq+j8jb8wXaY68Gp5PxB22I/UYGq+B3lVHa86i5ynzLWpQ8UIWIbpEJDX9NXQ9gokCOqXXLbAAK1lXRcH3kL3pzCt1rN3RPjhMftBdcrqQTI6WcvHUkpEccme91MalM/bMskjGQrNYi8PaGiAX/mstbjc+LAUz7AXUkn7DmFTReWcX5bQhGbOIbfMSB22/unRn6XuXFSMMl0DP5EPFYtE7m4qnioyndjKkH2XKfJGWunLWxzQd6MnHhryb1NBD0M=;25:HPvBjd4665H62OBrmtWK0f32dyJi1ZBi3jZ1JE3lSjbG4rvBqdaOGnjRzNJ+6d73X5JV1c4cq8psQXyiyGGBc7rQuHY+m4rnV8xjb9YKy/l0i6bMxHdJHrFt5H7BWO670xK35ceRjR233yNBwo/CfkY5lF1+aji75oh7gqP3gYS9+V1/FJ+Pq/0GgoBU7/htIAEax7v3EnFQAOKgtlJ/fMfc1ZHJSVB7iQmGbXWKfVLh8OW4JGNTAU4j/HPKZgzzjScfajMrvHI/r2xwC8Bosr9m0LHc6IXRZilLcjHxvpoJtDaQylSCl5347S77KRv8fk68mGcEFksMiaoKNNd82s+1ce/7Cah46Ovx607S5ng=
X-MS-TrafficTypeDiagnostic: DM3PR12MB0762:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;31:CBfDXbIFgDDxgOAmZK1QpdIJT+rBz3vDw10V0itCSRuNtR+5ccS1k5PamfafBD8RgvH9kMY1wqUgyCGTiDhDa+DTf1dkrwj/bxeXVCNxgJ01QtQYmKGrgawf4LV9B3/mFnhlB7/skIDCkN1VLz8QPZIODbtC8iv0THkrv/O5MJmi4vHCG2cw0yOWUWHy+Yp9F2j4q/tbx3LwxCYjfiVTfglTc+R7Ad8+qcBL9xKxZxA=;20:WDv2kEWcwl8iticS4AyXc7WfjZw9L2v0HgLFWGFYw+Sy0IMGQcjQ4L1Z/EiZ9bory8ISUavbyHSMA3H+6S0dkoYUqO6k5MqXrs1xKCQ752ynichGYhejvioml4XkyRpXo5eI35ZdOiB4+Ch3SmdWx/xlHT9EO5olwX/C7b8x78fR2hEuooWBfVMTczLnWWQeXJM59rczhsZqU3/J8tvCLBG/AIM5o3Ow++8rYvgMnjATnTJ9O6cPxyyIL05Vc0G53NgQdYk9fuIzIphMifvcNtKMnoGMASMBFK5PdqoKjPwipYrjHNwGGWYHsVB1hnjEpzqNbseALYuRTyd/o/tw8YwjwZMfKSHuD/PlbH9hwfxpthnCaep3Qd6Q3HamagBFYZA3XfwuLEA2vrmGMOmULfHhu4Sq42PQWv4YJgomyYKUlwYnlsUyrMskLz+KjaA0YZWBx5dlo37TZJCXf94f7OCEGwLUqU8pmdIdND7qEvIOEsLOlQ0v+jkjA0RAHr+7
X-Microsoft-Antispam-PRVS: <DM3PR12MB076209664A5C750C6BB22759978E0@DM3PR12MB0762.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM3PR12MB0762;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0762;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;4:ODsqzXaa8GT1QWxhwETzGUbrH3O9vM5B94bhbapskYiydGtW+R/O8/LakGS0cPH2wpBoMtAdwrUGSVsWTJomvCnEMLQefS+3VBbKHioxwHXO7xKYzcyWGxYJ6o4XccqxpkrkEd2/QbLuVl7XOcrQTHLc47K9Hnlo8SK8gIJbqK741fe4i+3RFfeBjhFcbpgnP9k/yfS/klURHJWrzKk9gCSeskK/lMfeBD57WcUIdve865Htu2FvcF3Cn4BSdy7OrjyLTDCmzLkbhUJHdMs6eWnCMr0NF/v2tulGRxJ1h5HsgyST8r+VfZ8l5U5bNTcp
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0762;23:0oIgOCdgoxKp3wXwK2EbR4jjNpTrM6olXJwdVJcM0?=
 =?us-ascii?Q?RRBU4EmI8A0YJ/CgyT8IpVrUqbAnNeuyVCwLTEF/IgzjpZ6iRv3YFvsTO8sO?=
 =?us-ascii?Q?YtHL08ZTR/MY5RuAJ6qthbSpiUzSwsdeT6/4DBbsicqI4L8qp/K8NsIBc7dp?=
 =?us-ascii?Q?maec5kyywytvD+BdSyLEKNUZ44x2j7s19kO952/5oahSsx/Fp5JImrDyWi2k?=
 =?us-ascii?Q?46+C7YUnCR4FWylncO2tUVtYke7BXgLSGbRopT3Ok6xHUFuxyZPy3JD4rSRt?=
 =?us-ascii?Q?gfiP45noI9UMbXLT3PykvMessRy+P5N6rlG415vnJH8m/GqzJdzEHMRjk8Jg?=
 =?us-ascii?Q?soOjsXtdo2YPHW7m9vpPcBIlYRzrO2Glpsxfn+y3UigkFEqm52m9QauYnc+R?=
 =?us-ascii?Q?fLqimFQJt38XhY6Lbu+FvNcLjT5UARvj5TOBs4ODKlI8flWBYFkXB6fHnYxv?=
 =?us-ascii?Q?iy/tXqHpj+L61CqC2Zynoo+/kcc9Fa94CT54LlztKIKrSBe0iymZd9njY+QF?=
 =?us-ascii?Q?E8p5UjFGESTBUzuYKmcJeA3tGxaTqpnC5rbHQP2T2d7BhEVTHsiU4P34TV4w?=
 =?us-ascii?Q?QWXZg41opGOiPPxZF/xkDA0G/Yd3S5UDR7324RT62W0JUtdMhdhkWWG/Fr/9?=
 =?us-ascii?Q?TiIsd5rv7Bkf0rr26SWbGrRtgg0DyS6c3Rcn3w7K0amir/XDQnZF/oxE/01Y?=
 =?us-ascii?Q?wqGqivRguvjEuUeP1GYP9AZZnFUyfhJapM5jBczNhm8TThwBpckUNyhTXokt?=
 =?us-ascii?Q?w3yNhLJbmdf1IfTKaHlP8hVLM9hhDyt3FwodCTsR9U6DfM93YVcWRX/PpP5c?=
 =?us-ascii?Q?C5+jeySVv3SL/PcdHiEN4PBzUwDd7mMitN2dyiJvq0OouM1+R/DbzQYeF7lN?=
 =?us-ascii?Q?UpCMjaR+ahKxLwCu21RF6lxTn9VSRopmZP47lFWhsGUEGVr80h7DgTVFn31H?=
 =?us-ascii?Q?CH8l3aSFgfY5E0Fk0dggtJlCXGpIkX/BNxjPg9ma+cRsgXIsqGzC4jnhBG7r?=
 =?us-ascii?Q?RkK6wjckVSZibAUSdfXv3H2dQOZAtmu0m3/RR4eoTcbXCDFbCA8YzefIn45v?=
 =?us-ascii?Q?JbA8naFn1efj3OOKXHlIIZOqQU+dvt/ETqT/7NssBtlym4R7wyA08QSWbFFS?=
 =?us-ascii?Q?AbHGsU5OaynViZrhY6vz3V8gpOUlQ+DCRr6dWXIXXSk+BH/bQIOvzLDt9gR6?=
 =?us-ascii?Q?f2C0zVYrmT9m5CxLnj9X+KSQmTMn1+NaDoavjxAZDD9wF5HNMVAzByGqQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: pXiNXsY/HUM7UfpY3l01Q/P29Z12PmK5UGOaJNVfw/zBxRYbx4cjr1+TR3zpAyQffMnKiQ/p/138JCCkXUy2i29wAP9KeiAv20emaHm5XVXHXVlxO8+UdmXbG773vE+n0wyalB3s/15YxIDlzR9Qr1AjcX8aqOHt2DPh5KPyi9HGNTnZTamoAyGC5WcaoOqG
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;6:0vTRLPOdF48X59G8D4jXEJLj40dut6iGw4ls9aX4j8rUTvePgWj4OyF4LMPvtSVNuzgUjmMYMUZHBUYC0Zm/VWNBzuAtOqzolZvMBIWhqsGCmunabYZ0XekHqypjpAvPYtGYiYctSgN2i0jX0vrM7Cy+KW8oU//sY7AMHoa4lkL7eQZYDMZEpP+tU2h9H6u7Q6OICLPcXUmqAQ4BV9gLvSKpZ7IIWhxbwR7EMdW7/XpJYJGVZ88lxaHZvDqwglJGRkaaHSym26u4hpYuEbbvynU75JZuBwcfhhZVg4uTeRTNiDoCuPUKzOt88sRUml4rLZUQpR7fqT6/3WnfozSKLQSSkP7NuhT5xB23QheSHgSX2DL0N1W9xVbmy8+YPhgfZ8V+QyU3/P9rqnyrYC9IoXkgjWCpWBMnuiJQ9IF1kavq7v8er986WMSNkawUjedmGH5CDlz5KHYxiAN9YxxZYg==;5:r8EWy1fbtRbM4D3BsXllKgJ+nAH2+itPgWVMbzPKDG8iBc9wvgNqK4yUkdgItkZx9Md+F/emFxU737tv7toore0EM9xRZ1nu8LogJ7N56Tz6oA8a8KtCtOx2lzOx/q8KPw860iqkhjO2PEdrNyFkNsHZGbHCGITtt4RiMluGuug=;24:kwCa1gokDeI2b5wrF55qUTE3E3siCHks0yrWP0r+8UWhAKZufCiOwrrJQR4LnjWlZo8de0hxCoG3mNZOGUpDYV9ZIEyny3QdpMt7jAdB/Oc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0762;7:zIa8vAbbohxE9dvFljxp57evu+pJnlA/bdAoa9hF0+FJC4EmSkeMhf1NzlifPPVPw9Hsab96YCNVIj0acRjLhEz78HH5biWOa/mngmSPL1Pid5f+pcedziSD+k4ZpycIEw2+ThNG8ilmS8qV0TA3CcnLyNFIJPoZ4D9JBIGORa10R+p3ldr2ykmGMvkIkxj7RpajpCOw7z72cXy6FMjZ05dFlOFhtcOPQ3iqGjHeiRoBmvwr6LTrJS6BeNW9ZIi0;20:KMreIMZMwnn1TgkkAxsEth3GLlBlGhzh+/mnLohkDrp+u9PIGaEIxinvppB+NdgBReUxLcrDhtNqE6sIbA+CVdaKxLV0kxlAhrE5OcAvbKKAbvUJeeyWy8I9muTsVEqfevBJHOvG8J/hnU9zPj0bB0dZrlBRIS1rEc+kgnaZmPYmf+fTiuUAQtfGBR3LT/lkssZBi2+w+TJiGO6D521NBc6cqp9vJkYTrMsf6sEY9lY0ToJeeGksPgZqyjMruTsx
X-MS-Office365-Filtering-Correlation-Id: bec1d87e-a066-435a-01f8-08d5ab675641
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:17:45.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec1d87e-a066-435a-01f8-08d5ab675641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0762
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
