Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A5C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826982081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="jVGUChM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826982081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeKBUBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:01:00 -0400
Received: from mail-he1eur01on0100.outbound.protection.outlook.com ([104.47.0.100]:47328
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbeKBUBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxWoppGnHpAPa6loe2iA9qL1lFjZSw+bwcP5U8q6Wwk=;
 b=jVGUChM7V9jP5pGOp4GtBqnT1/DrhFfbKcKXAaL9mUbaR7KVHjaydnD2k0s3OA1YYJUIcVSw2BmgJsdMaIdd/fUyZbDAH1Z61LNFOOLLvR9zyhgfbU5AkPMpkBOq7/EcG0715WlEYfnfpfTl8Gfx6KieQ7a9X/mTETj00Wtn9wk=
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com (10.164.51.157) by
 HE1PR07MB4412.eurprd07.prod.outlook.com (20.176.167.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.16; Fri, 2 Nov 2018 10:54:13 +0000
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b]) by HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 10:54:13 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
Subject: [PATCH] arm64: dts: stratix10: fix multicast filtering
Thread-Topic: [PATCH] arm64: dts: stratix10: fix multicast filtering
Thread-Index: AQHUcppkcUhvTRsJYUaof7ZKCW1t8g==
Date:   Fri, 2 Nov 2018 10:54:13 +0000
Message-ID: <20181102105355.18654-1-aaro.koskinen@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.2.16]
x-mailer: git-send-email 2.11.0
x-clientproxiedby: HE1PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::32) To HE1PR07MB1307.eurprd07.prod.outlook.com
 (2a01:111:e400:59af::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB4412;6:gmplPFb/nmrNCTp79vU1ANCjuvB67gg1w2PvMTLTvY6aJe7fJGVlZ6XilVAJsgNqQY54twwjhoSeBgygPoAjzNLlWQr2ngYIR/V8tvteEjEBQ8ymJPRfwh4LndC4cYxKQLIsal+yA2uDqc/4XY9mZNJu0xJpqbnysvXaG5LvMlU4V6tTGINiQEdKLjvzIJxGjmxTdvsbgzMsZBLu+ZhSk6n/t7b/heBhMzD6yLsuVBWp6p1AMRC4j1GXze9iNobWTfkWfnHE/dUpY40CpHPWrF7AA1xbXfRTVHtJGFXdX+nAwQvlQaEAihA8+0W73sazgWdCmuJqXhBjwljHPstfgt8T9T8T+5W/MRw/LBpqCUMomd2920n5xqhZNcx4pASEC574wqW3/3VCJiDRFZqlNqZAOUMx9NtL6j6kCEHsJ/yXsSr6Z8Sk4WHinqSW4miGo2UY1WDmpqbexxZASfb8hA==;5:upXkYaOOpk2R/4wQ1kZr2hEyvbFW0THPmpEWrzsRvwS1rItOQRvB40NrDk7bgNmzkK7Fs47KQL9fYvirqXgIaCcEJdJxjMnSLhAg3sNNwB9Z9w8eWRlWhDADi0C3k1Vybns+d7Gs0P+HvbhbJxfTKUo+gYWqQfI/V54fWY3WCR0=;7:NiZxrPMmgkaqCfpTQZgU7D4LL5pixPqFKQTFais54LvkrfRIeu3K2IlzkydlCb+p3bYrafQ4s0IXIsStujJcVubNWbn6MeevaeSRBd7YvK7EAOViF9z+K8AvAxuEU9F95SifNvhmN63ee3DQh3DqQg==
x-ms-office365-filtering-correlation-id: c4de9081-0f6c-4c1b-e01e-08d640b185ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR07MB4412;
x-ms-traffictypediagnostic: HE1PR07MB4412:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-microsoft-antispam-prvs: <HE1PR07MB4412D1C2BEE91550E2C26B0BF4CF0@HE1PR07MB4412.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(195916259791689)(109105607167333)(82608151540597);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(806099)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB4412;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB4412;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(4326008)(14454004)(71200400001)(71190400001)(50226002)(8936002)(106356001)(105586002)(8676002)(81166006)(81156014)(256004)(14444005)(66066001)(6512007)(1857600001)(2900100001)(25786009)(478600001)(26005)(53936002)(186003)(6436002)(7736002)(476003)(2616005)(6486002)(54906003)(486006)(305945005)(97736004)(110136005)(52116002)(6506007)(386003)(102836004)(86362001)(99286004)(107886003)(6116002)(1076002)(3846002)(36756003)(316002)(2906002)(5660300001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB4412;H:HE1PR07MB1307.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cdIR44dewmAY9vJuyA8cCX23BY3qvKGEJIT0+wSG8GzebgV//qebmqldg/0aC/EEBBg/i1jbaUopraFMVZm0mJHdAHkKinPz1eaZNkXVmNJLia+Meh1PhaoYmYSaq7MTMCvHKhDe7vtL7MxVWk+joyygJ+AhWPIP1RKVMuYBnTWxrKoLsec9DWnV/f/TLslbXbqaiHUpXIWFNfDwOYNbKBO5i6jVXPoTNX8oaGpCGFLdxH4iXcSJnK1ynVNqOmFCMT0wO6CC8KWJSljfqyg5GPlEOaKEahyeHfxo6WXfrEA0eDr+nm7K378+BF6457AFqAuhVTSsML3FYZFFQMDS22g/o2TFp8wUPBF4FZLnYek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4de9081-0f6c-4c1b-e01e-08d640b185ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 10:54:13.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4412
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Stratix 10, the EMAC has 256 hash buckets for multicast filtering. This
needs to be specified in DTS, otherwise the stmmac driver defaults to 64
buckets and initializes the filter incorrectly. As a result, e.g. valid
IPv6 multicast traffic ends up being dropped.

Fixes: 78cd6a9d8e15 ("arm64: dts: Add base stratix 10 dtsi")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64=
/boot/dts/altera/socfpga_stratix10.dtsi
index 8253a1a9e985..fef7351e9f67 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -139,6 +139,7 @@
 			clock-names =3D "stmmaceth";
 			tx-fifo-depth =3D <16384>;
 			rx-fifo-depth =3D <16384>;
+			snps,multicast-filter-bins =3D <256>;
 			status =3D "disabled";
 		};
=20
@@ -154,6 +155,7 @@
 			clock-names =3D "stmmaceth";
 			tx-fifo-depth =3D <16384>;
 			rx-fifo-depth =3D <16384>;
+			snps,multicast-filter-bins =3D <256>;
 			status =3D "disabled";
 		};
=20
@@ -169,6 +171,7 @@
 			clock-names =3D "stmmaceth";
 			tx-fifo-depth =3D <16384>;
 			rx-fifo-depth =3D <16384>;
+			snps,multicast-filter-bins =3D <256>;
 			status =3D "disabled";
 		};
=20
--=20
2.11.0

