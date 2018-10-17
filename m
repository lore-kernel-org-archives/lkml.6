Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B8521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="xSgzKFSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B8521526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJQVG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:06:27 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:65531 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeJQVG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:06:27 -0400
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="19640493"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Oct 2018 06:10:49 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 17 Oct 2018 06:10:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB0Jl6LYTrM00VBR7QKx6HHrIALE0s5hwJaWjpvyi8o=;
 b=xSgzKFSIFETe5wh9KzBwKs+dBcQrSriCrCo3O0Cy0CuYp2ILkA2OGZQfMst8cWE/J6P7SMpGhPSGVb11zMGTkDniG6MfnDaYq7QYN5dnwALO4an2rPAMZ+Dj1zgyYWuEw/Efpiouu67BVGjBv6aMH6Dxwg4tpDqlrIKdH1NbIYk=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0711.namprd11.prod.outlook.com (10.163.111.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Wed, 17 Oct 2018 13:10:46 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff%6]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 13:10:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jonas@orbital-systems.com>,
        <alexander.stein@systec-electronic.com>
CC:     <linux-kernel@vger.kernel.org>, <sre@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
Thread-Topic: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
Thread-Index: AQHUZVRe/70fNEEmkkyQnDUBwInNrqUjXJ0sgAAOTQA=
Date:   Wed, 17 Oct 2018 13:10:46 +0000
Message-ID: <11b4bcb4-8882-bdd2-c7f7-6a74d0758cbc@microchip.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
 <2351196.3BzoFE0xYq@ws-140106>
 <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
