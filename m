Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C6BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BB3208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="oJPiqKNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeHXJJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 05:09:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:1587 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbeHXJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 05:09:08 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id FC/6E-19809-E399F7B5; Fri, 24 Aug 2018 05:35:58 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRWlGSWpSXmKPExsVy9fgsM127mfX
  RBvvesFrMP3KO1eLwoheMFjc/fWO1uLxrDpvF0usXmSze3pnOYtG69wi7A7vHmnlrGD12zrrL
  7rF5hZbHplWdbB6fN8kFsEaxZuYl5VcksGacbr/AWnBbpKJp42KWBsYdIl2MXBwsAuuZJQ4+u
  M8G4ggJTGSSWNH2iQXCucso8fPgAqAMJwebgI7Eo5nrmUASIgILGSUuntgK5jALTGeSmPysnQ
  WkSljAWuJB238wW0TARmLZi9OMELaVxKQ/u5lAbBYBVYmd3z6B1fAKxEq8PXCECWLdTkaJ/8v
  OsIMkOAUcJXbNXgHUzMHBKCArcfWaDEiYWUBc4taT+WBzJAQEJJbsOc8MYYtKvHz8jxXEZhSI
  l2h4NQcqriNx9voTRghbSeJo8w0WCFtW4tL8bkaQvRIC+9kltp+cwAaR8JX4cfcZE0TiBKNE5
  +fNzCBHSAhoSextsYaosZBY0t0KNchG4tyD7VB2jsSH7hVQtpZEx5FZUIfKSazqfcgCMfMgs8
  TfVd+grpOReD3rDdMERr1ZSJ6bBbSOWUBTYv0ufYiwosSU7ofss8DhJShxcuYTlgWMLKsYLZK
  KMtMzSnITM3N0DQ0MdA0NjXSNDIx1DY1N9BKrdJP1Ukt1y1OLS3QN9RLLi/WKK3OTc1L08lJL
  NjECExgDEOxgvPUt+RCjJAeTkiiv6dK6aCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvKYz6qOFB
  ItS01Mr0jJzgKkUJi3BwaMkwisAkuYtLkjMLc5Mh0idYjTm+PN+6iRmjjvd0yYxC7Hk5eelSo
  nzioOUCoCUZpTmwQ2CpfhLjLJSwryMQKcJ8RSkFuVmlqDKv2IU52BUEuY1BJnCk5lXArfvFdA
  pTECnsDLXgpxSkoiQkmpgdAo21lhxKM5q9cNp4W09kzusj8+ot43cut5X5eY5v1s3L8VLCXNO
  /Kuz3/KCvwf7DlPT3UpTc83bwyO5OD0arsu8Xhy+f0n+o13Sj2MPusyrDfDae6m+cLWyReNUJ
  Y63NZmvw55XH7gcetSQc/2MjmarLscNXy5ndXIwdv3s5fhlZGUWpfBAiaU4I9FQi7moOBEADP
  4M5ewDAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-10.tower-302.messagelabs.com!1535088957!5965079!1
X-Originating-IP: [213.199.154.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8607 invoked from network); 24 Aug 2018 05:35:58 -0000
Received: from mail-ve1eur02lp0054.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (213.199.154.54)
  by server-10.tower-302.messagelabs.com with AES256-SHA256 encrypted SMTP; 24 Aug 2018 05:35:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMAbzkmH54QVtTCkyI9JFkF4jTBlKCJqWRK4w6mb9lg=;
 b=oJPiqKNPwSqKqwSJtIMeVfQRdbX4241SQRrVh+C90CQjkuk0usvfVgFN/uoWR3zco2g/Prtf0dW6/gXhExlFNgcm6O+f0tbMExkcFmGYOjNBk6JgD+9ksCYoFAcDievO4tSK/Gf4xdHTkQyT/SatzBs8QXCB/8cZ/Dt0sB/VHAE=
Received: from DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM (20.176.239.91) by
 DB7PR10MB2395.EURPRD10.PROD.OUTLOOK.COM (20.177.121.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Fri, 24 Aug 2018 05:35:54 +0000
Received: from DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::440b:d23:b994:eb63]) by DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::440b:d23:b994:eb63%2]) with mapi id 15.20.1059.023; Fri, 24 Aug 2018
 05:35:54 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roy Im <roy.im.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH V4 3/3] Input: new da7280 haptic driver
Thread-Index: AQHUOsHNaHoTAIoqzUS5sVD835mEvKTNdlgAgADbYEA=
Date:   Fri, 24 Aug 2018 05:35:54 +0000
Message-ID: <DB7PR10MB216980706A65A8E913A1BE7285360@DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1534830272.git.Roy.Im@diasemi.com>
 <2c28a93093c075e0145b70e7bc999f2654d0431d.1534830272.git.Roy.Im@diasemi.com>
 <6115d6ca-8df6-1830-3c61-681610d8f2b0@infradead.org>
