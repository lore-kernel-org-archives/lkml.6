Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAB8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C5F20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="wWaYXVs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfAaTU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:20:27 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:36386
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfAaTU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk7wkvE2hKpaZb4WpK1mt7Qw3sgYhKeGCop22zq1C/k=;
 b=wWaYXVs9WzxuCVu8x5L0R8n23XaA3nIXnzMUmiRNUGNxb+486pSbrjQRin6nLpE76iRxKT2WrIEyyZf4txSYxyHmdhpdA932Li3SzbP/7Zj1aiuiPHrHJLZpvTd0fWW/dp1VrYYpNdx1clscyXeymxmCAt4WF/rhJebxMbevBMs=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3463.eurprd05.prod.outlook.com (10.175.233.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Thu, 31 Jan 2019 19:20:21 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 19:20:21 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v2] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Index: AQHUuYV/ZdouKCwE60m/C1lyrX9NOaXJmmYAgAAB23CAACSVUA==
Date:   Thu, 31 Jan 2019 19:20:20 +0000
Message-ID: <DB6PR05MB32234336D53E88B2D81D1434A1910@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1548953587-12719-1-git-send-email-lsun@mellanox.com>
 <CAHp75Vfr7+NONzthw=E77BqLb06=wgfmNqu7D01fkcNQMqUCsQ@mail.gmail.com>
 <DB6PR05MB3223E95170C064869591118AA1910@DB6PR05MB3223.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB3223E95170C064869591118AA1910@DB6PR05MB3223.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB3463;6:p8ivfqBiaD/25iQaOFDwPlE3vB23LZgHJBeVm57hMn3dNilM8tKRk9+kxgjepeGU4MZcXmoXgIQR8H7aTSrCAx9goHD0NGT7yZSLjva+Xs9i/xyaHjsIyiTe+VqyEqNP+gTGrrkH3ZYqA+e6NfcZxttZL3zLxWmubdz9sJwbzsY1FSgQVZ7UUPobZshM53sOL2fVD2R+e7zg0GxXV/nE5ykhmBCcp/O/h1Vhsz/UkIFOAIfvCRSXGlp3zXDtznBcQayLnmcwEH+jFiDcTyJ0ta1St2K77QDLkRVwjXZg10pBx4ugQaEYHy4IEk8C7R5f7JIqsnvkKvWb3svhxy0bsPFaD8IpY6Da2KYzb7BXyP+Gr4c0FNUGXtiuWTDI4BPUvx3TDAstYh3m5XW//YWWrytYHYcKuMj6+YNL/AkX0Btcn0GVjOEiizzzmquJGSN96Dy4j6UjckFmB4wZkLumtw==;5:JOD8slyc70MSZHHQNxh7K5KqeN6Hv03bWAUsTSxd9XOqvxVTQE4qSJ88ccr/rqyKLogW47GhLSK3m1/wxQ+O6RTQlA1XDRgsKbOk5yKsr92Ke8tmTdGyHrMR1FRyzKWXLCw35LMHnwF59W3s5MmBNvKPAvO2Rw1DDcVK/3BvM4d8ghWGVsN2ieEFGLYLJtZA81fdYuVe4ARIK9K2nzg+8w==;7:ySCwNP/2Dl52+eTQX5K0c6zG9aamMJAVvBZwWREOxWipQPBZQaNoiXByKjR/o+eIm6Z0oHhF8whrucCFnE3b/KxGt7A3bX741SRZNemooixDpAviI37kZQ4XVGZQG9WENHsARrWU7hxKLc6/9o43sA==
