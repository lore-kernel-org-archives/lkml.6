Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1837CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819362086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EJSjrC5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeLNUJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:09:10 -0500
Received: from mail-eopbgr740058.outbound.protection.outlook.com ([40.107.74.58]:59648
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729808AbeLNUJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8098JhCVdhKekg3WKZnvMt/UZykkPW0/HTaA+4pp+YM=;
 b=EJSjrC5ZJKaAPCB+YJ9cJWWxs/jY7dMbBQichd36Bih3C6fjG+JDHOvKWI3nVOVM/i4kj2RjJbKaRio/w+zlVIeL7kLQ95Zr22xf8nbq3RBZVOGJfmbge3PYzPVmItfBFTheys54ZZckrPt9eIa+eyXvYWQNkytPDp8Yx18kPiU=
Received: from BY2PR12MB0178.namprd12.prod.outlook.com (10.162.82.27) by
 BY2PR12MB0194.namprd12.prod.outlook.com (10.162.83.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 20:09:00 +0000
Received: from BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::bd9a:fb2b:f12c:8c81]) by BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::bd9a:fb2b:f12c:8c81%8]) with mapi id 15.20.1404.028; Fri, 14 Dec 2018
 20:09:00 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
CC:     "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by
 reference
Thread-Topic: [PATCH] drm/amd/display: Pass app_tf by value rather than by
 reference
Thread-Index: AQHUkOIFW3RndZyO6kmTUxzjHW0N4KV6Di0AgAAE8ACAAAbxgIAEld6A
Date:   Fri, 14 Dec 2018 20:09:00 +0000
Message-ID: <61e435a1-6f54-ad91-50a6-9989cf75ba90@amd.com>
References: <20181210234201.4850-1-natechancellor@gmail.com>
 <CAKwvOdkOwdrsOAADGp9To2F5o2AAW7123yADFzYLMawwsinmug@mail.gmail.com>
 <20181211214240.GA31705@flashbox>
 <CAKwvOdn4467193YUMCboj+Z62m0+pVMAbjAc4avCsSsng7hpPg@mail.gmail.com>
