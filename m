Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A8AC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA020842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h7Lv91ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBA020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeJOOkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:40:01 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:21305
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbeJOOkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfXo7VbJ1klA+IlzNFsdqcX7tDhzErBLdPsjOyw4V54=;
 b=h7Lv91ai/jXD76iv9kjkoSAtCPpqfkjwM0HDZp9JQCusObGZaZhlHI6+6AgfEFg/obU8zpx8EYQymbUUqkflzd8jCtXe5KQCuhFPam1L/jUp4afh8FpMCcVUkgN8u3Rgd6OHMjos4uk2HsWcykMe1jAtPhe0Ef0r3GTXuwHBHgI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from amd-chromium.amd.com (165.204.156.251) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 06:55:50 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, djkurtz@chromium.org,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Add SND_JACK_LINEOUT jack type
Date:   Mon, 15 Oct 2018 12:24:44 +0530
Message-Id: <1539586502-12516-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: PN1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::26) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf34b51-7b38-47f5-1198-08d6326b4456
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:KOT78SiyC1UMhrE11d05CGH2ZK5BBw53P1xvWt85VdFcmSsRWkaEdC5esWyGhYKC7SovW8zG+HAebLRGDuvFGJgyOD4iFZDV42WX14eOhIfk5/K47hYQQK8FyLhe4cPcRvF9EKVJ294MoJ1ew5b07NUFYlQv4GzbXPkzR9u4HeyWd7C68S7yJuFLjjm+SZo/Mtjjrk6Dx9GUiX6wfqoNKEAIAwp9TO6yrCXmk6MsSfehfm74u4dJ+XF8kEPO1Qod;25:rKnF9XxEt52BKGfT4EbFwWO+Ecx7P6dNOBGhwidYSP+VAGkrZlUvqgPJ6gD15V1OGMrJlGL8HrrLT1gIcx6YI1OKu7CUrtKlUSBPZG1xCTAVzddjBK1uLAA2TMA8rtg6xkRdgiwTJqkRXWnEZtOB+Une67hNJxlVMp2IHs6+6WSwHPll1vQg4muMDmo8hoihZBrQtUazmib5HrrYThYJpz+0mioJcNAX1c5B4exMMs0CwDbUx8WCMzT0/pDQEXrL37CrPb+a9xhua87gPoGpsqdeciH9+o5cG5RNNq+VqcXaHYOd56gpC+CMt2lA6whFTPQ216AnGBIp1TE3FD4vwA==;31:zRMCHmyUGXVhw9WRHl/aB1hVBRe7IH3FTJY/FTC6ngpdTOGXammpvFsMw6xESevmb4EMzp/cN1YfG7aaI3objCRlck0IAPntzE8tPPuMXS2YEIM05yWiBaOGx56iAS7JAkleN+hgRTqI9y1mBgf7Dw3usk81IsAN+I3HngKCSalU6Zq2zTLnrqrAAKjpw2ymYJ1DkF7ux7VoG+7FrQ5CnyHT4ju6Xl08LrGpo8WB6kA=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:6aTqVSOn3trKvfOiBPvzXrl4xgKBJZmq4heHJe1/PqsVF2u3vJZ3KkabQWpWnkSjDzBvBkEbvVhgPLlViA+nOvbBktPizOJ4H5viFKoqSyMKHpLM6j8DnYM7gby5KWimoFHLHH0dBGMQ5mkqg0j0vA4a/Ytnq4OuaypNcAOMdkXN49ZCr427OgEM6K34OVkskkZNHhFZSMxfyBO7RHa4mf/KvPUwwvoamOo9Am4GqjREWvR7KxkWmVpa39Ea7YicVlupU/ReC4u67ybD25SWl53jfkQepfUzAQvVoB90tY09o/7LNMWArFTo1DSmGzbLc9VezDOfli8sUZx4/xFKQhxTnswxXlK1c0sfsvtJ3uNl3IjHPfBD+dbl45dkO8/ealfeN+IlOfcTx7Gaotr25KOkKTCVN7JaqkgRNAyunj9+GB9EcpiI8JOogQlXjb3c3oh21yoHMrD7Bb1BkcYNTw/96C0wPOr7l1CX8UAhwuKXTKlDBXFx/ojkEHHG3ExE;4:XjSodF+tu9fencjIdegY+qS0oj+dz8IENSRhTdBN6sl31gXnPrsSrAa2P8qYNdYbcazDwI7gKHIdAjIFaC0yT8rY+XP/u1h8+zUBE77WTKhXzAgGTZHIFhDkmwezydIAVlUAUuR5uRHGOGhqhvlIiiSx/dKyoQ5+3RAUC7cIa5oK/QYb2ynLIkyHYJgYHzCrUL5Cf8kuOZUZRg9KsZfvjHSosBwpSk/gyjlYs8vWKZYUqnwi823QE5nk2QzvEeUzzNglIGndKFC/ugjmnOz4WwgOrV01knUjWr9Hxh7GDSbnL/oRN1Yd4mKU1M3+K9hV5wiKpij3idLH13RCDYGAzQ==
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364664C59269511827D8632F8FD0@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(36756003)(478600001)(14444005)(68736007)(2906002)(97736004)(386003)(105586002)(1857600001)(106356001)(53416004)(6666004)(6486002)(86362001)(575784001)(16526019)(26005)(956004)(50466002)(5660300001)(186003)(48376002)(2616005)(44832011)(486006)(72206003)(476003)(47776003)(25786009)(81156014)(50226002)(53936002)(305945005)(81166006)(316002)(7736002)(54906003)(4326008)(1671002)(3846002)(109986005)(6116002)(16586007)(8936002)(39060400002)(7696005)(66066001)(52116002)(8676002)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:amd-chromium.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:iO5P4BQljDKQspNRBFix2eBaHFLfpO2XGi/uB9bLK?=
 =?us-ascii?Q?4xCV5uSaHQpX/Ceqk2unFCuRsNBYkGHxRwIM7i8XtRFWKDSoCtdikjOExdAz?=
 =?us-ascii?Q?4L0fM4EluxkdNfRj2m3jPw5GLUuSveX+WBvPa1xLyspV9uz2s1Zlngg6jDPp?=
 =?us-ascii?Q?5QtvMZOE9UXqIukRyHduoFYaEgL5Ok6Hla8Uu15xNL1GIxMeqcIIgwo9Vaq2?=
 =?us-ascii?Q?t1fBdJDW9WRyt6ep7HJfilj5buykX2q6etuFrVZVs+Z+e67oy3Xkg5SZdCLO?=
 =?us-ascii?Q?lHtfqtw5P+BcanvJcmgzQQQy5M2g60Yzs+U8Pe7Wn71nimibUfIS7hNUtcHA?=
 =?us-ascii?Q?Usb9bOiR8ZOUCBCFjEA1ks/7+iMExau39U+a0vmiR4QjM+iNNaGRUuS/KO/a?=
 =?us-ascii?Q?c5NRcKYVxFrfPwKznw9TnLUq9EdEh/ZwK61dJI38Y50mZxBQhNg+nAA3agKj?=
 =?us-ascii?Q?uqil1QuqV3TjE1DP5ZAhmpjU9/RXqnv5sgM/iJ+R7HzOuzd2wzG/EVFbi4Fa?=
 =?us-ascii?Q?O+IVR/FxkHjRCU0tfm5EAbuxfWu5Z+OmmLZjaecZuhlc4epBVBOdrRUG6/G1?=
 =?us-ascii?Q?eyzu3YLtfA9hlWZrLJi0pw8XcKErWaAy0n8av4TSkD8dh9M053eDBRlRTFh0?=
 =?us-ascii?Q?gtOfECyoAmkS9BHvQjnIuuy0psZbAT+p8Zl3UbQCxGqne8LPrqWVqySs/WVV?=
 =?us-ascii?Q?6yB6kflVSeKAcd+JETAL2BVW4+6hF9GzzjAtyjLnrDyty/jspsCujl1X205X?=
 =?us-ascii?Q?0FnF+LSSwB31fDooFKjOG/DCmPcDGL6Q4X+Ou+tIaA/GZGkorrciMzLYve5A?=
 =?us-ascii?Q?S6/paOUSiWd7fjbyMzi7eQVuKw2oOd4ugznCG5InDpnG4C92/Pj0gVOih0GW?=
 =?us-ascii?Q?SXzOgSyGYivB/OZYID9SorN2lqf4ecRG92azjGoayiBZOrglra8VkPHZhsAH?=
 =?us-ascii?Q?0vS8VKWbqUbTOic54U6PgpieqQg6Ol2DrvjQmOfwLorFllO/zYDRjKMYptab?=
 =?us-ascii?Q?zqtzWaltScRbI4FV+ZVJMau3fD+V8NrVGsimM0C2+Uw4MBQfkiGQl5GptRL5?=
 =?us-ascii?Q?Z5R9kBHwPrGwGDFl2dOnxzGDiN5plZvYOooP0ZCqD10TE2A9zCxaL6kO5Csj?=
 =?us-ascii?Q?M+WFxARFXZyNfomq+9BZ7mHrtEe560nljw64AjBeUfjgO4BS2tmzAn4io8QG?=
 =?us-ascii?Q?oXTsEL25wwVtD7qolMJAJlV+9m3etFMnlrmQZz8Z9RcGsHzjWT1UzwQEaTS+?=
 =?us-ascii?Q?furnH2pxSFduAeYmZRCXissBIAfdQx1c+k6w7/KYuVkXul9hX3p3QnDxoL6S?=
 =?us-ascii?Q?ii8LRKVrg1StI1NOnwsslY=3D?=
