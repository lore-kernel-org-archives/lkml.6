Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C770C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472CA21903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s4SY3ql8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeLWGTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 01:19:19 -0500
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:50874
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbeLWGTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 01:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnAwnjxQsR0X0Uht0MREp/NOMYOXynjJimZrCmtk4O8=;
 b=s4SY3ql8vKdkVTlrL7CE3E07sGCAzdEOME0UFmOe6Z8qJRCXUdHEhCWMLsSFTrMS0j6ZvOwK1AQ6l/B+M1LKCyT3VJxFwnO8WdCHl0RWSQJTUB0Ige2Z55/xAWwxG/r7Uy0k1gCMv0PlWrqM3c/Z1X4Hu+GiW9j1AHIMVwF2MXo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3689.eurprd04.prod.outlook.com (52.134.69.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.26; Sun, 23 Dec 2018 06:19:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%5]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 06:19:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7] iio: light: isl29018: add vcc regulator operation
 support
Thread-Topic: [PATCH V7] iio: light: isl29018: add vcc regulator operation
 support
Thread-Index: AQHUlbghL8UoJu3CiUOnqyrpi++ur6WLCC0AgADaRRA=
Date:   Sun, 23 Dec 2018 06:19:09 +0000
Message-ID: <DB3PR0402MB3916E5242EF5F31B400EB3C2F5BA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1545016752-9865-1-git-send-email-Anson.Huang@nxp.com>
 <20181222171434.4eca4ea4@archlinux>
