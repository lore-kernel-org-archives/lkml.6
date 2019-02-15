Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3076C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C3B2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qm5bWbsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbfBOHGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:06:20 -0500
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:58176
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731690AbfBOHGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykoB92EpoeAAhBmHWeO3CXuJvMPMfXhcQi9ie4g2ruo=;
 b=Qm5bWbsKrbs3dl10Xjrol8CMc7FJSP535TjCaYRCjFxZ0xC0co0clMA/9523QhfzfbgeXtA92NtpLk9gNVxBb7XKj9cqK0gNbuYZhA7GVFmG9DHXc180M97biHIjy+LGoPpmWvofOjUGphj94e1V7Wj0AzUbadH6g1zj1/SiaI4=
Received: from MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) by
 MN2PR12MB3472.namprd12.prod.outlook.com (20.178.244.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 07:06:16 +0000
Received: from MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::5ae:a47d:20e0:1e67]) by MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::5ae:a47d:20e0:1e67%2]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 07:06:16 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: AMD: Configure master codec on all playback/capture
 cases
Thread-Topic: [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Thread-Index: AQHUxPzxizQmdrGlv0Oz0EPwJ2D5pw==
Date:   Fri, 15 Feb 2019 07:06:15 +0000
Message-ID: <20190215070539.22150-1-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::28) To MN2PR12MB3088.namprd12.prod.outlook.com
 (2603:10b6:208:c4::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae1ded90-5df7-40f9-e86f-08d693141377
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3472;
x-ms-traffictypediagnostic: MN2PR12MB3472:
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3472;20:cC8ISdbZRUfQI2dL0YFtxuTtpM9p82O/65yeC0w01jLvNjspi1OpU8Vl/MFikoF6hTRbegxXAZNIz6nLrUV49Ah3XTJzLbL/oy0Af0BKi+IS2Yob61j+ZqKiXtrwj5YuehQYtX380JbN5TAn194pfFnRwdXnBQ6Gq8DMHeCPyNkFOKQfu92IRr4AwXB9Vn0NdSzf7rFHDabaEkAX9sdUDEkKmXRfS1aNnLNo7ib7Gv4b2tiWxk0J1ZON+8pIyqmE
x-microsoft-antispam-prvs: <MN2PR12MB3472FC0A1D10A2E1D91ECE5CF8600@MN2PR12MB3472.namprd12.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(36756003)(6512007)(68736007)(105586002)(6486002)(86362001)(6436002)(106356001)(3846002)(99286004)(6116002)(478600001)(71200400001)(72206003)(71190400001)(316002)(52116002)(97736004)(386003)(102836004)(66066001)(50226002)(186003)(26005)(81156014)(2616005)(476003)(6506007)(59246006)(486006)(7736002)(54906003)(14454004)(8936002)(2906002)(305945005)(8676002)(1671002)(7416002)(256004)(109986005)(25786009)(4326008)(1076003)(81166006)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3472;H:MN2PR12MB3088.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3VmNVlcmK075QJdWujmweR/eUsFiIl+NBpOIvXv7p4Mu9O9Ls0he2o2M9hbPgaqhCDCXzfLaGuNTZFQqoVwDzEbfvejt1lrhs96PlnJnjhBNqCDN01j9eAVwt/IQfHcDthSJfwRTP1YRxhSReirzEGQOTSm1MsmrVrk2Wp0/NXnIktlgO/blXQoz1DJJ3ep3++Mni9fQSSlSunWCOINurmE3A+HJY8VwPs++06LTlpgIoT1/VANBHZK1pZEpPcW2o2Xx31q1cBqegOF16KzM4Lhy7hnWCcIw5ox9kEOrDbhVU4zrkxs0efSjNrC2ZuPGJ+uGaVL+TZJH1+T8w6tqNFVSQALNfwIdR0Vhj6eXlTQuXJkcQg6ac7XCE+/gWVExDuO7COOov8v/MNyLrXUBylk2ll8Q2x1qukQwaQsdwe8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1ded90-5df7-40f9-e86f-08d693141377
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 07:06:11.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3472
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the system design da7219 is the master codec and clocks are
generated by it.
Bclk is to be generated at the required rate for other codecs used when
da7219 is acting only as clock master. For this call hw_params of da7219
during playback/capture on non da7219 codecs.

Being able to set bclk at lower rate also fixes noise issue observed on
some dmics.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da721=
9-max98357a.c
index a5daad973ce5..ad327415290a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -45,6 +45,7 @@
 #define CZ_PLAT_CLK 48000000
 #define DUAL_CHANNEL		2
=20
+static struct snd_soc_dai *codec_dai;
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
 extern int bt_uart_enable;
@@ -53,8 +54,10 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rt=
d)
 {
 	int ret;
 	struct snd_soc_card *card =3D rtd->card;
-	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
-	struct snd_soc_component *component =3D codec_dai->component;
+	struct snd_soc_component *component;
+
+	codec_dai =3D rtd->codec_dai;
+	component =3D codec_dai->component;
=20
 	dev_info(rtd->dev, "codec dai name =3D %s\n", codec_dai->name);
=20
@@ -255,6 +258,16 @@ static void cz_dmic_shutdown(struct snd_pcm_substream =
*substream)
 	da7219_clk_disable();
 }
=20
+static static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	/* da7219 Codec is clock master so setup as per the needs */
+	if (codec_dai->driver->ops->hw_params)
+		return codec_dai->driver->ops->hw_params(substream, params,
+							 codec_dai);
+	return 0;
+}
+
 static const struct snd_soc_ops cz_da7219_play_ops =3D {
 	.startup =3D cz_da7219_play_startup,
 	.shutdown =3D cz_da7219_shutdown,
@@ -268,16 +281,19 @@ static const struct snd_soc_ops cz_da7219_cap_ops =3D=
 {
 static const struct snd_soc_ops cz_max_play_ops =3D {
 	.startup =3D cz_max_startup,
 	.shutdown =3D cz_max_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_dmic0_cap_ops =3D {
 	.startup =3D cz_dmic0_startup,
 	.shutdown =3D cz_dmic_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_dmic1_cap_ops =3D {
 	.startup =3D cz_dmic1_startup,
 	.shutdown =3D cz_dmic_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static struct snd_soc_dai_link cz_dai_7219_98357[] =3D {
--=20
2.17.1

