Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E5FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C8B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lm0A2+Td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C8B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932686AbeFUE7r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:59:47 -0400
Received: from mail-eopbgr690065.outbound.protection.outlook.com ([40.107.69.65]:25248
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932403AbeFUE7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eNpbvHqrwHT3AnlWnOxL/owGcsimJl+f1COD54td3U=;
 b=Lm0A2+TdGITfz27g+VW5kCRVAMKkVXSWHg81aVvu4BCT7mdi3PizcF0oenBUgiDSDqsDk/o9DhuqwyZDyXumn53WKdCeFtmRXP+pULGTzIJO1rbBnwKwlx9WFHR9BQdWbCYdnC2d5SYnENconNFthSOmFfA1Ck9GH/uaCwKrAlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:b4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Thu, 21 Jun 2018 04:59:32 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [v2, 2/2] ASoC: AMD: Configure channel 1 or channel 0 for capture
Date:   Thu, 21 Jun 2018 12:58:17 +0800
Message-Id: <1529557112-5525-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529557112-5525-1-git-send-email-akshu.agrawal@amd.com>
References: <1529557112-5525-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To DM5PR12MB2360.namprd12.prod.outlook.com
 (2603:10b6:4:b4::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a675d94-22dc-4a0d-b437-08d5d733cc90
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2360;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;3:o8ciO7rFwn0rtKNO2Rlm6/FFXZq9/H/+2wIkti84iQtRszbXSTnVsJEeQURmpmX+B92yDn6ED+zFkLa0S+13zjBuoexOmMsZSjaKqf9gbdxa35o4/gSkc+poY44eCmFYVX7OeUAKKNPzYBF0Kc1DUGAKLKgpI1m/LncNM/XYw8TUT7sOs5tJN+h1uMZzdwNS8CazapNZUC/IrXiSqL2knTsYofGoRUZ0HRkDrf0IXzCOzF8gimQvuyjRE3QHmoqr;25:PZgPcq8hObjGurXPXsVnom527wwhsmyLtj7F7ygKof6xuGKH4vrUt+Xn4NTN+IIaRj/sCLhpXh5+m/+YtVqMmnEUSOiHjk+HjroNfeDYnJpw3NMrBA1ISRN1k9iFB4ezatVQb5Z2dAJiII0zm9i0YbxBsR84y1TdflrDzftiIA3BvDWVztl7xL6nuLcw8gTBeD4heMwDTy70tmoRNUlEY5Hg7GWQ5TM7Ptl2AgMA6HZzBAN5XB5LSUnWFJw0/jD2JPL0f1OyFBXuKOD7p6dXZ0eYAjlRmTG8KTnT2c/6ExevRNBvBTJfBnXqaWTZ0TVzB0UXmqpVIDynMRfPS2nyIg==;31:cVkilz/FNIbxOVrkKjghlAlb3POAjPG6N49V4k+lior0W0gtFr5k5YaaY666xK0GBAJqATnI4A64CLpy2lc1aph/0Ak9YV+acTnJoA+aJkUfYhaYdDNIF6Kqeak3vXNb2PWe5wwKMY218iU2SiqXP5t5c7pKSmU6lWlLPjIqrKQi0JNh2SFj/s1nYRiIGspujOvQVpJ93/qP1x71IBNUoelQ4UzbKWlPH1bErKiXQl4=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;20:g9h9bxyAfvt1oloNgKwAYi+CJeL5TGUWtLYD+8NJ6DePRDbKnDU2bceJ6bLqjjyT4Tc9w+ogkclM4X5mzS2UFd5/7y+zbVuEQdAxaGtZiB/tQaoLiXF/f3UWvcLKlN+lgQHlHoqkSzoorjpXqKpT0AFQ/GDAaayYFYCA5t2YKimL1jyiJzrH1elELiFkQWfBKOqsxXQpGNSxgtAJvO+fSCG5pVefXVsNuivGyiWRXCHO+xQFqcwk8D0ytGxxbfNx3fT9Dn5mrljKaFPDzGy9UHF2eDl5iaFgDbilcbVqJHVVlM35PaeC8XfdibP3eiT5IlwLgKbylyze6d6ZgpWlREkNQF7ghMqgIhDFui9+wRgsEXkcob9G4T37bGdpop2VpuWODGUdu73nFmB8r6e03/QrecQeQDm0hFq2hQc9kajp/99IeYiwQtIC177EkCPXn8w13mUP3eLrgIg3Iwfos3h9vfw9UR+K5WhQvJ/SWzt98RQxPfX2/CfC+g+Q4oiF;4:g41p7ZY8BH3jAKl/MKWSkBYtUrSH0QI3Ibiq5VcGws300Ht0m4CKycdsNY1Hq+q0KgpdzbRY++1wQ94TsKn0A6hWvPtbSTGTWd05Hkny9fWcihlpJEJJpnWHFj2hw8Nnby8fykw4koZVAU3MdaudIh2veb9VTQenBY72oEUkODvxWBmjadxeG9JELEknHp21ti23uJJUb8d4p7OPjCVgBnks78Quw+H/qwV4TeDztSfO4TLTrvtCwwz/v/ZUB6zTAnM08Tyr89udE6M2ZhCjsnyk3kYjiu+3KF4y4W+T1dvhah9J4PtECyXs6XCj6Mxz
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360AB8F1453A20DCAE96D07F8760@DM5PR12MB2360.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2360;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2360;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(189003)(199004)(81156014)(1671002)(2906002)(81166006)(8676002)(8936002)(48376002)(50466002)(6116002)(3846002)(6666003)(47776003)(316002)(54906003)(7416002)(36756003)(16586007)(109986005)(66066001)(5660300001)(39060400002)(97736004)(53936002)(446003)(4326008)(106356001)(76176011)(2616005)(476003)(51416003)(11346002)(7696005)(52116002)(956004)(105586002)(16526019)(86362001)(478600001)(68736007)(186003)(486006)(50226002)(26005)(386003)(72206003)(305945005)(44832011)(7736002)(25786009)(53416004)(6486002)(59450400001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2360;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2360;23:QroLqGtDO7CUjf2nAOutlW2pB7E1eKotBR77/krRK?=
 =?us-ascii?Q?pQQqIRhR7u7fND3IZ3NoytyE8oewvAXE/2SNBKCEgmn4K6/7IQqEnHC12Jk2?=
 =?us-ascii?Q?T87ERh+KwFsMvIw18HcszM7zEmQ4b6YSg2bH3+Ske2P6GfUHE07BMUaz30Hv?=
 =?us-ascii?Q?el71VlSwr+d3UYeNUCt/+lUy3NT20JR0VJlCls6bIRJgzGLj4jAdAayhZbxj?=
 =?us-ascii?Q?KG4V9cIqYw0OJuou/5r6Ud7r9Dwr1mD4ZgB/EBKtFLBD4p9caLP83Xb4cMn+?=
 =?us-ascii?Q?JLDQdnLfBOQ7ozGtWjZjDRADB3CmpGo8o/O0jYusfnAVd2oQt8ZkI5QL29AS?=
 =?us-ascii?Q?YPYlqVPGlttTSd23RdUmNPHcmqASyKzjmncqTnEMtei6Fs6Va+MOpJIPIryC?=
 =?us-ascii?Q?8mnrsvE3dhm8yK7PcS2bCDZme2qjZPtdk2TpFg+uAr99B2MVj5gFvpxr/qH0?=
 =?us-ascii?Q?adh+xrCMwbc5yhAfI3HekF6a2YGrd5IJYaH3HdUJAgnrzriWMoiPXNiLy//J?=
 =?us-ascii?Q?uujbC4B4B94Wk+fw7XqCVHI7nl0eM3Lu2i8YqOf8GZizHvpGmba/e8iy4DVZ?=
 =?us-ascii?Q?O2jzRI9nLSv8Vlc+E6/2OiRruVVvCRkqt6SsNcNJ1mTfEgF2wjFhSvADLpUE?=
 =?us-ascii?Q?EQc+O26p9PPAMPzqnka/76+L1Mo7oBF9/izzxWvn6Rh6TL/PvgbKJBXMssN5?=
 =?us-ascii?Q?WYmIGdXY+kPoFNmJI1JWdSmKTWRb19VYVwtI+fE0ZhEL3Dmf7+RvXvPwLJLG?=
 =?us-ascii?Q?H/365bIFXSL489nYH3brcLjM7GTFMzYnKcbXR1xBK6i5a43UCDYDZPtUIHFM?=
 =?us-ascii?Q?BBfk3gINmYONbvm3CcF634J2CJ3pzGIlP4qWiAclo4D8K1t36Eopp5YNMZZm?=
 =?us-ascii?Q?zze7q8GZyLZJyMb2r0dXvnJ9PwX9paUSoflIUwm+6Ua9IZBkoYgG2Yn40tMY?=
 =?us-ascii?Q?VHg5ZhPCM2LAU5PYKezYfryKIxaAI1E+Cl5P+E8ispOBGpMLaXrDkpSP/VSW?=
 =?us-ascii?Q?h6CTFwORkCvTmYsYOmmi2mZKEOZPNkzYmiOBnASLWolylUro38ZPnznsof+N?=
 =?us-ascii?Q?aP9ZSzV1It/yoSp+4MTYKvhd1oTB/HK1teF5sj0o9NjSTQH/FTf6TquCWei0?=
 =?us-ascii?Q?lDaJYaxblhwtGeLX9I06IE/eM21nxQnzC/wzbWBwEAWVuC+37yyZzKtZUndC?=
 =?us-ascii?Q?Q/eb7/S04dJtsHTOtAzm6WjwPsNNzI9IZrmOYlZRSjqq1JALX6uTCPMtCDxV?=
 =?us-ascii?Q?XhJpnOfe488wAqOIuOctVAUUytZh8b8a6OCGDvWbUzz9xlsDWJWqJf3BQyjT?=
 =?us-ascii?Q?eD9DREgcsljQI8icguPnOWxMlsBpH1JfVaJq39lbjfD6TEUgED8S11WmG5+V?=
 =?us-ascii?Q?sFJWg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6SfCP6ZCI8PohyBZiZv8b1Ws38LDk7WnY6uFdSq2PldBSiYFcOutsYoqokwcAzt4hCGOgfPli2oj0hfMHG7Lp4dvfBlZVGw/OThSIeSTLKM4iD1Uea2B9yjJ/+5d1iE+yYTqAkxUDOPXqFoARslYdh4E+EGe2C0nhqIervQRfEDZvCMLCJjrXH6bt/OudDvxKfidOslxhbxQ3100QayUqm3MdNVBgM0JNDmv8tPa7RDtcIcDkG+gkJrRunGFQp/7tBIRfwS2Wj07Go/jOzjh7fZHJf1XxZWBP3xpD3p8dKYsCmNxPfz+6lQ1y9/AgAGKnov9Zku9ebZfzP0gmbcjZQ==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;6:Se9GPtfAEznoZs5LiprL0kVprXX7ES0DcnGSQeWxQYmI107G6yMhoxajAxz56SFANZiOIWETSP2cILWmKmGTFHnBmIVE47shEPQfhW4QrhpGphK7RD5RG5zoPn2wZiJ52eI3L/mqa/Hra7ILpKVBBZshbE0k9LX3smq1oXpN3sOBj4r2G092tJkXEa0TRHmdaU2Og54QBbE9FMCU0hI91UVjfWGWZULW6Q8KC8HVbX9pPlKEi9YSogYEym7JqZ3Uip7UVSTuPtux9xOL4gIAJm/AHpx5WtuoqVa/+OMyv2X33OlqXypZVHuFwhdd3iS7j8AowmKROTmgOOdiT2GLewGEeEw1kHGqZVKKpPT4QIEA/T+tGCk2jsB5twS3FazrzIxDZ8O6AMsn00OP6Hp/izjHfAsX//TAkD7EAE8/YvppOktMe7Nz1Xva5S+cFnvPnjWb2K0BmxXgnjJI3CO/IA==;5:M5jTHXzcj0hkyWyjjPY8id/oOAArWR2V1eBi2kxq3Y3lYyOWKgZ8iIXJWqhalQ+a8CDuOvCED6QwVtYR4mAonOY3BVf5aFxSqQJESrKHfulpSdCwR75ybGzMvHjGSaVUHljLID543SZjf9qETWONknXTkG11jc8d3mkvmWTNXfY=;24:FksXQ71UCTRJ8kVdcJd2tgUIJ2obmdZrcZVhuZsXBijdJL+n2+NbC75WtmvaaHuOJFRJQvBPGMVD8PU2RT0T9PWG1TmJDGm94B/gNEPdMPI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2360;7:pQ5QzwRHma8fMNo5UMtdo54JClAOhyhWFO0qe3EoAxGwmjZyL58kLuo+vhYLhas59dC5ArMsovvXsrwFC27qPVQgNIiC6/2VtejZMKptiIlZCLZ8h9rjOe9hL1J1iPpz2oXYjARRzA/ImT34U/ntwMpiMtguCkJ4GbIER0079dwxoZ/Cf68IAh4rD+xi4VOAVUwm19FWcak8T3pxGxDUPMvkkbyr72wmKVn+bnNdCqW3lOFB71VoLEXVKTsmTYyF;20:nEK/zoxZWnQe8eMiIhiPAJycA9e8//dvNodam4hBRBAHL1OOT+E2b8Ux4z76abqybEYi03bzRjirySRyArlU2wu7ARdBhIcCB42ST7ZJ0kWc9vrRlbd8zchee4Ik7N8JKCfIqtcDRZID0wa1RbENFwD2EOWbyJ3gnu4KB9+IjL29pLv17XWEX9Sb4ZA331r3umq1uX4h6baPfs77r1t/Z9vqfaouCnFspOrhljiJD3SiHqod+c3zA4ntayAROzUt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 04:59:32.5475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a675d94-22dc-4a0d-b437-08d5d733cc90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
v2: Split acp_dma_cap_channel into 2 functions.

 sound/soc/amd/acp-da7219-max98357a.c | 43 +++++++++++++++++++---
 sound/soc/amd/acp-pcm-dma.c          | 71 +++++++++++++++++++++++++++++++++++-
 sound/soc/amd/acp.h                  |  4 ++
 3 files changed, 111 insertions(+), 7 deletions(-)

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
index 1458b50..3c3d398 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -336,6 +336,61 @@ static void config_acp_dma(void __iomem *acp_mmio,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
 
+static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
+				       u16 cap_channel)
+{
+	u32 val, ch_reg, imr_reg, res_reg;
+
+	switch (cap_channel) {
+	case CAP_CHANNEL1:
+		ch_reg = mmACP_I2SMICSP_RER1;
+		res_reg = mmACP_I2SMICSP_RCR1;
+		imr_reg = mmACP_I2SMICSP_IMR1;
+		break;
+	case CAP_CHANNEL0:
+	default:
+		ch_reg = mmACP_I2SMICSP_RER0;
+		res_reg = mmACP_I2SMICSP_RCR0;
+		imr_reg = mmACP_I2SMICSP_IMR0;
+		break;
+	}
+	val = acp_reg_read(acp_mmio,
+			   mmACP_I2S_16BIT_RESOLUTION_EN);
+	if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
+		acp_reg_write(0x0, acp_mmio, ch_reg);
+		/* Set 16bit resolution on capture */
+		acp_reg_write(0x2, acp_mmio, res_reg);
+	}
+	val = acp_reg_read(acp_mmio, imr_reg);
+	val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+	val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+	acp_reg_write(val, acp_mmio, imr_reg);
+	acp_reg_write(0x1, acp_mmio, ch_reg);
+}
+
+static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
+					u16 cap_channel)
+{
+	u32 val, ch_reg, imr_reg;
+
+	switch (cap_channel) {
+	case CAP_CHANNEL1:
+		imr_reg = mmACP_I2SMICSP_IMR1;
+		ch_reg = mmACP_I2SMICSP_RER1;
+		break;
+	case CAP_CHANNEL0:
+	default:
+		imr_reg = mmACP_I2SMICSP_IMR0;
+		ch_reg = mmACP_I2SMICSP_RER0;
+		break;
+	}
+	val = acp_reg_read(acp_mmio, imr_reg);
+	val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
+	val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
+	acp_reg_write(val, acp_mmio, imr_reg);
+	acp_reg_write(0x0, acp_mmio, ch_reg);
+}
+
 /* Start a given DMA channel transfer */
 static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 {
@@ -773,8 +828,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
-	if (pinfo)
+	if (pinfo) {
 		rtd->i2s_instance = pinfo->i2s_instance;
+		rtd->capture_channel = pinfo->capture_channel;
+	}
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
@@ -990,6 +1047,18 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 			acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		} else {
+			if (rtd->capture_channel == CAP_CHANNEL0) {
+				acp_dma_cap_channel_disable(rtd->acp_mmio,
+							    CAP_CHANNEL1);
+				acp_dma_cap_channel_enable(rtd->acp_mmio,
+							   CAP_CHANNEL0);
+			}
+			if (rtd->capture_channel == CAP_CHANNEL1) {
+				acp_dma_cap_channel_disable(rtd->acp_mmio,
+							    CAP_CHANNEL0);
+				acp_dma_cap_channel_enable(rtd->acp_mmio,
+							   CAP_CHANNEL1);
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

