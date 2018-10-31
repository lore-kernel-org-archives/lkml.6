Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277DFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A242081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emutex.onmicrosoft.com header.i=@emutex.onmicrosoft.com header.b="afMdq/t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A242081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeKAFkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:40:32 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com ([40.107.8.114]:59176
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729837AbeKAFkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emutex.onmicrosoft.com; s=selector1-emutex-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJazY2ZgMOJI+PZZ231yzDTkt9hMx7GVzNkylPrfrrY=;
 b=afMdq/t1RmhcOjcDwdhZNwvx4FLEIlbzT+UtWxroHkB91CfvKhIp7GOee0Jo7ojB7AIJmVds1/H9avIugS2ANLTJ1uXSe8XVylsQzlj8Z/tz0yvVEurPkTB1VqYhlg9WOFav7AEAHbZSsANOON+N8CbLRgoMu5Rf4sMX6iuqhe8=
Received: from VI1P190MB0013.EURP190.PROD.OUTLOOK.COM (10.172.14.137) by
 VI1P190MB0494.EURP190.PROD.OUTLOOK.COM (10.165.198.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 31 Oct 2018 20:40:45 +0000
Received: from VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 ([fe80::71b0:31d3:faf9:3584]) by VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 ([fe80::71b0:31d3:faf9:3584%6]) with mapi id 15.20.1294.021; Wed, 31 Oct 2018
 20:40:45 +0000
From:   Dan O'Donovan <dan.odonovan@emutex.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan O'Donovan <dan.odonovan@emutex.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v2 1/3] mfd: upboard: Add UP2 platform controller driver
Thread-Topic: [PATCH v2 1/3] mfd: upboard: Add UP2 platform controller driver
Thread-Index: AQHUatOn/ozPfCtK6E+jLanRdnZEdKU53lSA
Date:   Wed, 31 Oct 2018 20:40:45 +0000
Message-ID: <cdf91d51-dfb5-b2dc-99af-60954cf32255@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-2-git-send-email-dan@emutex.com>
 <CAHp75VdkwfcPdSmB0dYBF_xwwXMqkrLOa1tL0xkOJ4DVcx8h8g@mail.gmail.com>
