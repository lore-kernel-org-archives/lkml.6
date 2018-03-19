Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497239-2-16072763146099121160
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
    t=1521497238; b=rayMwCovMth8Vmi3zlCmmWDJ+/58FXkPq0ez6B3BRhRr9we
    BLicpj7O1NSH9Yj4hrDVEHUum/fbR2yvI1WwpXzBXiKCv61M7OxzblUkAt246HYA
    //MNta0G37MVhqbupi4we/0BDbcy8HQnweec6Or2rYpsjcV159G5R3pq3O/8Om+m
    RYP0hLNnAqHURrijMrlLTQRsWgopIvNO8CbXj2r1dLco8eG2n2TeXMyS8dMhgcNo
    y6aKfV0oXbY0cooWaKno/xoF691Ki6RAmVT/ZNb6H13XHk2r60Brri+Itci2WrMR
    E5bTyrFK77J6aMLFUPgaaQASwkz/TvJOzgPmaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497238; bh=tOf+tq
    8DTtIZA9ySoAcbLMdKiPoVAutcBR6iJTeH8OY=; b=TeHh1R4S0NJgDpP27fWjne
    cFIBeVJiatubKmNnFJMx9n/zQtdjZYVQTvtg+9+bNAB34JyFZ7CHOy2irmem5Vy9
    m8b5uoi9jK2tVUKG66ISFAwbaP1Ml3QlED2qm/MxER9PVKrp81bI3toKHY9SWYu2
    yhqJAVQrUwdgn0yVRXtvIvRGnYfWOZYHYA760ZwVo9LqwTF9oO7i80BvpqNSFwNH
    vlLFHxQ2F2GGOry84qBPg4jOCUcXZjrNEuJm7ZKQHn7dctPqzhnSTGyovN9qNKFB
    rVq0++082XIqSGdW16FrfQVGrarFbxjP1YChD+RS8U6/wf1O8nAmFOXblvne9jGA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TYFTbo2a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeekgeenucevlhhushhtvghrufhiiigvpeegje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TYFTbo2a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeekgeenucevlhhushhtvghrufhiiigvpeegje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934498AbeCSWG3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:06:29 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:57024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964801AbeCSPzE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 28/97] ASoC: Intel: Skylake: Disable clock
 gating during firmware and library download
Thread-Topic: [PATCH AUTOSEL for 4.14 28/97] ASoC: Intel: Skylake: Disable
 clock gating during firmware and library download
Thread-Index: AQHTv5qjn6qEqkxRXEybyo9i7kVZSA==
Date: Mon, 19 Mar 2018 15:55:01 +0000
Message-ID: <20180319155411.12348-28-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:9o/9GzaNaZZtIYjbeg8qPhetGDx8iGrTuwpSZTuDOgmfzdK3Wg0uVKLE8ttf9Sy4aRAo3/GbNmUTN+NjlrUo/JmKM/HaC0moLPW3Fv+L10E4+YRDiYyjcCtQ8RfLCk4r1xyjijJKPwCep8pU9CJAAmW9CS5Zt4rqv3+2XGuppaYfCSK/4TYv9pBmDzBabk8UuWvmJUM7wPpbNpnSVEbXZkDlkzYDFPJtMDpMT1OTiCjzUfdsRhcj4TY9E/4+e+L7;20:S5NdmDebF2rj4QyZZjMBJHYj2GG6uDxbb+1C3bQn+52mNbB3fyKkxmIfGViKcleZ4Ddqjq8x1FgfyBeZwtoqujrCgml7KPeI97lzFn9OW2MqR+9Wyfeg3xs2Xsjm8FKkz2UyTx2yCNO1C/tY/c0Pq5QCOQeyJpmnBKwtUBXzkno=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fb1eed0-8433-45cb-00a1-08d58db1c62a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807172AA8005667C63819F9FBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(305945005)(68736007)(186003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(59450400001)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(575784001)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NuliAAPdPrLjmYkNVZIj1JurKXRrKUbxzeervQo9s6A873NyCxpCMaryI7w4F1tOwX5nW+RXs6XjP6Xk4oQthcMBcxf3f3ViXt9pN34d+zPnEf9fOfXwXTg1o5pGlxDIJCXmCBcHHP1le3wln4RiYKCnQaPn7rPtE8quTBe8fcQUusWSN3XWGfRQCuusK+aq28mKoCbxwz22mXHiGCMzpH+bJMMQrRgPiUHek2dvBDczgEq+bfQK0hJASLsjZh+v+bF8fTjMkeNj4FOHHs25pPxVKi5L/Ri55oZs3L+MVjpg1hpZbXKw+oStOiluI3Gr+RUzn15rP4L6636HfRS4pQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb1eed0-8433-45cb-00a1-08d58db1c62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:01.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index 89f70133c8e4..b74a6040cd96 100644
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
index 2b1e513b1680..7fe1e8f273a0 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1332,7 +1332,11 @@ static int skl_platform_soc_probe(struct snd_soc_pla=
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