x-ms-office365-filtering-correlation-id: ce5d7dda-e5e5-4010-a3c8-08d687b1247a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3463;
x-ms-traffictypediagnostic: DB6PR05MB3463:
x-microsoft-antispam-prvs: <DB6PR05MB3463E58B73BF2EE48DEF349BA1910@DB6PR05MB3463.eurprd05.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(13464003)(54534003)(7736002)(316002)(6436002)(476003)(6916009)(11346002)(71190400001)(33656002)(8936002)(229853002)(93156006)(9686003)(305945005)(68736007)(26005)(55016002)(8676002)(81156014)(81166006)(105586002)(14444005)(256004)(71200400001)(446003)(76176011)(4326008)(25786009)(106356001)(7696005)(66066001)(6246003)(486006)(102836004)(2940100002)(53936002)(74316002)(6506007)(3846002)(99286004)(39060400002)(53546011)(86362001)(54906003)(2906002)(186003)(6116002)(14454004)(93886005)(478600001)(97736004)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3463;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v6Idb3pTjwp4VP/2J1qEqoA6NU/jkFRZBzhubt3NOktJmWZ03+UFdt2dEsMXOPpBwPbnCbnIXCsrQ6C0k8erdSKXgjOhLofxfpJZQruYhn7qSLp/5dmG09w2DtU2nAs1upPAbK/DJxC+JNVHB/i7FCcR0hTM8vqA+g1Kfk/E9mo1/EPpjv15cO3O3EihqJpy2/tESAcNlKA2uknq5mHjn7fFArlZPCma9On6NjZcG82q55mNopnS+PA3mz54YKwqoQGwG2gNZKaSYEKLH3hTKaIOKtlrtwWX4DMaKZxu0FFworyBW5W8scAcQEOt3wCPVxwBVkAz59d4xGLibBCIzt6evZG/iS3wAP308kfuWM5XOEbL0kdpXp7fNuVTPgRCz9g3b6ZBqE6vmRs1u4bzVoWcuTqEXUTiYZvfB39FY8k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5d7dda-e5e5-4010-a3c8-08d687b1247a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 19:20:20.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djMgaGFzIGJlZW4gcG9zdGVkIHdpdGggQ2hhbmdlbG9nIGFkZGVkLg0KDQpUaGFua3MhDQpMaW1p
bmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1pbmcgU3VuDQo+
IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDMxLCAyMDE5IDEyOjE4IFBNDQo+IFRvOiAnQW5keSBT
aGV2Y2hlbmtvJyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gQ2M6IEFuZHkgU2hldmNo
ZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPjsgRGFycmVuIEhhcnQgPGR2aGFydEBpbmZyYWRlYWQu
b3JnPjsgVmFkaW0gUGFzdGVybmFrIDx2YWRpbXBAbWVsbGFub3guY29tPjsgRGF2aWQNCj4gV29v
ZHMgPGR3b29kc0BtZWxsYW5veC5jb20+OyBQbGF0Zm9ybSBEcml2ZXIgPHBsYXRmb3JtLWRyaXZl
ci14ODZAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjJdIHBs
YXRmb3JtL21lbGxhbm94OiBBZGQgYm9vdGN0bCBkcml2ZXIgZm9yIE1lbGxhbm94IEJsdWVGaWVs
ZCBTb2MNCj4gDQo+IFBsZWFzZSBzZWUgbXkgcmVzcG9uc2UgaW5saW5lLiBXaWxsIHByb3ZpZGUg
djMgb25jZSBJIHNvbHZlIHRoZSBjb21tZW50cy4NCj4gDQo+IFRoYW5rcywNCj4gTGltaW5nDQo+
IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQW5keSBTaGV2Y2hl
bmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBKYW51
YXJ5IDMxLCAyMDE5IDEyOjAyIFBNDQo+ID4gVG86IExpbWluZyBTdW4gPGxzdW5AbWVsbGFub3gu
Y29tPg0KPiA+IENjOiBBbmR5IFNoZXZjaGVua28gPGFuZHlAaW5mcmFkZWFkLm9yZz47IERhcnJl
biBIYXJ0IDxkdmhhcnRAaW5mcmFkZWFkLm9yZz47IFZhZGltIFBhc3Rlcm5hayA8dmFkaW1wQG1l
bGxhbm94LmNvbT47DQo+IERhdmlkDQo+ID4gV29vZHMgPGR3b29kc0BtZWxsYW5veC5jb20+OyBQ
bGF0Zm9ybSBEcml2ZXIgPHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnPjsgTGlu
dXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+ID4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zz4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBwbGF0Zm9ybS9tZWxsYW5veDogQWRkIGJv
b3RjdGwgZHJpdmVyIGZvciBNZWxsYW5veCBCbHVlRmllbGQgU29jDQo+ID4NCj4gPiBPbiBUaHUs
IEphbiAzMSwgMjAxOSBhdCA2OjUzIFBNIExpbWluZyBTdW4gPGxzdW5AbWVsbGFub3guY29tPiB3
cm90ZToNCj4gPiA+DQo+ID4gPiBUaGlzIGNvbW1pdCBhZGRzIHRoZSBib290Y3RsIHBsYXRmb3Jt
IGRyaXZlciBmb3IgTWVsbGFub3ggQmx1ZUZpZWxkDQo+ID4gPiBTb2MsIHdoaWNoIGNvbnRyb2xz
IHRoZSBlTU1DIGJvb3QgcGFydGl0aW9uIHN3YXBwaW5nIGFuZCBzZW5kcyBTTUMNCj4gPiA+IGNh
bGxzIHRvIEFURiBydW5uaW5nIGF0IGV4Y2VwdGlvbiBsZXZlbCBFTDMgdG8gcHJvZ3JhbSBzb21l
IHN5c3RlbQ0KPiA+ID4gcmVnaXN0ZXIuIFRoaXMgcmVnaXN0ZXIgaXMgb25seSBhY2Nlc3NpYmxl
IGluIHNlY3VyZSBjb2RlIGFuZCBpcw0KPiA+ID4gdXNlZCB0byBlbmFibGUgdGhlIHdhdGNoZG9n
IGFmdGVyIHJlYm9vdC4NCj4gPiA+DQo+ID4gPiBCZWxvdyBhcmUgdGhlIHNlcXVlbmNlcyBvZiBh
IHR5cGljYWwgdXNlIGNhc2UuDQo+ID4gPg0KPiA+ID4gICAxLiBVc2VyLXNwYWNlIHRvb2wgdXBn
cmFkZXMgb25lIGVNTUMgYm9vdCBwYXJ0aXRpb24gYW5kIHJlcXVlc3RzDQo+ID4gPiAgICAgIHRo
ZSBib290IHBhcnRpdGlvbiBzd2FwcGluZzsNCj4gPiA+DQo+ID4gPiAgIDIuIFRoZSBib290Y3Rs
IGRyaXZlciBoYW5kbGVzIHN1Y2ggcmVxdWVzdCBhbmQgc2VuZHMgU01DIGNhbGwNCj4gPiA+ICAg
ICAgdG8gQVRGLiBBVEYgcHJvZ3JhbXMgcmVnaXN0ZXIgQlJFQURDUlVNQjAgd2hpY2ggaGFzIHZh
bHVlDQo+ID4gPiAgICAgIHByZXNlcnZlZCBkdXJpbmcgc29mdHdhcmUgcmVzZXQuIEl0IGFsc28g
cHJvZ3JhbXMgZU1NQyB0bw0KPiA+ID4gICAgICBzd2FwIHRoZSBib290IHBhcnRpdGlvbjsNCj4g
PiA+DQo+ID4gPiAgIDMuIEFmdGVyIHNvZnR3YXJlIHJlc2V0IChyZWJvb3RpbmcpLCBBVEYgQkwx
IChCb290Um9tKSBjaGVja3MNCj4gPiA+ICAgICAgcmVnaXN0ZXIgQlJFQURDUlVNQjAgdG8gZW5h
YmxlIHdhdGNoZG9nIGlmIGNvbmZpZ3VyZWQ7DQo+ID4gPg0KPiA+ID4gICA0LiBJZiBib290aW5n
IGZhaWxzLCB0aGUgd2F0Y2hkb2cgdGltZXIgd2lsbCB0cmlnZ2VyIHJlYm9vdGluZy4NCj4gPiA+
ICAgICAgSW4gc3VjaCBjYXNlLCBBVEYgQm9vdFJvbSB3aWxsIHN3aXRjaCB0aGUgYm9vdCBwYXJ0
aXRpb24NCj4gPiA+ICAgICAgdG8gdGhlIHByZXZpb3VzIG9uZS4NCj4gPg0KPiA+IFRoYW5rcyBm
b3IgYW4gdXBkYXRlLiBNeSBjb21tZW50cyBiZWxvdy4NCj4gPg0KPiA+DQo+ID4gPiBSZXZpZXdl
ZC1ieTogRGF2aWQgV29vZHMgPGR3b29kc0BtZWxsYW5veC5jb20+DQo+ID4NCj4gPiBJJ20gbm90
IHN1cmUgSSBzZWUgdGhpcyBndXkgdG8gcmV2aWV3IHYyLiBPZiBjb3Vyc2UgaWYgeW91IGNvbnNp
ZGVyDQo+ID4gYWxsIGNoYW5nZXMgbWlub3IsIHlvdSBtYXkgbGVhdmUgdGhpcyB0YWcuDQo+IA0K
PiBIZSBzaXRzIGJlc2lkZXMgbWUgZm9yIGludGVybmFsIHJldmlldy4gSSdsbCB0cnkgdG8gYXNr
IGhpbSB0byBzZW5kDQo+IGNvbW1lbnRzIHRvIHRoZSBtYWlsaW5nIGxpc3QuDQo+IA0KPiA+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxsc3VuQG1lbGxhbm94LmNvbT4NCj4gPiA+
IC0tLQ0KPiA+DQo+ID4gSGVyZSBzaG91bGQgYmUgYSBjaGFuZ2Vsb2cgd2hhdCBoYWQgYmVlbiBk
b25lIGluIG5ldyB2ZXJzaW9uLg0KPiANCj4gV2lsbCBwcm92aWRlIGNoYW5nZWxvZyBpbiB0aGUg
djMgZW1haWwuDQo+IE9yIHBsZWFzZSBjb3JyZWN0IG1lIGlmIHlvdSBtZWFudCBhZGRpbmcgY2hh
bmdlbG9nIGluIHRoZSBjb2RlIG9yDQo+IGNvdmVyIGxldHRlci4NCj4gDQo+ID4gPiArLyogVVVJ
RCB1c2VkIHRvIHByb2JlIEFURiBzZXJ2aWNlLiAqLw0KPiA+DQo+ID4gPiArc3RhdGljIGNvbnN0
IGNoYXIgKiBjb25zdCBtbHhiZl9ib290Y3RsX3N2Y191dWlkX3N0ciA9DQo+ID4gPiArICAgICAg
ICI4OWMwMzZiNC1lN2Q3LTExZTYtODc5Ny0wMDFhY2EwMGJmYzQiOw0KPiA+DQo+ID4gc3RhdGlj
IGNvbnN0IGNoYXIgKnh4eCA9IC4uLjsNCj4gDQo+IFdpbGwgdXBkYXRlIGl0IGluIHYzLg0KPiAN
Cj4gPg0KPiA+ID4gKy8qDQo+ID4gPiArICogVVVJRCBzdHJ1Y3R1cmUgdXNlZCB0byBtYXRjaCB0
aGUgcmV0dXJuZWQgdmFsdWUgZnJvbSBBVEYgaW4NCj4gPiA+ICsgKiBmb3VyIDMyLWJpdCB3b3Jk
cy4gTm8gbmVlZCB0byBkbyBlbmRpYW4gY29udmVyc2lvbiBoZXJlLg0KPiA+ID4gKyAqLw0KPiA+
ID4gK3VuaW9uIG1seGJmX2Jvb3RjdGxfdXVpZCB7DQo+ID4gPiArICAgICAgIGd1aWRfdCBndWlk
Ow0KPiA+ID4gKyAgICAgICB1MzIgd29yZHNbNF07DQo+ID4gPiArfTsNCj4gPg0KPiA+IEknbSBu
b3Qgc3VyZSBpdCdzIHRoZSBiZXN0IHlvdSBjYW4gZG8uIGluc3RlYWQgb2YgdXNpbmcgdW5pb24s
IGJldHRlcg0KPiA+IHRvIHVzZSBjb252ZXJzaW9uIGZyb20gYW5kIHRvIGNvcnJlc3BvbmRpbmcg
dXVpZCB0eXBlLg0KPiANCj4gSSdsbCB0cnkgdG8gZmlndXJlIG91dCBhbm90aGVyIHdheSB3aXRo
b3V0IHRoZSB1bmlvbiB0byBjb21wYXJlIHRoZQ0KPiB1dWlkIGRpcmVjdGx5IHVzaW5nIHV1aWQg
YXBpLiBXaWxsIHVwZGF0ZSBpdCBpbiB2My4NCj4gDQo+ID4NCj4gPiBUaGUgcmVzdCBJIHdpbGwg
Y29tbWVudCBvbiB2My4NCj4gPg0KPiA+IC0tDQo+ID4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+ID4g
QW5keSBTaGV2Y2hlbmtvDQo=
