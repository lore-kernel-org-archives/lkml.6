Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CDC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590FC218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KuHzHjN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbfAaQxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:53:33 -0500
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:36635
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388687AbfAaQxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PBIbp2JX8VrQQThHopKF9j70qgjvb+LiZ+OXraA3jc=;
 b=KuHzHjN0apu8YUxFPjKgmxcyq1t9gaeFVJhMMHWaQiTp3l0AVB9rHxuSUdxMFpIhbAkni7/9WTI8gvKqC6duQXI2q5tFDa59oRXIIcB8381DZgaOuPVkAx0tyGTM8mJyfqfN0c3YSMsObTsu39RRO9Ponh90DP80Fx89sdS47zo=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB4518.eurprd05.prod.outlook.com (10.168.25.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:53:27 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:53:27 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v1 1/1] platform/mellanox: Add bootctl driver for
 Mellanox BlueField Soc
Thread-Index: AQHUuBWSgorN9Oha0kyXFJVXsER32KXGzLEAgAE3meCAAE3cgIABKbWg
Date:   Thu, 31 Jan 2019 16:53:27 +0000
Message-ID: <DB6PR05MB3223132246F702D41F7399ECA1910@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <CAHp75VfpmBMmR_zU8JxN3Apb__QyWXyU9wD8e03z0N3TTRpMYg@mail.gmail.com>
 <DB6PR05MB32230728A361BD68D14D7B69A1900@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <CAHp75VcsYsxSfUT6Sc9-59gXaQRXs0ugpPRAvAzFr2+DYJHeCg@mail.gmail.com>
