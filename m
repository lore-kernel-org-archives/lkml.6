Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1035396-1524077654-2-3945010939321227096
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524077653; b=n/nXMRaKt2VHlTcX0+Ci5kCjQsB4CxhHLmkRTTXrPZlopB+T6b
    ZE8vD4++o28sLMY0ByoN8fHutqiNfgVTHmasUqWOgS9QfLER987lSQ6VTp92uhKr
    qoN7lvT54vjFJdYPTNyd6zIsvpHIX+0kiGfCWcQPn21qEM9mXBl6cBK8nhbyDURi
    z8e1i14amKg6WNw0VFIjh5d+HaKa6wtd4Bo0GvGaieifh+5DHEW+Vv8RQnBrrcyR
    odCcS+5fx8LZEkG24Y9E32gyRL+jSzARxEgLj8dP9iPhq9kR/8oFjOH/+BzKxU2y
    73b4H9VSdNODKf29PLviePfRDFnqnwqe3D+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524077653; bh=YhOh/mc04s
    09ZrAVygeGpo2COkOTYUfzM7b64GH60Wg=; b=kzZE4Na4VE2V/oajbUVoeMxNkk
    kw8K+S5j3ij/ryGHFXFQy98RpBJnxknuEyC9vZ3M5+GGqWEyCZIWPH1bP2wgTa5o
    hsTWgjuW0Zi12/IYRUBUxI7JjcsLRJYxTjj9RW1uWh8+VHbQB2IBYk4ZN/iTt3wf
    tVzhcu2T/sjU5JjnJxEVAOJBckJ+/WDjGSc7cF+x7uTeQhUgG/+Q4NJWjxphH0C1
    8ThzhmjMmlrKDz9YL34333O8isEsH8apGi8IRybKasvd2CwNNL3TFp9x7tSw/tnc
    TgjpE/z7Kp3SHhQroeiekYY6B/8dX65vSzK7uZOtIkhj/FJxv+QAkepX7Y9g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HyjN6/Es x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HyjN6/Es x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHsKSTEN2qt4FGgD6pyCag29XF/awZn7ue5bb4UnlGQ0IYrb0JEa7CQ4gP3qIXD7tNefvDhEdOOaCUccroeE1QluWnd6yraJtz7eIrInh+HnIJNpMBwu
    0/98mEKddotEhnBve8Ekm1OvVU4cCdfcF2kCM8YDAtMXOkhJGXJAMDv/90dsa8m3mhLDYF+OL6/beei2w/fHwCnMSaFoB0la8HdAUXeQQrMKoTkLV/U+azcp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=R4fxTKrshSIA:10 a=IYp8n1Yz95QA:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=yMhMjlubAAAA:8 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=gNNYoDwtRQVvGGBI-wEA:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeDRSx6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 14:53:58 -0400
