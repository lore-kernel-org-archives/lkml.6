Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D2C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9126219EE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NKNsb2Kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9126219EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeGCLPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:15:18 -0400
Received: from mail-he1eur01on0082.outbound.protection.outlook.com ([104.47.0.82]:42753
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752552AbeGCLPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mN4SiVfxzxCinf6I/ihtCh8iWMiY8g5ruaONVydtEg=;
 b=NKNsb2KhkZtvfp8VIz+5IgZBIq70Ob1HEVHyw2x1zf3mT/0qeLuMTvFbXMjkwKs09W/7aI6YKrQ39b1iZV99m+VIMeVw6GRxOoM4CNdHyqs9Jx1fueMz6HcczLrSl+GGY+rH6gRP9FMONLzLB2yPivh243GZDveyAdYaOCB1nkM=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3448.eurprd04.prod.outlook.com (52.133.19.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Tue, 3 Jul 2018 11:15:13 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::ec30:550b:5843:9788]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::ec30:550b:5843:9788%4]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 11:15:13 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
Thread-Topic: [PATCH] mmc: sdhci-of-esdhc: set proper dma mask for ls104x
 chips
Thread-Index: AQHUDrxWLGe/QpkZskWq+gDG+p8kqaR8BtMAgAFZ7AA=
Date:   Tue, 3 Jul 2018 11:15:13 +0000
Message-ID: <61a16c6b-9158-17ea-51f9-2ee5b85ccb78@nxp.com>
References: <20180628084509.19646-1-laurentiu.tudor@nxp.com>
 <CAPDyKFoNmcg+7JbWq1eeb2Dx7GKSh=FWpZcEeB8RORaBbrr=qA@mail.gmail.com>
