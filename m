Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96C3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593D621104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="IpT0eEaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593D621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbeK1FuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:50:24 -0500
Received: from mail-eopbgr150122.outbound.protection.outlook.com ([40.107.15.122]:12560
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbeK1FuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6i0erIJgtiqyeAOUgMuysQpRk2nzitSZfhAFBtivXk=;
 b=IpT0eEaApo3HaoU1xRPLMDQUgjKHqlaxKAG9RYhoXoMb7oQtJ4/8+Ea21bmfqw0qk/B//jUgVRBc+N0jvkhPtA9QGalT+xWk8pFAUQprIYPp/coN3ctM2Krw0T/ndYq5hIZRUtTln/My2jNywHB4iIe3Pxkeq4IKbg9lZtC6rtM=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2318.eurprd02.prod.outlook.com (10.168.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 18:51:13 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22%8]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 18:51:13 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Luca Ceresoli <lucaceresoli77@gmail.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Thread-Topic: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Thread-Index: AQHUWyyIYmlXSDP/EEi7krLfM400NKUWCzAAgAKfzACAPP48gIAOpMEA
Date:   Tue, 27 Nov 2018 18:51:13 +0000
Message-ID: <55ea59c5-ac9b-ab78-e3a1-edaed099ca15@axentia.se>
References: <20181003151928.17713-1-lucaceresoli77@gmail.com>
 <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
 <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
 <205e1d73-2318-ecd4-c531-3ff18a0e0005@lucaceresoli.net>
In-Reply-To: <205e1d73-2318-ecd4-c531-3ff18a0e0005@lucaceresoli.net>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::23)
 To VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2318;6:ibXRG6CRpvNyzfchR7tdqTReij93IvzPvNfRbmFYdpBtk5/W4tpUoklNNj/J18QswpOTuJ1j1UQYBsqbxBOf8t7vqbVw3OQRLMagXEaQpED42gpt5b1aCDCP810cgjmCtGvIeuiop49v+eE+DxIrB3kHSZXH3EVGEP4yFZ86Rgg44pTrBvbOi/0Qp/9MaP4bv5yZ5gdkrGLoherlMSixu1fqR1OOijVA4P1FCuQCFQ74d+M8vC80IWbycArQ5WXscmfoUCtGc41A+yCNGNSwmX7IJdrNFBTX9hDQWmyUYgHlxswaK9Y9FaI2aQ2k7Zn2PayRpJqxWLuM+JWEIqvqpdOrQ54MfS7K7ouvEMgt6SAgX2t2bRM4Ozu+V3VwWX66Bt03Urf2pJUteU2uu+MK+tihWdS+7iU6t+O5Voi/mYc7QB6+NK5p0VDYXIp1w+2OMOxcqIZ9gS2FR5ChBwQsiw==;5:4YsGq5jbEBv+VDsC83xmHmN8a5kdrNnAXb/reo46Vvs557J6cg5K7ZxU+dJb2IuAkKKcYUM1Zx/EUj1mdsVEb9TViivgq7WqcZV4hLSwbNeo2d6CSZv4bNVkwrFVceZfAlp9Iqkdh2tFssBZ9i/U5aYT4da9bzD5fC2dv6V+nQ0=;7:fcUbTRQQY8K/15Hec5UFBlVNZYRutW7NT3FZUKPNb36W6Ez8ISEGMRfFCOLbnnv0Pdixbls8lCcOhJxcqqN6gJ0iI6p2c/o5EXi8PZlhpmhqYqRaV+2dviBSWCrE7W/1hWJHITSe+FaZCjP+CCRpQQ==
