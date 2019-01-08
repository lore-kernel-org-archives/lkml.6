Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AC9C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098732183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WKyrVY2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAHJRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:17:05 -0500
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:50720
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728510AbfAHJRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVi1jWKxdtJHQZQ1S+OspDYwdC+Q6tjnKTR9Z1MuATY=;
 b=WKyrVY2jE8NfUzse+q/X5q78PajvInSN2BLcNPZJ2Q613ErYnSB5RQPVXpbVp8w6xbzVns1QypZpwIQtfhZyvww6HPV/tAfXk2d0GHgwhLPsajGC7atvYC/Qg74H7EqIVLDAsGd2+Kj//ob47kuAW1xKj8MBLriT+tsXFfyW7k4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3802.eurprd04.prod.outlook.com (52.134.71.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 09:16:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:16:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V8] iio: light: isl29018: add vcc regulator operation
 support
Thread-Topic: [PATCH V8] iio: light: isl29018: add vcc regulator operation
 support
Thread-Index: AQHUmos93wSvgiqCGEmCwFK1MbfS4KWhBxUAgAQpfWA=
Date:   Tue, 8 Jan 2019 09:16:57 +0000
Message-ID: <DB3PR0402MB391651EAEE91DA842A33D8C6F58A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1545547310-22203-1-git-send-email-Anson.Huang@nxp.com>
 <20190105174254.49f95395@archlinux>