In-Reply-To: <CAPDyKFoNmcg+7JbWq1eeb2Dx7GKSh=FWpZcEeB8RORaBbrr=qA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3448;7:unCsbCDwNk86zmFoW+f1r85GpX4J5RHdLjfAAXB2xXEQsbjdtpI6WU/b88Ap++/gd8zIXAvoPQbYLM+fi2iXLD5fCxL5WBu4t4PejJB2geHYx44TZeE3lIMkQIy0n/R3WLdGDvRO4sU0H0XGFpZEO/J/Km2WiOHnNw5k00wHTlLsdBtZTJ9OuBVAxy6r/csWfhd93RbdDdXBTU9LvHPIHfZJev6fYHmizAqrgGq2SPj0DU+GtL0uL8ARMTccB9Na
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f247f2dd-49cd-4386-f65a-08d5e0d63f45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3448;
x-ms-traffictypediagnostic: AM6PR0402MB3448:
x-microsoft-antispam-prvs: <AM6PR0402MB344853467EE856E8FD4133BAEC420@AM6PR0402MB3448.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR0402MB3448;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3448;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(6246003)(6486002)(106356001)(316002)(6436002)(6506007)(66066001)(53546011)(229853002)(446003)(102836004)(186003)(25786009)(97736004)(76176011)(31686004)(105586002)(6116002)(26005)(2900100001)(36756003)(3846002)(54906003)(14454004)(478600001)(68736007)(6512007)(7736002)(99286004)(486006)(476003)(2616005)(6916009)(81156014)(256004)(5250100002)(8936002)(8676002)(2906002)(81166006)(5660300001)(86362001)(53936002)(31696002)(11346002)(4326008)(575784001)(305945005)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3448;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JvR5H0/CTMAiK/peLbVUpsAzKTaOSUDxCWkER86nsEixrXgZ1oi0kUD+aHjqfztLrUqay86XQBBMpa18MlCXgCKZWbL1ryfarEg4ZpgfpPKBzcUPmSNHd0JIveRQKoISh+ce2F3I2fMYBoKVus56+6VTb766nxLoYLQ5V5JyK/IxXpnapLSuWZZgMlvXIyNFa8ZJKTu9D9FIOJz3SQ2oGN6VnPwqz8niEvEWZT24nAopSwp3Rk8pdO7jdZwJIuhgFxdKlxNo2VgOF6KnppicnHLmxY4NWTC81i6CDPvapJTlWNPGN5IyCQ9mZ8kVmT0SZdRwOD+hpr77WXw+oB7G1iWbRHmbvEdFa5K2IKexKX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <93E2212E647BFE44B197BEA55CFD0B55@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f247f2dd-49cd-4386-f65a-08d5e0d63f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 11:15:13.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KT24gMDIuMDcuMjAxOCAxNzozNywgVWxmIEhhbnNzb24gd3JvdGU6DQo+IE9u
IDI4IEp1bmUgMjAxOCBhdCAxMDo0NSwgTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JA
bnhwLmNvbT4gd3JvdGU6DQo+PiBTREhDSSBjb250cm9sbGVyIGluIGxzMTA0M2EgYW5kIGxzMTA0
NmEgZ2VuZXJhdGUgNDAtYml0IHdpZGUgYWRkcmVzc2VzDQo+PiB3aGVuIGRvaW5nIERNQS4gTWFr
ZSBzdXJlIHRoYXQgdGhlIGNvcnJlc3BvbmRpbmcgZG1hIG1hc2sgaXMgY29ycmVjdGx5DQo+PiBj
b25maWd1cmVkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVu
dGl1LnR1ZG9yQG54cC5jb20+DQo+IA0KPiBUaGFua3MsIGFwcGxpZWQgZm9yIG5leHQhDQoNClRo
YW5rcyBmb3IgcGlja2luZyB0aGlzIHVwIQ0KSSBqdXN0IHJlYWxpemVkIHRoYXQgbWF5YmUgSSBz
aG91bGQgaGF2ZSBwcm92aWRlZCBzb21lIGNvbnRleHQgYXJvdW5kIA0KdGhpcyBwYXRjaC4gSSdt
IHdvcmtpbmcgb24gZW5hYmxpbmcgc21tdSBvbiB0aGVzZSBjaGlwcyBhbmQgZW5jb3VudGVyZWQg
DQp0aGUgZm9sbG93aW5nIHByb2JsZW06IHRoZSBzbW11IGlucHV0IGFkZHJlc3Mgc2l6ZSBpcyA0
OCBiaXRzIHNvIHRoZSBkbWEgDQptYXBwaW5ncyBmb3Igc2RoY2kgZW5kIHVwIDQ4LWJpdCB3aWRl
LiBIb3dldmVyLCBvbiB0aGVzZSBjaGlwcyBzZGhjaSANCm9ubHkgdXNlIDQwLWJpdHMgb2YgdGhh
dCBhZGRyZXNzIHNpemUgd2hlbiBkb2luZyBkbWEuDQpTbyB5b3UgZW5kIHVwIHdpdGggYSA0OC1i
aXQgYWRkcmVzcyB0cmFuc2xhdGlvbiBpbiBzbW11IGJ1dCB0aGUgZGV2aWNlIA0KZ2VuZXJhdGVz
IHRyYW5zYWN0aW9ucyB3aXRoIGNsaXBwZWQgNDAtYml0IGFkZHJlc3NlcywgdGh1cyBzbW11IGNv
bnRleHQgDQpmYXVsdHMgYXJlIHRyaWdnZXJlZC4gU2V0dGluZyB1cCB0aGUgY29ycmVjdCBkbWEg
bWFzayBmaXhlcyB0aGlzIHNpdHVhdGlvbi4NCg0KLS0tDQpCZXN0IFJlZ2FyZHMsIExhdXJlbnRp
dQ0KDQo+IA0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMuYyB8
IDYgKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+PiBpbmRleCA0ZmZhNmIxNzNhMjEuLjgzMzJmNTZl
NmMwZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMuYw0K
Pj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+PiBAQCAtMjIsNiAr
MjIsNyBAQA0KPj4gICAjaW5jbHVkZSA8bGludXgvc3lzX3NvYy5oPg0KPj4gICAjaW5jbHVkZSA8
bGludXgvY2xrLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9rdGltZS5oPg0KPj4gKyNpbmNsdWRl
IDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvbW1jL2hvc3QuaD4N
Cj4+ICAgI2luY2x1ZGUgInNkaGNpLXBsdGZtLmgiDQo+PiAgICNpbmNsdWRlICJzZGhjaS1lc2Ro
Yy5oIg0KPj4gQEAgLTQyNyw2ICs0MjgsMTEgQEAgc3RhdGljIHZvaWQgZXNkaGNfb2ZfYWRtYV93
b3JrYXJvdW5kKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1MzIgaW50bWFzaykNCj4+ICAgc3Rh
dGljIGludCBlc2RoY19vZl9lbmFibGVfZG1hKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0KPj4g
ICB7DQo+PiAgICAgICAgICB1MzIgdmFsdWU7DQo+PiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRl
diA9IG1tY19kZXYoaG9zdC0+bW1jKTsNCj4+ICsNCj4+ICsgICAgICAgaWYgKG9mX2RldmljZV9p
c19jb21wYXRpYmxlKGRldi0+b2Zfbm9kZSwgImZzbCxsczEwNDNhLWVzZGhjIikgfHwNCj4+ICsg
ICAgICAgICAgIG9mX2RldmljZV9pc19jb21wYXRpYmxlKGRldi0+b2Zfbm9kZSwgImZzbCxsczEw
NDZhLWVzZGhjIikpDQo+PiArICAgICAgICAgICAgICAgZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVu
dChkZXYsIERNQV9CSVRfTUFTSyg0MCkpOw0KPj4NCj4+ICAgICAgICAgIHZhbHVlID0gc2RoY2lf
cmVhZGwoaG9zdCwgRVNESENfRE1BX1NZU0NUTCk7DQo+PiAgICAgICAgICB2YWx1ZSB8PSBFU0RI
Q19ETUFfU05PT1A7DQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg==
