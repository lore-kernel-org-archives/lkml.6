Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB73821848
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iA0vnYWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfBRXik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:38:40 -0500
Received: from mail-eopbgr140100.outbound.protection.outlook.com ([40.107.14.100]:60647
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfBRXij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu5fBGlbsOIXbkEFYi/opFPlJBkOk724JYCT7VEVn3o=;
 b=iA0vnYWJntpRXzcUnMyxz8imoBZC9vTmA0AGxLaAlJAQUkssZAVNJ2f9Msgfgs0Oej77hxGeakwIO8BuuqMq7q3Jl0L0sizPR9HiekAjk2jWVwtpFZcTCtzlJVI6HbIPhLZe1MhSOvsUsLtBV1R82xuTB6RrPvwZfIpeyn0T6Xo=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4046.eurprd02.prod.outlook.com (20.177.58.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 23:38:31 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 23:38:31 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Leo Li <leoyang.li@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] drivers: mux: Generic register bitfield-based multiplexer
 driver
Thread-Topic: [PATCH] drivers: mux: Generic register bitfield-based
 multiplexer driver
Thread-Index: AQHUx0xz2hlFfSdjRkyo3ywwDF+eo6XlTzmAgAADfWCAAErjAIAAbmmQgAArf4A=
Date:   Mon, 18 Feb 2019 23:38:31 +0000
Message-ID: <bfe3fd9c-7375-1c53-5692-7cdea3c9b670@axentia.se>
References: <20190218110509.28225-1-pankaj.bansal@nxp.com>
 <3d8168fa-d71a-bcb7-6a1a-a82fad1a01f4@axentia.se>
 <VI1PR0401MB2496C7B8250C4E760108F6FFF1630@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <a653de12-4785-615a-670e-2cf68bee1372@axentia.se>
 <AM0PR04MB58588DDADE24F3612E5EF5108F630@AM0PR04MB5858.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB58588DDADE24F3612E5EF5108F630@AM0PR04MB5858.eurprd04.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR08CA0072.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::43) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 106a15c6-57a2-4d8f-ce19-08d695fa30d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4046;
