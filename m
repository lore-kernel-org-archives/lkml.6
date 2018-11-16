Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E22086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="MdsL6DKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8E22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeKQGcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:32:54 -0500
Received: from mail-eopbgr680070.outbound.protection.outlook.com ([40.107.68.70]:62997
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbeKQGcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97+WkQW8mRQMhBRZlz1JDQczkxApoTbxefePtlfGgp8=;
 b=MdsL6DKXlODMGw9BRwNTqemHXpcMNuDNyjwJlX/LMxCqGOSITCUqVtiz9qsBTGuedhZH440S7AJsvRW03pEKiyYa542r3EDS2+PFcPPqcVUI2IxTVIhOcyuHBWKVpz3qv/VLyySnS+Ry3+EASVi/nJfUkdRTYrW+w247Fn52A1k=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4392.namprd05.prod.outlook.com (52.135.202.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.11; Fri, 16 Nov 2018 20:18:58 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.023; Fri, 16 Nov 2018
 20:18:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86: set a dependency on macros.S
Thread-Topic: [PATCH v2 2/2] x86: set a dependency on macros.S
Thread-Index: AQHUfJfhME2VCVedbU2G/6lCfEvm4qVSBVgAgADUqwA=
Date:   Fri, 16 Nov 2018 20:18:58 +0000
Message-ID: <C359F0E6-2920-428F-B93E-7C76E564C1BA@vmware.com>
References: <20181114204309.18645-1-namit@vmware.com>
 <20181114204309.18645-3-namit@vmware.com>
 <CAK7LNAR30CVQHBTXzY-cFcpa-mw2QSpqUZHEAs7n0Jn64dLBFw@mail.gmail.com>
In-Reply-To: <CAK7LNAR30CVQHBTXzY-cFcpa-mw2QSpqUZHEAs7n0Jn64dLBFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4392;20:iW2V1ij18hUPEl1DbIhbxpVbmmuYu2QSpzjoVk2nd6UZihF6z7A3qbMUyIWmx1FTTcwgkeu1p2gdkOB8ajeS3bn6ZUKHHNRz/8gdkTFMeigpVVLQzm4X1pClkYUN1m/GVUV7aQ5/VytIjfLV/G1ZtJgHPoanYr0gh9auSkSWKwk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 12d153dc-269a-4114-94ab-08d64c00bdb8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4392;
x-ms-traffictypediagnostic: BYAPR05MB4392:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB439272698E4CF14F86CD3A57D0DD0@BYAPR05MB4392.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(944501410)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4392;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4392;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(6512007)(14454004)(71190400001)(83716004)(478600001)(33656002)(97736004)(71200400001)(26005)(66066001)(105586002)(76176011)(106356001)(36756003)(102836004)(82746002)(54906003)(6506007)(99286004)(53546011)(316002)(486006)(6486002)(2900100001)(256004)(5660300001)(3846002)(6116002)(305945005)(446003)(2616005)(4326008)(11346002)(25786009)(6246003)(186003)(476003)(8936002)(86362001)(81166006)(81156014)(8676002)(53936002)(6436002)(229853002)(7736002)(68736007)(6916009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4392;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tsxC+jaa0hKO/cyPQdfr4eDBGIWaTZEstPW2bkNFQ/1XSTW3J/eiT2J+HS8DSsk9pDMzPXtvw+waBQUdzHNaoHALHW6nU7KEJX+qHyU4as42lGAOhLvfIN38VQRRCtROjHKWku4bQ/uEHHQseZFtnnUIgYBOHk7IHHhcnHuiN7wpnHyDn2+b8cMI37nw0MxB9lbnbxf3nAD9fJIG4FDrMaFK/JwVoOA8ncvIebSoKTgN2m2Lx2JslokIzO5s9SkmLGsJdQjj9Orm02TB4+nTyUDAoWOBewzfBBlo560ho4p15stnMnhIKmjH6ZAJ27jQWgDrjhEbM1YlNrFC/FxGPwAxJLr+m27uiTCgwwmFUDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB0AF2066A1B464A8FF40E7ACA58E272@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d153dc-269a-4114-94ab-08d64c00bdb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 20:18:58.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhDQpTZW50OiBOb3ZlbWJlciAxNiwgMjAxOCBhdCA3OjM3OjQ2
IEFNIEdNVA0KPiBUbzogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gQ2M6IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPiwgTWljaGFsIE1hcmVrIDxtaWNoYWwubGttbEBtYXJr
b3ZpLm5ldD4sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiwgQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4sIFg4
NiBNTCA8eDg2QGtlcm5lbC5vcmc+LCBMaW51eCBLYnVpbGQgbWFpbGluZyBsaXN0IDxsaW51eC1r
YnVpbGRAdmdlci5rZXJuZWwub3JnPiwgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIHg4
Njogc2V0IGEgZGVwZW5kZW5jeSBvbiBtYWNyb3MuUw0KPiANCj4gDQo+IE9uIFRodSwgTm92IDE1
LCAyMDE4IGF0IDE6MDEgUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+
PiBDaGFuZ2VzIGluIG1hY3Jvcy5TIHNob3VsZCB0cmlnZ2VyIHRoZSByZWNvbXBpbGF0aW9uIG9m
IGFsbCBDIGZpbGVzLCBhcw0KPj4gdGhlIG1hY3JvcyBtaWdodCBuZWVkIHRvIGFmZmVjdCB0aGVp
ciBjb21waWxhdGlvbi4NCj4+IA0KPj4gQWNrZWQtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJu
ZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4N
Cj4+IC0tLQ0KPiANCj4gV2hlbiB3ZSB0YWxrZWQgYWJvdXQgdGhpcyBsYXN0IHRpbWUsDQo+IHdl
IGFncmVlZCB0byBub3QgZG8gdGhpcw0KPiBiZWNhdXNlIGEgc2luZ2xlIGxpbmUgY2hhbmdlIGlu
IGFzbSBoZWFkZXJzDQo+IHdvdWxkIGNhdXNlIGdsb2JhbCByZWJ1aWxkaW5nLg0KPiANCj4gRGlk
IHlvdSBjaGFuZ2UgeW91ciBtaW5kPw0KDQpJIHdhcyB3cm9uZyAoYW5kIHlvdSB3ZXJlIHJpZ2h0
PyBJIGRvbuKAmXQgcXVpdGUgcmVtZW1iZXIpLiBBbnlob3csIGFub3RoZXINCnBhdGNoIEkgd29y
ayBvbiBtYWRlIG1lIHJlYWxpemUgaG93IHdyb25nIEkgd2FzLg0KDQpJZiByZXF1aXJlZCwgd2Ug
Y2FuIGV4dHJhY3QgdGhlIG1hY3JvcyBmcm9tIHNvbWUgb2YgdGhlIGhlYWRlciBmaWxlcyBpbnRv
DQpzZXBhcmF0ZSBoZWFkZXIgZmlsZXMgdG8gcHJldmVudCB1bm5lY2Vzc2FyeSByZWJ1aWxkcy4N
Cg0KVGhhbmtzLA0KTmFkYXY=