In-Reply-To: <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0711;6:xpo8S7+yA2nocQJyiRsk4egBnEYaq8yjtFfctcDXLdtsnBFGo8UTlZ/mizhg1Ts7mhdfo8SvnKi/E31JrJpSeBXm20womq9B7O+w56LImZriW8R+3rhdcnqh1weRAwHWkq+hZPlpQdyuItvLzhEFXN6olKIhjWkcld260Ns9fNr6Cxh5Uow2SOFBTFvqf4zorGKtAr0qgl+Z8XMQWG72I2IujO5S1ymmfBioibo7v76+NVNOrwQUX+PMBoWah92KfuMu22ypJSuVVoaJTsBqRHPjhFx+zvuNo3zL7rkeiDD1rAIq17xaVxuG4HOFPvennFgjNyCpBIKI5cUh47B0y0DUCFyigTKbCTBK3O2uVkS1WvyIU8wma6vgUJrS1sIfaDwxgyrJZoEo6UGpkSA+t+uIvngf98ESkiGRzW2+AbY8LWPq0mlHMr2SQStg9zfzEOEUyAIVcMWUlWJHFAEM0A==;5:wNcsKcOBNq1ClHkU1WDwDg6RbeMsSV2xKT86SHPSNESwhhBWYvhNUWAVBdm6nKZrXMYLUxk9WAFpa7Pt3IwaBfhD1V7ImjsnXxnZt/lOtTjSVw11GiFCUxBbBdxAq0uU4JClpw70tdTuGcCgOaP1CGjb04FaJWBWxAj302YELBI=;7:nVj2tuHIxGsJ3M5LsYWLXRPMctOadW7+HZk1BjcAuS+tyho8D0Hb1e896j/CuCLebmfJ8F3sRwJ9qm+YArJ0RR9DFfxee/osJvAAx0peCoDQlEpiVIjXAd+x21HVLWkI/bfLbzzS+qlPMaBImIFtZBfOzTiGtFKv1H9hYk8muEffHzqPLX3+mhHLPx88eIHVs8NcimL5E+u1ipQ47zZXCUXf8oSWtTptz6YaQ3XoOp4KCOmeTs5872/sgjr77Udn
x-ms-office365-filtering-correlation-id: 9a403c11-8e4d-4916-e5db-08d63431f303
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0711;
x-ms-traffictypediagnostic: BY2PR11MB0711:
x-microsoft-antispam-prvs: <BY2PR11MB0711AFB2B670D227B95F1E5187FF0@BY2PR11MB0711.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0711;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0711;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(186003)(6486002)(26005)(8676002)(102836004)(76176011)(99286004)(6246003)(97736004)(31686004)(5250100002)(256004)(6512007)(14444005)(53546011)(25786009)(53936002)(4326008)(105586002)(2501003)(36756003)(66066001)(106356001)(8936002)(2900100001)(6436002)(5660300001)(386003)(14454004)(15760500003)(478600001)(110136005)(54906003)(93886005)(81166006)(476003)(71200400001)(81156014)(72206003)(2906002)(3846002)(6506007)(6116002)(71190400001)(486006)(86362001)(11346002)(52116002)(446003)(2616005)(31696002)(68736007)(305945005)(316002)(229853002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0711;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m4yoojhas8Q9jTFV0rzMNArdx2AwGAMfUayNbSLwXW8py/sYRW2FDORcji8cbuOKs12mxmjO/zubnASPgSvb1VnD2Nu7SaIg8BHtF24B6MVvkyihqyxbKqRhPNwHDeSoKURQ3V29v6wYxHL5yZ1zYZ4VbmCotQ4MWH2btVnmuMx6aCPo3RSBwERgUXHDE30XdNw/+GCTofJjcbrQ1kPA68Iv+TlChX9MwTZZZcC6zufjfOpdBQ72WCnXmdoSrdrjO42ylVB9++37BkfdwPKgsI5IM0vVgFOaYvY+4KUrJdnB2CrAhrxRUvlfFDKTMbVJY+ECyS+I3auQWxFCiCg5USdgKDmN6ZgxzL5NwUxTGAo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A3194EE76537459FE8CB5C5825BA00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a403c11-8e4d-4916-e5db-08d63431f303
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 13:10:46.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0711
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE3LjEwLjIwMTggMTU6MTcsIEpvbmFzIERhbmllbHNzb24gd3JvdGU6DQo+IE9uIFR1
ZSwgT2N0IDE2LCAyMDE4IGF0IDQ6NTIgUE0gQWxleGFuZGVyIFN0ZWluDQo+IDxhbGV4YW5kZXIu
c3RlaW5Ac3lzdGVjLWVsZWN0cm9uaWMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBUdWVzZGF5LCBP
Y3RvYmVyIDE2LCAyMDE4LCAzOjMwOjI0IFBNIENFU1QgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+PiBIaSBKb25hcywNCj4+Pg0KPj4+IE9uIDA3LjEwLjIwMTggMTU6NTcs
IEpvbmFzIERhbmllbHNzb24gd3JvdGU6DQo+Pj4+IEZyb206IEpvbmFzIERhbmllbHNzb24gPGpv
bmFzQG9yYml0YWwtc3lzdGVtcy5jb20+DQo+Pj4+DQo+Pj4+IFRoaXMgZml4ZXMgYSBidWcgd2hl
cmUgb3VyIGVtYmVkZGVkIHN5c3RlbSAoQVQ5MVNBTTkyNjAgYmFzZWQpIHdvdWxkDQo+Pj4+IGhh
bmcgYXQgcmVib290LiBBdCB0aGUgbW9zdCB3ZSBtYW5hZ2VkIDE2IGJvb3QgbG9vcHMgd2l0aG91
dCBhIGhhbmcuDQo+Pj4+DQo+Pj4+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkIHRoZSBwcm9ibGVt
IGhhcyBub3QgYmVlbiBvYnNlcnZlZCBhbmQgdGhlIGJvYXJkDQo+Pj4+IGhhcyBtYW5hZ2VkIGFi
b3ZlIDI1MCBib290IGxvb3BzLg0KPj4+Pg0KPj4+PiBUaGUgQVQ5MVNBTTkyNjAgZGF0YXNoZWV0
IHRlbGxzIHVzIHRoYXQgd2l0aCB0aGUgaW5zdHJ1Y3Rpb24gY2FjaGUNCj4+Pj4gZGlzYWJsZWQg
YWxsIGluc3RydWN0aW9ucyBhcmUgZmV0Y2hlZCBmcm9tIFNEUkFNLiBBbmQgd2UgaGF2ZSBhbiBl
cnJhdGENCj4+Pj4gdGVsbGluZyB1cyB3ZSBtdXN0IHBvd2VyIGRvd24gdGhlIFNEUkFNIGJlZm9y
ZSBpc3N1aW5nIGNwdSByZXNldC4NCj4+Pj4NCj4+Pj4gVGhpcyBtZWFucyB3ZSBuZWVkIHRoZSBp
bnN0cnVjdGlvbiBjYWNoZSBlbmFibGVkIGluIGF0OTFzYW05MjYwX3Jlc2V0KCkNCj4+Pj4gQXQg
dGhlIG1vbWVudCBpdCBpcyBiZWluZyBkaXNhYmxlZCBpbiBjcHVfcHJvY19maW4oKSB3aGljaCBp
cyBjYWxsZWQgZnJvbQ0KPj4+PiBhcmNoL2FybS9rZXJuZWwvcmVib290LmMuDQo+Pj4NCj4+PiBB
cmUgeW91IHVzaW5nIGtleGVjIHJlYm9vdCBvciBpbXBsZW1lbnRlZCBoaWJlcm5hdGUgbW9kZSBv
biB0aGlzIG1hY2hpbmU/DQo+Pj4gSSdtIHNlZWluZyBjcHVfcHJvY19maW4oKSBpcyBjYWxsZWQg
b25seSBpbiBjYXNlIG9mIGtleGVjIHJlYm9vdCBvcg0KPj4+IHN3aXRjaGluZyB0byBoaWJlcm5h
dGUgbW9kZS4NCj4+Pg0KPj4+IEluIGNhc2Ugb2Ygbm9ybWFsIHJlYm9vdCAoZS5nLiByZWJvb3Qg
Y29tbWFuZCkgbWFjaGluZV9yZXN0YXJ0KCkgZnJvbQ0KPj4+IGFyY2gvYXJtL2tlcm5lbC9yZWJv
b3QuYyBpcyBjYWxsZWQuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZy4NCj4+DQo+PiBB
bm90aGVyIGxvY2F0aW9uIGlzIGNwdV9yZXNldCgpIGFrYSBjcHVfYXJtOTI2X3Jlc2V0KCkgaW4g
cHJvYy1hcm05MjYuUw0KPj4gd2hpY2ggYWxzbyBkaXNhYmxlcyBJLWNhY2hlLiBCdXQgSSBjYW4n
dCB0cmFjayBkb3duIGEgY2FsbHN0YWNrDQo+PiBlbmRpbmcgdGhlcmUuDQo+Pg0KPiANCj4gV2Ug
dGFrZSB0aGUgbm9ybWFsIHBhdGggb2Ygc3lzX3JlYm9vdCA9PiBrZXJuZWxfcmVzdGFydCA9PiBt
YWNoaW5lX3Jlc3RhcnQgLi4uDQo+IA0KPiBJIGFkZGVkIGNvZGUgdG8gcHJpbnQgdGhlIGMxIHJl
Z2lzdGVyIGluIGRpZmZlcmVudCBwYXRocy4gQW5kIEktY2FjaGUNCj4gaXMgZW5hYmxlZC4NCj4g
U28gbm93IEkgYW0gcmVhbGx5IGNvbmZ1c2VkIGFib3V0IHdoeSB0aGUgcGF0Y2ggd29ya2VkLg0K
DQpKdXN0IHNheWluZy4uLiBtYXliZSB5b3VyIGluc3RydWN0aW9ucyBhZGQgc29tZSBkZWxheSBv
biB0aGUgZXhlY3V0aW9uIHBhdGgNCmFuZCB0aGlzIGlzIHdoeSBpdCBoZWxwcy4uLiB0cnkgdG8g
YWNjZXNzIGNwMTUgY28tcHJvY2Vzc29yIGZvciByZWFkIGFuZA0Kd3JpdGUgYmFjayB0aGUgdmFs
dWUgeW91IHJlYWQgd2l0aG91dCBhY3R1YWxseSB0byBtb2RpZnkgaXQsIHRvIHNlZSBpZiB0aGlz
DQpjb3VsZCBiZSB0aGUgcmVhc29uOiBlLmcuOg0KDQptcmMJcDE1LCAwLCByMCwgYzEsIGMwLCAw
DQpvcnIJcjEsIHIxLCAjNDA5NgkJLy8gd2hhdGV2ZXIgaXMgaW4gcjEsIGRvZXNuJ3QgbWF0dGVy
DQptY3IJcDE1LCAwLCByMCwgYzEsIGMwLCAwDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVh
DQoNCj4gDQo+PiBCZXN0IHJlZ2FyZHMsDQo+PiBBbGV4YW5kZXINCj4gDQo+IEpvbmFzDQo+IA0K
Pj4NCj4+DQo+Pg0KPiANCj4gDQo=