In-Reply-To: <CAHp75VcsYsxSfUT6Sc9-59gXaQRXs0ugpPRAvAzFr2+DYJHeCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB4518;6:pQVaVWbHRxFZf35GI7KZK9Eu2ibtv5GvDOrcKL+YeARhY8eJmxeXLafR1VJton0wu6bwjho0x7tu/uw6j5iGEslku/qfnjMInEhmoNQgVAJuiC5YHw+9nnrqPn4hAMWF6PrZi2mWC6zYTqlPmRGSLAZf2LTuWr+Zq6h0vCfxX9PK+wnOfcuCNnJkVMhK3zY/JvmR/5pQRZ0upa5rvXuqfVMbIKKODflqDPfpbmXN32MJisD4Wzipmn9NFJPFPyffF3oULZFyqSDmPDFCkqWkS1/BFcz2dFT+K7CZ0qZWU8FcIiKs04Wx3lm00S7NHjuIQdjQEr99mYXMKqW9Q3AZnIkMQCFoavk5JjMPYnpiTWydZw7cDbeV76Wjkre2MG2lMwiAqgEztkXMtL73F9EATYDAiJLFq/tEl6/tScvoH7W4dExMAz+k5Ed1GPsf0u9mHDw6xgdOcLB36httzqjbGw==;5:DVgq/xmOdU3rq3tqrEjgHmTWh0Kp/1yjRz/U5JCHy9kuX2xfmvez+xHaeEKFxFMCtwNsrZhyTjv9FsO+25FK3ENOuQbtOpcfqs/IVSLilAvJxrDILG/0lZc44qzCGDI58uAVlfgo62dgUVTQ9PDUUByna2A3TEi5C4xXaiSyc4kiCDJusHsnrEriwW7tnoEgIqLEjcV/wUw2+ntuVNmsjQ==;7:AAwPo3xC81zq+CLQJDNtrEw9PBDUCypAvtjIGDl7gx0ohVelAlCbcSPCVOPkCnZguDpWWsII8rDbYGmn6YgKKQaKepet7S/WzR+kqC2Gio2OgFX1Ej3h248GNSP4zQV5PqVItwGem1yuS29bcgA2zw==
x-ms-office365-filtering-correlation-id: 7aa2ebcd-736f-4be4-70a1-08d6879c9f3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4518;
x-ms-traffictypediagnostic: DB6PR05MB4518:
x-microsoft-antispam-prvs: <DB6PR05MB4518C70D230574CBBF1E68FFA1910@DB6PR05MB4518.eurprd05.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(13464003)(51914003)(199004)(189003)(106356001)(68736007)(86362001)(25786009)(476003)(39060400002)(54906003)(11346002)(105586002)(71200400001)(71190400001)(76176011)(99286004)(4326008)(33656002)(486006)(446003)(97736004)(102836004)(53546011)(6116002)(66066001)(7696005)(3846002)(316002)(26005)(186003)(6506007)(6916009)(7736002)(9686003)(81166006)(81156014)(6246003)(74316002)(93886005)(6436002)(8676002)(2906002)(55016002)(8936002)(305945005)(229853002)(53936002)(14454004)(478600001)(14444005)(256004)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4518;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 61/JVzDtdYGVmDAeH4nfqWxXOSiXv+5CMWsqeXCa27W1Y8/kSsSpTo++QxnvR1/UNnNKnOoDvcQJ/2JW3sIbMuuurT695zmpBZL4pSBExdr75Yle98/yUgzGNP7cfmAwtptq4cYa4ORuGUXXopUwbPLjaSKZTFJd+7iRdHvtVU7EpGD8xhestty0P7FhyG1ZUf2zkptRiTIJGcu4ob4zzHF97VDeCDNgpiaZuAws7rBkpMVRtQOGnepOC5KbhR/mI4yRSZVcUMLg3Sjwj/B4y8hm6YhDdaGKa9/x+YvU969s1l1yoInal3N+JJxMRKZtulZdq8Vb07SMrHg0hcdLaQ/xTRcwG0OPVedAYJugZJfXlYNGmEbfoih8B5r9stEDfeEJdIUkhRNNSFQzynkyGYq5rUpiRk1GIFX2kNrQqIA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa2ebcd-736f-4be4-70a1-08d6879c9f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:53:27.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzISAgdjIgaGFzIGJlZW4gcG9zdGVkIHRyeWluZyB0byBzb2x2ZSBhbGwgdGhlIGNvbW1l
bnRzLiBQbGVhc2UgYWxzbyBzZWUgcmVzcG9uc2UgaW5saW5lLg0KDQpSZWdhcmRzLA0KTGltaW5n
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkg
MzAsIDIwMTkgNDoxNyBQTQ0KPiBUbzogTGltaW5nIFN1biA8bHN1bkBtZWxsYW5veC5jb20+DQo+
IENjOiBBbmR5IFNoZXZjaGVua28gPGFuZHlAaW5mcmFkZWFkLm9yZz47IERhcnJlbiBIYXJ0IDxk
dmhhcnRAaW5mcmFkZWFkLm9yZz47IFZhZGltIFBhc3Rlcm5hayA8dmFkaW1wQG1lbGxhbm94LmNv
bT47IERhdmlkDQo+IFdvb2RzIDxkd29vZHNAbWVsbGFub3guY29tPjsgUGxhdGZvcm0gRHJpdmVy
IDxwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWls
aW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxIDEvMV0gcGxhdGZvcm0vbWVsbGFub3g6IEFkZCBib290Y3RsIGRyaXZlciBm
b3IgTWVsbGFub3ggQmx1ZUZpZWxkIFNvYw0KPiANCj4gT24gV2VkLCBKYW4gMzAsIDIwMTkgYXQg
MTA6NDcgUE0gTGltaW5nIFN1biA8bHN1bkBtZWxsYW5veC5jb20+IHdyb3RlOg0KPiANCj4gPiA+
IEZpcnN0IG9mIGFsbCwgaXMgaXQgYSByZWFsIHdhdGNoZG9nIHdpdGggYSBkcml2ZXI/IEkgdGhp
bmsgd2F0Y2hkb2cgaW4NCj4gPiA+IHRoYXQgY2FzZSBzaG91bGQgYmUgc2V0IHVwIHRocm91Z2gg
c3RhbmRhcmQgd2F0Y2hkb2cgZmFjaWxpdGllcy4NCj4gPg0KPiA+IFRoaXMgaXMgbm90IGEgd2F0
Y2hkb2cgZHJpdmVyIGl0c2VsZi4gSW5zdGVhZCwgaXQgcHJvdmlkZXMgaW50ZXJmYWNlIHRvDQo+
ID4gdXNlci1zcGFjZSBhbmQgdXNlIEFSTSBTTUMgY2FsbHMgdG8gQVRGIHRvIGNvbmZpZ3VyZSBy
ZWdpc3RlcnMgYW5kDQo+ID4gd2F0Y2hkb2cuIEknbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2Fn
ZSBpbiB2MiB0byBjbGFyaWZ5IGl0Lg0KPiANCj4gSG1tLi4uIEZvciBleGFtcGxlIEludGVsIE1J
RCBwbGF0Zm9ybXMgaGF2ZSBTQ1UgKHN5c3RlbSBjb250cm9sbGVyDQo+IHVuaXQpIHRoYXQgcHJv
dmlkZXMgYSB3YXRjaGRvZyBmYWNpbGl0eS4gSW4gdGhlIGtlcm5lbCB3ZSBoYXZlIGENCj4gd2F0
Y2hkb2cgZHJpdmVyIGZvciB0aGF0Lg0KPiBDYW4ndCB5b3UgZG8gc2ltaWxhciBmb3IgeW91ciBj
YXNlPw0KDQpUaGUgcHJvY2VzcyBtaWdodCBiZSBkaWZmZXJlbnQgdGhhbiB3aGF0J3MgZG9uZSBv
biB0aGUgQmx1ZUZpZWxkIFNvQy4NCg0KQWZ0ZXIgdGhlIGJvb3QtcGFydGl0aW9uIHN3YXBwaW5n
LCB0aGUgQVJNIHdhdGNoZG9nIGlzIG5vdCBzdGFydGVkDQpyaWdodCBhd2F5LiBJdCBpcyBzdGFy
dGVkIGR1cmluZyBuZXh0IHJlYm9vdGluZyBieSB0aGUgQVRGIEJMMSBjb2RlIA0KKHdoaWNoIGlz
IHRoZSBCb290IFJPTSBjb2RlIHRoYW4gY291bGRuJ3QgY2hhbmdlKS4gVGhlIEJvb3QtUk9NIA0K
Y2hlY2tzIHNvbWUgcmVnaXN0ZXIgdmFsdWUgd2hpY2ggaXMgcHJlc2VydmVkIGR1cmluZyByZWJv
b3RpbmcsIGFuZCANCmtub3dzIHRoYXQgYSBib290LXBhcnRpdGlvbiBzd2FwcGluZyBpcyBpbiBw
cm9jZXNzLCB0aHVzIGVuYWJsZSB0aGUgDQp3YXRjaGRvZyB0aW1lciBpZiBjb25maWd1cmVkLiBB
dCB0aGlzIHRpbWUsIG5vIFVFRkkgb3IgTGludXggaXMgcnVubmluZywgDQpqdXN0IHRoZSBib290
IFJPTSBjb2RlIGF0IHRoZSB2ZXJ5IGJlZ2lubmluZy4NCg0KSSdsbCBhZGQgdGhlIHNlcXVlbmNl
IG9mIHN1Y2ggdXNlIGNhc2UgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIG9mIHYyLg0KDQo+IA0KPiA+
ID4gPiArICAgICAgIGlmIChtbHhiZl9ib290Y3RsX3NtY19jYWxsMShNTFhCRl9CT09UQ1RMX1NF
VF9QT1NUX1JFU0VUX1dET0csDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHdhdGNoZG9nKSA8IDApDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4gPiA+DQo+ID4gPiBJZiB0aGF0IGNhbGwgcmV0dXJucyBhbiBlcnJvciBpdCBzaG91
bGRuJ3QgYmUgc2hhZG93ZWQgaGVyZS4NCj4gPg0KPiA+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0
aGlzIGNvbW1lbnQgY29ycmVjdGx5IG9yIG5vdC4NCj4gPiBUaGlzIGZ1bmN0aW9uIGlzIGRlZmlu
ZWQgYnkgRFJJVkVSX0FUVFJfUlcoKSwgd2hpY2ggYXBwZWFycyB0byBleHBlY3QNCj4gPiBzc2l6
ZV90IG9yIGFuIGVycm9yIGNvZGUgYXMgcmV0dXJuIHZhbHVlIGFjY29yZGluZyB0byBvdGhlciBl
eGFtcGxlcyBJIHNhdy4NCj4gDQo+IFdoYXQgaXMgcmV0dXJuZWQgYnkgbWx4Li4uY2FsbDEoKSBz
aG91bGQgYmUgcHJvcGFnYXRlZCB0byB0aGUgYWN0dWFsIGNhbGxlci4NCj4gU2FtZSBjb21tZW50
IGZvciBhbGwgc2ltaWxhciBjYXNlcy4NCg0KTWFrZSBzZW5zZSEgVGhhbmtzIGZvciB0aGUgZXhw
bGFuYXRpb24uIFVwZGF0ZWQgaXQgaW4gdjIuDQoNCj4gDQo+ID4gPiA+ICsgICAgICAgbGNfc3Rh
dGUgJj0gKE1MWEJGX0JPT1RDVExfU0JfTU9ERV9URVNUX01BU0sgfA0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICBNTFhCRl9CT09UQ1RMX1NCX01PREVfU0VDVVJFX01BU0spOw0KPiA+ID4N
Cj4gPiA+IEJldHRlciB0byBzcGxpdCBsaWtlDQo+ID4gPg0KPiA+ID4geHh4ID0NCj4gPiA+ICAo
QSB8IEIpOw0KPiA+DQo+ID4gSXQgc2VlbXMgaGFyZCB0byBkbyAiKEEgfCBCKTsiIHdpdGhpbiA4
MCBjaGFyYWN0ZXJzIHBsdXMgdGhlIGluZGVudHMuDQo+IA0KPiBSZXBlYXRpbmcgbXlzZWxmLCBp
dCdzIHN0aWxsIGJldHRlciB0aGFuIHlvdXIgdmFyaWFudCBmb3IgcmVhZGFiaWxpdHkuDQoNCkRv
bmUuIE1hbmFnZWQgdG8gc2hvcnRlbiB0aGUgdmFyaWFibGUgbmFtZSBhIGxpdHRsZSBiaXQuDQpV
cGRhdGVkIGl0IGluIHYyLg0KDQo+IA0KPiA+ID4gPiArICAgICAgIGlmIChyZXMuYTAgIT0gMHg4
OWMwMzZiNCB8fCByZXMuYTEgIT0gMHgxMWU2ZTdkNyB8fA0KPiA+ID4gPiArICAgICAgICAgICBy
ZXMuYTIgIT0gMHgxYTAwOTc4NyB8fCByZXMuYTMgIT0gMHhjNGJmMDBjYSkNCj4gPiA+DQo+ID4g
PiBXaGF0IGlzIHRoaXM/IQ0KPiA+ID4NCj4gPiA+IENhbiB5b3UgdXNlIFVVSUQgQVBJPw0KPiA+
DQo+ID4gWWVzLCBpdCBpcyBVVUlEIGNvbXBhcmlzb24uIFRoZSBTTUMgY2FsbCByZXR1cm5zIGZv
dXIgJ3Vuc2lnbmVkIGxvbmcnIGZyb20gQVRGDQo+ID4gdG8gcmVwcmVzZW50IHRoZSBVVUlELiBU
aGVyZSBzZWVtcyBubyBleGlzdGluZyBBUElzIGluIHVhcGkvbGludXgvdXVpZC5oIHRvDQo+ID4g
Y29tcGFyZSBzdWNoIHNwZWNpYWwgZm9ybWF0LiBIb3cgYWJvdXQgcmVwbGFjaW5nIGl0IHdpdGgg
Y29tbWVudCBhbmQgTUFDUk9zDQo+ID4gaW5zdGVhZCBvZiB0aGUgaGFyZGNvZGVkIHZhbHVlcyB0
byBtYWtlIGl0IG1vcmUgcmVhZGFibGU/DQo+IA0KPiBTaG91bGQgYmUgbm8gbWFnaWMgbnVtYmVy
cyBpbnZvbHZlZCBpbnNpZGUgdGhlIGZ1bmN0aW9uIGF0IHRoZSBlbmQuDQo+IFVzZSBkZXNjcmlw
dGl2ZSBkZWZpbml0aW9ucyBhbmQgSSBzdGlsbCByZWNvbW1lbmQgdG8gZ2l2ZSBhIGxvb2sgYXQN
Cj4gVVVJRCBBUEkgaG93IGl0IGNhbiBiZSB1dGlsaXplZCBoZXJlLg0KPiAoaGludDogVGh1bmRl
cmJvbHQgaHcgaXMgb3BlcmF0aW5nIHdpdGggaW50ZWdlcnMsIHRob3VnaCBkcml2ZXIgdXNlcw0K
PiBVVUlEIEFQSSBhdCB0aGUgZW5kKQ0KPiANCg0KVXBkYXRlZCBpbiB2Mi4gTm93IGl0IHNob3Vs
ZCBsb29rIGJldHRlciA6KQ0KDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCg==
