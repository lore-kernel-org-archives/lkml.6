Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A243DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290CD214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mx3v9r5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290CD214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeHUKOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:14:53 -0400
Received: from mail-by2nam03on0077.outbound.protection.outlook.com ([104.47.42.77]:6936
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbeHUKOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyVw4K8lX6Mw2y77c9+aXdblgLrcWBCeuDmQreHFPXo=;
 b=mx3v9r5cfjKvQ5hrOIuL+ABFa8hOxzUe12w45X4K3ycOjhkmD7xftjseEjnYEI54TXv3qn0NRZv2xV3xBNoPrsBDPbEf13E3MX/wQoMA3bws6g/RWDszrOljVU1IAy9IKZLYhEVVBBlSAj9JWFnWMnDimoyiN1EyGUn/i4c6KdM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 06:55:52 +0000
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
Subject: [PATCH] ASoC: AMD: Set constraints for DMIC and MAX98357a codec
Date:   Tue, 21 Aug 2018 12:25:05 +0530
Message-Id: <1534834520-18397-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BM1PR01CA0112.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::28)
 To SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1540c9e7-5351-42ac-791a-08d6073324e4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:OI5OWHk0VrT7rEZ1iSA6X/7pDvpzZV2gU8oJcaqhUeXG0e7mM1Srayka+w5O6CsDVIN/6Jef9XgaiaaZvKvx19Noxzj8/MxRJ/3ZNYa55tWlvxQJIRFDkc5viIgFVB2Ry/d02EjylZvWS21EzeNRXNtI8qaNW2Z+3p7pKwEGcohLfh5h8NFOkXqlq7i9xHh2SsGlo1DoqYvBYdeiw3yQG+anKW2/9iNtayo1RAnciEGViHP649F3cbP81H5lG1dU;25:6MLq61R/ub6FCP6CyCqIUbtka2HXHRuK5+v36rGacE6Q9qugrLnIYOrbG0jAIjOwK1g+E5Onx4wSdahyVI1aVyJCdtMGLVaoyxAuNIvLh6zaLwKxFcel5PnxTEC88/FIwtFDqdOC9agsD2OdY5ZiP5S50grQAivNxMti4Amtd9fKJTmQUWfL81PvurTvjB5vBFh9NvrZ440/ycgVlu5b7JAYsP9qTl7GscP6/RGmjTtUzIvC6KG1e1kkRnzIdwwM1L+nQhcnDoj4gKPxUFfMHwtB0p4SbcTl7Rpr7ATymFg4uC/huRwHqb5qmZGBn1uV5eoaIq+UtZlnCKMrsaAeBQ==;31:T5cW2gNKiBbMucaFwxi4qvq0b0+twEg1Pk67p6t9ERwAlO3/B1L1iblruak8w4kqM0KQgFWODNPfwoxjiValxce6El0bHTEnlIgG3mpLLaBy2WWC1IWfqpBrnKa/DmVLBzi5u5FUIFAMs6NfDwBtoJeuhMlFc3QjSoFTXwTUrmIHlZ04mxcAq+MPYGTNerQrDydWW/Vrs4DOOh7Vc8PE6ujmycQgtw/WnFGVOM2LpYs=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:hjyqMWeRKbpJZM+GkP0cX8I7LhrUaIsg1uaOcY23CljUACfEPvjJ7iEM5I9JXXCHSFkMbVZHukpJLp6rlYFi5BoZYVG+tWqGsbGu3vr2JkJcmOo+mkYo0ssXWtm3810ayuv3o2WjouWRFj9arWrNMMRs9/IH1tk3Th48qs5Hqc+pQrLo5FZgyN/iw3poBkt+ZXr90pJ18vPwvzdUE0mQGeRisa2PGl38UFowkiFYxLGkOxuZZ66HRrQOB22BipZugaVu2kElprX/nRNNkH613Ksja7Wo4FvZcDd2x6z+8GZhTJ0AhXItpwGlaxS3nvnJGyQJSbsx2RCjVspukXS/tHRL5OSDewo2XcNxrBYomNAE6labn7d2yT01chN8a3zGf3CTPcLfQoKXbT/e4X0j3DnMNkwR1YuJTLrYiIrdeGWuMLUEBer1BEkFwWq8+TgEPYgiycOi2lyGybzH5gbTUCpazetmyrblwxuq/J6mKBTHXvC0mwhD1DElT51FH06n;4:OGRbtZuaMyaAeF6EjI5ttvhAHoBz5MewcX+BFEAnUanoH48iiGeH2vTos6J9jAhg9PIA/9pFcEkKosdwVN7SWizsQSTud24/0l33pVe2QeKt3cXddx1GjXmIYzRul+90enn61HPbJaqClfzrAXEOjuW0vx/LSDzUl4slEEMrXj00bhoa1ODeRc4Rwm2sEf4NV6BeOC8keqCdmMKK90gg/HYBovYX4ZFMMWTYc4TdZoVOdH/KusNWrMiSo4S/Jh0ypIL5lMLqrKKTJOKBTTEqP1aMUPiX2oWZ/9wMHB2xpVfejO6pgkyND5/rsznwMYbU
