Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9639C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 06:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84843208A4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 06:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84843208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeGHGbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 02:31:33 -0400
Received: from mail-oln040092072053.outbound.protection.outlook.com ([40.92.72.53]:44172
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751293AbeGHGbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 02:31:31 -0400
Received: from AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (10.152.16.58) by AM5EUR03HT013.eop-EUR03.prod.protection.outlook.com
 (10.152.16.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.930.16; Sun, 8
 Jul 2018 06:31:29 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.16.58) by
 AM5EUR03FT010.mail.protection.outlook.com (10.152.16.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.930.16 via Frontend Transport; Sun, 8 Jul 2018 06:31:29 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243%7]) with mapi id 15.20.0952.008; Sun, 8 Jul 2018
 06:31:28 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix the oldconfig target rule
Thread-Topic: [PATCH] Fix the oldconfig target rule
Thread-Index: AQHUFoVN4VKe8QEqTUu43IsWDRn/Eg==
Date:   Sun, 8 Jul 2018 06:31:28 +0000
Message-ID: <AM5PR0701MB2657B3C36CDB2D67702077D8E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:4:29::25) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:603A8442AE6DAEB45D58C49EF9438F942AA3CA55765BC23FF4468C5DD96C359E;UpperCasedChecksum:FB4FDB96944BB752A3D5F14C8104A6D7DC6E4D5E00C62EBBCB45702DDC945A03;SizeAsReceived:7449;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ebeHTeikJkpmABjGVuRfdRGnVQf+zKwH]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5EUR03HT013;7:JvXw1zvTKjCfqxLvvohkZ5MKnLvzF3xamReYiooxTSD+hO/6ZJqqtaWfpPrIZwcT0mAYJ9mc8vujcxTjt1h1sncLZESBnFoU6jsjimadLTo8arPKjiPrYeLPHQlkSR3LZe0/9P0Ji9dbxMN+RVXc69mW1rnQDtxWZ2pmO1ykr0Pq/QvPc1RJy6tHiMxRSpULixllZnXk865ulpT/6tlEsxZGq8HMzS5BPaHtHOPBd0bfyoLQuM0fafCQpX6P1oU9
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:AM5EUR03HT013;
x-ms-traffictypediagnostic: AM5EUR03HT013:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(82015058);SRVR:AM5EUR03HT013;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR03HT013;
x-forefront-prvs: 0727122FC6
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(199004)(189003)(2900100001)(73972006)(74482002)(305945005)(44832011)(74316002)(476003)(14444005)(256004)(75402003)(110136005)(81156014)(8676002)(8936002)(99286004)(25786009)(55016002)(2501003)(5250100002)(5660300001)(486006)(82202002)(1857600001)(6436002)(6506007)(102836004)(7696005)(26005)(86362001)(386003)(14454004)(2201001)(105586002)(106356001)(68736007)(9686003)(97736004)(6346003)(104016004)(33656002);DIR:OUT;SFP:1901;SCL:1;SRVR:AM5EUR03HT013;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: HO9oZ35d5+tnqORUPLToMAzYEP1i4Bu6VpxAKCRQ49DBMURR5xRm06SSy4tUYe6axqpUcXDOoWTDMot1aKPICwfmK2TXDCp//eAZySRVbocb71yNX4FzSm/YOXltp0db3fETf0JOmb7CUhcAuyJn/A7BaMiuSmRhIKwIJuyq+jg4qR3eMIlwUYpwWVUe7JTZ7i1Cu/VKiV904Ee8/bIDgHPJCUrNKdjCAdSMwUW2J8U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3129065340840C44BEE34B6B3CC21448@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c3655d-f498-4be0-d8d7-08d5e49c6f60
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2018 06:31:28.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG5leHQgbWFrZSBhZnRlciBhbiBvbGRjb25maWcgcmVhZHMgaW4gdGhlIG91dGRhdGVkDQpp
bmNsdWRlL2NvbmZpZy9hdXRvLmNvbmYgd2hpY2ggY2FuIGtpbGwgdGhlIG1ha2UgYmVmb3JlDQpp
dCBpcyBhYmxlIHRvIGNhbGwgdGhlIHN5bmNjb25maWcgdGFyZ2V0Lg0KDQokIG1ha2UgZGVmY29u
ZmlnDQoqKiogRGVmYXVsdCBjb25maWd1cmF0aW9uIGlzIGJhc2VkIG9uICd4ODZfNjRfZGVmY29u
ZmlnJw0KJCBtYWtlDQpzY3JpcHRzL2tjb25maWcvY29uZiAgLS1zeW5jY29uZmlnIEtjb25maWcN
Ck1ha2VmaWxlOjkzNjogKioqICJDYW5ub3QgZ2VuZXJhdGUgT1JDIG1ldGFkYXRhIGZvciBDT05G
SUdfVU5XSU5ERVJfT1JDPXksDQpwbGVhc2UgaW5zdGFsbCBsaWJlbGYtZGV2LCBsaWJlbGYtZGV2
ZWwgb3IgZWxmdXRpbHMtbGliZWxmLWRldmVsIi4gIFN0b3AuDQoNCiQgc2VkIC1pIHMvQ09ORklH
X1VOV0lOREVSX09SQz15Ly8gLmNvbmZpZ3MNCiQgbWFrZSBvbGRjb25maWcNCkNob29zZSBrZXJu
ZWwgdW53aW5kZXINCj4gMS4gT1JDIHVud2luZGVyIChVTldJTkRFUl9PUkMpIChORVcpDQogICAy
LiBGcmFtZSBwb2ludGVyIHVud2luZGVyIChVTldJTkRFUl9GUkFNRV9QT0lOVEVSKQ0KY2hvaWNl
WzEtMj9dOiAyDQokIG1ha2UNCk1ha2VmaWxlOjkzNjogKioqICJDYW5ub3QgZ2VuZXJhdGUgT1JD
IG1ldGFkYXRhIGZvciBDT05GSUdfVU5XSU5ERVJfT1JDPXksDQpwbGVhc2UgaW5zdGFsbCBsaWJl
bGYtZGV2LCBsaWJlbGYtZGV2ZWwgb3IgZWxmdXRpbHMtbGliZWxmLWRldmVsIi4gIFN0b3AuDQoN
CldpdGggdGhpcyBwYXRjaCBvbGRjb25maWcgYW5kIHNpbWlsYXIgdGFyZ2V0cyBsaWtlDQptZW51
Y29uZmlnIGNhbGwgc3luY2NvbmZpZyB0byBhdm9pZCB0aGlzIGZhaWx1cmUuDQoNClNpZ25lZC1v
ZmYtYnk6IEJlcm5kIEVkbGluZ2VyIDxiZXJuZC5lZGxpbmdlckBob3RtYWlsLmRlPg0KLS0tDQog
IHNjcmlwdHMva2NvbmZpZy9NYWtlZmlsZSB8IDEgKw0KICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMva2NvbmZpZy9NYWtlZmlsZSBiL3Njcmlw
dHMva2NvbmZpZy9NYWtlZmlsZQ0KaW5kZXggYTNhYzJjOS4uZWYzNDI3NSAxMDA2NDQNCi0tLSBh
L3NjcmlwdHMva2NvbmZpZy9NYWtlZmlsZQ0KKysrIGIvc2NyaXB0cy9rY29uZmlnL01ha2VmaWxl
DQpAQCAtNjIsNiArNjIsNyBAQCBQSE9OWSArPSAkKHNpbXBsZS10YXJnZXRzKQ0KICANCiAgJChz
aW1wbGUtdGFyZ2V0cyk6ICQob2JqKS9jb25mDQogIAkkPCAkKHNpbGVudCkgLS0kQCAkKEtjb25m
aWcpDQorCSQoUSkkKE1BS0UpIC1mICQoc3JjdHJlZSkvTWFrZWZpbGUgc3luY2NvbmZpZw0KICAN
CiAgUEhPTlkgKz0gb2xkbm9jb25maWcgc2lsZW50b2xkY29uZmlnIHNhdmVkZWZjb25maWcgZGVm
Y29uZmlnDQogIA0KLS0gDQoxLjkuMQ0K
