Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5426208A2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xd876KZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5426208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeGZHMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:12:00 -0400
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:43872
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbeGZHL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKh65jFcZBShhQjcK7FtLih+9xUPHwqVQtxEhgYJXK0=;
 b=xd876KZwz9camkPkqQXz5wu240xskGldYrBiHxxrffFb07QU3NUiU7iAPe3vKyibLtZvNHJa42ru68DxNXs5nOrHpjqBf93dq4Bjb7hEVwuHlNmot+0WZt8w1V/rklJV5CEbIYxLUh+w8sYwMbkvG36wOVsVWzgDzDe8YnKbQOg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 05:56:35 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Fix build warning
Date:   Thu, 26 Jul 2018 13:55:48 +0800
Message-Id: <1532584572-8362-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::23) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81473155-0123-49d9-e5c8-08d5f2bc90cd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:mKBXrePOvlFwP8Vvi8JmQQVi5xIaYciVsmT+ztOPDGffagwJkaBtnbkFHx77aANSkkVyCzwKHlFdHDSrQKu591lvfZ68YZAqPq4wBXYC4g43TOL9wq5FZXiBDgHHEf2v0yXI7NKHIB1jSzVGejHtN9pY2CuvEvPx4zext+QIt3a9nHjVrWOACzbevUP8PYdsI7eP2C8adLTGn/s4Aml3Eu2L1tQY19D+a/PfIgbxFCBpX1L6h4t3lmDG5MnRfCip;25:Xa75ylqRheLxU5QiQtGhh1nKw9h9+E4X1v8OSEjgQakajelutiGfpE1+e3lNBapOcPTTSSrt/d3be5vs4WNPxZPAhYGpjMWIXiFIv5h8KeyvXBSGXRq6y/D08sDLdJd64hbSMK16ReoZujrtjuezOF8xQpcZc61QhLoNH6QZIw1Wsj8Adhr3iaojk4ZDuP5LdEM1Gt4STkWl1N75Z2DVLO9yms/hbCPxK1NFxtRSzFHCBPQJ1Y+Dhe9paMbB6dYzEu8lBKddkr+NMEp80k+Mmjpju2WMIKWrspNtIVr2315b7H5yPXjU5cFMWudparRq91IeCUar1Co49dpIMcAMXQ==;31:rQjPjTZhfuva2D3uGp3uKtxvnbJNqYjDpzZM9VTM9ObwQC3/ozCCxVcNAh9h4TswZ0wELSCtb9gDAv7ZNMw3oSZ29WuAiA5qDqo3KVquGbxqJBtWjmA91s00Cmz/VxOolENJ3QCTgsLmUVwmHyw0Fw81Pvpdy8J1oxMIV4UOMFWbh6ZdhHs7Pum2rzcWk3+tZps4gBwhexjzFgkAqBzr4pSR+5dzz91g3tdzecciGAU=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:JkStiPumuaDrOU3bucyDjw5Nyt/kQ8j7qdu+6oGOgIIlSQZBpF3m7BsMdD3cor7LIE1idUyuyKgV9p1vyQtdzCchAAtwfss7TT4jLJ2NImy0m7ze1zV6a7yOxpxYlLoLNpCdflHpaUUZ8tSr2Y80LyOBFNNEV+KUe23aEWNertr5gcBSUlma2rljYsCee7g1aIz6C5PPxFK+DDC5rS8enVYdAOsUzHYAw6QXY8fmZwJK0+ac17OmLbNZI6LRsONfu5CUHmDGjKEMHljfpFcJs6OSUlNmZ0M+Sp4TfKdMryckMhNPlWIwFdIZfKW3GxDUkGkEak7Fn6wHLSblaFYpZ0czJSiawGcSelCi7P/1jMOUmOihKXUGvALi7kBr3fDaPsd5inmF6sjQErHgftE6yD+YFpmsHtWoIAHT9e8Ko/FN1VjrG+6YfaKVHmJ5sHeiAYbg0ZED7RkpxOY0H96Sd95qpoN3F2ynJRnibx9sg/SSCPup4DqWkra8GASOyJUk;4:S6sWRCMZoRB6WTt9yUtdGMKH48ZmuW/KQBn7gajTkzzTQ2R3ZSXOipoX+lUjicpURK6AFzJA93tEw5PGpc6npJ89cQzFG7LvH1HZpci9Tf26GrzdlQM+ds0RLf/86O7xAyAR8TpkJxkWy2PwemR0T3p8Crzw0Y+MzgW5IxjMG0ey6eCehq3Uk1PGIeReL9IannAVvBGa5IiBHSKAaUA53LV3jcHa6ATS22g4RuWEwc3W5j/zfTCxTF4dOQaeq3FWk/n1ZtBkzKF5f4xQx7+Yrtngo8BHwm9L9h6hn4pcChjDfbZxwiYhUzWGg95gW5T5
X-Microsoft-Antispam-PRVS: <MW2PR12MB23644CE490D214DED24401A8F82B0@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(8676002)(3846002)(81156014)(316002)(81166006)(6116002)(68736007)(54906003)(16586007)(478600001)(5660300001)(6666003)(476003)(305945005)(97736004)(8936002)(53936002)(50226002)(16526019)(14444005)(47776003)(7696005)(44832011)(53416004)(50466002)(25786009)(2906002)(39060400002)(26005)(956004)(6486002)(106356001)(66066001)(1857600001)(2616005)(109986005)(36756003)(86362001)(52116002)(51416003)(7736002)(72206003)(486006)(1671002)(48376002)(386003)(105586002)(4326008)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:ejoTGbv7793yGv0SnOEyUq21Y3CAsrNLN7Fk1X5Rx?=
 =?us-ascii?Q?+jgWwqYo7vljno2g5Rz9eZVvil8cazbuTkS8jcXsj6tPDb/BMhxWHWB/xv3q?=
 =?us-ascii?Q?l1asRPrxldZom43+O1TtiIpMN3QCVYr7M7WiK9s9Z5D6fnLNTiX2KqfMqWPc?=
 =?us-ascii?Q?Pqs/PhHu5JiWQEebWJXY0xqCK+Tshcb5DIJvzHk/keziDx6VaFdZ1S35aYP/?=
 =?us-ascii?Q?Ap17cr8DH3qvnO5WLsAoVMceJqIjaePvFFtpPDiOmglXYg9mLKlv1E2ulyyX?=
 =?us-ascii?Q?8+RrPVnv5ay4kK6793rTLX2PxTin6SiLtuwAchXQDeHXbvSn12AFVt10ezAE?=
 =?us-ascii?Q?Rqyk9KR6ux7LoEW9U0BQhduNmk93G56FeJiViL6RLrIirfSY6r2pq8mlSEwb?=
 =?us-ascii?Q?7Pam7PWdFyE2kCoY/6dV3x1FOY0f4FExTNWJJTqE5jQoRQTqJF1LNGVhAjhi?=
 =?us-ascii?Q?pIhIZeBSFGjhsB590/fk8j4b3q74FE9g3MhUFc6gI7zPgw1tqNbqZlXoHrzm?=
 =?us-ascii?Q?AR/Ayezs5eUPhOpXdoBbdQQEZiCMcu5Go8kcHRQSG2c+SZaWu06sc0ejSI0p?=
 =?us-ascii?Q?sO1swPJ1l7QM9ZclvGIR6Ppkr144/3uwnS0L3aMf/E7tx/tZhzidMPPPPlnD?=
 =?us-ascii?Q?9491r2qiLv57MD3tMavwH5pocUh0oLQ9MTe7TbTj/hR81gPaUtkWE7stU3Er?=
 =?us-ascii?Q?gm1ogbeSekL6AJaddx7FTjrbp2LZXI66XzCUINPyj4JYrQLb5YYpSHtFP/xM?=
 =?us-ascii?Q?Tgiks4xuhFdVIQ7ENYfYUsDv4AWbuI0qGmrfFyKqggRvi4fx/3hlFMFHM6LB?=
 =?us-ascii?Q?uVGOc6R4QpFCw2Q7rmXIUXtgnXTW6WmkPCEig4duYfTnd8uaMHIZgDZUAKyz?=
 =?us-ascii?Q?TdI6GsLENR3FpjstYfE0ZkTe76SggZxi0UG9NqVdq/xNaYjgX1+nrir0xVkh?=
 =?us-ascii?Q?4HT7stqV7qulW6OVjbTuk+Wcuqt2o66vVk25XPaNah3wYxBlIHtPd6nMJ8jH?=
 =?us-ascii?Q?iSQjP2dkE1JzTMj2oKiCMyz45Wdc3lwj/2b45MsPouhPrnpWTi86CDHUXGvA?=
 =?us-ascii?Q?pY9qr9lzbEuRJ5kE7iaxeSlpS+idF2v3rkH9cgfg7R2y4Foc4PXarRU/kJeh?=
 =?us-ascii?Q?aCQDW83jpxNm0KcFwiO/mNXpIsJrJiihZ72CCDMyzjaxTHS9C0FxwNHIzIRT?=
 =?us-ascii?Q?5KOZkCWTvkKJEh4aw2jw30kxajGftNRHiT5BiWBuxK1UZpXS9HboOfeCMJ9e?=
 =?us-ascii?Q?fXmQP4hssPDq1O4hJKn6HJTj77iV7A97YPJBrqJ?=
