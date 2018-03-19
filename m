Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493854-2-16728549174648771356
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493853; b=G+l4Abqqz7FqKmk+TH5glvbAGEwyes/Keo5yALucoQ/sgVm
    ZMHOwGZLQgv2QrrLYfMiUVVQYuE/eE/4KOv/Ex9eDw+342R+2wGoVmt7+ZFTHM/2
    JnS+i28yVxlEfmwKteCrDE8qcL5Wl3zi1No/oKIhZcO/iQukl6PRfSHNZLMFiS18
    cAAMzAgB15Wiuf7ycucdkNa0/vc9S5iL++YCMvlyeB/eLVctVcpe9JaK/AFdr5So
    vNw5ROBj3x1t7xLIbi8XOUjtoRlotSv+A3SE/rtIhyjK9eN1DHdxYXQQ3FuLE0Iy
    30GSfknf3bJeL+3WKXh/dRttGOLpsn5TILrJ/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493853; bh=ZHUID3
    TWPuoK4n1uo+QAmNbR76y76pef5hydDE/u2go=; b=BSngnMKLKcAjViYY9b6FbI
    lBb7nt1wvVQPjqMHsL8t4X7aubfgf6jp6F0Ne9riHKPJVrjXZ2tv8B0t+5uiCM8G
    h8UWS1DziQakekPhoWx921frtaKXYGGEjLdx+li9OgZDfP6daojfTt0GvNZ435ig
    E9MsLXp7/nE4yR9mmj6WXiziJhBouk67AYu43+YTv3Wzq185RpjQktkZib/9ErfV
    g0lTVf09wAT3txiFoCVhpvSUJIAvlEOnWzHLRQw2rD+i8zykrTH596St2PYWt+p7
    L8TzRdrKeMrzYE9goTUkZAjJVSPUOIlD+imGtSNVBmzeU7lYDehAsHd8somt71MA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LS667xWt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieektdenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LS667xWt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieektdenucevlhhushhtvghrufhiiigvpeehge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934997AbeCSVKu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:10:50 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:47488
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935001AbeCSQBz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 135/281] ASoC: Intel: cht_bsw_rt5645: Analog
 Mic support
Thread-Topic: [PATCH AUTOSEL for 4.9 135/281] ASoC: Intel: cht_bsw_rt5645:
 Analog Mic support
Thread-Index: AQHTv5tpLqmwYAgaAEmP6GA7J8+tiA==
Date: Mon, 19 Mar 2018 16:00:33 +0000
Message-ID: <20180319155742.13731-135-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:2+jNdaIFY1tzvfLrD9BPBMHuL5Vbt3ZYFHvb5epsl2MP2h1b1J3Mk2TuSBn8FIzMHMYzNWtFFc2kc3p/5PDd/PDKQTg77cjr4pCZhyRq+PMiW/XPWXpHZvlNEtjJb8pfhkrI9GEXitHC1BoOcg91I945gtjdqL4pGIvXXYeBlqKOxsYGiCxFT1CRzqD/SksRGsTKbJAk1J7byZ+ZxbD5e5garnr8F/V+0h8pexk64OqVPtGo95ItK83aCSkViZw6;20:SM5k54FAK5J9dlEJVVWlSXf/Ixw1VpAKj2YdbmGGE6JPSPUS68cxiUSlY6u6M6GEMtqg/U1sXIPOqpRuBZJPddyvCVkScttId0lXu9pHBNtkF7JCNPAot+YDuuAjFkj57ZWQ5W4Pve0QuBroaeA+D84+bcxEIqx5nZJ4zYtNLUY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48ac5c32-a6c5-4358-d43d-08d58db2b8e5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09192D7B127D512CC42228F6FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dJj//8HPqYpK1aVIT/1r4/jq1M2WYo4RGv4Ekr9yqAb15tLgU80aQ3LcKDzxCVEXlS5JCzkqVBh5kZpJq1qUjV4BWgPuJZHwjbyOxEUWwnxO+F85HrXLK8dzEuY97WIXrS4TtT34JbyQCFZDoj6cV4VpKWGvzpKt/ZQbvS+JlY1tdVWkJH9G9a6tQI+PVekRrE1ZCTn78WZnEG1ACEWwxVXaLhC7+9FTiSEudL/9YR5yBPdQfglsQqQEt6bv49gQr9iL2yq6Xu3m8E8gQ7ZDpGMMy1MWZxzlGKthzt5xIBRGLVfR1hhG3NAZ09r/zwGzv+08m8BDgYzv3Od+PohZFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac5c32-a6c5-4358-d43d-08d58db2b8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:33.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit b70b309950418437bbd2a30afd169c4f09dee3e5 ]

Various Cherry Trail boards with a rt5645 codec have an analog mic
connected to IN2P + IN2N. The mic on this boards also needs micbias to
be enabled, on some boards micbias1 is used and on others micbias2, so
we enable both.

This commit adds a new "Int Analog Mic" DAPM widget for this, so that we
do not end up enabling micbias on boards with a digital mic which uses
the already present "Int Mic" widget. Some existing UCM files already
refer to "Int Mic" for their "Internal Analog Microphones" SectionDevice,
but these don't work anyways since they enable the RECMIX BST1 Switch
instead of the BST2 switch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boar=
ds/cht_bsw_rt5645.c
index 90525614c20a..b1eb696f33b6 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -111,6 +111,7 @@ static const struct snd_soc_dapm_widget cht_dapm_widget=
s[] =3D {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Analog Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -121,6 +122,8 @@ static const struct snd_soc_dapm_route cht_rt5645_audio=
_map[] =3D {
 	{"IN1N", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Int Mic"},
 	{"DMIC R1", NULL, "Int Mic"},
+	{"IN2P", NULL, "Int Analog Mic"},
+	{"IN2N", NULL, "Int Analog Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Ext Spk", NULL, "SPOL"},
@@ -134,6 +137,9 @@ static const struct snd_soc_dapm_route cht_rt5645_audio=
_map[] =3D {
 	{"Headphone", NULL, "Platform Clock"},
 	{"Headset Mic", NULL, "Platform Clock"},
 	{"Int Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "Platform Clock"},
+	{"Int Analog Mic", NULL, "micbias1"},
+	{"Int Analog Mic", NULL, "micbias2"},
 	{"Ext Spk", NULL, "Platform Clock"},
 };
=20
@@ -162,6 +168,7 @@ static const struct snd_kcontrol_new cht_mc_controls[] =
=3D {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Analog Mic"),
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
=20
--=20
2.14.1
