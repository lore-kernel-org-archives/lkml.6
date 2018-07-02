Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3C6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E9D25E4D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="x/rr5EWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E9D25E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeGBOHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:07:05 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:9157 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751535AbeGBOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1530540422; x=1562076422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDKJH0HIGJN30F8IqceHHk7ubLN2i8Dl+l7vh0fk4/g=;
  b=x/rr5EWqi58vKvFZ5G93knvXZkk86FvN9VKR97zxAI6ijX/jjc1GRUd9
   mmN2YVcSYORjnrxH6CUohp7ZQnc652SHx5UGG+ntedX38RXyVSui6GBTP
   sij4QeirmCjnmF9FHniN04YSf6GQGLGheawTys+UsEXdn1cga1E1dAftg
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EoAQADMTpbmD+a6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQdgQ0oCoNvlEKCB3WHOY0KgWYLhGwCF4McITgUAQIBAQIBAQIBAQI?=
 =?us-ascii?q?QAQEBAQEICwsGKS+CNSKCYQEBAQEDIxE6CwwEAgEIEQQBAQECAiMDAgICHyUBC?=
 =?us-ascii?q?AgCBAENBQiDGIFoAxWnW4Ichw4NgS6BLoELh2KCFYEPgloHLoJWgWgmLYJqglU?=
 =?us-ascii?q?CmRsrBwKMEoMDjV2LAocFgViBdHBQgmmCJA4JjhdvAZBAgRoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EoAQADMTpbmD+a6ERcGgEBAQEBAgEBAQEIAQEBAYQdgQ0?=
 =?us-ascii?q?oCoNvlEKCB3WHOY0KgWYLhGwCF4McITgUAQIBAQIBAQIBAQIQAQEBAQEICwsGK?=
 =?us-ascii?q?S+CNSKCYQEBAQEDIxE6CwwEAgEIEQQBAQECAiMDAgICHyUBCAgCBAENBQiDGIF?=
 =?us-ascii?q?oAxWnW4Ichw4NgS6BLoELh2KCFYEPgloHLoJWgWgmLYJqglUCmRsrBwKMEoMDj?=
 =?us-ascii?q?V2LAocFgViBdHBQgmmCJA4JjhdvAZBAgRoBAQ?=
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 09:07:01 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 19:57:03 +0600
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.51,299,1526360400"; 
   d="scan'208";a="1268782405"
X-DLP:  DLP_GlobalPCIDSS
To:     <andy.shevchenko@gmail.com>, <stuart.w.hayes@gmail.com>
CC:     <dvhart@infradead.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v3] dcdbas: Add support for WSMT ACPI table
Thread-Topic: [PATCH v3] dcdbas: Add support for WSMT ACPI table
Thread-Index: AQHUA+s4lznLK12+Q0uzCL8QOq9XaKRgVv6fgBdXLySAAFzYgIAEBPIQ
Date:   Mon, 2 Jul 2018 14:07:00 +0000
Message-ID: <e17fbb51b98d45318001adb7eb6a51b2@ausx13mpc120.AMER.DELL.COM>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
 <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
 <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
 <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com>
 <CAHp75VdSVLzNHnrOzzrBMf4X2Cg4QACRrnxKNkQzcYJ0h5W+tw@mail.gmail.com>