In-Reply-To: <CAHp75VdkwfcPdSmB0dYBF_xwwXMqkrLOa1tL0xkOJ4DVcx8h8g@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:10::17) To VI1P190MB0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:a0::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dan.odonovan@emutex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.51.199.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1P190MB0494;6:xMoAofV1YkfYhPBJSohFTjdEjCgY86/wH4xg8gcAtuEsI6iKRnSHsAp0uGWMnBOu11CNSookMDUAvZpzJlDhniUJ8+ujFvNS4PRgZze5ulGKlJZV5TmZccmZQ0YD8j1idnErg9BT8Rn2Zw2HwCZoAbwtsLjccLaeUNF7LuTC44ZHcVT8GPUNCDRBbXWJ4VydFc6RaHQRBvjZPceUCGp+c0Ef9o8wj0KLSLds7MHwi5j01rhwYUXTDuFsGf56rEV2DeU6aYTM22MhemG/mAGF84m97HzEb4jlGqkuBi45ssmynY3edZEybeL/7y4n9QMvOuWv4UToaTj+rHjHvgtHo4uIH0sev+/qOcZJtXYaM2VrUQ+7IRl/BGSumjOjk3ldRl3YyOC/OLMyt/dzdeEPIqxHXYiIdJvBr5ypvZRDCGy7L4Njoum+164+Ma8dJPsNOD4DvPyNbaCO5APV4eitUQ==;5:g7sFVQtBdEz731BgAmVFcIv1wTYsgGBm6sjXWyJq3XnL8E+CD57F8OMorrwpWjg5tSDsk8dlFxyuXPq3MtDOhzZFAuF4bNGzlau5eU2NsNrbU9zQHfYPhIOeglOAR6vlOIfAmUykYjDrRUplOCw3w1S4IXuC41gq1mQN0V4raos=;7:TF8wJxFqkXCbje+hCm/jNRhGv0qpa10gDDf8JO0KxvTWKC6oC6Ctmktn9VsVJInFoDeNgRcSxL1TPtRAiQ75WIYc4TH8j83Cga/4hvGuoJJgCK1avU8QhZqc2bchM8y9CWCurr7wwvHD7EH+9W5CtQ==
x-ms-office365-filtering-correlation-id: 71a4ca6e-246a-41c9-e0b9-08d63f7121eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1P190MB0494;
x-ms-traffictypediagnostic: VI1P190MB0494:
x-microsoft-antispam-prvs: <VI1P190MB04944EA34FB2A5522E9ECA81F8CD0@VI1P190MB0494.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(278428928389397)(192278398808882)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(6059035)(201703131423095)(20161123555045)(201703061421075)(201703151056150)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1P190MB0494;BCL:0;PCL:0;RULEID:;SRVR:VI1P190MB0494;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(376002)(136003)(396003)(366004)(199004)(189003)(31696002)(6506007)(498600001)(68736007)(446003)(55236004)(66066001)(2900100001)(5660300001)(186003)(486006)(86362001)(38480400004)(7416002)(26005)(97736004)(386003)(81156014)(53546011)(8676002)(81166006)(7736002)(8936002)(6116002)(53936002)(3846002)(305945005)(52116002)(6486002)(105586002)(6246003)(99286004)(2906002)(6512007)(106356001)(38600400001)(110136005)(256004)(39060400002)(107886003)(38500400001)(5250100002)(14454004)(4326008)(2616005)(71200400001)(71190400001)(586005)(31686004)(36756003)(6306002)(93886005)(11346002)(229853002)(476003)(38610400001)(25786009)(102836004)(966005)(76176011)(6436002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1P190MB0494;H:VI1P190MB0013.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: emutex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8uJeP26J2xc77tO2Vu/8l3fyfJ5NItVHqHs6P2Ei7Iad4U4OXUU91xI0qtPdPOAAADTpm9DFQOtU2uBISMFOtVeiEvFsNW06gIUo77emYH/SnWBFJ5VESthay0TeTY9TCLnLOHNMB04Gsem6x2z81a8ZmzXn6HUthd/0TCqooJWqY2klkdmVCfIMIhRNCZguI8LsKLPBfIkhTME6jeLXt0CKo9tuGg8BRAxY85muS9m283nCNwzx7086B1eTL1yH84jHkixCzl6kVkhzXdwzsirvTAtEyNkLkBmQMzstmYCRStN31TgW4A/5jxe/PHU3TOemvW0gtW5M1mHF8fwOlSrqnA5tta2XSVpSW1VGYGs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA21931C4422744687ECC1B11E2A1830@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: emutex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a4ca6e-246a-41c9-e0b9-08d63f7121eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 20:40:45.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cc844b-5c53-4da1-99da-34ef4089ea8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8yMC8yMDE4IDEyOjQ5IFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIEZy
aSwgT2N0IDE5LCAyMDE4IGF0IDg6MjYgUE0gRGFuIE8nRG9ub3ZhbiA8ZGFuQGVtdXRleC5jb20+
IHdyb3RlOg0KPj4gRnJvbTogSmF2aWVyIEFydGVhZ2EgPGphdmllckBlbXV0ZXguY29tPg0KPj4N
Cj4+IFVQIFNxdWFyZWQgKFVQMikgaXMgYSB4ODYgU0JDIGZyb20gQUFFT04gYmFzZWQgb24gSW50
ZWwgQXBvbGxvIExha2UuIEl0DQo+PiBmZWF0dXJlcyBhIE1BWCAxMCBGUEdBIHRoYXQgcm91dGVz
IGxpbmVzIGZyb20gYm90aCBTb0MgYW5kIG9uLWJvYXJkDQo+PiBkZXZpY2VzIHRvIHR3byBJL08g
aGVhZGVyczoNCj4+DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
NDAtcGluIFJQaS1saWtlIGhlYWRlciB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgKy0t
LS0tLXwgICAgICAgICAoSEFUKSAgICAgICAgICB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+PiAgICAgKy0tLS0tLS0rICAg
ICstLS0tLS0tLSsNCj4+ICAgICB8ICAgICAgIHwgICAgfCAgICAgICAgfCAgICAgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSsNCj4+ICAgICB8ICBTb0MgIHwtLS0tfCAgRlBHQSAgfC0tLS0tfCAg
Q3VzdG9tIFVQMiBwaW4gaGVhZGVyIHwNCj4+ICAgICB8ICAgICAgIHwgICAgfCAgICAgICAgfCAg
ICAgfCAgICAgICAgKEVYSEFUKSAgICAgICAgIHwNCj4+ICAgICArLS0tLS0tLSsgICAgKy0tLS0t
LS0tKyAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLSogT24tYm9hcmQg
ZGV2aWNlczogTEVELCBWTFMuLi4NCj4+DQo+PiBUaGlzIGlzIGludGVuZGVkIHRvIGVuYWJsZSB2
ZW5kb3Itc3BlY2lmaWMgYXBwbGljYXRpb25zIHRvIGN1c3RvbWl6ZSBJL08NCj4+IGhlYWRlciBw
aW5vdXQsIGFzIHdlbGwgYXMgaW5jbHVkZSBsb3ctbGF0ZW5jeSBmdW5jdGlvbmFsaXR5LiBJdCBh
bHNvDQo+PiBwZXJmb3JtcyB2b2x0YWdlIGxldmVsIHRyYW5zbGF0aW9uIGJldHdlZW4gdGhlIFNv
QyAoMS44VikgYW5kIEhBVCBoZWFkZXINCj4+ICgzLjNWKS4NCj4+DQo+PiBPdXQgb2YgdGhlIGJv
eCwgdGhpcyBibG9jayBpbXBsZW1lbnRzIGEgcGxhdGZvcm0gY29udHJvbGxlciB3aXRoIGENCj4+
IEdQSU8tYml0YmFuZ2VkIGNvbnRyb2wgaW50ZXJmYWNlLiBJdCdzIGVudW1lcmF0ZWQgYnkgQUNQ
SSBhbmQgcHJvdmlkZXMNCj4+IHJlZ2lzdGVycyB0byBjb250cm9sOg0KPj4NCj4+IC0gQ29uZmln
dXJhdGlvbiBvZiBhbGwgRlBHQS1yb3V0ZWQgaGVhZGVyIGxpbmVzLiBUaGVzZSBjYW4gYmUgZHJp
dmVuDQo+PiAgIFNvQy10by1oZWFkZXIsIGhlYWRlci10by1Tb0Mgb3Igc2V0IGluIGhpZ2ggaW1w
ZWRhbmNlLg0KPj4NCj4+IC0gT24tYm9hcmQgTEVEcyBhbmQgZW5hYmxlIGxpbmVzIGZvciBvdGhl
ciBwbGF0Zm9ybSBkZXZpY2VzLg0KPj4NCj4+IEFkZCBjb3JlIHN1cHBvcnQgZm9yIHRoaXMgcGxh
dGZvcm0gY29udHJvbGxlciBhcyBhIE1GRCBkZXZpY2UsIGV4cG9zaW5nDQo+PiB0aGVzZSByZWdp
c3RlcnMgYXMgYSByZWdtYXAuDQo+IENhbiB3ZSBzZWUgYSBsaW5rIHRvIG9yIGFuIGV4Y2VycHQg
b2YgQUNQSSB0YWJsZSBmb3IgdGhpcyBkZXZpY2U/DQpTdXJlOiBodHRwczovL2dpc3QuZ2l0aHVi
LmNvbS9EYW4tRW11dGV4LzYzODJjMjVmNGI4YjhjZGQ4MGU2MDU2ODg5Y2RmNDhiDQpJJ2xsIGFk
ZCB0aGlzIHRvIHRoZSBjb3ZlciBsZXR0ZXIgZm9yIHYzIGFzIHdlbGwuDQoNCj4NCj4+ICsjZGVm
aW5lIHNldF9jbGVhcih1LCB4KSBncGlvZF9zZXRfdmFsdWUoKHUpLT5jbGVhcl9ncGlvLCAoeCkp
DQo+PiArI2RlZmluZSBzZXRfc3Ryb2JlKHUsIHgpIGdwaW9kX3NldF92YWx1ZSgodSktPnN0cm9i
ZV9ncGlvLCAoeCkpDQo+PiArI2RlZmluZSBzZXRfZGF0YWluKHUsIHgpIGdwaW9kX3NldF92YWx1
ZSgodSktPmRhdGFpbl9ncGlvLCAoeCkpDQo+PiArI2RlZmluZSBnZXRfZGF0YW91dCh1KSBncGlv
ZF9nZXRfdmFsdWUoKHUpLT5kYXRhb3V0X2dwaW8pDQo+IEkgdGhpbmsgdGhlc2UgbWFjcm9zIGRv
bid0IGJyaW5nIG11Y2ggdmFsdWUuIChVcCB0byB5b3UgYW5kIExlZSB0byBkZWNpZGUpDQpUaGVz
ZSB3ZXJlIGFkZGVkIGluIHJlc3BvbnNlIHRvIG9uZSBvZiB5b3VyIHJldmlldyBjb21tZW50cyBv
biB0aGUgb3JpZ2luYWwgcGF0Y2gtc2V0IDspDQpJIHRoaW5rIHRoZXkgZG8gc2xpZ2h0bHkgaW1w
cm92ZSB0aGUgY29kZSByZWFkYWJpbGl0eSBzbyBJJ2xsIGxlYXZlIHRoZW0gdGhlcmUgaWYgdGhl
cmUgYXJlIG5vIG9iamVjdGlvbnMuDQoNCj4NCj4NCj4+ICtzdGF0aWMgdm9pZCBfX3JlZ19pb193
cml0ZShjb25zdCBzdHJ1Y3QgdXBib2FyZF9kZGF0YSAqIGNvbnN0IGRkYXRhLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHNpemUsIHVuc2lnbmVkIGludCB2YWwp
DQo+PiArew0KPj4gKyAgICAgICBpbnQgaTsNCj4+ICsNCj4+ICsgICAgICAgLyoNCj4+ICsgICAg
ICAgICogREFUQUlOIGlzIGxhdGNoZWQgb24gZWFjaCByaXNpbmcgZWRnZSBvZiB0aGUgU1RST0JF
IHNpZ25hbC4NCj4+ICsgICAgICAgICogRGF0YSAocmVnaXN0ZXIgYWRkcmVzcyBvciB2YWx1ZSkg
aXMgc2VudCBNU2IgZmlyc3QuDQo+PiArICAgICAgICAqLw0KPj4gKyAgICAgICBmb3IgKGkgPSBz
aXplIC0gMTsgaSA+PSAwOyBpLS0pIHsNCj4gd2hpbGUgKHNpemUtLSkNClllcCwgbXVjaCBuZWF0
ZXIuwqAgSSdsbCBjaGFuZ2UgdGhhdCwgdGhhbmtzIcKgIERpdHRvIGZvciB0aGUgb3RoZXIgY29t
bWVudHMgb24gdGhpcyBmaWxlLisgcmV0ID0gdXBib2FyZF9pbml0X2dwaW8oZGV2KTsNCg0KPj4g
KyAgICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgaWYgKHJldCAhPSAtRVBST0JF
X0RFRkVSKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQg
dG8gaW5pdCBHUElPczogJWQiLCByZXQpOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+PiArICAgICAgIH0NCj4gSSBkb24ndCBrbm93IGlmIHByb2JlX2VycigpIGhlbHBlciBpcyBn
b2luZyB0byBiZSBhIHBhcnQgb2YgdjQuMjENCj4gKHdoaWNoIHRoaXMgc2VyaWVzIHRhcmdldHMp
LCBpdCB3b3VsZCBiZSBnb29kIHRvIHVzZSBpdC4NCkkgbGVmdCB0aGlzIG91dCBmb3Igbm93IGlu
IGNhc2UgaXQgY2F1c2VzIGFueSBhd2t3YXJkbmVzcyB3aXRoIG1lcmdpbmcuwqAgSG9wZSB0aGF0
J3Mgb2suDQoNCg==
