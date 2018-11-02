Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05803C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A419A20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="EAf9XjCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A419A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeKBUUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:20:06 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com ([40.107.5.90]:29764
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbeKBUUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YA7ItzCMpHPMu6W/LbaW0hhXKKDhUh7wzlykuO3OgJY=;
 b=EAf9XjCKtKqClDZw086NvKGdt3WVv/FRXpNX8nrAvvoSX/W0vor7E+h8CZGf7vhj7riejV494zLly1UL1DO2ScxeXPzabOCa0fuzX5wT86haM0ogee969bgG//Te4B+TGJsexdZmCtQy83H91uC2qgDGrqNAk4Pb7WC6zxoZXs8=
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com (10.164.51.157) by
 HE1PR07MB4409.eurprd07.prod.outlook.com (20.176.167.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.16; Fri, 2 Nov 2018 11:13:14 +0000
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b]) by HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 11:13:14 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
Subject: [PATCH v2] arm64: dts: stratix10: fix multicast filtering
Thread-Topic: [PATCH v2] arm64: dts: stratix10: fix multicast filtering
Thread-Index: AQHUcp0MQUsx/YwAnUyT3CyI6LJndg==
Date:   Fri, 2 Nov 2018 11:13:14 +0000
Message-ID: <20181102111258.18748-1-aaro.koskinen@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.2.16]
x-mailer: git-send-email 2.11.0
x-clientproxiedby: HE1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:7:16::36) To HE1PR07MB1307.eurprd07.prod.outlook.com
 (2a01:111:e400:59af::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB4409;6:Ux5hHHPCY6werNZoZwgKf7kAfCcWHBvCrChsaWpRLXehqIL9Iqp9CWVN7xk6wUhS/YY/gg/qOM6BC4oMl8LX18N+GrZHS0hOhfRBoNxI/cVNPvR/W2nsGqGx3kiEnLyfqrALGbLt0PW2SqiYkHLdddvQ/X6+ggV8Sl+U/n+8vgc28i+W/m27FFvt8J8fLvYpFre+F0Yh+MtH24JOFWkvowOu/2v7kBjXiSyx3LnLtsgYOo2xpMaujSCE9uUK5MCHZc382ti81AoACovQgSZYeInQdXnQ77kDCVNkspcYn+6OQSzGjBRZOamRPOwD3T7BsQSu0lQtckfJWfTToG9I80g1AALniQlWIRvt6keJm4PNASTrywpmck1ndvMDk07j/QSQ3GWLdv+S/qRVsOudSKePJFmiKtSuPC/Ad7/JjxURktc5DpErqlcoFGNYmBJ19YVM+tuD5QsA+yTiUmGCdg==;5:DZ4r4a9/nnbarMSOHPfjo4DySGNefBg6oUcn7bF1NCD0nDDFYx+ydLh13fMwzfZh6mSjaGVhPFwWpWD7h60EGbLxrXKbaLiWBRixgVyyv8bIxybc7fywxgVbPrOPsvn+kHbzAhWv2ZOJnuqezUSZteBpd/TTKUXTO35Myq+Vu7Y=;7:E6wDxg5RfXEBVpM0awTpNTuNHGph14h+jvKwdJAgwfU5FsCKSQW2Kv8PS6hQNP8mcBfa3o4HeLP6JN5lbbGSeCUpfjZWOUz9YTXzaZE7kZXqUlk/N4cgSMEYuPwfAiVLqqjZsjhY7R4PcRKsHQ6+Vg==
x-ms-office365-filtering-correlation-id: 73d9c1a2-1d26-4de1-c89c-08d640b42e31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR07MB4409;
x-ms-traffictypediagnostic: HE1PR07MB4409:
x-microsoft-antispam-prvs: <HE1PR07MB440972C1DB51367E0A3ABE2CF4CF0@HE1PR07MB4409.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(109105607167333)(195916259791689)(82608151540597);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(806099)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB4409;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB4409;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(26005)(386003)(6506007)(99286004)(86362001)(1076002)(6116002)(3846002)(478600001)(2906002)(102836004)(6512007)(7736002)(486006)(105586002)(106356001)(52116002)(25786009)(186003)(36756003)(305945005)(97736004)(476003)(5660300001)(6486002)(107886003)(2616005)(6436002)(110136005)(8936002)(68736007)(316002)(54906003)(66066001)(53936002)(8676002)(71190400001)(71200400001)(14444005)(256004)(81156014)(50226002)(81166006)(4326008)(14454004)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB4409;H:HE1PR07MB1307.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +AFAXrTJ2REWYvQwe0cK5YWYmo2DsWMQOj1oAsg6sk1SvMfy078z9y88C/9NCWeml6789UDsLiGDb5k+/5SUXRNezMf58v/b4oEARe1Q53qrmdkmg6jle8mvIv5wNB6Mg4yBBrONvxeeMzRQFWkPL6uHmoP6ha4OE9IB/rLZ3VdBlojBdfv8x5vlTLfpWOBLEEuvDtwjJxh5j9dLuRf+9uNf8SV0LMmWmNrSXEe8M4XL7c1wGM/rhf54eDOvlJ2vW/5QXwfNpgzQKmug5Ojf5hr3m8Wic3Q1ADTcFpzK3htzltbaRevHVM1dQ+aliiBUse2yboPqx5HQVZvyNFTkgvQYzQnv/zoCRLubrOPjrBk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d9c1a2-1d26-4de1-c89c-08d640b42e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 11:13:14.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen+linux@nokia.com>

From: Aaro Koskinen <aaro.koskinen@nokia.com>

On Stratix 10, the EMAC has 256 hash buckets for multicast filtering. This
needs to be specified in DTS, otherwise the stmmac driver defaults to 64
buckets and initializes the filter incorrectly. As a result, e.g. valid
IPv6 multicast traffic ends up being dropped.

Fixes: 78cd6a9d8e15 ("arm64: dts: Add base stratix 10 dtsi")
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 3 +++
 1 file changed, 3 insertions(+)

	v2: Provide a correct From: due to SMTP server issue.

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

