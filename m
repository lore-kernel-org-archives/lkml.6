Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521499017-5-17884465163199584058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499017; b=vrbsRyhvVQdBKiJTU6XKR8Lk5Pkjispjx/GAuuTuH5MuC+X
    /SEXPE+o2FCjeQN2MjsMRz4nKmr7q1kXb4jfSXDQxKD1j5jYpsMfAX0M36qz62/9
    WnvMdGdPZWH30LlWwlDpvpcH2hPjHZVaQqSCqJmGnd/ZSbGK9Gux7YZbPzXuaNB9
    TLOMATpsluuyQsI5+ZSET0Qd18NWuylVhNOPmXYFly76kgm03s/RYMIqn98PqnsE
    RWC0IiTDe9dA+rucYnxEkzYoMC4gQCGu+UW2pv7hrW9myDAFnLIK3gP0BY9qgl4W
    zdLEMuXfdt9k76bjmm3/knkqhTOVo75PronCO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499017; bh=6ezqMm
    3CEFjDaEBQMCFGO8ASNGlEeiM2Pnhe6X6ok08=; b=R0npg8v65OH+156AqSgjW/
    TZrwMzqCclUY3G2ZKWXNHQWpoPFugfrSYIGo2955mHREzo5NYiQlF3HOh5yAWueE
    v7KsXeVtkoPutDEo6v4A70DnOhsMRc+ikKJDioNHbhBF9gxzzA8wlpzSoltX/BK7
    H/CL3Oehr2Jcyt1umIzsDXYKIoWzRntHZbdFla5LzrxAoZgtsDk4WtxeeKrtLLys
    xDqRvzOgTFCQS20fUmKJzKqFs5UCvI27GdTXV9jV/W1sT+8Yj1H9yCwSvmsTELbF
    tLRBdLW0QNdcbcuprueVHbDbKqxSfRBlMtRR3HD7dixGiEgSdOVD9IWDNm3yTR7w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eJJE/qsB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdelkeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eJJE/qsB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdelkeenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936552AbeCSWcA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:00 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:41792
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933745AbeCSPsV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 036/124] ASoC: Intel: Skylake: Disable clock
 gating during firmware and library download
Thread-Topic: [PATCH AUTOSEL for 4.15 036/124] ASoC: Intel: Skylake: Disable
 clock gating during firmware and library download
Thread-Index: AQHTv5mau8zdsZy+vUGYb9Twz898fg==
Date: Mon, 19 Mar 2018 15:47:36 +0000
Message-ID: <20180319154645.11350-36-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:tmRDbzO3Z9WSWsBOk9OSKnC46p9GijBsfmm6uifEexY6IfphM8C6vDVSQdAGt+2ooiBtttstIHURNapwNP6qauyz2gVD8z8UdYh6L3SO014vB2L3Xn4EpMVKT+Rt5gJYmsVeNQ9iP9WRkO4atsPF99GgriqMzG9M4qxjdXa+JwGExJLDtsWenE1bg5HPPr7cr5whPnXn3D+K1vmRxXdpiGuYM7Ah06PFVngGxf6Xz0yhfoj91iB09nG+dlG4eSlq;20:e2SVBS1d2cbSw5hzOdyMkr1JgFQYgVk6vY7nJRWxKVRB2o0YgFDBeOV5TwBpX3f5oMy/UcX6IklTUUjVh/VLZ+hjr/9yWUHuFB9uMdaoxkumxqwOvv78RVPSpGpdbX/jyUXs22vcCpCh6+L9o3tpLU33VkPO2XV4uILd9o4H/f8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04a001f8-60fb-4f32-a1c9-08d58db0cda0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030D1FBEA20819A1E58EF37FBD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(6486002)(5250100002)(478600001)(86612001)(102836004)(1076002)(97736004)(575784001)(99286004)(72206003)(6436002)(2906002)(107886003)(66066001)(10090500001)(81166006)(6116002)(81156014)(305945005)(8676002)(86362001)(7736002)(68736007)(54906003)(110136005)(26005)(3846002)(105586002)(3280700002)(316002)(53936002)(8936002)(186003)(76176011)(2900100001)(59450400001)(6506007)(36756003)(10290500003)(2950100002)(22452003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UIqHrJyzuqh+YAZ7gwASL9s8g6WfSYdasbBRnnvl+q4YGbQwhinutlziBoq+xacZvyyErK1357AOO3BEo3QUhKGs2UGxx2ukncvuSFryXKr5bgsz6QJpfhWlMUEuFSjr4YMceXsMq67ykEopVoBQza/V/YhExD9zGNrPDGDWpuh3aWdple0h+uVBZjELQDDwrIVzoHzG0t6yB9p1MyXykOmbU0ApSqW30D2Hh4OefDwLVaM5E8fxlfX/Av5FEjSpeXtT2eZv6T3WPQf81zB1ooiHz36UmWpPRmcIC4QzS4dRE+dKEfprdQ556SHEgmxG/w0/Y5bV4fm+NRbLsi+neg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a001f8-60fb-4f32-a1c9-08d58db0cda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:36.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>

[ Upstream commit d5cc0a1fcbb5ddbef9fdd4c4a978da3254ddbf37 ]

During firmware and library download, sometimes it is observed that
firmware and library download is timed-out resulting into probe failure.

This patch disables dynamic clock gating while firmware and library
download.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/intel/skylake/skl-messages.c | 4 ++++
 sound/soc/intel/skylake/skl-pcm.c      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skyla=
ke/skl-messages.c
index 61b5bfa79d13..97572fb38387 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -404,7 +404,11 @@ int skl_resume_dsp(struct skl *skl)
 	if (skl->skl_sst->is_first_boot =3D=3D true)
 		return 0;
=20
+	/* disable dynamic clock gating during fw and lib download */
+	ctx->enable_miscbdcge(ctx->dev, false);
+
 	ret =3D skl_dsp_wake(ctx->dsp);
+	ctx->enable_miscbdcge(ctx->dev, true);
 	if (ret < 0)
 		return ret;
=20
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/sk=
l-pcm.c
index 1dd97479e0c0..32b30f99d2c8 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1343,7 +1343,11 @@ static int skl_platform_soc_probe(struct snd_soc_pla=
tform *platform)
 			return -EIO;
 		}
=20
+		/* disable dynamic clock gating during fw and lib download */
+		skl->skl_sst->enable_miscbdcge(platform->dev, false);
+
 		ret =3D ops->init_fw(platform->dev, skl->skl_sst);
+		skl->skl_sst->enable_miscbdcge(platform->dev, true);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to boot first fw: %d\n", ret);
 			return ret;
--=20
2.14.1