x-ms-traffictypediagnostic: VI1PR02MB4046:
x-microsoft-antispam-prvs: <VI1PR02MB4046FD5A7E3B165D33502AADBC630@VI1PR02MB4046.eurprd02.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(39830400003)(366004)(136003)(396003)(199004)(189003)(52314003)(6512007)(2501003)(6116002)(53546011)(6246003)(26005)(36756003)(86362001)(486006)(14454004)(99286004)(58126008)(186003)(64126003)(316002)(31696002)(74482002)(25786009)(110136005)(3846002)(6506007)(386003)(6436002)(5660300002)(65826007)(7736002)(102836004)(76176011)(53936002)(305945005)(11346002)(446003)(52116002)(2616005)(476003)(71200400001)(71190400001)(65806001)(81166006)(31686004)(65956001)(106356001)(229853002)(81156014)(93886005)(256004)(2906002)(8676002)(508600001)(6486002)(105586002)(97736004)(8936002)(66066001)(14444005)(68736007)(41533002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4046;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjAyTUI0MDQ2OzIzOkh2VmMrVjh5TWJWbTVKYUltTzAybEVDd2pH?=
 =?utf-8?B?TjNDaEhYUHFYWjM4djNMbHJwZTNKWjYxeXdXenR0THUxZWVmMldxWGZqUkJl?=
 =?utf-8?B?UHpQMGVtR0NHdGs5SGM4M1ZxeDF2RW1Bak5KVWlqNm43d052ZWdMU2lVZjFu?=
 =?utf-8?B?clZrL1BqUkplWW1XejdwaXBuMjlkOWpGdUJ6dDdPZkE5aXlwYUlGOENTT2Y0?=
 =?utf-8?B?WStiZEk5MWVMM1BEOU9PSTlMQjd6ZzBQL2FuaUkvR2t3NjQ2d0c5clYvU1hW?=
 =?utf-8?B?OWRoNlZvZW5qcW5RbmgxQ2d6M0p5YUp5V3Z0YVpCN1hPQmhGSEVTZy9KcURF?=
 =?utf-8?B?TXdtYzNyblpnVGRKMHhNUCtPcURRajJkUHBqa3JNOVZhc3RWelJ3cXd3eDFo?=
 =?utf-8?B?TUVBcmI1ZTlyUWlDa3JHKzBpVUFKdTVpK1l6Vm8wcWljTXo0d0d4TDY1Rmwr?=
 =?utf-8?B?VlZDdi82QUpwS3lGd0pBaTVpVWNrTDYzY2xDckpSMkxtdHlnMFNERmFXQTlr?=
 =?utf-8?B?UHpINk1wTTVVcTl5U3JDWW5tY3NsREllQ2llVUVaOEVZaGFFaExEZk85WE1D?=
 =?utf-8?B?Ty95ZGtlZHF5algvWndkYnJjVExIakRkaTBoZXlUNHcwaysxWWJIRnUvWlBO?=
 =?utf-8?B?Y2lwSHJLOVJtd2lqMVlZcUVpT0JlbXIvUHBkREtzVGxKeHFGQXRXWi9pVEdV?=
 =?utf-8?B?amxZQkEyc3VHT3lXa0pjNHJCL3JWT1BYSzF3TllvdHlkNy91N0RWeUIxQS9n?=
 =?utf-8?B?ZDZpZGhkRkFmSkVYS3pEYUlYa3R0SkkyWEx4TmlyMHhFVTVydklyb1hVcjBv?=
 =?utf-8?B?enFKK0lyNHJRSDQvTHY3aWpRTWVrL0RzQVlpZnRjRWsvdW9RM2lBbjZKcEk2?=
 =?utf-8?B?TEdTTEFkQzBDSHZ0cG9DanMrSUtUb0RuSkVJYUdGb3pWSlNrMlFwQ2FNZzQy?=
 =?utf-8?B?MXBlR2JBNWF2dVNrSFFLWGJqb0lTRWYzemYrRWJOMHhFUDNwUGRwTUlWZE5S?=
 =?utf-8?B?TTRZQUZCb1BGK2QwbDJ4aTlxbTlPS1h0RnRxYWtJK3RMeHM0bzFqcFNPQWh1?=
 =?utf-8?B?ZHRwaWdaK0NTTDJCeFRIWXNRUVlWbmNBbmczSDh5ZlYrcTU0KzN6Mk1EZjcy?=
 =?utf-8?B?RnRmQURqeWMyMjI5ZzB1QUxHbTJnRkNiRmRRalJPZlFBdVdyVU9XY3M2dlNZ?=
 =?utf-8?B?QnlTTXpnbU9KUVhhNWEwa0VvMllDN2ROQU9hVnZEckIvS2tWVUhOYVZMRnJV?=
 =?utf-8?B?OTZNdG9qSUhrSGh6YStNcmlTc090bXQrWXJKUzJrMzM5TGlJWUpJMFJRRGlZ?=
 =?utf-8?B?NUtGalFoZ1RGS0JyeVc3T3BQYlJhbUtIVEFOT3RLRzdON2hIYi81Um5WZlpy?=
 =?utf-8?B?SzBVQ2JVSGl3bXAvaWxZZmpweHhRRFdRRjJLS2krNVZzNWdJUWVDaTd1SVRR?=
 =?utf-8?B?dFFNNkFla3J4Qzcyc2d4NEVKSE5iOHRoMmVWTU05MnhoRXQ3b1VxZVNwWDVo?=
 =?utf-8?B?N0hwK2lGbjBEbTFyTWZid044YlRYTFYzWCtvT3E2cEpOeVpuVm5OUEViRVNK?=
 =?utf-8?B?SzQ2N1ZSMTlweDJkMExDWjJsdm96WnVoZTMrNEM5aXFXd1F2QXlUTldqT0h3?=
 =?utf-8?B?NzhjbDBNODBSSk1ENGpEb1hJYy9zZnd0Q2tUMWpyNEZySzJYMDV3WW5CZHVS?=
 =?utf-8?B?TkhLWTNsMk9jMU5WUE80Um9zaHoxdVpPYXFaN3BRL2dvL3NjSi9HNTU4YjBJ?=
 =?utf-8?B?L2pZRDB4ai9oeVZ1a0JnY1k3ZGhaRFFvVGY4bU5HT1ZoalpqbG5zQVc3MXFt?=
 =?utf-8?B?TnJlZnRGU2kyZG4rdGd3REhKaVVUM1dNcTJqdUFUM0M1Vm10Wmd6WEVBajg2?=
 =?utf-8?B?S0k5VjZhTXUzZkR5WUZGWEpzNzhjUUxNQjBxbnJtMnRaVzBRcHNBc3hLdml2?=
 =?utf-8?B?QzEzaEhnbXdiTGNVSklldG1iSDhiYlRMb1RMQlpKRElCUmp4U2FLK0RpQlN5?=
 =?utf-8?B?MGI3amZjSGVsRlppTU1NdmJIdERDMi9OVFRWOWxXWGV3TkZzOWhSQ0o2blRS?=
 =?utf-8?B?U3RRU01uckVmSkswQnRkYlJYU25maTRob093ZG9JY085T2NyMXVqbjJCb1Rm?=
 =?utf-8?B?bHc9PQ==?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aP/hoj+SqVuuYSrZ5vh9Uf1BcTxCEzLjnsRGHxTaVi4e7R89QeyvlF/r2y/J28QhEIHLXXmuavVVIAJGBBb+fsF8YZCTr9UXkg/L5geCch2g3cJSqfLLkYCQOCg641CPUsXn0V1BaXQ2M4YISKOrXKEu6a1jEWsCi0Y23T6PIDci74VvpdMEOD1pWIDpNs2moSlaAqRq/E9PyVP5xyFp8uOOsnPr3G7Zem4lk9tkJREOlu+9qJRslUaM5R2q1kIpGgvmvHenp/VJD5nVz7YYMgi85XxMQ6CAIyIKPDtyN+OEZxiY+hSYD4gF39h7eDEosU2d+DrJ1WscUEHledVt7W2pBC/EzRODSJZYb7SlRVwoS7AdnE6j9yQZIuxfQ2sDTebnVGE1sVJJOOi9feaV2GqrpC8Ec2TC3BdacWFf50U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3F1CE6799216F46B5862B12C2550681@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 106a15c6-57a2-4d8f-ce19-08d695fa30d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 23:38:30.8552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0xOCAyMjowNywgTGVvIExpIHdyb3RlOg0KPiBGcm9tOiBQZXRlciBSb3NpbiA8
cGVkYUBheGVudGlhLnNlPg0KPj4gT24gMjAxOS0wMi0xOCAxMToyMCwgUGFua2FqIEJhbnNhbCB3
cm90ZToNCj4+PiBGcm9tOiBQZXRlciBSb3NpbiBbbWFpbHRvOnBlZGFAYXhlbnRpYS5zZV0NCj4+
Pj4gQW55d2F5LCBJIHdvdWxkIHByZWZlciBpZiB5b3UgY291bGQgZXh0ZW5kIGRyaXZlcnMvbXV4
L21taW8uYyB0bw0KPj4+PiBzdXBwb3J0IGJvdGggY29tcGF0aWJsZXMsIGFuZCB1c2luZyB0aGUg
Y29tcGF0aWJsZSB0byBzZWxlY3QgaWYNCj4+Pj4NCj4+Pj4gCXJlZ21hcCA9IHN5c2Nvbl9ub2Rl
X3RvX3JlZ21hcChucC0+cGFyZW50KTsNCj4+Pj4NCj4+Pj4gb3INCj4+Pj4NCj4+Pj4gCXJlZ21h
cCA9IGRldl9nZXRfcmVnbWFwKGRldi0+cGFyZW50LCBOVUxMKTsNCj4+Pj4NCj4+Pj4gaXMgY2Fs
bGVkIHRvIGdldCB0byB0aGUgZGVzaXJlZCByZWdtYXAuDQo+Pj4NCj4+PiBUaGlzIGNhbiBiZSBk
b25lLiBUaGUgbmFtZSBtbWlvLmMgaG93ZXZlciBzdWdnZXN0cyB0aGF0IG11eCBpcw0KPj4+IGNv
bnRyb2xsZWQgYnkgYSBNZW1vcnkgbWFwcGVkIGRldmljZS4NCj4+PiBJTU8sIGlmIHRoZSBnZW5l
cmljIHJlZ21hcCBBUEkgaXMgdG8gYmUgYWRkZWQgdG8gaXQsIHRoZSBuYW1lIG5lZWRzIHRvDQo+
Pj4gY2hhbmdlZC4gQW55IHN1Z2dlc3Rpb25zID8NCj4+DQo+PiBKdXN0IGtlZXAgdGhlIGRyaXZl
ciBuYW1lIGFzIGlzLCB0aGVyZSBpcyBubyBzaG9ydGFnZSBvZiBkcml2ZXJzIHN1cHBvcnRpbmcN
Cj4+IG1vcmUgdGhhbiBvbmUgdGhpbmcuLi4NCj4gDQo+IFlvdSBhcmUgcmlnaHQgdGhhdCBhIGxv
dCBvZiBkcml2ZXJzIHN1cHBvcnQgbXVsdGlwbGUgZnVuY3Rpb25zLiBCdXQNCj4gdGhlIHByb2Js
ZW0gaGVyZSBpcyB0aGF0IHRoZSBjdXJyZW50IG5hbWUgbW1pbyBpcyBvbmx5IGEgc3Vic2V0IG9m
DQo+IHdoYXQgdGhlIHVwZGF0ZWQgZHJpdmVyIHdpbGwgaGFuZGxlLCB3aGljaCBjYW4gY3JlYXRl
IGNvbmZ1c2lvbi4NCg0KSSByZWZ1c2UgdGhlIGR1cGxpY2F0aW9uLiBUaGlzIG5ldyBkcml2ZXIg
aXMgZG9pbmcgdGhlIGV4YWN0IHNhbWUNCnRoaW5nICgtaXNoKSBhcyB0aGUgb2xkIG9uZS4gSGF2
aW5nIHRoZSBzYW1lIGNvZGUgaW4gdHdvIHBsYWNlcyBpcyBqdXN0DQphIHJlY2lwZSBmb3IgZnV0
dXJlIGRpdmVyZ2VuY2Ugd2hlbiBldmVyeW9uZSBoYXZlIGZvcmdvdHRlbiB0aGF0DQp0aGVyZSBh
cmUgdHdvIG5lYXJseSBpZGVudGljYWwgZHJpdmVycyB0aGF0IGJvdGggbmVlZCBwYXRjaGluZy4g
U3RhdGluZw0KdGhpcyBpbiBhIGNvbW1lbnQgc29tZXdoZXJlIGluIHRoZSBkcml2ZXJzIHdpbGwg
bm90IGhlbHAgYWxsIHRoYXQgbXVjaA0KaW4gbXkgZXhwZXJpZW5jZS4gVGhlIGNvbW1lbnQgd2ls
bCBiZSBtaXNzaW5nIGZyb20gdGhlIGNvbnRleHQgaW4gc29tZQ0Kc2VlbWluZ2x5IHRyaXZpYWwg
cGF0Y2gsIGFuZCB0aGVyZSB5b3UgZ28uIFRoZXJlICp3aWxsKiBiZSB3ZWVkIGRvd24NCnRoZSBs
aW5lLCBpZiBkdXBsaWNhdGlvbiBpcyBhbGxvd2VkLg0KDQpJIGNhbiBhZ3JlZSB0aGF0IG11eC1y
ZWdtYXAuYyBhbmQgQ09ORklHX01VWF9SRUdNQVAgd291bGQgaGF2ZSBiZWVuDQpiZXR0ZXIgbmFt
ZXMsIGJ1dCBtdXgtbW1pbyBpcyBhbHJlYWR5IHRoZXJlLiBTbyBpdCBpcyB3aGF0IGl0IGlzLiBC
dXQNCmlmIHlvdSBjYW4gY29udmluY2UgbWUgdGhhdCBjaGFuZ2luZyB0aGUgbmFtZSB3aWxsIG5v
dCBjYXVzZSBhbnkNCnRyb3VibGUgYW55d2hlcmUgZm9yIGFueSBleGlzdGluZyBtdXgtbW1pbyB1
c2VycywgSSBzdXBwb3NlIHdlIGNhbg0KZG8gYSByZW5hbWUuIEJ1dCBJIGJldCB0aGVyZSB3aWxs
IGJlIHNvbWUgbmFzdHkgY29ybmVyIGNhc2VzIGFuZA0Kb2RkIHVzZSBjYXNlcywgc28geW91IHdp
bGwgaGF2ZSB0byBwcmVzZW50IHN0cm9uZyBhcmd1bWVudHMuDQoNCkp1c3QgdXBkYXRlIHRoZSBL
Y29uZmlnIHRvIGRvY3VtZW50IHRoZSBkdWFsIG5hdHVyZSBhbmQgcmVtb3ZlIHRoZQ0KTUZEX1NZ
U0NPTiBkZXBlbmRlbmN5LiBJIHN1cHBvc2UgeW91IGFsc28gbmVlZCB0byBoYW5kbGUgdGhlIHBv
c3NpYmx5DQptaXNzaW5nIHN5c2NvbiBpbiB0aGUgLmMgZmlsZSwgZGV0YWlscywgZGV0YWlscy4g
QnV0IHNvbWV0aGluZyBsaWtlDQp0aGlzIHBlcmhhcHM6DQoNCmNvbmZpZyBNVVhfTU1JTw0KCXRy
aXN0YXRlICJNTUlPL1JlZ21hcCByZWdpc3RlciBiaXRmaWVsZC1jb250cm9sbGVkIE11bHRpcGxl
eGVyIg0KCWRlcGVuZHMgb24gT0YgfHwgQ09NUElMRV9URVNUDQoJaGVscA0KCSAgTU1JTy9SZWdt
YXAgcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciBjb250cm9sbGVyLg0K
DQoJICBUaGUgZHJpdmVyIGJ1aWxkcyBtdWx0aXBsZXhlciBjb250cm9sbGVycyBmb3IgYml0Zmll
bGRzIGluIGVpdGhlcg0KCSAgYSBzeXNjb24gcmVnaXN0ZXIgb3IgYSBkcml2ZXIgcmVnbWFwIHJl
Z2lzdGVyLiBGb3IgTiBiaXQgd2lkZQ0KCSAgYml0ZmllbGRzLCB0aGVyZSB3aWxsIGJlIDJeTiBw
b3NzaWJsZSBtdWx0aXBsZXhlciBzdGF0ZXMuDQoNCgkgIFRvIGNvbXBpbGUgdGhlIGRyaXZlciBh
cyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlIG1vZHVsZSB3aWxsDQoJICBiZSBjYWxsZWQg
bXV4LW1taW8uDQoNCkNoZWVycywNClBldGVyDQo=