x-ms-office365-filtering-correlation-id: 1ae4a95d-0642-45c3-49ac-08d654994db6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2318;
x-ms-traffictypediagnostic: VI1PR0201MB2318:
x-microsoft-antispam-prvs: <VI1PR0201MB231837465A32F17DEC2A25FEBCD00@VI1PR0201MB2318.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(2016111802025)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0201MB2318;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2318;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39830400003)(52314003)(199004)(189003)(6512007)(54906003)(6306002)(53936002)(39060400002)(966005)(316002)(58126008)(81156014)(5660300001)(186003)(6486002)(64126003)(8936002)(110136005)(229853002)(476003)(93886005)(6246003)(11346002)(86362001)(446003)(71200400001)(2616005)(8676002)(36756003)(508600001)(81166006)(14444005)(256004)(99286004)(486006)(71190400001)(4001150100001)(66066001)(52116002)(65826007)(4326008)(74482002)(76176011)(31696002)(97736004)(14454004)(305945005)(65806001)(65956001)(386003)(25786009)(102836004)(6506007)(53546011)(6436002)(105586002)(106356001)(68736007)(31686004)(2906002)(2501003)(3846002)(26005)(6116002)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2318;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9Ce0DPe6WhBxIPX3v9yWOo/lzYy/5ys0f+FGGoeRwO0+ZHSfzRay7tLNYqpjdMdVb1fUu61I8HWpEz/huEeFowlDjtEwi/sMYb2JDGlCOtIJWIky6A9zSf85icAEjWwvbbG4IwHMaxoCuSqvZfvg4XlpZ7r69/hb919FvSpm7ULFIouBBzS7nIEKuqUO9JleAW3n6zCF1x0+mUZ56lyrGYuq7//6W8vnggHOcnlOVckD0xPr297zM3qfuQU9mnTuLES3dCijxKkPzUCOKowQKSV4MSWaHF8oKIZ/o8MhBCdlYgsxKp/fGGGcMXhpNZrRmqvKD6LLJJ4CUtBnwbJkWHRmTk5K80eTmreTFHySI/k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <36E1114BF01D164E8FA534BA060BAA39@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae4a95d-0642-45c3-49ac-08d654994db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 18:51:13.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0xOCAxMjoxMywgTHVjYSBDZXJlc29saSB3cm90ZToNCj4gSGkgUGV0ZXIsDQo+
IA0KPiBPbiAxMC8xMC8xOCAxNzo0OCwgTHVjYSBDZXJlc29saSB3cm90ZToNCj4+IEhpIFBldGVy
LA0KPj4NCj4+IE9uIDA4LzEwLzIwMTggMjM6NDMsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4+IE9u
IDIwMTgtMTAtMDMgMTc6MTksIEx1Y2EgQ2VyZXNvbGkgd3JvdGU6DQo+Pj4+IEZyb206IEx1Y2Eg
Q2VyZXNvbGkgPGx1Y2FAbHVjYWNlcmVzb2xpLm5ldD4NCj4+Pj4NCj4+Pj4gaTJjLW11eCBpbnN0
YW50aWF0ZXMgb25lIGkyY19hbGdvcml0aG0gZm9yIGVhY2ggZG93bnN0cmVhbSBhZGFwdGVyLg0K
Pj4+PiBIb3dldmVyIHRoZXNlIGFsZ29yaXRobXMgYXJlIGFsbCBpZGVudGljYWwsIGRlcGVuZGlu
ZyBvbmx5IG9uIHRoZQ0KPj4+PiBwYXJlbnQgYWRhcHRlci4NCj4+Pj4NCj4+Pj4gQXZvaWQgZHVw
bGljYXRpb24gYnkgaG9pc3RpbmcgdGhlIGkyY19hbGdvcml0aG0gZnJvbSB0aGUgYWRhcHRlcnMg
dG8NCj4+Pj4gdGhlIGkyY19tdXhfY29yZSBvYmplY3QsIGFuZCByZXVzZSBpdCBpbiBhbGwgdGhl
IGFkYXB0ZXJzLg0KPj4+DQo+Pj4gT3VjaCwgd2hpbGUgSSBsaWtlIHRoZSBjb25jZXB0IG9mIGhh
dmluZyBvbmUgaTJjX2FsZ29yaXRobSBwZXIgbXV4LA0KPj4+IHRoaXMgcGF0Y2ggaXMgbm90IHdv
cmtpbmcuIFZhcmlvdXMgaTJjLW11eCBkcml2ZXJzIHNldCB0aGUNCj4+PiBtdXhjLT5tdXhfbG9j
a2VkIHZhcmlhYmxlICphZnRlciogdGhlIGkyY19tdXhfYWxsb2MgY2FsbCwgYW5kIHRoaXMNCj4+
PiBwYXRjaCBicmVha3Mgc3VjaCB1c2UuDQo+IA0KPiBJIGZpbmFsbHkgaGFkIGEgbG9vayBpbnRv
IHRoaXMgaXNzdWUuIFRocmVlIGRyaXZlcnMgYXJlIHNldHRpbmcNCj4gbXV4X2xvY2tlZCBhZnRl
ciBpMmNfbXV4X2FsbG9jOiBpMmMtbXV4LWdwbXV4LCBpMmMtbXV4LWdwaW8gYW5kDQo+IGkyYy1t
dXgtcGluY3RybC4NCj4gDQo+IGkyYy1tdXgtZ3BtdXggaXMgdHJpdmlhbCB0byBmaXguDQo+IA0K
PiBUaGUgb3RoZXIgdHdvIGFyZSBub3QgdHJpdmlhbCBiZWNhdXNlOg0KPiANCj4gIDEuIHRoZXkg
Y29tcHV0ZSBtdXhfbG9ja2VkIGZyb20gb3RoZXIgdmFyaWFibGVzDQo+ICAyLiB0aG9zZSB2YXJp
YWJsZXMgYXJlIHN0b3JlZCBpbiB0aGUgZHJpdmVycyAicHJpdmF0ZSIgZGF0YQ0KPiAgMy4gdGhl
aXIgcHJpdmF0ZSBkYXRhIGlzIHN0b3JlZCBpbnNpZGUgc3RydWN0IGkyY19tdXhfY29yZQ0KPiAg
ICAgKG11eGMtPnByaXYpIHdoaWNoIGV4aXN0cyBvbmx5IGFmdGVyIGkyY19tdXhfYWxsb2MoKQ0K
PiANCj4gSW4gdGhvc2UgY2FzZXMgY29tcHV0aW5nIG11eF9sb2NrZWQgYmVmb3JlIGkyY19tdXhf
YWxsb2MoKSBpbnZvbHZlcw0KPiBxdWl0ZSBpbnZhc2l2ZSBjaGFuZ2VzLiBJdCB0b29rIDMgbm9u
LXRyaXZpYWwgY29tbWl0cyBqdXN0IGZvcg0KPiBpMmMtbXV4LWdwaW8sIGFuZCBJIHN0aWxsIGhh
dmUgdG8gbG9vayBpbnRvIGkyYy1tdXgtcGluY3RybC4NCj4gDQo+IFNvIHRoZSBxdWVzdGlvbiBp
czogZG8gd2UgcmVhbGx5IHdhbnQgdG8gZG8gdGhpcz8NCj4gDQo+IFVzaW5nIHRoZSBwcml2YXRl
IHN0b3JhZ2UgcHJvdmlkZWQgYnkgaTJjX211eF9hbGxvYygpIGlzIGEgaGFuZHkNCj4gZmVhdHVy
ZSwgYXQgbGVhc3QgZm9yIHNpbXBsZXIgZHJpdmVycyB3aGljaCBrbm93IGluIGFkdmFuY2UgdGhl
IGZsYWdzDQo+IHRoZXkgbmVlZCB0byBzZXQuIE9UT0ggSSBkb24ndCBsaWtlIGluZGl2aWR1YWwg
ZHJpdmVycyB0byBtYW5pcHVsYXRlDQo+IG11eF9jb3JlIGZsYWdzIHRoYXQgbG9vayB2ZXJ5IG11
Y2ggbGlrZSBpbnRlcm5hbCBkYXRhLiBJdCBtYWtlcyBhbnkNCj4gY2hhbmdlIHRvIHRoZSBpMmMg
bXV4IGNvcmUgaGFyZGVyLCBzaW5jZSBldmVyeSBjaGFuZ2VkIGxpbmUgY291bGQgaGF2ZQ0KPiBz
aWRlIGVmZmVjdHMgaW4gc29tZSBkcml2ZXJzLCB3aGljaCBpcyB3aGF0J3MgaGFwcGVuaW5nIGhl
cmUuDQo+IA0KPiBXaGF0J3MgeW91ciBvcGluaW9uIGFib3V0IHRoaXMgaXNzdWU/DQoNCkkgb2J2
aW91c2x5IGRvbid0IGxpa2UgdGhhdCBkcml2ZXJzIGFyZSBwb2tpbmcgYXJvdW5kIGluIHN0cnVj
dA0KaTJjX211eF9jb3JlLg0KDQpCdXQsIHlvdXIgZGVzY3JpcHRpb24gc291bmRzIHByZWNpc2Vs
eSBob3cgSSByZW1lbWJlcmVkIGl0LiBUaGUNCnVuZGVybHlpbmcgcHJvYmxlbSBpcyBvZiBjb3Vy
c2UgdGhhdCBpMmMtbXV4LWdwaW8gYW5kDQppMmMtbXV4LXBpbmN0cmwgZG8gcmVhbGx5IG5hc3R5
IGRpZ3MgaW50byBpbnRlcm5hbCBwYXJ0cyBvZiB0aGUNCmdwaW8gYW5kIHRoZSBwaW5jdHJsIHN1
YnN5c3RlbXMgYXMgdGhleSAqdHJ5KiB0byBmaWd1cmUgb3V0IGlmDQp0aGV5IHNob3VsZCBiZSBt
dXgtbG9ja2VkIG9yIHBhcmVudC1sb2NrZWQuIFRoZSByZXN1bHQgb2YgdGhhdA0KZGlnZ2luZyBp
cyBub3QgY29tcGxldGVseSByZWxpYWJsZSwgYnV0IGl0IHNvbHZlcyB0aGUgaXNzdWUNCndpdGhv
dXQgaGVscCBmcm9tIGRldmljZS10cmVlIHByb3BlcnRpZXMgaW4gYXQgbGVhc3Qgb25lIGNhc2UN
CnRoYXQgSSBrbm93IGFib3V0LiBIb3dldmVyLCBmb3IgdGhhdCBjYXNlIEkgYWxzbyBrbm93IHRo
YXQgdGhlcmUNCmlzIG5vIHJpc2sgb2YgcmVncmVzc2lvbiBzaW5jZSBJIGNvbnRyb2wgdGhlIGRp
c3RyaWJ1dGlvbiBvZg0KYm90aCBrZXJuZWwgYW5kIC5kdGIgZm9yIGFueSB1cGdyYWRlLiBBbnl3
YXksIGl0IHdhcyBkb25lIGxpa2UNCml0IHdhcyBzaW5jZSBJIGF0IHRoZSB0aW1lIGRpZCBub3Qg
ZGFyZSB0byBxdWVzdGlvbiB0aGUgZmVlZGJhY2sNCmZyb20gdGhlIGRldmljZS10cmVlIGNhbXAs
IGFuZCBhY3R1YWxseSB0aG91Z2h0IGl0IHdhcyBhIGdvb2QNCnRoaW5nLCBhbmQgdGh1cyBkaWQg
bm90IHB1c2ggZm9yIGEgZGV2aWNlLXRyZWUgcHJvcGVydHkgd2hlbg0KUm9iIGNvbXBsYWluZWQg
YWJvdXQgdGhlIHByb3BlcnR5IG5vdCBkZXNjcmliaW5nIEhXIGFuZCBpbnN0ZWFkDQp3YXMganVz
dCB3b3JraW5nIGFyb3VuZCBrZXJuZWwgaXNzdWVzIFsxXS4gVGhlIG11eC1sb2NrZWQgdnMuDQpw
YXJlbnQtbG9ja2VkIHByb3BlcnR5IGhhcyBiZWVuIGFkZGVkIHNpbmNlLiBJbiByZXRyb3NwZWN0
LCB0aGUNCndob2xlIGF0dGVtcHQgdG8gYXV0by1kZXRlY3QgbXV4LWxvY2tlZCBvciBwYXJlbnQt
bG9ja2VkIHdhcyBhDQptaXN0YWtlLCBhbmQgZXZlcnl0aGluZyB3b3VsZCBoYXZlIGJlZW4gc28g
bXVjaCBlYXNpZXIgaWYgdGhlDQpkZXZpY2UtdHJlZSBjb3VsZCBhbHdheXMganVzdCBzdGF0ZSB3
aGF0IHRoZSByZXF1aXJlbWVudCBpcy4gQXQNCmxlYXN0IHRoYXQncyBteSBjdXJyZW50IHRob3Vn
aHRzIG9uIHRoZSBtYXR0ZXIuIE1heWJlIHdlIHNob3VsZA0KYXR0ZW1wdCB0byByZW1vdmUgdGhl
IHVnbHkgYXV0by1kZXRlY3QgY29kZSBhbmQgc2VlIGlmIGFueW9uZQ0KY29tcGxhaW5zPw0KDQpC
dXQgb2YgY291cnNlLCBhbm90aGVyIGFzcGVjdCBpcyB0aGF0IG5vdCBldmVyeXRoaW5nIGlzIERU
LCBzbw0KcGVyaGFwcyB0aGVyZSBpcyBubyBjbGVhbiBzb2x1dGlvbj8NCg0KQ2hlZXJzLA0KUGV0
ZXINCg0KWzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE2LzEvNi80MzcNCg==
