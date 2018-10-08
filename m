Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD72C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663AD20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kphLejBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663AD20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJID4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:56:20 -0400
Received: from mail-he1eur01on0135.outbound.protection.outlook.com ([104.47.0.135]:43473
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeJID4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn2s+4u/oJxR94eCT/5CvGdaNX2DcxdUkmVI/mHFpwY=;
 b=kphLejBsKafgfcgLCRJelCr+N0QSO3h88aQL/6LfbFHkmlAfsw7KxCDuwLpg+eeaz2PYXTUnLaf3autLWxej6TkFSKdSG+mxjO8DtNW3PpmCnvH0/qI255kHEandDUGEsFhELTRndhTy47gA6u5Q7W6f3Pgu+bPYLs6dqir/8hY=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB1519.eurprd02.prod.outlook.com (10.166.139.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Mon, 8 Oct 2018 20:42:41 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 20:42:41 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dpot-dac: mark expected switch fall-through
Thread-Topic: [PATCH] iio: dpot-dac: mark expected switch fall-through
Thread-Index: AQHUXy1dR3DPrllFh0W6+gqsRwwRKqUV0IsA
Date:   Mon, 8 Oct 2018 20:42:41 +0000
Message-ID: <ded46d23-0ec9-3fc8-3fc2-fa8003639272@axentia.se>
References: <20181008173528.GA31787@embeddedor.com>
In-Reply-To: <20181008173528.GA31787@embeddedor.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB1519;6:+gmUnvf+qyTWbid6MJ6IFdpR9ouVxNONNf+tQrp8EvVlYfwjptbFHFlgGoTI8T0DA7aQWbGA+i6L9aZF+6Ele7M4IJ/UF+DAGGgDPiJFKO14Q5q+kFgOZHJZC8S0HBhs9X0AlRG+PEP8H9bt160gGMDCjDEIasiUivIxSnyMi3L5GTrXJcMrptRkgxRa/C7xUSMDUGlSFiqP2ih4UghH+dv/NmqgiXD/YcrhQehE3N/Klg3QHe36EK+yZBkBhwfaS+6sLBdpfEOxfBBUcLj9CW6lp30h6GtNu93VcGy0vEvQ+JzNotnPMJMeB/efTm88xBFXKtmjpKHVC7lHWQSJT5JssDQxeDYGDwFam9ttQDprqRHcFr69SFVYKV1UD1BZmScAJidCCO4drAt+kgIcQ8n4/qH8z+Xy0nspJ2BWDBquFUEuOhquAU56/urTysYhFXaOWq3MxGK3v6HT8YdVdA==;5:ek/7K/EkmGwFkCUEnnn7g2pN4IR6KJojmrFCRujanlG+ZMvW126ozV9n0dAAn+Lue2887ETf3OUjo/PRmZ8NLly6A++TJKNFPp9DTIC9aET77BfXoSrGcYX2g7E6I4/2QBex54/xqv8EqfpefEaSWom2h0d7xZRx2Tz+M8JKum8=;7:G082n8Jp+SggJ4lMR0IaaBqOAnTEts6ofE0HxB6iUWyWF95rNxKZ/+hNLXyLW6mZbudqMtJFiaP01xAZeYpoJW7BR1GmdJ2T7Z8UTudJ9xjRQpPVnz1PBzHHAZ4Hqy1jb+Mi2iJcMH52yR0OUjWTpnPhd3E7fHgbLB17EbsY+pS/7WtkRdHqJfBnFzbpgeVeu9WxKcmJ+UukDmvepRd/p04SPqupIzI304ZTSnUr9/nBmCHRsuP7M9E6MNLQZdsu
x-ms-office365-filtering-correlation-id: 6dd43285-c1ea-41f9-b282-08d62d5e974f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB1519;
x-ms-traffictypediagnostic: VI1PR0201MB1519:
x-microsoft-antispam-prvs: <VI1PR0201MB1519525401BF8F0F72738F88BCE60@VI1PR0201MB1519.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123562045)(20161123558120)(2016111802025)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:VI1PR0201MB1519;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB1519;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39830400003)(376002)(396003)(189003)(199004)(76176011)(86362001)(575784001)(52116002)(2906002)(71190400001)(71200400001)(99286004)(4326008)(316002)(26005)(25786009)(105586002)(3260700006)(64126003)(31696002)(2900100001)(14454004)(256004)(106356001)(186003)(386003)(5250100002)(6506007)(102836004)(14444005)(3846002)(6116002)(53546011)(7736002)(6486002)(53936002)(5660300001)(65826007)(74482002)(81156014)(81166006)(8676002)(229853002)(8936002)(6512007)(68736007)(305945005)(6436002)(65806001)(65956001)(66066001)(486006)(97736004)(476003)(31686004)(36756003)(2616005)(6246003)(446003)(11346002)(54906003)(508600001)(58126008)(110136005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB1519;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MA3wOuM/2YqcaDPG8e9dMBWtASlezZvb2muvf0mA+8x77KuETtzipRQiTzIbioiLmC/kL6r3s5WY9v8B7rlCAXjZXQMvAvoDdmoM0oLEwM2v6w6D81yU2pJvaEVnCooiyoET7H+deAzmNoESntyNiXSvC6uxcvIJHwK9l40TFfHR2HQIOV1hhq7/k4Nh9VQX83inSvf3EiOg4h3VxXl4Z/ty1CjQfSwewqTd10FGChNsXCq6KczcV8Q4t1HunrYb9OtjWcqvVHAh2nwqosKFuB2QeNe3Sb4UWY33dXMtkI3xsdw2cKLl2UxnQheSIvsAJqlJuS/gAXsEXVzhdua+YxBu7OxpiJJDMvORyTEo7Xw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <360DBCD96697D34AAF812C046DEFA0D7@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd43285-c1ea-41f9-b282-08d62d5e974f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 20:42:41.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB1519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMC0wOCAxOTozNSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gSW4gcHJl
cGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBzd2l0Y2gg
Y2FzZXMNCj4gd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guDQoNClRoZSB3
YXkgSSBzZWUgaXQsIGl0IGlzIHByZXR0eSB3ZWxsIG1hcmtlZCB1cCBhcyBpcy4gU28sIHRoaXMg
cGFyYWdyYXBoDQppcyBub3QgZGVzY3JpYmluZyB0aGUgY2hhbmdlLg0KDQo+IA0KPiBOb3RpY2Ug
dGhhdCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgSSByZXBsYWNlZCAiLi4uYW5kIGZhbGwgdGhy
b3VnaC4iDQo+IHdpdGggYSBwcm9wZXIgImZhbGwgdGhyb3VnaCIsIHdoaWNoIGlzIHdoYXQgR0ND
IGlzIGV4cGVjdGluZyB0byBmaW5kLg0KDQpXaGF0IGlzIG5vdCAicHJvcGVyIiBhYm91dCB0aGUg
ZXhpc3RpbmcgY29tbWVudD8gWWVzIHllcywgSSAqa25vdyogdGhhdA0KR0NDIGlzIG5vdCB2ZXJ5
IGludGVsbGlnZW50IGFib3V0IGl0IGFuZCByZXF1aXJlcyBoYW5kLWhvbGRpbmcsIGJ1dA0KYmxh
bWluZyB0aGUgZXhpc3RpbmcgY29tbWVudCBmb3Igbm90ICpwcm9wZXJseSogbWFya2luZyBhbiBp
bnRlbnRpb25hbA0KZmFsbCB0aHJvdWdoIGlzIC4uLiByaWNoLg0KDQo+IA0KPiBBZGRyZXNzZXMt
Q292ZXJpdHktSUQ6IDE0NjI0MDggKCJNaXNzaW5nIGJyZWFrIGluIHN3aXRjaCIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9paW8vZGFjL2Rwb3QtZGFjLmMgfCAyICstDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9kYWMvZHBvdC1kYWMuYyBiL2RyaXZlcnMvaWlvL2RhYy9kcG90LWRhYy5jDQo+
IGluZGV4IGE3OTFkMGEuLmUzNTM5NDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2RhYy9k
cG90LWRhYy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2RhYy9kcG90LWRhYy5jDQo+IEBAIC03OCw3
ICs3OCw3IEBAIHN0YXRpYyBpbnQgZHBvdF9kYWNfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldiwNCg0KQWRkaW5nIHNvbWUgbW9yZSBjb250ZXh0IGhlcmUuDQoNCgkJY2FzZSBJSU9f
VkFMX0lOVDoNCgkJCS8qDQoJCQkgKiBDb252ZXJ0IGludGVnZXIgc2NhbGUgdG8gZnJhY3Rpb25h
bCBzY2FsZSBieQ0KCQkJICogc2V0dGluZyB0aGUgZGVub21pbmF0b3IgKHZhbDIpIHRvIG9uZS4u
Lg0KPiAgCQkJICovDQo+ICAJCQkqdmFsMiA9IDE7DQo+ICAJCQlyZXQgPSBJSU9fVkFMX0ZSQUNU
SU9OQUw7DQo+IC0JCQkvKiAuLi5hbmQgZmFsbCB0aHJvdWdoLiAqLw0KPiArCQkJLyogZmFsbCB0
aHJvdWdoICovDQo+ICAJCWNhc2UgSUlPX1ZBTF9GUkFDVElPTkFMOg0KPiAgCQkJKnZhbCAqPSBy
ZWd1bGF0b3JfZ2V0X3ZvbHRhZ2UoZGFjLT52cmVmKSAvIDEwMDA7DQo+ICAJCQkqdmFsMiAqPSBk
YWMtPm1heF9vaG1zOw0KPiANCg0KQ29uc2lkZXJpbmcgdGhlIGFib3ZlIGFkZGVkIGNvbnRleHQs
IEkgaGF2ZSB0byBzYXkgdGhhdCB0aGlzIG1pbmRsZXNzDQpjaGFuZ2UgaXMgbm90IGFuIGltcHJv
dmVtZW50LCBhcyB5b3UgaGF2ZSBqdXN0IGRlc3Ryb3llZCB0aGUgY29udGludWVkDQpzZW50ZW5j
ZSBmcm9tIHRoZSBwcmV2aW91cyBjb21tZW50LiBZb3UgbXVzdCBoYXZlIG5vdGljZWQgdGhhdCB0
aGlzDQp3YXMgdGhlIGVuZCBvZiBhIGNvbnRpbnVlZCBzZW50ZW5jZSwgYXMgeW91IGV2ZW4gcXVv
dGVkIGl0IGluIHRoZSBjb21taXQNCm1lc3NhZ2UuIFRoZSBiaWcgcXVlc3Rpb24gaXMgd2h5IHlv
dSBkaWQgbm90IHN0b3AgdG8gdGhpbmsgYW5kIGNvbnNpZGVyDQp0aGUgY29udGV4dD8NCg0KWWVz
LCBJJ20gYW5ub3llZCBieSBtaW5kbGVzcyBjaGFuZ2VzLiBFc3BlY2lhbGx5IG1pbmRsZXNzIGNo
YW5nZXMgYWltZWQNCmF0IGltcHJvdmluZyByZWFkYWJpbGl0eSB3aGlsZSBpbiBmYWN0IG1ha2lu
ZyB0aGluZ3MgbGVzcyByZWFkYWJsZS4NCg0KVEw7RFIsIGlmIHlvdSBhcmUgZGVzcGVyYXRlIHRv
IGZpeCAidGhlIHByb2JsZW0iIHdpdGggdGhpcyBmYWxsIHRocm91Z2gNCmNvbW1lbnQsIHBsZWFz
ZSBkbyBzbyBpbiBhIHdheSB0aGF0IHByZXNlcnZlcyBvdmVyYWxsIHJlYWRhYmlsaXR5LiBBbmQN
Cml0IHdvdWxkIGJlIG5pY2UgdG8gbm90IGJsYW1lIHRoZSBleGlzdGluZyBjb2RlIGZvciBicmFp
biBkYW1hZ2UgaW4gR0NDDQphbmQgdmFyaW91cyBvdGhlciBzdGF0aWMgYW5hbHl6ZXJzLg0KDQpD
aGVlcnMsDQpQZXRlcg0K
