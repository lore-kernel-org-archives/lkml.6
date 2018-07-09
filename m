Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F77C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0E2208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="0HMy6rmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0E2208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeGIEiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:38:21 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:57685 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750810AbeGIEiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1531110496; x=1562646496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2sfeSKJ7WtpLlyrm4kK9+Wpu+bnGUiWCEc+MZNKyQmc=;
  b=0HMy6rmMRm3RSEcQMn9wIaFpgCHA/PEN5kBfkunWkrxzH6ve78BtqqAd
   b2F3qlZ8fDKSvVq3UVVrO/u3HbCtfroWp+78VUFrESi9tOfVsMUW88vQI
   yvMYEpZVCghxVd2OqNd18BHL9jRQ2NYa9nbGJariNOwUH8VmXWrH/c5N2
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EyBgCQ5UJbh8mZ6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYMbgQKBDSgKg3CUOIIHgziTdAuEbAIXghchOBQBAgEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEKCwkIKS+CNSKCYQEBAQECASMROgMIBQcEAgEIEQQBAQECAiMDAgICRAECA?=
 =?us-ascii?q?QUIAgQBDQUIgxiBeAipEYIciEaBOoELh2OCFYEPgw+EXiMzgkeCVQKICZFGBwK?=
 =?us-ascii?q?PHIFKhA6IDYd9ihOBWIF0cFCCaYIkDgmOF28BjjWBGgEB?=
X-IPAS-Result: =?us-ascii?q?A2EyBgCQ5UJbh8mZ6ERcGgEBAQEBAgEBAQEIAQEBAYMbgQK?=
 =?us-ascii?q?BDSgKg3CUOIIHgziTdAuEbAIXghchOBQBAgEBAgEBAgEBAhABAQEKCwkIKS+CN?=
 =?us-ascii?q?SKCYQEBAQECASMROgMIBQcEAgEIEQQBAQECAiMDAgICRAECAQUIAgQBDQUIgxi?=
 =?us-ascii?q?BeAipEYIciEaBOoELh2OCFYEPgw+EXiMzgkeCVQKICZFGBwKPHIFKhA6IDYd9i?=
 =?us-ascii?q?hOBWIF0cFCCaYIkDgmOF28BjjWBGgEB?=
Received: from esa1.dell-outbound2.iphmx.com ([68.232.153.201])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 23:28:15 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 10:34:29 +0600
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.51,328,1526360400"; 
   d="scan'208";a="270350307"
X-DLP:  DLP_GlobalPCIDSS
To:     <srinivas.pandruvada@linux.intel.com>, <dvhart@infradead.org>,
        <andy.shevchenko@gmail.com>
CC:     <alex.hung@canonical.com>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>
Subject: RE: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Thread-Topic: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Thread-Index: AQHUDwyTs6nsEeHVokGyB9ujS48v7KR3cjWwgARzsgGAABHaIIAG9Ny+gAE6MACAAjcPYA==
Date:   Mon, 9 Jul 2018 04:38:16 +0000
Message-ID: <1dfb07bd3461414e8db492e643d7de88@ausx13mpc120.AMER.DELL.COM>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
         <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
         <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
         <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
         <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
         <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
         <20180706235907.GE3041@fury>
 <ccb18d853b254f680895c45862274ec8bdd70ab0.camel@linux.intel.com>
