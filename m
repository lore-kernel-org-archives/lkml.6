Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182AEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFAA206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="TCjWwZqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfAJQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:20:55 -0500
Received: from mail-eopbgr150073.outbound.protection.outlook.com ([40.107.15.73]:2284
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728605AbfAJQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqTK9CZt5vE55mF13xiWPY10b15hHFtVEI0eZtqoeWE=;
 b=TCjWwZqImk87OlR6rcznhM2NP3YNiv3CVP3F+pzszPvkYHVRau/cnpBjJqaC21gBphWPOqp40ojiaB8MQQXWWPGI1K1aZ1AsyKKnOBd14SS4hvVU4OECMYMNA0mAFT0NWN+bWCe0vzfR8CX0UjK8+axnlQszK1Vjgyw0rYoWFFg=
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com (20.176.233.96) by
 DB7PR04MB4666.eurprd04.prod.outlook.com (52.135.139.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 16:20:50 +0000
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7]) by DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 16:20:50 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH shawn/for-next v3 1/2] dt-bindings: arm: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Thread-Topic: [PATCH shawn/for-next v3 1/2] dt-bindings: arm: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Thread-Index: AQHUqQBzMzydnRJgHE+jwJ/lo9o7Fw==
Date:   Thu, 10 Jan 2019 16:20:50 +0000
Message-ID: <1547137215-25928-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::26) To DB7PR04MB4810.eurprd04.prod.outlook.com
 (2603:10a6:10:15::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4666;6:2b/hkBLRPmyPGCP2NArc5bUcdWddGVpTAbmwUOZ0touSyfBYMoN+Jojlb9x5nRC3yVVh/wMWMMP/y+7pgM1FCYbA9NoLFfWoG2OjL20v/GrlDmVyT+3x/HC3Bbq6C+csVddCi7G7GvbBcrDN9tEMkQMpl8jtFyqh8mogop7S0ZcMSUZoYnT3L1yvoHGpEAL8M2znLJXvc2ayxXu1FHoWgPGvZX2rmeA0Up/Ssx5RfBfuEeDEF8w6rLkfIPr1MkzNbQPF3VYoxpKgfkdaE5mVkeT0C/SvZ4ObBTWN4WiHtclAgvFgvj2xp7rx+U5vbjpwU0PbNTa5h7Bj1FS+Gb0a0GuIpQxJfryCkG3t3BCGqRzOb/ZhU1ZVmPzoFe8kVsbEJ3Jgr7YY68z2WR5HVcA+B7zxzQk+NxfOC6mOB4sibXDOl1jJspJRTfHN9+/Ht8EmNAr7zvuy/Qsndpz1MaVobg==;5:Wu8rEkg9fH3/H72uIeYOlkfVfrboa4sLAG9ivsHhX5sCYOtmbNSJ5ZDDXQUrWRGCnoAP/8HCtRCJE8kdjdVn9rgc8UibO04h4f7SZ7iheUPOcmiKHuis23b80DpR9qGfsfdy2HVDQceXQUnyC4G+KXgHiSMM3EB7q5sruqM5M8eSSooT9K94/inJIY18TzVC8TIlh5dSGpl9tJCeNcYpSw==;7:2y0nBaZRT9GkvrH9bKoKF42gt6VhwadtdHPAud17qeHTjKBBH2JruJ3TsUlHRdTMt+28WFSDRuPO9TBdqjS+nLxEJhBxbjAx/kdKqvvSWx2gKkl8zcmcsKR00B2iQfltkQCw17RyD70eZBD3HkyGHw==
x-ms-office365-filtering-correlation-id: 6dc019c0-a86c-4540-dc5c-08d6771795bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4666;
x-ms-traffictypediagnostic: DB7PR04MB4666:
x-microsoft-antispam-prvs: <DB7PR04MB4666CD94366C5E62B81E723F9E840@DB7PR04MB4666.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4666;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4666;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(376002)(396003)(366004)(136003)(189003)(199004)(97736004)(25786009)(4326008)(53936002)(105586002)(3846002)(6116002)(107886003)(486006)(71190400001)(71200400001)(68736007)(2906002)(106356001)(5660300001)(8676002)(81156014)(72206003)(478600001)(7736002)(8936002)(476003)(81166006)(50226002)(6486002)(52116002)(99286004)(316002)(86362001)(110136005)(54906003)(256004)(36756003)(85182001)(14454004)(19627235002)(66066001)(6506007)(2616005)(305945005)(102836004)(6512007)(26005)(386003)(186003)(6436002)(567974002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4666;H:DB7PR04MB4810.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bSWxmRdk9FdRiTiykxliDsF+onLS+tJRj0297vFli7QRtYrecZOOWgkmnEfqLIuY0DZQ980XjRLBRyaX9fGq2Wq+xhLQjwUpKD7YRUAy47L+OKAR+ar/71KdmS8oePupmKcwGSqVtWg/CUZFOzl/YHVozPx7c7kFk5S30EtuU7ASoMMnXxyxBkdYORIAOdCv5BjzxU2XbQoCBEqhfFmIbXEHlw5wtRv92tupTbbyD6o116/fAXBCVDMQe+88K81YU4mA+R8V3eSvDB6UXklguay5gzcSx3twi2Ib02UvRbDFZcvTtf8Xi0rp8hPAwEZv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <600BE0E33F000448B8BFA2C51739FFC0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc019c0-a86c-4540-dc5c-08d6771795bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 16:20:49.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlc2UgYXJlIGkuTVg2RHVhbExpdGUvU29sbyBiYXNlZCBzaW5nbGUgYm9hcmQgY29tcHV0ZXJz
IHVzZWQNCmluIHZhcmlvdXMgWSBTb2Z0IHByb2R1Y3RzLg0KDQpDYzogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KU2lnbmVkLW9mZi1ieTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2th
Y0B5c29mdC5jb20+DQotLS0NCkNoYW5nZXMgc2luY2UgdjI6DQogLSBOZXcgcGF0Y2gNCg0KIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgfCAzICsrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQppbmRleCBhNGQ2MjVkLi5iMzkwOGEwIDEwMDY0
NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KQEAg
LTk0LDYgKzk0LDkgQEAgcHJvcGVydGllczoNCiAgICAgICAgICAgICAgIC0gZnNsLGlteDZkbC1z
YWJyZXNkICAgICAgICAjIGkuTVg2IER1YWxMaXRlIFNBQlJFIFNtYXJ0IERldmljZSBCb2FyZA0K
ICAgICAgICAgICAgICAgLSB0ZWNobm9sb2dpYyxpbXg2ZGwtdHM0OTAwDQogICAgICAgICAgICAg
ICAtIHRlY2hub2xvZ2ljLGlteDZkbC10czc5NzANCisgICAgICAgICAgICAgIC0geXNvZnQsaW14
NmRsLXlhcHA0LWRyYWNvICAjIGkuTVg2IER1YWxMaXRlIFkgU29mdCBJT1RBIERyYWNvIGJvYXJk
DQorICAgICAgICAgICAgICAtIHlzb2Z0LGlteDZkbC15YXBwNC1oeWRyYSAgIyBpLk1YNiBEdWFs
TGl0ZSBZIFNvZnQgSU9UQSBIeWRyYSBib2FyZA0KKyAgICAgICAgICAgICAgLSB5c29mdCxpbXg2
ZGwteWFwcDQtdXJzYSAgICMgaS5NWDYgU29sbyBZIFNvZnQgSU9UQSBVcnNhIGJvYXJkDQogICAg
ICAgICAgIC0gY29uc3Q6IGZzbCxpbXg2ZGwNCiANCiAgICAgICAtIGRlc2NyaXB0aW9uOiBpLk1Y
NlNMIGJhc2VkIEJvYXJkcw0KLS0gDQoyLjEuNA0KDQo=
