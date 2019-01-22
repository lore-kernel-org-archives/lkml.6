Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A28AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A43217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ByFM4IEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAVUY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:24:58 -0500
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:63904
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfAVUY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G005N93oq2pALirgGK57AqDGuHIhhPjyEc6XC+9uAls=;
 b=ByFM4IEC+aISjjszOh0bKggDWA/Cc7YVQVBKclADTrS3G2t0x7PMc+tgbagEH+PVqr/M8lZSYdTef0GUV5siWxckr6u/c+qRjAvD1st+B0WmpmXWtHmoYjsbxlDu76e1g3YyaHX6JBvTWWOgp2y6PClfjqzxKp6sMUmVLCKfN/4=
Received: from MN2PR12MB3631.namprd12.prod.outlook.com (20.178.243.19) by
 MN2PR12MB3392.namprd12.prod.outlook.com (20.178.242.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.28; Tue, 22 Jan 2019 20:24:52 +0000
Received: from MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044]) by MN2PR12MB3631.namprd12.prod.outlook.com
 ([fe80::a861:43c0:476d:e044%5]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 20:24:52 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: tsc: Fast TSC calibration failed with AMD B350M/Ryzen 3 2200G
Thread-Topic: tsc: Fast TSC calibration failed with AMD B350M/Ryzen 3 2200G
Thread-Index: AQHUoO/vPVjTHRVqDk6vrw3sWwKfhKWj+EYAgAACq4CABp/WgIAEBdmAgA0DjQCAADr+gA==
Date:   Tue, 22 Jan 2019 20:24:51 +0000
Message-ID: <b95f5c96-2428-1f3b-0be4-ca7b439c7124@amd.com>
References: <fd05d500-f1b5-7115-4326-7c7fee9f5456@molgen.mpg.de>
 <alpine.DEB.2.21.1901071622160.2688@nanos.tec.linutronix.de>
 <9f444c64-c221-e729-7eb5-fc4f093c16d3@molgen.mpg.de>
 <alpine.DEB.2.21.1901112141480.1661@nanos.tec.linutronix.de>
 <5656446a-eaef-aa94-8766-49fec24257c6@molgen.mpg.de>
 <0bacd3f0-12fd-c1d9-8bed-320ac87d4505@molgen.mpg.de>
In-Reply-To: <0bacd3f0-12fd-c1d9-8bed-320ac87d4505@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) To MN2PR12MB3631.namprd12.prod.outlook.com
 (2603:10b6:208:cc::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3392;20:A8sM6uS9GgmTULCucAVSHARV+XrB+o2zzxPmCUTtPJew0psouU2iHKjeQw7Duea+T24/zmoTtB0NiEd5bulJrNJNQxXeGErw5MpFWjObUhQ4CTHdetWfDxFyV79QbGy30S0a9tYhjyEJDrg7MS3cbNXARzJ+WzO9vw8kd81IAIkk5gWd9/w9Or3QLUygiAZ/mcJ59n8pZwnjRXr9ozKeM3Ey8LBArvpIpisIhk4azzr43bssDH9AqIZZtxdknhsr
x-ms-office365-filtering-correlation-id: 20e0b072-73db-41b5-ddba-08d680a7a9ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3392;
x-ms-traffictypediagnostic: MN2PR12MB3392:
x-microsoft-antispam-prvs: <MN2PR12MB3392B250532924703D8605D7EC980@MN2PR12MB3392.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(256004)(93886005)(102836004)(71190400001)(6116002)(14444005)(305945005)(81156014)(7736002)(229853002)(3846002)(86362001)(81166006)(8676002)(52116002)(76176011)(71200400001)(2616005)(26005)(53546011)(11346002)(446003)(386003)(186003)(6506007)(14454004)(72206003)(99286004)(105586002)(106356001)(476003)(966005)(413944005)(6436002)(478600001)(6486002)(16799955002)(97736004)(31686004)(2906002)(6512007)(6306002)(68736007)(316002)(53936002)(8936002)(31696002)(54906003)(6246003)(486006)(4326008)(66066001)(110136005)(36756003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3392;H:MN2PR12MB3631.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JjqIkT3peWO787C7kv+m7H36ng6o7/no8TVw6fJ39qhOAddKaZVbC47O4xddyFOq0XN9iAtXkbqsqkJdwbw3HtkLvV6gAzVqireCpSkIJaICHNi4QZqNx0RPszAT6uubVH05iMAmZTdR1KUDAy92aYDe9lScEOrP5Cr/inz7pE9KtXhCz4xs7UPFCNsb81DMa33ctYK7vSVxSLEZ5hyogE8D/PREZijXCpmlHujj5iJ+hf3Te1OKaYToGTKWGNRCW5w7TdTpLweQsuC0OcR57ZKVPoP0wQtyI/u65bc6cHenwy+J2xtzwLUUAyXtfv0fyvd6201CoOdxi0or8D6VRUHcG0eMdTsjuQG0yVpJcqBi/W7oN/n66QVx08DuCj9StT8S/MnNKbF3tWsW2yEabhw7xHDVEbB/rUg/r1nEYvQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC62F5E94504D44FBAA81772E030F403@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e0b072-73db-41b5-ddba-08d680a7a9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 20:24:51.0648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMi8xOSAxMDo1MyBBTSwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+IFtBZGRpbmcgVG9tIHRv
IENDXQ0KPiANCj4gRGVhciBUaG9tYXMsIGRlYXIgVG9tLA0KPiANCj4gDQo+IE9uIDAxLzE0LzE5
IDExOjA5LCBQYXVsIE1lbnplbCB3cm90ZToNCj4gDQo+PiBPbiAwMS8xMS8xOSAyMTo0MywgVGhv
bWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4NCj4+PiBPbiBNb24sIDcgSmFuIDIwMTksIFBhdWwgTWVu
emVsIHdyb3RlOg0KPj4+PiBPbiAwMS8wNy8xOSAxNjoyNCwgVGhvbWFzIEdsZWl4bmVyIHdyb3Rl
Og0KPj4+Pj4+IExpbnV4IDQuMTkuMTMgZnJvbSBEZWJpYW4gU2lkL3Vuc3RhYmxlIGxvZ3MgdGhl
IG1lc3NhZ2UgYmVsb3cgb24gdGhlIGJvYXJkIE1TSQ0KPj4+Pj4+IE1TLTdBMzcvQjM1ME0gTU9S
VEFSIHdpdGggdGhlIHByb2Nlc3NvciBBTUQgUnl6ZW4gMyAyMjAwRy4NCj4+Pj4+Pg0KPj4+Pj4+
IEFzIGEgcmVzdWx0LCB0aGUgZWFybHkgdGltZSBzdGFtcHMgZG8gbm90IHNlZW0gdG8gYmUgd29y
a2luZy4NCj4+Pj4+DQo+Pj4+Pj4+IFsgICAgMC4wMDAwMDBdIERNSTogTWljcm8tU3RhciBJbnRl
cm5hdGlvbmFsIENvLiwgTHRkLiBNUy03QTM3L0IzNTBNIE1PUlRBUiAoTVMtN0EzNyksIEJJT1Mg
MS5JMCAxMS8wNi8yMDE4DQo+Pj4+Pj4+IFsgICAgMC4wMDAwMDBdIHRzYzogRmFzdCBUU0MgY2Fs
aWJyYXRpb24gZmFpbGVkDQo+Pj4+Pg0KPj4+Pj4gQW5kIHRoZSBmdXJ0aGVyIGJvb3QgbG9nIHNh
eXM6DQo+Pj4+Pg0KPj4+Pj4gWyAgICAwLjAzNjAwMF0gdHNjOiBVbmFibGUgdG8gY2FsaWJyYXRl
IGFnYWluc3QgUElUDQo+Pj4+PiBbICAgIDAuMDM2MDAwXSB0c2M6IHVzaW5nIEhQRVQgcmVmZXJl
bmNlIGNhbGlicmF0aW9uDQo+Pj4+PiBbICAgIDAuMDM2MDAwXSB0c2M6IERldGVjdGVkIDM1MDAu
MTE3IE1IeiBwcm9jZXNzb3INCj4+Pj4+DQo+Pj4+PiBTbyB0aGUgcXVpY2sgY2FsaWJyYXRpb24g
aW4gZWFybHkgYm9vdCBmYWlscyBiZWNhdXNlIHRoZSBQSVQgc2VlbXMgbm90IHRvDQo+Pj4+PiBk
byB3aGF0IHRoZSBrZXJuZWwgZXhwZWN0cy4gTm90aGluZyB3ZSBjYW4gY3VyZSA6KA0KPj4+Pg0K
Pj4+PiBJIHNlZS4gQ2FuIEFNRCBjb25maXJtIHRoYXQgdGhpcyBpcyB0aGUgZXhwZWN0ZWQgYmVo
YXZpb3I/IElmIHllcywgc2hvdWxkDQo+Pj4+IHRoZSBmYXN0IFRTQyBjYWxpYnJhdGlvbiBiZSBz
a2lwcGVkIG9uIHRoZXNlIGRldmljZXM/DQoNCkhpIFBhdWwsDQoNCkl0J3Mgbm90IGV4cGVjdGVk
IGJlaGF2aW9yLiBBbGwgb2YgdGhlIHN5c3RlbXMgdGhhdCBJIGhhdmUgYWNjZXNzIHRvIGRvDQpu
b3QgZXhoaWJpdCB0aGlzIGlzc3VlLiBIYXZpbmcgc2FpZCB0aGF0LCBJIGhhdmUgYSBsaW1pdGVk
IG51bWJlciBvZg0Kc3lzdGVtcyBhdmFpbGFibGUgdG8gbWUuDQoNCkkgZG9uJ3QgaGF2ZSBtdWNo
IGV4cGVyaWVuY2UgaW4gdGhpcyBhcmVhLCBidXQgaWYgaXQgaXMgc29tZXRoaW5nIHRoYXQNCmNv
bnNpc3RlbnRseSBvY2N1cnMsIHlvdSBtaWdodCB0cnkgdG8gc2VlIGlmIHlvdSBjYW4gYmV0dGVy
IGlkZW50aWZ5IHdoeQ0KaXQgZmFpbHMuIFRoZSBtZXNzYWdlIGlzIGlzc3VlZCBpbiBwaXRfaHBl
dF9wdGltZXJfY2FsaWJyYXRlX2NwdSgpIGluIGZpbGUNCmFyY2gveDg2L2tlcm5lbC90c2MuYy4N
Cg0KVGhhbmtzLA0KVG9tDQoNCj4+Pg0KPj4+IEl0IHNob3VsZCB3b3JrIGFuZCB3ZSByZWFsbHkg
ZG9uJ3Qgd2FudCB0byBhZGQgY3B1IGZhbWlseS9tb2RlbCBiYXNlZA0KPj4+IGRlY2lzaW9ucyB3
aGV0aGVyIHdlIGludm9rZSBzb21ldGhpbmcgb3Igbm90LiBUaG9zZSB0YWJsZXMgYXJlIHN0YWxl
IGJlZm9yZQ0KPj4+IHRoZXkgaGl0IG1haW5saW5lLg0KPj4NCj4+IFVuZGVyc3Rvb2QuIElmIGl0
4oCZcyBzdXBwb3NlZCB0byB3b3JrLCBhbnkgaGludHMgb24gaG93IHRvIGRlYnVnIHRoaXM/DQo+
Pg0KPj4gRG9lcyBzb21lIExpbnV4IGtlcm5lbCBkZXZlbG9wZXJzIGhhdmUgYW4gQU1EIFJ5emVu
IHN5c3RlbSwgYW5kIGNhbiByZXByb2R1Y2UNCj4+IHRoZSBpc3N1ZT8NCj4+DQo+PiBJdCBzZWVt
cyB0byBmYWlsIHdpdGggYW4gQU1EIFJ5emVuIDI0MDBHIHRvbyBbMV0uDQo+IA0KPiBXZSBub3cg
aGF2ZSBhbiBIUCBFbGl0ZURlc2sgNzA1IEc0IE1UIHdpdGggdGhhdCBwcm9jZXNzc29yLCBzaG93
aW5nIHRoZSBzYW1lDQo+IHByb2JsZW0uDQo+IA0KPiBgYGANCj4gWyAgICAwLjAwMDAwMF0gTGlu
dXggdmVyc2lvbiA0LjIwLjAubXg2NC4yMzggKHJvb3RAZWxjYXR0aXZvLm1vbGdlbi5tcGcuZGUp
IChnY2MgdmVyc2lvbiA3LjMuMCAoR0NDKSkgIzEgU01QIE1vbiBEZWMgMjQgMTQ6NTA6MDAgQ0VU
IDIwMTgNCj4gW+KApl0NCj4gWyAgICAwLjAwMDAwMF0gTlggKEV4ZWN1dGUgRGlzYWJsZSkgcHJv
dGVjdGlvbjogYWN0aXZlDQo+IFsgICAgMC4wMDAwMDBdIFNNQklPUyAzLjEgcHJlc2VudC4NCj4g
WyAgICAwLjAwMDAwMF0gRE1JOiBIUCBIUCBFbGl0ZURlc2sgNzA1IEc0IE1ULzgzRTcsIEJJT1Mg
UTA2IFZlci4gMDIuMDQuMDEgMDkvMTQvMjAxOA0KPiBbICAgIDAuMDAwMDAwXSB0c2M6IEZhc3Qg
VFNDIGNhbGlicmF0aW9uIGZhaWxlZA0KPiBbICAgIDAuMDAwMDAwXSBlODIwOiB1cGRhdGUgW21l
bSAweDAwMDAwMDAwLTB4MDAwMDBmZmZdIHVzYWJsZSA9PT4gcmVzZXJ2ZWQNCj4gW+KApl0NCj4g
WyAgICAwLjAxNzg2MF0gc21wYm9vdDogQ1BVMDogQU1EIFJ5emVuIDUgUFJPIDI0MDBHIHdpdGgg
UmFkZW9uIFZlZ2EgR3JhcGhpY3MgKGZhbWlseTogMHgxNywgbW9kZWw6IDB4MTEsIHN0ZXBwaW5n
OiAweDApDQo+IFvigKZdDQo+IGBgYA0KPiANCj4+IEl0IGFsc28gZmFpbHMgb24gYW4gQU1EIFJ5
emVuIDcgMTcwMCBbMl0uDQo+Pg0KPj4gYGBgDQo+PiBbIDAuMDAwMDAwXSBMaW51eCB2ZXJzaW9u
IDQuMTUuMC1rYWxpMy1hbWQ2NCAoZGV2ZWxAa2FsaS5vcmcpIChnY2MgdmVyc2lvbiA3LjMuMCAo
RGViaWFuIDcuMy4wLTE2KSkgIzEgU01QIERlYmlhbiA0LjE1LjE3LTFrYWxpMSAoMjAxOC0wNC0y
NSkNCj4+IFvigKZdDQo+PiBbIDAuMDA4MDAwXSAuLlRJTUVSOiB2ZWN0b3I9MHgzMCBhcGljMT0w
IHBpbjE9MiBhcGljMj0tMSBwaW4yPS0xDQo+PiBbIDAuMDI4MDAwXSB0c2M6IEZhc3QgVFNDIGNh
bGlicmF0aW9uIGZhaWxlZA0KPj4gWyAwLjAzMjAwMF0gdHNjOiBQSVQgY2FsaWJyYXRpb24gbWF0
Y2hlcyBIUEVULiAxIGxvb3BzDQo+PiBbIDAuMDMyMDAwXSB0c2M6IERldGVjdGVkIDI5OTQuMjQ2
IE1IeiBwcm9jZXNzb3INCj4+IFvigKZdDQo+PiBbIDAuMDQ0MDAwXSBzbXBib290OiBDUFUwOiBB
TUQgUnl6ZW4gNyAxNzAwIEVpZ2h0LUNvcmUgUHJvY2Vzc29yIChmYW1pbHk6IDB4MTcsIG1vZGVs
OiAweDEsIHN0ZXBwaW5nOiAweDEpDQo+PiBgYGANCj4+DQo+PiBJdCAqd29ya3MqIGhlcmUgb24g
b25lIHN5c3RlbSB3aXRoIEFNRCBSeXplbiA1IFBSTyAxNTAwIGFuZCBMaW51eCA0LjE0Ljg3Lg0K
Pj4NCj4+IGBgYA0KPj4gWyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA0LjE0Ljg3Lm14NjQu
MjM2IChyb290QGxpa2Vhcm9sbGluZ3N0b25lLm1vbGdlbi5tcGcuZGUpIChnY2MgdmVyc2lvbiA3
LjMuMCAoR0NDKSkgIzEgU01QIE1vbiBEZWMgMTAgMDk6NDg6NTcgQ0VUIDIwMTgNCj4+IFvigKZd
DQo+PiBbICAgIDAuMDAwMDAwXSB0c2M6IEZhc3QgVFNDIGNhbGlicmF0aW9uIHVzaW5nIFBJVA0K
Pj4gW+KApl0NCj4+IFsgICAgMC4wMzUwMDBdIHNtcGJvb3Q6IENQVTA6IEFNRCBSeXplbiA1IFBS
TyAxNTAwIFF1YWQtQ29yZSBQcm9jZXNzb3IgKGZhbWlseTogMHgxNywgbW9kZWw6IDB4MSwgc3Rl
cHBpbmc6IDB4MSkNCj4+IGBgYA0KPiANCj4gSG93IHRvIGNvbnRpbnVlIGZyb20gaGVyZT8gSXMg
ZG9jdW1lbnRhdGlvbiBmb3IgdGhhdCBhdmFpbGFibGUgZnJvbSBBTUQ/DQo+IEkgZGlkbuKAmXQg
ZmluZCBhIEJLREcgKEJpb3MgS2VybmVsIERldmVsb3BlciBHdWlkZSkgYXQgWzNdLg0KPiANCj4g
DQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCj4gDQo+IA0KPj4gWzFdOiBodHRwczovL2Ji
cy5hcmNobGludXgub3JnL3ZpZXd0b3BpYy5waHA/cGlkPTE3ODEyODIjcDE3ODEyODINCj4+IFsy
XTogaHR0cHM6Ly9mb3J1bXMua2FsaS5vcmcvc2hvd3RocmVhZC5waHA/NDA0NDQtZXJyb3ItbG9h
ZGluZy1hbWRncHUtZHJpdmVycy1BTUQtUlg1ODAtZHJpdmVyWzNdOiBodHRwczovL2RldmVsb3Bl
ci5hbWQuY29tL3Jlc291cmNlcy9kZXZlbG9wZXItZ3VpZGVzLW1hbnVhbHMvDQo+IA0K
