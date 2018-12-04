Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0F2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PZ7ib2+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB0F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeLDNtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:49:17 -0500
Received: from mail-eopbgr150101.outbound.protection.outlook.com ([40.107.15.101]:64032
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbeLDNtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIA3+7gUMpuT8vcJgnbEOaB71jKoypi2SChod57cYhI=;
 b=PZ7ib2+SwIHB1TBat9lMbCuPm1rP1Hlf5bEbVVTHt1AYslbdGKjj6GJP3f4JRvv8Ws6MZcA60TeFdbn6lcSDLR9W7LDtHYf+sRfz1mw+RYYQEbni5StfWfRsE0tjdQLIb/nTX5DwCSqbwxVVr9xv4YVFhY41K5+AvN2MBTXdbNI=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB4222.eurprd02.prod.outlook.com (20.177.60.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 13:49:11 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1361.022; Tue, 4 Dec 2018
 13:49:11 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Nicholas Mc Guire <der.herr@hofr.at>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Topic: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Index: AQHUiV04FT84eXxBo0+Q2gJyFszP86VucwAAgAAPwACAABrHAA==
Date:   Tue, 4 Dec 2018 13:49:11 +0000
Message-ID: <2c43e965-9a12-0367-fb23-bedfaaed4f68@axentia.se>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
 <549eba3a-28b9-e4b0-f680-8fb51b160879@axentia.se>
 <20181204121318.GB28201@osadl.at>
In-Reply-To: <20181204121318.GB28201@osadl.at>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0101CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::25) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4222;6:BY6hM/PFOB9Ne73bWiyu7o9Ohv590GKVesSOhLZxIYjKhyPOonT8SPK1sY4t7y6Yob80wf6Ia8IptJ0j8OtFv8YDh3oUABonYNCSKpv25vCu/Je6SzRRuhW+W/ZGd9Faw3fST6tJcfLnKCEUvnnXQd3KxuutaoZbz/FjnHulJfll25dWNlf5UgnOx0gZbBi5TLO04JmYz4RgFgj9mSYcKNLb5CpKLO2QjFElQ41zEXBo10V3FhDWA/WUNOYb7l1Ghdmhf6W/GoxNTtgemR2jkbfZQWGfRF6RsMABJ2qml+xGOimLuVaK/HX+mCq0rj4znSH6hx3dUkWJKGonZlWXcHC9XhDVP0nuoQyGWZix6znB5hsNcxOp2e/SfBpfp7MLIsDJRkCBRTiBJVHhqDQtOaZAJKLImJXp+SFdtZTjoe7UM9U5WQKEBs2r3cGfDzUeCCV7n1WW2nrPrtEDouG/6Q==;5:nl/XH1yYB2eKPmEonX6ov2hA8UtivjLT/mHA0aRhgm90hiuG4Xm/eks0bWbENnDYvhSPqegScFtJxauqfFUqxZl9eeiByIny6X2uz+sw6fFyDkPrqYi4PYegdyhZrBs+EpsdspdI0YOu9yHze9qnoY4txnODO7DYV++t65pAwHg=;7:adrjSSaxEAVWeM12w0iQv8H3uepWEbWGXwumKg7nw/losbo+PHS3Fa9g85LQXQ1x9etzUN6vpjUwMJ8k5o+fk/X7ol6rVKoGTL6KtdV/oE2CRwCsxf6vk4p7+MUQskZMuGxmmJvQHqfeAHhiJy0B1A==
x-ms-office365-filtering-correlation-id: f4593a12-2e9b-41ea-33dc-08d659ef44fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4222;
x-ms-traffictypediagnostic: VI1PR02MB4222:
x-microsoft-antispam-prvs: <VI1PR02MB4222336211AEA05C00883FA2BCAF0@VI1PR02MB4222.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501493)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB4222;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB4222;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39830400003)(346002)(396003)(189003)(199004)(11346002)(7736002)(105586002)(305945005)(2616005)(86362001)(486006)(446003)(6486002)(476003)(4326008)(508600001)(74482002)(66066001)(65956001)(26005)(53936002)(5660300001)(71200400001)(229853002)(6512007)(64126003)(65826007)(65806001)(31696002)(256004)(31686004)(14444005)(186003)(97736004)(36756003)(386003)(6506007)(6916009)(54906003)(53546011)(58126008)(316002)(76176011)(81166006)(8676002)(2906002)(68736007)(81156014)(25786009)(99286004)(6116002)(8936002)(3846002)(6246003)(102836004)(52116002)(106356001)(71190400001)(14454004)(6436002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4222;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7Ifry+Wu1vnI+Lov/queo2qFJMG3SvOLGlHKtL1DuXlQEbGJD4L0wpCA2I9r9qpwCNWk+NWKhw5R9MFN7AAwGdHjpGnCCMY1qOoqzaTuaKGmhP0kllMLteY+9/PTcyAfdueeEUi1Q08+dPtyd3ge+tMX0uhiVbN/6ehuVApVva9Yi4ORPDDSAnkHLZEBXRB3YJWt+t+B6VUhkmxOgLriUHVbDXO58hRwHDm9XZpLjm81OJrKrWqA/zO3DjvTCbrh7kdUsEY3ef9FYLzZWQWESGYBX7Tm+Lbq2exw9OUdK/wwzdzds8LurXGm8Gt+AsYGToA8wlUaxerSBCAtT1G5t8reYqVQR9Oof1fe6FchigQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <175875D639804E4EBE8F25B263FD6455@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f4593a12-2e9b-41ea-33dc-08d659ef44fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 13:49:11.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0wNCAxMzoxMywgTmljaG9sYXMgTWMgR3VpcmUgd3JvdGU6DQo+IE9uIFR1ZSwg
RGVjIDA0LCAyMDE4IGF0IDExOjE2OjU5QU0gKzAwMDAsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4g
SGkhDQo+Pg0KPj4gVGhpcyBwYXRjaCBsb29rcyBsaWtlIGEgZ29vZCBpZGVhLiBIb3dldmVyLCBh
IG5pdHBpY2sgYmVsb3cuDQo+Pg0KPj4gT24gMjAxOC0xMi0wMSAxMTowMSwgTmljaG9sYXMgTWMg
R3VpcmUgd3JvdGU6DQo+Pj4gZGV2bV9rc3RyZHVwKCkgbWF5IHJldHVybiBOVUxMIGlmIGludGVy
bmFsIGFsbG9jYXRpb24gZmFpbGVkLg0KPj4+IFRodXMgdXNpbmcgIG5hbWUsIHZhbHVlICBpcyB1
bnNhZmUgd2l0aG91dCBiZWluZyBjaGVja2VkLiBBcw0KPj4+IGkyY19kZW11eF9waW5jdHJsX3By
b2JlKCkgY2FuIHJldHVybiAtRU5PTUVNIGluIG90aGVyIGNhc2VzDQo+Pj4gYSBkZXZfZXJyKCkg
bWVzc2FnZSBpcyBpbmNsdWRlZCB0byBtYWtlIHRoZSBmYWlsdXJlIGxvY2F0aW9uDQo+Pj4gY2xl
YXIuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBNYyBHdWlyZSA8aG9mcmF0QG9z
YWRsLm9yZz4NCj4+PiBGaXhlczogZTM1NDc4ZWFjMDMwICgiaTJjOiBtdXg6IGRlbXV4LXBpbmN0
cmw6IHJ1biBwcm9wZXJseSB3aXRoIG11bHRpcGxlIGluc3RhbmNlcyIpDQo+Pj4gLS0tDQo+Pj4N
Cj4+PiBQcm9ibGVtIGxvY2F0ZWQgd2l0aCBleHBlcmltZW50YWwgY29jY2luZWxsZSBzY3JpcHQN
Cj4+Pg0KPj4+IFE6IFRoZSB1c2Ugb2YgZGV2bV9rc3RyZHVwKCkgc2VlbXMgYSBiaXQgb2RkIHdo
aWxlIHRlY2huaWNhbGx5IG5vdCB3cm9uZywNCj4+PiAgICBwZXJzb25hbGx5IEkgdGhpbmsgZGV2
bV9rYXNwcmludGYoKSB3b3VsZCBiZSBtb3JlIHN1aXRhYmxlIGhlcmUuDQo+Pj4NCj4+PiBQYXRj
aCB3YXMgY29tcGlsZSB0ZXN0ZWQgd2l0aDogbXVsdGlfdjdfZGVmY29uZmlnIA0KPj4+IChpbXBs
aWVzIEkyQ19ERU1VWF9QSU5DVFJMPXkpDQo+Pj4NCj4+PiBQYXRjaCBpcyBhZ2FpbnN0IDQuMjAt
cmM0IChsb2NhbHZlcnNpb24tbmV4dCBpcyBuZXh0LTIwMTgxMTMwKQ0KPj4+DQo+Pj4gIGRyaXZl
cnMvaTJjL211eGVzL2kyYy1kZW11eC1waW5jdHJsLmMgfCA2ICsrKysrKw0KPj4+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
MmMvbXV4ZXMvaTJjLWRlbXV4LXBpbmN0cmwuYyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1kZW11
eC1waW5jdHJsLmMNCj4+PiBpbmRleCAwMzUwMzJlLi5jNDY2OTk5IDEwMDY0NA0KPj4+IC0tLSBh
L2RyaXZlcnMvaTJjL211eGVzL2kyYy1kZW11eC1waW5jdHJsLmMNCj4+PiArKysgYi9kcml2ZXJz
L2kyYy9tdXhlcy9pMmMtZGVtdXgtcGluY3RybC5jDQo+Pj4gQEAgLTI0NCw2ICsyNDQsMTIgQEAg
c3RhdGljIGludCBpMmNfZGVtdXhfcGluY3RybF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPj4+ICANCj4+PiAgCQlwcm9wc1tpXS5uYW1lID0gZGV2bV9rc3RyZHVwKCZwZGV2
LT5kZXYsICJzdGF0dXMiLCBHRlBfS0VSTkVMKTsNCj4+PiAgCQlwcm9wc1tpXS52YWx1ZSA9IGRl
dm1fa3N0cmR1cCgmcGRldi0+ZGV2LCAib2siLCBHRlBfS0VSTkVMKTsNCj4+PiArCQlpZiAoIXBy
b3BzW2ldLm5hbWUgfHwgIXByb3BzW2ldLnZhbHVlKSB7DQo+Pj4gKwkJCWRldl9lcnIoJnBkZXYt
PmRldiwNCj4+PiArCQkJCSJjaGFuICVkIG5hbWUsIHZhbHVlIGFsbG9jYXRpb24gZmFpbGVkXG4i
LCBpKTsNCj4+DQo+PiBQbGVhc2UgZHJvcCB0aGlzIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWx1cmUg
bWVzc2FnZS4gWW91IHNob3VsZCBnZXQgc3VjaCBhDQo+PiBtZXNzYWdlIGZyb20gZGV2bV9rc3Ry
ZHVwLg0KPj4NCj4gDQo+IGhtLi4udHJpZWQgdG8gZmlndXJlIG91dCB3aGVyZSB0aGF0IG1lc3Nh
Z2Ugd291bGQgYmUgY29tbWluZw0KPiBmcm9tIC0gYnV0IEkgY291bGQgbm90IGZpbmQgYW55IHBv
aW50IGluIHRoZSBjYWxsIHRyZWUgdGhhdA0KPiB3b3VsZCBpc3N1ZSBzdWNoIGEgbWVzc2FnZSA/
DQo+IA0KPiAgZGV2bV9rc3RyZHVwKCkgDQo+ICAgIC0+IGRldm1fa21hbGxvYygpDQo+ICAgICAg
ICAgLT4gYWxsb2NfZHIoKQ0KPiAgICAgICAgICAgICAgLS0+IGttYWxsb2NfdHJhY2tfY2FsbGVy
KCkgKG5vbi1OVU1BKQ0KPiAgICAgICAgICAgICAgfCAgICAgLT4gX19rbWFsbG9jX25vZGUoKQ0K
PiAgICAgICAgICAgICAgfCAgICAgICAgLT4gX19kb19rbWFsbG9jX25vZGUoKQ0KPiAgICAgICAg
ICAgICAgYC0+IF9fa21hbGxvY19ub2RlX3RyYWNrX2NhbGxlcigpIChOVU1BKQ0KPiAgICAgICAg
ICAgICAgICAgICAgLT4gX19kb19rbWFsbG9jX25vZGUoKQ0KPiANCj4gIF9fZG9fa21hbGxvY19u
b2RlKCkgc2VlbXMgbGlrZSBpdCBzaW1wbHkgcmV0dXJucyBOVUxMIGJ1dA0KPiAgaXNzdWVzIG5v
IGZhaWx1cmUgbWVzc2FnZS4NCj4gIEFtIEkgb3Zlcmxvb2tpbmcgc29tZXRoaW5nID8gDQoNCldl
bGwsIEkgZG9uJ3Qga25vdyB0aGUgZGV0YWlscywgYnV0IGNoZWNrcGF0Y2ggd2lsbCB3YXJuIGFi
b3V0IHNpbXBsZQ0KZXJyb3IgbWVzc2FnZXMgb24gZGV2bV9rc3RyZHVwIGZhaWx1cmUgKGlmIEkg
cmVhZCB0aGUgY2hlY2twYXRjaCBzb3VyY2UNCmNvcnJlY3RseSkuIEJ1dCBpbiB0aGlzIGNhc2Ug
dGhlcmUgYXJlIHR3byBwYXJhbGxlbCBjb25kaXRpb25zIGluIHRoZQ0KaWYgYW5kIGhlbmNlIGNo
ZWNrcGF0Y2ggc3R1bWJsZXMsIGJ1dCBnaXN0IGlzIHRoZSBzYW1lLCB5b3Ugc2hvdWxkIG5vdA0K
c3ByaW5rbGUgbWVzc2FnZXMgb24gbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVyZS4NCg0KQ2hlZXJz
LA0KUGV0ZXINCg0KPiB0aHghDQo+IGhvZnJhdCANCj4gIA0KPj4gQ2hlZXJzLA0KPj4gUGV0ZXIN
Cj4+DQo+Pj4gKwkJCWVyciA9IC1FTk9NRU07DQo+Pj4gKwkJCWdvdG8gZXJyX3JvbGxiYWNrOw0K
Pj4+ICsJCX0NCj4+PiAgCQlwcm9wc1tpXS5sZW5ndGggPSAzOw0KPj4+ICANCj4+PiAgCQlvZl9j
aGFuZ2VzZXRfaW5pdCgmcHJpdi0+Y2hhbltpXS5jaGdzZXQpOw0KPj4+DQo+Pg0KDQo=
