Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E1FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1D82081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ATliFHmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1D82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeLDOMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:12:33 -0500
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:11296
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbeLDOMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVb+rLLDHmVyclcNNt5I8SEHyRkszc2FZ4y7AYlKfIE=;
 b=ATliFHmklaNTUT+tpNUkRTIVKKh9NOnhO1ncAdITFSJEfzN/odIcliOpZGSM85ddL+w67ZBnoJCWp5PvnWn32FNxX0U2AxycL1f9xR8eqadlpYde1mo3+hQag8BSBSKXwMBBOaVWLCkjKgROxwgYbBYkvVczh2+00stCAMAxRcs=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB3102.eurprd02.prod.outlook.com (10.170.236.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 14:11:33 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1361.022; Tue, 4 Dec 2018
 14:11:33 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Topic: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Index: AQHUiV04FT84eXxBo0+Q2gJyFszP86Vuo8YA
Date:   Tue, 4 Dec 2018 14:11:33 +0000
Message-ID: <37b8709c-0b58-7bc9-22c5-e01953593d06@axentia.se>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:7:67::13) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB3102;6:23B59/4j7ykHhxYiJY1juJVGfmHCRVdGoTZGddRkKv7ulExDo8d4dqeWoCf0gK0TIkqnJ7AvfFgOxKz8MgDbP1OCtIfUTrDRscVBlTbNw8F39Fsy5HGWIjdWnZV1ZMUmQglC3Y3haTkQ+IStkHRpk0ZKP8+q5GRCQcXej684msam5GXIM7wwCiSxQ0a25YCVmoBhOH/RHYhU4azjq0xmUwhj9c1Ooj1iRt1E76tD5KIIyydI5d5bpusxXNjZVHQwmPCSYivFX/vMXRWnashxR1ZkKlHUcN8cmikz+CUoOO2nx+TuziCwDmbd93gZVzgyweJ41sacrKJuS6NfMpjgt8Sd5KYLLJKuTQEXapjIYeHWqxGevw7ohbQa5T3xD0dYzdyOtQxm10e4uf+513gjpbomjNxp1QYzI6sPaBGdXaCVK2++HDEOkErx3NpY3T8kt6mi3AIQ9na0MJZ8iRgMhg==;5:8ztbe1PAdrl4B+alfK18//FN1dqC7sJyMG56ic7er1FCZmqXc8yaDxRgWkG4hAmdNpcQDBmUa56Hn+A8Fw5W7cStuGEvuHtR3loTLdnKMMyBrGPqJjv3SUYTwpGuVjhqlBvJrrNfF/rwFnbNeQHhKqzkbBGvjqE/6Upfv7lFqPc=;7:gT4cdDrlTPcRf5rkz/caQFn3mWiF+txrMYZ/6f83GatjtuE6nXvc95QCGCPxEhLYxPQ6rdW/KNwPUuDJq2+ijCnErBpcZ5I+jqP4uAwY2YxIMFb9kXDye8G/gIT0/tzlX7yX2KNvK4zPPgpPR7J5yQ==
x-ms-office365-filtering-correlation-id: b5099d7f-9170-4eb1-0e4f-08d659f2654d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3102;
x-ms-traffictypediagnostic: VI1PR02MB3102:
x-microsoft-antispam-prvs: <VI1PR02MB3102B8A259F3DB1B6000DB40BCAF0@VI1PR02MB3102.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB3102;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB3102;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39840400004)(189003)(199004)(102836004)(2906002)(316002)(58126008)(76176011)(105586002)(66066001)(65806001)(186003)(6512007)(53546011)(52116002)(106356001)(6246003)(36756003)(386003)(110136005)(6506007)(65956001)(99286004)(31696002)(6116002)(64126003)(54906003)(5660300001)(53936002)(65826007)(31686004)(8936002)(14454004)(11346002)(256004)(14444005)(6436002)(74482002)(2616005)(4326008)(476003)(508600001)(8676002)(7736002)(81166006)(81156014)(6486002)(26005)(97736004)(68736007)(3846002)(486006)(446003)(71190400001)(86362001)(71200400001)(229853002)(25786009)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3102;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jaqCfXRSX1aBRWB1IzP1R1VgAD5eeOe2S6qZO3tO4IFvifVmI7HYmqmnS9YGuRjiDkO2pDWyr4OapUSfBQkuXFMbQybf+Kx48/vXBQAHmpBDtdm2ibic5Qm/PJN51E7NTWgWsrLmPNnngTh4s6VNdJB7uetapM8rf2hx4q+KdSFVf/mEBL4N/CFrtQocLEKuDLt7VUPRYpwAGBBCKOMu8oWdcdeBG/Jw9s2ASF7RySZnXq7DthxrCVAZEJydOOoCmM6fAt0sopkog8jz2hjAU9o/tlHdyZyMgBJ54sulsbIDNW41+lyrFQJ2k7FPa/af3qFCBbhDyMrCjj9wYiBtw/0qFgv3DmY4bb1dJGfhJrc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E8123AA13491A44A0EB1DC093B253A5@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b5099d7f-9170-4eb1-0e4f-08d659f2654d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 14:11:33.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SG8gaG1tLiBIYWQgYW5vdGhlciBsb29rIGF0IHRoaXMgcGF0Y2gsIG9yIHJhdGhlciwgdGhlIGNv
bnRleHQgb2YgdGhlDQpwYXRjaCBzbyBub3QgcmVhbGx5IHJlbGF0ZWQsIGJ1dC4uLg0KDQpPbiAy
MDE4LTEyLTAxIDExOjAxLCBOaWNob2xhcyBNYyBHdWlyZSB3cm90ZToNCj4gZGV2bV9rc3RyZHVw
KCkgbWF5IHJldHVybiBOVUxMIGlmIGludGVybmFsIGFsbG9jYXRpb24gZmFpbGVkLg0KPiBUaHVz
IHVzaW5nICBuYW1lLCB2YWx1ZSAgaXMgdW5zYWZlIHdpdGhvdXQgYmVpbmcgY2hlY2tlZC4gQXMN
Cj4gaTJjX2RlbXV4X3BpbmN0cmxfcHJvYmUoKSBjYW4gcmV0dXJuIC1FTk9NRU0gaW4gb3RoZXIg
Y2FzZXMNCj4gYSBkZXZfZXJyKCkgbWVzc2FnZSBpcyBpbmNsdWRlZCB0byBtYWtlIHRoZSBmYWls
dXJlIGxvY2F0aW9uDQo+IGNsZWFyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmljaG9sYXMgTWMg
R3VpcmUgPGhvZnJhdEBvc2FkbC5vcmc+DQo+IEZpeGVzOiBlMzU0NzhlYWMwMzAgKCJpMmM6IG11
eDogZGVtdXgtcGluY3RybDogcnVuIHByb3Blcmx5IHdpdGggbXVsdGlwbGUgaW5zdGFuY2VzIikN
Cj4gLS0tDQo+IA0KPiBQcm9ibGVtIGxvY2F0ZWQgd2l0aCBleHBlcmltZW50YWwgY29jY2luZWxs
ZSBzY3JpcHQNCj4gDQo+IFE6IFRoZSB1c2Ugb2YgZGV2bV9rc3RyZHVwKCkgc2VlbXMgYSBiaXQg
b2RkIHdoaWxlIHRlY2huaWNhbGx5IG5vdCB3cm9uZywNCj4gICAgcGVyc29uYWxseSBJIHRoaW5r
IGRldm1fa2FzcHJpbnRmKCkgd291bGQgYmUgbW9yZSBzdWl0YWJsZSBoZXJlLg0KPiANCj4gUGF0
Y2ggd2FzIGNvbXBpbGUgdGVzdGVkIHdpdGg6IG11bHRpX3Y3X2RlZmNvbmZpZyANCj4gKGltcGxp
ZXMgSTJDX0RFTVVYX1BJTkNUUkw9eSkNCj4gDQo+IFBhdGNoIGlzIGFnYWluc3QgNC4yMC1yYzQg
KGxvY2FsdmVyc2lvbi1uZXh0IGlzIG5leHQtMjAxODExMzApDQo+IA0KPiAgZHJpdmVycy9pMmMv
bXV4ZXMvaTJjLWRlbXV4LXBpbmN0cmwuYyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvbXV4ZXMvaTJj
LWRlbXV4LXBpbmN0cmwuYyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1kZW11eC1waW5jdHJsLmMN
Cj4gaW5kZXggMDM1MDMyZS4uYzQ2Njk5OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pMmMvbXV4
ZXMvaTJjLWRlbXV4LXBpbmN0cmwuYw0KPiArKysgYi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtZGVt
dXgtcGluY3RybC5jDQo+IEBAIC0yNDQsNiArMjQ0LDEyIEBAIHN0YXRpYyBpbnQgaTJjX2RlbXV4
X3BpbmN0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCQlw
cm9wc1tpXS5uYW1lID0gZGV2bV9rc3RyZHVwKCZwZGV2LT5kZXYsICJzdGF0dXMiLCBHRlBfS0VS
TkVMKTsNCj4gIAkJcHJvcHNbaV0udmFsdWUgPSBkZXZtX2tzdHJkdXAoJnBkZXYtPmRldiwgIm9r
IiwgR0ZQX0tFUk5FTCk7DQoNCkl0IHNlZW1lZCB2ZXJ5IGR1YmlvdXMgdG8gdXNlIGRldm1fa3N0
cmR1cCBoZXJlLCBzaW5jZQ0KDQoxLiBpZiB0aGUgY29uc3VtZXIgaXMgbm90IGZyZWVpbmcgdGhl
IHN0cmluZ3MgaXQgd291bGQgYmUgc3VmZmljaWVudCB3aXRoIGp1c3QNCiAgCQlwcm9wc1tpXS5u
YW1lID0gInN0YXR1cyI7DQogIAkJcHJvcHNbaV0udmFsdWUgPSAib2siOw0KDQoyLiBpZiB0aGUg
Y29uc3VtZXIgaXMgZnJlZWluZyB0aGUgc3RyaW5ncywgaXQgaXMgdmVyeSBiYWQgdG8gZnJlZSB0
aGVtIHR3aWNlDQogICB3aGljaCBpcyB3aGF0IGhhcHBlbnMgd2l0aCB0aGUgZGV2bV8gcHJlZml4
Lg0KDQpTbywgdGhlcmUgaXMgbm8gY2FzZSwgQUZBSUNULCB3aGVyZSBpdCBpcyBzYW5lIHRvIHVz
ZSBkZXZtX2tzdHJkdXAuDQoNClRoZXJlZm9yZSBJIGhhZCBhIGxvb2sgYXQgdGhlIGNvZGUsIGFu
ZCB0byBtZSBpdCBzZWVtcyBhcyBpZiB0aGUgY29uc3VtZXINCnZlcnkgbXVjaCBmcmVlcyB0aGUg
c3RyaW5ncywgd2hpY2ggbWVhbnMgdGhhdCB3ZSBhcmUgaW4gY2FzZSAyLCBhbmQgdGhhdA0KdGhl
IGFib3ZlIHNob3VsZCBiZSBvcmRpbmFyeSBrc3RyZHVwIGNhbGxzLg0KDQpBbSBJIG1pc3Npbmcg
c29tZXRoaW5nPw0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+ICsJCWlmICghcHJvcHNbaV0ubmFtZSB8
fCAhcHJvcHNbaV0udmFsdWUpIHsNCj4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwNCj4gKwkJCQki
Y2hhbiAlZCBuYW1lLCB2YWx1ZSBhbGxvY2F0aW9uIGZhaWxlZFxuIiwgaSk7DQo+ICsJCQllcnIg
PSAtRU5PTUVNOw0KPiArCQkJZ290byBlcnJfcm9sbGJhY2s7DQo+ICsJCX0NCj4gIAkJcHJvcHNb
aV0ubGVuZ3RoID0gMzsNCj4gIA0KPiAgCQlvZl9jaGFuZ2VzZXRfaW5pdCgmcHJpdi0+Y2hhbltp
XS5jaGdzZXQpOw0KPiANCg0K
