Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481126-2-3304857328540557970
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481126; b=XAzeuSIOs8GaVXF/+8Gnf7ac4fyfUiJ/ReyqTUsr2Nfuf4S
    p9GgtFhcoCxucdEvm2jZWQ5GcA15rHsvAGnGHxgU9AK0mqG6Iz9KMp/AB58eC1wu
    Jts1e9LQ3/etGTa3+9KxJR04skj6O35waKEiCMe+/3zbd/T7xFUWJsSlW4LhEBq3
    8/Hj9uxEV44eTE52RupurGSOU1P3vSUuswLXa5jOikZWFhX5AvLM10RilMztjMya
    4oqodzqBC41jPSRkvzKu7XnDwZof78Bz1i30F2cEBYwqLq7zweQ2zyEW9djiik4i
    qIgXn8QTS/Pmg8v9V+4Za0LR2rpKGo7Bg3t2nVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481126; bh=gBSi1+
    +TTcTzzXwVnhhXLaguhzrchLNIaygE7GymJNc=; b=l0NusO6Q7bZDGdx/fbjR95
    IJV1qy3b6PhDO5dCW2fVUFNBRVcUSMQm+3gLUxLk6OPLJju49bhVi8z9N9t8txEt
    /JnYewr4i7ByA776j2ateNwPeHF+NbNk2W4d2I+OmmrfnXMmk61aPKm8/VHFUTVn
    /GxZ4a6QT1dcXRW8L+Uhd9gwWqi05QWvSANZtrHgVGYohGFCQSFcX5ETtcCQxw4Q
    XDTJZiP+U14BXOhnjbcqNydI81tJG9Q7xrhJkU1mfQJD+NYJED8qG+gV0U0Gz1zK
    rR9beW4NWQDmwCcKPYPlu+X5YvsuUTpNdRxcRHIrrM8okc60T1/g6VJSJCOsHOpw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fp5yltdt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdelieenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fp5yltdt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdelieenucevlhhushhtvghrufhiiigvpedufe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934609AbeCSRiP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:38:15 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965969AbeCSQGm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 003/167] rtc: snvs: fix an incorrect check of
 return value
Thread-Topic: [PATCH AUTOSEL for 4.4 003/167] rtc: snvs: fix an incorrect
 check of return value
Thread-Index: AQHTv5wV1bdeNFnhFkii50zgA5faGQ==
Date: Mon, 19 Mar 2018 16:05:22 +0000
Message-ID: <20180319160513.16384-3-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:8UrXs2XSgfsmFrDp5lWyADMDkRJyHcx364AVNfmgM/+Z3IpXDxJItXZB22qbunwArGrTca8jUgcg/DW2YAfultyhMt+8lmB4iUrbXaADgbjVEB684jqdUu4zXJm5pAyOs0ZMYVf7lk2E554Qk7W90Y1If0uAtX85M5RGpCx7vfTrc44SVMfZ1sphGQC8DTClLAUNLwFA3G8ddt5RxB85wCDi+oDXCfBRIhfZG9KRLHAtInp8TEnscl4PNXK8LpOC;20:VPGP3qbJ6kyxdfnAspu+NbeWunyniEg3wsVLuUw71WaR7IT1Aua4KHRbh0k90mhz/Qe+AkUBWEdZ+OXtAmnUWpT+EdJ3m7n187rKw0Txv/whZxs7YkgO53yTGGnlYk7atwZRUOrG9GT2tGeUoGt7TDpZ4kDu0RjfNUj7NWe8B00=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b5e4b49-afbc-4457-8977-08d58db3669f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09207F1E495A5CA7A417EF80FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WqB1mvLwtJs+Nin7Sol+KsVSs6/KpqYwkuxXMh7gtQQv5o95jYaAw1qsNtknqYd3GrSUNwzu69B6u59i5tvvLncwVdzo9LJu3QuUdeaPAmpvR8H+eYd3WpV25wE46/+vvhCNumuuWCEb0ALyprByR33WRi9fJTpNKIQUzfYZO3+qTh1oKKGszQNybRx29UPDWKk0uubYecJGYSbHOMyhHWuHiDG3ArQmM6JK+uVIWtbuZIuqVnX3PKWdVJC14WqcTVhI6DJN5oY0lENskF0kNzM3bhxzLJ9l7YhS3TAFVAJ/F0Le3jOfbZDbHz+byVGJHdWEkQ6hls2n1mt6sqL9lw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5e4b49-afbc-4457-8977-08d58db3669f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:22.4085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 758929005f06f954b7e1c87a1c9fdb44157b228f ]

Function devm_regmap_init_mmio() returns an ERR_PTR on error. However,
in function snvs_rtc_probe() its return value is checked against NULL.
This patch fixes it by checking the return value with IS_ERR().

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-snvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 950c5d0b6dca..afab89f5be48 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -257,7 +257,7 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node, "offset", &data->offset);
 	}
=20
-	if (!data->regmap) {
+	if (IS_ERR(data->regmap)) {
 		dev_err(&pdev->dev, "Can't find snvs syscon\n");
 		return -ENODEV;
 	}
--=20
2.14.1