In-Reply-To: <20190105174254.49f95395@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3802;6:FbZRvenTdLqHP16qbf00OJfCISAn123FyS5wlk+zTvEO1jcHCITB0EIu1qsw4qClTR6HZqn0MrGC1I3//an0i45nV3dMIZrfdEIt3RyVJ9BFkrszOqvP12LMpH9M0R4s9HAqDFwXOH+DfnRsfxqzWnQrvUALu5ZwlyukOnPwWrZVeWMT5iZU4ZLDkqdaMe18lZRqMBKw2v58BytOuIpgJGI4hPfynphMWMHn2JVqL6PfjuDDKPS7E3euHtFBXtC9JQDAScHpYKTjck1Lb1yJxNxfKMNuqZ3/9gIwaWYRp55MmBT8O5Xexx8p2prqB/PMT9sOyFFTfMt/uOukHq2d5nKU4nWkql1zKAXK1cJgPtnU0/xs/MIs95MgtVDD/4JvhQfw/hDLnTJPWegtNIgzfWsxmJZr6g9YG48vsNZDsdNXqSiRXoX0QigVeQwWUd2+rXr2tFy1rLT7bjBVrpJJVQ==;5:RZM3jlKDI44nh0todakbilJhYzauUXixdxuLD1wc3A1I2rV8HnLeiPTt+Es6x7AU8dWEC6M3IPMZ8RG4P8ihM8xk7csbh3PHOf20e4exbt1t+I2MHgdkRI3clutVA3SMDWuJvz64hxsnsKxRVgJK0HkO5u5ggNvOwjKlGCufJUS1QL3XNcPgmHo6OSXpMYxqPWJjiGEsUE30vEuN2u6LdA==;7:0XQvJwGaQpCHS5YRO8AofNVccUr/tZs/gzrPQn6AcX1gFB71ZY0I0X7DrNsS05iqz2Zo2A6mfXWB7n9Gvxf6OfkXeF81LoB1HzhFpGrp7ftr98KNyfDZAmDqnCX3FV44Mo6vDoCWyZY98Dubd6SbTA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 17892e41-6578-4a83-441e-08d6754a0a4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3802;
x-ms-traffictypediagnostic: DB3PR0402MB3802:
x-microsoft-antispam-prvs: <DB3PR0402MB3802B0C9D6F8F48AF343465AF58A0@DB3PR0402MB3802.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3802;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3802;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(54534003)(13464003)(189003)(199004)(76176011)(6506007)(53546011)(68736007)(3846002)(6116002)(7696005)(106356001)(97736004)(256004)(14444005)(5660300001)(25786009)(14454004)(4326008)(6246003)(55016002)(229853002)(486006)(99286004)(33656002)(74316002)(6436002)(44832011)(478600001)(305945005)(6916009)(476003)(81166006)(66066001)(53936002)(71190400001)(71200400001)(8676002)(11346002)(446003)(81156014)(186003)(7736002)(26005)(6346003)(102836004)(8936002)(54906003)(2906002)(9686003)(105586002)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3802;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pKDMpTz/DugasgXU/ywF4r/JB9mZ+kQjIr0+xKrbCLE3nBrr67GLir0RRjDX2UYFa4nMqDh4W9wQtssSiyjbADN5LoX79CVXMJ0hhsCFN/4CHNnPJHpbiVA0CE0eebCe2bego4wZzS9YTADd1nGJLIoZZDp0hbeDZ5lferyWojc48PM1p9dNZ6Nt2vtLdUdPUY3C15D0k9GxzIWLlQAMyvjKTZ4pp6KruNMMTYmVM5Yp2ZlEVD+hYWkBDZ4OrKwUtWL4Sq1IbN/0rqTc/xCVkDr5LDxujaHB+TSVY7C8VVkifhX31ydvQOOCs6J5amV1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17892e41-6578-4a83-441e-08d6754a0a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:16:57.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvbmF0aGFuDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiBbbWFpbHRvOmppYzIz
QGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTnE6jHUwjbI1SAxOjQzDQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IGtuYWFjay5oQGdteC5kZTsgbGFyc0BtZXRh
Zm9vLmRlOyBwbWVlcndAcG1lZXJ3Lm5ldDsNCj4gbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhA
bnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWOF0gaWlvOiBsaWdodDogaXNsMjkwMTg6
IGFkZCB2Y2MgcmVndWxhdG9yIG9wZXJhdGlvbg0KPiBzdXBwb3J0DQo+IA0KPiBPbiBTdW4sIDIz
IERlYyAyMDE4IDA2OjQ2OjMyICswMDAwDQo+IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAu
Y29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIGxpZ2h0IHNlbnNvcidzIHBvd2VyIHN1cHBseSBjb3Vs
ZCBiZSBjb250cm9sbGFibGUgYnkgcmVndWxhdG9yIG9uDQo+ID4gc29tZSBwbGF0Zm9ybXMsIHN1
Y2ggYXMgaS5NWDZRLVNBQlJFU0QgYm9hcmQsIHRoZSBsaWdodCBzZW5zb3INCj4gPiBpc2wyOTAy
MydzIHBvd2VyIHN1cHBseSBpcyBjb250cm9sbGVkIGJ5IGEgR1BJTyBmaXhlZCByZWd1bGF0b3Is
IG5lZWQNCj4gPiB0byBtYWtlIHN1cmUgdGhlIHJlZ3VsYXRvciBpcyBlbmFibGVkIGJlZm9yZSBh
bnkgb3BlcmF0aW9uIG9mIHNlbnNvciwNCj4gPiB0aGlzIHBhdGNoIGFkZHMgdmNjIHJlZ3VsYXRv
ciBvcGVyYXRpb24gc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gT25lIGNvbW1lbnQgaW5saW5lIG9uIGhhbmRs
aW5nIHRoZSBlcnJvciBmcm9tIGRldm1fYWRkX2FjdGlvbi4NCj4gDQo+IEpvbmF0aGFuDQo+IA0K
PiA+IC0tLQ0KPiA+IENoYW5nZUxvZyBTaW5jZSBWNzoNCj4gPiAgICAgLSBtb3ZlIGRldm1fYWRk
X2FjdGlvbiB0byBiZWZvcmUgZGV2bV9yZWdtYXBfaW5pdF9pMmMgY2FsbCB0byBzYXZlDQo+IGNv
ZGUgb2YgZGlzYWJsaW5nIHJlZ3VsYXRvcjsNCj4gPiAgICAgLSBzaW1wbHkgdGhlIGVycm9yIGNo
ZWNrIGxvZ2ljIGluIGlzbDI5MDE4X3N1c3BlbmQuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlv
L2xpZ2h0L2lzbDI5MDE4LmMgfCA0Nw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvaXNs
MjkwMTguYw0KPiA+IGIvZHJpdmVycy9paW8vbGlnaHQvaXNsMjkwMTguYyBpbmRleCBiNDU0MDBm
Li5lYzZjZTg5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L2lzbDI5MDE4LmMN
Cj4gPiArKysgYi9kcml2ZXJzL2lpby9saWdodC9pc2wyOTAxOC5jDQo+ID4gQEAgLTIzLDYgKzIz
LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51
eC9kZWxheS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L2lpby9zeXNmcy5oPg0KPiA+IEBAIC05NSw2ICs5Niw3IEBAIHN0cnVjdCBpc2wyOTAxOF9jaGlw
IHsNCj4gPiAgCXN0cnVjdCBpc2wyOTAxOF9zY2FsZQlzY2FsZTsNCj4gPiAgCWludAkJCXByb3hf
c2NoZW1lOw0KPiA+ICAJYm9vbAkJCXN1c3BlbmRlZDsNCj4gPiArCXN0cnVjdCByZWd1bGF0b3IJ
KnZjY19yZWc7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBpc2wyOTAxOF9zZXRfaW50
ZWdyYXRpb25fdGltZShzdHJ1Y3QgaXNsMjkwMThfY2hpcCAqY2hpcCwNCj4gPiBAQCAtNzA4LDYg
KzcxMCwxNiBAQCBzdGF0aWMgY29uc3QgY2hhcg0KPiAqaXNsMjkwMThfbWF0Y2hfYWNwaV9kZXZp
Y2Uoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgKmRhdGEpDQo+ID4gIAlyZXR1cm4gZGV2X25hbWUo
ZGV2KTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGlzbDI5MDE4X2Rpc2FibGVfcmVn
dWxhdG9yX2FjdGlvbih2b2lkICpfZGF0YSkgew0KPiA+ICsJc3RydWN0IGlzbDI5MDE4X2NoaXAg
KmNoaXAgPSBfZGF0YTsNCj4gPiArCWludCBlcnI7DQo+ID4gKw0KPiA+ICsJZXJyID0gcmVndWxh
dG9yX2Rpc2FibGUoY2hpcC0+dmNjX3JlZyk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCXByX2Vy
cigiZmFpbGVkIHRvIGRpc2FibGUgaXNsMjkwMTgncyBWQ0MgcmVndWxhdG9yIVxuIik7IH0NCj4g
PiArDQo+ID4gIHN0YXRpYyBpbnQgaXNsMjkwMThfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCwNCj4gPiAgCQkJICBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCAqaWQpDQo+ID4gIHsN
Cj4gPiBAQCAtNzQyLDYgKzc1NCwyOCBAQCBzdGF0aWMgaW50IGlzbDI5MDE4X3Byb2JlKHN0cnVj
dCBpMmNfY2xpZW50ICpjbGllbnQsDQo+ID4gIAljaGlwLT5zY2FsZSA9IGlzbDI5MDE4X3NjYWxl
c1tjaGlwLT5pbnRfdGltZV1bMF07DQo+ID4gIAljaGlwLT5zdXNwZW5kZWQgPSBmYWxzZTsNCj4g
Pg0KPiA+ICsJY2hpcC0+dmNjX3JlZyA9IGRldm1fcmVndWxhdG9yX2dldCgmY2xpZW50LT5kZXYs
ICJ2Y2MiKTsNCj4gPiArCWlmIChJU19FUlIoY2hpcC0+dmNjX3JlZykpIHsNCj4gPiArCQllcnIg
PSBQVFJfRVJSKGNoaXAtPnZjY19yZWcpOw0KPiA+ICsJCWlmIChlcnIgIT0gLUVQUk9CRV9ERUZF
UikNCj4gPiArCQkJZGV2X2VycigmY2xpZW50LT5kZXYsICJmYWlsZWQgdG8gZ2V0IFZDQyByZWd1
bGF0b3IhXG4iKTsNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWVy
ciA9IHJlZ3VsYXRvcl9lbmFibGUoY2hpcC0+dmNjX3JlZyk7DQo+ID4gKwlpZiAoZXJyKSB7DQo+
ID4gKwkJZGV2X2VycigmY2xpZW50LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIFZDQyByZWd1bGF0
b3IhXG4iKTsNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWVyciA9
IGRldm1fYWRkX2FjdGlvbigmY2xpZW50LT5kZXYsIGlzbDI5MDE4X2Rpc2FibGVfcmVndWxhdG9y
X2FjdGlvbiwNCj4gPiArCQkJCSBjaGlwKTsNCj4gDQo+IFVzZSBkZXZtX2FkZF9hY3Rpb25fb3Jf
cmVzZXQsIHRoZW4geW91IGRvbid0IG5lZWQgdG8gY2FsbCB0aGUgZGlzYWJsZSBpZiBhbg0KPiBl
cnJvciBvY2N1cnMgaW4gdGhlIGFkZF9hY3Rpb24gcGFydC4uLg0KPiANCj4gPiArCWlmIChlcnIp
IHsNCj4gPiArCQlpc2wyOTAxOF9kaXNhYmxlX3JlZ3VsYXRvcl9hY3Rpb24oY2hpcCk7DQo+IA0K
PiAod2lsbCBnZXQgcmlkIG9mIHRoZSBsaW5lIGFib3ZlKS4NCg0KRG9uZSBpbiBWOSBwYXRjaCwg
cGxlYXNlIGhlbHAgcmV2aWV3LCB0aGFua3MuDQoNCkFuc29uLg0KDQo+IA0KPiA+ICsJCWRldl9l
cnIoJmNsaWVudC0+ZGV2LCAiZmFpbGVkIHRvIHNldHVwIHJlZ3VsYXRvciBjbGVhbnVwIGFjdGlv
biFcbiIpOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJY2hpcC0+
cmVnbWFwID0gZGV2bV9yZWdtYXBfaW5pdF9pMmMoY2xpZW50LA0KPiA+ICAJCQkJaXNsMjkwMThf
Y2hpcF9pbmZvX3RibFtkZXZfaWRdLnJlZ21hcF9jZmcpOw0KPiA+ICAJaWYgKElTX0VSUihjaGlw
LT5yZWdtYXApKSB7DQo+ID4gQEAgLTc2OCw2ICs4MDIsNyBAQCBzdGF0aWMgaW50IGlzbDI5MDE4
X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50DQo+ID4gKmNsaWVudCwgIHN0YXRpYyBpbnQgaXNsMjkw
MThfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpICB7DQo+ID4gIAlzdHJ1Y3QgaXNsMjkwMThf
Y2hpcCAqY2hpcCA9IGlpb19wcml2KGRldl9nZXRfZHJ2ZGF0YShkZXYpKTsNCj4gPiArCWludCBy
ZXQ7DQo+ID4NCj4gPiAgCW11dGV4X2xvY2soJmNoaXAtPmxvY2spOw0KPiA+DQo+ID4gQEAgLTc3
NywxMCArODEyLDEzIEBAIHN0YXRpYyBpbnQgaXNsMjkwMThfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gIAkgKiBTbyB3ZSBkbyBub3QgaGF2ZSBtdWNoIHRvIGRvIGhlcmUuDQo+ID4g
IAkgKi8NCj4gPiAgCWNoaXAtPnN1c3BlbmRlZCA9IHRydWU7DQo+ID4gKwlyZXQgPSByZWd1bGF0
b3JfZGlzYWJsZShjaGlwLT52Y2NfcmVnKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZGV2X2Vy
cihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSBWQ0MgcmVndWxhdG9yXG4iKTsNCj4gPg0KPiA+ICAJ
bXV0ZXhfdW5sb2NrKCZjaGlwLT5sb2NrKTsNCj4gPg0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gKwly
ZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBpc2wyOTAxOF9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KSBAQCAtNzkwLDYgKzgyOCwxMyBAQA0KPiA+IHN0YXRpYyBpbnQg
aXNsMjkwMThfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPg0KPiA+ICAJbXV0ZXhfbG9j
aygmY2hpcC0+bG9jayk7DQo+ID4NCj4gPiArCWVyciA9IHJlZ3VsYXRvcl9lbmFibGUoY2hpcC0+
dmNjX3JlZyk7DQo+ID4gKwlpZiAoZXJyKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQg
dG8gZW5hYmxlIFZDQyByZWd1bGF0b3JcbiIpOw0KPiA+ICsJCW11dGV4X3VubG9jaygmY2hpcC0+
bG9jayk7DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArCX0NCj4gPiArDQo+ID4gIAllcnIgPSBp
c2wyOTAxOF9jaGlwX2luaXQoY2hpcCk7DQo+ID4gIAlpZiAoIWVycikNCj4gPiAgCQljaGlwLT5z
dXNwZW5kZWQgPSBmYWxzZTsNCg0K
