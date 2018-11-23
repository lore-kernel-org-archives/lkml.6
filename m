Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B895C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071E820672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ULWYnhrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071E820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409856AbeKWXY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:24:28 -0500
Received: from mail-eopbgr60115.outbound.protection.outlook.com ([40.107.6.115]:5360
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405500AbeKWXY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmY6NKL9L8WEYe/lT+VJ4wsdjjQevlFpQQHO+HjRdq0=;
 b=ULWYnhrwvrmUZiMA9kt6TY5pnYzoGEzOUxBdQMxQyyvxIAp0qR5gAxJJreUxB/SpH5Y1btIw3dvcuyVQ4RL+iJ9qKPLtTJflgigkD535PRNNUqb5c5EnAM+KVi32o4dQpdru0qAKn3Xp2293kM1bBKZ4zbYyPV0gNaJsKw7EUdA=
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com (10.169.244.8) by
 AM5PR0201MB2418.eurprd02.prod.outlook.com (10.169.243.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Fri, 23 Nov 2018 12:40:20 +0000
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::3c1f:657e:d0f7:4913]) by AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::3c1f:657e:d0f7:4913%3]) with mapi id 15.20.1361.016; Fri, 23 Nov 2018
 12:40:20 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: Use correct vendor prefix for Atmel
Thread-Topic: [PATCH] dt-bindings: i2c: Use correct vendor prefix for Atmel
Thread-Index: AQHUgyV//Stu+82/xk6+1DLzGdG/jKVdTRSA
Date:   Fri, 23 Nov 2018 12:40:19 +0000
Message-ID: <374af1fb-54bc-ee13-b4fd-616c2fe0746f@axentia.se>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
In-Reply-To: <20181123121009.17213-1-thierry.reding@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::17) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0201MB2418;6:O77441J9RZ5PHblQGpL7/F16Q4r0djCxJOrZD52mzOd1bk5JREfttXmK3mR10n/daR1jMb2xQKT1/lUufTzpoaCAyzfXlVm5hLUAAD30Jd21rtphsWik7Y6bDR8OBkrqsjYxlEl6tO1mXFXhzBjmchABHqU1HMLRmfwrJrTY23TAi/ytViLhmpkBdd/VU2/QyTEtLEKtzFUJdBW8OxIDCUQQbO+9eIiWw4LlA/JMyby69MRc2UsMF+fw9ipbTP/qNMdJZDB1SOGq7vRfzpPiG1yP6bLya1qbZuQvqLkv8uuAyePz044NVUGfxDngilhwVN5cSVo177cqGjqZ+Jl1VLf45kl0n2fIo/1uEKPLQwrRJbO7AnEQF0IwmQNYeO6gwzHo5ATpm0SKjx6DOqGAv1pW4pviSdpLJUGsf8/j5h7hkKJCizhwhpDARuow9q31nemCEbwhXgjfJo585rvPDA==;5:gE4dRhqrmA6QvC6ZT2Be52/5ik3wlMZ0h/1ZaMS/o8uFWt4a8bsmJ6XTcJ5eZtZnDCcVDP6fTaLYSKPPQPjyQSDUXHTPivDm0iMPX8YS2gOTJflzUAh7PBA9uddJ3c1kRbZup7ISqiZ9hcFal9UvbcnY8TM/IRDfgxVFHJTOVdg=;7:xN8j19+qhfTTwPTAmmvz+i4sHpsSsOGJEp6X3V+2RC1HxOlOGtTxay5UcUZzEKpczS5dsAx63g4uhpUGZgbRvepCgepIZ/LhMvsgSiMxCag7YAWccOJWIsDKjXPSIK+GJKv/9dHIiy33+m2TEP97VA==
x-ms-office365-filtering-correlation-id: 98d5d26c-b8a5-40bb-66ab-08d65140d3f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2418;
x-ms-traffictypediagnostic: AM5PR0201MB2418:
x-microsoft-antispam-prvs: <AM5PR0201MB2418F8342E9C7F965B2BA616BCD40@AM5PR0201MB2418.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM5PR0201MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2418;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(31686004)(81156014)(2616005)(81166006)(64126003)(446003)(476003)(76176011)(8676002)(11346002)(68736007)(99286004)(52116002)(31696002)(102836004)(229853002)(53546011)(386003)(6506007)(86362001)(65826007)(105586002)(71190400001)(4001150100001)(5660300001)(71200400001)(26005)(186003)(97736004)(486006)(8936002)(106356001)(6436002)(6486002)(256004)(58126008)(316002)(7736002)(74482002)(4326008)(53936002)(305945005)(65806001)(66066001)(65956001)(54906003)(110136005)(6512007)(6246003)(25786009)(39060400002)(2906002)(3260700006)(3846002)(36756003)(6116002)(508600001)(2900100001)(14454004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2418;H:AM5PR0201MB2451.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SvTvBWF4jLCFLrMSf/+GI1XATUNMczee++MhElLv0ziyPKZQra84lX7Hfq7lC/TOIuNINZw6DN+zl8U/iuKA3lv6qv6ui9HH27Av7kHUid9ZLQy9hSi6cQo63tVabbZZVX7VRQa+F9ihRvqSx48cqg0uRTgzSNzt0qPk9ON90I0D8ifC0l+cx+fD6vA/dle7ZfnIMAl2gBAGMfw7LGSfwsM7ci+aautAIvQ8zyR7OdzXv80u5badUFPEEW0NN0k0TW28xC411OsZvm/Y73TrUt3bWRLCmMdCskWAowJX7H0mnPHRW0m9U6neCZgq9yEB2wN1uRs4P/hLgtN1q5SC4DrGsou1YTzb8sugGTzlGfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9A070F084B66F4AAE7F7E01CA7FB706@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d5d26c-b8a5-40bb-66ab-08d65140d3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 12:40:20.0245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0yMyAxMzoxMCwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6DQo+IEZyb206IFRoaWVy
cnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+DQo+IA0KPiBUaGUgImF0LCIgcHJlZml4IHdh
cyBuZXZlciBjb3JyZWN0IGZvciBBdG1lbCwgc28gZml4IHRoZSBmZXcgb2NjdXJyZW5jZXMNCj4g
dGhhdCBnb3QgaXQgd3JvbmcuIFVzZSAiYXRtZWwsIiBpbnN0ZWFkLg0KDQpGdWxseSBhZ3JlZWQu
IEhvd2V2ZXIsIGdpdmVuIHRoYXQgYXRtZWwsMjRjMDggaXMgZG9jdW1lbnRlZCBpbiAuLi4vZWVw
cm9tL2F0MjQudHh0DQpJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byByZW1vdmUgYXQsMjRj
MDggZnJvbSB0cml2aWFsLWRldmljZXMudHh0DQoNCkNoZWVycywNClBldGVyDQoNCj4gU2lnbmVk
LW9mZi1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4NCj4gLS0tDQo+ICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgtbHRjNDMwNi50eHQg
fCAyICstDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgt
cGNhOTU0eC50eHQgfCAyICstDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aTJjL254cCxwY2E5NTQxLnR4dCAgICAgfCAyICstDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnR4dCAgICAgfCAyICstDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgtbHRjNDMwNi50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgtbHRjNDMw
Ni50eHQNCj4gaW5kZXggMWU5OGM2YjNhNzIxLi5jNjYxYjkwODNlYzYgMTAwNjQ0DQo+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLW11eC1sdGM0MzA2LnR4
dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgt
bHRjNDMwNi50eHQNCj4gQEAgLTQzLDcgKzQzLDcgQEAgRXhhbXBsZToNCj4gIAkJCXJlZyA9IDww
PjsNCj4gIA0KPiAgCQkJZWVwcm9tQDUwIHsNCj4gLQkJCQljb21wYXRpYmxlID0gImF0LDI0YzAy
IjsNCj4gKwkJCQljb21wYXRpYmxlID0gImF0bWVsLDI0YzAyIjsNCj4gIAkJCQlyZWcgPSA8MHg1
MD47DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXV4LXBjYTk1NHgudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXV4LXBjYTk1NHgudHh0DQo+IGluZGV4IGNjZjZj
ODZlZDA3Ni4uMzBhYzZhNjBmMDQxIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgtcGNhOTU0eC50eHQNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXV4LXBjYTk1NHgudHh0DQo+IEBAIC01
NCw3ICs1NCw3IEBAIEV4YW1wbGU6DQo+ICAJCQlyZWcgPSA8Mj47DQo+ICANCj4gIAkJCWVlcHJv
bUA1NCB7DQo+IC0JCQkJY29tcGF0aWJsZSA9ICJhdCwyNGMwOCI7DQo+ICsJCQkJY29tcGF0aWJs
ZSA9ICJhdG1lbCwyNGMwOCI7DQo+ICAJCQkJcmVnID0gPDB4NTQ+Ow0KPiAgCQkJfTsNCj4gIAkJ
fTsNCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMv
bnhwLHBjYTk1NDEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9u
eHAscGNhOTU0MS50eHQNCj4gaW5kZXggMGZiYmM2OTcwZWM1Li40MmJmYzA5Yzg5MTggMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvbnhwLHBjYTk1
NDEudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvbnhw
LHBjYTk1NDEudHh0DQo+IEBAIC0yMiw3ICsyMiw3IEBAIEV4YW1wbGU6DQo+ICAJCQkjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4gIA0KPiAgCQkJZWVwcm9tQDU0IHsNCj4gLQkJCQljb21wYXRpYmxlID0g
ImF0LDI0YzA4IjsNCj4gKwkJCQljb21wYXRpYmxlID0gImF0bWVsLDI0YzA4IjsNCj4gIAkJCQly
ZWcgPSA8MHg1ND47DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RyaXZpYWwtZGV2aWNlcy50eHQgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnR4dA0KPiBpbmRleCA2YWIw
MDFmYTFlZDQuLmI3YTdlYWYyOTc5YSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3RyaXZpYWwtZGV2aWNlcy50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RyaXZpYWwtZGV2aWNlcy50eHQNCj4gQEAgLTIxLDcgKzIx
LDcgQEAgYWRpLGFkdDc0OTAJCSsvLTFDIFRETSBFeHRlbmRlZCBUZW1wIFJhbmdlIEkuQw0KPiAg
YWRpLGFkeGwzNDUJCVRocmVlLUF4aXMgRGlnaXRhbCBBY2NlbGVyb21ldGVyDQo+ICBhZGksYWR4
bDM0NgkJVGhyZWUtQXhpcyBEaWdpdGFsIEFjY2VsZXJvbWV0ZXIgKGJhY2t3YXJkLWNvbXBhdGli
aWxpdHkgdmFsdWUgImFkaSxhZHhsMzQ1IiBtdXN0IGJlIGxpc3RlZCB0b28pDQo+ICBhbXMsaWFx
LWNvcmUJCUFNUyBpQVEtQ29yZSBWT0MgU2Vuc29yDQo+IC1hdCwyNGMwOAkJaTJjIHNlcmlhbCBl
ZXByb20gICgyNGN4eCkNCj4gK2F0bWVsLDI0YzA4CQlpMmMgc2VyaWFsIGVlcHJvbSAgKDI0Y3h4
KQ0KPiAgYXRtZWwsYXQ5N3NjMzIwNHQJaTJjIHRydXN0ZWQgcGxhdGZvcm0gbW9kdWxlIChUUE0p
DQo+ICBjYXBlbGxhLGNtMzIxODEJCUNNMzIxODE6IEFtYmllbnQgTGlnaHQgU2Vuc29yDQo+ICBj
YXBlbGxhLGNtMzIzMgkJQ00zMjMyOiBBbWJpZW50IExpZ2h0IFNlbnNvcg0KPiANCg0K