In-Reply-To: <CAHp75VdSVLzNHnrOzzrBMf4X2Cg4QACRrnxKNkQzcYJ0h5W+tw@mail.gmail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21h
aWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPiBTZW50OiBGcmlkYXksIEp1bmUgMjks
IDIwMTggMjozMCBQTQ0KPiBUbzogU3R1YXJ0IEhheWVzDQo+IENjOiBEYXJyZW4gSGFydDsgTGlt
b25jaWVsbG8sIE1hcmlvOyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0OyBQbGF0Zm9ybSBEcml2
ZXINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZGNkYmFzOiBBZGQgc3VwcG9ydCBmb3IgV1NN
VCBBQ1BJIHRhYmxlDQo+IA0KPiBPbiBGcmksIEp1biAyOSwgMjAxOCBhdCA5OjU2IFBNLCBTdHVh
cnQgSGF5ZXMgPHN0dWFydC53LmhheWVzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gT24gMDYvMjcv
MjAxOCAwNjo1MiBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+PiBPbiBGcmksIEp1biAx
NSwgMjAxOCBhdCAxOjMxIEFNLCBTdHVhcnQgSGF5ZXMgPHN0dWFydC53LmhheWVzQGdtYWlsLmNv
bT4NCj4gd3JvdGU6DQo+ID4+PiBPbiA2LzE0LzIwMTggMTI6MjUgUE0sIEFuZHkgU2hldmNoZW5r
byB3cm90ZToNCj4gPj4+PiBPbiBUaHUsIEp1biAxNCwgMjAxOCBhdCA1OjIyIFBNLCBTdHVhcnQg
SGF5ZXMgPHN0dWFydC53LmhheWVzQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4+Pj4+IE9uIDYv
MTMvMjAxOCAzOjU0IEFNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IA0KPiA+Pj4+IFRoYW5r
cywgYnV0IGhlcmUgSSBtZWFudCArPSAxIHZzICs9IDE2IHN0ZXAuDQo+IA0KPiA+IEkgZGlkIHJl
YWxpemUgdGhhdCB0aGUgZGVidWcgY29kZSB0aGF0IHByaW50ZWQgdGhlIGFkZHJlc3Mgb2YgdGhl
IEVQUyB0YWJsZSB3YXMgbm90DQo+ID4gd29ya2luZyByaWdodCwgYW5kIHRoZSB0YWJsZSBvbiBt
eSBzeXN0ZW0gaXMgYWN0dWFsbHkgMTYtYnl0ZSBhbGlnbmVkLiAgSG93ZXZlciwNCj4gPiB0aGUg
ZG9jdW1lbnRhdGlvbiBvbiB0aGUgRVBTIGRvZXMgbm90IHNwZWNpZnkgdGhhdCBpdCB3aWxsIGJl
IDE2LWJ5dGUgYWxpZ25lZCwgc28gSQ0KPiA+IGRvbid0IHRoaW5rIHRoZSBkcml2ZXIgc2hvdWxk
IG1ha2UgdGhhdCBhc3N1bXB0aW9uLCBlc3BlY2lhbGx5IHNpbmNlIHNjYW5uaW5nIGENCj4gNjRL
DQo+ID4gcmVnaW9uIGJ5dGUgYnkgYnl0ZSBzaG91bGQgdGFrZSB2ZXJ5IGxpdHRsZSBleHRyYSB0
aW1lIG92ZXIgc2Nhbm5pbmcgZXZlcnkgMTZ0aA0KPiBieXRlLg0KPiANCj4gPiBJIGd1ZXNzIHRo
aXMgaXNuJ3QgbmVlZGVkIHNpbmNlIHRoZSB0YWJsZSBvbiBteSBzeXN0ZW0gYWN0dWFsbHkgaXMg
MTYtYnl0ZSBhbGlnbmVkLg0KPiANCj4gSSB0aGluayB0aGUgMTYgYnl0ZSBpcyBhIG5hdHVyYWwg
YWxpZ25tZW50IGFwcGxpY2FibGUgdG8gYWxsIHRhYmxlcyBsaWtlIGEgc3VjaC4NCj4gSSB3b3Vs
ZCByYXRoZXIgZ28gd2l0aCBpdCB1bnRpbCB3ZSB3aWxsIGdldCBhICh3ZWlyZCkgQklPUyB3aGlj
aCBkb2VzDQo+IG5vdCBzdXBwb3J0IHRoYXQuDQo+IA0KPiAoSSBiZWxpZXZlIHRoaXMgYWxpZ25t
ZW50IGp1c3QgY29tZXMgYnkgZGVmaW5pdGlvbiBvZiBDIEFCSXMgZm9yIHRoZQ0KPiBzdHJ1Y3R1
cmVzIC8gdHlwZXMuIFNvLCBlYWNoIGRlZmluZWQgdHlwZSBpcyBsb2NhdGVkIG9uIGFuIGFsaWdu
ZWQNCj4gYm91bmRhcmllcykNCj4gDQo+ID4+PiBbIDQ2ODAuMTk0MDEyXSBkY2RiYXMgZGNkYmFz
OiBXU01UIGZvdW5kLCB1c2luZyBmaXJtd2FyZS1wcm92aWRlZCBTTUkNCj4gYnVmZmVyLg0KPiA+
Pj4gWyA0NjgwLjE5NTMyN10gZGNkYmFzIGRjZGJhczogRGVsbCBTeXN0ZW1zIE1hbmFnZW1lbnQg
QmFzZSBEcml2ZXIgKHZlcnNpb24NCj4gNS42LjAtMy4zKQ0KPiA+Pg0KPiA+PiBPSywgbm93IHRo
ZSBtb3N0IGltcG9ydGFudCBxdWVzdGlvbiwgZGlkIHlvdSBpbnZlc3RpZ2F0ZSAiU01NDQo+ID4+
IENvbW11bmljYXRpb24gQUNQSSBUYWJsZSI/DQo+ID4+IENhbiB5b3UgdXRpbGl6ZSBpbmZvcm1h
dGlvbiBpbiBpdD8NCj4gDQo+ID4gRGVsbCBCSU9TIGRvZXMgbm90IHByb3ZpZGUgYSAiU01NIENv
bW11bmljYXRpb24gQUNQSSBUYWJsZSIsIGp1c3QgdGhlIEVQUy4gIEl0DQo+IGFwcGVhcnMNCj4g
PiB0aGF0IHRoZSAiU01NIENvbW11bmljYXRpb24gQUNQSSBUYWJsZSIgaXMgZGVwcmVjYXRlZCBp
biB0aGUgVUVGSSAyLjcgc3BlYy4NCj4gQWxzbywgdGhlDQo+ID4gZGNkYmFzIGRyaXZlciBpcyBm
b3IgRGVsbCBzeXN0ZW1zIG9ubHkuDQo+IA0KPiA+IFRoZSBFUFMgdGFibGUgaXNuJ3QgYW4gQUNQ
SSB0YWJsZSwNCj4gPiBpdCdzIGp1c3QgYSBEZWxsLWRlZmluZWQgdGFibGUuDQo+IA0KPiBIbW0u
Li4gSXQncyBlaXRoZXIgc3RyYW5nZSBvciBoYXMgc29tZSBiYWNrZ3JvdW5kIHdoeSBpcyBzby4N
Cj4gT0sgaXQgaGFzIGEgbm90ZSB0aGF0IHRoZXJlIGlzIG5vIHVzZSBjYXNlLCBidXQgaGVyZSBp
dCBpcyENCj4gDQo+IE1hcmlvLCBjYW4gd2UgY29uc2lkZXIgdGhpcyBhcyBhIEJJT1MgYnVnIHdo
aWNoIGRvZXNuJ3QgcHJvdmlkZSBTTU0NCj4gQ29tbXVuaWNhdGlvbiBBQ1BJIHRhYmxlPw0KPiAN
Cj4gQ2FuIGl0IGJlIGVzY2FsYXRlZCBvbiBVRUZJIGNvbW1pdHRlZT8NCj4gDQoNCkkgZG9uJ3Qg
YmVsaWV2ZSBTTU0gY29tbXVuaWNhdGlvbiBBQ1BJIHRhYmxlIGhhcyBldmVyIGJlZW4gaW1wbGVt
ZW50ZWQgYnkgRGVsbA0Kb24gc2VydmVyIG9yIGNsaWVudCBCSU9TLiAgSSBkbyBhZ3JlZSB0aGlz
IHRhYmxlIGRlc2NyaWJlcyB0aGUgYmVoYXZpb3IgdGhhdCBEQ0RCQVMgZHJpdmVyDQpoYXMgdXNl
ZCBzaW5jZSBiZWZvcmUgZXZlbiBVRUZJIEJJT1MgcHJldHR5IGFjY3VyYXRlbHkuDQoNClN0dWFy
dCBhbmQgSSBkaWQgZGlzY3VzcyB3aXRoIHNlcnZlciBCSU9TICh3aG8gdXNlcyB0aGlzIEVQUyBt
ZWNoYW5pc20pIHRvIHNlZSBpZiBpdHMgcG9zc2libGUNCnRvIG1vdmUgRVBTIHRvIFNNTSBjb21t
dW5pY2F0aW9uIEFDUEkgdGFibGUgaG93ZXZlciBzaW5jZSBpdCdzIGJlZW4gZGVwcmVjYXRlZCBi
eQ0KVUVGSSAyLjcgdGhleSB3ZXJlbid0IHdpbGxpbmcgdG8gYWRvcHQgaXQuDQoNClN0dWFydCwg
YW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQgaGVyZT8NCg0K
