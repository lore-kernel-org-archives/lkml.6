Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E29BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0829320673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="aMUG6rhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0829320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeG0IKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:10:32 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:20593
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeG0IKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkRnN51FF1x6wj11TXR/7PdjSM0PCARG3UETrky+G/w=;
 b=aMUG6rhXf6PV462Y/Rr3vEfBBAeTX6onreryY5ThS5KIEBsxF4MmWhWX/lb21/sNRPTXsTAL4+n0XWaMNjyQc5W+hLM42vSrPqpu1lwn9QD7XlHF0ZrZxbdlcuZIcDn8VysCAJMyYsG+uoygEEJBZw4B+8y5mJQapWAq7AmohKA=
Received: from BYAPR04MB4760.namprd04.prod.outlook.com (52.135.240.79) by
 BYAPR04MB5112.namprd04.prod.outlook.com (52.135.235.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Fri, 27 Jul 2018 06:50:01 +0000
Received: from BYAPR04MB4760.namprd04.prod.outlook.com
 ([fe80::44e2:1ff2:21d5:5b45]) by BYAPR04MB4760.namprd04.prod.outlook.com
 ([fe80::44e2:1ff2:21d5:5b45%3]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 06:49:59 +0000
From:   "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chuanjin Pang (WH)" <chuanjin.pang@bayhubtech.com>,
        "Mike Li (WH)" <mike.li@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Bobby Wu (WH)" <bobby.wu@bayhubtech.com>
Subject: RE: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock
 frequency to 200MHz
Thread-Topic: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock
 frequency to 200MHz
Thread-Index: AQHUHM4qII4CPaY8ykquzv+/lMDqTqSfnUMAgAMU9YA=
Date:   Fri, 27 Jul 2018 06:49:59 +0000
Message-ID: <BYAPR04MB4760BF8783C0E58A75D00F25E52A0@BYAPR04MB4760.namprd04.prod.outlook.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
 <20180716062655.24703-2-ernest.zhang@bayhubtech.com>
 <06a9dcec-846e-495c-4519-4af13549fe0e@intel.com>
In-Reply-To: <06a9dcec-846e-495c-4519-4af13549fe0e@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [27.17.7.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5112;6:86jlC4cC18MsJwtaecTzkkqkWotg6oJ6hsFzpXX5HpnRxfx9mbYO3YljTDVEGYFpLaXU+i72IOMPefEP5MdLyjAofQNoTjsLbhyeoNVSVaFjhOrjRPUIWme6J4UDJX2viA+0fGnFpcDdWvDzDlJVRH9V6AUuWS0igbMypfxBy5rkHO+a19YeIm7VSlxMPOUPESx4UhHDCIQJ+D1sA+bUoMqyipKsMVwj/kRk1UWYRpXLuKEHlv+mcFz3BX8uQL43FuGXlLWoGv3P9m1AKVupPWZjSutGWbAZyBjnfRP4/yzMoQnhRr/eqa+M1BgRcGdHJp5XiYZHlGjLDlPa3XS8JJXHjpo3+2gbH10yAALjoseUd0yS1KJOXLBsy6oEiTTwhFuv4hoDCfBKFTADzPzBGA5Qtbr3aJ2rLadhAwnWZtdjK5Z5BXwyQJUP7mZGOvc0eXTGi9nC2L0eVWX/bglv+g==;5:FmdPoU0iAoywnwDw72i1b+EZ0CUsS8hDHLLPEvVCBTbzFRLrCq0CU5aSbNUSox1rISXNPSJVgqYPw3J2NUI5aEZQgitXfkyMZSXOEzpynLjorWrM9Sc8CZIBvbzlAwEwCV5n3nqiGUk6S4fqAciV4skOr/PiuCl2dMksG0A4+Ro=;7:Z4JrALPpUpDAbv6LN6nEjzOLrk5K9EI0zoGvpHHbLxnqgwbgWrEwZZHbIEKHy2odFkHWCpsf5g02DT0BEQFxGRT/NKYkrhcsYaifwkTvBpOQHPSCI/KKqKZc4VyfFV6qzC5FDNdYIuqLzChbmeEOODOanuL6vS7EHY6MJpbti/rgcCyKiO1PmhCWbBGknweSNOTm6flf/GN+t1BQD/7XyJrLAnvrjqjuQfgIxkWtp/xo60dpss34d98cOPT0s+IH
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(39840400004)(366004)(136003)(396003)(199004)(189003)(57704003)(13464003)(107886003)(9686003)(478600001)(3846002)(11346002)(446003)(256004)(55016002)(486006)(74316002)(476003)(2906002)(81166006)(7696005)(7736002)(81156014)(97736004)(305945005)(6116002)(26005)(105586002)(33656002)(106356001)(99286004)(76176011)(14454004)(6246003)(53936002)(5250100002)(2501003)(8936002)(53546011)(5660300001)(2201001)(6506007)(229853002)(316002)(186003)(86362001)(66066001)(6436002)(2900100001)(54906003)(110136005)(102836004)(25786009)(68736007)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5112;H:BYAPR04MB4760.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 55a8b326-10da-4543-2365-08d5f38d2c12
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5112;
x-ms-traffictypediagnostic: BYAPR04MB5112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
x-microsoft-antispam-prvs: <BYAPR04MB51121CBC78E694BF33668540E52A0@BYAPR04MB5112.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR04MB5112;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB5112;
x-forefront-prvs: 07467C4D33
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0+pXfKn0MqIW0vwbs8MWcLnXVFV5YJU/7BB4yUaQz3AD1/3JJg7pz2FZmqzxBKBcw1EjyedvZc89Fahx1UYZXy8R6/V/cz+6ZPqRuUNtwQXNbdN+zq9J6Pu3DuDrw60k+gDsudXAJDEDY4q2sLGGBc68raxx7nb8gBEXVIqqyABy3Lc+eKqHoc+bXIjqwqXIrQC9iNtzsGdUqDdfFLMrl3d6j0aLe9qjWU+6nwpXDm+myQ1+Pb8z4y823X/HX+QSeeEuKRQUwkdz00fVO65rjHpAeuyGfs4pwZorWqIjiX7P70PrtHCxGELUl6eY2sKj8pqqBwshYkT22g8MCCxO1iKQD5pe7XQYBBrhyYCUq3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a8b326-10da-4543-2365-08d5f38d2c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 06:49:59.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuLA0KCURvIEkgbmVlZCByZS1zdWJtaXQgYWxsIDUgcGF0Y2hlcyBhZnRlciBmaXgg
dGhhdCBhbmQgY2hhbmdlIHRoZSB2ZXJzaW9uIHRvIHY4Pw0KQlINCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEFkcmlhbiBIdW50ZXIgW21haWx0bzphZHJpYW4uaHVudGVyQGlu
dGVsLmNvbV0gDQpTZW50OiAyMDE45bm0N+aciDI15pelIDE1OjQ1DQpUbzogRXJuZXN0IFpoYW5n
KFdIKTsgVWxmIEhhbnNzb247IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBDaHVhbmppbiBQYW5nIChXSCk7IE1pa2UgTGkgKFdIKTsg
Q2hldnJvbiBMaSAoV0gpOyBTaGlybGV5IEhlciAoU0MpOyBYaWFvZ3VhbmcgWXUgKFdIKTsgQm9i
YnkgV3UgKFdIKQ0KU3ViamVjdDogUmU6IFtQQVRDSCBWNyAyLzVdIG1tYzogc2RoY2k6IENoYW5n
ZSBPMiBIb3N0IEhTMjAwIG1vZGUgY2xvY2sgZnJlcXVlbmN5IHRvIDIwME1Ieg0KDQpPbiAxNi8w
Ny8xOCAwOToyNiwgZXJuZXN0LnpoYW5nIHdyb3RlOg0KPiBPMiBTRCBIb3N0IEhTMjAwIG1vZGUg
Y2xvY2sgZnJlcXVlbmN5IGN1cnJlbnQgaXMgMjA4TUh6LCBzaG91bGQgYmUgDQo+IGNoYW5nZWQg
dG8gMjAwTUh6IHRvIG1lZXQgc3BlY2lmaWNhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGVy
bmVzdC56aGFuZyA8ZXJuZXN0LnpoYW5nQGJheWh1YnRlY2guY29tPg0KDQpZb3UgbGVmdCBpbiB0
aGUgbWlzbGVhZGluZyBjb21tZW50LiAgRml4IHRoYXQgYW5kIGFkZDoNCg0KQWNrZWQtYnk6IEFk
cmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2Ug
aW4gVjc6DQo+IAlDaGFuZ2UgSFMyMDAgbW9kZSBjbG9jayBmcmVxdWVuY3kgZnJvbSAyMDhNSHog
dG8gMjAwTUh6IHRvIG1lZXQNCj4gCVNwZWNpZmljYXRpb24uDQo+IA0KPiBDaGFuZ2UgaW4gVjF+
VjY6DQo+IAlOL0ENCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3Jv
LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJt
aWNyby5jIA0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KPiBpbmRl
eCBiYTU5ZGI2YTEyNmMuLjk0Y2YzY2Q3NWRkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
cGNpLW8ybWljcm8uYw0KPiBAQCAtMzExLDcgKzMxMSw3IEBAIGludCBzZGhjaV9wY2lfbzJfcHJv
YmUoc3RydWN0IHNkaGNpX3BjaV9jaGlwIA0KPiAqY2hpcCkNCj4gIA0KPiAgCQkJLyogQ2hlY2sg
V2hldGhlciBzdWJJZCBpcyAweDExIG9yIDB4MTIgKi8NCj4gIAkJCWlmICgoc2NyYXRjaF8zMiA9
PSAweDExKSB8fCAoc2NyYXRjaF8zMiA9PSAweDEyKSkgew0KPiAtCQkJCXNjcmF0Y2hfMzIgPSAw
eDJjMjgwMDAwOw0KPiArCQkJCXNjcmF0Y2hfMzIgPSAweDI1MTAwMDAwOw0KPiAgDQo+ICAJCQkJ
LyogU2V0IEJhc2UgQ2xvY2sgdG8gMjA4TVogKi8NCg0KVGhhdCBjb21tZW50IGlzIG1pc2xlYWRp
bmcgbm93Lg0KDQo+ICAJCQkJbzJfcGNpX3NldF9iYXNlY2xrKGNoaXAsIHNjcmF0Y2hfMzIpOyBA
QCAtNDA2LDcgKzQwNiw3IEBAIGludCANCj4gc2RoY2lfcGNpX28yX3Byb2JlKHN0cnVjdCBzZGhj
aV9wY2lfY2hpcCAqY2hpcCkNCj4gIAkJCQkJICAgICAgIE8yX1NEX1BMTF9TRVRUSU5HLCBzY3Jh
dGNoXzMyKTsNCj4gIAkJfSBlbHNlIHsNCj4gIAkJCXNjcmF0Y2hfMzIgJj0gMHgwMDAwRkZGRjsN
Cj4gLQkJCXNjcmF0Y2hfMzIgfD0gMHgyYzI4MDAwMDsNCj4gKwkJCXNjcmF0Y2hfMzIgfD0gMHgy
NTEwMDAwMDsNCj4gIA0KPiAgCQkJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0K
PiAgCQkJCQkgICAgICAgTzJfU0RfUExMX1NFVFRJTkcsIHNjcmF0Y2hfMzIpOw0KPiANCg0K
