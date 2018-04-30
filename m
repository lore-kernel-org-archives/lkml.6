Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeD3HEK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:04:10 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:7424
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751759AbeD3HEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:04:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Adam.Thomson.Opensource@diasemi.com,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: da7219: read fmw property to get mclk for non-dts systems
Date: Mon, 30 Apr 2018 15:01:54 +0800
Message-Id: <1525071715-17796-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::25) To DM5PR12MB2358.namprd12.prod.outlook.com
 (2603:10b6:4:b4::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2358;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;3:zKCNm1oUeywhnkHfjF352AJAhSssbXpn7swSJxEhCSqgiqxS93eXEwt+sYgCdZH0a8Aj3yw9woC3K2WN0Wvk/amgzrAeyAK060u58D2uIOx/HH1PJAT50iPWduMnNfKMPMApptTRbQBySGte0et6+aCjozkLgbKq528L7VP6Be9LCpJ/W1ZRWGhPKQyovpXRiGR+7wn1wLr97Wv5rMLMpvAax0JokCRfbOUX/4PyDeKzEmM94qaKrfib06a6S4Sx;25:Mer1yAsJ/2zTrvZTf/tNmuSJhNrYgFvqU0adRkppZPJVPp3PmXKc0MxM7IVh3uGgEe2YdmMO2bmBwz8cCez9UT+PXPXB5zzD7KvlFFIyC/u83h9aOltIDFepIngzU6HaHOyHZUh6lZzrge+1yXADnBuji4BYYNaI3kDuMZRLelsFxKnLdYWix6PMjPRA9uRYFY6+ts0hcuJHCDiYPhoytDmelxRsfEIf7YfJSMo7NIgp+C+apr8LNN+AKFpijrnue49IhkpTqmzOozjE/KsARCgYmfJJztCD32ID6nBoez0Rpo+Un4KZW4SVOSM/EZ+RIPzg8bGKklkTZuKQmp6qpw==;31:Kel5Uhy0n+wrj1wej9K52fk7LtwIusxJAMryoms4hJEqIJwUpgHMywjlSG7itUmvXigIT2bqKLr6i+FXwHONsIRB5CLxF0uVyaCHgE5avfX02cYaZ1xHb7tNxhHh5hKfK14LuvnTcUTvKupaEPK0Oe4YGsnJagr+V59h3prjOKZbo23Up9mIFCaJoWJgDnf5KPZnVpFcevBDJvP7Z48exF/s4gKu9PQaEVQIBvQpYgg=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;20:Ec43rWgjLBDvZXc216vn1i36ew4BpOyIK0tPFThj+tJRd6RdaCjKUsDBN4kSZLLKfSN3pADMi9eOUPbwlpwQp4RZHZzTtGqOa8lD22LXllyToEXynA+ecU2US1qZCJeC+Sm7x6iaXu+in1txzhz/EE0wK7qpm/c+3OgqG1f/xq0yiyqeHj5xFD23f7Aoyk7CJjhVqas6k64Xn6IPyaxE+4yRLeHc4ErQZnm2kxUXNe/1sziGzFjI20IUp1arAScCBHDUMZoso/V9gnLrUo/T9gELidtlWOBaKz/RTtQcMrj4RCJ9/525ljB/BRsbdRXG9GDZGajzyweQYgw5CqQXUj6hwe36LgFeyqkcd23v6OPJVuaILPVsg0f0pSeDjXEVGGNzjOS3plLeCx6qx6Uss816dSyVCbZm7MghsCSxbWlLXs0UE583Gkw5SWWx3GA4018h6Livnp/QGv/+1f0Ud6DrfTZakIgrVhLH7KnsVtGQiGRzqFi7+kw2uxLUQzD7;4:TG2t8ZpmLMI1/i3BFbVL9Oct0UZDFo1AdRMx+87LRjW5uJ/gCriGXhYwk+SNB1zg7BLjI9tmspRFSZZNy4c0VP2EqeuGrky09+ueImOPbzFSzZxffTywUFPJXHEK3seZUh42umOvdISKZCJmlwR56YQogL117xxSxGhJ9Jtj32f02xcxU1C+gntFQa+wfMic/J6JwYCqK+Q7nm5SRgamIOe1HWdDUfmOzdwpbefluOYkPg8t/1Dy6uUXrGFduIyMe+E4XQ+98YBVS2XKKU6r7odkGVr1UK8IFum7s0oZC2YQ8A1ymT5tz4/zf5XohYTu
X-Microsoft-Antispam-PRVS: <DM5PR12MB23588A628CC15FB1AD5F7F5CF8820@DM5PR12MB2358.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB2358;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2358;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(6486002)(6666003)(97736004)(16586007)(8676002)(47776003)(81166006)(81156014)(7736002)(8936002)(4326008)(2906002)(305945005)(16526019)(53936002)(186003)(66066001)(50226002)(109986005)(26005)(106356001)(53416004)(6512007)(105586002)(54906003)(39060400002)(48376002)(6116002)(3846002)(50466002)(1671002)(316002)(69596002)(72206003)(476003)(1857600001)(486006)(68736007)(25786009)(2616005)(956004)(5660300001)(386003)(478600001)(36756003)(44832011)(6506007)(52116002)(51416003)(59450400001)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2358;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2358;23:7OWk+o9Er76VLy9dkvEZU3r0wloQbUbPqwZEB6GlZ?=
 =?us-ascii?Q?UTF8JMC2OiBfuKJMque/2e6KNItNOWRkcQZA/kH4NQ7eY6iaH/zJBOkGMRg1?=
 =?us-ascii?Q?12Me3H6Q3SvZYXMaq/Tk2LK+A1moHL4yaPc5S/PF6fkYLkZjPYqFAhZ/8KXD?=
 =?us-ascii?Q?H5fnedyvXsW/MPvQXRfDclhUCWWMSP1foJ8T1i6DuDnMKBkuGo5L/ujkGZBW?=
 =?us-ascii?Q?Iyy2MQdE1t7HE0cNPoBecvN8UaqDVHueHD7T2cTqJL73F9PN+J2suxFjSX3K?=
 =?us-ascii?Q?uVWlOpJbjYwtviVKbPf/7YNJv2mYSBCYUHTo/rsqwDd0eUAVAwBVzU5NV6mY?=
 =?us-ascii?Q?4DM7K85oqneVt0BJLH29KIMSknRvFEN7F+VSDX4imWi3P6XLIXvdj0e00BuI?=
 =?us-ascii?Q?Tndq6QGafkR49pDFGfLcjlxeMqLSC1amFZVBVtVe+wDE74moOvzMVR5qJgN6?=
 =?us-ascii?Q?6h2TzsB0xnv+xkv1iD/Wma7dn4vlPt+OWlI3Sp33Nn8SurkVcW6R64+leQb/?=
 =?us-ascii?Q?G5gn2NnhVpUhO7n8Qs4b8aHIAZFq1XX28gvWukCZDJxQPviariwV0UKN8553?=
 =?us-ascii?Q?fUVAWJspcAS+Yko0DAgP6p1fK02cQ44IHMm9CmBGujaeeehcuFSsj/fFAI63?=
 =?us-ascii?Q?9hVXNixo/BDxkCMjkxZn18P4dYV7KQezMEP3sEt7wG7T1KXcetkvDW8Nv+0z?=
 =?us-ascii?Q?/tiwZHABG3n0kMykT7rct/V8R+igJaR2PtNsH46H7PZt6MdsKuIyMNOS8gDd?=
 =?us-ascii?Q?ZBv7xom+UGXKsglwVzOSLx3LatpRVjfekpzeozT4DOWzxuMHbjO2OSvERSrz?=
 =?us-ascii?Q?4q6FGfqs/WDunElAeIi+5e95nArg3nxEX1G+0ZHozlHYXCZbStt5i/nkpkCZ?=
 =?us-ascii?Q?LdNPCwBEEXb9rirvXloCNuSORub+xdosf6wFms14s2f4hS1gutMyXysI+mLH?=
 =?us-ascii?Q?E6X15JWa2FqBHcJgAaGaxsd7XCqUSMAWKg1yEhOLu/vRNNhvClBn72OL0K4e?=
 =?us-ascii?Q?2PogEZK8ihkYKpJ7RTi3H+BOBjcPonVsa7hrUOe4XTU2UvqoHIvx5xbc6vaB?=
 =?us-ascii?Q?Oz4Gc8kII9F1becheEf+MaFtRf2heDIjmW0avba+A7OavRdRPHHEf6pSTUcS?=
 =?us-ascii?Q?j65+KXXxq9gRWD/cjcVEPXpd9DcnN4UjUmcr24VfqAI1THbBLWwaiQG8s4lU?=
 =?us-ascii?Q?j8fzCTn6SmLQYRwsJ+Eh7Zd9/9bgZy9W3xtYinK6jjr4S8chx8ZxrtCFBIRo?=
 =?us-ascii?Q?xm6Jlwu6s8SZz2Bd69whAhLvsKCVX4tckdPCiHoIXZz8NUDyAMheC7TfdBeL?=
 =?us-ascii?Q?Nn0IAqVEe26I1VVBV+FZk83jv5/LY1sWafGmKxEeYOO?=
X-Microsoft-Antispam-Message-Info: KZq8RdsnAK6a8+/jv14LAhkHnaibThggcWdjEbHeFMr+X6hulaqi9FlLgKJT9/L3avVTC3stFZShezpY9qH0yKoxigTijdx0UxcoMsvyokt25YvX93NcmBe3epw0W0EyH+XusPTdfsxMVatTiOUyI7kz1lCae1s+9VXsusZ5C+OHxBnVtZFg0nq31LGX0vTC
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;6:DRVD187dlo4EEHimZnZ6hpkYg0kZkHwntYNzhgT9zu6/I0O9NDIjrqUtDfL01DM9iiaKMw1zX36En5Ds1xNg0VUjRVNPvxlXKyhKmvMgfxFuQe3vqHwkxJwuEfT8BYZJjrwNDztQOOmmHacWtNAY6nkjIi57OLTjjIpwGruA+Ri4p61+81e23qDPAi3ErSTwQJ4SbPL1wtLtTzevMzlCAEDeBJP40F90a9YQWrKsomxNdRLFoq4iWM1McQImRqa0fSiN58LY+TcE/Lt8YAq/fgZODZMgNbWFMPTnmC4sOHJBlAjaa65Rm2gMNQqmcz6siZl6cQpcIg/Awt+RC5NE3fOsPV1LFaeZkbzbyeXl7YZ4phC2fjibDUvhHzl9SFDBA2pctqLSDUFabsB5ZKmzeyboTZAtnzqBEMJLS5OkVMyYT1txERhGbU10IeyyEgJ92M656bt4swarZa5901laGQ==;5:ODBA1mYLjIVbZqzRjCIX3xyeIUHPpd8Zh1C2t+2HUeCFld+SnZ9BNIionVUbUBLEUia09I2dARGt7NA3fzc4nT9vKZ2RE9J/dpDJRnz1I4Nk/b+dosCM3l2p1ChalMn0aDg1ytgAJRo7KuKKOR2hPNGYJOCWJLWDhClx0bmmIoM=;24:9RDupB9goUU41JP0g7WAbcrGYmX1eT46hZp33R+dSqI8hXitvcdOZ6QyhHm3fUfywN6DlDMXGZQvB2sHi2u5dcxYpaLRCQ3cpr2uaaTrrpE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2358;7:RoCDEVKqryvSAukPtjMLMHtJAkhNFABiLx5VpVsgmHTku84smgsKecRWcsFzLCZzJfNyODRAAA2cCQo59rrogtx+MWM629muub5U4xE5RKNae0/liOsmJqUOjc4r3trdZYQ+HlSsQzXu27/yrGOszXprnLI/6OZvS2yZu3qlZKr1nKRyaSsiEiASTCWj9vDrY8wToFxa36cYSP38z3yPxQQMRovelVJl86qJD2dAo4ZNKp2yFrYbKSQHlesJqXLT;20:bZ6rlRO76jo0VRtfQ4s3ofk/AWYGSMT+f4ICnvbwdOuU5GBoxPqYghgaYNjZCWuUjTVSgMeTjKO4wkc/WsmtSx0F+kdmjGn5Bs7FIaRbovhAXQcEJNLQIt8c93hzLTaDdqx7e+tgizrMb1T90aaJYMZbXohSIL5bKBESFeDIzLYUTK3X+6VQTvTaBii1Z/FwKDBVYqXNK0/RpuWSBZXiNarBdUKufeNS6/1Psz+4i2vNO5SFl+tU1UwK8Jn0q0X/
X-MS-Office365-Filtering-Correlation-Id: b3af72c4-0fc2-42a2-f1a9-08d5ae688fbf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 07:04:02.0909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3af72c4-0fc2-42a2-f1a9-08d5ae688fbf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-dts based systems can use ACPI DSDT to pass on the mclk
to da7219.
This enables da7219 mclk to be linked to system clock.
Enable/Disable of the mclk is already handled in the codec so
platform drivers don't have to explicitly do handling of mclk.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 include/sound/da7219.h    | 2 ++
 sound/soc/codecs/da7219.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 1bfcb16..df7ddf4 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -38,6 +38,8 @@ struct da7219_pdata {
 
 	const char *dai_clks_name;
 
+	const char *mclk_name;
+
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 980a6a8..47ffb35 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 		dev_warn(dev, "Using default clk name: %s\n",
 			 pdata->dai_clks_name);
 
+	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
+
 	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
 		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
 	else
@@ -1905,7 +1907,10 @@ static int da7219_probe(struct snd_soc_component *component)
 	da7219_handle_pdata(component);
 
 	/* Check if MCLK provided */
-	da7219->mclk = devm_clk_get(component->dev, "mclk");
+	if (da7219->pdata->mclk_name)
+		da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);
+	if (!da7219->mclk)
+		da7219->mclk = devm_clk_get(codec->dev, "mclk");
 	if (IS_ERR(da7219->mclk)) {
 		if (PTR_ERR(da7219->mclk) != -ENOENT) {
 			ret = PTR_ERR(da7219->mclk);
-- 
1.9.1
