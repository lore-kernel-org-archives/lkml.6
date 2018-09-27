Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C27AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840F821580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="C/zfmNM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840F821580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeI0Rdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:33:31 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:7872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbeI0Rdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARJ9pMEWl0rJ49rxeSr9JKfJDM3m1sVnVsqU8uh/FmU=;
 b=C/zfmNM1B7iA1ORWHcmM/lFsFkX+hMOh4LYPZUPX6yPQIqQjrjXFYGr0BjLlUzYQlLjVQkVTsKZhsTlXj6NBRE9O93+n2ioYLa9kWW7R3E8Q4W0it99D7tlfcDUB5zblqGfxd2Yr9gjLyWn6Ta8mfUEgmnSQ7418SvetVT6DUhM=
Received: from MW2PR07MB4042.namprd07.prod.outlook.com (52.132.179.25) by
 MW2PR07MB4009.namprd07.prod.outlook.com (52.132.179.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Thu, 27 Sep 2018 11:15:42 +0000
Received: from MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::e5fe:b69b:da0a:4717]) by MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::e5fe:b69b:da0a:4717%5]) with mapi id 15.20.1143.022; Thu, 27 Sep 2018
 11:15:42 +0000
From:   "Rangankar, Manish" <Manish.Rangankar@cavium.com>
To:     Colin King <colin.king@canonical.com>,
        Dept-Eng QLogic Storage Upstream 
        <QLogic-Storage-Upstream@cavium.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: qla4xxx: remove redundant check on drvr_wait
