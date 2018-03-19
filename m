Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474945-2-10220298671257115814
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
    t=1521474944; b=rWVtnu2czZ2cZ07U6FU5xa7DuGyn3gOURu8pfUKt9wtU0R6
    MO9QXQZa/EvqTySrEHnPxkCyrHHLw8eLVrDsIsPc0PzqQ7rDC4SIEKPa+LqU+43Y
    1e3VVgPoJfABVh0aCHWb7GDFJIv0yVj+gBXOoKVu74VhogQJY/zoDpyxu0FATun0
    13vsJqt/HRk9oYTSIcmr3d9iauvl4M26D8J1TW/j3rM3TiEDInF/GZQePImvzQ3I
    yqpyEi4kyBksGsKb4ym1sd1OWu/0lq229eBDpgjJ8uY/dC38SGA0bYOk5R2JTmRD
    2OckSbZXjH1J2E9KgYqMsCVxRSimtDa7m3JlZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474944; bh=yqCnsC
    e6+GvQzOE1g+/SXvl5Ah6zSt89pyjczujGunY=; b=Nm/v5AawvUkP5gRxQGXQT1
    leOJyWuqQtNQnf8nvFMfGrD2O0UvnSozZJMVXFlb7Z7xHlJPjxuB8xny9+A9By8T
    aBh9TiIEBcqFovsMGmAi6zWTkyBSy6HcJAOVuQB6DdtPqFMiqc+qk3gNbfzZCZkB
    2xNaN+lxvDJ/XZ6+mXsaMogq48joD3opMKxwIRUFCSNTsk1CAkuY+4fn6ovcNkKK
    /UDC57nhOnkwHDPgFY3wOgitAlxgJYgSmug/+d/N/wugQTZa97F8EMVoZeJNgZu5
    Upr5vAHjPwo2gzcv8hfV26z7gCQmsypcykeVf7AJ4do0KyZ7EcfKXzzKjZhz3JdA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=POcV9Gyo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeejudefnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=POcV9Gyo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeejudefnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeCSPzO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:14 -0400
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:16428
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934353AbeCSPzJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 29/97] ASoC: Intel: cht_bsw_rt5645: Analog
 Mic support
Thread-Topic: [PATCH AUTOSEL for 4.14 29/97] ASoC: Intel: cht_bsw_rt5645:
 Analog Mic support
Thread-Index: AQHTv5qkcMqv+m5va0eK0dg8Ws6RGA==
Date: Mon, 19 Mar 2018 15:55:02 +0000
Message-ID: <20180319155411.12348-29-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:CU1PzYwIvq1rayTCCmsXU68KLty42fYiIwe9uGZKxAiAF/hh3rrRG69UUcZSgwyG9GiNC5DF79AxiQlanHtwrSJOP5OoNrUEAJktrPP/FI8tTZZk6wz0aSRvNjEiKKi+mNPpFpuirnwvuHEaR/GlM7qJ6hBLe6AFXtUjbDK4dXP1ZjSabQhAV8vKjGFo6JHc+aDa0aDO71QqwwzxQFlu9J6xneCQzhGSgstGTw5BVySN3r/eF7ZrXFpJbOhdy7xn;20:x8D1eW+74/oRRMbhKrJHPQpHxOOsaVhlTG7OQFaGFAT3DA7G+keJY9McUfhklo6Bxh2UYltP8MBqf5l6VVMxd60B/Caqt5IBAXsZQ42peRWrSmIa2S3vjjmelCB3QY7cl68zSf6PD17brWo7hQPnOMoA8Ytu5d7bimqll2+N7Z8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16ed213f-74bb-4d56-ccc2-08d58db1c6d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0982489C0C8FAE92B98C3A52FBD40@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FfRs0aqX6AWxlkSdJOkHpbLfZYhL83q6+v+JFjepL8RQhrfctu5mvnmjqm6GY1DAXJVi+3oQ0Sx61RszMgZnwMAlbIyn4m8xj+31hNi10J+sFtb0OWihJP6te1v6Sg43Bwq+YWbQCqbmnha6sov8TyCpRUYFP7vQ9KRjxfEJtX3Ntnu4hpSlHc/Vf6ItZQEZ0rRaTKqKp4vLaT5GqOfAIBKpGzeBEiosWMcJm91zIl5GRCVhF90Hlg5X7IgvjqvDvVOHs5ZC7lQlSdXovhY5bPCZWV3tfR72BYoQm4B3MRdc1cVFTJm9iaZFnQC7oW2R8vcphKB4P49GlKciGrEu1w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ed213f-74bb-4d56-ccc2-08d58db1c6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:02.5408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
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
index 5bcde01d15e6..fbfb76ee2346 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -133,6 +133,7 @@ static const struct snd_soc_dapm_widget cht_dapm_widget=
s[] =3D {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Analog Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -143,6 +144,8 @@ static const struct snd_soc_dapm_route cht_rt5645_audio=
_map[] =3D {
 	{"IN1N", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Int Mic"},
 	{"DMIC R1", NULL, "Int Mic"},
+	{"IN2P", NULL, "Int Analog Mic"},
+	{"IN2N", NULL, "Int Analog Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Ext Spk", NULL, "SPOL"},
@@ -150,6 +153,9 @@ static const struct snd_soc_dapm_route cht_rt5645_audio=
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
@@ -204,6 +210,7 @@ static const struct snd_kcontrol_new cht_mc_controls[] =
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
