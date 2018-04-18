Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1035396-1524077587-2-17530017633043547073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524077587; b=VdViD5JrdJX+poqrvzOZvOHhcVpf4i2myx9cUCdrB2rP1RPrOZ
    Qa7WW++LpJMdtgC5CJs0bYWnrKIbX2H4n4WnmPpeqAYSmDsii5VSzFbfNuc0uJSn
    wmu+9wZhnu+aixcRbMTO+hxon/dmgvzVoTJCdMRcS/JzpSfEfRy3LdI6acXUmMpj
    R8qx4+4NtnV8KgdimRs0TrCAeE2ffQWa8U1K0LR/tZSCAWkrDV95RgBfvH1PgCU9
    U47K9sEPzol0U5hxVnLesZV528e6YGqBZwyAt64whttXF6NKZH4Tl2QN8i0V4hza
    r6LMR/w7sW1NWu97agghvkmcBO5dysRJuiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524077587; bh=mouG0aLdLx
    bJhVgetlMlV6MiYUILB/+CMbmdpo9R5+U=; b=OZXag8X/o4JSb9WGRV8/Go9pMK
    ubTscr/KGWaBsoNbvP58nqKoP/kfwGjBV1PwTcI/bLCFAGTNTZNC5W3XiGMk5F1+
    ruyp0cta5cFR4AhWAT9v8hpSuGosvGnpzPV/UH/bnmRDDW+cwWb59YPUF8LsBcey
    pYk4GjCNV6ehmKst8lLas2O7/90PsAQ87QdOc0irk7zVjQIalWZwqbQBM0Pzs3XS
    Te+wgOmhiBW/R3DD8MxQzHV1YGDD6lnlPBgStlUXbcDmFvkug+POfA06dSplf9q6
    v3ncm3nkNW2KhmJHrkBwMpofOh0j8IX6oYOIFtjwpaBsgo92ydK7SClQsXLg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HgIEpH3W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HgIEpH3W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAoa6uzeFn4V+BzfK+KPPhKo95Fn6bm7h+6J3szoR3agwe+8hr+uEXbmkNJiL2TKeaxOqjvhjwvrQCu0cXpUNVRW3dXrvrlP6tXOLlhvl00Bg3wKRHth
    c91aPJgJVakVoaPzHvQqrDr3aklqROvd0aeZY3+/ZiCAy5opCdUw54IiWXYhgipTigsrUWf6/I8RegoNkL1hX8o2EYcNoabxLvl4oTrKZ5csqprWt244u5CG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=IYp8n1Yz95QA:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=yMhMjlubAAAA:8 a=iFdGihldbxoDu3OUmKEA:9 a=gc-LNAhInBDV_w2D:21
    a=tKK64gbB5aAAniVJ:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDRSxE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 14:53:04 -0400
