Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD05C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F39624D84
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="lS5JOnAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F39624D84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeGBW45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:56:57 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:37821 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753312AbeGBW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1530571980; x=1562107980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+gDHFPAnK+pLzP+5k3pCNCJYIjYHD683GxO7bMf/Wo=;
  b=lS5JOnAWwhw42xrQU0vjYVchqeI2yN+YUPD8/NqNADDeFYQrVDjnz55F
   tlT0yoRq0Pp165+x8gY5xPJlxLHLta1d9a2P0TWCqzD7VCBCXJ2haflGl
   B9gxFA1EXXQyFoNKFkWeJAdwi9My67jPk1abA81SE3GSN4AsIL1r2Jqbl
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FfAAA4rDpbh8qZ6ERVBxkBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEHAQEBAQGEHQ5/KAqDb4gEjEE4gU+VJIE/OwsnB4Q+AheDHiE0GAECAQE?=
 =?us-ascii?q?CAQECAQECEAEBAQoLCQgpIwyCNSINBEsvCAEFAQEBAQEBAQEBIwEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBwINMxYBARgBAQEBAyMRRQwEAgE?=
 =?us-ascii?q?IEQQBAQECAiMDAgICRAECAQUIAgQBDQUIgxgBgX8PqFqCHIhTgTaBC4dighWBD?=
 =?us-ascii?q?4JhLoQ5JQgBCCIGgmSCVQKHP5IHBwKGBokPgguLUoozhEeDDYFBggtwUIJpCYI?=
 =?us-ascii?q?bDgkRgzSKUm8BjjgBASQDBIEBgRoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FfAAA4rDpbh8qZ6ERVBxkBAQEBAQEBAQEBAQEHAQEBAQG?=
 =?us-ascii?q?EHQ5/KAqDb4gEjEE4gU+VJIE/OwsnB4Q+AheDHiE0GAECAQECAQECAQECEAEBA?=
 =?us-ascii?q?QoLCQgpIwyCNSINBEsvCAEFAQEBAQEBAQEBIwEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBBwINMxYBARgBAQEBAyMRRQwEAgEIEQQBAQECAiMDA?=
 =?us-ascii?q?gICRAECAQUIAgQBDQUIgxgBgX8PqFqCHIhTgTaBC4dighWBD4JhLoQ5JQgBCCI?=
 =?us-ascii?q?GgmSCVQKHP5IHBwKGBokPgguLUoozhEeDDYFBggtwUIJpCYIbDgkRgzSKUm8Bj?=
 =?us-ascii?q?jgBASQDBIEBgRoBAQ?=
Received: from esa2.dell-outbound2.iphmx.com ([68.232.153.202])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 17:52:59 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 04:56:03 +0600
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.51,300,1526360400"; 
   d="scan'208";a="1104905915"
X-DLP:  DLP_GlobalPCIDSS
To:     <srinivas.pandruvada@linux.intel.com>, <hdegoede@redhat.com>,
        <tj@kernel.org>
CC:     <rjw@rjwysocki.net>, <alan.cox@intel.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: RE: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Thread-Topic: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Thread-Index: AQHUEjgfcJkNEdNy4UGaBW/ApKAq4aR8tACAgAASN4CAAAukgP//slFA
Date:   Mon, 2 Jul 2018 22:56:51 +0000
Message-ID: <67e158af5f8e4fe6b3cbaa3472447335@ausx13mpc120.AMER.DELL.COM>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
         <20180702202151.GK533219@devbig577.frc2.facebook.com>
         <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
 <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
