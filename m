Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493918-2-12750396403063180699
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
    t=1521493918; b=cmlgGN5ovPSTspsJJ0SJSJxclRDMCvblvPuHyNiuKqgjG8V
    fh1QQJ5H1THfu3vtnWvsLhA1zC24XKa4NcowLok2jHy4HRR+BIMAYSSgAZ6Ededh
    AmRzOTXVNfm6PJMY61917Dl+exlniskKSeEG2gwEf37nHjuzaQMdqWctwOZUBvoe
    ZvMyfe5wD1iqJo5HuGEnvhn7VO2NDd35aFECfGSVY4s2smnNCf1R+ix7HXX1P9/T
    9fKTmJRevZYHrF6RhG2ECYIo1rW1CkTLPTruoDU8IZBxWbOBCRRyF0xuDKl40u1k
    dUEQc7x1hYcFsjSnzy2lBi+GyI89K9kDzs/bp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493918; bh=8T9wOY
    qDmVYJWBij+bqPEAeQgLUNQBgO/QBTsrKq6xY=; b=eCiRilOyBQEnP7sA0bKojq
    5Wi6jBQqMiO0UXvFKQvUA7ITIhW4+3LBINQTMud+fMSkosL19N1Hg4ccc45ppdET
    LRKEpd0CYaOwY9SrzwyNbfOFynMmF7KR0QfXtiYofe5w/YWATB/qrmx73AP7DHoB
    JIKr0rzY445lCqXKIKqtG97EtTEr7fYOd0vqV1rmrYuw/MEQvrINdfB+nJctqQdk
    mU5dqpMOpSDJqtO71QebSqUbtIaQU4H/9ci5+POsutKEnHzS7/KV4Vp5OmKTaNVO
    SQcKhcmCp3rjm/XGbcdGp9+ojdyXXvWcYThGCDdscdabHgY3NRWMYPT2o1ZSnBUg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AAqI6uph x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdelkeenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AAqI6uph x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdelkeenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965383AbeCSVKw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:10:52 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934996AbeCSQBy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 134/281] ASoC: Intel: Skylake: Disable clock
 gating during firmware and library download
Thread-Topic: [PATCH AUTOSEL for 4.9 134/281] ASoC: Intel: Skylake: Disable
 clock gating during firmware and library download
Thread-Index: AQHTv5tocLEQK0e4o0iQySN9tJDVPw==
Date: Mon, 19 Mar 2018 16:00:32 +0000
Message-ID: <20180319155742.13731-134-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:D9G9XBzvJBdpZvNEhdIvb798/VwcQXAgtS4Jl1K50RnFyhPY5W4lwCot0to55urrKa4hCn30z22fuBn9uMMxkz5UxnYWy0bkwO+Y5SbiGAR37dl7bGRmL6NEC4nLsy69K6m3gskGtIQWgHN8BV7zoZt9nJAHQPa9Cw6nV3iugt/f/LZ/uDMinBj/THBPKJqc+U1IKZuJZmiof5FEItoOqCMB99sBbbO4jB67956bcCTlB4+PdxghKhO4ibqBiF5G;20:3p19THW+UUZeX4r+2f/ljEUbr1a0np/2iaggtZc56vuN6nMJeNxPMJJ6X7A2LbgatFHNAWKYuRl9LgZT5akfByVJgXsqH5herNUcQA77lWOKFR/AYIiLw14iHTxkvPukdkf6YlglcJJrr/1A5cR+IqGHVhWifhEUk9ajR5Wiu2M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d05c8e6-809b-4e99-f702-08d58db2b881
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919E154D6A5C25C1BD6D5CBFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BMiY67+iBKPEwnZMNVoTgF6K54edF6XVd5MYqE7zf07mxk7bJBW6BYmFfyVwjCMdFwt9uuWshunnPVtHUxbVxULOxK/4Rqm4tbQVjG/08lXxytAZG5v9kI8+ZP6bGYGLi3QRBvchPth2ej75mSXYrug86DID6LeKsJjXQF8XyarbDOZOc5A6QwBwSg7wfQDLufgHEujUEvb1TER3+R1W+kK93SKp8YVF3fcGAkv1cnMX+TQhmyM/HlYwabHs9CVW0lh7M3TghRe6p52epeA/JxnS074pF2cxG8G22s4ER4Lnop6+Fc2dYzf6c4z3AQzlT/QE9GD7Iffc2Ee2ecTqYg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d05c8e6-809b-4e99-f702-08d58db2b881
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:32.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 805b7f2173f3..78472c908ae9 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -331,7 +331,11 @@ int skl_resume_dsp(struct skl *skl)
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
index 58c728662600..2fd213cd9a40 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1191,7 +1191,11 @@ static int skl_platform_soc_probe(struct snd_soc_pla=
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