Received: from mail-by2nam03on0123.outbound.protection.outlook.com ([104.47.42.123]:29247
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752166AbeDRSxC (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 14:53:02 -0400
From: Long Li <longli@microsoft.com>
To: Tom Talpey <tom@talpey.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Topic: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Index: AQHT1q0nc3yHaleoh0CJYtibUbzbEqQGZIIAgAAa8ICAABB7AIAAMDvwgAALHQCAABQuwA==
Date: Wed, 18 Apr 2018 18:53:00 +0000
Message-ID: <MWHPR2101MB07298391D72A2877D8A237B3CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
 <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
 <e9e7f77032c5402e848de0293e4db3ee@AcuMS.aculab.com>
 <b8e56b14-a746-2a22-cb8d-94f1ba7d646b@talpey.com>
 <MWHPR2101MB072909460F3898C6D13B4D4CCEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
 <568a36d2-29a1-442f-f725-58a02b8a90e5@talpey.com>
In-Reply-To: <568a36d2-29a1-442f-f725-58a02b8a90e5@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0811;7:5LuLCOAlO9sWtTREk6QL1RPIMPloEfkMTOHWggZaHXHMyMshPtPeQgPXMpgLcxegZ5CiFDcKSjfjI0+YY0/rVC88pYnPyQ0ejr4rLiZ0FlTTSZH7B7kIukB6ak1TgAuB4PrpPT2Re0YMfjqLGIb1HPihg3R4QRGF3qjB7NDdeZ68rxm7ZcjSPWyQSEwoo25L+qxPQNjjhMIGmvq06IK32IvuaRP9SoyquRiPwlJKcxtkjLs5aUobBeDzo1q0pUr4;20:1QmoDbaBiRIGtjmjLbZf1smvn4pzf0XdmapBuojn4wsqxHmUs2wb9/C3sJGO87GoCW8AgzfL8yY5FH/04cYVqYjQCLCh0iqrlIdjkLlZCy1aY1DbFWw+mJHAMkNQRZgTFAJOCuEnvhgd/HmieZZYAyvW7Y+r4jmn+gWjo0i2/nM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0811;
x-ms-traffictypediagnostic: MWHPR2101MB0811:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB081103B5B0A7F8241E209C9FCEB60@MWHPR2101MB0811.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501368)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR2101MB0811;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0811;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(39380400002)(2906002)(229853002)(8936002)(14454004)(10290500003)(9686003)(6436002)(55016002)(25786009)(15650500001)(478600001)(7696005)(76176011)(53546011)(86612001)(476003)(59450400001)(99286004)(446003)(11346002)(6506007)(186003)(5660300001)(10090500001)(102836004)(33656002)(3280700002)(3660700001)(110136005)(6246003)(2501003)(316002)(22452003)(7736002)(93886005)(6116002)(305945005)(4326008)(2201001)(5250100002)(53936002)(81166006)(74316002)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0811;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: akAeM+Ls55rutb/zYs1Iohgn4YproPGLIlm0LToo7RP5Cj6GTikWM/UvKHrHCS7lgDWL6Ww6q2UFrD/1iGHsVkYpneOqeri/RrCkOGoZYHgw/YIMfc9XqAzkqvH45B3Mtxy4iC6na1lTPo8SrZWJKptER8SyYbAmNmFhki01QVZboG7yo9hfhuZwMqnBuSW+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 65c3c93f-5a8b-4b95-8ecf-08d5a55d9bbe
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c3c93f-5a8b-4b95-8ecf-08d5a55d9bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 18:53:00.5666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0811
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzIDIvNl0gY2lmczogQWxsb2NhdGUgdmFsaWRhdGUgbmVn
b3RpYXRpb24gcmVxdWVzdCB0aHJvdWdoDQo+IGttYWxsb2MNCj4gDQo+IE9uIDQvMTgvMjAxOCAx
OjExIFBNLCBMb25nIExpIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzIDIvNl0g
Y2lmczogQWxsb2NhdGUgdmFsaWRhdGUgbmVnb3RpYXRpb24NCj4gPj4gcmVxdWVzdCB0aHJvdWdo
IGttYWxsb2MNCj4gPj4NCj4gPj4gT24gNC8xOC8yMDE4IDk6MDggQU0sIERhdmlkIExhaWdodCB3
cm90ZToNCj4gPj4+IEZyb206IFRvbSBUYWxwZXkNCj4gPj4+PiBTZW50OiAxOCBBcHJpbCAyMDE4
IDEyOjMyDQo+ID4+PiAuLi4NCj4gPj4+PiBPbiA0LzE3LzIwMTggODozMyBQTSwgTG9uZyBMaSB3
cm90ZToNCj4gPj4+Pj4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4+
Pj4+DQo+ID4+Pj4+IFRoZSBkYXRhIGJ1ZmZlciBhbGxvY2F0ZWQgb24gdGhlIHN0YWNrIGNhbid0
IGJlIERNQSdlZCwgYW5kIGhlbmNlDQo+ID4+Pj4+IGNhbid0IHNlbmQgdGhyb3VnaCBSRE1BIHZp
YSBTTUIgRGlyZWN0Lg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBjb21tZW50IGlzIGNvbmZ1c2luZy4g
QW55IHJlZ2lzdGVyZWQgbWVtb3J5IGNhbiBiZSBETUEnZCwNCj4gbmVlZA0KPiA+Pj4+IHRvIHN0
YXRlIHRoZSByZWFzb24gZm9yIHRoZSBjaG9pY2UgaGVyZSBtb3JlIGNsZWFybHkuDQo+ID4+Pg0K
PiA+Pj4gVGhlIHN0YWNrIGNvdWxkIGJlIGFsbG9jYXRlZCB3aXRoIHZtYWxsb2MoKS4NCj4gPj4+
IEluIHdoaWNoIGNhc2UgdGhlIHBhZ2VzIG1pZ2h0IG5vdCBiZSBwaHlzaWNhbGx5IGNvbnRpZ3Vv
dXMgYW5kIHRoZXJlDQo+ID4+PiBpcyBubw0KPiA+Pj4gKHNlbnNpYmxlKSBjYWxsIHRvIGdldCB0
aGUgcGh5c2ljYWwgYWRkcmVzcyByZXF1aXJlZCBieSB0aGUgZG1hDQo+ID4+PiBjb250cm9sbGVy
IChvciBvdGhlciBidXMgbWFzdGVyKS4NCj4gPj4NCj4gPj4gTWVtb3J5IHJlZ2lzdHJhdGlvbiBk
b2VzIG5vdCByZXF1aXJlcyBwYWdlcyB0byBiZSBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMuDQo+ID4+
IFJETUEgUmVnaW9ucyBjYW4gYW5kIGRvIHN1cHBvcnQgdmVyeSBsYXJnZSBwaHlzaWNhbCBwYWdl
DQo+ID4+IHNjYXR0ZXIvZ2F0aGVyLCBhbmQgdGhlIGFkYXB0ZXIgRE1BJ3MgdGhlbSByZWFkaWx5
LiBJcyB0aGlzIHRoZSBvbmx5DQo+IHJlYXNvbj8NCj4gPg0KPiA+IGliX2RtYV9tYXBfcGFnZSB3
aWxsIHJldHVybiBhbiBpbnZhbGlkIERNQSBhZGRyZXNzIGZvciBhIGJ1ZmZlciBvbiBzdGFjay4N
Cj4gRXZlbiB3b3JzZSwgdGhpcyBpbmNvcnJlY3QgYWRkcmVzcyBjYW4ndCBiZSBkZXRlY3RlZCBi
eQ0KPiBpYl9kbWFfbWFwcGluZ19lcnJvci4gU2VuZGluZyBkYXRhIGZyb20gdGhpcyBhZGRyZXNz
IHRvIGhhcmR3YXJlIHdpbGwgbm90DQo+IGZhaWwsIGJ1dCB0aGUgcmVtb3RlIHBlZXIgd2lsbCBn
ZXQganVuayBkYXRhLg0KPiA+DQo+ID4gSSB0aGluayBpdCBtYWtlcyBzZW5zZSBhcyBzdGFjayBp
cyBkeW5hbWljIGFuZCBjYW4gc2hyaW5rIGFzIEkvTyBwcm9jZWVkcywgc28NCj4gdGhlIGJ1ZmZl
ciBpcyBnb25lLiBPdGhlciBrZXJuZWwgY29kZSB1c2Ugb25seSBkYXRhIG9uIHRoZSBoZWFwIGZv
ciBETUEsIGUuZy4NCj4gQkxLL1NDU0kgbGF5ZXIgbmV2ZXIgdXNlIGJ1ZmZlciBvbiB0aGUgc3Rh
Y2sgdG8gc2VuZCBkYXRhLg0KPiANCj4gSSB0b3RhbGx5IGFncmVlIHRoYXQgcmVnaXN0ZXJpbmcg
dGhlIHN0YWNrIGlzIGEgYmFkIGlkZWEuIEkgbWFpbmx5IHN1Z2dlc3QgdGhhdA0KPiB5b3UgY2Fw
dHVyZSB0aGVzZSBmdW5kYW1lbnRhbCBpYl9kbWEqIHJlYXNvbnMgaW4gdGhlIGNvbW1pdC4gVGhl
cmUncyBubw0KPiBvdGhlciBwcmFjdGljYWwgcmVhc29uIHdoeSB0aGUgb3JpZ2luYWwgYXBwcm9h
Y2ggd291bGQgbm90IHdvcmsuDQoNClN1cmUgSSB3aWxsIGZpeCB0aGF0Lg0K