In-Reply-To: <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRh
IFttYWlsdG86c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IE1v
bmRheSwgSnVseSAyLCAyMDE4IDU6MDkgUE0NCj4gVG86IEhhbnMgZGUgR29lZGU7IFRlanVuIEhl
bw0KPiBDYzogcmp3QHJqd3lzb2NraS5uZXQ7IGFsYW4uY294QGludGVsLmNvbTsgbGludXgtaWRl
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXBtQHZnZXIua2VybmVsLm9yZzsgTGltb25jaWVsbG8sIE1hcmlvDQo+IFN1YmplY3Q6IFJlOiBb
UkZDIFBBVENIXSBhdGE6IGFoY2k6IEVuYWJsZSBERVZTTFAgYnkgZGVmYXVsdCBvbiB4ODYgbW9k
ZXJuDQo+IHN0YW5kYnkgcGxhdGZvcm0NCj4gDQo+IEhpIEhhbnMsDQo+IA0KPiBPbiBNb24sIDIw
MTgtMDctMDIgYXQgMjM6MjcgKzAyMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+ID4gSGksDQo+
ID4NCj4gPiBPbiAwMi0wNy0xOCAyMjoyMSwgVGVqdW4gSGVvIHdyb3RlOg0KPiA+ID4gT24gTW9u
LCBKdWwgMDIsIDIwMTggYXQgMTI6MDg6NDVQTSAtMDcwMCwgU3Jpbml2YXMgUGFuZHJ1dmFkYQ0K
PiA+ID4gd3JvdGU6DQo+ID4gPiA+IEZyb206IFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRh
QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gT25lIG9mIHRoZSByZXF1aXJlbWVu
dCBmb3IgbW9kZXJuIHg4NiBzeXN0ZW0gdG8gZW50ZXIgbG93ZXN0DQo+ID4gPiA+IHBvd2VyIG1v
ZGUNCj4gPiA+ID4gKFNMUF9TMCkgaXMgU0FUQSBJUCBibG9jayB0byBiZSBvZmYuIFRoaXMgaXMg
dHJ1ZSBldmVuIGR1cmluZw0KPiA+ID4gPiB3aGVuDQo+ID4gPiA+IHBsYXRmb3JtIGlzIHN1c3Bl
bmRlZCB0byBpZGxlIGFuZCBub3Qgb25seSBpbiBvcHBvcnR1bmlzdGljDQo+ID4gPiA+IChydW50
aW1lKQ0KPiA+ID4gPiBzdXNwZW5kLg0KPiA+ID4gPg0KPiA+ID4gPiBTZXZlcmFsIG9mIHRoZXNl
IHN5c3RlbSBkb24ndCBoYXZlIHRyYWRpdGlvbmFsIEFDUEkgUzMsIHNvIGl0IGlzDQo+ID4gPiA+
IGltcG9ydGFudCB0aGF0IHRoZXkgZW50ZXIgU0xQX1MwIHN0YXRlLCB0byBhdm9pZCBkcmFpbmlu
ZyBiYXR0ZXJ5DQo+ID4gPiA+IGV2ZW4NCj4gPiA+ID4gZHVyaW5nIHN1c3BlbmQgZXZlbiB3aXRo
IG91dCBvZiB0aGUgYm94IExpbnV4IGluc3RhbGxhdGlvbi4NCj4gPg0KPiA+IFF1ZXN0aW9uIGNh
biBzeXN0ZW1zIHdoaWNoIGRvIGhhdmUgUzMgbm90IGFsc28gZW50ZXIgU0xQX1MwIHN0YXRlDQo+
ID4gZHVyaW5nDQo+ID4gbm9ybWFsIG9wZXJhdGlvbiB0byBzYXZlIHBvd2VyPw0KPiBTMyBzeXN0
ZW1zIGRvbid0IGVudGVyIFNMUF9TMC4gV2hlbiBpbiBzdXNwZW5kIHZpYSBTMyBhbGwgZGV2aWNl
cyBhcmUNCj4gc2ltcGx5IHR1cm4gb2ZmIGFsbCBleGNlcHQgc29tZSBmb3Igd2FrZXVwLg0KPiAN
Cj4gPg0KPiA+IEkgZ3Vlc3MgdGhlIGNoYW5nZSBvZiB0aGF0IGhhcHBlbmluZyB3aXRob3V0IGJl
aW5nIGluIGEgc3VzcGVuZCBsaWtlDQo+ID4gc3RhdGUNCj4gPiAoc2NyZWVuIHR1cm5lZCBvZmYs
IGV0YyksIGlzIHZlcnkgc21hbGwgYmVjYXVzZSB0aGVyZSB3aWxsIGFsd2F5cyBiZQ0KPiA+IHNv
bWV0aGluZyBibG9ja2luZyBlbnRlcmluZyBvZiBTTFBfUzAsIHNvIHRoYXQgaXQgaXMgbm90IHdv
cnRoDQo+ID4gYm90aGVyaW5nIGxvb2tpbmcgaW50byBTTFBfUzAgb24gc3lzdGVtcyB3aGljaCB1
c2UgUzMgZm9yIHN1c3BlbmQgPw0KPiA+DQo+IFNMUF9TMCBpcyBzdXNwZW5kIGxpa2Ugc3RhdGUg
d2l0aG91dCBiaWcgZXhpdCBsYXRlbmN5LiBUbyBhY2hpZXZlIHRoaXMNCj4gc3RhdGUgdGhlIElQ
IGJsb2NrcywgY2xvY2tzIGFuZCB2b2x0YWdlIHJhaWxzIG5lZWRzIHRvIGJlIGluIGNlcnRhaW4N
Cj4gcHJlZGVmaW5lZCBzdGF0ZS4gSWYgYW55b25lIG9mIHRob3NlIGNvbnN0cmFpbnRzIG5vdCBt
ZXQsIHRoZSBzeXN0ZW0NCj4gd2lsbCBub3QgcmVhY2ggdGhpcyBzdGF0ZS4gVW5saWtlIFMzLCB3
ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IGRldmljZXMNCj4gcmVhY2ggcmlnaHQgc3VzcGVuZCBz
dGF0ZS4gSW4gUzMgd2Ugd291bGRuJ3QgaGF2ZSBjYXJlZCBtdWNoLCBhcw0KPiBCSU9TL0FDUEkg
d2lsbCB0YWtlIGFjdGlvbiBhbmQgdHVybiBvZmYgYW55d2F5Lg0KPiBJZiB5b3UgYWNoaWV2ZSBT
TFBfUzAsIHRoZSBwb3dlciB3aWxsIGJlIGxvd2VyIG9yIGVxdWFsIHRvIFMzIGJ1dCB3aWxsDQo+
IGJlIGltbWVkaWF0ZWx5IGFibGUgdG8gcmVzdW1lLg0KPiANCj4gDQo+ID4gPiA+IFNBVEEgSVAg
YmxvY2sgZG9lc24ndCBnZXQgdHVybmVkIG9mZiB0aWxsIFNBVEEgaXMgaW4gREVWU0xQIG1vZGUu
DQo+ID4gPiA+IEhlcmUNCj4gPiA+ID4gdXNlciBoYXMgdG8gZWl0aGVyIHVzZSBzY3NpLWhvc3Qg
c3lzZnMgb3IgdG9vbHMgbGlrZSBwb3dlcnRvcCB0bw0KPiA+ID4gPiBzZXQNCj4gPiA+ID4gdGhl
IHNhdGEtaG9zdCBsaW5rX3Bvd2VyX21hbmFnZW1lbnRfcG9saWN5IHRvIG1pbl9wb3dlci4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhpcyBjaGFuZ2Ugc2V0cyBieSBkZWZhdWx0IGxpbmsgcG93ZXIgbWFu
YWdlbWVudCBwb2xpY3kgdG8NCj4gPiA+ID4gbWluX3Bvd2VyDQo+ID4gPiA+IGZvciBzb21lIHBs
YXRmb3Jtcy4gIFRvIGF2b2lkIHJlZ3Jlc3Npb25zLCB0aGUgZm9sbG93aW5nDQo+ID4gPiA+IGNv
bmRpdGlvbnMNCj4gPiA+ID4gYXJlIHVzZWQ6DQo+ID4gPiA+IC0gVGhlIGtlcm5lbCBjb25maWcg
aXMgYWxyZWFkeSBzZXQgdG8gdXNlIG1lZF9wb3dlcl93aXRoX2RpcG0gb3INCj4gPiA+ID4gZGVl
cGVyDQo+ID4gPiA+IC0gU3lzdGVtIGlzIGEgbW9kZXJuIHN0YW5kYnkgc3lzdGVtIHVzaW5nIEFD
UEkgbG93IHBvd2VyIGlkbGUNCj4gPiA+ID4gZmxhZw0KPiA+ID4gPiAtIFRoZSBwbGF0Zm9ybSBp
cyBub3QgYmxhY2tsaXN0ZWQgZm9yIFN1c3BlbmQgdG8gSWRsZSBhbmQgc3VzcGVuZA0KPiA+ID4g
PiB0byBpZGxlIGlzIHVzZWQgaW5zdGVhZCBvZiBTMw0KPiA+ID4gPiBUaGlzIGNvbWJpbmF0aW9u
IHdpbGwgbWFrZSBzdXJlIHRoYXQgc3lzdGVtcyBhcmUgZmFpcmx5IHJlY2VudA0KPiA+ID4gPiBh
bmQNCj4gPiA+ID4gc2luY2UgZ2V0dGluZyBzaGlwcGVkIHdpdGggbW9kZXJuIHN0YW5kYnkgc3Rh
bmRieSwgdGhlIERFVlNMUA0KPiA+ID4gPiBmdW5jdGlvbg0KPiA+ID4gPiBpcyBhbHJlYWR5IHZh
bGlkYXRlZC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXMgUGFuZHJ1
dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnQNCj4gPiA+ID4gZWwuY29tPg0KPiA+
ID4NCj4gPiA+IFNlZW1zIHNhbmUgdG8gbWUuICBIYW5zLCB3aGF0IGRvIHlvdSB0aGluaz8NCj4g
Pg0KPiA+IEkgdGhpbmsgdGhpcyBpcyBnb2luZyBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uLCBidXQg
bWluX3Bvd2VyIGVuYWJsZXMNCj4gPiBib3RoIERFVlNMUCBhbmQgSElQTSwgQUZBSUsgV2luZG93
cyBhdCBsZWFzdCBpbiB0aGUgcGFzdCBkaWQgbm90DQo+ID4gZW5hYmxlIEhJUE0gYmUgZGVmYXVs
dC4NCj4gDQo+IFdpbmRvd3MgYW5kIExpbnV4IHdpbGwgbmVlZCB0byBtZWV0IHRoZSBzYW1lIGNy
aXRlcmlhIHRvIHJlYWNoIFNMUF9TMA0KPiBzdGF0ZS4gT1MgaXMgbm90IGRlY2lkaW5nIHdoZXRo
ZXIgd2UgbWVldCBjcml0ZXJpYSBvciBub3QsIGl0IGlzDQo+IGZpcm13YXJlIGRlY2lkaW5nLCBh
bmQgaXQgd2lsbCBsb29rIGZvciBTQVRBIElQIHRvIGJlIGluIGNlcnRhaW4NCj4gcHJlZGVmaW5l
ZCBzdGF0ZSwgYmVmb3JlIGdlbmVyYXRpbmcgdGhpcyBTTFBfUzAgc2lnbmFsLg0KPiANCj4gDQo+
ID4gU3Jpbml2YXMgY2FuIHlvdSBmaWd1cmUgb3V0IHdoYXQgV2luZG93cyBkb2VzIHdydCBISVBN
Pw0KPiANCj4gV2UgY2FuIHNlZSB0aGF0IHVuZGVyIFdpbmRvd3MgdGhlIFNBVEEgcmFpbCB2b2x0
YWdlIGlzIGRyb3BwZWQuIEkgZG9uJ3QNCj4ga25vdyBpZiB0aGVyZSBpcyBhbnkgb3RoZXIgbWV0
aG9kIG90aGVyIHRoYW4gREVWU0xQIGNvbmZpZ3VyYXRpb24uIEJ1dA0KPiBJIHdpbGwgc3VyZWx5
IGNoZWNrIGFyb3VuZC4NCg0KU29tZXRoaW5nIHRvIGtlZXAgaW4gbWluZCBpcyB0aGF0IG9uIFdp
bmRvd3MgbW9zdCBzeXN0ZW1zIGFyZSBzaGlwcGVkDQp3aXRoIFJBSUQgT04gcmF0aGVyIHRoYW4g
QUhDSS4gIFNvIFdpbmRvd3MgZGVmYXVsdHMgZm9yIEFIQ0kgbGluayBwb3dlciBtYW5hZ2VtZW50
DQpjYW4ndCBhcHBseSBpbiB0aGUgUkFJRCBPTiBjYXNlLiAgSXQgd291bGQgcmF0aGVyIGJlIElu
dGVsIFJTVCBkcml2ZXIgYmVoYXZpb3JzDQpmb3IgaG93IGl0IGludGVybmFsbHkgbWFuYWdlcyBE
SVBNICwgSElQTSwgREVWU0xFRVAuDQoNClNvIEkgY2hlY2tlZCBhIGZldyB0aGluZ3MgdG9kYXku
DQoNCjEpIE9uIGEgc3lzdGVtIHdpdGggbW9kZXJuIHN0YW5kYnkgd2l0aCBTQVRBIFNTRCBzZXQg
dG8gQUhDSTsgbGluayBwb3dlciBtYW5hZ2VtZW50DQppc24ndCBldmVuIGV4cG9zZWQgaW4gcG93
ZXIgb3B0aW9ucyBHVUkuIChNYXliZSB0byBwcmV2ZW50IHByb2JsZW1zIHdpdGggU0xQUzA/KQ0K
SSBkaWRuJ3Qgc2VlIGl0IGluIHBvd2VyY2ZnIC9xICh3aGljaCBpcyBzdXBwb3NlZCB0byBsaXN0
IGNvbmZpZ3VyYWJsZSBvcHRpb25zIHRvbykNCg0KSSBmb3VuZCBvdXQgaG93IHRvIHVuaGlkZSBp
dCB3aXRoIHBvd2VyY2ZnIGFuZCBhZnRlciB1bmhpZGluZyBpdCBJIGZvdW5kIHRoYXQgdGhpcyBp
cyB0aGUNCm9wdGlvbiBleHBvc2VkOg0KaHR0cHM6Ly9kb2NzLm1pY3Jvc29mdC5jb20vZW4tdXMv
d2luZG93cy1oYXJkd2FyZS9jdXN0b21pemUvcG93ZXItc2V0dGluZ3MvZGlzay1zZXR0aW5ncy1s
aW5rLXBvd2VyLW1hbmFnZW1lbnQtbW9kZS0tLWhpcG0tZGlwbQ0KDQpJdCdzIGdvdCA1IGluZGV4
ZXM6DQpBY3RpdmUsDQpISVBNDQpISVBNK0RJUE0NCkRJUE0NCkxvd2VzdA0KDQoyKSBXaXRoIHNv
bWUgaW50ZXJuYWwgZm9sa3MgYW5kIHRoZXkgdGVsbCBtZSB0aGF0IEhJUE0gYW5kIERJUE0gYXJl
IGRlZmF1bHRpbmcNCm9uIHdpdGggUlNUIGRyaXZlciwgaG93ZXZlciB0aGlzIGNhbiBiZSBjaGFu
Z2VkIHdpdGggcmVnaXN0cnkga2V5IGFzIG5lY2Vzc2FyeS4NCg0KPiANCj4gDQo+ID4gV2UgbWF5
IG5lZWQgYSBuZXcgbWVkX3Bvd2VyX3dpdGhfZGlwbV9hbmRfZGV2c2xwIGxldmVsIGlmIHdpbmRv
d3MNCj4gPiBkb2VzDQo+ID4gbm90IGVuYWJsZSBISVBNIGJ5IGRlZmF1bHQgb24gdGhlc2Ugc3lz
dGVtcy4gSW4gaGluZCBzaWdodCB3ZSByZWFsbHkNCj4gPiBzaG91bGQgaGF2ZSBzZXBhcmF0ZSBi
b29scyBmb3IgZWFjaCwgcmF0aGVyIHRoZW4gY29kaW5nIHRoaXMgaW4NCj4gPiBhIHNpbmdsZSBs
ZXZlbCwgYWggd2VsbC4NCj4gQWdyZWUuIFdlIGNhbiBjZXJ0YWlubHkgZG8gdGhpcyBmb3IgZXZl
biBzYWZlciBpbXBsZW1lbnRhdGlvbi4NCg0KTWljcm9zb2Z0IGRvY3VtZW50YXRpb24gYWJvdmUg
ZG9lc24ndCBzZWVtIHRvIG1lbnRpb24gREVWU0xQIGJ1dCByYW5kb20gZm9ydW1zDQooaHR0cDov
L215d2luZG93c2h1Yi5jb20vYWRkLWFoY2ktbGluay1wb3dlci1tYW5hZ2VtZW50LWhpcG1kaXBt
LXBvd2VyLW9wdGlvbnMtd2luZG93cy0xMC8pDQpzZWVtIHRvIGluZGljYXRlIHRoYXQgTG93ZXN0
IGlzICJISVBNLCBESVBNIGFuZCBERVZTTFAiIChpZiBzdXBwb3J0ZWQgYnkgc3RvcmFnZSBkZXZp
Y2UpLg0KDQo=
