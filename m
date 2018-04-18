Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-909730-1524071768-2-10793358638872055616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524071768; b=JXtALqezt7xfY6o+np6UqLRShfbvxthhVEKjh27L2A15Bd1YeE
    NYxxCOTrvhnwJbmXG871b6Y6OuVeG7gkr3kwLW4kqN9BmYwSY93/IRZZZZ12H5TK
    ib/mlsFkPpBoq3bdxHy4r28rKgMbuuKikcq1huWH1ZRaG7Op+8eq9R5tStqbzo8w
    0m8TDOGrunohiEPH0ZtZT39XUaV3T2+MpzczXWGj1fOZy/xT3fgT71YHuojFtLsn
    KVsLz/jUllOZokW2Z8wSd0Q561WHjye6huBgUkay6CWB0hzEynaKepF+r1jN8pJV
    k90oojoBUMGYuVTZvl0FoTK0TJbE3cZh5FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524071768; bh=S+8t9XojZy
    5R0e7S0DvjarFVZBqEQgLs9VVQFDgdqj0=; b=WjObuZj8XJ/3m9wRQsAtmQ31Ec
    ZRKIpATPcuhxN/EqoV2D/ZjV6l8J2PbV1r/pthoHRQc/IHDuCMM/B4cZl6Nx5lYG
    guLxYLr80NClruCgAjz+u/wojciay0jCcdhalFze3oiB+YTwe4Mi1qqXkTkjpa0f
    td1Qsi0o56jK3f56fN58k585xwvShODh3dKgp9m2UNQ21IAGy/huCkbT6y6nuOY3
    kLJ56eIgOIQKOGdexoNQccrpax/2ZTAxF/r00QUwJ6FBy9IIbIgfb8/C0r53hHcJ
    ROdKEx+tQa0HHw8JMRwLsX34zXum/nC4S0zXp9rbJ/0OE1Ha4dVekd0W/XIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dE4g8Inx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dE4g8Inx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEJNMYVxOTRVjWRLnH2NOHDMTuW/1kJR3DfZIfVu1PbmEvOQLuz5Vw3LZjiS+BUO13MiKghDK5tKx3CgvuAQt+AhxbOv8Q6WKbMdRbJoh69N2VJ/tqtg
    zkPh/VBe6BFeAp7OTYr9PdVZmZd9DkXkY4wMSRh2LK/+uKD4X4WhhcWCZGEhvKNmuUJnxoq0g7L1APaVzqkwvVydsBM57cIpqYiN/m+i794GPazLmv44w3c3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=IYp8n1Yz95QA:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=yMhMjlubAAAA:8 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=Nhoi9vVKwS4RbA6556UA:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDRRQF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 13:16:05 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:22560
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751335AbeDRRQD (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 13:16:03 -0400
From: Long Li <longli@microsoft.com>
To: Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Topic: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Index: AQHT1q0nc3yHaleoh0CJYtibUbzbEqQGZIIAgABfECA=
Date: Wed, 18 Apr 2018 17:16:00 +0000
Message-ID: <MWHPR2101MB07298108AA78EBC4B8D10B4BCEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
 <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
In-Reply-To: <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0874;7:w7WSEh4RJW19ZrSKuQ74Ea/+TaWXgxXXVnRUQU287D4NcUAH7f1220rYjCH4I+fxaDnhkH1yzdbw+GkNFiQkrsOIFpHIRQb2PsDwsqqoT0vIEGSF1zZZYS5JyOGrQ7YEKeZlxvUjhWqBxCM8Kg9QiGW3A0HLZz1XOaWBvi+z8Jq/R4JQRyB6k4fJAOwHzlQMEzlmmnDHMnBR4vBDW6RhZXk2+LqWMtmE++WEYEQC/p/7ui0YLgFTx/SV+ZczbY3O;20:Oyy4mMK717rK/G2D2uuvKz/cKKYnA2TPHJmUprd5vsunn/Nk+NKXWpjDeL7mMMXB9+uFr0kC2vxBcDDyzBr17tjZeeX03TZpaVcVUmUh7to0JQioCp4ZYminsG5a1fHlzVC735zrHQgVWZYJ7Q530O7/hLqMrDrrkOqBiATXYug=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0874;
x-ms-traffictypediagnostic: MWHPR2101MB0874:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0874B1CE46BFA9D4C545D2BECEB60@MWHPR2101MB0874.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(192374486261705)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501368)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR2101MB0874;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0874;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(346002)(376002)(69234005)(81166006)(2201001)(15650500001)(316002)(86612001)(5250100002)(2501003)(6116002)(2906002)(8676002)(59450400001)(3280700002)(5660300001)(8936002)(6246003)(3660700001)(86362001)(22452003)(4326008)(7696005)(6436002)(9686003)(14454004)(76176011)(53936002)(55016002)(11346002)(446003)(7736002)(305945005)(53546011)(476003)(6506007)(102836004)(25786009)(10290500003)(478600001)(186003)(99286004)(229853002)(110136005)(10090500001)(33656002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0874;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: dYGW48GbxslwVVaPN+7expMogoWfsAGjam+dD9+l6e+LTsscLSe5rCIbhvkYDh5cUsVGf6GspBPEOkYyx6Xzhd3QK2UD6uDCTTf3D270GyK1bnxgEFbJVjYxr2fqK1q9TDecFhxm8dnC7LUsTiaZmNRLPhEjP/K2w4cpxxn6cm0eSgVRSuUho2GFScsf9BTN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d09b9427-0bba-41f9-5dee-08d5a5500edd
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09b9427-0bba-41f9-5dee-08d5a5500edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 17:16:00.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0874
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzIDIvNl0gY2lmczogQWxsb2NhdGUgdmFsaWRhdGUgbmVn
b3RpYXRpb24gcmVxdWVzdCB0aHJvdWdoDQo+IGttYWxsb2MNCj4gDQo+IFR3byBjb21tZW50cy4N
Cj4gDQo+IE9uIDQvMTcvMjAxOCA4OjMzIFBNLCBMb25nIExpIHdyb3RlOg0KPiA+IEZyb206IExv
bmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gVGhlIGRhdGEgYnVmZmVyIGFs
bG9jYXRlZCBvbiB0aGUgc3RhY2sgY2FuJ3QgYmUgRE1BJ2VkLCBhbmQgaGVuY2UNCj4gPiBjYW4n
dCBzZW5kIHRocm91Z2ggUkRNQSB2aWEgU01CIERpcmVjdC4NCj4gDQo+IFRoaXMgY29tbWVudCBp
cyBjb25mdXNpbmcuIEFueSByZWdpc3RlcmVkIG1lbW9yeSBjYW4gYmUgRE1BJ2QsIG5lZWQgdG8N
Cj4gc3RhdGUgdGhlIHJlYXNvbiBmb3IgdGhlIGNob2ljZSBoZXJlIG1vcmUgY2xlYXJseS4NCj4g
DQo+ID4NCj4gPiBGaXggdGhpcyBieSBhbGxvY2F0aW5nIHRoZSByZXF1ZXN0IG9uIHRoZSBoZWFw
IGluIHNtYjNfdmFsaWRhdGVfbmVnb3RpYXRlLg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4g
PiBSZW1vdmVkIGR1cGxpY2F0ZWQgY29kZSBvbiBmcmVlaW5nIGJ1ZmZlcnMgb24gZnVuY3Rpb24g
ZXhpdC4NCj4gPiAoVGhhbmtzIHRvIFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPikg
Rml4ZWQgdHlwbyBpbiB0aGUgcGF0Y2gNCj4gPiB0aXRsZS4NCj4gPg0KPiA+IENoYW5nZXMgaW4g
djM6DQo+ID4gQWRkZWQgIkZpeGVzIiB0byB0aGUgcGF0Y2guDQo+ID4gQ2hhbmdlZCBzaXplb2Yo
KSB0byB1c2UgKnBvaW50ZXIgaW4gcGxhY2Ugb2Ygc3RydWN0Lg0KPiA+DQo+ID4gRml4ZXM6IGZm
MWMwMzhhZGRjNCAoIkNoZWNrIFNNQjMgZGlhbGVjdHMgYWdhaW5zdCBkb3duZ3JhZGUgYXR0YWNr
cyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+
ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAtLS0NCj4gPiAgIGZzL2NpZnMvc21i
MnBkdS5jIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0N
Cj4gLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAy
NyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9jaWZzL3NtYjJwZHUuYyBi
L2ZzL2NpZnMvc21iMnBkdS5jIGluZGV4DQo+ID4gMGYwNDRjNC4uNTU4MmEwMiAxMDA2NDQNCj4g
PiAtLS0gYS9mcy9jaWZzL3NtYjJwZHUuYw0KPiA+ICsrKyBiL2ZzL2NpZnMvc21iMnBkdS5jDQo+
ID4gQEAgLTcyOSw4ICs3MjksOCBAQCBTTUIyX25lZ290aWF0ZShjb25zdCB1bnNpZ25lZCBpbnQg
eGlkLCBzdHJ1Y3QNCj4gPiBjaWZzX3NlcyAqc2VzKQ0KPiA+DQo+ID4gICBpbnQgc21iM192YWxp
ZGF0ZV9uZWdvdGlhdGUoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAq
dGNvbikNCj4gPiAgIHsNCj4gPiAtCWludCByYyA9IDA7DQo+ID4gLQlzdHJ1Y3QgdmFsaWRhdGVf
bmVnb3RpYXRlX2luZm9fcmVxIHZuZWdfaW5idWY7DQo+ID4gKwlpbnQgcmV0LCByYyA9IC1FSU87
DQo+ID4gKwlzdHJ1Y3QgdmFsaWRhdGVfbmVnb3RpYXRlX2luZm9fcmVxICpwbmVnX2luYnVmOw0K
PiA+ICAgCXN0cnVjdCB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yc3AgKnBuZWdfcnNwID0gTlVM
TDsNCj4gPiAgIAl1MzIgcnNwbGVuOw0KPiA+ICAgCXUzMiBpbmJ1ZmxlbjsgLyogbWF4IG9mIDQg
ZGlhbGVjdHMgKi8gQEAgLTc0MSw2ICs3NDEsOSBAQCBpbnQNCj4gPiBzbWIzX3ZhbGlkYXRlX25l
Z290aWF0ZShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uKQ0K
PiA+ICAgCWlmICh0Y29uLT5zZXMtPnNlcnZlci0+cmRtYSkNCj4gPiAgIAkJcmV0dXJuIDA7DQo+
ID4gICAjZW5kaWYNCj4gPiArCXBuZWdfaW5idWYgPSBrbWFsbG9jKHNpemVvZigqcG5lZ19pbmJ1
ZiksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFwbmVnX2luYnVmKQ0KPiA+ICsJCXJldHVybiAt
RU5PTUVNOw0KPiANCj4gV2h5IGlzIHRoaXMgYSBub25ibG9ja2luZyBhbGxvY2F0aW9uPyBJdCB3
b3VsZCBzZWVtIG1vcmUgcm9idXN0IHRvIHVzZQ0KPiBHRlBfTk9GUyBoZXJlLg0KDQpJIGFncmVl
IGl0IG1ha2VzIHNlbnNlIHRvIHVzZSBHRlBfTk9GUy4gDQoNClRoZSBjaG9pY2UgaGVyZSBpcyBt
YWRlIGNvbnNpc3RlbnQgd2l0aCBhbGwgdGhlIHJlc3QgQ0lGUyBjb2RlIGFsbG9jYXRpbmcgcHJv
dG9jb2wgcmVxdWVzdCBidWZmZXJzLiBNYXliZSB3ZSBzaG91bGQgZG8gYW5vdGhlciBwYXRjaCB0
byBjbGVhbnVwIGFsbCB0aG9zZSBjb2RlLg0KDQo+IA0KPiBUb20uDQo+IA0KPiA+DQo+ID4gICAJ
LyogSW4gU01CMy4xMSBwcmVhdXRoIGludGVncml0eSBzdXBlcnNlZGVzIHZhbGlkYXRlIG5lZ290
aWF0ZSAqLw0KPiA+ICAgCWlmICh0Y29uLT5zZXMtPnNlcnZlci0+ZGlhbGVjdCA9PSBTTUIzMTFf
UFJPVF9JRCkgQEAgLTc2NCw2Mw0KPiA+ICs3NjcsNjMgQEAgaW50IHNtYjNfdmFsaWRhdGVfbmVn
b3RpYXRlKGNvbnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdA0KPiBjaWZzX3Rjb24gKnRjb24p
DQo+ID4gICAJaWYgKHRjb24tPnNlcy0+c2Vzc2lvbl9mbGFncyAmIFNNQjJfU0VTU0lPTl9GTEFH
X0lTX05VTEwpDQo+ID4gICAJCWNpZnNfZGJnKFZGUywgIlVuZXhwZWN0ZWQgbnVsbCB1c2VyIChh
bm9ueW1vdXMpIGF1dGggZmxhZw0KPiBzZW50IGJ5DQo+ID4gc2VydmVyXG4iKTsNCj4gPg0KPiA+
IC0Jdm5lZ19pbmJ1Zi5DYXBhYmlsaXRpZXMgPQ0KPiA+ICsJcG5lZ19pbmJ1Zi0+Q2FwYWJpbGl0
aWVzID0NCj4gPiAgIAkJCWNwdV90b19sZTMyKHRjb24tPnNlcy0+c2VydmVyLT52YWxzLQ0KPiA+
cmVxX2NhcGFiaWxpdGllcyk7DQo+ID4gLQltZW1jcHkodm5lZ19pbmJ1Zi5HdWlkLCB0Y29uLT5z
ZXMtPnNlcnZlci0+Y2xpZW50X2d1aWQsDQo+ID4gKwltZW1jcHkocG5lZ19pbmJ1Zi0+R3VpZCwg
dGNvbi0+c2VzLT5zZXJ2ZXItPmNsaWVudF9ndWlkLA0KPiA+ICAgCQkJCQlTTUIyX0NMSUVOVF9H
VUlEX1NJWkUpOw0KPiA+DQo+ID4gICAJaWYgKHRjb24tPnNlcy0+c2lnbikNCj4gPiAtCQl2bmVn
X2luYnVmLlNlY3VyaXR5TW9kZSA9DQo+ID4gKwkJcG5lZ19pbmJ1Zi0+U2VjdXJpdHlNb2RlID0N
Cj4gPg0KPiAJY3B1X3RvX2xlMTYoU01CMl9ORUdPVElBVEVfU0lHTklOR19SRVFVSVJFRCk7DQo+
ID4gICAJZWxzZSBpZiAoZ2xvYmFsX3NlY2ZsYWdzICYgQ0lGU1NFQ19NQVlfU0lHTikNCj4gPiAt
CQl2bmVnX2luYnVmLlNlY3VyaXR5TW9kZSA9DQo+ID4gKwkJcG5lZ19pbmJ1Zi0+U2VjdXJpdHlN
b2RlID0NCj4gPg0KPiAJY3B1X3RvX2xlMTYoU01CMl9ORUdPVElBVEVfU0lHTklOR19FTkFCTEVE
KTsNCj4gPiAgIAllbHNlDQo+ID4gLQkJdm5lZ19pbmJ1Zi5TZWN1cml0eU1vZGUgPSAwOw0KPiA+
ICsJCXBuZWdfaW5idWYtPlNlY3VyaXR5TW9kZSA9IDA7DQo+ID4NCj4gPg0KPiA+ICAgCWlmIChz
dHJjbXAodGNvbi0+c2VzLT5zZXJ2ZXItPnZhbHMtPnZlcnNpb25fc3RyaW5nLA0KPiA+ICAgCQlT
TUIzQU5ZX1ZFUlNJT05fU1RSSU5HKSA9PSAwKSB7DQo+ID4gLQkJdm5lZ19pbmJ1Zi5EaWFsZWN0
c1swXSA9IGNwdV90b19sZTE2KFNNQjMwX1BST1RfSUQpOw0KPiA+IC0JCXZuZWdfaW5idWYuRGlh
bGVjdHNbMV0gPSBjcHVfdG9fbGUxNihTTUIzMDJfUFJPVF9JRCk7DQo+ID4gLQkJdm5lZ19pbmJ1
Zi5EaWFsZWN0Q291bnQgPSBjcHVfdG9fbGUxNigyKTsNCj4gPiArCQlwbmVnX2luYnVmLT5EaWFs
ZWN0c1swXSA9IGNwdV90b19sZTE2KFNNQjMwX1BST1RfSUQpOw0KPiA+ICsJCXBuZWdfaW5idWYt
PkRpYWxlY3RzWzFdID0gY3B1X3RvX2xlMTYoU01CMzAyX1BST1RfSUQpOw0KPiA+ICsJCXBuZWdf
aW5idWYtPkRpYWxlY3RDb3VudCA9IGNwdV90b19sZTE2KDIpOw0KPiA+ICAgCQkvKiBzdHJ1Y3R1
cmUgaXMgYmlnIGVub3VnaCBmb3IgMyBkaWFsZWN0cywgc2VuZGluZyBvbmx5IDIgKi8NCj4gPiAg
IAkJaW5idWZsZW4gPSBzaXplb2Yoc3RydWN0IHZhbGlkYXRlX25lZ290aWF0ZV9pbmZvX3JlcSkg
LSAyOw0KPiA+ICAgCX0gZWxzZSBpZiAoc3RyY21wKHRjb24tPnNlcy0+c2VydmVyLT52YWxzLT52
ZXJzaW9uX3N0cmluZywNCj4gPiAgIAkJU01CREVGQVVMVF9WRVJTSU9OX1NUUklORykgPT0gMCkg
ew0KPiA+IC0JCXZuZWdfaW5idWYuRGlhbGVjdHNbMF0gPSBjcHVfdG9fbGUxNihTTUIyMV9QUk9U
X0lEKTsNCj4gPiAtCQl2bmVnX2luYnVmLkRpYWxlY3RzWzFdID0gY3B1X3RvX2xlMTYoU01CMzBf
UFJPVF9JRCk7DQo+ID4gLQkJdm5lZ19pbmJ1Zi5EaWFsZWN0c1syXSA9IGNwdV90b19sZTE2KFNN
QjMwMl9QUk9UX0lEKTsNCj4gPiAtCQl2bmVnX2luYnVmLkRpYWxlY3RDb3VudCA9IGNwdV90b19s
ZTE2KDMpOw0KPiA+ICsJCXBuZWdfaW5idWYtPkRpYWxlY3RzWzBdID0gY3B1X3RvX2xlMTYoU01C
MjFfUFJPVF9JRCk7DQo+ID4gKwkJcG5lZ19pbmJ1Zi0+RGlhbGVjdHNbMV0gPSBjcHVfdG9fbGUx
NihTTUIzMF9QUk9UX0lEKTsNCj4gPiArCQlwbmVnX2luYnVmLT5EaWFsZWN0c1syXSA9IGNwdV90
b19sZTE2KFNNQjMwMl9QUk9UX0lEKTsNCj4gPiArCQlwbmVnX2luYnVmLT5EaWFsZWN0Q291bnQg
PSBjcHVfdG9fbGUxNigzKTsNCj4gPiAgIAkJLyogc3RydWN0dXJlIGlzIGJpZyBlbm91Z2ggZm9y
IDMgZGlhbGVjdHMgKi8NCj4gPiAgIAkJaW5idWZsZW4gPSBzaXplb2Yoc3RydWN0IHZhbGlkYXRl
X25lZ290aWF0ZV9pbmZvX3JlcSk7DQo+ID4gICAJfSBlbHNlIHsNCj4gPiAgIAkJLyogb3RoZXJ3
aXNlIHNwZWNpZmljIGRpYWxlY3Qgd2FzIHJlcXVlc3RlZCAqLw0KPiA+IC0JCXZuZWdfaW5idWYu
RGlhbGVjdHNbMF0gPQ0KPiA+ICsJCXBuZWdfaW5idWYtPkRpYWxlY3RzWzBdID0NCj4gPiAgIAkJ
CWNwdV90b19sZTE2KHRjb24tPnNlcy0+c2VydmVyLT52YWxzLT5wcm90b2NvbF9pZCk7DQo+ID4g
LQkJdm5lZ19pbmJ1Zi5EaWFsZWN0Q291bnQgPSBjcHVfdG9fbGUxNigxKTsNCj4gPiArCQlwbmVn
X2luYnVmLT5EaWFsZWN0Q291bnQgPSBjcHVfdG9fbGUxNigxKTsNCj4gPiAgIAkJLyogc3RydWN0
dXJlIGlzIGJpZyBlbm91Z2ggZm9yIDMgZGlhbGVjdHMsIHNlbmRpbmcgb25seSAxICovDQo+ID4g
ICAJCWluYnVmbGVuID0gc2l6ZW9mKHN0cnVjdCB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yZXEp
IC0gNDsNCj4gPiAgIAl9DQo+ID4NCj4gPiAtCXJjID0gU01CMl9pb2N0bCh4aWQsIHRjb24sIE5P
X0ZJTEVfSUQsIE5PX0ZJTEVfSUQsDQo+ID4gKwlyZXQgPSBTTUIyX2lvY3RsKHhpZCwgdGNvbiwg
Tk9fRklMRV9JRCwgTk9fRklMRV9JRCwNCj4gPiAgIAkJRlNDVExfVkFMSURBVEVfTkVHT1RJQVRF
X0lORk8sIHRydWUgLyogaXNfZnNjdGwgKi8sDQo+ID4gLQkJKGNoYXIgKikmdm5lZ19pbmJ1Ziwg
c2l6ZW9mKHN0cnVjdA0KPiB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yZXEpLA0KPiA+ICsJCShj
aGFyICopcG5lZ19pbmJ1Ziwgc2l6ZW9mKCpwbmVnX2luYnVmKSwNCj4gPiAgIAkJKGNoYXIgKiop
JnBuZWdfcnNwLCAmcnNwbGVuKTsNCj4gPg0KPiA+IC0JaWYgKHJjICE9IDApIHsNCj4gPiAtCQlj
aWZzX2RiZyhWRlMsICJ2YWxpZGF0ZSBwcm90b2NvbCBuZWdvdGlhdGUgZmFpbGVkOiAlZFxuIiwg
cmMpOw0KPiA+IC0JCXJldHVybiAtRUlPOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWNpZnNf
ZGJnKFZGUywgInZhbGlkYXRlIHByb3RvY29sIG5lZ290aWF0ZSBmYWlsZWQ6ICVkXG4iLCByZXQp
Ow0KPiA+ICsJCWdvdG8gb3V0X2ZyZWVfaW5idWY7DQo+ID4gICAJfQ0KPiA+DQo+ID4gLQlpZiAo
cnNwbGVuICE9IHNpemVvZihzdHJ1Y3QgdmFsaWRhdGVfbmVnb3RpYXRlX2luZm9fcnNwKSkgew0K
PiA+ICsJaWYgKHJzcGxlbiAhPSBzaXplb2YoKnBuZWdfcnNwKSkgew0KPiA+ICAgCQljaWZzX2Ri
ZyhWRlMsICJpbnZhbGlkIHByb3RvY29sIG5lZ290aWF0ZSByZXNwb25zZQ0KPiBzaXplOiAlZFxu
IiwNCj4gPiAgIAkJCSByc3BsZW4pOw0KPiA+DQo+ID4gICAJCS8qIHJlbGF4IGNoZWNrIHNpbmNl
IE1hYyByZXR1cm5zIG1heCBidWZzaXplIGFsbG93ZWQgb24gaW9jdGwNCj4gKi8NCj4gPiAgIAkJ
aWYgKChyc3BsZW4gPiBDSUZTTWF4QnVmU2l6ZSkNCj4gPiAgIAkJICAgICB8fCAocnNwbGVuIDwg
c2l6ZW9mKHN0cnVjdCB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yc3ApKSkNCj4gPiAtCQkJZ290
byBlcnJfcnNwX2ZyZWU7DQo+ID4gKwkJCWdvdG8gb3V0X2ZyZWVfcnNwOw0KPiA+ICAgCX0NCj4g
Pg0KPiA+ICAgCS8qIGNoZWNrIHZhbGlkYXRlIG5lZ290aWF0ZSBpbmZvIHJlc3BvbnNlIG1hdGNo
ZXMgd2hhdCB3ZSBnb3QNCj4gPiBlYXJsaWVyICovIEBAIC04MzgsMTQgKzg0MSwxNiBAQCBpbnQg
c21iM192YWxpZGF0ZV9uZWdvdGlhdGUoY29uc3QNCj4gPiB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1
Y3QgY2lmc190Y29uICp0Y29uKQ0KPiA+DQo+ID4gICAJLyogdmFsaWRhdGUgbmVnb3RpYXRlIHN1
Y2Nlc3NmdWwgKi8NCj4gPiAgIAljaWZzX2RiZyhGWUksICJ2YWxpZGF0ZSBuZWdvdGlhdGUgaW5m
byBzdWNjZXNzZnVsXG4iKTsNCj4gPiAtCWtmcmVlKHBuZWdfcnNwKTsNCj4gPiAtCXJldHVybiAw
Ow0KPiA+ICsJcmMgPSAwOw0KPiA+ICsJZ290byBvdXRfZnJlZV9yc3A7DQo+ID4NCj4gPiAgIHZu
ZWdfb3V0Og0KPiA+ICAgCWNpZnNfZGJnKFZGUywgInByb3RvY29sIHJldmFsaWRhdGlvbiAtIHNl
Y3VyaXR5IHNldHRpbmdzDQo+ID4gbWlzbWF0Y2hcbiIpOw0KPiA+IC1lcnJfcnNwX2ZyZWU6DQo+
ID4gK291dF9mcmVlX3JzcDoNCj4gPiAgIAlrZnJlZShwbmVnX3JzcCk7DQo+ID4gLQlyZXR1cm4g
LUVJTzsNCj4gPiArb3V0X2ZyZWVfaW5idWY6DQo+ID4gKwlrZnJlZShwbmVnX2luYnVmKTsNCj4g
PiArCXJldHVybiByYzsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgZW51bSBzZWN1cml0eUVudW0NCj4g
Pg0K