In-Reply-To: <ccb18d853b254f680895c45862274ec8bdd70ab0.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRh
IFttYWlsdG86c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IFNh
dHVyZGF5LCBKdWx5IDcsIDIwMTggODo0NCBBTQ0KPiBUbzogRGFycmVuIEhhcnQ7IEFuZHkgU2hl
dmNoZW5rbw0KPiBDYzogTGltb25jaWVsbG8sIE1hcmlvOyBBbGV4IEh1bmc7IEFuZHkgU2hldmNo
ZW5rbzsgUGxhdGZvcm0gRHJpdmVyOyBMaW51eCBLZXJuZWwNCj4gTWFpbGluZyBMaXN0OyBSYWZh
ZWwgSi4gV3lzb2NraQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBwbGF0Zm9ybS94ODY6IGlu
dGVsLWhpZDogQWRkIHN1cHBvcnQgZm9yIERldmljZSBTcGVjaWZpYw0KPiBNZXRob2RzDQo+IA0K
PiBPbiBGcmksIDIwMTgtMDctMDYgYXQgMTY6NTkgLTA3MDAsIERhcnJlbiBIYXJ0IHdyb3RlOg0K
PiA+IE9uIE1vbiwgSnVsIDAyLCAyMDE4IGF0IDA1OjA2OjE0UE0gKzAzMDAsIEFuZHkgU2hldmNo
ZW5rbyB3cm90ZToNCj4gPiA+IE9uIE1vbiwgSnVsIDIsIDIwMTggYXQgNDo1MSBQTSwgIDxNYXJp
by5MaW1vbmNpZWxsb0BkZWxsLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gPiA+
IFNvIHRoZXJlIGFyZSBzb21lIGN1c3RvbWVycyB3aG8gd2lsbCBoYXZlIGlzc3VlIHdpdGggcG93
ZXINCj4gPiA+ID4gPiA+IGJ1dHRvbg0KPiA+ID4gPiA+ID4gd2l0aG91dCB0aGlzIHBhdGNoLCBz
byBpdCBzaG91bGQgYmUgYWxzbyBtYXJrZWQgZm9yIHN0YWJsZQ0KPiA+ID4gPiA+ID4gYWxzby4N
Cj4gPiA+ID4gPiA+IEFsc28gdGhpcyBtYXkgYmUgYSBjYW5kaWRhdGUgZm9yIDQuMTgtcmNYLg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEknbSBub3Qgc3VyZSBHcmVnIHdpbGwg
dGFrZSB0aGlzIHNlbGxpbmcgcG9pbnQgZm9yIHJhdGhlciBiaWcNCj4gPiA+ID4gPiBwYXRjaC4N
Cj4gPiA+ID4gPiBGcm9tIGNoYW5nZWxvZywgaG9uZXN0bHksIEkgZG9uJ3Qgc2VlIGFueSByZWdy
ZXNzaW9uDQo+ID4gPiA+ID4gZGVzY3JpcHRpb24sDQo+ID4gPiA+ID4gbG9va3MgbGlrZSAiaXQg
d2Fzbid0IHdvcmtpbmcgYmVmb3JlIGNoYW5nZSBhbnl3YXkiLg0KPiA+ID4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IEp1c3QgZm9yIGFkZGluZyBzb21lIGNvbnRleHQuDQo+ID4gPiA+DQo+ID4gPiA+
IFNvbWUgcGxhdGZvcm1zIGhhdmUgbW92ZWQgdG8gZGlmZmVyZW50IGludGVyZmFjZSBpbiBBU0wg
aW4gRlcNCj4gPiA+ID4gdXBncmFkZQ0KPiA+ID4gPiBkdWUgdG8gZGVmaWNpZW5jaWVzL2J1Z3Mg
cHJlc2VudCB3aXRoIG9sZCBpbnRlcmZhY2UuICBTbyB5ZXMgaXQncw0KPiA+ID4gPiBwbGF0Zm9y
bSBGVw0KPiA+ID4gPiBjaGFuZ2UgaW4gYmVoYXZpb3IgdGhhdCBsZWFkcyB0byBMaW51eCBrZXJu
ZWwNCj4gPiA+ID4gcmVncmVzc2lvbi4gIFdpbmRvd3MgZHJpdmVyIGhhcyBzdXBwb3J0ZWQNCj4g
PiA+ID4gYm90aCBpbnRlcmZhY2VzIGZvciBhIGxvbmcgdGltZS4gIExpbnV4IGtlcm5lbCBob3dl
dmVyIGRvZXNuJ3QNCj4gPiA+ID4gc3VwcG9ydCB0aGlzIGludGVyZmFjZSB1bnRpbCBub3cuDQo+
ID4gPiA+DQo+ID4gPiA+ID4gRm9yIG5vdywgSSBwdXNoZWQgdGhpcyB0byBteSByZXZpZXcgYW5k
IHRlc3RpbmcgcXVldWUgYXMgaXMsDQo+ID4gPiA+ID4gdGhhbmtzIQ0KPiA+ID4gPg0KPiA+ID4g
PiBJZiBub3Qgc3RhYmxlIEkgdGhpbmsgaXQgd291bGQgYXQgbGVhc3QgYmUgaWRlYWwgdG8gdHJ5
IHRvIGJyaW5nDQo+ID4gPiA+IHRoaXMgdG8gNC4xOC1yY1ggaWYgcG9zc2libGUgZm9yDQo+ID4g
PiA+IGNvbXBhdGliaWxpdHkgd2l0aCBtb3JlIHBsYXRmb3JtcyB0aGF0IHdpbGwgY29tZSB3aXRo
IHRoaXMgb3RoZXINCj4gPiA+ID4gaW50ZXJmYWNlIGluc3RlYWQuDQo+ID4gPg0KPiA+ID4gQ2l0
aW5nIExpbnVzOg0KPiA+ID4NCj4gPiA+IC0tLSA4PCAtLS0gODwgLS0tDQo+ID4gPiBTbyBwbGVh
c2UsIHBlb3BsZSwgdGhlICJmaXhlcyIgZHVyaW5nIHRoZSByYyBzZXJpZXMgcmVhbGx5IHNob3Vs
ZA0KPiA+ID4gYmUNCj4gPiA+IHRoaW5ncyB0aGF0IGFyZSBfcmVncmVzc2lvbnNfLiBJZiBpdCB1
c2VkIHRvIHdvcmssIGFuZCBpdCBubyBsb25nZXINCj4gPiA+IGRvZXMsDQo+ID4gPiB0aGVuIGZp
eGluZyB0aGF0IGlzIGEgZ29vZCBhbmQgcHJvcGVyIGZpeC4gT3IgaWYgc29tZXRoaW5nIG9vcHNl
cw0KPiA+ID4gb3IgaGFzIGENCj4gPiA+IHNlY3VyaXR5IGltcGxpY2F0aW9uLCB0aGVuIHRoZSBm
aXggZm9yIHRoYXQgaXMgYSByZWFsIGZpeC4NCj4gPiA+DQo+ID4gPiBCdXQgaWYgaXQncyBzb21l
dGhpbmcgdGhhdCBoYXMgbmV2ZXIgd29ya2VkLCBldmVuIGlmIGl0ICJmaXhlcyINCj4gPiA+IHNv
bWUNCj4gPiA+IGJlaGF2aW9yLCB0aGVuIGl0J3MgbmV3IGRldmVsb3BtZW50LCBhbmQgdGhhdCBz
aG91bGQgY29tZSBpbiBkdXJpbmcNCj4gPiA+IHRoZQ0KPiA+ID4gbWVyZ2Ugd2luZG93LiBKdXN0
IGJlY2F1c2UgeW91IHRoaW5rIGl0J3MgYSAiZml4IiBkb2Vzbid0IG1lYW4gdGhhdA0KPiA+ID4g
aXQNCj4gPiA+IHJlYWxseSBpcyBvbmUsIGF0IGxlYXN0IGluIHRoZSAiZHVyaW5nIHRoZSByYyBz
ZXJpZXMiIHNlbnNlLg0KPiA+ID4gLS0tIDg8IC0tLSA4PCAtLS0NCj4gPiA+DQo+ID4gPiBTbywg
aWYgd2UgY2FuIHNlbGwgaGltIHRoYXQgaXQgdXNlZCB0byB3b3JrIGFuZCBmaXJtd2FyZSBmaXgg
aXMgYQ0KPiA+ID4gTGludXggcmVncmVzc2lvbiBJJ20gZmluZS4NCj4gPiA+DQo+ID4gPiBEYXJy
ZW4sIHdoYXQgZG8geW91IHRoaW5rPw0KPiA+DQo+ID4gU28gaWYgSSB1bmRlcnN0YW5kIHRoaXMg
Y29ycmVjdGx5LCB3ZSBoYXZlIHRoaXMgdGltZWxpbmUuDQo+ID4NCj4gPiBMaW51eCB2NC4xNg0K
PiA+IC0gTWFjaGluZSBBIHdvcmtzDQo+ID4gTGludXggdjQuMTcNCj4gPiAtIE1hY2hpbmUgQSB3
b3Jrcw0KPiA+IC0gTWFjaGluZSBBIHVwZGF0ZXMgZmlybXdhcmUNCj4gPiAtIE1hY2hpbmUgQSBz
dG9wcyB3b3JraW5nDQo+ID4gTGludXggdjQuMTgNCj4gPiAtIE1hY2hpbmUgQSBzdGlsbCBkb2Vz
bid0IHdvcmsNCj4gPg0KPiA+IFNvIGl0IGlzIG5vdCBhICpMaW51eCBrZXJuZWwqIHJlZ3Jlc3Np
b24uDQo+ID4NCj4gPiBUaGUgcGF0Y2ggaXMgdG9vIGxhcmdlIGZvciBzdGFuZGFyZCBzdGFibGUg
cnVsZXMuDQo+ID4NCj4gPiBJdCBpcyBhIHJlZ3Jlc3Npb24gZnJvbSBhbnkgdXNlcidzIHBlcnNw
ZWN0aXZlIC0gdGhlIG1hY2hpbmUgd29ya2VkLA0KPiA+IHRoZXkgZm9sbG93ZWQgZ29vZCBkaWdp
dGFsIGh5Z2llbmUgYW5kIHVwZGF0ZWQgdGhlaXIgZmlybXdhcmUsIGFuZA0KPiA+IG5vdw0KPiA+
IGl0IGRvZXNuJ3QuIFRoaXMgdXNlciB3aWxsIG5vdyB0aGluayB0d2ljZSBiZWZvcmUgdGhleSB1
cGRhdGUgdGhlaXINCj4gPiBCSU9TDQo+ID4gYWdhaW4sIHNpbmNlIGl0IG1heSBmdW5kYW1lbnRh
bGx5IGNoYW5nZSB0aGUgcGxhdGZvcm0sIHJhdGhlciB0aGFuDQo+ID4gY29tbWl0dGluZyB0byBv
bmx5IGZpeGluZyB0aGluZ3MgYmVsb3cgdGhlIE9TIEludGVyZmFjZSBsYXllci4gOi0oDQo+ID4N
Cj4gPiBUaGUgcmlzayBvZiBjb3Vyc2UgaXMgdGhhdCB0aGlzIGludHJvZHVjZXMgbmV3IGJ1Z3Mg
LSBhbmQgYXMgd2l0aA0KPiA+IGFueXRoaW5nIHRoYXQgc3RpbGwgdXNlcyBfRFNNIChzaWdoLCB3
aHk/KSB0aGF0IGlzIHF1aXRlIHBvc3NpYmxlIGR1ZQ0KPiA+IHRvDQo+ID4gdGhlIG9wYXF1ZSBp
bnRlcmZhY2UuIFZlcnkgdW5mb3J0dW5hdGUgdG8gc2VlIF9EU00gQURERUQgdG8gYQ0KPiA+IHBy
ZXZpb3VzbHkNCj4gPiBfRFNNIGZyZWUgaW1wbGVtZW50YXRpb24uIExpbnVzIGlzIHJpZ2h0LCB0
aGlzIGlzIG5vdCBhIGZpeCwgdGhpcyBpcw0KPiA+IGZlYXR1cmUgZGV2ZWxvcG1lbnQuDQo+ID4N
Cj4gPiBJIHN0cm9uZ2x5IGFkdm9jYXRlIGZvciB2ZW5kb3JzIHRvIGhhdmUgbW9yZSBjb250cm9s
IG92ZXIgdGhlaXINCj4gPiBkcml2ZXJzLA0KPiA+IGJ1dCB0aGlzIHNjZW5hcmlvIHJlYWxseSBm
cnVzdHJhdGVzIG1lLiBJIGRvbid0IHRoaW5rIEkgY2FuIGp1c3RpZnkNCj4gPiB0aGlzDQo+ID4g
dG8gTGludXMgYXMgYSBmaXguIEJ1dCBiZWZvcmUgd2UganVzdCBzYXkgIm5vIiAoYmVjYXVzZSBo
ZXksIEkgd2FudA0KPiA+IHRoZXNlIGZpeGVzIGF2YWlsYWJsZSBhcyBlYXJseSBhcyBwb3NzaWJs
ZSB0b28pLCBsZXQncyBhc2sgUmFmYWVsIGlmDQo+ID4gaGUNCj4gPiBoYXMgYW4gb3BpbmlvbiBv
ciBpZiB0aGVyZSBpcyBwcmVjZWRlbnQgZm9yIHRoaXMgaW4gaGlzIGV4cGVyaWVuY2UNCj4gPiB3
aXRoDQo+ID4gQUNQSSBkcml2ZXJzIGluIGdlbmVyYWw6DQo+ID4NCj4gPiBSYWZhZWw/DQo+ID4N
Cj4gPiBGaW5hbGx5LCB3ZSBjYW4gYWxzbyBqdXN0IGFzayBMaW51cy4gVGhlIGZpcm13YXJlIHVw
ZGF0ZSBicm9rZSB0aGUNCj4gPiBwb3dlcg0KPiA+IGJ1dHRvbiwgd2UgY2FuIGdldCBpdCB3b3Jr
aW5nIGFnYWluIGJ5IHN1cHBvcnRpbmcgdGhlIG5ldyBBUEkgd2l0aA0KPiA+IHRoaXMNCj4gPiBw
YXRjaC4uLiBzZWUgd2hhdCBoZSBzYXlzLg0KDQo+IE1hcmlvIGNhbiBhZGQgbW9yZS4NCj4gQnV0
IEkgdGhpbmsgRGVsbCBoYXMgcmVsZWFzZWQgYSBCSU9TIGZpeCwgc28gdGhhdCBwb3dlciBidXR0
b24gY2FuDQo+IHN0aWxsIHdvcmsgdXNpbmcgbm9uIF9EU00gd2F5LiBTbyBJIHRoaW5rIHdlIGNh
biB3YWl0IGZvciBub3JtYWwNCj4gcmVsZWFzZSBjeWNsZS4NCg0KWWVhaCwgSSBhZGRlZCBzb21l
IGNvbW1lbnRzIG9uIGEgc2VwYXJhdGUgcmVwbHkgYWxyZWFkeSBpbmRpY2F0aW5nIHRoaXMuDQoN
ClRoZSBhZmZlY3RlZCBzeXN0ZW0gd2Uga25vdyBhYm91dCBoYXMgcmV2ZXJ0ZWQgdGhlIG5ldyBp
bnRlcmZhY2UuDQoNClRoaXMgYWxsIHN0ZW1zIGZyb20gYW4gZXhwZWN0YXRpb24gdGhhdCB0aGUg
X0RTTSBoYXMgYmVlbiB0aGVyZSBmb3IgIm1hbnkiDQpyZWxlYXNlcyBvbiB0aGUgV2luZG93cyBz
aWRlLiAgTG9uZyBlbm91Z2ggdGhhdCBldmVuIGFsbCB0aGUgY29ycG9yYXRlIGRvd25ncmFkZQ0K
c2NlbmFyaW9zIHRvIG9sZGVyIFdpbmRvd3MgdmVyc2lvbnMgYW5kIHRoZSBkcml2ZXJzIHdpdGgg
dGhlbSBhbGwgd29ya2VkIHByb3Blcmx5Lg0KDQpJZiB0aGlzIGRvZXNuJ3QgZW5kIHVwIGJlaW5n
IGEgY2FuZGlkYXRlIGZvciBiYWNrcG9ydGluZyB0byBzdGFibGUgd2UnbGwgcHJvYmFibHkNCmVu
ZCB1cCBhc2tpbmcgb3VyIHZhcmlvdXMgT1MgcGFydG5lcnMgdG8gYmFja3BvcnQgaXQgYXMgYSBT
QVVDRSB0eXBlIHBhdGNoIGluIGRpc3Rybw0Ka2VybmVscyB0byBldmVudHVhbGx5IGJlIGFibGUg
dG8gdHVybiB0aGlzIGJhY2sgb24uDQo=
