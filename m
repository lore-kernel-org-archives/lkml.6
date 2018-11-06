Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55ACC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9288620827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sMhH085u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9288620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeKFSoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:44:01 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:2828
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729711AbeKFSoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee0bRyJKWW9GVee8h12jpKMI0bYxGYStbxMpO7l1A0w=;
 b=sMhH085ufcOxb6XHfxVTLMEAIoxhlrOUOuoGzYQeAcunKvkKG/CS5zxGxiG7EQTDIDa4tWNSFlzS5T4kn/m9gnCVl2g2B+b+T/MbYbb6eCwZ+thAo3s1HEXM4Ws4p8JfGIWu/Q1I6yVhEPYMPEA625HOSlv0Gu1sISZwKEuR080=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 6 Nov 2018 09:19:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 09:19:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6sl: vddpu is NOT an always-on regulator
Thread-Topic: [PATCH] ARM: dts: imx6sl: vddpu is NOT an always-on regulator
Thread-Index: AQHUdbHZgQdgP6mWLU6+YbqAWEXMrg==
Date:   Tue, 6 Nov 2018 09:19:41 +0000
Message-ID: <1541495675-14706-2-git-send-email-Anson.Huang@nxp.com>
References: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:DNpdHheAX/bzvSMAlJ++OTQegjLHNJOVoUs+3ZuN0g7lTPlQXkawHxKCz/lfE+lsHJ6f8y8PWbCJpU/9Sg58U56EU4s3DzgByM01seLXXyp5BUAq+z/a0RfYAFZa5LYnlyuMXxwo68YXEcGdV3z36t57cQAXjgEWxQmz8FICA3kZu08AQxyFBlwi1xAe16k88KcrUlY43Y7ZjRq4ik9+qbKa0qqco5YIfljehswa59g3Vo1JVIHevJ0p4s/VrBl2G7GtfJXSniGENiWeLuPT6UA+Nhxa0Vr3CDVpQsZApqTNwypCLOJbbsICcxfQhT+g9yWIhu1D2pbYML8dSQ/eq7s/lsII1EbNC3q8L6hZXQFx/l01ltPsWoZRmdqzGu0BAHhHoQVxuoy0fpVJPQ1D2yr99n1JGXyCJJJ5B4MAk/k71m+OLbNoj1lTpcZgoS2VSIVluGcis+Dr7YyywqZa6Q==;5:M1E4SQCTMTXOChRnV5hOph81LVMmhsevVyNscmiJERnytT+u0t0/9DU0XAG+A9FJuBc+zEUgwSyB0LADtimiYGC8zae84kH3X5QuyO0bFEScf3AC7Juo2VXhCQXC3AUMH0oDEcKVMTgsy5HvMvQHQ1H1jw8kL3n4OCmugSJ5QfY=;7:aWntXzLKtHM4ogYqhTHm1zLmXNtIP5kdebqsOMPfoewIgS5GwueQVB50JJdvhgH6XaT2IjjF8RaraaIzbq0jrCEizE7LJxkgMzt3WarDkiIvdSKVq/biTL7EksNBFDHCaJDNZaKdiDzNMJ4wGUBFGg==
x-ms-office365-filtering-correlation-id: 05a365e7-b386-418e-5180-08d643c8fb47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB39467C5BABBFAA54A8E0F706F5CB0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(3846002)(256004)(81156014)(478600001)(486006)(71200400001)(2900100001)(97736004)(8676002)(7736002)(71190400001)(6486002)(53936002)(102836004)(11346002)(446003)(68736007)(81166006)(66066001)(316002)(2616005)(6116002)(186003)(6512007)(476003)(2906002)(6436002)(86362001)(110136005)(26005)(106356001)(2501003)(5660300001)(4326008)(105586002)(14454004)(76176011)(52116002)(25786009)(386003)(6506007)(2201001)(14444005)(1857600001)(305945005)(50226002)(36756003)(8936002)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nc17eCadzUpF7sEaBhZgnXK7Uqlu199P0TaAQyps/IbTl/kPujpDr+yeGgyoZY+/bvuvOWTb+3wO6QaT3D/ruZWi53sJnGrG6bXISS5aDSBRaQ9qzszzbrC2oJM3hHOPu5+ZtaFNpDd5akioYU6WL6tn4Ew6MX0PwmiEoybV+tGSkSaAy3a59yJOCKEL9I94u7LQh8lGIsDJzdNYhqWzXAm5fxWGlWJeZOfBoWPbK88xW7JuwjjlV5Q/5rKIy10fZWu/glFPkhBtqQURiTY8qnQ179qR49CZTeiLxZvKDZnhoGfkDqPfsIEB7AcXAjPtTMhUYrQpLggzYb/yV8QGpb6sAKhR4vZTI+9axBzXKUo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a365e7-b386-418e-5180-08d643c8fb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 09:19:41.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "regulator-always-on" property for vddpu regulator
since it can be OFF when GPU power domain is OFF.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 9bbc5b0..557d3fd 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -588,7 +588,6 @@
 					regulator-name =3D "vddpu";
 					regulator-min-microvolt =3D <725000>;
 					regulator-max-microvolt =3D <1450000>;
-					regulator-always-on;
 					anatop-reg-offset =3D <0x140>;
 					anatop-vol-bit-shift =3D <9>;
 					anatop-vol-bit-width =3D <5>;
--=20
2.7.4