In-Reply-To: <6115d6ca-8df6-1830-3c61-681610d8f2b0@infradead.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.100.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR10MB2395;6:3vWbeJWB51o0kkxRPgLUg5+Tg7dDGGXsdGs9MRvPsUL20c+zvFwNBletsSiQJwWuzTECLxAChHwscOdwCU2cAcrptYQ2K6zEwm+ILqG6Cno+/bIAlWzfEv77E0CYXEVdu7jT+r9JzCZDeb3+FRq/lziGUPGhIu5vE2Cm36BgDDBZ9v+BmIAEtaFmgTwQYOVZlpvrZOJ+AhzliPw6/6tzwU6Yy2cCZ6WTtoLCZpzpsVSW1dZHOsGs1JxO5aScYXAHU3iom44xKefOWQLmxWpINcv7ts85a3oPvz9PGE4xoCiNL/JqSCAeC2Nsi4Rm0D8zaVMxegO+Zz25J13w3DKkLYg5DH1gN3m9CzDozIKv+LxY8KA0/n77C+DOs76OSL2An4nPRrFbBG6h0ajUsDhk1qjcMmAu1sK8exHOaVIArlQUCvFExjq7CW3AK50Vl/XccLCP07Uy/wqOJ/TlDQ652w==;5:LI9SlXKI3jziCowTGWJTO6mp1jsKfqT84F54w9v8n2vJ9pekG2hcUhKxwbZLNWQMQKJhxnK5JA2ffZMkTEayRL+UZbKBRxfXFNUw8iSG61yQa9Ff/gqzbRxDpCYUvPnfv5JJeKPeOitSBL/bfnkVXq/YYJob5U9sI9tiGbOwpo0=;7:+wv3151hmjjQgMHJ4LV4Yru/Haq1SJJ8CU3saIDOXdp9GyS5AYK3yByPAPWDnX2HT19RqBDL8Jd4xivhEQPGDl9Rhz2gC80yetcW+B5/FZZI1IbXnyOCeC4sIv9KLp92HpeVBFcMCMV57w3f3A8kB6RG3Eh77CzVwCARdzdj84DJI0vF5xBZELJfUGeur59aYpiwE8NKoZkLVB9QryFaAhHj/eBckCYKkuYI69G0DB+/XVWSfIJPFjZUfc8Fuc4r
x-ms-office365-filtering-correlation-id: 87908b24-e096-4ebc-48ff-08d60983761f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR10MB2395;
x-ms-traffictypediagnostic: DB7PR10MB2395:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <DB7PR10MB239571FC5373E6B2117F09C4A2360@DB7PR10MB2395.EURPRD10.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DB7PR10MB2395;BCL:0;PCL:0;RULEID:;SRVR:DB7PR10MB2395;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39850400004)(189003)(199004)(316002)(25786009)(39060400002)(4326008)(256004)(6436002)(68736007)(55016002)(81166006)(105586002)(8936002)(81156014)(53936002)(14444005)(229853002)(66066001)(106356001)(9686003)(33656002)(110136005)(54906003)(99286004)(7696005)(76176011)(97736004)(2900100001)(6246003)(476003)(5250100002)(26005)(8676002)(6116002)(11346002)(305945005)(7736002)(3846002)(6506007)(102836004)(478600001)(446003)(186003)(86362001)(2906002)(486006)(5660300001)(14454004)(575784001)(74316002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2395;H:DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: phtQZTOfMvoMMaSESS2N390mMzpOv2Yal1O0MBAtx1j/cCTYgoVhHnWZWrcF9EkZOy2nvKBIykMZajbf2e4ab0MdjOrPVa1WYB2f87hu8pjx1Khd51+O8hYiZtnfk0d5su7Nf4wTop9C5X+wEkGX8WCTEwxAfigacYX4rsCH+XNS8RSBgECmrtDUJNyVDrOKZkWeRmnty3zbDkiYJn+IRH47aO/7USvtZaikPc4oTYb811KC7hknvzuGckAy6iqX86KRl7x9NiGorRoCtgY0KTcnTjh4ypjVQvUXE3HptNpp6oVcBvERs8ZJFGaV413VEP76h72d1kw2nQjZZc90SMXISkXrCqTPU3wmPsv5TUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87908b24-e096-4ebc-48ff-08d60983761f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 05:35:54.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCk9uIDA4LzI0LzIwMTggMTI6MjggQU0sIFJhbmR5IER1bmxhcCB3cm90ZToN
Cg0KPiBPbiAwOC8yMC8yMDE4IDEwOjQ0IFBNLCBSb3kgSW0gd3JvdGU6DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5wdXQvbWlzYy9LY29uZmlnIGIvZHJpdmVycy9pbnB1dC9taXNjL0tjb25m
aWcNCj4gPiBpbmRleCBjYTU5YTJiLi42ZTBkZTY5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aW5wdXQvbWlzYy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9pbnB1dC9taXNjL0tjb25maWcN
Cj4gPiBAQCAtODUxLDQgKzg1MSwxNiBAQCBjb25maWcgSU5QVVRfU0MyN1hYX1ZJQlJBDQo+ID4g
IAkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmUuIFRo
ZSBtb2R1bGUNCj4gd2lsbA0KPiA+ICAJICBiZSBjYWxsZWQgc2MyN3h4X3ZpYnJhLg0KPiA+DQo+
IA0KPiBIaSwNCj4gQ2FuIHlvdSBleHBsYWluIHRoZSAiZGVwZW5kcyBvbiIgYmVsb3csIHBsZWFz
ZS4NCj4gDQo+ID4gK2NvbmZpZyBJTlBVVF9EQTcyODBfSEFQVElDUw0KPiA+ICsJdHJpc3RhdGUg
IkRpYWxvZyBTZW1pY29uZHVjdG9yIERBNzI4MCBoYXB0aWNzIHN1cHBvcnQiDQo+ID4gKwlkZXBl
bmRzIG9uIChJTlBVVCAmJiBJMkMgJiYgU1lTRlMpIHx8IFBXTQ0KPiA+ICsJc2VsZWN0IElOUFVU
X0ZGX01FTUxFU1MNCj4gPiArCXNlbGVjdCBSRUdNQVBfSTJDDQo+IA0KPiBJZiBJTlBVVCBpcyBk
aXNhYmxlZCwgYW5kIEkyQyBpcyBkaXNhYmxlZCwgYW5kIFNZU0ZTIGlzIGRpc2FibGVkLCBidXQN
Cj4gUFdNPXksDQo+IHRoZW4gdGhlICJzZWxlY3QicyB3aWxsIGhhdmUgcHJvYmxlbXMgd2l0aCB1
bm1ldCBkZXBlbmRlbmNpZXMuDQoNCkkgd2lsbCBmaXggdGhpcyBpbiB2NS4NCg0KPiANCj4gPiAr
CWhlbHANCj4gPiArCSAgU2F5IFkgdG8gZW5hYmxlIHN1cHBvcnQgZm9yIHRoZSBoYXB0aWNzIGNv
bnRyb2xsZXIgb24NCj4gPiArCSAgRGlhbG9nIERBNzI4MCBjaGlwLg0KPiA+ICsNCj4gPiArCSAg
VG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlDQo+
ID4gKwkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBkYTcyODAtaGFwdGljLg0KPiANCj4gVGhhdCBt
b2R1bGUgbmFtZSBkb2Vzbid0IG1hdGNoIHdoYXQncyBpbiB0aGUgTWFrZWZpbGUgKGJlbG93KS4N
Cg0KSSB3aWxsIGZpeCB0aGlzIGFzIHdlbGwgaW4gdjUuDQoNCj4gDQo+ID4gKw0KPiA+ICBlbmRp
Zg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L21pc2MvTWFrZWZpbGUgYi9kcml2ZXJz
L2lucHV0L21pc2MvTWFrZWZpbGUNCj4gPiBpbmRleCA5ZDBmOWQxLi5kOTQxMzQ4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvaW5wdXQvbWlzYy9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMv
aW5wdXQvbWlzYy9NYWtlZmlsZQ0KPiA+IEBAIC0yNSw2ICsyNSw3IEBAIG9iai0kKENPTkZJR19J
TlBVVF9DTUEzMDAwKQkJKz0NCj4gY21hMzAwMF9kMHgubw0KPiA+ICBvYmotJChDT05GSUdfSU5Q
VVRfQ01BMzAwMF9JMkMpCQkrPSBjbWEzMDAwX2QweF9pMmMubw0KPiA+ICBvYmotJChDT05GSUdf
SU5QVVRfQ09CQUxUX0JUTlMpCQkrPSBjb2JhbHRfYnRucy5vDQo+ID4gIG9iai0kKENPTkZJR19J
TlBVVF9DUENBUF9QV1JCVVRUT04pCSs9IGNwY2FwLXB3cmJ1dHRvbi5vDQo+ID4gK29iai0kKENP
TkZJR19JTlBVVF9EQTcyODBfSEFQVElDUykJKz0gZGE3MjgwLm8NCj4gPiAgb2JqLSQoQ09ORklH
X0lOUFVUX0RBOTA1Ml9PTktFWSkJKz0gZGE5MDUyX29ua2V5Lm8NCj4gPiAgb2JqLSQoQ09ORklH
X0lOUFVUX0RBOTA1NV9PTktFWSkJKz0gZGE5MDU1X29ua2V5Lm8NCj4gPiAgb2JqLSQoQ09ORklH
X0lOUFVUX0RBOTA2M19PTktFWSkJKz0gZGE5MDYzX29ua2V5Lm8NCj4gDQo+IA0KPiAtLQ0KPiB+
UmFuZHkNCg0KUmVnYXJkcywNClJveQ0K