In-Reply-To: <CAKwvOdn4467193YUMCboj+Z62m0+pVMAbjAc4avCsSsng7hpPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::46) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0194;20:QqrN0+3+maQzG1avpDM+epjjMKA7Wh56orIBxqX4/FtO0SqrLspaptInhUldvHn3B0fKwNQKhOVz/b+hhmso3jq0MN9JWBrWOrvFhCVbh7uCnDB2lPqaR/lDUdBq5eqc3LOtAmZc2hmB+KIXavPyqwo2jL3NYVhXm1jU5JA4auaTnxREeBq8Q1nHC2cgqJO0zXN6U5ldmCHVKOr+0aTXr5G9544dy58Y2+64+4fNssSMGjIXqfvRyqIn58C4Lzm7
x-ms-office365-filtering-correlation-id: 161130c7-234a-4304-77c3-08d661fffc79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0194;
x-ms-traffictypediagnostic: BY2PR12MB0194:
x-microsoft-antispam-prvs: <BY2PR12MB019400E3A8DA091C6CA6ACC98CA10@BY2PR12MB0194.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0194;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0194;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(14444005)(186003)(2616005)(26005)(476003)(72206003)(31696002)(229853002)(99286004)(486006)(65806001)(65956001)(66066001)(6116002)(25786009)(6246003)(3846002)(6486002)(86362001)(105586002)(64126003)(966005)(76176011)(4326008)(39060400002)(31686004)(14454004)(256004)(6436002)(2906002)(53546011)(6506007)(58126008)(5660300001)(6512007)(8676002)(65826007)(386003)(305945005)(54906003)(316002)(93886005)(106356001)(102836004)(6306002)(11346002)(71190400001)(446003)(7736002)(97736004)(53936002)(68736007)(4001150100001)(52116002)(36756003)(8936002)(71200400001)(478600001)(110136005)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0194;H:BY2PR12MB0178.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D3Wm3GuwNnnOA1a+E5PniJTxxVcieV/+AKqNNuLe+4ONNUA2PGKdjM2M0I9WgDOfau0vVKBtgjGzEs78lcgaY3G9lUw5lCfzvThmMkY8aAF4C7Ssk2N/c71Bb3GD9D2+uH9Ul+DimRaDi8QIWvAJtVrVY8WeoH7bnxD4dxwVQUzlks9rwBL24goTRPKqOJxyI8taUfAiza2GOz1W30g8n3H/isAyzrnQ+QPyTrx7mo1D7lpWPvGwswLh9YthPuUPvsCwpHE21QKKBBdgqKtgtQJymFNKAXts1i7nUPmDHsf7vUpxuiecfdLbQBzlyM+W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F49BCF4135EB4E448F4CD1F6461BC503@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161130c7-234a-4304-77c3-08d661fffc79
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 20:09:00.4511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0xMSA1OjA3IHAubS4sIE5pY2sgRGVzYXVsbmllcnMgd3JvdGU6DQo+IE9uIFR1
ZSwgRGVjIDExLCAyMDE4IGF0IDE6NDIgUE0gTmF0aGFuIENoYW5jZWxsb3INCj4gPG5hdGVjaGFu
Y2VsbG9yQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gVHVlLCBEZWMgMTEsIDIwMTggYXQg
MDE6MjU6MDBQTSAtMDgwMCwgTmljayBEZXNhdWxuaWVycyB3cm90ZToNCj4+PiBPbiBNb24sIERl
YyAxMCwgMjAxOCBhdCAzOjQyIFBNIE5hdGhhbiBDaGFuY2VsbG9yDQo+Pj4gPG5hdGVjaGFuY2Vs
bG9yQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IENsYW5nIHdhcm5zIHdoZW4gYW4gZXhw
cmVzc2lvbiB0aGF0IGVxdWFscyB6ZXJvIGlzIHVzZWQgYXMgYSBudWxsDQo+Pj4+IHBvaW50ZXIg
Y29uc3RhbnQgKGluIGxpZXUgb2YgTlVMTCk6DQo+Pj4+DQo+Pj4+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjQ0MzU6MzoNCj4+Pj4g
d2FybmluZzogZXhwcmVzc2lvbiB3aGljaCBldmFsdWF0ZXMgdG8gemVybyB0cmVhdGVkIGFzIGEg
bnVsbCBwb2ludGVyDQo+Pj4+IGNvbnN0YW50IG9mIHR5cGUgJ2NvbnN0IGVudW0gY29sb3JfdHJh
bnNmZXJfZnVuYyAqJw0KPj4+PiBbLVdub24tbGl0ZXJhbC1udWxsLWNvbnZlcnNpb25dDQo+Pj4+
ICAgICAgICAgICAgICAgICBUUkFOU0ZFUl9GVU5DX1VOS05PV04sDQo+Pj4+ICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4+Pj4gMSB3YXJuaW5nIGdlbmVyYXRlZC4NCj4+
Pj4NCj4+Pj4gVGhpcyB3YXJuaW5nIGlzIGNhdXNlZCBieSBjb21taXQgYmI0N2RlNzM2NjYxICgi
ZHJtL2FtZGdwdTogU2V0IEZyZWVTeW5jDQo+Pj4+IHN0YXRlIHVzaW5nIGRybSBWUlIgcHJvcGVy
dGllcyIpIGFuZCBpdCBjb3VsZCBiZSBzb2x2ZWQgYnkgdXNpbmcgTlVMTA0KPj4+PiBpbnN0ZWFk
IG9mIFRSQU5TRkVSX0ZVTkNfVU5LTk9XTiBvciBjYXN0aW5nIFRSQU5TRkVSX0ZVTkNfVU5LTk9X
TiBhcyBhDQo+Pj4+IHBvaW50ZXIuIEhvd2V2ZXIsIGFmdGVyIGxvb2tpbmcgaW50byBpdCwgdGhl
cmUgZG9lc24ndCBhcHBlYXIgdG8gYmUgYQ0KPj4+PiBnb29kIHJlYXNvbiB0byBwYXNzIGFwcF90
ZiBieSByZWZlcmVuY2UgYXMgaXQgaXMgbmV2ZXIgbXV0YXRlZCBhbG9uZyB0aGUNCj4+Pj4gd2F5
LiBUaGlzIGlzIHRoZSBvbmx5IGNvZGUgcGF0aCBpbiB3aGljaCBhcHBfdGYgaXMgdXNlZDoNCj4+
Pj4NCj4+Pj4gbW9kX2ZyZWVzeW5jX2J1aWxkX3Zycl9pbmZvcGFja2V0IC0+DQo+Pj4+ICAgICBi
dWlsZF92cnJfaW5mb3BhY2tldF92MiAtPg0KPj4+PiAgICAgICAgIGJ1aWxkX3Zycl9pbmZvcGFj
a2V0X2ZzMl9kYXRhDQo+Pj4+DQo+Pj4+IE5laXRoZXIgbW9kX2ZyZWVzeW5jX2J1aWxkX3Zycl9p
bmZvcGFja2V0IG9yIGJ1aWxkX3Zycl9pbmZvcGFja2V0X3YyDQo+Pj4+IG1vZGlmeSBhcHBfdGYn
cyB2YWx1ZSBhbmQgYnVpbGRfdnJyX2luZm9wYWNrZXRfZnMyX2RhdGEgZXhwZWN0cyBqdXN0DQo+
Pj4+IHRoZSB2YWx1ZSBzbyB3ZSBjYW4gYXZvaWQgZGVyZWZlcmVuY2luZyBhbnl0aGluZyBieSBq
dXN0IHBhc3NpbmcgaW4NCj4+Pj4gYXBwX3RmJ3MgdmFsdWUgdG8gbW9kX2ZyZWVzeW5jX2J1aWxk
X3Zycl9pbmZvcGFja2V0IGFuZA0KPj4+PiBidWlsZF92cnJfaW5mb3BhY2tldF92Mi4NCj4+Pj4N
Cj4+Pj4gVGhlcmUgaXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UgYmVjYXVzZSBidWlsZF92cnJfaW5m
b3BhY2tldF9mczJfZGF0YQ0KPj4+PiBkb2Vzbid0IGRvIGFueXRoaW5nIGlmIFRSQU5TRkVSX0ZV
TkNfVU5LTk9XTiBpcyBwYXNzZWQgdG8gaXQsIHRoZSBzYW1lDQo+Pj4+IGFzIG5vdCBjYWxsaW5n
IGJ1aWxkX3Zycl9pbmZvcGFja2V0X2ZzMl9kYXRhIGF0IGFsbCBsaWtlIGJlZm9yZSB0aGlzDQo+
Pj4+IGNoYW5nZSB3aGVuIE5VTEwgd2FzIHVzZWQgZm9yIGFwcF90Zi4NCj4+Pg0KPj4+IE5hdGhh
biwNCj4+PiBUaGFua3MgZm9yIHNlbmRpbmcgdGhpcyBwYXRjaC4gIEkgd2FzIGhvcGluZyB0byBw
cm92aWRlIHJldmlldyBzb29uZXIsDQo+Pj4gYnV0IGhhdmUgYmVlbiBxdWl0ZSBidXN5IGxhdGVs
eS4NCj4+Pg0KPj4NCj4+IExhdGUgcmV2aWV3IGlzIGJldHRlciB0aGFuIG5vIHJldmlldywgSSBh
cHBlY2lhdGUgeW91IHRha2luZyB0aGUgdGltZSB0bw0KPj4gZG8gdGhpcyENCj4+DQo+Pj4gWWVh
aCwgZXNwZWNpYWxseSBmb3IgTFA2NCB0YXJnZXRzLCB0aGUgcG9pbnRlciB0byBlbnVtIGlzIGxh
cmdlciB0aGFuDQo+Pj4ganVzdCB0aGUgZW51bSwgYW5kIGlmIGl0J3Mgbm90IGJlaW5nIHVwZGF0
ZWQgKCJpbi9vdXQgcGFyYW10ZXIiKQ0KPj4+IHRoZXJlJ3Mgbm8gbmVlZCB0byBwYXNzIGJ5IHBv
aW50ZXIuDQo+Pj4NCj4+DQo+PiBUaGFua3MgZm9yIGNvbmZpcm1pbmchDQo+Pg0KPj4+Pg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwu
Y29tPg0KPj4+PiAtLS0NCj4+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVz
L2ZyZWVzeW5jL2ZyZWVzeW5jLmMgfCA3ICsrKy0tLS0NCj4+Pj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9tb2R1bGVzL2luYy9tb2RfZnJlZXN5bmMuaCAgfCAyICstDQo+Pj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5j
L2ZyZWVzeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9mcmVlc3lu
Yy9mcmVlc3luYy5jDQo+Pj4+IGluZGV4IDYyMGExNzE2MjBlZS4uNTIwNjY1YTlkODFhIDEwMDY0
NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9mcmVlc3lu
Yy9mcmVlc3luYy5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1
bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMNCj4+Pj4gQEAgLTY1Niw3ICs2NTYsNyBAQCBzdGF0aWMg
dm9pZCBidWlsZF92cnJfaW5mb3BhY2tldF92MShlbnVtIHNpZ25hbF90eXBlIHNpZ25hbCwNCj4+
Pj4NCj4+Pj4gIHN0YXRpYyB2b2lkIGJ1aWxkX3Zycl9pbmZvcGFja2V0X3YyKGVudW0gc2lnbmFs
X3R5cGUgc2lnbmFsLA0KPj4+PiAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IG1vZF92cnJf
cGFyYW1zICp2cnIsDQo+Pj4+IC0gICAgICAgICAgICAgICBjb25zdCBlbnVtIGNvbG9yX3RyYW5z
ZmVyX2Z1bmMgKmFwcF90ZiwNCj4+Pj4gKyAgICAgICAgICAgICAgIGVudW0gY29sb3JfdHJhbnNm
ZXJfZnVuYyBhcHBfdGYsDQo+Pj4+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGNfaW5mb19wYWNr
ZXQgKmluZm9wYWNrZXQpDQo+Pj4+ICB7DQo+Pj4+ICAgICAgICAgdW5zaWduZWQgaW50IHBheWxv
YWRfc2l6ZSA9IDA7DQo+Pj4+IEBAIC02NjQsOCArNjY0LDcgQEAgc3RhdGljIHZvaWQgYnVpbGRf
dnJyX2luZm9wYWNrZXRfdjIoZW51bSBzaWduYWxfdHlwZSBzaWduYWwsDQo+Pj4+ICAgICAgICAg
YnVpbGRfdnJyX2luZm9wYWNrZXRfaGVhZGVyX3YyKHNpZ25hbCwgaW5mb3BhY2tldCwgJnBheWxv
YWRfc2l6ZSk7DQo+Pj4+ICAgICAgICAgYnVpbGRfdnJyX2luZm9wYWNrZXRfZGF0YSh2cnIsIGlu
Zm9wYWNrZXQpOw0KPj4+Pg0KPj4+PiAtICAgICAgIGlmIChhcHBfdGYgIT0gTlVMTCkNCj4+Pj4g
LSAgICAgICAgICAgICAgIGJ1aWxkX3Zycl9pbmZvcGFja2V0X2ZzMl9kYXRhKCphcHBfdGYsIGlu
Zm9wYWNrZXQpOw0KPj4+PiArICAgICAgIGJ1aWxkX3Zycl9pbmZvcGFja2V0X2ZzMl9kYXRhKGFw
cF90ZiwgaW5mb3BhY2tldCk7DQo+Pj4+DQo+Pj4+ICAgICAgICAgYnVpbGRfdnJyX2luZm9wYWNr
ZXRfY2hlY2tzdW0oJnBheWxvYWRfc2l6ZSwgaW5mb3BhY2tldCk7DQo+Pj4+DQo+Pj4+IEBAIC02
NzYsNyArNjc1LDcgQEAgdm9pZCBtb2RfZnJlZXN5bmNfYnVpbGRfdnJyX2luZm9wYWNrZXQoc3Ry
dWN0IG1vZF9mcmVlc3luYyAqbW9kX2ZyZWVzeW5jLA0KPj4+PiAgICAgICAgICAgICAgICAgY29u
c3Qgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtLA0KPj4+PiAgICAgICAgICAgICAgICAg
Y29uc3Qgc3RydWN0IG1vZF92cnJfcGFyYW1zICp2cnIsDQo+Pj4+ICAgICAgICAgICAgICAgICBl
bnVtIHZycl9wYWNrZXRfdHlwZSBwYWNrZXRfdHlwZSwNCj4+Pj4gLSAgICAgICAgICAgICAgIGNv
bnN0IGVudW0gY29sb3JfdHJhbnNmZXJfZnVuYyAqYXBwX3RmLA0KPj4+PiArICAgICAgICAgICAg
ICAgZW51bSBjb2xvcl90cmFuc2Zlcl9mdW5jIGFwcF90ZiwNCj4+Pj4gICAgICAgICAgICAgICAg
IHN0cnVjdCBkY19pbmZvX3BhY2tldCAqaW5mb3BhY2tldCkNCj4+Pj4gIHsNCj4+Pj4gICAgICAg
ICAvKiBTUEQgaW5mbyBwYWNrZXQgZm9yIEZyZWVTeW5jICovDQo+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmMvbW9kX2ZyZWVzeW5jLmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmMvbW9kX2ZyZWVzeW5jLmgNCj4+
Pj4gaW5kZXggOTQ5YThiNjJhYTk4Li4wNjNhZjYyNThmZDkgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2luYy9tb2RfZnJlZXN5bmMuaA0KPj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmMvbW9kX2ZyZWVz
eW5jLmgNCj4+Pj4gQEAgLTE0NSw3ICsxNDUsNyBAQCB2b2lkIG1vZF9mcmVlc3luY19idWlsZF92
cnJfaW5mb3BhY2tldChzdHJ1Y3QgbW9kX2ZyZWVzeW5jICptb2RfZnJlZXN5bmMsDQo+Pj4+ICAg
ICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJlYW0sDQo+Pj4+
ICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgbW9kX3Zycl9wYXJhbXMgKnZyciwNCj4+Pj4g
ICAgICAgICAgICAgICAgIGVudW0gdnJyX3BhY2tldF90eXBlIHBhY2tldF90eXBlLA0KPj4+PiAt
ICAgICAgICAgICAgICAgY29uc3QgZW51bSBjb2xvcl90cmFuc2Zlcl9mdW5jICphcHBfdGYsDQo+
Pj4+ICsgICAgICAgICAgICAgICBlbnVtIGNvbG9yX3RyYW5zZmVyX2Z1bmMgYXBwX3RmLA0KPj4+
DQo+Pj4gRG9uJ3QgeW91IG5lZWQgdG8gdXBkYXRlIHRoZSBjYWxsc2l0ZSBvZiBgbW9kX2ZyZWVz
eW5jX2J1aWxkX3Zycl9pbmZvcGFja2V0YCBpbg0KPj4+DQo+Pj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyM0OTQ5Og0KPj4+DQo+Pj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLA0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cmFuc2Zlcl9mdW5jX3Vua25vd24sDQo+
Pj4NCj4+DQo+PiBUaGF0IGNoYW5nZSBpbiBjb21taXQgYmI0N2RlNzM2NjYxICgiZHJtL2FtZGdw
dTogU2V0IEZyZWVTeW5jIHN0YXRlDQo+PiB1c2luZyBkcm0gVlJSIHByb3BlcnRpZXMiKSBpbiAt
bmV4dCBpcyB3aGF0IHByb21wdGVkIHRoaXMgcGF0Y2ggKHRoZQ0KPj4gd2FybmluZyBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UgaXMgbm90IHByZXNlbnQgaW4gbWFpbmxpbmUpOg0KPiANCj4gQWghIFNv
cnJ5LCBJIHdhcyBsb29raW5nIGF0IG1haW5saW5lLiAgSSBzaG91bGQgaGF2ZSBub3RpY2VkDQo+
IGJiNDdkZTczNjY2MSB3YXNuJ3QgdGhlcmUuDQo+IA0KPiBTaG91bGRuJ3QgdGhhdCBjaGFuZ2Ug
ZmFpbCB0byBjb21waWxlLCBhcyB0cmFuc2Zlcl9mdW5jX3Vua25vd24gaXMgYW4NCj4gYGVudW0g
Y29sb3JfdHJhbnNmZXJfZnVuY2AgdmFsdWUsIGJ1dA0KPiBtb2RfZnJlZXN5bmNfYnVpbGRfdnJy
X2luZm9wYWNrZXQgdGFrZXMgYSAqcG9pbnRlciogdG8gYW4gYGVudW0NCj4gY29sb3JfdHJhbnNm
ZXJfZnVuY2AgdmFsdWU/DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvdHJlZS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvbW9kdWxlcy9mcmVlc3luYy9mcmVlc3luYy5jI242NzUNCj4gDQo+Pg0KPj4gICAgICAg
ICBtb2RfZnJlZXN5bmNfYnVpbGRfdnJyX2luZm9wYWNrZXQoDQo+PiAgICAgICAgICAgICAgICAg
ZG0tPmZyZWVzeW5jX21vZHVsZSwNCj4+ICAgICAgICAgICAgICAgICBuZXdfc3RyZWFtLA0KPj4g
ICAgICAgICAgICAgICAgICZ2cnIsDQo+PiAgICAgICAgICAgICAgICAgcGFja2V0X3R5cGVfdnJy
LA0KPj4gICAgICAgICAgICAgICAgIHRyYW5zZmVyX2Z1bmNfdW5rbm93biwNCj4+ICAgICAgICAg
ICAgICAgICAmdnJyX2luZm9wYWNrZXQpOw0KPj4NCj4+PiBNYXliZSBhdCB0aGF0IHBvaW50IHRo
ZSBgaWYgKGFwcF90ZiAhPSBOVUxMKWAgY291bGQgYmUgcmVwbGFjZWQgd2l0aA0KPj4+IGBpZiAo
YXBwX3RmICE9IHRyYW5zZmVyX2Z1bmNfdW5rbm93bilgIGhvaXN0ZWQgZnJvbQ0KPj4+IGBidWls
ZF92cnJfaW5mb3BhY2tldF9mczJfZGF0YWA/IChUaGVyZSdzIG9ubHkgb25lIGNhbGxlciBvZg0K
Pj4+IGBidWlsZF92cnJfaW5mb3BhY2tldF9mczJfZGF0YWAgdG9kYXksIG1heWJlIGZpbmUgdG8g
bGVhdmUgdGhlDQo+Pj4gdW5jb25kaXRpb25hbCBjYWxsIGFuZCBjaGVjaykuDQo+Pj4NCj4+DQo+
PiBIbW1tIHRoYXQncyBub3QgdW5yZWFzb25hYmxlIEkgc3VwcG9zZS4gSSBndWVzcyBpdCBkZXBl
bmRzIG9uIGlmDQo+PiBidWlsZF92cnJfaW5mb3BhY2tldF9mczJfZGF0YSBjb3VsZCBldmVyIGJl
IGNhbGxlZCBmcm9tIG91dHNpZGUgb2YNCj4+IGJ1aWxkX3Zycl9pbmZvcGFja2V0X3YyOyBpZiBp
dCBjYW4sIGl0IG1ha2VzIHNlbnNlIHRvIGxlYXZlIHRoZQ0KPj4gY29uZGl0aW9uYWwgY2hlY2sg
Zm9yICdhcHBfdGYgIT0gdHJhbnNmZXJfZnVuY191bmtub3duJyBpbg0KPj4gYnVpbGRfdnJyX2lu
Zm9wYWNrZXRfZnMyX2RhdGEgYW5kIGxlYXZpbmcgdGhlIHVuY29uZGl0aW9uYWwgY2FsbA0KPj4g
dG8gaXQgaW4gYnVpbGRfdnJyX2luZm9wYWNrZXRfdjIgKHNpbmNlIGFwcF90ZiBpcyBubyBsb25n
ZXIgYSBwb2ludGVyLA0KPj4gbm8gbmVlZCB0byBjaGVjayBhZ2FpbnN0IE5VTEwpLg0KPj4NCj4+
IEknbSBoYXBweSB0byBkbyBhIHYyIGlmIHRoZSBtYWludGFpbmVycyBmZWVsIHN0cm9uZ2x5IGFi
b3V0IGl0LCB0aGFuaw0KPj4geW91IGZvciBicmluZ2luZyB0aGF0IHVwLg0KPiANCj4gRG9uJ3Qg
d29ycnkgYWJvdXQgaXQsIEkgdGhpbmsgaXQncyBmaW5lLg0KPiBSZXZpZXdlZC1ieTogTmljayBE
ZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+IA0KDQpTb3JyeSBmb3IgYmVp
bmcgbGF0ZSB0byB0aGUgZ2FtZS4gRldJVywgY29kZSBpcyBhbHNvDQpSZXZpZXdlZC1ieTogSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQoNCldlIGNhbiBjaGFuZ2UgdGhl
IGNvbXBhcmlzb24gc2VwYXJhdGVseSBsYXRlci4NCg0KTm90IHN1cmUgd2h5IHRoaXMgd2FzIGV2
ZXIgcGFzc2VkIGFzIGEgcG9pbnRlci4NCg0KSGFycnkNCg==