In-Reply-To: <20181222171434.4eca4ea4@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3689;6:AXkBvPfS33wpsPQHSacUP4cP5vH4utNa0qMXq0C7hMSZqeWNzUzvs2lcSn9lSXfYfRQFcuhwKSwYw+yiAuIE/228R92qUWKNRBESJfxiuXCpIbvOSMAWuHnlRU2OmPA1REHGs0yTFMyudpnkVm/pK9/GLjmRzJigCadnnbgQmUg/dqBjuA8LphZlka37vTPxFe1HlqupibpCEN9AOPKd62omh1tsivsQRMIt5JQEJp/soYIlcgShkX3Pk5Gvl1BSKVxyxh/HvFkVdOr/IzWaGtEsVuA0x77s0wa4lrlhRU11cyissknSpmD98iZ3GRhrNDfsIolOJSGA+t+87iIKMs0PzWuqI5rn9mGZTUXcRTdr42otuDfEhGKHDifc7bz2EESCIjM+P/qotALpomoPByJlsRwRHqC2vW/u2U2pU6M4zyo9d+6wS9h2LU0wkbqoMx0VWDHDpPYiNYHDZcwErg==;5:ghXXudEtoodY3uXgu7KKZcY2Cy8iuQ/5usrVt1WsvbESxZWI5A+n6DkP6bXd9HJKipuvsXfQCbtncnBhD1QQbgIchFcsnBXdycq/mrNHrAic3y6Iaxb9J3sd4Cfs2IJWY+ajxqYiAeoueghZNbNL2GgB+k7zDDfMhOffu60rwuI=;7:ys5H9FMmu0hVRxdvQAC1OyaEy0oOqVnYrSMPEwyBY2nOu+7Qb1FV//+8CSoj2APFLSTPI6p3sb4b3XfblAMwKmck7+BY8RIPhmPjK2rsyHQmq+hxrkM9QAvKumv6zG6JkTxs9naJIQCVfLzyto0JqQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 80339d82-0d05-421c-80ae-08d6689e8ca1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3689;
x-ms-traffictypediagnostic: DB3PR0402MB3689:
x-microsoft-antispam-prvs: <DB3PR0402MB3689EF0AAA8FA1E958F835A3F5BA0@DB3PR0402MB3689.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3689;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3689;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(52314003)(13464003)(54534003)(189003)(199004)(316002)(14444005)(54906003)(256004)(4326008)(44832011)(5660300001)(486006)(66066001)(476003)(99286004)(6246003)(105586002)(81166006)(8676002)(81156014)(55016002)(6116002)(106356001)(6436002)(39060400002)(3846002)(8936002)(74316002)(33656002)(9686003)(14454004)(6916009)(229853002)(2906002)(25786009)(7736002)(305945005)(53936002)(478600001)(68736007)(71190400001)(71200400001)(26005)(6506007)(86362001)(7696005)(76176011)(446003)(186003)(11346002)(97736004)(53546011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3689;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IDvJi3IBulAYbeJMXumgTKXwWiSQSxnHCP/2X1ylT9Rt3oRxRCnRveAxq1MfFNf+uElCx4r8/IAl1HIsQst3XHNIGh3OcHbO4kvEIZR0anK3arrvDEaITUvbS8Z5DKmUCkwsBVxBDNRJZvzWIM8rmsvF9uGvhxPbEsil0yGU07r1axWcpJAWuXhdtbe6LVb+MK9y0dkOpJY/qAFeSJmfX5f0+QE0N9vyoPebt3TjijE5Ct9OTAFgexNL9iBy4RBT4fCWBAnnOYXJhjhf5eapGsBHU+LubtxInp+tKqdrOMD13Y9zuG0alxZ4gjG+PP1g
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80339d82-0d05-421c-80ae-08d6689e8ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 06:19:09.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEpvbmF0aGFuDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiBbbWFpbHRvOmppYzIz
QGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTjE6jEy1MIyM8jVIDE6MTUNCj4gVG86IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzoga25hYWNrLmhAZ214LmRlOyBsYXJzQG1l
dGFmb28uZGU7IHBtZWVyd0BwbWVlcncubmV0Ow0KPiBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IHBy
ZWlkQGVsZWN0cm9tYWcuY29tLmF1OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIFY3XSBpaW86IGxpZ2h0OiBpc2wyOTAxODogYWRkIHZjYyBy
ZWd1bGF0b3Igb3BlcmF0aW9uDQo+IHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgMTcgRGVjIDIwMTgg
MDM6MjU6MTcgKzAwMDANCj4gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+IHdyb3Rl
Og0KPiANCj4gPiBUaGUgbGlnaHQgc2Vuc29yJ3MgcG93ZXIgc3VwcGx5IGNvdWxkIGJlIGNvbnRy
b2xsYWJsZSBieSByZWd1bGF0b3Igb24NCj4gPiBzb21lIHBsYXRmb3Jtcywgc3VjaCBhcyBpLk1Y
NlEtU0FCUkVTRCBib2FyZCwgdGhlIGxpZ2h0IHNlbnNvcg0KPiA+IGlzbDI5MDIzJ3MgcG93ZXIg
c3VwcGx5IGlzIGNvbnRyb2xsZWQgYnkgYSBHUElPIGZpeGVkIHJlZ3VsYXRvciwgbmVlZA0KPiA+
IHRvIG1ha2Ugc3VyZSB0aGUgcmVndWxhdG9yIGlzIGVuYWJsZWQgYmVmb3JlIGFueSBvcGVyYXRp
b24gb2Ygc2Vuc29yLA0KPiA+IHRoaXMgcGF0Y2ggYWRkcyB2Y2MgcmVndWxhdG9yIG9wZXJhdGlv
biBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+IEhpIEFuc29uDQo+IA0KPiBTZWUgYmVsb3cuDQo+IA0KPiA+IC0tLQ0K
PiA+IENoYW5nZUxvZyBzaW5jZSBWNg0KPiA+ICAgICAtIHVzaW5nIGRldm1fcmVndWxhdG9yX2dl
dCgpIGluc3RlYWQgb2YgZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKCkNCj4gc2luY2UgdGhl
IHJlZ3VsYXRvciBpcw0KPiA+ICAgICAgIHRoZXJlIGFueXdheSwgaWYgZHRiIGRvZXMgTk9UIHNw
ZWNpZnkgb25lLCByZWd1bGF0b3IgZnJhbWV3b3JrIHdpbGwNCj4gYXNzaWduIGR1bW15IHJlZ3Vs
YXRvciBmb3IgaXQ7DQo+ID4gICAgIC0gU2V0dXAgZGV2bSBhY3Rpb24gZm9yIGNsZWFuaW5nIHVw
IHJlZ3VsYXRvciByZXNvdXJjZSBmb3IgZXJyb3INCj4gaGFuZGxpbmcuDQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvaWlvL2xpZ2h0L2lzbDI5MDE4LmMgfCA1OA0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvaXNsMjkw
MTguYw0KPiA+IGIvZHJpdmVycy9paW8vbGlnaHQvaXNsMjkwMTguYyBpbmRleCBiNDU0MDBmLi42
M2Y3YjlkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L2lzbDI5MDE4LmMNCj4g
PiArKysgYi9kcml2ZXJzL2lpby9saWdodC9pc2wyOTAxOC5jDQo+ID4gQEAgLTIzLDYgKzIzLDcg
QEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9k
ZWxheS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lp
by9zeXNmcy5oPg0KPiA+IEBAIC05NSw2ICs5Niw3IEBAIHN0cnVjdCBpc2wyOTAxOF9jaGlwIHsN
Cj4gPiAgCXN0cnVjdCBpc2wyOTAxOF9zY2FsZQlzY2FsZTsNCj4gPiAgCWludAkJCXByb3hfc2No
ZW1lOw0KPiA+ICAJYm9vbAkJCXN1c3BlbmRlZDsNCj4gPiArCXN0cnVjdCByZWd1bGF0b3IJKnZj
Y19yZWc7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBpc2wyOTAxOF9zZXRfaW50ZWdy
YXRpb25fdGltZShzdHJ1Y3QgaXNsMjkwMThfY2hpcCAqY2hpcCwNCj4gPiBAQCAtNzA4LDYgKzcx
MCwxNyBAQCBzdGF0aWMgY29uc3QgY2hhcg0KPiAqaXNsMjkwMThfbWF0Y2hfYWNwaV9kZXZpY2Uo
c3RydWN0IGRldmljZSAqZGV2LCBpbnQgKmRhdGEpDQo+ID4gIAlyZXR1cm4gZGV2X25hbWUoZGV2
KTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGlzbDI5MDE4X2Rpc2FibGVfcmVndWxh
dG9yX2FjdGlvbih2b2lkICpfZGF0YSkgew0KPiA+ICsJc3RydWN0IGlzbDI5MDE4X2NoaXAgKmNo
aXAgPSBfZGF0YTsNCj4gPiArCWludCBlcnI7DQo+ID4gKw0KPiA+ICsJZXJyID0gcmVndWxhdG9y
X2Rpc2FibGUoY2hpcC0+dmNjX3JlZyk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCWRldl9lcnIo
cmVnbWFwX2dldF9kZXZpY2UoY2hpcC0+cmVnbWFwKSwNCj4gPiArCQkJImZhaWxlZCB0byBkaXNh
YmxlIFZDQyByZWd1bGF0b3IhXG4iKTsgfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBpc2wyOTAx
OF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KPiA+ICAJCQkgIGNvbnN0IHN0cnVj
dCBpMmNfZGV2aWNlX2lkICppZCkNCj4gPiAgew0KPiA+IEBAIC03NDIsNiArNzU1LDM3IEBAIHN0
YXRpYyBpbnQgaXNsMjkwMThfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gPiAg
CWNoaXAtPnNjYWxlID0gaXNsMjkwMThfc2NhbGVzW2NoaXAtPmludF90aW1lXVswXTsNCj4gPiAg
CWNoaXAtPnN1c3BlbmRlZCA9IGZhbHNlOw0KPiA+DQo+ID4gKwljaGlwLT52Y2NfcmVnID0gZGV2
bV9yZWd1bGF0b3JfZ2V0KCZjbGllbnQtPmRldiwgInZjYyIpOw0KPiA+ICsJaWYgKElTX0VSUihj
aGlwLT52Y2NfcmVnKSkgew0KPiA+ICsJCWVyciA9IFBUUl9FUlIoY2hpcC0+dmNjX3JlZyk7DQo+
ID4gKwkJaWYgKGVyciAhPSAtRVBST0JFX0RFRkVSKQ0KPiA+ICsJCQlkZXZfZXJyKCZjbGllbnQt
PmRldiwgImZhaWxlZCB0byBnZXQgVkNDIHJlZ3VsYXRvciFcbiIpOw0KPiA+ICsJCXJldHVybiBl
cnI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZXJyID0gcmVndWxhdG9yX2VuYWJsZShjaGlwLT52
Y2NfcmVnKTsNCj4gPiArCWlmIChlcnIpIHsNCj4gPiArCQlkZXZfZXJyKCZjbGllbnQtPmRldiwg
ImZhaWxlZCB0byBlbmFibGUgVkNDIHJlZ3VsYXRvciFcbiIpOw0KPiA+ICsJCXJldHVybiBlcnI7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJY2hpcC0+cmVnbWFwID0gZGV2bV9yZWdtYXBfaW5pdF9p
MmMoY2xpZW50LA0KPiA+ICsJCQkJaXNsMjkwMThfY2hpcF9pbmZvX3RibFtkZXZfaWRdLnJlZ21h
cF9jZmcpOw0KPiA+ICsJaWYgKElTX0VSUihjaGlwLT5yZWdtYXApKSB7DQo+ID4gKwkJZXJyID0g
UFRSX0VSUihjaGlwLT5yZWdtYXApOw0KPiA+ICsJCWRldl9lcnIoJmNsaWVudC0+ZGV2LCAicmVn
bWFwIGluaXRpYWxpemF0aW9uIGZhaWxzOiAlZFxuIiwgZXJyKTsNCj4gPiArCQlyZWd1bGF0b3Jf
ZGlzYWJsZShjaGlwLT52Y2NfcmVnKTsNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCWVyciA9IGRldm1fYWRkX2FjdGlvbigmY2xpZW50LT5kZXYsIGlzbDI5MDE4X2Rp
c2FibGVfcmVndWxhdG9yX2FjdGlvbiwNCj4gPiArCQkJCSBjaGlwKTsNCj4gPiArCWlmIChlcnIp
IHsNCj4gDQo+IEknbSBhIGxpdHRsZSBjb25mdXNlZCwgd2h5IG5vdCBkbyB0aGlzIGJlZm9yZSBk
ZXZtX3JlZ21hcF9pbml0X2kyYy4NCj4gVGhhdCB3YXkgeW91IHdvbid0IGhhdmUgdG8gZGlzYWJs
ZSB0aGUgcmVndWxhdG9yIGluIHRoYXQgb25lIGVycm9yIHBhdGguDQo+IEFsc28sIGRldm1fYWRk
X2FjdGlvbl9vcl9yZXNldCB3aWxsIGNhbGwgaXNsMjkwMThfZGlzYWJsZV9yZWd1bGF0b3JfYWN0
aW9uDQo+IGZvciB5b3Ugb24gZXJyb3IuDQoNCkl0IGlzIGJlY2F1c2UgSSB1c2VkIGRldl9lcnIo
KSBpbiBpc2wyOTAxOF9kaXNhYmxlX3JlZ3VsYXRvcl9hY3Rpb24gd2hpY2ggbmVlZCByZWdtYXAN
CnRvIGdldCAiZGV2IiBieSByZWdtYXBfZ2V0X2RldmljZShjaGlwLT5yZWdtYXApLCBpZiBpdCBp
cyBhY2NlcHRlZCBieSBqdXN0IHVzaW5nDQpwcl9lcnIoKSBpbnN0ZWFkIG9mIGRldl9lcnIsIHRo
ZW4gSSBjYW4gZG8gdGhlIGRldm1fYWRkX2FjdGlvbiBiZWZvcmUgZGV2bV9yZWdtYXBfaW5pdF9p
MmMuDQoNCkkgdGhpbmsgdXNpbmcgcHJfZXJyIHNob3VsZCBiZSBPSywgSSB3aWxsIHVzZSBpdCBp
biBWOCBwYXRjaC4NCg0KPiANCj4gPiArCQlpc2wyOTAxOF9kaXNhYmxlX3JlZ3VsYXRvcl9hY3Rp
b24oY2hpcCk7DQo+ID4gKwkJZGV2X2VycigmY2xpZW50LT5kZXYsICJmYWlsZWQgdG8gc2V0dXAg
cmVndWxhdG9yIGNsZWFudXAgYWN0aW9uIVxuIik7DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gIAljaGlwLT5yZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X2kyYyhjbGll
bnQsDQo+ID4gIAkJCQlpc2wyOTAxOF9jaGlwX2luZm9fdGJsW2Rldl9pZF0ucmVnbWFwX2NmZyk7
DQo+ID4gIAlpZiAoSVNfRVJSKGNoaXAtPnJlZ21hcCkpIHsNCj4gPiBAQCAtNzY4LDYgKzgxMiw3
IEBAIHN0YXRpYyBpbnQgaXNsMjkwMThfcHJvYmUoc3RydWN0IGkyY19jbGllbnQNCj4gPiAqY2xp
ZW50LCAgc3RhdGljIGludCBpc2wyOTAxOF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikgIHsN
Cj4gPiAgCXN0cnVjdCBpc2wyOTAxOF9jaGlwICpjaGlwID0gaWlvX3ByaXYoZGV2X2dldF9kcnZk
YXRhKGRldikpOw0KPiA+ICsJaW50IHJldDsNCj4gPg0KPiA+ICAJbXV0ZXhfbG9jaygmY2hpcC0+
bG9jayk7DQo+ID4NCj4gPiBAQCAtNzc3LDYgKzgyMiwxMiBAQCBzdGF0aWMgaW50IGlzbDI5MDE4
X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJICogU28gd2UgZG8gbm90IGhhdmUg
bXVjaCB0byBkbyBoZXJlLg0KPiA+ICAJICovDQo+ID4gIAljaGlwLT5zdXNwZW5kZWQgPSB0cnVl
Ow0KPiA+ICsJcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUoY2hpcC0+dmNjX3JlZyk7DQo+ID4gKwlp
ZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSBWQ0MgcmVn
dWxhdG9yXG4iKTsNCj4gPiArCQltdXRleF91bmxvY2soJmNoaXAtPmxvY2spOw0KPiA+ICsJCXJl
dHVybiByZXQ7DQo+IA0KPiBHaXZlbiB5b3UgYXJlIGFib3V0IHRvIHVubG9jayBhbnl3YXkgYSBj
b21tb24gcGF0dGVybiBpcyB0byBub3QgY2hlY2sgcmV0DQo+IHVudGlsIGFmdGVyIHRoZSB1bmxv
Y2ssIHRodXMgc2ltcGxpZnlpbmcgdGhlIGNvZGUuDQoNCkkgd2lsbCBpbXByb3ZlIHRoaXMgaW4g
VjggcGF0Y2gsIHRoYW5rcy4NCg0KQW5zb24uDQoNCj4gDQo+ID4gKwl9DQo+ID4NCj4gPiAgCW11
dGV4X3VubG9jaygmY2hpcC0+bG9jayk7DQo+ID4NCj4gPiBAQCAtNzkwLDYgKzg0MSwxMyBAQCBz
dGF0aWMgaW50IGlzbDI5MDE4X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4NCj4gPiAg
CW11dGV4X2xvY2soJmNoaXAtPmxvY2spOw0KPiA+DQo+ID4gKwllcnIgPSByZWd1bGF0b3JfZW5h
YmxlKGNoaXAtPnZjY19yZWcpOw0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGVuYWJsZSBWQ0MgcmVndWxhdG9yXG4iKTsNCj4gPiArCQltdXRleF91bmxv
Y2soJmNoaXAtPmxvY2spOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICAJZXJyID0gaXNsMjkwMThfY2hpcF9pbml0KGNoaXApOw0KPiA+ICAJaWYgKCFlcnIpDQo+ID4g
IAkJY2hpcC0+c3VzcGVuZGVkID0gZmFsc2U7DQoNCg==
