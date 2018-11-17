Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CACBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D338B2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="lBtM84Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D338B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeKQW3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:29:31 -0500
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:30640
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbeKQW3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncXFo5kQ1/tIEktOnhPsjycwverkGND2+Il+78rx5rw=;
 b=lBtM84Qd0CkK1CSob+M1vZ2msqG31nRR+d/4ynEbjlyWW/FuREicQ2AaUDxRRNM518eXDYcaMLDsmR8HgzM80KUKUT0TF4fHc6c4J8oGmsiM2e4/1A5FYVFCZFe1T13Q3oXFCaoPvxenawJ49CDInfWjKWMkGjSqbMCL/FHCQ+c=
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com (10.169.244.8) by
 AM5PR0201MB2355.eurprd02.prod.outlook.com (10.169.243.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Sat, 17 Nov 2018 12:12:57 +0000
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a]) by AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a%3]) with mapi id 15.20.1294.045; Sat, 17 Nov 2018
 12:12:57 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: hwmon: add B57891S0103 thermistor from Epcos
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: add B57891S0103 thermistor from
 Epcos
Thread-Index: AQHUfm7gJIToXkQMqkmn7U2EbJSLZw==
Date:   Sat, 17 Nov 2018 12:12:57 +0000
Message-ID: <20181117121248.32143-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0211.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::11) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0201MB2355;6:srCetmGECAZbWDOpr/fF4CAP2Hseoz2LJz3Ck4wIfS3nRzc1EvJQAA0+e7IqUCSMlV8Arsl+5AMYCYEmMM/QGehu3kTi+sP7rwl/TrfquwQu/qyU+GHpEVao3GIrMwfxjxp9SFs0uwb8kUSLhlxUh8CaBQKNqOFNTKecUjLneNcGqiFpchTOPfp0L9bQ6qRqkoxTcvgo9h5g3YAeyaARHtjFB4B7PgSG+a/DL/YpSrwZ+bDojCs8hbzJA1KNu3z2UvKgTPOCHRiDru3mRp8ju/jdlMV9Jrko85wRL9wOSDJrj7CDdJuBae4y9Hid/sz4TtdQ5TViS+fhnlZ2AAj8q0kRn1m1/60vuKTX4jip2EBQCXmDqmH+64pSNuWISEO0/rdGRnoriRPZWxxGo+KtQqr9KE91BLibEI/1DB9t/h66IbIOtmJfs1RAoij5gtw18DhqK8OmZndYjImozC2MnA==;5:I3U+fH5ffrPbqo42lgmB3Y0S0dSSVdBF66vCoC8ad2iAoJ7UQ/qgDEkUKTrDAddcdBtVUlnnpvVKg63HJuACLtSGsNbWA5XJgeIwJFzqvoOLCE6yR9EyRQrllDHA2LJJxzVemNC2wMUI5iH6HzJMxjrdLR6Rf/wlvXDgWwSEnFA=;7:IRFDJFN+lNiYEtdtQqVwPl63/9pyoAp6MstRevFvmziA7FvLs4wW2p7DN2AhzD0aOm63mUKtr5P0lySNXcLKy5k995i82IHGaDETm7NTSGK3oaquMf/Fv5W4nrsJ4+f5xQm+W7WQU64rIbktJK0jFQ==
x-ms-office365-filtering-correlation-id: 8bda361d-0907-4d68-c9ee-08d64c86021e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2355;
x-ms-traffictypediagnostic: AM5PR0201MB2355:
x-microsoft-antispam-prvs: <AM5PR0201MB2355BF78CB27114B2FDCAA37BCDE0@AM5PR0201MB2355.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM5PR0201MB2355;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2355;
x-forefront-prvs: 085956473E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(39830400003)(346002)(199004)(189003)(97736004)(8936002)(508600001)(99286004)(52116002)(81156014)(81166006)(256004)(105586002)(8676002)(7736002)(476003)(106356001)(86362001)(102836004)(486006)(2616005)(6116002)(14454004)(305945005)(50226002)(6506007)(3846002)(386003)(36756003)(2351001)(2900100001)(1076002)(6916009)(74482002)(5640700003)(2501003)(54906003)(25786009)(26005)(316002)(6512007)(66066001)(186003)(6436002)(68736007)(5660300001)(4326008)(2906002)(6486002)(71190400001)(71200400001)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2355;H:AM5PR0201MB2451.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SVigUxLswIMw6Qxi9dNysXe2/+A9qERURW7j1Uhw8/0jSu6RQsQH0sBMe4FFCaplFX7WmDPH5NnEaG8Pnakj1xeqjv1hGsj1VZzxWe0ktR8aLSDo5o7wgz7hXnQpJmL7J9rSflxCWgy7RbRTuq5Mhao3aC8gY8D0fpPVOavBfU70yPqH9yAfim5WNACh6mfE45T6Sij+DUTsybsK287Ov2tXxc6GBFK6wUyHSmvgHXayzEwONHb/DWKyIzzA6X9gKB0zu27OEl8lKxxVWq8XXykNeOXiYa8mzpcuEdia6Xue+kkMeqxieZkykLiWsCNAjgwrItjixQ8RUqm1EY34e2lW6Z2mobrFjnc/O3yDrfQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bda361d-0907-4d68-c9ee-08d64c86021e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2018 12:12:57.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are Negative Temperature Coefficient thermistors, like the others
in the list.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/D=
ocumentation/devicetree/bindings/hwmon/ntc_thermistor.txt
index c3b9c4cfe8df..37f18d684f6a 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
+++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
@@ -4,6 +4,7 @@ NTC Thermistor hwmon sensors
 Requires node properties:
 - "compatible" value : one of
 	"epcos,b57330v2103"
+	"epcos,b57891s0103"
 	"murata,ncp15wb473"
 	"murata,ncp18wb473"
 	"murata,ncp21wb473"
--=20
2.11.0

