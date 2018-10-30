Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DBBC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4342F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ktCTeZR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4342F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeJaBrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:47:14 -0400
Received: from mail-eopbgr690062.outbound.protection.outlook.com ([40.107.69.62]:15497
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbeJaBrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZd+2mQCAUiThA8dczLve1WEPYzJRRoEaewiJ0y9MgM=;
 b=ktCTeZR9Rb9Te438fvvwy8ENXDvvVEVB7boW/sUJMhpJLbg6I2Rpq7JE1eSSDOf5KHH947ogcMRxGOhGXZkeLzWXZd3CbHKpcEvozsbzTyl79lFgjRwL82VPnd6Sv+0XUEmFQSGYpWOv2OvHHXdh5WGNnJ+Tgag4fxtUZVoHj7w=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4744.namprd05.prod.outlook.com (52.135.233.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.16; Tue, 30 Oct 2018 16:52:56 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.018; Tue, 30 Oct 2018
 16:52:56 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Topic: [PATCH v3 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Index: AQHUVc1A1pnRvXeeC0qBolVm1YmtjKU4MKcAgAAFTYCAAABwgA==
Date:   Tue, 30 Oct 2018 16:52:55 +0000
Message-ID: <0AC59738-06A0-43DC-8622-D4177FDDC1F3@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
 <E1B69BF2-458D-435C-8065-6944111A9EC6@vmware.com>
 <20181030165119.GA23017@kroah.com>
In-Reply-To: <20181030165119.GA23017@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4744;20:cmbvBTG6udF5jtV8cPaXDbnnQzNhfpvnPzhPGcnm4Yhm6C8+fXYAWl0j6DZaq7uENWFV13eAGV49IkqnXmOrCo49/J/FD+z2urEIcah4edTYb4wqiXwQb8unDFjWfL51nTiqHXKjcZWneoNvabpld1hf80sEJVP/FfblEisuBLw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5baa9a34-31f8-4e91-55f5-08d63e88240e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4744;
x-ms-traffictypediagnostic: BYAPR05MB4744:
x-microsoft-antispam-prvs: <BYAPR05MB4744099AECBD1105066FCE65D0CC0@BYAPR05MB4744.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4744;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4744;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(99286004)(229853002)(82746002)(106356001)(446003)(68736007)(102836004)(33656002)(6346003)(476003)(26005)(2616005)(6116002)(3846002)(53936002)(186003)(11346002)(6916009)(76176011)(6512007)(6246003)(53546011)(6506007)(2900100001)(486006)(7736002)(5250100002)(305945005)(25786009)(81156014)(2501003)(1730700003)(81166006)(14454004)(2906002)(83716004)(5660300001)(66066001)(71190400001)(71200400001)(8676002)(97736004)(6486002)(86362001)(256004)(14444005)(4326008)(478600001)(5640700003)(6436002)(316002)(36756003)(8936002)(105586002)(2351001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4744;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: 8pgoBE4QnLDwV7j7d1iqYKSZY50hSuo7Sks+qmbNdociEVqfS/bEWY9lFppelzZHjkufxVaQf5pB+wbq+kXpT5HcLXKmi1qt8oCgZ0tjgznj+IcEr9+S8+NAFTSgQ10rV4ARNX3Xux2OKaMNwunSSRffSyvyQYdpCtsS0d/9NMyxXF6JBD2i/Y4KKoSEf+LfJnRYQzEFbbVuRiJdcSeNilaHTOLrsTPxZ2+uX7TsROfLXcgwX+MTRkqPtcRNFg75m8DV3m8HOG1184IYO5+QJcuZb5Xq0oETq5FSBb8LBEXz1l1aXoKIxJkspbpC+KCTi2dIqGhJwiQwdQQZBAFgvpWU3lmvy2XII64+4/LR/qc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CCA2CD2D1B0CB40BFE7D3E9D4A8D497@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baa9a34-31f8-4e91-55f5-08d63e88240e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 16:52:55.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNClNlbnQ6IE9jdG9iZXIgMzAsIDIwMTgg
YXQgNDo1MToxOSBQTSBHTVQNCj4gVG86IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+
IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiwgWGF2aWVyIERlZ3VpbGxhcmQgPHhk
ZWd1aWxsYXJkQHZtd2FyZS5jb20+LCBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
PiwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4sIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+LCBsaW51eC1tbUBrdmFjay5vcmcgPGxpbnV4LW1tQGt2YWNrLm9yZz4s
IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnIDx2aXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAw
MC8yMF0gdm13X2JhbGxvb246IGNvbXBhY3Rpb24sIHNocmlua2VyLCA2NC1iaXQsIGV0Yy4NCj4g
DQo+IA0KPiBPbiBUdWUsIE9jdCAzMCwgMjAxOCBhdCAwNDozMjoyMlBNICswMDAwLCBOYWRhdiBB
bWl0IHdyb3RlOg0KPj4gRnJvbTogTmFkYXYgQW1pdA0KPj4gU2VudDogU2VwdGVtYmVyIDI2LCAy
MDE4IGF0IDc6MTM6MTYgUE0gR01UDQo+Pj4gVG86IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+LCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KPj4+IENjOiBYYXZpZXIgRGVndWlsbGFy
ZCA8eGRlZ3VpbGxhcmRAdm13YXJlLmNvbT4sIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
LCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiwgTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4sIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+LCBsaW51eC1tbUBr
dmFjay5vcmc+LCB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPj4+
IFN1YmplY3Q6IFtQQVRDSCB2MyAwMC8yMF0gdm13X2JhbGxvb246IGNvbXBhY3Rpb24sIHNocmlu
a2VyLCA2NC1iaXQsIGV0Yy4NCj4+PiANCj4+PiANCj4+PiBUaGlzIHBhdGNoLXNldCBhZGRzIHRo
ZSBmb2xsb3dpbmcgZW5oYW5jZW1lbnRzIHRvIHRoZSBWTXdhcmUgYmFsbG9vbg0KPj4+IGRyaXZl
cjoNCj4+PiANCj4+PiAxLiBCYWxsb29uIGNvbXBhY3Rpb24gc3VwcG9ydC4NCj4+PiAyLiBSZXBv
cnQgdGhlIG51bWJlciBvZiBpbmZsYXRlZC9kZWZsYXRlZCBiYWxsb29uZWQgcGFnZXMgdGhyb3Vn
aCB2bXN0YXQuDQo+Pj4gMy4gTWVtb3J5IHNocmlua2VyIHRvIGF2b2lkIGJhbGxvb24gb3Zlci1p
bmZsYXRpb24gKGFuZCBPT00pLg0KPj4+IDQuIFN1cHBvcnQgVk1zIHdpdGggbWVtb3J5IGxpbWl0
IHRoYXQgaXMgZ3JlYXRlciB0aGFuIDE2VEIuDQo+Pj4gNS4gRmFzdGVyIGFuZCBtb3JlIGFnZ3Jl
c3NpdmUgaW5mbGF0aW9uLg0KPj4+IA0KPj4+IFRvIHN1cHBvcnQgY29tcGFjdGlvbiB3ZSB3aXNo
IHRvIHVzZSB0aGUgZXhpc3RpbmcgaW5mcmFzdHJ1Y3R1cmUuDQo+Pj4gSG93ZXZlciwgd2UgbmVl
ZCB0byBtYWtlIHNsaWdodCBhZGFwdGlvbnMgZm9yIGl0LiBXZSBhZGQgYSBuZXcgbGlzdA0KPj4+
IGludGVyZmFjZSB0byBiYWxsb29uLWNvbXBhY3Rpb24sIHdoaWNoIGlzIG1vcmUgZ2VuZXJpYyBh
bmQgZWZmaWNpZW50LA0KPj4+IHNpbmNlIGl0IGRvZXMgbm90IHJlcXVpcmUgYXMgbWFueSBJUlEg
c2F2ZS9yZXN0b3JlIG9wZXJhdGlvbnMuIFdlIGxlYXZlDQo+Pj4gdGhlIG9sZCBpbnRlcmZhY2Ug
dGhhdCBpcyB1c2VkIGJ5IHRoZSB2aXJ0aW8gYmFsbG9vbi4NCj4+PiANCj4+PiBCaWcgcGFydHMg
b2YgdGhpcyBwYXRjaC1zZXQgYXJlIGNsZWFudXAgYW5kIGRvY3VtZW50YXRpb24uIFBhdGNoZXMg
MS0xMw0KPj4+IHNpbXBsaWZ5IHRoZSBiYWxsb29uIGNvZGUsIGRvY3VtZW50IGl0cyBiZWhhdmlv
ciBhbmQgYWxsb3cgdGhlIGJhbGxvb24NCj4+PiBjb2RlIHRvIHJ1biBjb25jdXJyZW50bHkuIFRo
ZSBzdXBwb3J0IGZvciBjb25jdXJyZW5jeSBpcyByZXF1aXJlZCBmb3INCj4+PiBjb21wYWN0aW9u
IGFuZCB0aGUgc2hyaW5rZXIgaW50ZXJmYWNlLg0KPj4+IA0KPj4+IEZvciBkb2N1bWVudGF0aW9u
IHdlIHVzZSB0aGUga2VybmVsLWRvYyBmb3JtYXQuIFdlIGFyZSBhd2FyZSB0aGF0IHRoZQ0KPj4+
IGJhbGxvb24gaW50ZXJmYWNlIGlzIG5vdCBwdWJsaWMsIGJ1dCBmb2xsb3dpbmcgdGhlIGtlcm5l
bC1kb2MgZm9ybWF0IG1heQ0KPj4+IGJlIHVzZWZ1bCBvbmUgZGF5Lg0KPj4+IA0KPj4+IHYyLT52
MzogKiBNb3ZpbmcgdGhlIGJhbGxvb24gbWFnaWMtbnVtYmVyIG91dCBvZiB1YXBpIChHcmVnKQ0K
Pj4+IA0KPj4+IHYxLT52MjoJKiBGaXggYnVpbGQgZXJyb3Igd2hlbiBUSFAgaXMgb2ZmIChrYnVp
bGQpDQo+Pj4gCSogRml4IGJ1aWxkIGVycm9yIG9uIGkzODYgKGtidWlsZCkNCj4+IA0KPj4gR3Jl
ZywNCj4+IA0KPj4gSSByZWFsaXplIHlvdSBkaWRu4oCZdCBhcHBseSBwYXRjaGVzIDE3LTIwLiBB
bnkgcmVhc29uIGZvciB0aGF0Pw0KPiANCj4gSSBoYXZlIG5vIGlkZWEsIHRoYXQgd2FzIGEgZmV3
IHRob3VzYW5kIHBhdGNoZXMgcmV2aWV3ZWQgYWdvLi4uDQo+IA0KPiBEaWQgSSBub3Qgc2F5IGFu
eXRoaW5nIGFib3V0IHRoaXMgd2hlbiBJIGFwcGxpZWQgdGhlbT8NCj4gDQo+IGdyZWcgay1oDQoN
CllvdSByZWdhcmRlZCB0aGUgbWFnaWMtbnVtYmVyIGluIHYyLCB3aGljaCBJIGZpeGVkIGZvciB2
My4NCg0KU2hvdWxkIEkgcmVzZW5kPw0KDQo=
