Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93562C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592C121848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="SCZuzs2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfA3HkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:40:20 -0500
Received: from mail-eopbgr140097.outbound.protection.outlook.com ([40.107.14.97]:36399
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfA3HkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTuf9WZbzjZ9LIDpiG9Vs0fdLS+DVg/kUqlKDlDAKow=;
 b=SCZuzs2LtmWxEiaf2wxZQe/QV7DixjF2tyHEYTVVjf5TEcDjDessBSlLBInpLpaUj4Qm+LPEgTnjU9Xh0fHamsYWty7lRJrhiC6KLz4wKV9JEhbGLGQXH9y1WP4LZVM0MIfgAQSPxil+8/ArhwYpedw96F9hP6BY2UIIQUfMdMk=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1584.EURPRD10.PROD.OUTLOOK.COM (10.165.191.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 07:40:15 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 07:40:15 +0000
From:   Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Esben Haabendal <esben@haabendal.dk>,
        "martin@hundeboll.net" <martin@hundeboll.net>
Subject: Re: [PATCH v9 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Thread-Topic: [PATCH v9 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Thread-Index: AQHUscpEwvUxada9K0KrXhhGLz87qKW7jIGAgAs0LACAALnQgA==
Date:   Wed, 30 Jan 2019 07:40:15 +0000
Message-ID: <354edbef-1ad5-78d8-e210-e55c38798962@prevas.se>
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
 <20190121204527.5548-1-rasmus.villemoes@prevas.dk>
 <20190121204527.5548-2-rasmus.villemoes@prevas.dk>
 <20190122172935.GA4964@roeck-us.net>
 <de4bd94c-d2f7-66c2-6386-8b1cec57af03@prevas.dk>
In-Reply-To: <de4bd94c-d2f7-66c2-6386-8b1cec57af03@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0222.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::22) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR10MB1584;6:R3sc4d3wr0bMhoGutaCQJtfbdwu2gfsH8R2NOsCf1UJPxt1JHtgiCOIAwIfirbPEKIEAfAHr/gyLrawtKMiMnej9to480ByFLE4rVpiFcenIpaRTBpq1ukOg9WEhS3DZgTFl/uzb3C/7VX1ZGfZqAzDZqTo8kHm0HnlZW5gtz6x+8K90chvaWGKh++Ba2HOo7Co0+4xCrV8xOgZ2IFAAwjZdnVmfMGGppUdbZ9lsTLHc4dGL+aVUZjKadolcxjbrfjZHfAhhPVd7LSLDmI5XHNTE2VnelPqbhCj9J1UZsVOPL/ympJXe9uLlsjGPdVrwva5Mx43cnkXd/kfG1cjJDaoq6Oh4R7OmvKBLgHex/O8AV330FZyCxuW6B7u+ooVB25zSRImc8fQ6Qa0bspb6JIx5FL98SeTJQw7VttEGPSiadLD2/J+1wspdyS7km0SrRsKb1CmNPgRT3VrWwhLz4w==;5:o4OADamGD/Q+DxazAxoPwJOJmhba/fpEaQV6rE/Dbb1jVDthcV1EjGf7niH815jXFCXcApzXob9SnZUTKn1yS5t3Ski62nwGwfB6YDC8tJQbUpE01zivT9XSsquc5l/JkRZaQXdB7g0No9DZcW0DMrC9WjDyKU05H/iosNcWT7oI3i9pV4hYd5CGHv5xUThizuwWmMtIKnUjlojXJ4C6vg==;7:WgWx0UPC54IgmW/uRfvBn+eavMD3+oEZttnoAUwFgrbEzO1YVKaOKWhVw8njIKI2F8qFh4oQplTWC2Up6FRZ9Y/+XOzUPueZ9dRQFTKWvyC5HU+4C/vLDmzHyKXyFllklmqPNzPfbrioDAFVqnomvw==
x-ms-office365-filtering-correlation-id: 303ddcaf-91e6-4faf-f9ce-08d686862cb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1584;
x-ms-traffictypediagnostic: VI1PR10MB1584:
x-microsoft-antispam-prvs: <VI1PR10MB15842B01769D6A806741DA138A900@VI1PR10MB1584.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39850400004)(43544003)(199004)(189003)(99286004)(6512007)(93886005)(54906003)(256004)(2616005)(31696002)(36756003)(2906002)(7736002)(86362001)(486006)(316002)(14454004)(476003)(11346002)(446003)(4326008)(6916009)(53936002)(6436002)(74482002)(305945005)(6486002)(25786009)(68736007)(66066001)(97736004)(26005)(3846002)(52116002)(105586002)(6506007)(76176011)(102836004)(478600001)(106356001)(6246003)(386003)(6116002)(31686004)(72206003)(81166006)(81156014)(44832011)(71190400001)(71200400001)(8676002)(8936002)(186003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1584;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GBddFpXjy/NioFeAIFVl+iIS6/4lvnLvOXIaDjD8YHCrsSZVyt5Sq2zDh4yxh0K4WhBQoSE2Y8cW0GiF17DvCylTTX0JD14ygpWcU3IeqW3lIFW9zWuf1kxThMdPrw1BsrDVqrQFlQkpW6Wpo7HmcF8ruxU3yyoinSxzo+O9G7kQCkIJhquyRCM5lp83vC2M7XsYZSY+V1i3NSVb9XIAzgNgyzoE4FN2eFB2Cj8ZOPby327tfH22DznM3ld2WmxVNeGUGbNBe6HPGXsiVHdm/Us+rpJ2nqAYgjIMbHGHuNAtDXIkQsjf4w73BjarwU2yefBbPEUZE3INDa5+8rzETlzgwqjfEX3BlLnfqJJ7Oyo/kNk3uHVcFAbTJUa5KHdmHfImQ9hQb2iVrxyruwbR6wy3JWCQ3iMkpsv4SbhmmZE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDCF14841DB6B84FBD02B6F038AE6ACE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 303ddcaf-91e6-4faf-f9ce-08d686862cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 07:40:14.6583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDEvMjAxOSAyMS4zNSwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4gT24gMjIvMDEv
MjAxOSAxOC4yOSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4+IE9uIE1vbiwgSmFuIDIxLCAyMDE5
IGF0IDA4OjQ1OjM5UE0gKzAwMDAsIFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+Pj4gIA0KPj4+
ICBzdGF0aWMgdm9pZCB3YXRjaGRvZ19waW5nX3dvcmsoc3RydWN0IGt0aHJlYWRfd29yayAqd29y
aykNCj4+PiBAQCAtMjk3LDcgKzMxNyw3IEBAIHN0YXRpYyBpbnQgd2F0Y2hkb2dfc3RvcChzdHJ1
Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZGQpDQo+Pj4gIAkJcmV0dXJuIC1FQlVTWTsNCj4+PiAgCX0N
Cj4+PiAgDQo+Pj4gLQlpZiAod2RkLT5vcHMtPnN0b3ApIHsNCj4+PiArCWlmICh3ZGQtPm9wcy0+
c3RvcCAmJiAhb3Blbl90aW1lb3V0KSB7DQo+Pg0KPj4gVGhpcyBjaGFuZ2VzIHRoZSBzZW1hbnRp
Y3Mgb2YgV0RJT0NfU0VUT1BUSU9OUyAvIFdESU9TX0RJU0FCTEVDQVJELg0KPj4gIlR1cm4gb2Zm
IHRoZSB3YXRjaGRvZyB0aW1lciIgaXMgd2VsbCBkZWZpbmVkIGFuZCBkb2Vzbid0IGxlYXZlDQo+
PiB0aGUgb3B0aW9uIG9mIHNldHRpbmcgYSB0aW1lb3V0IG9uIGl0Lg0KPiANCj4gSSBjYW4gZHJv
cCB0aGlzIGh1bmssIHNpbmNlIGl0J3MgbW9zdGx5IGlycmVsZXZhbnQgdG8gdGhlIGFjdHVhbCB1
c2UNCj4gY2FzZXMgSSBoYXZlIGluIG1pbmQuIEl0IG1ha2VzIHRlc3RpbmcgdGhlIGZlYXR1cmUg
b24gcmVmZXJlbmNlIGJvYXJkcyBhDQo+IGxpdHRsZSBtb3JlIGF3a3dhcmQsIGJ1dCBJIGNhbiBs
aXZlIHdpdGggdGhhdC4NCg0KQWN0dWFsbHksIHRoYXQncyBub3QgZW5vdWdoIC0gaWYgdGhlcmUg
d2FzIGEgbm9uLXplcm8gb3Blbl90aW1lb3V0IGF0DQpib290LCB0aGUgZGV2aWNlIGhhcyBoYWQg
aXRzIC0+b3Blbl9kZWFkbGluZSBzZXQgdG8gc29tZSBmaW5pdGUgKG5vdA0KS1RJTUVfTUFYKSB2
YWx1ZSwgYW5kIC0+b3Blbl9kZWFkbGluZSBkb2VzIG5vdCBnZXQgdXBkYXRlZCBvbiB0aGUNCldE
SU9DX1NFVE9QVElPTlMgLyBXRElPU19ESVNBQkxFQ0FSRCBwYXRoLg0KDQpTbywgSSB0aGluayBv
bmUgd2F5IHRvIHByZXNlcnZlIHRoZSBzZW1hbnRpY3Mgb2YgV0RJT1NfRElTQUJMRUNBUkQNCih3
aGljaCwgZm9yIGEgbm9uLXN0b3BhYmxlIHdhdGNoZG9nIHJlYWxseSBtZWFucyAicGxlYXNlIGxl
dCB0aGUga2VybmVsDQp0YWtlIGNhcmUgb2YgdGhpcyBpbmRlZmluaXRlbHksIG9yIHVudGlsIFdE
SU9TX0VOQUJMRUNBUkQiKSBpcyB0byBleHRlbmQNCndhdGNoZG9nX3N0b3Agd2l0aCBhIHRpbWVv
dXQgcGFyYW1ldGVyLCBhbmQgZG8gdGhlIGNhbGwgb2YNCndhdGNoZG9nX3NldF9vcGVuX2RlYWRs
aW5lKCkgZnJvbSB3YXRjaGRvZ19zdG9wKCkgdXNpbmcgdGhlIHBhc3NlZA0KdGltZW91dCB2YWx1
ZS4gV2hlbiBjYWxsZWQgZnJvbSB0aGUgV0RJT1NfRElTQUJMRUNBUkQgY2FzZSwgd2UnZCBwYXNz
IDANCmZvciB0aGF0IHRpbWVvdXQsIHdoaWxlIHRoZSBjYWxsIGZyb20gX3JlbGVhc2Ugd291bGQg
cGFzcyB0aGUgbW9kdWxlDQpwYXJhbWV0ZXIgb3Blbl90aW1lb3V0LiBbT2J2aW91c2x5LCB3YXRj
aGRvZ19zZXRfb3Blbl9kZWFkbGluZSgpIHdvdWxkDQphbHNvIHRha2UgdGhlIHRpbWVvdXQgYXMg
YSBwYXJhbWV0ZXIgaW5zdGVhZCBvZiByZWZlcnJpbmcgdG8gdGhlDQpvcGVuX3RpbWVvdXQgZGly
ZWN0bHkuXQ0KDQpUaGFua3MgZm9yIHBvaW50aW5nIG91dCB0aGUgV0RJT1NfRElTQUJMRUNBUkQg
Y2FzZS4gSSdsbCB0cnkgdG8gbWFrZSB0aGUNCmFib3ZlIGludG8gY29kZSB0byBzZWUgaG93IGl0
IGxvb2tzLg0KDQpSYXNtdXMNCg0K