Thread-Topic: [PATCH] scsi: qla4xxx: remove redundant check on drvr_wait
Thread-Index: AQHUVZoTpJRvt3VQr0Kcn2NDwyntvKUD+2qg
Date:   Thu, 27 Sep 2018 11:15:42 +0000
Message-ID: <MW2PR07MB40429AAD3AC7C40972012788E3140@MW2PR07MB4042.namprd07.prod.outlook.com>
References: <20180926130848.30645-1-colin.king@canonical.com>
In-Reply-To: <20180926130848.30645-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Rangankar@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB4009;6:vuHRrhj6gVBSjFYpbLP3kWdxaAoQZu4g+5d3Gn7MRDNeo9r2vFzAgGVjFhq2GXi+HMGkUAsPCJeDxAN4ZhLbRYszks6FYwQct3nNkJMBiJ7Yil/MtgwhqMZ5IWhYc7h61usLEItvVAWC96Hmp1FtqJUdMxogPff4RkelF8CPyfPmGARIG7V37yzMu0Ds1kV3iFChsas5rJhrPTCWphT8ARmYYGBgZXNllrKMjgAYdAiExcRtKQgdz1Gz0V8D3G2WkmseW58O7FkruY6RCf5LXcLYPwLdKbvcrOnPUdXNabqt+t0bfVi08SYXH0la+HTnO4JPGEVvGt8F4I7DnoF8EtN6Q5KaAWPlpAoEsxoljIFlu8rNugzOqNDrZOINF6hQtgeKXo0S3H4RKqH6yRhkwC9Zs9X8qJE7aun7un5YtE49K7ytfcx5D7qSdyi87AAty+rtgF8CTWK99yMNtr5SvA==;5:hTWdquR2rsTDXcrzwm8hqvXAdoN0A0QrHJslj+6V1JfGnq7OtIvYHiOG+L0RmBXJSGrhq9FDfw2sPyOCoNURwV7njYeRFgz0VctyT/jhkbBmZPFZIztD/yq5VG53fzE8BhJKZ+az5F/kzWyPskiSfcZLj8+69ChELxJTiBlz1es=;7:L3ehX25PNTRzYqBDxMpHgisdBxwgMgVOpA9kAkSeUXKsirDL1aThb49NDv7NGGNNaO+3PIhiqY8SvKleffQL6AV24B0LO6pGAwcBajdR8BtbgBh17tp2uSqg3ziIDAdwgPtxII9BElWWL1arOfeW3OITwelVnUm85p4uKoWUjd6GWHl++b+U0tVjuL/+8IRrR8zes/mQqUQeAds1KQIqfkWtSpL6pHc2xgH8j3ByUQ2TWlh11iqLokIBN4Unzx8e
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e01148cb-2c12-48c8-5617-08d6246a903a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB4009;
x-ms-traffictypediagnostic: MW2PR07MB4009:
x-microsoft-antispam-prvs: <MW2PR07MB40098A8E166E0D201856D1B7E3140@MW2PR07MB4009.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(9452136761055)(17755550239193)(198206253151910)(104084551191319)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:MW2PR07MB4009;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB4009;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(189003)(199004)(13464003)(256004)(5250100002)(97736004)(14444005)(86362001)(575784001)(74316002)(2501003)(66066001)(4326008)(7736002)(305945005)(3846002)(6116002)(71190400001)(229853002)(55016002)(34290500001)(6436002)(53936002)(25786009)(9686003)(68736007)(476003)(6246003)(486006)(11346002)(446003)(99286004)(81166006)(81156014)(8676002)(478600001)(33656002)(7696005)(14454004)(8936002)(26005)(2906002)(186003)(110136005)(54906003)(102836004)(71200400001)(76176011)(106356001)(72206003)(5660300001)(316002)(2900100001)(6506007)(105586002)(53546011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4009;H:MW2PR07MB4042.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YMYWoAkp18QqLpY5M3sEdqEgEIBKl9+lPcODjJ29YLbgwUDpHE/4xiiHea/AbxgOjPezPGHWsvfMeQzVrcIs8yLD4ZDSGWx4zTWPsy1s27hTTCSMB/q1OQDvuhbUZCklmKxfZYJSaPwSb5hhOFtSfprveWEwQfIvS0wJGf/nGJyI5nEkRTSgdeph2rPR3M2gII1TBaZeWJiVBfpCHo3smU8dxNphcD0omNcaUrC8ypTLqwV36rjB6vMih0ovoVqlvr73JTagpTmQnSeP5xX5HcE9plLI1ehJ7BetY3ustGKIFe7HBDZezfPdeXaTw0rM8153lj21cvVIWpRGBEtoLjiWifMeSuP6y+rmj5t7IE0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01148cb-2c12-48c8-5617-08d6246a903a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 11:15:42.2478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENvbGluIEtpbmcgPGNvbGlu
LmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIw
MTggNjozOSBQTQ0KPiBUbzogRGVwdC1FbmcgUUxvZ2ljIFN0b3JhZ2UgVXBzdHJlYW0gPFFMb2dp
Yy1TdG9yYWdlLQ0KPiBVcHN0cmVhbUBjYXZpdW0uY29tPjsgSmFtZXMgRSAuIEogLiBCb3R0b21s
ZXkgPGplamJAbGludXgudm5ldC5pYm0uY29tPjsNCj4gTWFydGluIEsgLiBQZXRlcnNlbiA8bWFy
dGluLnBldGVyc2VuQG9yYWNsZS5jb20+OyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZw0KPiBD
Yzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNjc2k6IHFsYTR4eHg6IHJlbW92ZSByZWR1bmRh
bnQgY2hlY2sgb24gZHJ2cl93YWl0DQo+IA0KPiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gRnJvbTog
Q29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IFRoZSBjaGVj
ayBmb3IgYSBub24temVybyBkcnZyX3dhaXQgaXMgcmVkdW5kYW50IGFzIHRoZSBzYW1lIGNoZWNr
IGlzIHBlcmZvcm1lZA0KPiBlYXJsaWVyIGluIHRoZSBvdXRlciB3aGlsZSBsb29wLCB0aGUgaW5u
ZXIgY2hlY2sgd2lsbCBhbHdheXMgYmUgdHJ1ZSBpZiB3ZSByZWFjaGVkDQo+IHRoaXMgcG9pbnQg
aW5zaWRlIHRoZSB3aGlsZSBsb29wLg0KPiBSZW1vdmUgdGhlIHJlZHVuZGFudCBpZiBjaGVjay4N
Cj4gDQo+IERldGVjdGVkIGJ5IGNwcGNoZWNrOg0KPiAod2FybmluZykgSWRlbnRpY2FsIGlubmVy
ICdpZicgY29uZGl0aW9uIGlzIGFsd2F5cyB0cnVlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29s
aW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3Njc2kvcWxhNHh4eC9xbDRfaW5pdC5jIHwgMTAgKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvcWxhNHh4eC9xbDRfaW5pdC5jIGIvZHJpdmVycy9zY3NpL3FsYTR4eHgvcWw0
X2luaXQuYyBpbmRleA0KPiA1MmIxYTBiYzkzYzkuLjFlZjc0YWEyZDAwYSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9zY3NpL3FsYTR4eHgvcWw0X2luaXQuYw0KPiArKysgYi9kcml2ZXJzL3Njc2kv
cWxhNHh4eC9xbDRfaW5pdC5jDQo+IEBAIC03NjYsMTIgKzc2NiwxMCBAQCBpbnQgcWw0eHh4X2xv
Y2tfZHJ2cl93YWl0KHN0cnVjdCBzY3NpX3FsYV9ob3N0ICphKQ0KPiAgICAgICAgIHdoaWxlIChk
cnZyX3dhaXQpIHsNCj4gICAgICAgICAgICAgICAgIGlmIChxbDR4eHhfbG9ja19kcnZyKGEpID09
IDApIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3NsZWVwKFFMNF9MT0NLX0RSVlJfU0xF
RVApOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoZHJ2cl93YWl0KSB7DQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgREVCVUcyKHByaW50aygic2NzaSVsZDogJXM6IFdh
aXRpbmcgZm9yICINCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJHbG9iYWwgSW5pdCBTZW1hcGhvcmUoJWQpLi4uXG4iLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYS0+aG9zdF9ubywNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBkcnZyX3dhaXQpKTsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBE
RUJVRzIocHJpbnRrKCJzY3NpJWxkOiAlczogV2FpdGluZyBmb3IgIg0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJHbG9iYWwgSW5pdCBTZW1hcGhvcmUoJWQpLi4uXG4i
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGEtPmhvc3Rfbm8sDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGRydnJfd2Fp
dCkpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkcnZyX3dhaXQgLT0gUUw0X0xPQ0tfRFJW
Ul9TTEVFUDsNCj4gICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIERFQlVHMihwcmludGsoInNjc2klbGQ6ICVzOiBHbG9iYWwgSW5pdCBTZW1hcGhvcmUg
Ig0KPiAtLQ0KPiAyLjE3LjENCg0KVGhhbmtzLA0KDQpBY2tlZC1ieTogTWFuaXNoIFJhbmdhbmth
ciA8TWFuaXNoLlJhbmdhbmthckBjYXZpdW0uY29tPg0K
