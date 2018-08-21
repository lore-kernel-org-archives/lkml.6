Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609DCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EBC213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AIaeDI+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EBC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeHUKTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:19:23 -0400
Received: from mail-eopbgr680083.outbound.protection.outlook.com ([40.107.68.83]:40672
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbeHUKTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY3eGvbulTG+DzLETstPNCCPnLHCvIORz3vboLEAtek=;
 b=AIaeDI+htICoPHVN3K9XkHLirfOcB3lCwxsvB0z7vfYCd8ZO5KyHiNWG5TVU+/sWhoI4FGaZtvjfujeILQMmWrnkCWsKPNVj//8KZ8WHVEClTblA8rfpHNwMWS82GvLlaD+mDhY7TOIAaaYR3b/lVPiti8D0BFqNhWeR5ahYylw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 07:00:18 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Change MCLK to 48Mhz
Date:   Tue, 21 Aug 2018 12:29:43 +0530
Message-Id: <1534834795-18494-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BMXPR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::12) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b05e61d8-8f48-4e9b-95ad-08d60733c387
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:qYODT7GnT4jHE/ZkMeuJHGpHwt7F8u+FnXzeK7aaoxuYEr2iQhHFqiMklsgZv4OcVXGipXinN9GT+kGy4BGyWiDTtgQQQvroZInKcODw1zL7xTnLu3NydOWQyO4xCYXDxvDozoR3PI+W48Nn1J0nNS7C+JmBGPcig59J0v6BA7Pu7vGuO31dBDpWzanstVC5yWgQo+Q5EIkROMZ9bQK7foDrKFFC6tlqvu7AXgAzZKICWkTAhCuXBpqOSCBOFOi9;25:3nnrinJElxlkl9ArYMVTMA5COyekWj6tFv+C543oGcDjNue4HdtTdZOA7BN9r8Eb/wTTV8LwcsoatDmaUub/WWV1h3JxDw3kAFmPTpKUbaZbob0OiiFgRfhLHefXutEBptzDKXbuu7eLXEg8A2K6szajv47JXfEwhqyyp+NLppld73IeDyEpLR9GpAnTO72IVv4kCVuTCh9+pGGDdwmVj10PxIQKRV9oImhEUmYMSMp1VbsWlFsmve0SGSNx+ULLs9IcsrCNl6gGLurrCJNfAKTG5n/DgMmt5I5RMsPItTiy5lrVZKGrXwTA4Tm+aOsLEZXR1KldVY1Lfpb0EJgV2Q==;31:MA4rVdmoEx2IID8ppEYTbsaSHw4x+eYJxOdF4GO5cu1xCkXp+dvJYEgFYkF9mfyQtDuZhpQDCcO13lXp504RkvrrRe3Ozqy3PjyhdmoWN3QjDhJuBTTe7xmnNJAvPem+D1jL4OP5WunlTszJ7v8i0l6fFycvJxuKYKe8Y6uH5VM18DQSZ9n/IYEKhgozEAiFuWE6UhV5FyDm9uQ+gRLZaZSyJNUcuWaPhSNBdTjttPk=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:3r2vYXW3+7jS7l7qwAcZrvXZk6r1y8og/EB1yccyRQFp5qddBkRV+S661NfoplMUxv9y7MX2B60E1Ak4GvzU8Qkqq1QOwY1llYPdfkD0i8/rjDpov6jiJ9FFqLfr1vy4HHf8emFQt7RkfCiwdKb4kaB+jZB7B4VaeBV7RYhEm4kz9HXMA7sY9mU1CAVHpGEvbqRb/Ovc36sq2w/dP/UvdRG5tNv7keO3iO0i/kvzE2O0V6lsPtinazPPVXjiwB14h9suj5yb/iGipR8Sy4r23iQhk8kMB+FbpshGtRPCi4/dzbsgdu1fsOqBkaSpDhd7OGZQ8d74vYAJODjAQb7+4V/J/CmbK7vzuvMV/u8DkdVDDMWT6uef9qCVvABZONmQQlvpafiOfUiXdoMvRIxx8PTKDZpNDCLKaf/Mf589JHTZD7r1AUJPR27IKgqCoR5B2NA6qgO7n3J8nE6rMsNzVr8PrkK09o3VzDD73bLhj3pV8A5TpH0M+XHrpo7P2wnz;4:qw9YGdISwq0tI7CO8iWBWLaZFB/t0yhvXXW/Xo87rktNgkeMYrjfflR6HTJcwl6oPsOBU1rC0Q/w864LKrFVNnOnX3QOm/QnDYPI/bS1yGMI+Ul5cZTuKvCFXc08vsk/ReEkIxBTCz6LErJWq+Md9NXZ8eI5tKvuMK3ECUFKShqTVzGjtnVJHFvcHHe+Ceu/cS0qHzpHHvlpkAdqIq5lO1c1Sz3zZdF7dZ0ngqmj2rz5D1AxVxJgt7GYiebrP00W1xhNxP4JL8L9aFRYF9UWqxoXTw82+0aMXLYdgo3RKFxC4ZVq6RguxNNw2JQ6AwNB
X-Microsoft-Antispam-PRVS: <SN1PR12MB236655BF9FED6D4D8AEBF50AF8310@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(199004)(189003)(81156014)(8936002)(386003)(109986005)(14444005)(81166006)(44832011)(2616005)(7736002)(53936002)(1857600001)(36756003)(25786009)(26005)(486006)(2906002)(39060400002)(6666003)(52116002)(956004)(8676002)(51416003)(3846002)(7696005)(50226002)(305945005)(6116002)(4326008)(105586002)(1671002)(53416004)(106356001)(316002)(5660300001)(97736004)(47776003)(66066001)(68736007)(86362001)(476003)(478600001)(54906003)(16586007)(16526019)(50466002)(48376002)(186003)(6486002)(72206003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:uf6N/KmFjEHWBhxwuljxbJRS9v5p2HZ69wMA48//j?=
 =?us-ascii?Q?RqsVUdOz2pIRNS2Mn78MdWEY3IqV3o4YrGkRw+etIFTdXfOrCyLANI4zHKJN?=
 =?us-ascii?Q?yWhyEW8o4R1JAN50U44oIMKRi1O41F3sYp+vYUty4jQFAkVVoRnOk5yVU+T/?=
 =?us-ascii?Q?XQo0lAKz2Gi4pmTarEo8L4v9qocLvfpwOiiEMezDWz1QB8US29Cot31d9Gbp?=
 =?us-ascii?Q?Pt49BIh+j+aXlAhKALjTeUr4TnLgzXM6NG4nPqDpXFwQp3+u7ymZs70k11Bt?=
 =?us-ascii?Q?Ov4G3PsNIssgejEpSix0xQt/neOuXpH+jJE2338o/BiXci3C8pnN1DIjXXrc?=
 =?us-ascii?Q?fcYiquW/jYd1a9HzoO8+qYSo0AUowatDumgo4LUROB4eJfXITiP8KhuirXSE?=
 =?us-ascii?Q?AFh24IpBwVEFUMMOehfcJ0moBd/XMEPp/rwJfjB9F3I060qk2lJ3/1WPpmdw?=
 =?us-ascii?Q?/eZ/+q23EfhEl5sp1V8NG/nLFFT/BPtaGRZd0einXAMixtMh4ITUYPmW3wke?=
 =?us-ascii?Q?yOso8p5eoj2nKUJmXgRf1UqZ2mhL1O+SWTfO7yBp242iWe0J+IsfFKJL2X4z?=
 =?us-ascii?Q?EshlCdxxQQyUt9iLyuF26GocRmPT0+EU8Ykmd5nqrbh2CQQUVR+vQL1PUjQp?=
 =?us-ascii?Q?s1pGAVtPDbemquTT7HjPGvNEo2M+/ygKzfhqlLZYF7N8P/doMfeY3bEOJYpJ?=
 =?us-ascii?Q?q2BEtQ1RD1JcJP9BisLx+283uTIVvBjqjV0orslFjxum/HO9d3ZoU7vwYRcq?=
 =?us-ascii?Q?jB/BAAzyHM6Q5KNi86SGEWZHi9B81rRH4pEDftoDaNkhOJrA8xO8Dz5VDMRt?=
 =?us-ascii?Q?+ok87AMeh8x7lD4aM7dmaQi8Axnl5b8DN+LrswYBDDF4vA6qgVcR6u9/ZSNq?=
 =?us-ascii?Q?rMafydJHl+jD7BvqOahx+eDKs2ZiLAKzdxT3QIUbSuV7ky9wO63PTJpJn3tY?=
 =?us-ascii?Q?igo3fGKH86s+HswNIubL+4olYJIJ6oyymy7Avu+0wii4QysuvvyFBTGoEuDo?=
 =?us-ascii?Q?mKBsAFyQQKAxYFzMr30kR9vTrA9NwWCog0RdXLOZlXicFCnEqagGyjNvYhAN?=
 =?us-ascii?Q?BAmH00gHMMokfBwMOp6mfU/lJF0p26zMqojVj9yhwGTCpWgTiBtGYSO9k7b6?=
 =?us-ascii?Q?DyVHqx2eJCDCBmVOSYDV3aZPgOdn2s5YHCLksj7N3tXaHFbjgwdoyowqj5YM?=
 =?us-ascii?Q?VPNw1Ty9xTIlSTgKtwqB6QJzMoyOo52YWDzXvGTosrwgUfa6BNesrEAh/d1V?=
 =?us-ascii?Q?LBr2qrmGUKPs7sE2Cq5r170JfNIExZTAI7Hlp+0jGh3cGdSrNJ3WQ9vLZkWu?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: cCoOZQs4T3811E1JJC1hxBVefjUfJ3X6fAI535SmNFaTG5RrEPSnyNAV4KDhk0PxNloCFdESlMqhj0RB6JUE1MuyYnVQt1tbuCQNEsJQ/2S7YHftstud+UPyqR/TA3IE/dz1ri1NzG0vQeCKE4d5+3D9QUXKVfWEQkXkGpr1Ay52QFbGcPud1FD2PQw1cWInYuFWLra4nmjPMfNqUWCYs3oBLsH7PprKLmTayP4iUUel3v/Z6Yhy5uxoWK0dWe9HLhlw5zn4JwdrZy/hGMn9WxToBK1dOF6hoAqMEVnaMKQuIc6FnT8HK5KlKw+Bt9sApWWkCV+BPplAX0drt6zBuTXI7l9Bhk7F0LiTz7InztU=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:24Ls+FJw1zQPRgsQrYwUf0n8gbkJE6SaK9g34cPfD4jI44N2/fNrsbyHx/6HN6AoKHNNwNrN9Gq8CdQLRE2q7DUg+ZkNjxoonNOlSSeef4E3u5TJ3CyR707a023+VUNavWEJSiG73M38kb1/KA07xXHrwzB1mgbgFTOotn4ZyQG6q/C/3NpyCPWPDhxCmxC8XQ6ULAxuZilOb61vcTW9UzYoQlFH+hqYoJI1hM7IGapAy/NbsfF7vYzNqwDSPa6BxbGCLQGpJhqz7ymLIAp/+7Focdp2YLi5o5FUXDH13PqwVCqFKNyJFoesDMdxBzwBQoeFOlQwPsSCf+xPYsPAXfBdlskZ63Z1wjYiFqrXaOH3aICPgpB7ZeRNfvZJB6dB0bywccyJfNWoBsiGrTL+cR+auaFnslwcwh9rZkwmEj/0i0ig5fcW/q7MJLSpjMcxZxkpr0sVnMgn8XxGJKKTGQ==;5:k6CTa71BrBs+ZSKJTEhs6bMQXAAoVeu6n792rHesO6fc+ddt+gCKJU5HpqiwgSV1brBTKkk9JBKmf3xZWUjYhR2g1cwzInDWTcTvtlOAcovhOvmEM9CiKRJV99UBOxMxCLrsCVunT7LSYNgcSIpBcJTkJd7wLTwwPWAmqRzG55g=;7:8dMfDZD4HxP+ytVPEbK+SRlFjfT2hfb/I/ST96A4WYhqSK2rmakGj+noO7rlXC5zPnFbLnbx0RTC6KOUvlysHfl7gZ66TForJW+6TlxdKmJT976MB+f/GMHFmbBAjqQRny4xaA1O1Q9i/LVZFOn1HmgaRhvyapZnQxoNt0lMNFnfD0SC3AqlIbeUwqJWEcQ7+dQFfZaaudoSjA0aV6NytqVRosFIuoA0GS90oMSxzVpecJklXk/sXlBCebOuPBGq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:J6JO3xDlXeOy+dwczntp4+6MlBkiHldulbis+4DeHzNMGu9aS95eT4H2B+N7T7LtZ7K7foTfL/idl+CrpZBRVN+cPv4teGrAyUl5SpmkhbSaMWEN4DTwi0kde5m6nFpOjW0R32QZB448az12sgLaSdQJA3muO8t8w3Om5nj80zc2uhV1WWp1LPO7ebvZPPg1NKttAzmKstM++AL/OjE82XT+7e7TE+dqyfljysXVv8SsB3g3ILix58rg0LimT6i+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 07:00:18.4655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05e61d8-8f48-4e9b-95ad-08d60733c387
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25Mhz MCLK which was earlier used was of spread type.
Thus, we were not getting accurate rate. The 48Mhz system
clk is of non-spread type and we are changing to it to get
accurate rate.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index cf2f648..55d7f61 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -42,7 +42,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 25000000
+#define CZ_PLAT_CLK 48000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-- 
1.9.1

