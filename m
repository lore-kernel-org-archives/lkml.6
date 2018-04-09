Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246115-2-16213344937670995371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246115; b=wCVJ+VzsyBWd5rBVZHcLoaP6J/7O115AshmaAJoGnKozZBKjCN
    SFoFPveTQ1mCLe3wEuk+QmavJYthjYV4enQCdobUWSa8bks5jSCYw5nl1WZRvwU0
    wxclS/qXRLMNVT9sCVoaoyG/VCXXg/zLUrhyd2+uQVvq+533YOu/CdDZxlETuwQX
    MFvWBTB+o7V0Tna82kZ7j0CYLUkogeNkPmxhs0f8FpZIAOJUviKnA6CXFL0PrYjd
    FyC3T9FaSHKKAmDwBnb5KqyPjWchfBW3TsdbwsefTmCyC0sZGb89li/ZjB9uCPvH
    2fNdvvc9GRVaIJ8bkc4q4KzYNmPWcKvQ2VFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246115; bh=1Hz+/eQxa4
    hTH10utFuJPC3cC1NEgur5uLkx351QxIw=; b=TFqxO+B/44o1nJZj4irGGsWcc0
    4rTDcJ+gNpULVZTY3tFwancNP0bbpqEk+/ryzOTmvjCnRdSiEHHNMPHpqTJlnxR0
    Zf028DmfiZbGXA7kQrMzSLeZuSmky1zHf8CX4YZ4j59Ixp+WZ4h9NxY1E7Jbarmv
    HAsQjKLCO5c/SOlMK7dLgUklvCmKt2lOI+VmfT4KKLouI32KZGcHUWQPiV88HbR5
    3B1IvYEFQcpz5S+cvy7m+RmoSHxERulTyY1ftTEYQxBdecCMMV9M+XOszQ82nCpP
    +/dTaa4I290n3SHhG0RJKVeL/6mufKJwuMxAWO0Im5mPcmaTDnYvDWHJ8aXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fQJQxBp8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fQJQxBp8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCaxRjBSN7L3RTe9XsjS/FxvwLFGn3MjzNkV2rVFb+8i5mVR2IWNkMxrltJ1k3LFdt9ORbmS+Yw3ktGXicDd4Vn4/shkG3UXCQcK9kyuNXfVbHQXh5YE
    YGWuvnXhjzBcQJ91m7ZfOdv9STooMjzFXVp4wLtcHuNAVzPiqldacIXsKoEAbZylMLzmWTsMUwOp9ZNXTsxV4epVM1DSYJbORgZmTv0LW5GbT17kbCfrGeoQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=s8YR1HE3AAAA:8 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=dOWJWV5Flkr-bMFZBqYA:9 a=wPNLvfGTeEIA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeDIASw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:52 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753774AbeDIASs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 085/189] ASoC: rockchip: Use dummy_dai for
 rt5514 dsp dailink
Thread-Topic: [PATCH AUTOSEL for 4.15 085/189] ASoC: rockchip: Use dummy_dai
 for rt5514 dsp dailink
Thread-Index: AQHTz5gzN6thB0TnBUC690gc0R8eYw==
Date: Mon, 9 Apr 2018 00:17:52 +0000
Message-ID: <20180409001637.162453-85-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:v2h0REmG5udJV339fBzuLzy7eVlV0EJ3YskjgJyA+VpOMBPRtkm7s8dMWMIbX/ttohIA3NGqNNHi7vyM1PdCwpu+OzuZHzEDiCkPgTWQsnsSZz6YbCTbpuemp10NkwzT1JQA+QIViFRbEnEJpzUkUx3HLTrGYs5gK/0WfYPZZQw3aA6Zfk7VYaQweNLVFVsxh4/dyENGMRZyzl9S6bxXDkS7/uzi2fdTp5/grDK/SPZA/+J41s0oGIUStWuGI3Nb;20:cLnOL5VDxSbEx4jOU7rK9HFPdnCqwNJn6v34dt2ztffDpkKAsSP+1w7oytEg3MLODmQNE5HF2zQF/ooR9kzW09d22KhRd/pU3JAEBo90ganEwTpTbjHT8XPws6zB/MVQO3c7VOf004wQqKBd45cf9wdq8XJwKYj37DZtzdGwnvs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09d00f7e-baac-4204-10f9-08d59daf729f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128A24769D7196271E99FABFBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fKE2HWWMzcZwybYpEALBFDCv6PdEO8HDrFLlMy1ArMBRJ3rLyrDXWtXnVG+C2YSnqwo/XNHuNa3M76k6YHb1PSrkajkCouuyy+RKrHW0O+kqyV5S30cqCbXcoH801EjMbR1PxK9Dd+gfMwSd77ZNwr/5iymq87tYRJGZlP6K4mTPonFOQYsE5WKV9vX5SeFdf05lToMILeNm9Cdr8dLtX5eJzTA58gTJdDH6oa/edDny5VQx9PwBc4eWSMAFgUGdqR8BSPPwfaZXIvovRxnC1SSZ9kd2M/tWWDCKIaROAzq7Pj0d+7xJ1o8uoSwy8ix13r7TxPmvqwmp3SA8ysCPmcp8qUyecBtQpLJ8e1rd3LSK3eT8N60/K8jMAAANpojhnQJh0il0wOHtMJtm6XEB4WPUk5c+273Pjdztuwhm+IE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d00f7e-baac-4204-10f9-08d59daf729f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:52.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeffy Chen <jeffy.chen@rock-chips.com>

[ Upstream commit fde7f9dbc71365230eeb8c8ea97ce9b552c8e5bd ]

The rt5514 dsp captures pcm data through spi directly, so we should not
use rockchip-i2s as it's cpu dai like other codecs.

Use dummy_dai for rt5514 dsp dailink to make voice wakeup work again.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Fixes: (72cfb0f20c75 ASoC: rockchip: Use codec of_node and dai_name for rt5=
514 dsp)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3=
399_gru_sound.c
index d64fbbd50544..aa8ffd035377 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -367,7 +367,8 @@ static const struct snd_soc_dai_link rockchip_dais[] =
=3D {
 	[DAILINK_RT5514_DSP] =3D {
 		.name =3D "RT5514 DSP",
 		.stream_name =3D "Wake on Voice",
-		.codec_dai_name =3D "rt5514-dsp-cpu-dai",
+		.codec_name =3D "snd-soc-dummy",
+		.codec_dai_name =3D "snd-soc-dummy-dai",
 	},
 };
=20
@@ -528,7 +529,18 @@ static int rockchip_sound_of_parse_dais(struct device =
*dev,
 		if (index < 0)
 			continue;
=20
-		np_cpu =3D (index =3D=3D DAILINK_CDNDP) ? np_cpu1 : np_cpu0;
+		switch (index) {
+		case DAILINK_CDNDP:
+			np_cpu =3D np_cpu1;
+			break;
+		case DAILINK_RT5514_DSP:
+			np_cpu =3D np_codec;
+			break;
+		default:
+			np_cpu =3D np_cpu0;
+			break;
+		}
+
 		if (!np_cpu) {
 			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
 				rockchip_dais[index].name);
@@ -538,7 +550,8 @@ static int rockchip_sound_of_parse_dais(struct device *=
dev,
 		dai =3D &card->dai_link[card->num_links++];
 		*dai =3D rockchip_dais[index];
=20
-		dai->codec_of_node =3D np_codec;
+		if (!dai->codec_name)
+			dai->codec_of_node =3D np_codec;
 		dai->platform_of_node =3D np_cpu;
 		dai->cpu_of_node =3D np_cpu;
=20
--=20
2.15.1