X-Microsoft-Antispam-PRVS: <SN1PR12MB23664EDA026D352400A52C6FF8310@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(199004)(189003)(81156014)(8936002)(386003)(109986005)(81166006)(44832011)(2616005)(7736002)(53936002)(1857600001)(36756003)(25786009)(26005)(486006)(2906002)(39060400002)(6666003)(52116002)(956004)(8676002)(51416003)(3846002)(7696005)(50226002)(305945005)(6116002)(4326008)(105586002)(1671002)(53416004)(106356001)(316002)(5660300001)(97736004)(47776003)(66066001)(68736007)(86362001)(476003)(478600001)(54906003)(16586007)(16526019)(50466002)(48376002)(186003)(6486002)(72206003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:Mm0urb0y1VnWtSDcle6d0YB+INOcIjk8X+xBezIqq?=
 =?us-ascii?Q?XwfiAOKNJPFLYf55dMipvVQiPN8bwe7JmRsSPqiA/XwC49dsfekPSc6SXU/I?=
 =?us-ascii?Q?inHEVg9Eo1iHcNMKrx4fvwCMhb7ZLqdsbOwFg+JQhf/SsPRkSwEVGMSpA8dV?=
 =?us-ascii?Q?8eYKhDCvuh6wKJppagRbA8H9jC/bdxOWj+PyJAlSFXcbQC3FbeT2EG44weep?=
 =?us-ascii?Q?ulfnbtrnbAkm3L58ytDKAaQ9PccXWB28r8+4bILHrD3roPFS5CgZ3qqdm8wo?=
 =?us-ascii?Q?kCB7zzmrkd7X356hafMDROQi+rLyLFWt09eTxdkT/0HLToDFvHsTdXWQcYcb?=
 =?us-ascii?Q?1SKdfWjOh8N53FF9+vr5TwheMwu8uUOL/W3c6FULrH736y6667jlSccpovTl?=
 =?us-ascii?Q?QX6L+Q0AjCFUNf1w/Jtl2RXzYOdIBeujx0jT289lqvUGKRJa3irsoQEU0cpW?=
 =?us-ascii?Q?ghygV5dzHup0kreL6nwya4pqd5qJueezVPqZRBQ731ZMTBkbz+AKtNv4pAba?=
 =?us-ascii?Q?ck4Z1PIaiu1txBOtpzYDKTAGSz46qtBeJsiEdbLMv1wZq7qYAx3w3KDAEoPL?=
 =?us-ascii?Q?9aT4r8KZQf6OFTIKRHenE7XS6mUByHbPCzxgCSwDm52o79ns9+sVpZb5N1w1?=
 =?us-ascii?Q?zlRtGRUqknAk2pIYY1TR+APGSc52WyIy0jLyEhxmjwiAOi+MhTJKz11UvzR0?=
 =?us-ascii?Q?Hk1F5NKve0E4qwRJxstltrusgQv/u1FGPbHc3zodQOhIyBKQt7KwaFH5ntPo?=
 =?us-ascii?Q?sZ45pDcwUrhTvu0mht8GabRlY0/QzApnWrYo59OjNijyZ598BIYoqvjwQAgv?=
 =?us-ascii?Q?Gwj+8xvc5uAVDrGr/sa+7QnJEdStJ2Uc27lARnGp2dVriyfN1/YMzY6k76Hd?=
 =?us-ascii?Q?oR66UZKtf5mbqmVi254uaXLpPl3bjkEJfMMUNFLbbQw1jKy18ktM4PQ7w/Lu?=
 =?us-ascii?Q?mBey3o1qYZz0geqlVZ8KHU2Mk9RUrFkA6d4KTX3yooJkPMFAKq/tdlTdfhpt?=
 =?us-ascii?Q?CX9hHfoPOZPYlk+xZSVY0OzoXxs++xsO6xumgX/77zyBMCHvBOncqznZQv4w?=
 =?us-ascii?Q?1W+tHHIfrEwWEyMeLjm+6QxUc+WceG+CXi4tZvdSKLzT/dpwW2wU1N8TroKQ?=
 =?us-ascii?Q?WTecXlumKmCv5cmLyGYyCLHJKj9hApx+hapC16Gl+xsHZ/+KPkGfJ1q02bYK?=
 =?us-ascii?Q?skGym6oloE2d8U307mt7o7EkzqIyFvseMbta66yWYhQQucR2mw44Tdh6otpE?=
 =?us-ascii?Q?i1cQasvUEW/5jQDYqJNQP9jJRql1vG346EQMwFl?=
X-Microsoft-Antispam-Message-Info: mrWXzat1oTY2l4rLjTZmgTLEkYzDJeDJRpkQVruY6ms2/8XaMZuGi3hADr9W2jSQnsiDg1V8WxyRmoApE/xb6ZnntwRIMcQbMe+TL85FyIcjpbHUaQ/uRKk57eEg21BlXuJCjrqYNXf3AX+VNOwkpdG+gu3xPoX4PWb/eiY8/jCGcbsRDS3r5zMJYLPFuswjoI+W+q31HECkSeJG5YMtVQopCCUpveUi+MKjRAPO93+z4HCTZkqMcNDO3ktTpagiOBKS6y4KAR0hKb9ScRZO5PFGtmd72pqmuPTySAAq4Lo5VDJzPVXJmLIDvLnf/z6fenc8Dy+6FqMNSVQbTNjlOjB1SJ4hCOArNBJ3lXKQZT4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:aTnucwpaO50o60pXlZrPGbJj4tX1Y4p31t14O16QrgPzCy/mu5vvOFfecpgz99XiHmQ9f1Wb+u9xsYvWSwsJ2O3D/G72S3vuDFMhkJ3E6vIr5Pa6v1SQmKb9Ef6aVWfxhNxTxIdE7Rj5mOqM5fJurfWVxvxQDTcToUZLvjV2Ioh/DEhpMt4yrANXNHx+2fRw4CeEdWqAMlbs8QKOFCiiU+UIjST5QDng0gjTJvQy6NxAlMJBsbOOcg/313CUNvbU0xFNZCBWkbFaVQB5TRbclve/WgpHvdRs6TDXzyXLL4/I05J+qiL5NG692XMZAorXbQE9rmREbc+syQYvaCrirBiK05AhBhKs0AZTiMJO+OAOtzz2l5QC9G57wQs6CmTYis8dh8cFhCJAfQbTwIVMLQ5w/smGYkewNCFqeEq7rxAlK0oZgUKETPI3/KOpEcA1rqvxcnmQuUbdw3qdL5j5nQ==;5:8ZJaIyMdpNiG5tiEPXPUTCJFqbDrA3/t1AOg+/yxMl5GyVFZ1hYMMlvopmdaTQW82lZFE/sOdyvfBFGgLX7N8beEWtbwrcNXgEro5hNfMwc/QvVyDKwpB5o45zx8tBhpj4voXZ/UPrOX8/Cd8NSJ0Qe+rKxjiy99X7/1FD+sSxQ=;7:Z7uiegf/v/0M1f+IHTUGTPl0GNsnOVpI/zrc6Az4+hpm3g0w+ihyQz2y+TK+KxBAIYP4v2g7EApmwdMwHGA8X61J0YVNx7irWBsNF2+ZvKknV58nve3Cn0LHcByxw5C/vG+gruX5KmlxeEzY5K8iH19zqw+WGvOc3OPCD6SSSMWgObykZAcfOF9YI76Jq4lomGp4qhAq0w4pEOxFgAwmdJvTEGC9AYn4uMQr07UGnP7V7CS1etVWvA3U776PQSXR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:0iZZEWKYFVb6OOIrzc+4d5HsCmCappIP14O32GNPPwplJVv4akHs7TW/Qa6qyIfkYlgeEwqPI7SFS5eGAjJwKeGUleBwN662AsTyePZIKsPV/07FI2gFuGVbxzbFhqJdX1/x4hNLz104hQ+VsA7jtKWqhWHYAxPLTYCHsA1QQBEwqXeUTFr0jpQpWMB6QOBilR+D99Kv12hb1x8WOf4IFj3VtXCrRP28j4chFIv1jFLy1z9GJN2mBFlFJM7KvyPY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 06:55:52.2736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1540c9e7-5351-42ac-791a-08d6073324e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support dual channel, 48Khz. This constraint was set only for
da7219. It is being extended to DMIC and MAX98357a.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 066d5489..cf2f648 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -162,10 +162,21 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_max_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
+	/*
+	 * On this platform for PCM device we support stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
 	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
@@ -177,20 +188,42 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
+	/*
+	 * On this platform for PCM device we support stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
 	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
+	/*
+	 * On this platform for PCM device we support stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
 	machine->i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
 	return da7219_clk_enable(substream);
-- 
1.9.1