Received: from mail-by2nam03on0099.outbound.protection.outlook.com ([104.47.42.99]:63755
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753158AbeDRSxz (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 14:53:55 -0400
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
Thread-Index: AQHT1q0nc3yHaleoh0CJYtibUbzbEqQGZIIAgABfECCAAAhjAIAAE7FA
Date: Wed, 18 Apr 2018 18:53:53 +0000
Message-ID: <MWHPR2101MB0729A5CE8F2D52371AD239C6CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
 <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
 <MWHPR2101MB07298108AA78EBC4B8D10B4BCEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
 <aabd22d8-3644-6987-1d51-5592f9e04ced@talpey.com>
In-Reply-To: <aabd22d8-3644-6987-1d51-5592f9e04ced@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0811;7:Yu7MJ/SchdZowiehd4DDjCzRbD1I3XbRJhLWD05EqBBHqb4O3p0EEb2/USZ9SF6zfSxuDCCc68/kd1R4GpWWGuyI2LP/UCtktOol2fuo/0+DR9PYR5gxjzkFDgA+fhq3pSzseCKRq73FSkCx6ySnftY/LZiBqHK+DyXPPhsJbz4pdBlkFGf2GcTSWM2qvIMSwtp5xCudx5RmE8I5bdjoBFTZsmRFapMg/uVeKkkWy70uBAB2SVNbEHJHXnKEnQsg;20:IsShSnKE4bVzLTqI4q9n+OX4OxXUWVxQU9i6eyy2oqo/wAFyNCZ/x3SUlQE/puS/KM+Fef8B9XLJjN/wkHmvThg7Ouz0eujb32CYzNlLa9afbhdbEeApNu6rUGtd3gMx/Nh1yjLFCj9ZDgrglQCYRYHd2Rj7UeFXzzCknUYtFwA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:MWHPR2101MB0811;
x-ms-traffictypediagnostic: MWHPR2101MB0811:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=microsoft.com;
x-microsoft-antispam-prvs: <MWHPR2101MB0811416311F32BA4F88116C5CEB60@MWHPR2101MB0811.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(192374486261705)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501368)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR2101MB0811;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0811;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(39380400002)(69234005)(2906002)(229853002)(8936002)(14454004)(10290500003)(9686003)(6436002)(55016002)(25786009)(15650500001)(478600001)(7696005)(76176011)(53546011)(86612001)(476003)(59450400001)(99286004)(446003)(11346002)(6506007)(186003)(5660300001)(10090500001)(102836004)(33656002)(3280700002)(3660700001)(110136005)(6246003)(2501003)(316002)(22452003)(7736002)(93886005)(6116002)(305945005)(4326008)(2201001)(5250100002)(53936002)(81166006)(74316002)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0811;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: qIXYUPg3W1s6+aYBwykTIRcd/rMXYy+SZsP/x/k9ald5l7Fq7vGgTR23WIdkMk6My+MAbliUNwrVKS11Qa4qlB1uy9yFVDHhJNKBjy7tOIE9Cadv2+eBEgvssbKna+n+BcPRh9Gv6pocM57MFBftpB9KP5xAEJGjJUyKG5Qi4q91xy9EK4F/0FdqKEP/RDSc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8edec974-3e71-4d7a-ac75-08d5a55dbb23
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edec974-3e71-4d7a-ac75-08d5a55dbb23
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 18:53:53.2543
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
OjE2IFBNLCBMb25nIExpIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzIDIvNl0g
Y2lmczogQWxsb2NhdGUgdmFsaWRhdGUgbmVnb3RpYXRpb24NCj4gPj4gcmVxdWVzdCB0aHJvdWdo
IGttYWxsb2MNCj4gPj4NCj4gPj4gVHdvIGNvbW1lbnRzLg0KPiA+Pg0KPiA+PiBPbiA0LzE3LzIw
MTggODozMyBQTSwgTG9uZyBMaSB3cm90ZToNCj4gPj4+IEZyb206IExvbmcgTGkgPGxvbmdsaUBt
aWNyb3NvZnQuY29tPg0KPiA+Pj4NCj4gPj4+IFRoZSBkYXRhIGJ1ZmZlciBhbGxvY2F0ZWQgb24g
dGhlIHN0YWNrIGNhbid0IGJlIERNQSdlZCwgYW5kIGhlbmNlDQo+ID4+PiBjYW4ndCBzZW5kIHRo
cm91Z2ggUkRNQSB2aWEgU01CIERpcmVjdC4NCj4gPj4NCj4gPj4gVGhpcyBjb21tZW50IGlzIGNv
bmZ1c2luZy4gQW55IHJlZ2lzdGVyZWQgbWVtb3J5IGNhbiBiZSBETUEnZCwgbmVlZA0KPiA+PiB0
byBzdGF0ZSB0aGUgcmVhc29uIGZvciB0aGUgY2hvaWNlIGhlcmUgbW9yZSBjbGVhcmx5Lg0KPiA+
Pg0KPiA+Pj4NCj4gPj4+IEZpeCB0aGlzIGJ5IGFsbG9jYXRpbmcgdGhlIHJlcXVlc3Qgb24gdGhl
IGhlYXAgaW4NCj4gc21iM192YWxpZGF0ZV9uZWdvdGlhdGUuDQo+ID4+Pg0KPiA+Pj4gQ2hhbmdl
cyBpbiB2MjoNCj4gPj4+IFJlbW92ZWQgZHVwbGljYXRlZCBjb2RlIG9uIGZyZWVpbmcgYnVmZmVy
cyBvbiBmdW5jdGlvbiBleGl0Lg0KPiA+Pj4gKFRoYW5rcyB0byBQYXJhdiBQYW5kaXQgPHBhcmF2
QG1lbGxhbm94LmNvbT4pIEZpeGVkIHR5cG8gaW4gdGhlDQo+ID4+PiBwYXRjaCB0aXRsZS4NCj4g
Pj4+DQo+ID4+PiBDaGFuZ2VzIGluIHYzOg0KPiA+Pj4gQWRkZWQgIkZpeGVzIiB0byB0aGUgcGF0
Y2guDQo+ID4+PiBDaGFuZ2VkIHNpemVvZigpIHRvIHVzZSAqcG9pbnRlciBpbiBwbGFjZSBvZiBz
dHJ1Y3QuDQo+ID4+Pg0KPiA+Pj4gRml4ZXM6IGZmMWMwMzhhZGRjNCAoIkNoZWNrIFNNQjMgZGlh
bGVjdHMgYWdhaW5zdCBkb3duZ3JhZGUNCj4gPj4+IGF0dGFja3MiKQ0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4+PiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiA+Pj4gLS0tDQo+ID4+PiAgICBmcy9jaWZzL3NtYjJwZHUuYyB8IDU5
DQo+ID4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiA+
PiAtLS0tLS0tLS0tLQ0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyks
IDI3IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9mcy9jaWZzL3NtYjJw
ZHUuYyBiL2ZzL2NpZnMvc21iMnBkdS5jIGluZGV4DQo+ID4+PiAwZjA0NGM0Li41NTgyYTAyIDEw
MDY0NA0KPiA+Pj4gLS0tIGEvZnMvY2lmcy9zbWIycGR1LmMNCj4gPj4+ICsrKyBiL2ZzL2NpZnMv
c21iMnBkdS5jDQo+ID4+PiBAQCAtNzI5LDggKzcyOSw4IEBAIFNNQjJfbmVnb3RpYXRlKGNvbnN0
IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdA0KPiA+Pj4gY2lmc19zZXMgKnNlcykNCj4gPj4+DQo+
ID4+PiAgICBpbnQgc21iM192YWxpZGF0ZV9uZWdvdGlhdGUoY29uc3QgdW5zaWduZWQgaW50IHhp
ZCwgc3RydWN0IGNpZnNfdGNvbg0KPiAqdGNvbikNCj4gPj4+ICAgIHsNCj4gPj4+IC0JaW50IHJj
ID0gMDsNCj4gPj4+IC0Jc3RydWN0IHZhbGlkYXRlX25lZ290aWF0ZV9pbmZvX3JlcSB2bmVnX2lu
YnVmOw0KPiA+Pj4gKwlpbnQgcmV0LCByYyA9IC1FSU87DQo+ID4+PiArCXN0cnVjdCB2YWxpZGF0
ZV9uZWdvdGlhdGVfaW5mb19yZXEgKnBuZWdfaW5idWY7DQo+ID4+PiAgICAJc3RydWN0IHZhbGlk
YXRlX25lZ290aWF0ZV9pbmZvX3JzcCAqcG5lZ19yc3AgPSBOVUxMOw0KPiA+Pj4gICAgCXUzMiBy
c3BsZW47DQo+ID4+PiAgICAJdTMyIGluYnVmbGVuOyAvKiBtYXggb2YgNCBkaWFsZWN0cyAqLyBA
QCAtNzQxLDYgKzc0MSw5IEBAIGludA0KPiA+Pj4gc21iM192YWxpZGF0ZV9uZWdvdGlhdGUoY29u
c3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbikNCj4gPj4+ICAgIAlp
ZiAodGNvbi0+c2VzLT5zZXJ2ZXItPnJkbWEpDQo+ID4+PiAgICAJCXJldHVybiAwOw0KPiA+Pj4g
ICAgI2VuZGlmDQo+ID4+PiArCXBuZWdfaW5idWYgPSBrbWFsbG9jKHNpemVvZigqcG5lZ19pbmJ1
ZiksIEdGUF9LRVJORUwpOw0KPiA+Pj4gKwlpZiAoIXBuZWdfaW5idWYpDQo+ID4+PiArCQlyZXR1
cm4gLUVOT01FTTsNCj4gPj4NCj4gPj4gV2h5IGlzIHRoaXMgYSBub25ibG9ja2luZyBhbGxvY2F0
aW9uPyBJdCB3b3VsZCBzZWVtIG1vcmUgcm9idXN0IHRvDQo+ID4+IHVzZSBHRlBfTk9GUyBoZXJl
Lg0KPiA+DQo+ID4gSSBhZ3JlZSBpdCBtYWtlcyBzZW5zZSB0byB1c2UgR0ZQX05PRlMuDQo+ID4N
Cj4gPiBUaGUgY2hvaWNlIGhlcmUgaXMgbWFkZSBjb25zaXN0ZW50IHdpdGggYWxsIHRoZSByZXN0
IENJRlMgY29kZSBhbGxvY2F0aW5nDQo+IHByb3RvY29sIHJlcXVlc3QgYnVmZmVycy4gTWF5YmUg
d2Ugc2hvdWxkIGRvIGFub3RoZXIgcGF0Y2ggdG8gY2xlYW51cCBhbGwNCj4gdGhvc2UgY29kZS4N
Cj4gDQo+IEl0J2xsIGJlIHJlcXVpcmVkIHNvb25lciBvciBsYXRlci4gSSdtIGFnbm9zdGljIGFz
IHRvIGhvdyB5b3UgYXBwbHkgaXQsIGJ1dCBJIHN0aWxsDQo+IHN1Z2dlc3QgeW91IGNoYW5nZSB0
aGlzIG9uZSBub3cgcmF0aGVyIHRoYW4gY29udGludWUgdGhlIGZyYWdpbGUgYmVoYXZpb3IuIEl0
DQo+IG1heSBub3QgYmUgYSBnbG9iYWwgc2VhcmNoLWFuZC1yZXBsYWNlIHNpbmNlIHNvbWUgYWxs
b2NhdGlvbnMgbWF5IHJlcXVpcmUNCj4gbm9uYmxvY2tpbmcuDQoNCk9rYXksIEkgd2lsbCBmaXgg
dGhpcy4NCg0KPiANCj4gDQo+ID4NCj4gPj4NCj4gPj4gVG9tLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+
ICAgIAkvKiBJbiBTTUIzLjExIHByZWF1dGggaW50ZWdyaXR5IHN1cGVyc2VkZXMgdmFsaWRhdGUg
bmVnb3RpYXRlICovDQo+ID4+PiAgICAJaWYgKHRjb24tPnNlcy0+c2VydmVyLT5kaWFsZWN0ID09
IFNNQjMxMV9QUk9UX0lEKSBAQCAtNzY0LDYzDQo+ID4+PiArNzY3LDYzIEBAIGludCBzbWIzX3Zh
bGlkYXRlX25lZ290aWF0ZShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLA0KPiA+Pj4gK3N0cnVjdA0K
PiA+PiBjaWZzX3Rjb24gKnRjb24pDQo+ID4+PiAgICAJaWYgKHRjb24tPnNlcy0+c2Vzc2lvbl9m
bGFncyAmIFNNQjJfU0VTU0lPTl9GTEFHX0lTX05VTEwpDQo+ID4+PiAgICAJCWNpZnNfZGJnKFZG
UywgIlVuZXhwZWN0ZWQgbnVsbCB1c2VyIChhbm9ueW1vdXMpIGF1dGggZmxhZw0KPiA+PiBzZW50
IGJ5DQo+ID4+PiBzZXJ2ZXJcbiIpOw0KPiA+Pj4NCj4gPj4+IC0Jdm5lZ19pbmJ1Zi5DYXBhYmls
aXRpZXMgPQ0KPiA+Pj4gKwlwbmVnX2luYnVmLT5DYXBhYmlsaXRpZXMgPQ0KPiA+Pj4gICAgCQkJ
Y3B1X3RvX2xlMzIodGNvbi0+c2VzLT5zZXJ2ZXItPnZhbHMtDQo+ID4+PiByZXFfY2FwYWJpbGl0
aWVzKTsNCj4gPj4+IC0JbWVtY3B5KHZuZWdfaW5idWYuR3VpZCwgdGNvbi0+c2VzLT5zZXJ2ZXIt
PmNsaWVudF9ndWlkLA0KPiA+Pj4gKwltZW1jcHkocG5lZ19pbmJ1Zi0+R3VpZCwgdGNvbi0+c2Vz
LT5zZXJ2ZXItPmNsaWVudF9ndWlkLA0KPiA+Pj4gICAgCQkJCQlTTUIyX0NMSUVOVF9HVUlEX1NJ
WkUpOw0KPiA+Pj4NCj4gPj4+ICAgIAlpZiAodGNvbi0+c2VzLT5zaWduKQ0KPiA+Pj4gLQkJdm5l
Z19pbmJ1Zi5TZWN1cml0eU1vZGUgPQ0KPiA+Pj4gKwkJcG5lZ19pbmJ1Zi0+U2VjdXJpdHlNb2Rl
ID0NCj4gPj4+DQo+ID4+IAljcHVfdG9fbGUxNihTTUIyX05FR09USUFURV9TSUdOSU5HX1JFUVVJ
UkVEKTsNCj4gPj4+ICAgIAllbHNlIGlmIChnbG9iYWxfc2VjZmxhZ3MgJiBDSUZTU0VDX01BWV9T
SUdOKQ0KPiA+Pj4gLQkJdm5lZ19pbmJ1Zi5TZWN1cml0eU1vZGUgPQ0KPiA+Pj4gKwkJcG5lZ19p
bmJ1Zi0+U2VjdXJpdHlNb2RlID0NCj4gPj4+DQo+ID4+IAljcHVfdG9fbGUxNihTTUIyX05FR09U
SUFURV9TSUdOSU5HX0VOQUJMRUQpOw0KPiA+Pj4gICAgCWVsc2UNCj4gPj4+IC0JCXZuZWdfaW5i
dWYuU2VjdXJpdHlNb2RlID0gMDsNCj4gPj4+ICsJCXBuZWdfaW5idWYtPlNlY3VyaXR5TW9kZSA9
IDA7DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+ICAgIAlpZiAoc3RyY21wKHRjb24tPnNlcy0+c2VydmVy
LT52YWxzLT52ZXJzaW9uX3N0cmluZywNCj4gPj4+ICAgIAkJU01CM0FOWV9WRVJTSU9OX1NUUklO
RykgPT0gMCkgew0KPiA+Pj4gLQkJdm5lZ19pbmJ1Zi5EaWFsZWN0c1swXSA9IGNwdV90b19sZTE2
KFNNQjMwX1BST1RfSUQpOw0KPiA+Pj4gLQkJdm5lZ19pbmJ1Zi5EaWFsZWN0c1sxXSA9IGNwdV90
b19sZTE2KFNNQjMwMl9QUk9UX0lEKTsNCj4gPj4+IC0JCXZuZWdfaW5idWYuRGlhbGVjdENvdW50
ID0gY3B1X3RvX2xlMTYoMik7DQo+ID4+PiArCQlwbmVnX2luYnVmLT5EaWFsZWN0c1swXSA9IGNw
dV90b19sZTE2KFNNQjMwX1BST1RfSUQpOw0KPiA+Pj4gKwkJcG5lZ19pbmJ1Zi0+RGlhbGVjdHNb
MV0gPSBjcHVfdG9fbGUxNihTTUIzMDJfUFJPVF9JRCk7DQo+ID4+PiArCQlwbmVnX2luYnVmLT5E
aWFsZWN0Q291bnQgPSBjcHVfdG9fbGUxNigyKTsNCj4gPj4+ICAgIAkJLyogc3RydWN0dXJlIGlz
IGJpZyBlbm91Z2ggZm9yIDMgZGlhbGVjdHMsIHNlbmRpbmcgb25seSAyICovDQo+ID4+PiAgICAJ
CWluYnVmbGVuID0gc2l6ZW9mKHN0cnVjdCB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yZXEpIC0g
MjsNCj4gPj4+ICAgIAl9IGVsc2UgaWYgKHN0cmNtcCh0Y29uLT5zZXMtPnNlcnZlci0+dmFscy0+
dmVyc2lvbl9zdHJpbmcsDQo+ID4+PiAgICAJCVNNQkRFRkFVTFRfVkVSU0lPTl9TVFJJTkcpID09
IDApIHsNCj4gPj4+IC0JCXZuZWdfaW5idWYuRGlhbGVjdHNbMF0gPSBjcHVfdG9fbGUxNihTTUIy
MV9QUk9UX0lEKTsNCj4gPj4+IC0JCXZuZWdfaW5idWYuRGlhbGVjdHNbMV0gPSBjcHVfdG9fbGUx
NihTTUIzMF9QUk9UX0lEKTsNCj4gPj4+IC0JCXZuZWdfaW5idWYuRGlhbGVjdHNbMl0gPSBjcHVf
dG9fbGUxNihTTUIzMDJfUFJPVF9JRCk7DQo+ID4+PiAtCQl2bmVnX2luYnVmLkRpYWxlY3RDb3Vu
dCA9IGNwdV90b19sZTE2KDMpOw0KPiA+Pj4gKwkJcG5lZ19pbmJ1Zi0+RGlhbGVjdHNbMF0gPSBj
cHVfdG9fbGUxNihTTUIyMV9QUk9UX0lEKTsNCj4gPj4+ICsJCXBuZWdfaW5idWYtPkRpYWxlY3Rz
WzFdID0gY3B1X3RvX2xlMTYoU01CMzBfUFJPVF9JRCk7DQo+ID4+PiArCQlwbmVnX2luYnVmLT5E
aWFsZWN0c1syXSA9IGNwdV90b19sZTE2KFNNQjMwMl9QUk9UX0lEKTsNCj4gPj4+ICsJCXBuZWdf
aW5idWYtPkRpYWxlY3RDb3VudCA9IGNwdV90b19sZTE2KDMpOw0KPiA+Pj4gICAgCQkvKiBzdHJ1
Y3R1cmUgaXMgYmlnIGVub3VnaCBmb3IgMyBkaWFsZWN0cyAqLw0KPiA+Pj4gICAgCQlpbmJ1Zmxl
biA9IHNpemVvZihzdHJ1Y3QgdmFsaWRhdGVfbmVnb3RpYXRlX2luZm9fcmVxKTsNCj4gPj4+ICAg
IAl9IGVsc2Ugew0KPiA+Pj4gICAgCQkvKiBvdGhlcndpc2Ugc3BlY2lmaWMgZGlhbGVjdCB3YXMg
cmVxdWVzdGVkICovDQo+ID4+PiAtCQl2bmVnX2luYnVmLkRpYWxlY3RzWzBdID0NCj4gPj4+ICsJ
CXBuZWdfaW5idWYtPkRpYWxlY3RzWzBdID0NCj4gPj4+ICAgIAkJCWNwdV90b19sZTE2KHRjb24t
PnNlcy0+c2VydmVyLT52YWxzLT5wcm90b2NvbF9pZCk7DQo+ID4+PiAtCQl2bmVnX2luYnVmLkRp
YWxlY3RDb3VudCA9IGNwdV90b19sZTE2KDEpOw0KPiA+Pj4gKwkJcG5lZ19pbmJ1Zi0+RGlhbGVj
dENvdW50ID0gY3B1X3RvX2xlMTYoMSk7DQo+ID4+PiAgICAJCS8qIHN0cnVjdHVyZSBpcyBiaWcg
ZW5vdWdoIGZvciAzIGRpYWxlY3RzLCBzZW5kaW5nIG9ubHkgMSAqLw0KPiA+Pj4gICAgCQlpbmJ1
ZmxlbiA9IHNpemVvZihzdHJ1Y3QgdmFsaWRhdGVfbmVnb3RpYXRlX2luZm9fcmVxKSAtIDQ7DQo+
ID4+PiAgICAJfQ0KPiA+Pj4NCj4gPj4+IC0JcmMgPSBTTUIyX2lvY3RsKHhpZCwgdGNvbiwgTk9f
RklMRV9JRCwgTk9fRklMRV9JRCwNCj4gPj4+ICsJcmV0ID0gU01CMl9pb2N0bCh4aWQsIHRjb24s
IE5PX0ZJTEVfSUQsIE5PX0ZJTEVfSUQsDQo+ID4+PiAgICAJCUZTQ1RMX1ZBTElEQVRFX05FR09U
SUFURV9JTkZPLCB0cnVlIC8qIGlzX2ZzY3RsICovLA0KPiA+Pj4gLQkJKGNoYXIgKikmdm5lZ19p
bmJ1Ziwgc2l6ZW9mKHN0cnVjdA0KPiA+PiB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yZXEpLA0K
PiA+Pj4gKwkJKGNoYXIgKilwbmVnX2luYnVmLCBzaXplb2YoKnBuZWdfaW5idWYpLA0KPiA+Pj4g
ICAgCQkoY2hhciAqKikmcG5lZ19yc3AsICZyc3BsZW4pOw0KPiA+Pj4NCj4gPj4+IC0JaWYgKHJj
ICE9IDApIHsNCj4gPj4+IC0JCWNpZnNfZGJnKFZGUywgInZhbGlkYXRlIHByb3RvY29sIG5lZ290
aWF0ZSBmYWlsZWQ6ICVkXG4iLCByYyk7DQo+ID4+PiAtCQlyZXR1cm4gLUVJTzsNCj4gPj4+ICsJ
aWYgKHJldCkgew0KPiA+Pj4gKwkJY2lmc19kYmcoVkZTLCAidmFsaWRhdGUgcHJvdG9jb2wgbmVn
b3RpYXRlIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ID4+PiArCQlnb3RvIG91dF9mcmVlX2luYnVm
Ow0KPiA+Pj4gICAgCX0NCj4gPj4+DQo+ID4+PiAtCWlmIChyc3BsZW4gIT0gc2l6ZW9mKHN0cnVj
dCB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yc3ApKSB7DQo+ID4+PiArCWlmIChyc3BsZW4gIT0g
c2l6ZW9mKCpwbmVnX3JzcCkpIHsNCj4gPj4+ICAgIAkJY2lmc19kYmcoVkZTLCAiaW52YWxpZCBw
cm90b2NvbCBuZWdvdGlhdGUgcmVzcG9uc2UNCj4gPj4gc2l6ZTogJWRcbiIsDQo+ID4+PiAgICAJ
CQkgcnNwbGVuKTsNCj4gPj4+DQo+ID4+PiAgICAJCS8qIHJlbGF4IGNoZWNrIHNpbmNlIE1hYyBy
ZXR1cm5zIG1heCBidWZzaXplIGFsbG93ZWQgb24gaW9jdGwNCj4gPj4gKi8NCj4gPj4+ICAgIAkJ
aWYgKChyc3BsZW4gPiBDSUZTTWF4QnVmU2l6ZSkNCj4gPj4+ICAgIAkJICAgICB8fCAocnNwbGVu
IDwgc2l6ZW9mKHN0cnVjdCB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yc3ApKSkNCj4gPj4+IC0J
CQlnb3RvIGVycl9yc3BfZnJlZTsNCj4gPj4+ICsJCQlnb3RvIG91dF9mcmVlX3JzcDsNCj4gPj4+
ICAgIAl9DQo+ID4+Pg0KPiA+Pj4gICAgCS8qIGNoZWNrIHZhbGlkYXRlIG5lZ290aWF0ZSBpbmZv
IHJlc3BvbnNlIG1hdGNoZXMgd2hhdCB3ZSBnb3QNCj4gPj4+IGVhcmxpZXIgKi8gQEAgLTgzOCwx
NCArODQxLDE2IEBAIGludCBzbWIzX3ZhbGlkYXRlX25lZ290aWF0ZShjb25zdA0KPiA+Pj4gdW5z
aWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbikNCj4gPj4+DQo+ID4+PiAgICAJ
LyogdmFsaWRhdGUgbmVnb3RpYXRlIHN1Y2Nlc3NmdWwgKi8NCj4gPj4+ICAgIAljaWZzX2RiZyhG
WUksICJ2YWxpZGF0ZSBuZWdvdGlhdGUgaW5mbyBzdWNjZXNzZnVsXG4iKTsNCj4gPj4+IC0Ja2Zy
ZWUocG5lZ19yc3ApOw0KPiA+Pj4gLQlyZXR1cm4gMDsNCj4gPj4+ICsJcmMgPSAwOw0KPiA+Pj4g
Kwlnb3RvIG91dF9mcmVlX3JzcDsNCj4gPj4+DQo+ID4+PiAgICB2bmVnX291dDoNCj4gPj4+ICAg
IAljaWZzX2RiZyhWRlMsICJwcm90b2NvbCByZXZhbGlkYXRpb24gLSBzZWN1cml0eSBzZXR0aW5n
cw0KPiA+Pj4gbWlzbWF0Y2hcbiIpOw0KPiA+Pj4gLWVycl9yc3BfZnJlZToNCj4gPj4+ICtvdXRf
ZnJlZV9yc3A6DQo+ID4+PiAgICAJa2ZyZWUocG5lZ19yc3ApOw0KPiA+Pj4gLQlyZXR1cm4gLUVJ
TzsNCj4gPj4+ICtvdXRfZnJlZV9pbmJ1ZjoNCj4gPj4+ICsJa2ZyZWUocG5lZ19pbmJ1Zik7DQo+
ID4+PiArCXJldHVybiByYzsNCj4gPj4+ICAgIH0NCj4gPj4+DQo+ID4+PiAgICBlbnVtIHNlY3Vy
aXR5RW51bQ0KPiA+Pj4NCj4gPiBOICAgICByICB5ICAgYiBYICDHp3YgXiAp3rp7Lm4gKyAgICB7
ICDZmiB7YXkgHcqH2pkgLGogICBmICAgaCAgIHogHiB3DQo+IA0KPiAgICBqOit2ICAgdyBqIG0g
ICAgICAgICB6WisgICAgIN2iaiIgICF0bWw9DQo+ID4NCg==
