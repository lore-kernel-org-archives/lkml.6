Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B164C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69DC20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b1uyIqun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfA2TBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:01:55 -0500
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:58218
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbfA2TBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auQAHpQtTkhwYzTCeBOuGaeuWIrzmXgv29n8TrHwq1k=;
 b=b1uyIqunHB93H19UzH4M4aFP8G2PdzSm5sNHzaA3PHEXeHmvBS5WoCXyodXWJJVYf2EkNXfRjFusTWPsQufgD/v8bo8cbbdWguIlsPSm+UsTc/toi8grCD/bQIvZvjZBlwFD4Pm751UmUc9O7VKZP+SCmvVFdzxk3m7dcPDtjW4=
Received: from BN8PR12MB3602.namprd12.prod.outlook.com (20.178.212.86) by
 BN8PR12MB3201.namprd12.prod.outlook.com (20.179.65.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 19:01:51 +0000
Received: from BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::d5b4:3e1d:432f:4f62]) by BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::d5b4:3e1d:432f:4f62%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 19:01:51 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>, "S@google.com" <S@google.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>,
        Matthias Kaehlcke <mka@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        James Y Knight <jyknight@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Thread-Topic: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Thread-Index: AQHUtEhgHoOlRe+0fkeG56Pm7j0rtKW/ySkAgAadaYCAADlrgIAAAZ0A
Date:   Tue, 29 Jan 2019 19:01:51 +0000
Message-ID: <da0beeff-96eb-5585-50ef-904c8fe8af4d@amd.com>
References: <20190125005304.183322-1-ndesaulniers@google.com>
 <04bc6844-2a3b-2de8-60a7-a027149709fd@amd.com>
 <CADnq5_OuSD7Bmeg3CP0Y6JTo9Xso2FTZ3tKk-u1C+-B32eUGmQ@mail.gmail.com>
 <20190129185601.GA17525@roeck-us.net>