X-Microsoft-Antispam-Message-Info: Tlsqu49TdTB+vq6BV09fukfI8hY5+bV2X2xPgwJQo7/VMbGdl7uOTfQJClJYD/FGqJWyH9lTaI5TtsE9UV/7G8MFr3WZTCuZpkLmNaDzVZfBUb3WSA4CDcSfKrysJESmT8Nec3mky6UU+u3H8F+pCr5URv9AsQwkQ7aQMZQ9TIuC81lWCyFAKcFJ96zuEi2tcHCW7vlkbuDIHf0kW7+KDaNXQXuEGHuEY7Dmt0gwGsZZ9eBtDuMjTA9r3E0D+NcAtyl6bkgWYLCmdFRYtWs3WHxv38Ybs7rrWQckNNzLhxyQlnOASi/tFQ8b4/yq78zEhmKXzR4zQo3QO/1ukFh+BBiqQwwOEeQkidd1TF2q1xo=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:H+aaSb8xnxnQ+lP/TP6SnfTKv5uKufZnUFbRsC8w6S4V61q9mZ7mE7uePxItGuBTiaRSxriByJHq34f2jO2kpnkQROGzBVUxSG2CJ/uXltc7wP3rXqr4rBENFIJav1O8jUmkASmXL7Z8IUKvnYp/rGrk4naTrJ0EGc+dV4HGKVRIT7ncEkADkC1n5/679ICjWnoY61MdrFfANnQG1MoTpkoXwWyMLzw4bS9mqAJynqZ0eOvYauHODsMPaFphGgZptOJyqKs1jqFTwsCpExEtrQ/LXy2L2U76SZmvQ0Rl+QAYhvuv/2ZmerRBi1VG/yE7YCDdF/EROudKlBb0S3cAaJUlgspY2QKXImffZiYfjg9Y+VM4C92Jwx+NgkJFizk+6aY97QzGoGIfwzWOe90plTVROGXvpxkfbjplxTjd9+WuwTt3l/u7bwxx4+NOxgi6UTH1Ru/f8q/5R0X7cVCrJg==;5:zzdDlg97TlAyYcof8AFKuoRrwLU0dgKGVNe7sFD4qB9b2ClmwXzykGuuXJui/vEsA/7NO1TwebLk7JL6bTbJ/BOgwQtwj+WZzVrvA1bk+J2n6v0BHLqVHpihaGiGiWgGT9uF2S2bZ1KVRgvUAe5fLbbk0q7rr5yq+/1CdXLrmhg=;7:7celWMb9/aSrvpU46SIp0HX7t7dap+uxBh5JjIl6wRHp3kub6oBqCDov1x8j3YTZGZR0vbp5lc1N9hPdu6onYHf92FZqaH6kaOOWSBmZKvlIKa7sikf18yJQOsGk9T1kSEP6Ycnaei52/V0fBpujkBWGO/GcPbXWJayD8NTU1022mOBT5vKbDykTpOB4OSx7sSxiL4Lu7/nOqNJTT4hkAV62OEOVN8bYrzUUD5bI/P/No+C4mRkvEgK+M93xGQlh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:lfmSawuDKt1WcoV5tJ2rcoim4DFkAzw8YDmAdx8ep5Z8X44La0S2nubdju/C4Gg6wT2jTvBownuRdUZQudDXpcIoYMyW15KsYB+OA9tIY/MmLFTIBXo1TMhov0p5csyGr4dq4yKQeXQL7dqvi6SLDuLraz/dlsPlZ4rFeJnaqo3CPiHnystGIwmdoLjELn0F9OkLCO0Zz7s3yapYx9SGMC0MuxKRBmedVGktQJJIWrXGd6g1NeJtHuaItTn2m10p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 06:55:50.5750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf34b51-7b38-47f5-1198-08d6326b4456
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some 3 pole connectors report impedance greater than threshold of
1000Ohm. Thus, da7219 reports them as LINEOUT.
Adding the SND_JACK_LINEOUT type so that we don't fail to detect
any 3 pole jack type.
Also, changing
SND_JACK_HEADPHONE | SND_JACK_MICROPHONE -> SND_JACK_HEADSET

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 0d97d00698a0..eced4820b0bc 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -75,7 +75,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+				SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				&cz_jack, NULL, 0);
-- 
2.16.4

