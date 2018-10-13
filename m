Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E976AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A87206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Xki1VKT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A87206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJMWwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:52:12 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com ([40.107.4.113]:39968
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbeJMWwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaXN5/MmfwQy9LSV6UNs22sIuSZApxLwlzRiLHhvrQo=;
 b=Xki1VKT6rdI7FO2M3Uh+8LkEyrutYaRE/arRYKaleGZ5mYkzw0Hco7stw3FYLHCRXXq1w0yD9NK+18ixUcz+fP+jD9DPeOSSIGcsBnTHad5/W+KFQEoHGitGuJlCAyx6IIIZJ75mOvnakoBE7LSgoxIJ1PX1UQObIkApPbpp6Pk=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2320.eurprd02.prod.outlook.com (10.168.63.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Sat, 13 Oct 2018 15:14:35 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1228.020; Sat, 13 Oct 2018
 15:14:35 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dpot-dac: mark expected switch fall-through
Thread-Topic: [PATCH] iio: dpot-dac: mark expected switch fall-through
Thread-Index: AQHUXy1dR3DPrllFh0W6+gqsRwwRKqUV8hIAgAcy34CAACuVgA==
Date:   Sat, 13 Oct 2018 15:14:34 +0000
Message-ID: <43e89449-d693-3e1b-711c-7c9c139d288d@axentia.se>
References: <20181008173528.GA31787@embeddedor.com>
 <ded46d23-0ec9-3fc8-3fc2-fa8003639272@axentia.se>
 <20181013133831.7dbd31e8@archlinux>
In-Reply-To: <20181013133831.7dbd31e8@archlinux>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0802CA0001.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::11) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2320;6:0qee6MVqKH9Npw3mmuFkQR/faVlT0TuuVSzF86bO/gdP+5SuYE+H9YRmx+EtZ81rqCAuBPgc76sBP4Jp9dmmY8vz3EYNQiEo+oJn4RW7gzuYw8K7YRQwzarC7SL/1KnwQYYxCO/ta4enMDPytPsKjEqZVjG3waxBbuI1RKLh36qSV5BeMRMmy69wcjojIDnSaN6fr8dBZ4cVcgs+A7qgkPlOhqAtvueDgRIG1FmQlKfaP5pLSptM7MfrGMwy2TPbD5r5SWIGa/3VZPVhJP0csXoWyO4hVd2anhQwAJfegvu/NTXJ25xcohdglnQtF4YMuIS9lUkH6uCs8wZWWrCDuEOAr1mV+8lcZAxg8irAwfuZoQRvedX3QWxvPgrdfpT4dEMvT2qP32iOVTQYaVBI+aJOEVv6yB6CvX9Qj3b65wE5lVULvCy7SLXmRd9UguovqvItbOKCbQKJcDOmyHzzaw==;5:rpB/fMrRSeffJSIy2sKzwTmZ4BflYRaZL85RjxOQSJlT8GlCoOSVKdqTrXakDEXlZL4HjvvVl0dZ5mmKWJp1Jv1QkGKJXrUUyH9xnWXGPgwaJ1N7RQMwSa6ZkfBoBtowvrjvHGuXFdYdU1K6067iiACx8Ps/xnAuko12JdgS5Bc=;7:/j35qmBBAKeVDsAaGlG93zj2yIBSdCSVTmxmXrto0KL+0Ownmj4oG5r4cVLzSXgIy46WrYXZP7pEmXfw4vRvw7649HeWsDHiRTe5PUHaDF9ulI3U1xsvgH8K7oDiW51M89mhym8pDG1CL9aFhgSSN+ErizuAvcxuFVh9MEK5CCkNy+pUL9RkW3PX08He7SDwIT514abxUSXAzCq+u+FNU9eSiMr1wVR4dYtwdTrIYlnStFRK/MgASil0pZa0ZLHw
x-ms-office365-filtering-correlation-id: cd47542d-3c2a-4e84-cd1d-08d6311e9556
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2320;
x-ms-traffictypediagnostic: VI1PR0201MB2320:
x-microsoft-antispam-prvs: <VI1PR0201MB2320CBCA06C14DEECC262E53BCE30@VI1PR0201MB2320.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991067);SRVR:VI1PR0201MB2320;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2320;
x-forefront-prvs: 082465FB26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39830400003)(396003)(199004)(189003)(68736007)(508600001)(14454004)(5660300001)(65826007)(58126008)(36756003)(6916009)(54906003)(5250100002)(6116002)(2906002)(3846002)(4001150100001)(66066001)(65956001)(2900100001)(65806001)(74482002)(305945005)(7736002)(4326008)(6512007)(31686004)(3260700006)(25786009)(53936002)(71190400001)(71200400001)(6246003)(97736004)(105586002)(6486002)(229853002)(26005)(386003)(106356001)(102836004)(53546011)(6506007)(64126003)(76176011)(99286004)(186003)(86362001)(575784001)(8936002)(31696002)(81156014)(81166006)(52116002)(8676002)(6436002)(446003)(2616005)(11346002)(476003)(486006)(14444005)(316002)(256004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2320;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cOIX7M01mDr8u5YRwPqO7Jw+oXjCf6FTYPWKM3bH/5Zs8AfUkPmZq0nmq0lWyGbE4iACn/pemKYPi08u6Jfhs7LJOqFLYraYp9aiWFCU5o/i8x7A5waYhoEM7FjFYegojF3dXAVgkWNcZenOD7iBF93WY+rzY2HJNsyaPYKn/hDoQjoZBNi7Puc/OzTNELrGp1cWfxxDUGuUHe+uFRNeN+a5L5PGuDuf+liRR0pg+1Y9V/cg5jQ3alihep6rT6JjnkVOVEXcK8ZhthohmAYO+CVxohRb8Hu/55sc7fnWzTxHdW2jMQMsmBRTmQr4ANcdnpACrsIR5uwyhW63Ghc31m06eej99v99tIjKPLAktkY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C286D9CCB42A1459F8B4B7EB4161522@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cd47542d-3c2a-4e84-cd1d-08d6311e9556
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2018 15:14:34.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMC0xMyAxNDozOCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gTW9uLCA4
IE9jdCAyMDE4IDIwOjQyOjQxICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+
IHdyb3RlOg0KPiANCj4+IE9uIDIwMTgtMTAtMDggMTk6MzUsIEd1c3Rhdm8gQS4gUi4gU2lsdmEg
d3JvdGU6DQo+Pj4gSW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhy
b3VnaCwgbWFyayBzd2l0Y2ggY2FzZXMNCj4+PiB3aGVyZSB3ZSBhcmUgZXhwZWN0aW5nIHRvIGZh
bGwgdGhyb3VnaC4gIA0KPj4NCj4+IFRoZSB3YXkgSSBzZWUgaXQsIGl0IGlzIHByZXR0eSB3ZWxs
IG1hcmtlZCB1cCBhcyBpcy4gU28sIHRoaXMgcGFyYWdyYXBoDQo+PiBpcyBub3QgZGVzY3JpYmlu
ZyB0aGUgY2hhbmdlLg0KPj4NCj4+Pg0KPj4+IE5vdGljZSB0aGF0IGluIHRoaXMgcGFydGljdWxh
ciBjYXNlLCBJIHJlcGxhY2VkICIuLi5hbmQgZmFsbCB0aHJvdWdoLiINCj4+PiB3aXRoIGEgcHJv
cGVyICJmYWxsIHRocm91Z2giLCB3aGljaCBpcyB3aGF0IEdDQyBpcyBleHBlY3RpbmcgdG8gZmlu
ZC4gIA0KPj4NCj4+IFdoYXQgaXMgbm90ICJwcm9wZXIiIGFib3V0IHRoZSBleGlzdGluZyBjb21t
ZW50PyBZZXMgeWVzLCBJICprbm93KiB0aGF0DQo+PiBHQ0MgaXMgbm90IHZlcnkgaW50ZWxsaWdl
bnQgYWJvdXQgaXQgYW5kIHJlcXVpcmVzIGhhbmQtaG9sZGluZywgYnV0DQo+PiBibGFtaW5nIHRo
ZSBleGlzdGluZyBjb21tZW50IGZvciBub3QgKnByb3Blcmx5KiBtYXJraW5nIGFuIGludGVudGlv
bmFsDQo+PiBmYWxsIHRocm91Z2ggaXMgLi4uIHJpY2guDQo+Pg0KPj4+DQo+Pj4gQWRkcmVzc2Vz
LUNvdmVyaXR5LUlEOiAxNDYyNDA4ICgiTWlzc2luZyBicmVhayBpbiBzd2l0Y2giKQ0KPj4+IFNp
Z25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+
DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvaWlvL2RhYy9kcG90LWRhYy5jIHwgMiArLQ0KPj4+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lpby9kYWMvZHBvdC1kYWMuYyBiL2RyaXZlcnMvaWlvL2RhYy9k
cG90LWRhYy5jDQo+Pj4gaW5kZXggYTc5MWQwYS4uZTM1Mzk0NiAxMDA2NDQNCj4+PiAtLS0gYS9k
cml2ZXJzL2lpby9kYWMvZHBvdC1kYWMuYw0KPj4+ICsrKyBiL2RyaXZlcnMvaWlvL2RhYy9kcG90
LWRhYy5jDQo+Pj4gQEAgLTc4LDcgKzc4LDcgQEAgc3RhdGljIGludCBkcG90X2RhY19yZWFkX3Jh
dyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCAgDQo+Pg0KPj4gQWRkaW5nIHNvbWUgbW9yZSBj
b250ZXh0IGhlcmUuDQo+Pg0KPj4gCQljYXNlIElJT19WQUxfSU5UOg0KPj4gCQkJLyoNCj4+IAkJ
CSAqIENvbnZlcnQgaW50ZWdlciBzY2FsZSB0byBmcmFjdGlvbmFsIHNjYWxlIGJ5DQo+PiAJCQkg
KiBzZXR0aW5nIHRoZSBkZW5vbWluYXRvciAodmFsMikgdG8gb25lLi4uDQo+Pj4gIAkJCSAqLw0K
Pj4+ICAJCQkqdmFsMiA9IDE7DQo+Pj4gIAkJCXJldCA9IElJT19WQUxfRlJBQ1RJT05BTDsNCj4+
PiAtCQkJLyogLi4uYW5kIGZhbGwgdGhyb3VnaC4gKi8NCj4+PiArCQkJLyogZmFsbCB0aHJvdWdo
ICovDQo+Pj4gIAkJY2FzZSBJSU9fVkFMX0ZSQUNUSU9OQUw6DQo+Pj4gIAkJCSp2YWwgKj0gcmVn
dWxhdG9yX2dldF92b2x0YWdlKGRhYy0+dnJlZikgLyAxMDAwOw0KPj4+ICAJCQkqdmFsMiAqPSBk
YWMtPm1heF9vaG1zOw0KPj4+ICAgDQo+Pg0KPj4gQ29uc2lkZXJpbmcgdGhlIGFib3ZlIGFkZGVk
IGNvbnRleHQsIEkgaGF2ZSB0byBzYXkgdGhhdCB0aGlzIG1pbmRsZXNzDQo+PiBjaGFuZ2UgaXMg
bm90IGFuIGltcHJvdmVtZW50LCBhcyB5b3UgaGF2ZSBqdXN0IGRlc3Ryb3llZCB0aGUgY29udGlu
dWVkDQo+PiBzZW50ZW5jZSBmcm9tIHRoZSBwcmV2aW91cyBjb21tZW50LiBZb3UgbXVzdCBoYXZl
IG5vdGljZWQgdGhhdCB0aGlzDQo+PiB3YXMgdGhlIGVuZCBvZiBhIGNvbnRpbnVlZCBzZW50ZW5j
ZSwgYXMgeW91IGV2ZW4gcXVvdGVkIGl0IGluIHRoZSBjb21taXQNCj4+IG1lc3NhZ2UuIFRoZSBi
aWcgcXVlc3Rpb24gaXMgd2h5IHlvdSBkaWQgbm90IHN0b3AgdG8gdGhpbmsgYW5kIGNvbnNpZGVy
DQo+PiB0aGUgY29udGV4dD8NCj4+DQo+PiBZZXMsIEknbSBhbm5veWVkIGJ5IG1pbmRsZXNzIGNo
YW5nZXMuIEVzcGVjaWFsbHkgbWluZGxlc3MgY2hhbmdlcyBhaW1lZA0KPj4gYXQgaW1wcm92aW5n
IHJlYWRhYmlsaXR5IHdoaWxlIGluIGZhY3QgbWFraW5nIHRoaW5ncyBsZXNzIHJlYWRhYmxlLg0K
Pj4NCj4+IFRMO0RSLCBpZiB5b3UgYXJlIGRlc3BlcmF0ZSB0byBmaXggInRoZSBwcm9ibGVtIiB3
aXRoIHRoaXMgZmFsbCB0aHJvdWdoDQo+PiBjb21tZW50LCBwbGVhc2UgZG8gc28gaW4gYSB3YXkg
dGhhdCBwcmVzZXJ2ZXMgb3ZlcmFsbCByZWFkYWJpbGl0eS4gQW5kDQo+PiBpdCB3b3VsZCBiZSBu
aWNlIHRvIG5vdCBibGFtZSB0aGUgZXhpc3RpbmcgY29kZSBmb3IgYnJhaW4gZGFtYWdlIGluIEdD
Qw0KPj4gYW5kIHZhcmlvdXMgb3RoZXIgc3RhdGljIGFuYWx5emVycy4NCj4+DQo+PiBDaGVlcnMs
DQo+PiBQZXRlcg0KPiBJIGFncmVlIHdpdGggeW91IGluIHByaW5jaXBsZSBQZXRlciBhbmQgaGF2
ZSB0d2Vha2VkIHRoZSBwYXRjaCBkZXNjcmlwdGlvbg0KPiB0byBtYWtlIGl0IGNsZWFyZXIgdGhh
dCB3ZSBhcmUgZG9pbmcgdGhpcyB0byBtYWtlIEdDQyBzdGF0aWMgYW5hbHlzaXMgbW9yZQ0KPiBo
ZWxwZnVsIChzdXBwcmVzc2luZyBhIGZhbHNlIHdhcm5pbmcgaXMgYSB3b3J0aHdoaWxlIGlmIHlv
dSBhcmUgZGVhbGluZyB3aXRoDQo+IGxvdHMgb2YgdGhlbSkuDQo+IA0KPiBIb3dldmVyLCBuaWNl
IHRob3VnaCBpdCBpcyB0byBoYXZlIGVsZWdhbnQgY29tbWVudCBzdHJ1Y3R1cmUgSSB0aGluayB3
ZQ0KPiBzaG91bGQgc3RpbGwgaGF2ZSB0aGlzIHBhdGNoIGluIHBsYWNlLiAgVGhpcyBlZmZvcnQg
dG8gJ2ZpeCcgdGhlc2UNCj4gd2FybmluZ3MgaGFzIGFscmVhZHkgaWRlbnRpZmllZCBhIGZldyBw
bGFjZXMgd2hlcmUgaXQgd2FzIHdyb25nIHNvDQo+IEknbSBrZWVuIHRvIHNlZSBpdCBhcHBsaWVk
IGJ5IGRlZmF1bHQgZXZlbiBpZiBpdCBpc24ndCBwZXJmZWN0Lg0KDQpJIHN0aWxsIG9iamVjdC4g
SXQgd291bGQgaGF2ZSBiZWVuIHNvIGRhbW4gZWFzeSBhbmQgaXQgZG9lcyBub3QgdGFrZSBhIHdo
b2xlDQpsb3Qgb2YgaW1hZ2luYXRpb24gdG8gcXVpZXQgZG93biBHQ0Mgd2hpbGUga2VlcGluZyB0
aGUgY29tbWVudHMgcmVhZGFibGUuIEp1c3QNCm1vdmUgdGhlICJhbmQiIHRvIHRoZSBwcmV2aW91
cyBjb21tZW50LCBsaWtlIHRoaXMuDQoNCgkJY2FzZSBJSU9fVkFMX0lOVDoNCgkJCS8qDQoJCQkg
KiBDb252ZXJ0IGludGVnZXIgc2NhbGUgdG8gZnJhY3Rpb25hbCBzY2FsZSBieQ0KCQkJICogc2V0
dGluZyB0aGUgZGVub21pbmF0b3IgKHZhbDIpIHRvIG9uZSwgYW5kLi4uDQoJCQkgKi8NCgkJCSp2
YWwyID0gMTsNCgkJCXJldCA9IElJT19WQUxfRlJBQ1RJT05BTDsNCgkJCS8qIGZhbGwgdGhyb3Vn
aCAqLw0KCQljYXNlIElJT19WQUxfRlJBQ1RJT05BTDoNCg0KT3IgYWRkIGEgc2VudGVuY2UsIGxp
a2UgdGhpcyAod2hpY2ggaXMgYSBiaXQgbW9yZSBmdW4gSU1PKQ0KDQoJCWNhc2UgSUlPX1ZBTF9J
TlQ6DQoJCQkvKg0KCQkJICogQ29udmVydCBpbnRlZ2VyIHNjYWxlIHRvIGZyYWN0aW9uYWwgc2Nh
bGUgYnkNCgkJCSAqIHNldHRpbmcgdGhlIGRlbm9taW5hdG9yICh2YWwyKSB0byBvbmUuLi4NCgkJ
CSAqLw0KCQkJKnZhbDIgPSAxOw0KCQkJcmV0ID0gSUlPX1ZBTF9GUkFDVElPTkFMOw0KCQkJLyog
Li4uYW5kIGZhbGwgdGhyb3VnaC4gU2F5IGl0IGFnYWluIGZvciBHQ0MuICovDQoJCQkvKiBmYWxs
IHRocm91Z2ggKi8NCgkJY2FzZSBJSU9fVkFMX0ZSQUNUSU9OQUw6DQoNCkNoZWVycywNClBldGVy
DQo=