In-Reply-To: <20190129185601.GA17525@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [69.171.153.184]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-clientproxiedby: YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::47) To BN8PR12MB3602.namprd12.prod.outlook.com
 (2603:10b6:408:49::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR12MB3201;20:zGNQ2+/zkphDPdi0zvPL/05SBhAoObSjlA9LvDJ6dJEAGLtHgcjxQRoncM0asJZvwgHEu+rQ9ld8xbeZwo0UJeovPanjDOcEPgP7fUAMxx4LP4mlgtPsEBUGq40sNGNvz+Hhd+iFAbNpiblNnKkJetPIBftI2LgwXVzpOru0s0jqYn1gRTxuCFgiDgtlrFSNuMDWcmpQsUt8GdEC6gTKfgVW8W0K/DgLpQ8hTogNnpKVqOJXtm9rXxYA3gpYNyn9
x-ms-office365-filtering-correlation-id: 652ff44d-f754-4b79-e51f-08d6861c3a29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN8PR12MB3201;
x-ms-traffictypediagnostic: BN8PR12MB3201:
x-microsoft-antispam-prvs: <BN8PR12MB3201C74B8FCA3B49EDFB20EC8C970@BN8PR12MB3201.namprd12.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(199004)(189003)(105586002)(65806001)(53936002)(66066001)(106356001)(14454004)(8936002)(86362001)(72206003)(31686004)(966005)(316002)(6306002)(81156014)(6512007)(81166006)(65956001)(305945005)(110136005)(7736002)(478600001)(58126008)(8676002)(36756003)(31696002)(99286004)(54906003)(7416002)(2616005)(3846002)(11346002)(68736007)(446003)(256004)(14444005)(6246003)(65826007)(6116002)(486006)(76176011)(229853002)(476003)(6436002)(71200400001)(6486002)(386003)(39060400002)(186003)(53546011)(26005)(52116002)(2906002)(6506007)(64126003)(102836004)(71190400001)(4326008)(25786009)(93886005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB3201;H:BN8PR12MB3602.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DOI5Lt6f5iDPQ2k0PFU0JDsC2UNLlMXGcc/zEAx0TVoy69qiyfsysv/6cI997RXX/1QZy47TqAyQSKCVJSjh1luowGGuv3Dp8XGvqPF9BuMuhMouk11yRteWhrL65KB7hrS1gShhQxfv+UthtwUoXp0oTXeLQtU60gBsYBKPhldz42i40jNR/6Ln3O0LZ1gupRIlrxaAlcuQboilt+8DQiQU9YgOP90bptS9lX67ETUvsMix6gfPOUoZPF0wo8yHkrW6T4dO1vJCPN9wxyX+ftEwFa01d34vWOiVhBtJQakblHqDxs9gWyzkBVHHk+CIUX7Dn3nmQWMXnqDmUEsPEsebSVTvKvTYXttfsQPGqvtBGDUH5JCaCd4ZtD8fADTND7lBCzTcPYdg5UaLymULY+PeEqaWiCI9Z2IQY2LP6lc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0BD24C27C4C0A4C97113C0EECC9ED59@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ff44d-f754-4b79-e51f-08d6861c3a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 19:01:50.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0yOSAxOjU2IHAubS4sIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+IE9uIFR1ZSwg
SmFuIDI5LCAyMDE5IGF0IDEwOjMwOjMxQU0gLTA1MDAsIEFsZXggRGV1Y2hlciB3cm90ZToNCj4+
IE9uIEZyaSwgSmFuIDI1LCAyMDE5IGF0IDEwOjI5IEFNIFdlbnRsYW5kLCBIYXJyeSA8SGFycnku
V2VudGxhbmRAYW1kLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBPbiAyMDE5LTAxLTI0IDc6NTIgcC5t
LiwgbmRlc2F1bG5pZXJzQGdvb2dsZS5jb20gd3JvdGU6DQo+Pj4+IGFyY2gveDg2L01ha2VmaWxl
IGRpc2FibGVzIFNTRSBhbmQgU1NFMiBmb3IgdGhlIHdob2xlIGtlcm5lbC4gIFRoZQ0KPj4+PiBB
TURHUFUgZHJpdmVycyBtb2RpZmllZCBpbiB0aGlzIHBhdGNoIHJlLWVuYWJsZSBTU0UgYnV0IG5v
dCBTU0UyLiAgVHVybg0KPj4+PiBvbiBTU0UyIHRvIHN1cHBvcnQgZW1pdHRpbmcgZG91YmxlIHBy
ZWNpc2lvbiBmbG9hdGluZyBwb2ludCBpbnN0cnVjdGlvbnMNCj4+Pj4gcmF0aGVyIHRoYW4gY2Fs
bHMgdG8gbm9uLWV4aXN0ZW50ICh1c3VhbGx5IGF2YWlsYWJsZSBmcm9tIGdjY19zIG9yDQo+Pj4+
IGNvbXBpbGVyX3J0KSBmbG9hdGluZyBwb2ludCBoZWxwZXIgcm91dGluZXMuDQo+Pj4+DQo+Pj4+
IExpbms6IGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2NpbnQvU29mdC1mbG9hdC1s
aWJyYXJ5LXJvdXRpbmVzLmh0bWwNCj4+Pj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL0NsYW5n
QnVpbHRMaW51eC9saW51eC9pc3N1ZXMvMzI3DQo+Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnICMgNC4xOQ0KPj4+PiBSZXBvcnRlZC1ieTogUywgU2hpcmlzaCA8U2hpcmlzaC5TQGFtZC5j
b20+DQo+Pj4+IFJlcG9ydGVkLWJ5OiBNYXR0aGlhcyBLYWVobGNrZSA8bWthQGdvb2dsZS5jb20+
DQo+Pj4+IFN1Z2dlc3RlZC1ieTogSmFtZXMgWSBLbmlnaHQgPGp5a25pZ2h0QGdvb2dsZS5jb20+
DQo+Pj4+IFN1Z2dlc3RlZC1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdt
YWlsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5p
ZXJzQGdvb2dsZS5jb20+DQo+Pj4+IFRlc3RlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9l
Y2stdXMubmV0Pg0KPj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53
ZW50bGFuZEBhbWQuY29tPg0KPj4+DQo+Pj4gYW5kIGFwcGxpZWQuDQo+Pj4NCj4+DQo+PiBUaGlz
IHBhdGNoIGNhdXNlcyBhIHNlZ2ZhdWx0Og0KPj4gaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MTA5NDg3DQo+Pg0KPj4gQW55IGlkZWFzPw0KPj4NCj4gDQo+IFNl
dCAtbXNzZTIgb25seSBmb3IgY2xhbmcgPyBJIHN1c3BlY3QsIHRob3VnaCwgdGhhdCB0aGlzIG1p
Z2h0IG9ubHkNCj4gc29sdmUgdGhlIGNvbXBpbGUgcHJvYmxlbS4gSWYgSSB1bmRlcnN0YW5kIGNv
cnJlY3RseSwgdGhlIGZpcnN0DQo+IHdhcm5pbmcgaW4gdGhlIGxvZyBpcyBkdWUgdG8gQlJFQUtf
VE9fREVCVUdHRVIoKSwgc3VnZ2VzdGluZyB0aGF0DQo+IHNvbWV0aGluZyBpcyBzZXJpb3VzbHkg
d3JvbmcuIE1heWJlIGVuYWJsaW5nIHNzZTIgcmVzdWx0cyBpbiBkaWZmZXJlbnQNCj4gcmVzdWx0
cyBmcm9tIGZsb2F0aW5nIHBvaW50IG9wZXJhdGlvbnMuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IEkg
ZG9uJ3QgaGF2ZSBhIHN5c3RlbSB3aXRoIHRoZSBhZmZlY3RlZCBHUFUsDQo+IHNvIEkgY2FuJ3Qg
cnVuIGFueSB0ZXN0cyBvbiByZWFsIGhhcmR3YXJlLiBVbmxlc3Mgc29tZW9uZSBjYW4gdGVzdA0K
PiB3aXRoIHJlYWwgaGFyZHdhcmUsIEkgdGhpbmsgd2UgaGF2ZSBubyBjaG9pY2UgYnV0IHRvIHJl
dmVydCB0aGUNCj4gcGF0Y2guDQo+IA0KDQpNaWdodCBiZSBhIGdvb2QgaWRlYS4gRXZlbiB0aG91
Z2gsIGJlc3QgdG8gcmV2ZXJ0IGZvciBub3cgdW50aWwgd2UgdW5kZXJzdGFuZCB3aGF0J3MgZ29p
bmcgb24uDQoNCkl0IHNlZW1zIGxpa2UgcGVvcGxlIGF0IEFNRCBidWlsZGluZyB3aXRoIGdjYyA1
LjQgYXJlIGZpbmUsIGJ1dCB0aG9zZSB1c2luZyBnY2MgNy4zIG9yIDguMiBleHBlcmllbmNlIHRo
ZSBjcmFzaC4NCg0KSGFycnkNCg0KPiBHdWVudGVyDQo+IA0KPj4gQWxleA0KPj4NCj4+PiBIYXJy
eQ0KPj4+DQo+Pj4+IC0tLQ0KPj4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nh
bGNzL01ha2VmaWxlIHwgMiArLQ0KPj4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RtbC9NYWtlZmlsZSAgIHwgMiArLQ0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvTWFrZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY2FsY3MvTWFrZWZpbGUNCj4+Pj4gaW5kZXggOTVmMzMyZWUzZTdlLi5kYzg1
YTNjMDg4YWYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jYWxjcy9NYWtlZmlsZQ0KPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY2FsY3MvTWFrZWZpbGUNCj4+Pj4gQEAgLTMwLDcgKzMwLDcgQEAgZWxzZSBpZm5lcSAoJChj
YWxsIGNjLW9wdGlvbiwgLW1zdGFjay1hbGlnbm1lbnQ9MTYpLCkNCj4+Pj4gICAgICAgY2Nfc3Rh
Y2tfYWxpZ24gOj0gLW1zdGFjay1hbGlnbm1lbnQ9MTYNCj4+Pj4gIGVuZGlmDQo+Pj4+DQo+Pj4+
IC1jYWxjc19jY2ZsYWdzIDo9IC1taGFyZC1mbG9hdCAtbXNzZSAkKGNjX3N0YWNrX2FsaWduKQ0K
Pj4+PiArY2FsY3NfY2NmbGFncyA6PSAtbWhhcmQtZmxvYXQgLW1zc2UgLW1zc2UyICQoY2Nfc3Rh
Y2tfYWxpZ24pDQo+Pj4+DQo+Pj4+ICBDRkxBR1NfZGNuX2NhbGNzLm8gOj0gJChjYWxjc19jY2Zs
YWdzKQ0KPj4+PiAgQ0ZMQUdTX2Rjbl9jYWxjX2F1dG8ubyA6PSAkKGNhbGNzX2NjZmxhZ3MpDQo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL01ha2Vm
aWxlIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9NYWtlZmlsZQ0KPj4+PiBp
bmRleCBkOTdjYTY1MjhmOWQuLjMzYzdkNzU4ODcxMiAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9NYWtlZmlsZQ0KPj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL01ha2VmaWxlDQo+Pj4+IEBAIC0zMCw3ICszMCw3
IEBAIGVsc2UgaWZuZXEgKCQoY2FsbCBjYy1vcHRpb24sIC1tc3RhY2stYWxpZ25tZW50PTE2KSwp
DQo+Pj4+ICAgICAgIGNjX3N0YWNrX2FsaWduIDo9IC1tc3RhY2stYWxpZ25tZW50PTE2DQo+Pj4+
ICBlbmRpZg0KPj4+Pg0KPj4+PiAtZG1sX2NjZmxhZ3MgOj0gLW1oYXJkLWZsb2F0IC1tc3NlICQo
Y2Nfc3RhY2tfYWxpZ24pDQo+Pj4+ICtkbWxfY2NmbGFncyA6PSAtbWhhcmQtZmxvYXQgLW1zc2Ug
LW1zc2UyICQoY2Nfc3RhY2tfYWxpZ24pDQo+Pj4+DQo+Pj4+ICBDRkxBR1NfZGlzcGxheV9tb2Rl
X2xpYi5vIDo9ICQoZG1sX2NjZmxhZ3MpDQo+Pj4+ICBDRkxBR1NfZGlzcGxheV9waXBlX2Nsb2Nr
cy5vIDo9ICQoZG1sX2NjZmxhZ3MpDQo+Pj4+DQo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPj4+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo=
