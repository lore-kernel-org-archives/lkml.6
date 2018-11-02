Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D53204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="sGXW51cV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D53204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeKBWFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:05:47 -0400
Received: from mail-eopbgr40095.outbound.protection.outlook.com ([40.107.4.95]:45952
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbeKBWFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9plPqHSC09wy4W95RDG0jf5lhD0bfGDsyzwEmsWQfg=;
 b=sGXW51cVNPQp2dQVLJHx69LW0zuDC7ucU8FfGVclw3YCug3uTayqMGD9gGGimKKoSdq0eucWMtO61INvKTD9FtWq4V3nPaf7g1s+t9CixSp6MVFwu16QHkH6DXmpcsDTNzshSxJ7mh0ljwXgMoC9+6HQezReWqORUtpxcHGQ+F0=
Received: from DB6PR0201MB2454.eurprd02.prod.outlook.com (10.169.223.151) by
 DB6PR0201MB2471.eurprd02.prod.outlook.com (10.169.224.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Fri, 2 Nov 2018 12:58:38 +0000
Received: from DB6PR0201MB2454.eurprd02.prod.outlook.com
 ([fe80::ac29:961d:fd2a:7a5f]) by DB6PR0201MB2454.eurprd02.prod.outlook.com
 ([fe80::ac29:961d:fd2a:7a5f%7]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 12:58:38 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        "heiko@sntech.de" <heiko@sntech.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix some typo
Thread-Topic: [PATCH v2] i2c: rk3x: fix some typo
Thread-Index: AQHUcqn7yejVo+ObsU2G6DvrfzysyqU8cjOA
Date:   Fri, 2 Nov 2018 12:58:37 +0000
Message-ID: <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
References: <20181102124535.24331-1-tiny.windzz@gmail.com>
In-Reply-To: <20181102124535.24331-1-tiny.windzz@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::29) To DB6PR0201MB2454.eurprd02.prod.outlook.com
 (2603:10a6:4:34::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0201MB2471;6:nvZlbE6OGjIX1+pSHEP9bkbUs/9eG9GygfrDX6P9bGdsFJzU29phkSXzWN2ejC3SP7xWAhwfV4GZtLQYWXDbnyl3c9EGgYBQrox7WIftg9BNbp54BpKLZUpcJ9t6BWjcwFxWud5qHQo+lbX2ueRzQ5diC/olYk8rfOgFDmAssoBVMjb+fbiktaV96tKWpDLH2J3oOhWaMIIEDoOuayaTx5gJnFkJmOhkBsCVAaLSr80PnwZJ042lNDcmS3bWBemS4fYdfITBBpjFUrogd34/sEpl5fAEcyJbRoaGvh+iSF99SSl0PP3i+ATP9x3XJ7v9E5EtxbpMOs1IqSYUDUMnsCYJUiBlp8m5SMI6AVzTVvLIrNtfBeNzdklkG6LvzX2mVzwSmmWhrHnu9gA2Ocjk6uSTX9oRFRon9xZXsfSXs6iTPAS7FWTbRazhAjNe+Bzy2lI2/po5NlUIc43aODQmaw==;5:wFnVYU7KAKZknUkpUXNBWG1PXBc8BsjSPaVxgDEk4BETq+o2JFjnYkXC0RYxNFsSXh590lFyp8lHeKcK1HkpMUm0qj8o0mX/eb5PA5EzMPQ8F1tZetGN3A+TuHJZbOwBl6HJh8OQfwhEvQoFAqnv75aOHf4UvIkb6hxdSOUBnCc=;7:Da2gFA0B8ZNWxbgHPEkNR5v9I+cEnsRQ48p/AK/cfSaVm+HBkPXhoyVgcUBxz4im6m9gj5+376Z2F7uiDjYXJeQlLE5oKuLbBDxpJHL1saN1tJpWAqH/NhWL/Zf6LkaK+lAQ8DrF0nyPonKIh+vBfQ==
x-ms-office365-filtering-correlation-id: c202add7-2d17-4551-1319-08d640c2e7b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2471;
x-ms-traffictypediagnostic: DB6PR0201MB2471:
x-microsoft-antispam-prvs: <DB6PR0201MB247184B7ABB6911DC6043617BCCF0@DB6PR0201MB2471.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:DB6PR0201MB2471;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2471;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39830400003)(396003)(376002)(346002)(189003)(199004)(68736007)(256004)(74482002)(97736004)(64126003)(386003)(53546011)(26005)(6506007)(6486002)(65806001)(102836004)(305945005)(52116002)(7736002)(11346002)(65826007)(2616005)(476003)(5660300001)(6116002)(508600001)(229853002)(446003)(186003)(3846002)(2501003)(86362001)(31696002)(3260700006)(25786009)(486006)(99286004)(6246003)(2906002)(36756003)(53936002)(6512007)(39060400002)(110136005)(105586002)(2900100001)(8676002)(4326008)(71200400001)(71190400001)(65956001)(8936002)(31686004)(54906003)(14454004)(76176011)(106356001)(81156014)(316002)(58126008)(81166006)(6436002)(66066001)(32563001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2471;H:DB6PR0201MB2454.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S7ucNJVzQoGyMIzWRORJ+WoirqCrMFm44+wXf513OwI2u/2fLsd3k/4HjdzBxe58WK8Gg/SY/qIlGAYB992TjStbddhnm5ykWfwLTLyLphndENTWvr0lZozUFcIAB9mFEVtnopbNiJ+IN9cnbWjVPHCldWWqLYBPKiCXFZe9C4OWlrBCnXQGosxL84JPFK2ahksVSzpS6mIzi4i7C2S4UtrdYeN503Dz72fn1HX0byjhhcGXmqe1TCH+XsjAE6YeETKCIZO6aa5JQGkvu/3Y6Rp8nlVjWwz32dmIUX/lm7pYVnEVAiEOY8cgHJQx8NslCvL3UZa4Fof9cI3Lo3Gffa31ybVO3rc+kHfs/XZ2OT8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4CB0DD9DB5C8C4C93B9A3CC7670CB98@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c202add7-2d17-4551-1319-08d640c2e7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 12:58:37.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0wMiAxMzo0NSwgWWFuZ3RhbyBMaSB3cm90ZToNCj4gRml4IG11bHRpcGxlIGlu
c3RhbmNlcyBvZiBhIG1pc3NwZWxsZWQgIkNhbGN1bGF0ZXMiLg0KDQpZZXMsIGl0IHN1cmUgaXMg
aGFyZCB0byBzcGVsbCAiQ2FsY2x1YXRlZCwiIGl0J3MgYWxtb3N0IGltcG9zc2libGUgdG8NCmdl
dCBpdCBjb21wbGV0ZWx5IHJpZ2h0IGFuZCBub3QgaW50cm9kdWNlIGFub3RoZXIgdHlwbyBzb21l
d2hlcmUuLi4gOi0pDQoNCkNoZWVycywNClBldGVyDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlh
bmd0YW8gTGkgPHRpbnkud2luZHp6QGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhlaWtvIFN0
dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtYWRk
IGNvbW1pdCBtZXNzYWdlDQo+IC0tLQ0KPiAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1yazN4LmMg
fCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1yazN4LmMgYi9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLXJrM3guYw0KPiBpbmRleCBiOGEyNzI4ZGQ0YjYuLmZlMzQ3
ZThlMmEyMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1yazN4LmMNCj4g
KysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1yazN4LmMNCj4gQEAgLTU1NSw3ICs1NTUsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19zcGVjX3ZhbHVlcyAqcmszeF9pMmNfZ2V0X3NwZWMo
dW5zaWduZWQgaW50IHNwZWVkKQ0KPiAgICoNCj4gICAqIEBjbGtfcmF0ZTogSTJDIGlucHV0IGNs
b2NrIHJhdGUNCj4gICAqIEB0OiBLbm93biBJMkMgdGltaW5nIGluZm9ybWF0aW9uDQo+IC0gKiBA
dF9jYWxjOiBDYWN1bGF0ZWQgcmszeCBwcml2YXRlIHRpbWluZ3MgdGhhdCB3b3VsZCBiZSB3cml0
dGVuIGludG8gcmVncw0KPiArICogQHRfY2FsYzogQ2FsY3VsYXRlZCByazN4IHByaXZhdGUgdGlt
aW5ncyB0aGF0IHdvdWxkIGJlIHdyaXR0ZW4gaW50byByZWdzDQo+ICAgKg0KPiAgICogUmV0dXJu
czogMCBvbiBzdWNjZXNzLCAtRUlOVkFMIGlmIHRoZSBnb2FsIFNDTCByYXRlIGlzIHRvbyBzbG93
LiBJbiB0aGF0IGNhc2UNCj4gICAqIGEgYmVzdC1lZmZvcnQgZGl2aWRlciB2YWx1ZSBpcyByZXR1
cm5lZCBpbiBkaXZzLiBJZiB0aGUgdGFyZ2V0IHJhdGUgaXMNCj4gQEAgLTcxNiw3ICs3MTYsNyBA
QCBzdGF0aWMgaW50IHJrM3hfaTJjX3YwX2NhbGNfdGltaW5ncyh1bnNpZ25lZCBsb25nIGNsa19y
YXRlLA0KPiAgICoNCj4gICAqIEBjbGtfcmF0ZTogSTJDIGlucHV0IGNsb2NrIHJhdGUNCj4gICAq
IEB0OiBLbm93biBJMkMgdGltaW5nIGluZm9ybWF0aW9uDQo+IC0gKiBAdF9jYWxjOiBDYWN1bGF0
ZWQgcmszeCBwcml2YXRlIHRpbWluZ3MgdGhhdCB3b3VsZCBiZSB3cml0dGVuIGludG8gcmVncw0K
PiArICogQHRfY2FsYzogQ2FsY3VsYXRlZCByazN4IHByaXZhdGUgdGltaW5ncyB0aGF0IHdvdWxk
IGJlIHdyaXR0ZW4gaW50byByZWdzDQo+ICAgKg0KPiAgICogUmV0dXJuczogMCBvbiBzdWNjZXNz
LCAtRUlOVkFMIGlmIHRoZSBnb2FsIFNDTCByYXRlIGlzIHRvbyBzbG93LiBJbiB0aGF0IGNhc2UN
Cj4gICAqIGEgYmVzdC1lZmZvcnQgZGl2aWRlciB2YWx1ZSBpcyByZXR1cm5lZCBpbiBkaXZzLiBJ
ZiB0aGUgdGFyZ2V0IHJhdGUgaXMNCj4gDQoNCg==
