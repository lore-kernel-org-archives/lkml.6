Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD0121874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="QnCznYKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfBZVlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:41:51 -0500
Received: from mail-eopbgr730123.outbound.protection.outlook.com ([40.107.73.123]:45046
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728727AbfBZVlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jElM9RPyyoxXgd3XKEkeVzQ4T2lxi8EMMoe/udhRg0Q=;
 b=QnCznYKIB/qJsdljCP6B/w9DpUjnrcGZH0vm15x8sm9nlit4l0t6QjN8EE1PEYgVev//NoAoJ/uUsQ6Hpm76yF8InONOqJ2m7FP+zPzbBuZn7uXGK9VXmiiXQXTfSuyubYFwH3JEwaiMbM/xHfK2MR20sjo5IKsqQEV+97jC9Oc=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3739.namprd06.prod.outlook.com (10.167.236.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 21:41:47 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 21:41:46 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jiada_wang@mentor.com" <jiada_wang@mentor.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>
Subject: Bug in spi: imx: Add support for SPI Slave mode
Thread-Topic: Bug in spi: imx: Add support for SPI Slave mode
Thread-Index: AQHUzhwSBRMy/pK+/0CNaGtu+2Rbfg==
Date:   Tue, 26 Feb 2019 21:41:46 +0000
Message-ID: <1551217306.3075.188.camel@impinj.com>
References: <20170905051232.21203-1-jiada_wang@mentor.com>
In-Reply-To: <20170905051232.21203-1-jiada_wang@mentor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cccdb20d-b9ec-485f-2440-08d69c333539
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3739;
x-ms-traffictypediagnostic: MWHPR0601MB3739:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3739;20:doWPozYPfG/ggjx1D3tZx1pTDM+5bbQKHQZT1SuosPv2tO1PwVWeBTf224p4bfyXAQn+pl4hQGUw5UmiEmMtkz/deBhg11UsPqSUjC5RmmFbIgUwnw5a8f460Oggzh8pKZv9F7+bg6ggYDmuvLzZ9RiBjkUz6iRpMdZOodX5NvY=
x-microsoft-antispam-prvs: <MWHPR0601MB3739D4925922BF22811B151CD37B0@MWHPR0601MB3739.namprd06.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39850400004)(136003)(396003)(366004)(199004)(189003)(8676002)(2906002)(6512007)(66066001)(36756003)(71200400001)(5660300002)(486006)(25786009)(86362001)(53936002)(2501003)(71190400001)(2201001)(316002)(446003)(110136005)(2616005)(54906003)(103116003)(76176011)(14454004)(478600001)(68736007)(305945005)(6436002)(476003)(26005)(99286004)(106356001)(105586002)(81156014)(102836004)(186003)(3846002)(81166006)(6116002)(6506007)(11346002)(6486002)(256004)(7736002)(97736004)(4326008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3739;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4gYdaCWkA8Qf2iC7VV87ARzw6HX229NYKP8RKtnEZ0iDTV1KTnJb5EZVCXwi3YqsDYvMvMS+MLdeII37fSuvPqpMTqa2UhZ2HJgcVzOndjYI15tDwG7/J9Jn/OqbIxqpQIxAm9Ur3opdhyScJGrD9cmfRlAxRfHcroXBWwISvXyG0a0TsyE8jrACpcS5H5qJHDLBX1RcKm6A/GRC/YgQsHdaTsNqSx3r3Hd3F+KEY9T2/FuQODu2lZgNK/r6sBSdoPUN1bf74UDQm/Q3erQO8qUI6g83D6W68tbvuqXD5eI1VcLA41S9VMSeqi1Xebc0JbGU8iCP2EIR9eiTVIiMyzOFMjo6bGbLXaz55DJ/S8A9QgT4qra/rzuU84h4PrOggMijVPrw9gAYoO7M1rF1eyC9cJlK90g6HBcl0ZM31aw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B184B127233CEA42865C0F60340BE728@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccdb20d-b9ec-485f-2440-08d69c333539
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 21:41:46.8925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE3LTA5LTA1IGF0IDE0OjEyICswOTAwLCBKaWFkYSBXYW5nIHdyb3RlOg0KPiBQ
cmV2aW91c2x5IGkuTVggU1BJIGNvbnRyb2xsZXIgb25seSB3b3JrcyBpbiBNYXN0ZXIgbW9kZS4N
Cj4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgdG8gaS5NWDUxLCBpLk1YNTMgYW5kIGkuTVg2IEVD
U1BJDQo+IGNvbnRyb2xsZXIgdG8gd29yayBhbHNvIGluIFNsYXZlIG1vZGUuDQoNClJlY2VudGx5
IERNQSBoYXMgYmVlbiBlbmFibGVkIGZvciBpbXg2Lzcgd2l0aCBTUEkuICBUaGlzIHJlc3VsdHMg
aW4NCm1lbW9yeSBjb3JydXB0aW9uIGluIHNvbWUgaW5zdGFuY2VzIEkndmUgdHJhY2VkIHRoZSBw
cm9ibGVtIHRvIHRoaXMNCnBhdGNoLg0KDQoNCj4gIHN0YXRpYyBpbnQgc3BpX2lteF90cmFuc2Zl
cihzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLA0KPiAgCQkJCXN0cnVjdCBzcGlfdHJhbnNmZXIgKnRy
YW5zZmVyKQ0KPiAgew0KPiAgCXN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXggPSBzcGlfbWFz
dGVyX2dldF9kZXZkYXRhKHNwaS0+bWFzdGVyKTsNCj4gIA0KPiArCS8qIGZsdXNoIHJ4ZmlmbyBi
ZWZvcmUgdHJhbnNmZXIgKi8NCj4gKwl3aGlsZSAoc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT5yeF9h
dmFpbGFibGUoc3BpX2lteCkpDQo+ICsJCXNwaV9pbXgtPnJ4KHNwaV9pbXgpOw0KPiArDQo+ICsJ
aWYgKHNwaV9pbXgtPnNsYXZlX21vZGUpDQo+ICsJCXJldHVybiBzcGlfaW14X3Bpb190cmFuc2Zl
cl9zbGF2ZShzcGksIHRyYW5zZmVyKTsNCj4gKw0KPiAgCWlmIChzcGlfaW14LT51c2VkbWEpDQo+
ICAJCXJldHVybiBzcGlfaW14X2RtYV90cmFuc2ZlcihzcGlfaW14LCB0cmFuc2Zlcik7DQo+ICAJ
ZWxzZQ0KDQpUaGlzIGlzIGluIHRoZSBtYWluIHhmZXIgZnVuY3Rpb24gdGhhdCBpcyB1c2VkIGZv
ciBib3RoIG1hc3RlciBtb2RlIGFuZA0Kc2xhdmUgbW9kZS4gIE5vcm1hbGx5IFJYIGRhdGEgaXMg
cmVjZWl2ZWQgYWZ0ZXIgdGhlIHhmZXIgaXMgc3RhcnRlZCwgYXMNCnBhcnQgb2YgdGhlIHNwaV9p
bXhfcGlvL2RtYV90cmFuc2ZlcigpIHByb2Nlc3MuICBCdXQgdGhpcyBwYXRjaCBoYXMNCmFkZGVk
IGEgImZsdXNoIHJ4ZmlmbyIgY29tbWFuZCBiZWZvcmUgdGhpcy4gIFdoeT8NCg0KSWYgaXQncyBu
ZWNlc3NhcnkgdG8gZW1wdHkgdGhlIGZpZm8gYmVmb3JlIGFuIHhmZXIsIHRoZW4gaG93IGRpZCB0
aGlzDQpkcml2ZXIgZXZlciB3b3JrIGJlZm9yZSB0aGlzIGNoYW5nZT8gIEkgc2VlIG5vIGNoYW5n
ZSBhbnl3aGVyZSBlbHNlDQp0aGF0IHdvdWxkIG1ha2UgdGhpcyBhIG5ldyByZXF1aXJlbWVudC4N
Cg0KSWYgdGhlIHJ4IGZpZm8gaXMgbm90IGVtcHR5LCBhbmQgdGhpcyBjb2RlIGFjdHVhbGx5IGRv
ZXMgcnggc29tZXRoaW5nDQpmcm9tIHRoZSBmaWZvLCB0aGVuIGhvdyBjYW4gaXQgcG9zc2libHkg
d29yayB0byBwbGFjZSBpdCBpbnRvIHRoZQ0KeGZlcidzIFJYIGJ1ZmZlcj8gSG93IGRvIHlvdSBr
bm93IHRoZSBidWZmZXIgaXMgbGFyZ2UgZW5vdWdoIChpdCdzIG5vdCENCnRoYXQncyBteSBETUEg
YnVnISk/ICBXb24ndCBpdCBvZmZzZXQgdGhlIGFjdHVhbCByeCBkYXRhIHRoYXQgY29tZXMNCmFm
dGVyIGl0IGluIHRoZSB4ZmVyJ3MgYnVmZmVyPw0KDQpJbiBteSB0ZXN0LCBzd2l0Y2hpbmcgZnJv
bSBETUEgdG8gUElPLCB3aGljaCBoYXBwZW5zIGlmIHRoZSAxc3QgeGZlciBpcw0KIGxhcmdlIGVu
b3VnaCB0byBwYXNzIGEgPmZpZm8vMiBzaXplIHRlc3QsIGFuZCB1c2VzIERNQSwgYW5kIHRoZSAy
bmQNCnhmZXIgaXMgc21hbGxlciwgYW5kIHdpbGwgdXNlIFBJTywgcmVzdWx0cyBpbiB0aGUgUElP
IHhmZXIgdHJ5aW5nIHRvDQplbXB0eSB0aGUgcnggYnVmZmVyIGluIHRoaXMgY29kZSBhYm92ZS4g
IElmIHRoZXJlIGlzIG5vdCBlbm91Z2ggc3BhY2UNCmluIHRoZSB4ZmVyJ3MgcnggYnVmZmVyLCBh
bmQgdGhlcmUgaXMgbm8gcmVhc29uIGZvciB0aGVyZSB0byBiZSBhbnkNCnNwYWNlIGF0IGFsbCwg
aXQgY2xvYmJlcnMgbWVtb3J5Lg0KDQpJIHN1c3BlY3QgdGhlIGF1dGhvciBvZiB0aGlzIHdhc24n
dCBhd2FyZSB0aGF0IHNwaV9pbXgtPnJ4KCkgd2lsbCB3cml0ZQ0KdGhlIGRhdGEgcmVjZWl2ZWQg
aW50byB0aGUgY3VycmVudCB4ZmVyJ3MgcnggYnVmZmVyIHJhdGhlciB0aGFuIHRocm93DQppdCBh
d2F5LCBhbmQgbmV2ZXIgdGVzdGVkIHRoaXMgYWN0dWFsbHkgZ2V0dGluZyB1c2VkIGZvciBhIHRy
YW5zZmVyDQp3aGVyZSB0aGUgcnggZGF0YSBtYXR0ZXJlZC4NCg0KU3RpbGwsIEknZCBsaWtlIHRv
IGtub3cgd2h5IHRoZSBmbHVzaCByeCB0aGluZyBpcyBldmVuIGhlcmUuICBOb3RoaW5nDQppbiB0
aGUgY29tbWl0IG1lc3NhZ2Ugb3IgYW55IGRpc2N1c3Npb24gSSBjb3VsZCBmaW5kIGFkZHJlc3Nl
ZCB0aGlzLg==
