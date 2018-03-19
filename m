Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495056-2-9485849781345846087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495056; b=Pe49XITxdQeoDSAoTk8y6D8uwyp1/FHLgeQvNiZwmf9Ws+A
    E8mpI4GrGC+yrx4jYtRWeKhK4inJijAFDrfbwcE2mOj5Z5BZsWivbAlgudmt3R0Q
    wI+7z5fsiIsydRXh1VHYomU28RCZdGeC6gsNXaFkjpzj93G6rPSBeyE5nu++rVBw
    sqg3yBnwh74BoSEKB8kM7Dv5ngSg88rMeIY4BmZKZ4McIrRoc5TKI3CxE/ziSTw8
    pz9XdXn9zHg4ayIvg9QxygPSPVoK2Ypw0Diel7d/yvSv3dF5AEu7pCoeSlYROQmw
    a/ONM9r+Xl86ovwBoHKVmTCxb+hCxs4t96J3esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495056; bh=HAXGhi
    RRPKQXurE+aL/0gkqeaJbp8Q3qzviM3jW15+g=; b=m/GLAcAzkZIq7gJ9aKoE0g
    06o0TYYCUJjJ+hxQKDWVhmGI8opiPY8QC0fkM+eMyWyfAKVgCRxAYt3W0Fi8dlcJ
    MDtdR6Zze89O7PdEgPCwC44ndduXyaIQqpKd4dlbHYWC4JhqSCJ54a7E0SIah2IZ
    yVBY+1boLq8AMuLo9fHN0jBvXuEJUMfe1msoROOptjPNGx2+Q4jhbt2UcxyNZlSe
    bp8yHYteBwzZB7SYQkfOfd2XM/GfbOlEHthW2CB9UIC5XWO41pcapy56l5ikZqO/
    94li38bxoGpMZRXK5M1uLsh2gvYHIjWdwTIm7dFbh11yu18HzsSFt3WwdVS1n5bA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jGCFoGLX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvddtgeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jGCFoGLX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvddtgeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969921AbeCSVay (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:30:54 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:43648
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965213AbeCSQAE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sugar Zhang <sugar.zhang@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 065/281] ARM: dts: rockchip: fix rk322x i2s1
 pinctrl error
Thread-Topic: [PATCH AUTOSEL for 4.9 065/281] ARM: dts: rockchip: fix rk322x
 i2s1 pinctrl error
Thread-Index: AQHTv5s1/qVlb639kk+6YkfcNVN0pg==
Date: Mon, 19 Mar 2018 15:59:06 +0000
Message-ID: <20180319155742.13731-65-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:JZGFMLxCyTVmzZXb6zqb6WrOUDE9fJcVtQiyVTrHgaLZPGeajmjl85VhJTCcVFDms/tsfwhsAQvvt3XbLyBnMZ1lmrCmuNbibr0gAyHwMOGki+oRpwTtuD5rKPm4jMW2ZsVRfuVZeHkJOu6tsx00Q//HuySkuB/0l4K6iBp3WBfdT1YpNF1CndN47488vBecx7RzZEGVV3rzaVTtrVRurzz34GD0EVXplBB7Zal27PP14pkkzy3SJc7//vA5oirk;20:1Apgqg8H6ZZsH7hUL9zKEebVVy2kq2ICDHspwz2xzL+AQWiUKU3M7Y65cgvAwRBAwIs8fr6kRKOpL2tn0AiQ+SwmWTpDpfeHbROauASz3/kKnVU23tvAqB38OteVTTmHJcsoFKAY33ERZFn/ooCNK10DNKclXGvj7/By3p7586E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43369b33-ef5a-4c28-c2d1-08d58db275e5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096512970C197BD8BB243C62FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kD4ymZn+gv17si05t9ApB3GvkyxH2uq3Joa0hL1ui6Ucd9OOfR/XJ8Epa24qrP+a3Xk+3j/rZT5WXuPp9lV6VstzzOATJCZpJ3scfG38YzNjB2bx/xnn1F1Gbv6S7o78zzf8GdmwU5/RfW9ujj7x3ySzTovl+RKiz9ksIHavptnqd8Qh2MlIlNScDM8DluVkDm4s4PYfDldK5/HRz8YShcO/8Qfg5ark8OMKPF6Cu66Br2/RCS5laFw5vxfQSaawtNBhTmn0mDh7070BQPB1eTiqWdNvtAX0IrKW9uD80u7GndqyxkUp96gp22bq6+QM3rKkvf2cEzXN5RamPwTVuA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43369b33-ef5a-4c28-c2d1-08d58db275e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:06.0645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sugar Zhang <sugar.zhang@rock-chips.com>

[ Upstream commit 9d420e9b4140f8938ad6aa0d29e2428a2af6122b ]

Refer to Chapter 5.3.2 of rk3229 TRM, we can see that GPIO1A[2,4,5]
using RK_FUNC_2 not RK_FUNC_1. This patch fixes it.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9e6bf0e311bb..2679dc80f831 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -617,9 +617,9 @@
 						<0 12 RK_FUNC_1 &pcfg_pull_none>,
 						<0 13 RK_FUNC_1 &pcfg_pull_none>,
 						<0 14 RK_FUNC_1 &pcfg_pull_none>,
-						<1 2 RK_FUNC_1 &pcfg_pull_none>,
-						<1 4 RK_FUNC_1 &pcfg_pull_none>,
-						<1 5 RK_FUNC_1 &pcfg_pull_none>;
+						<1 2 RK_FUNC_2 &pcfg_pull_none>,
+						<1 4 RK_FUNC_2 &pcfg_pull_none>,
+						<1 5 RK_FUNC_2 &pcfg_pull_none>;
 			};
 		};
=20
--=20
2.14.1