X-Microsoft-Antispam-Message-Info: UbHaah9U3T+IlMMDHCM/X4NXe2gQSXdao6UVXqxJHfX6IbpGSjKB8DMKAAMKgxBoyHyrHnBK9KhArHRGbB0xC8EvbXFjbHFCdQPom0EHEZflpu7Lxcxrcj71WPZ9H1yAJUNx/OARkfe8TP0p83H07MI7pTJ5jrEsgyErSRjfa8ggb5F/koI3Jko1UeD9SvcMd6oZs+qiHAObFyA6iMxBlyI3tjwnZHTukBOVA0Tx2c8fRlNUiXVGRpND5LmyT5eaajQJ0yn4M3947sEr1y4i8n0uxSQkYzyXAz3BjnIB1D3eL/VCN4RQbSUD7ovpRb2WpVzNij4sEpY/NfqH7Ksbjt8r3chbrVZGIy3Yg6fMMwo=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:ohp/quxnLvZjh2ROy/q7iH4HaphxkiazKaT7B8Iv2q46de01ugfBs7SKx0llVu65sWiA8UbcYqqqVr2AT3pOE8auIK8vLMcuOr+jjsPa2l8M1iAkdlosYeUU4g6tJK/WxBGpg4wdfVIogwScEIlH2PyhId40QrDpFmnhHMr7F6YI3AsflTB9Cf+jgUfkJBbX9Cwm/Ai9JcC8m0JiUTCwP3FhFW7QfXjsbEC9dUnf6bcobrl8kfhBnYbh3Oup9WK/FGr4gvqhWkKvtTtfXqQnZeKgVs1eBzZDM7YBfKRduEmUJ6m/UUzmXTAbXBtC0ZDxODAv/EfcpfW1wcP8dr7IfIKGoOPMw/2/6yoe/0G6ZSlU4KDzeIGWZnXaZ6gqzA1BAsxvF60vg+J/d5hnEo/aZkEeZiruRmjxqSvvSaqVvlFOAs/YYdBkne9+QebBc/ICcuu4fyP2jD7s7VSNX4ZO8Q==;5:viak4by/v26Hv524EwFHBe0/paubeFLQUd/NmQVmxor+S960ObTxY58voK1RPKZsN6gHCtn+W6vrDxGLzBLxJr125pB9QKap6k1m9p8WC2nGREzicdC44Vh9CNViVWwaol/7q6eeH79ma8ISgbDHMH6mdDeX8q3J3QJmOzwPCXQ=;7:H48Op0NPL64/xsZqJuSlvv9dG90MMogzJHed9G1VxDT59FnAuwgmDGSHg+ccOTCI4WTAJz/DVi9ghxmKhUQAoIb+RcPB/zDO3RnLxe7Zuh/QshAYYssKw6KIKhyOzmddBkya9UnEzgxkreCbQ2muR6UPWzClPBDIuDEMGrdqMRJznb1sshHj5sE0P4gdNV72Oy6z0w+w03Cqrgek3Pfqzdm5luqKnARxdGiV5rlGREtCMuNNaouasjiQKbQdCWDN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:8dtGewBimPVNQBFilWQUPfP44fB6u9GjuJvBZNbs9dPcWIiXIvE5f4QmDnTOQ/GOgD1T+3Fw//BzGN10LV62h6mGvslWWhHToBbni9UDz1aN5nwYTNu9/ZSCEzRwAxfSNescWvI7IQ5l4z90IQz8S/jr5Br3xzw6R5PLcrS8q5QvI9oRbtiuSyRJm6jfIu6xjW1ygokERNmbMNE9R5ALuxs79TcU0SgY2b5i0uIYteTG7AgWBVC8HnmEFr/2Z9D3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 05:56:35.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81473155-0123-49d9-e5c8-08d5f2bc90cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes
sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_probe':
sound/soc/amd/acp-da7219-max98357a.c:367:3: warning: 'ret' may
be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(&pdev->dev, "Failed to register regulator: %d\n",
ret);

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index cd3cf6e..48c1d94 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -365,7 +365,7 @@ static int cz_probe(struct platform_device *pdev)
 				       &acp_da7219_cfg);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
-			ret);
+			(int)PTR_ERR(rdev);
 		return -EINVAL;
 	}
 
-- 
1.9.1

