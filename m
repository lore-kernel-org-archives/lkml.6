Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C41ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837B3208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ccemJZn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837B3208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeIOGrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:48 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbeIOGrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrr+ZIP+nDA0+yEKENwXqVDp8FgLjQU3MiVdW67bO8A=;
 b=ccemJZn4+IDNYUfZtg0DqZ555quEgcAsit6NeDdmrKMtXcHcl8q8bcoyrdF8JEr7tU+VLLAnqnlXlR5UwaydnsEFYHnPkBJ6plg1A0GzwihAOTG5yQR+XqIzEaMQ9LsFWpJn08ReJokzouyU+0twTQAZkSzCgNW7PyLDI0sk26c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 33/92] ASoC: hdmi-codec: fix routing
Thread-Topic: [PATCH AUTOSEL 4.18 33/92] ASoC: hdmi-codec: fix routing
Thread-Index: AQHUTJOmihUV/zk0Z0SlHE+ZCr1eVA==
Date:   Sat, 15 Sep 2018 01:30:13 +0000
Message-ID: <20180915012944.179481-33-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:7i857mSKJ5fJ6uUTuuqZu0mHRmJWMLvvMS+LQbL07w1+Mwvp+BFYuWsZM/pqXdhM32BoEkwyS/DuyyNVYqkNpJ9UVfmeg9KXKWfrrqpG63s6/JXMZobhHjqFkFKqtFqGY1tW9KjOw6mt4KVa72jusN0qLYGFLMZM/ob5OgyrBgKDabj1yy85FKzso9rA16IrEsamhCDh/jFwsbgPCA4MguNiHXG5ebAf8G1t9o/exEFKPa4RxuQoxlicmLcaKI4HXcClrW7TW0AqTd4CEo8PfCuEoQ6OnF+pNCXvoBfgD8U1pBUYaWMjkYNDY+sLUz4SIL1pcMvNa+Hb3U0LwftEaZFa3AV/eSrleSaln4668QlIABBxhqFnGFC7POkY7oq6JF44p7VbzLsAGOdu8cOrixnLpFwKsJzLplsHYIetBKALmdmFI03Np+ffFyZ5FXo+bA1Rb1bqHFE6na1JADplqQ==;5:5GfihAWVtdnt9tAEUo/K1vjfd6dIyifm40o0lnANMbbIQZyfGDsHM4ILen95vsRRhu2ofkXfbPgYYZFnrrrW6SwGTe6oQztZ6dXF4wlDLeYYhGQ1g20//Jf+hyK+bGVah0LDKIxwdIGq39K/6aIr47CDqxc9b7TwszsZkBrw280=;7:iJN4dMEio1oHoU+7GRaakvEZsJZ+cBxyAYIYc/4Y1/R6z+beGF/rKIzcOiXLTLoxep3Ufx1pyRnYRb4t6fn18WS4SX1OMwNU7l9eh2T6PRbDwrpIEfCyE/A68heIUYmOmvO4WbzvdWKIk3SkrSP88RBopCGdy+Jp9fgX/2SRdINdAVu0STYSYEqlC3/8JeTw3TEtW3awlEwNuwqy/Hp7g395s3PT2Qk7EULJHA/ChhT76WrHEtBKgzIso3O8L7z4
x-ms-office365-filtering-correlation-id: 8f63fdd9-661e-419f-0d73-08d61aaada51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB0741D0B3CEA73FB3774728EDFB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: c/gKJhGY74v65EYIuMt8JIsfgSCK4NCHTLioJBJpV83VMZe+2YqRn8rsAEmhXYqtzaU981ReI3cmDvzecsZ/uFuS8Rel+Tn0wZVs0RR3KuuXNcpiaj/IpADQ5Y1kcgG8ZL3yYVK3V+FrBk1W5Cy6ezGM5yeM75lk/8aN9pEFXd4V3sD8qnv4JBuBW+FBWghj/opCMXMpRX0JcRgmhhx1nsxZl9klrm7QMHdV+fQ8tOKeEU5z2H3X0NF86DgcZwKd+vNHDp8WBrA+9SdXH/Uf86GXL1k8bn084ru//5JNRt6h40m7CJEquLNLUL7RMKbHhdSjUZsOEDZL8EgLflulg7X2w1J59bg0WyhxP9lQ+tk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f63fdd9-661e-419f-0d73-08d61aaada51
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:13.2294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit d30e23d69981a4b665f5ce8711335df986576389 ]

Commit 943fa0228252 ("ASoC: hdmi-codec: Use different name for playback
streams") broke hdmi-codec's routing between it's output "TX" widget
and the S/PDIF or I2S streams by renaming the streams.

Whether an error occurs or not is dependent on whether there is another
widget called "Playback" registered by some other component - if there
is, that widget will be (incorrectly) bound to the HDMI codec's "TX"
output widget.  If we end up connecting "TX" incorrectly, it can result
in components not being started, causing no audio output.

Since the I2S and S/PDIF streams now have different names, we can't
use a static route at component level to describe the relationship, so
arrange to dynamically create the route when the DAI driver is probed.

Fixes: 943fa0228252 ("ASoC: hdmi-codec: Use different name for playback str=
eams")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/hdmi-codec.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 38e4a8515709..d00734d31e04 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -291,10 +291,6 @@ static const struct snd_soc_dapm_widget hdmi_widgets[]=
 =3D {
 	SND_SOC_DAPM_OUTPUT("TX"),
 };
=20
-static const struct snd_soc_dapm_route hdmi_routes[] =3D {
-	{ "TX", NULL, "Playback" },
-};
-
 enum {
 	DAI_ID_I2S =3D 0,
 	DAI_ID_SPDIF,
@@ -689,9 +685,23 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runti=
me *rtd,
 	return snd_ctl_add(rtd->card->snd_card, kctl);
 }
=20
+static int hdmi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_dapm_route route =3D {
+		.sink =3D "TX",
+		.source =3D dai->driver->playback.stream_name,
+	};
+
+	dapm =3D snd_soc_component_get_dapm(dai->component);
+
+	return snd_soc_dapm_add_routes(dapm, &route, 1);
+}
+
 static const struct snd_soc_dai_driver hdmi_i2s_dai =3D {
 	.name =3D "i2s-hifi",
 	.id =3D DAI_ID_I2S,
+	.probe =3D hdmi_dai_probe,
 	.playback =3D {
 		.stream_name =3D "I2S Playback",
 		.channels_min =3D 2,
@@ -707,6 +717,7 @@ static const struct snd_soc_dai_driver hdmi_i2s_dai =3D=
 {
 static const struct snd_soc_dai_driver hdmi_spdif_dai =3D {
 	.name =3D "spdif-hifi",
 	.id =3D DAI_ID_SPDIF,
+	.probe =3D hdmi_dai_probe,
 	.playback =3D {
 		.stream_name =3D "SPDIF Playback",
 		.channels_min =3D 2,
@@ -733,8 +744,6 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_componen=
t *component,
 static const struct snd_soc_component_driver hdmi_driver =3D {
 	.dapm_widgets		=3D hdmi_widgets,
 	.num_dapm_widgets	=3D ARRAY_SIZE(hdmi_widgets),
-	.dapm_routes		=3D hdmi_routes,
-	.num_dapm_routes	=3D ARRAY_SIZE(hdmi_routes),
 	.of_xlate_dai_id	=3D hdmi_of_xlate_dai_id,
 	.idle_bias_on		=3D 1,
 	.use_pmdown_time	=3D 1,
--=20
2.17.1
