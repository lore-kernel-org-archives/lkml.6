Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D707C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B758D206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BI8Tr9Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbeLNTAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:00:12 -0500
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:39184
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730467AbeLNTAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQBvrOmLwQ8tU98PWrTZcpi5mx85LRU5bZ/jSg0eUDA=;
 b=BI8Tr9PzxEcRhz8Q6pbCEM5eY8nGsxq3eBbsJrtp+0FBK5Y5/va7CeOamtl1nU8dzbqN8po/IXVGM5cw6czW/znJbSL1UpKJtFpg5y8BQwMjiCquV8aLkEEZpvu8+uYmt2eSL1nH2f49+ayk6mZAHgUbJk8dksbcSCJnfLaP/x0=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB0606.eurprd08.prod.outlook.com (10.163.169.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 19:00:08 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b%4]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 19:00:07 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Dave P Martin <Dave.Martin@arm.com>
CC:     nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Hayward <Alan.Hayward@arm.com>
Subject: Re: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Topic: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Index: AQHUkYd5TQtknm9R4kqjkh+b7I8GJaV+jmIAgAADSQCAAAm4gA==
Date:   Fri, 14 Dec 2018 19:00:07 +0000
Message-ID: <5e96f169-d77d-63d0-11ba-f59f572b0219@arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
 <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
 <20181214182518.GH3505@e103592.cambridge.arm.com>
