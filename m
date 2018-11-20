Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A3DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DFD2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="WNmCPxHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DFD2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeKTLWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:22:41 -0500
Received: from mail-eopbgr820137.outbound.protection.outlook.com ([40.107.82.137]:32420
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730140AbeKTLWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQn1iY/oAQCLjKCR71sRwKnwbIS8Fv/mCH63TdTYbN8=;
 b=WNmCPxHyO16UhIZg8w71MYALaHTXOw2qElkIDeMn92Z/Pov6i5n0x93SfPE6R/N7Rjtrhxe97wcc7kmBDZkztJXur5/ycnOVnpb7Rl4XaVxxK2N0w9bDuumzwfdTxvRf6XSNNvFxtTt+qZamhAQENCJa1F0JFyhupFv3ZvD60uk=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3636.namprd06.prod.outlook.com (52.132.101.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 20 Nov 2018 00:56:13 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%5]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 00:56:13 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "agust@denx.de" <agust@denx.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "atull@kernel.org" <atull@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>
Subject: Re: [PATCH v2 1/3] usb: misc: add driver for FT232H based FPGA
 configuration devices
Thread-Topic: [PATCH v2 1/3] usb: misc: add driver for FT232H based FPGA
 configuration devices
Thread-Index: AQHUgGgAPNp668MZnkyZHmVGvcOeoKVX1tkA
Date:   Tue, 20 Nov 2018 00:56:13 +0000
Message-ID: <1542675372.30311.573.camel@impinj.com>
References: <20181120002821.12794-1-agust@denx.de>
         <20181120002821.12794-2-agust@denx.de>
In-Reply-To: <20181120002821.12794-2-agust@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3636;6:9dfskf2jY/TtIPys0VxIIC4ZeUSTX7Z4GExssoz7CVYaY0gfyTTd4VFmNFURybgiHieCFNv1aV1CJWs71BDAkr6RDQmn099jWHWYdr3nkNP7wQSOMQ6kjdRObdHbBbLYkArLpCKvFDzH4fhk8f+b6/KqNSwUnEUVAt6NNgGPnj0FiZ3KsJP/njAtSelQUnF/gU4z6Aapw6M1zxcsV0utJjUn38Tv28sc9jjvW9ljqMrfjO2RY6lIj5xAjaD/OeFlS7Kk+Updue6TJcR/D7WD5+/4sV5cGt7SM4zmm9jdekQBYVOeCVScjjraRjZPJbqJlqXQ6/IQ18CHS9c7o3x31QAFXQKLQt0XC74EfCX5xJAr/dMDYhE+Dfh9iQiC8rLexQL6u4v/qqxiyMpoLfIq76iyAMXCNT2+b5chg8qKV3QWsBRKZnHp2djbryctUpybv/MlTXpfIfgZWfj5UIRpHw==;5:5G9yGjU74X7p5PbCM+6iEWlzhGdTon3vdZ2RQRVf568ysOEQ84xvhyJQJZaTJaeI51p8tGWs6V4o6/BcR9zZjcWrkeXkNfy9hLZmO/cT6toE4qpqMijfOMKmQUgOwVulSHIsXL4A600vB5mcn+KN8GL+HwnJ6pqwUIlN0TlK7ow=;7:HicJsr186vOCMK/HktiEQMGLEnQgZcsTWAgektgqhDwzK3uGGKm+7y58i75fXmu1rrmvnx5Z3sjud3MK+8Gi/EUiuMaKIW7zjorMrD5soezTwzbhMt5bh+o3JJwGwpNj0IY6jbEkdSoEhoF7WLm/AA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2e61b56b-c1d7-4ffb-fa42-08d64e82f7f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3636;
x-ms-traffictypediagnostic: CY4PR0601MB3636:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-microsoft-antispam-prvs: <CY4PR0601MB363650603EB3DF9D1E5872F6D3D90@CY4PR0601MB3636.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3636;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3636;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(103116003)(2201001)(6246003)(81166006)(2906002)(105586002)(81156014)(6512007)(8936002)(6116002)(3846002)(66066001)(53936002)(229853002)(86362001)(478600001)(106356001)(8676002)(14454004)(102836004)(7736002)(68736007)(26005)(4326008)(6506007)(36756003)(6486002)(71200400001)(99286004)(186003)(97736004)(76176011)(2900100001)(6436002)(4001150100001)(486006)(256004)(2501003)(71190400001)(25786009)(305945005)(476003)(11346002)(54906003)(316002)(446003)(2616005)(5660300001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3636;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9kpk5wzDf/f0R+6MPHE7j+QB7+dkZak5m1hjaiv0aLHos/RNV/vj0ZhJCuyRH4ZZvmTTPSeRIeOLRslN+fl8ymDdVb1V0eOy3xpvX6Mxd1ookh4dlfgH5tP09ftyn4XuKxtcr2e+3AQvTrvhgmK9OHkcuu0sstc3+vxaqPc2IdIs6WHtI4A53CpBbPA2XnKX3kZQXOH0z7AyjSKCHzY6MKU8PyEQZGov9C576JW8uH8zWClBAjCGEvBmKfO8Rdl7peIyaFl39vYUtCjJfPalXkaF/KUpg28hSusmtgK60YLxqu4TjqpAdwEGs40I65HIXlY/TWa8bl82rTkDxQaEGGmVZE2SLTqaW/o7RrXGevc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <35124F5A78DFE44DBD17E32E11905BEE@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e61b56b-c1d7-4ffb-fa42-08d64e82f7f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 00:56:13.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTIwIGF0IDAxOjI4ICswMTAwLCBBbmF0b2xpaiBHdXN0c2NoaW4gd3Jv
dGU6DQo+IEFkZCBVU0IgaW50ZXJmYWNlIGRyaXZlciBmb3IgQVJSSSBGUEdBIGNvbmZpZ3VyYXRp
b24gZGV2aWNlcyBiYXNlZCBvbg0KPiBGVERJIEZUMjMySCBjaGlwLiBEZXBlbmRpbmcgb24gVVNC
IFBJRCB0aGUgZHJpdmVyIHJlZ2lzdGVycyBkaWZmZXJlbnQNCj4gcGxhdGZvcm0gZGV2aWNlcyBk
ZXNjcmliaW5nIGFuIEZQR0EgY29uZmlndXJhdGlvbiBpbnRlcmZhY2UuDQoNCklzIEFSUkkgZGlm
ZmVyZW50IHRoYW4gQXJyaWE/DQoNCj4gKy8qIFVzZSBiYXVkcmF0ZSBjYWxjdWxhdGlvbiBib3Jy
b3dlZCBmcm9tIGxpYmZ0ZGkgKi8NCj4gK3N0YXRpYyBpbnQgZnRkaV90b19jbGtiaXRzKGludCBi
YXVkcmF0ZSwgdW5zaWduZWQgaW50IGNsaywgaW50IGNsa19kaXYsDQoNCkxpbnV4IHVzZXMgdW5z
aWduZWQgdmFsdWVzIGZvciBjbG9ja3MuICBEb2VzIGl0IG1ha2UgYW55IHNlbnNlIHRvIG1peA0K
dGhlIHVuc2lnbmVkIGNsayB3aXRoIHNpZ25lZCB2YWx1ZXM/ICBTZWVtcyBsaWtlIGJhdWRyYXRl
IGFuZCBjbGtfZGl2DQpzaG91bGQgYWxzbyBiZSB1bnNpZ25lZC4NCg0KPiArCQkJICAgdW5zaWdu
ZWQgbG9uZyAqZW5jb2RlZF9kaXZpc29yKQ0KDQp1bnNpZ25lZCBsb25nIGlzIGFuIG9kZCBjaG9p
Y2UgaGVyZS4gIElzIHRoZXJlIGFueSB0byByZWFzb24gdG8gdXNlIGFuDQp1bnNpZ25lZCBsb25n
IHRvIHN0b3JlIHRoZSByZXN1bHQgb2YgcmlnaHQgc2hpZnRpbmcgYSBzaWduZWQgaW50DQooYmVz
dF9kaXYpPyAgSXQgY2FuJ3QgYmUgbG9uZ2VyIHRoYW4gYSBpbnQsIGJ1dCBpdCBjYW4gYmUgbmVn
YXRpdmUuDQoNCj4gK3sNCj4gKwlzdGF0aWMgY29uc3QgY2hhciBmcmFjX2NvZGVbOF0gPSB7IDAs
IDMsIDIsIDQsIDEsIDUsIDYsIDcgfTsNCj4gKwlpbnQgYmVzdF9iYXVkID0gMDsNCj4gKwlpbnQg
ZGl2LCBiZXN0X2RpdjsNCj4gKw0KPiArCWlmIChiYXVkcmF0ZSA+PSBjbGsgLyBjbGtfZGl2KSB7
DQo+ICsJCSplbmNvZGVkX2Rpdmlzb3IgPSAwOw0KPiArCQliZXN0X2JhdWQgPSBjbGsgLyBjbGtf
ZGl2Ow0KPiArCX0gZWxzZSBpZiAoYmF1ZHJhdGUgPj0gY2xrIC8gKGNsa19kaXYgKyBjbGtfZGl2
IC8gMikpIHsNCj4gKwkJKmVuY29kZWRfZGl2aXNvciA9IDE7DQo+ICsJCWJlc3RfYmF1ZCA9IGNs
ayAvIChjbGtfZGl2ICsgY2xrX2RpdiAvIDIpOw0KPiArCX0gZWxzZSBpZiAoYmF1ZHJhdGUgPj0g
Y2xrIC8gKDIgKiBjbGtfZGl2KSkgew0KPiArCQkqZW5jb2RlZF9kaXZpc29yID0gMjsNCj4gKwkJ
YmVzdF9iYXVkID0gY2xrIC8gKDIgKiBjbGtfZGl2KTsNCj4gKwl9IGVsc2Ugew0KPiArCQkvKg0K
PiArCQkgKiBEaXZpZGUgYnkgMTYgdG8gaGF2ZSAzIGZyYWN0aW9uYWwgYml0cyBhbmQNCj4gKwkJ
ICogb25lIGJpdCBmb3Igcm91bmRpbmcNCj4gKwkJICovDQo+ICsJCWRpdiA9IGNsayAqIDE2IC8g
Y2xrX2RpdiAvIGJhdWRyYXRlOw0KPiANCj4gKwkJaWYgKGRpdiAmIDEpCS8qIERlY2lkZSBpZiB0
byByb3VuZCB1cCBvciBkb3duICovDQo+ICsJCQliZXN0X2RpdiA9IGRpdiAvIDIgKyAxOw0KPiAr
CQllbHNlDQo+ICsJCQliZXN0X2RpdiA9IGRpdiAvIDI7DQoNCkluIExpbnV4IHdlIHdvdWxkIHdy
aXRlOg0KDQpiZXN0X2RpdiA9IERJVl9ST1VORF9VUChkaXYsIDIpOw0KDQpUaG91Z2ggSSB0aGlu
ayB5b3UgY2FuIGNvbWJpbmUgdGhhdCB3aXRoIHRoZSBhYm92ZSB0byBnZXQ6DQoNCmJlc3RfZGl2
ID0gRElWX1JPVU5EX0NMT1NFU1QoY2xrICogOCAvIGNsa19kaXYsIGJhdWRyYXRlKTsNCg0KVGhh
dCB3aGF0IHRoZSBhYm92ZSBpcyB0cnlpbmcgdG8gYWNjb21wbGlzaCBpbiBhIHJvdW5kIGFib3V0
IHdheQ0KDQo+ICsJCWlmIChiZXN0X2RpdiA+IDB4MjAwMDApDQo+ICsJCQliZXN0X2RpdiA9IDB4
MWZmZmY7DQoNCkxvb2tzIGxpa2UgdGhlIGFib3ZlIHdhcyBwcm9iYWJseSBzdXBwb3NlZCB0byBi
ZSA+PQ0KDQo+ICsJCWJlc3RfYmF1ZCA9IGNsayAqIDE2IC8gY2xrX2RpdiAvIGJlc3RfZGl2Ow0K
PiArCQlpZiAoYmVzdF9iYXVkICYgMSkJLyogRGVjaWRlIGlmIHRvIHJvdW5kIHVwIG9yIGRvd24g
Ki8NCj4gKwkJCWJlc3RfYmF1ZCA9IGJlc3RfYmF1ZCAvIDIgKyAxOw0KPiArCQllbHNlDQo+ICsJ
CQliZXN0X2JhdWQgPSBiZXN0X2JhdWQgLyAyOw0KDQpBZ2FpbiwgbG9va3MgbGlrZSBhIGNvbXBs
aWNhdGVkIHdheSB0byByb3VuZCB0byB0aGUgbmVhcmVzdC4NCg0KPiArCQkqZW5jb2RlZF9kaXZp
c29yID0gKGJlc3RfZGl2ID4+IDMpIHwNCj4gKwkJCQkgICAoZnJhY19jb2RlW2Jlc3RfZGl2ICYg
MHg3XSA8PCAxNCk7DQo+ICsJfQ0KPiArCXJldHVybiBiZXN0X2JhdWQ7DQo+IA==