In-Reply-To: <20181214182518.GH3505@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWLP265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5d::29) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0606;6:gP4PtH4pacCHusHnwwghoCHw2SIT6usGNNulXLQSZrUtLz91K3Ye6g9Ih6rI2Ang9m1cG6+8vuKssHKcyX7uDelhMQSG/PT3Z+cV9AZFHf9Gl7x1XA3gVsv2fi50or/neZ82DjLi1PaD6NuS6l67Kic0OAemZesHZiQRmpVQjTtgztt/iEDPlMKujVq066mN26XCIhK7igMDwtOMe7ufke48PeyiuE0qyEuhMJaPwbdS9gjshevdvJnO/EYdBJfLXL9eUQ9FNcDFG2f8HO1Wb/XbBqFgAQdPxvyRXZKNgdfrNRfxh1viYbt4pO9rA0DC7rrYPsajDToklzZ9wiywv1s8NZjgp7jOGkEZZEGKcuR+kpdfh+WhnQwHsbzOswMOn0Elz/Jr7oUxIwaFEzK5hnZixHNKN4gdo94CueyVQEIkpLV3hZtAK+142fj9UUZtoTLc4MzK+q1ADzM7ak/mSQ==;5:RHCClX3VvKx6gNwng5tfMqplp2FknXhf0t2VnCfTfJ0Hn1u1oeLtiiY86HdY6bRWgyFFNGfJ2Xnmi9eoCiwe+3+p5SJsAo9stfPgx4/ICadVxug0+JhM2sNvsvMRPj71SpRkv0uMCaO//GwN3fjuknJmFN/hRQPhGiaIQs17VV8=;7:PVHLqcWzEzv6qhs+NU6ADnb8iR3pu04gb7UqoN2j9ii9PjGntti1kSsP9r2EIp8tHJQaIBTZB6osptizSAtfPaDJ6H/CmWCMw7EULzdxffrAc1eVRXkhWzyi3cUs+mBkNY9I0yfa8LpdycmTMRBZ6g==
x-ms-office365-filtering-correlation-id: d2ef2e46-4731-4c48-d4b1-08d661f65d3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0606;
x-ms-traffictypediagnostic: VI1PR08MB0606:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB06060E6A41FAAAB60ADEC302EDA10@VI1PR08MB0606.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB0606;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0606;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(8936002)(44832011)(65806001)(6512007)(305945005)(36756003)(65956001)(99286004)(316002)(3846002)(476003)(6116002)(6246003)(37006003)(58126008)(54906003)(97736004)(6862004)(81156014)(81166006)(7736002)(64126003)(66066001)(486006)(8676002)(25786009)(72206003)(2906002)(6306002)(106356001)(68736007)(31686004)(14454004)(53936002)(2616005)(6636002)(6436002)(102836004)(229853002)(446003)(5660300001)(26005)(11346002)(386003)(256004)(478600001)(966005)(6506007)(53546011)(71190400001)(6486002)(31696002)(65826007)(186003)(4326008)(105586002)(86362001)(71200400001)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0606;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JEE00f9qaOTSViNfledXuqjNWjH6zGMSi+U6DjFzWL4CukGOoVwVLzrVALRqf25XL4xjx+hUw008f2zCLRESNhN58NMHqmRiYKCk1HAXwuJvETbs1+GqqmXbM2K/rSwsn8As7whao92rRMv5hwib/5wM/Z7foYzkfJQmkV3BUsqAl7SURWCh+apl78LkdC4dj0AJSKNrUyPrZ8fy9gbRlMHpHpde9Z5YwaHkQ9Z9sJuAYlKMZeECoTeMTPmR26faWzhQu0nEAajpJZxGMsqnVxYxWePNt1AB0ReM8RAN+e2NlgkTtl8HsTrTnA/ZUpe0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6414EBAE69F4943B17087E30D14DFF8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ef2e46-4731-4c48-d4b1-08d661f65d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 19:00:07.8760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMTIvMjAxOCAxODoyNSwgRGF2ZSBNYXJ0aW4gd3JvdGU6DQo+IE9uIEZyaSwgRGVjIDE0
LCAyMDE4IGF0IDA2OjEzOjMzUE0gKzAwMDAsIFN6YWJvbGNzIE5hZ3kgd3JvdGU6DQo+PiBPbiAx
MS8xMi8yMDE4IDE5OjI2LCBEYXZlIE1hcnRpbiB3cm90ZToNCj4+PiBUaGlzIHBhdGNoIHJlZmFj
dG9ycyB0aGUgVUFQSSBoZWFkZXIgZGVmaW5pdGlvbnMgZm9yIHRoZSBBcm0gU1ZFDQo+Pj4gZXh0
ZW5zaW9uIHRvIGF2b2lkIG11bHRpcGxlLWRlZmluaXRpb24gcHJvYmxlbXMgd2hlbiB1c2Vyc3Bh
Y2UgbWl4ZXMgaXRzDQo+Pj4gb3duIHNpZ2NvbnRleHQuaCBkZWZpbml0aW9ucyB3aXRoIHRoZSBr
ZXJuZWwncyBwdHJhY2UuaCAod2hpY2ggaXMNCj4+PiBhcHBhcmVudGx5IHJvdXRpbmUpLg0KPj4+
DQo+Pj4gQSBjb21tb24gYmFja2VuZCBoZWFkZXIgaXMgY3JlYXRlZCB0byBob2xkIGNvbW1vbiBk
ZWZpbml0aW9ucywgc3VpdGFibHkNCj4+PiBuYW1lc3BhY2VkLCBhbmQgd2l0aCBhbiBhcHByb3By
aWF0ZSBoZWFkZXIgZ3VhcmQuDQo+Pj4NCj4+PiBTZWUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIHBh
dGNoIDMgZm9yIGZ1cnRoZXIgZXhwbGFuYXRpb24gb2Ygd2h5IHRoaXMNCj4+PiBpcyBuZWVkZWQu
DQo+Pj4NCj4+PiBCZWNhdXNlIG9mIHRoZSBub24tdHJpdmlhbCBoZWFkZXIgZ3VhcmQgaW4gdGhl
IG5ldyBzdmVfY29udGV4dC5oLCBwYXRjaA0KPj4+IDEgYWRkcyBzdXBwb3J0IHRvIGhlYWRlcnNf
aW5zdGFsbC5zaCB0byBtdW5nZSAjaWYgZGVmaW5lZChfVUFQSV9GT08pIGluDQo+Pj4gYSBzaW1p
bGFyIHdheSB0byB0aGUgY3VycmVudCBoYW5kbGluZyBvZiAjaWZuZGVmIF9VQVBJX0ZPTy4NCj4+
Pg0KPj4NCj4+IHRoYW5rcyBmb3IgZG9pbmcgdGhpcy4NCj4+DQo+PiB0aGUgcGF0Y2hlcyBmaXgg
dGhlIGdkYiBidWlsZCBpc3N1ZSBvbiBtdXNsIGxpYmMgd2l0aCBhbg0KPj4gYWRkaXRpb25hbCBn
ZGIgcGF0Y2g6DQo+PiBodHRwczovL3NvdXJjZXdhcmUub3JnL21sL2dkYi1wYXRjaGVzLzIwMTgt
MTIvbXNnMDAxNTIuaHRtbA0KPj4gKGluIHVzZXJzcGFjZSBpJ2QgZXhwZWN0IHVzZXJzIHJlbHlp
bmcgb24gc2lnbmFsLmggcHJvdmlkaW5nDQo+PiB3aGF0ZXZlciBpcyBpbiBhc20vc2lnY29udGV4
dC5oLikNCj4+DQo+PiBpIHRoaW5rIHN2ZV9jb250ZXh0LmggY291bGQgYmUgbWFkZSB0byB3b3Jr
IHdpdGggZGlyZWN0IGluY2x1ZGUsDQo+PiBldmVuIGlmIHRoYXQncyBub3QgdXNlZnVsIGJlY2F1
c2UgdGhlcmUgaXMgbm8gcHVibGljIGFwaSB0aGVyZS4NCj4+IChhbmQgdGhlbiB5b3UgZG9udCBu
ZWVkIHRoZSBmaXJzdCBwYXRjaCkNCj4gDQo+IE15IGdlbmVyYWwgdmlldyBpcyB0aGF0IGlmIHlv
dSB3YW50IHRoZSBzaWdmcmFtZSB0eXBlcyB1c2Vyc3BhY2Ugc2hvdWxkDQo+IHVzdWFsbHkgaW5j
bHVkZSA8dWNvbnRleHQuaD4gYW5kIHJlZmVyIHRvIG1jb250ZXh0X3QuDQo+IA0KDQp1Y29udGV4
dC5oIGRvZXMgbm90IGV4cG9zZSB0aGUgYXNtL3NpZ2NvbnRleHQuaCB0eXBlcyBpbiBnbGliYywN
CmJ1dCBpdCBpcyBjb21wYXRpYmxlIHdpdGggdGhlIGluY2x1c2lvbiBvZiBhc20vc2lnY29udGV4
dC5oDQoob3Igc2lnbmFsLmgpLg0KDQppbiBtdXNsIHVjb250ZXh0LmggaW5jbHVkZXMgc2lnbmFs
LmggYW5kIHNpZ25hbC5oIHByb3ZpZGVzDQp0aGUgYXNtL3NpZ2NvbnRleHQuaCBhcGkgd2l0aCBh
YmkgY29tcGF0aWJsZSBkZWZpbml0aW9ucy4NCg0KPiBCZWNhdXNlIHRoZSBwcm90b3R5cGUgZm9y
IHNhX3NpZ2FjdGlvbigpIHNwZWNpZmllcyBhIHZvaWQgKiBmb3IgdGhlDQo+IHVjb250ZXh0IGFy
Z3VtZW50LCBJJ3ZlIGdlbmVyYWxseSBhc3N1bWVkIHRoYXQgPHNpZ25hbC5oPiBpcyBub3QNCj4g
c3VmZmljaWVudCB0byBnZXQgdWNvbnRleHRfdCAob3IgbWNvbnRleHRfdCkgKGJ1dCBtYXliZSBJ
J20gdG9vIHBhcmFub2lkDQo+IHRoZXJlKS4NCg0KaHR0cDovL3B1YnMub3Blbmdyb3VwLm9yZy9v
bmxpbmVwdWJzLzk2OTk5MTk3OTkvYmFzZWRlZnMvc2lnbmFsLmguaHRtbA0KDQoiVGhlIDxzaWdu
YWwuaD4gaGVhZGVyIHNoYWxsIGRlZmluZSB0aGUgdWNvbnRleHRfdCB0eXBlIGFzIGEgc3RydWN0
dXJlDQogdGhhdCBzaGFsbCBpbmNsdWRlIGF0IGxlYXN0IHRoZSBmb2xsb3dpbmcgbWVtYmVyczoN
Ci4uLg0KIG1jb250ZXh0X3QgIHVjX21jb250ZXh0IEEgbWFjaGluZS1zcGVjaWZpYyByZXByZXNl
bnRhdGlvbiBvZiB0aGUgc2F2ZWQNCiAgICAgICAgICAgICBjb250ZXh0LiINCg0Kc28gc2lnbmFs
LmggbXVzdCBkZWZpbmUgdWNvbnRleHRfdCBidXQgbWNvbnRleHRfdCBjYW4gYmUgb3BhcXVlLg0K
KGl0IGlzIG9wYXF1ZSB3aXRoIHBvc2l4IGNvbmZvcm0gZmVhdHVyZSB0ZXN0cyB0byBhdm9pZA0K
bmFtZXNwYWNlIHBvbGx1dGlvbiwgYnV0IHdpdGggX0dOVV9TT1VSQ0UgZGVmaW5lZCBhbGwNCmFz
bS9zaWdjb250ZXh0LmggYXBpcyBhcmUgdGhlcmUgYW5kIG1jb250ZXh0X3QgbWF0Y2hlcw0Kc3Ry
dWN0IHNpZ2NvbnRleHQpDQoNCj4gDQo+IE5vbi1QT1NJWC1mbGF2b3VyZWQgc29mdHdhcmUgbWln
aHQgaW5jbHVkZSA8YXNtL3NpZ2NvbnRleHQuaD4gZGlyZWN0bHkuDQo+IEluIGdsaWJjL211c2wg
bGliYyB3aWxsIHRoYXQgY29uZmxpY3Qgd2l0aCA8c2lnbmFsLmg+LCBvciBjYW4gdGhlIHR3bw0K
PiBjb2V4aXN0Pw0KDQppZiB5b3UgY29tcGlsZSBlLmcgaW4gc3RhbmRhcmQgY29uZm9ybSBtb2Rl
IHRoZW4NCmkgdGhpbmsgc2lnbmFsLmggYW5kIGFzbS9zaWdjb250ZXh0LmggYXJlIGNvbXBhdGli
bGUuDQoNCj4gDQo+IENoZWVycw0KPiAtLS1EYXZlDQo+IA0KDQo=
