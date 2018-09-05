Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D17C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9DF2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9DF2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIEVXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:23:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:31304 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeIEVXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:23:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 09:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="67782045"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2018 09:52:36 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 09:52:36 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.230]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.30]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 09:52:36 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] net: ethernet: i40e: fix build error
Thread-Topic: [PATCH v2 1/2] net: ethernet: i40e: fix build error
Thread-Index: AQHURMAOHuyMEikkN06R2JwEV2/dyqTh551A
Date:   Wed, 5 Sep 2018 16:52:35 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
In-Reply-To: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGI0NWZlOTQtODUwYS00MmNkLTg3MDYtNmVkMDc4OWUxMTE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYXBpMzRCeGZ3djlNYmRzRWJkRGw5Tm5JSlpPXC9kRkY2Y0hqSE91cTE4K28rNFNxK2FjWExYUjVsT3c3R0xTbDMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2FuZyBEb25nc2hlbmcg
W21haWx0bzpkb25nc2hlbmcud2FuZ0BoeHQtc2VtaXRlY2guY29tXQ0KPiBTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgMDQsIDIwMTggNzoyNyBQTQ0KPiBUbzogS2lyc2hlciwgSmVmZnJleSBUIDxq
ZWZmcmV5LnQua2lyc2hlckBpbnRlbC5jb20+Ow0KPiBzZXJnZWkuc2h0eWx5b3ZAY29nZW50ZW1i
ZWRkZWQuY29tDQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNv
bT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGludGVsLQ0KPiB3aXJlZC1sYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFdhbmcgRG9uZ3NoZW5nIDxkb25nc2hlbmcud2FuZ0BoeHQtDQo+IHNlbWl0ZWNoLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIHYyIDEvMl0gbmV0OiBldGhlcm5ldDogaTQwZTogZml4IGJ1
aWxkIGVycm9yDQo+IA0KPiBSZW1vdmUgImlubGluZSIgZnJvbSBfX2k0MGVfYWRkX3N0YXRfc3Ry
aW5ncy4NCj4gDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pNDBlL2k0MGVfZXRodG9vbC5jOjk6MDoNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaTQwZS9pNDBlX2V0aHRvb2wuYzogSW4gZnVuY3Rpb24NCj4g4oCYX19pNDBlX2FkZF9z
dGF0X3N0cmluZ3PigJk6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9l
dGh0b29sX3N0YXRzLmg6MTkzOjIwOiBlcnJvcjoNCj4gZnVuY3Rpb24g4oCYX19pNDBlX2FkZF9z
dGF0X3N0cmluZ3PigJkgY2FuIG5ldmVyIGJlIGlubGluZWQgYmVjYXVzZSBpdCB1c2VzDQo+IHZh
cmlhYmxlIGFyZ3VtZW50IGxpc3RzDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgX19pNDBlX2FkZF9z
dGF0X3N0cmluZ3ModTggKipwLCBjb25zdCBzdHJ1Y3QNCj4gCQkJCQkgICAgaTQwZV9zdGF0cyBz
dGF0c1tdLA0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53
YW5nQGh4dC1zZW1pdGVjaC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGZpeC4NCg0KQSBiaXQgb2Zm
IHRvcGljLCBidXQgdGhlc2UgdHdvIGZpbGVzIGluIHRoZSBpNDBlIGFuZCBpNDBldmYgc2hhcmUg
c29tZSBjb2RlLiBJcyB0aGVyZSBhIGdvb2QgbWVjaGFuaXNtIGZvciBzaGFyaW5nIHRoZXNlIGJl
dHdlZW4gdGhlIHR3byBkcml2ZXJzIHRoYXQgd291bGQgYWxsb3cgdGhlIG1vZHVsZXMgdG8gYmUg
aW5kZXBlbmRlbnQ/IFRoYXQgd291bGQgYmUgaWRlYWwuDQoNCkFja2VkLWJ5OiBKYWNvYiBLZWxs
ZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gdjI6DQo+IDEuIE1vdmUg
ZnVuY3Rpb24uDQo+IDIuIEluY2x1ZGUgYSBuZXcgcGF0Y2ggYXQgWzIvMl0uDQo+IA0KPiAtLS0N
Cj4gIC4uLi9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX2V0aHRvb2wuYyAgICB8IDI0ICsr
KysrKysrKysrKysrKysrKw0KPiAgLi4uL2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9ldGh0b29s
X3N0YXRzLmggIHwgMjUgKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
NiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfZXRodG9vbC5jDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX2V0aHRvb2wuYw0KPiBpbmRleCBkN2QzOTc0YmVj
YTIuLmY0YTcwZDY3YTgwYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaTQwZS9pNDBlX2V0aHRvb2wuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pNDBlL2k0MGVfZXRodG9vbC5jDQo+IEBAIC0xODIxLDYgKzE4MjEsMzAgQEAgc3RhdGljIHZv
aWQgaTQwZV9nZXRfZXRodG9vbF9zdGF0cyhzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqbmV0ZGV2LA0K
PiAgCQkgICJldGh0b29sIHN0YXRzIGNvdW50IG1pc21hdGNoISIpOw0KPiAgfQ0KPiANCj4gKy8q
Kg0KPiArICogX19pNDBlX2FkZF9zdGF0X3N0cmluZ3MgLSBjb3B5IHN0YXQgc3RyaW5ncyBpbnRv
IGV0aHRvb2wgYnVmZmVyDQo+ICsgKiBAcDogZXRodG9vbCBzdXBwbGllZCBidWZmZXINCj4gKyAq
IEBzdGF0czogc3RhdCBkZWZpbml0aW9ucyBhcnJheQ0KPiArICogQHNpemU6IHNpemUgb2YgdGhl
IHN0YXRzIGFycmF5DQo+ICsgKg0KPiArICogRm9ybWF0IGFuZCBjb3B5IHRoZSBzdHJpbmdzIGRl
c2NyaWJlZCBieSBzdGF0cyBpbnRvIHRoZSBidWZmZXIgcG9pbnRlZCBhdA0KPiArICogYnkgcC4N
Cj4gKyAqKi8NCj4gK3ZvaWQgX19pNDBlX2FkZF9zdGF0X3N0cmluZ3ModTggKipwLCBjb25zdCBz
dHJ1Y3QgaTQwZV9zdGF0cyBzdGF0c1tdLA0KPiArCQkJICAgICBjb25zdCB1bnNpZ25lZCBpbnQg
c2l6ZSwgLi4uKQ0KPiArew0KPiArCXVuc2lnbmVkIGludCBpOw0KPiArDQo+ICsJZm9yIChpID0g
MDsgaSA8IHNpemU7IGkrKykgew0KPiArCQl2YV9saXN0IGFyZ3M7DQo+ICsNCj4gKwkJdmFfc3Rh
cnQoYXJncywgc2l6ZSk7DQo+ICsJCXZzbnByaW50ZigqcCwgRVRIX0dTVFJJTkdfTEVOLCBzdGF0
c1tpXS5zdGF0X3N0cmluZywgYXJncyk7DQo+ICsJCSpwICs9IEVUSF9HU1RSSU5HX0xFTjsNCj4g
KwkJdmFfZW5kKGFyZ3MpOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAgKiBpNDBlX2dl
dF9zdGF0X3N0cmluZ3MgLSBjb3B5IHN0YXQgc3RyaW5ncyBpbnRvIHN1cHBsaWVkIGJ1ZmZlcg0K
PiAgICogQG5ldGRldjogdGhlIG5ldGRldiB0byBjb2xsZWN0IHN0cmluZ3MgZm9yDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfZXRodG9vbF9zdGF0
cy5oDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX2V0aHRvb2xfc3Rh
dHMuaA0KPiBpbmRleCBiYmExY2IwYjY1OGYuLjA4NzRjMzUyMTM2YSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX2V0aHRvb2xfc3RhdHMuaA0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfZXRodG9vbF9zdGF0cy5o
DQo+IEBAIC0xODEsMjkgKzE4MSw4IEBAIGk0MGVfYWRkX3F1ZXVlX3N0YXRzKHU2NCAqKmRhdGEs
IHN0cnVjdCBpNDBlX3JpbmcNCj4gKnJpbmcpDQo+ICAJKmRhdGEgKz0gc2l6ZTsNCj4gIH0NCj4g
DQo+IC0vKioNCj4gLSAqIF9faTQwZV9hZGRfc3RhdF9zdHJpbmdzIC0gY29weSBzdGF0IHN0cmlu
Z3MgaW50byBldGh0b29sIGJ1ZmZlcg0KPiAtICogQHA6IGV0aHRvb2wgc3VwcGxpZWQgYnVmZmVy
DQo+IC0gKiBAc3RhdHM6IHN0YXQgZGVmaW5pdGlvbnMgYXJyYXkNCj4gLSAqIEBzaXplOiBzaXpl
IG9mIHRoZSBzdGF0cyBhcnJheQ0KPiAtICoNCj4gLSAqIEZvcm1hdCBhbmQgY29weSB0aGUgc3Ry
aW5ncyBkZXNjcmliZWQgYnkgc3RhdHMgaW50byB0aGUgYnVmZmVyIHBvaW50ZWQgYXQNCj4gLSAq
IGJ5IHAuDQo+IC0gKiovDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgX19pNDBlX2FkZF9zdGF0X3N0
cmluZ3ModTggKipwLCBjb25zdCBzdHJ1Y3QgaTQwZV9zdGF0cyBzdGF0c1tdLA0KPiAtCQkJCSAg
ICBjb25zdCB1bnNpZ25lZCBpbnQgc2l6ZSwgLi4uKQ0KPiAtew0KPiAtCXVuc2lnbmVkIGludCBp
Ow0KPiAtDQo+IC0JZm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykgew0KPiAtCQl2YV9saXN0IGFy
Z3M7DQo+IC0NCj4gLQkJdmFfc3RhcnQoYXJncywgc2l6ZSk7DQo+IC0JCXZzbnByaW50ZigqcCwg
RVRIX0dTVFJJTkdfTEVOLCBzdGF0c1tpXS5zdGF0X3N0cmluZywgYXJncyk7DQo+IC0JCSpwICs9
IEVUSF9HU1RSSU5HX0xFTjsNCj4gLQkJdmFfZW5kKGFyZ3MpOw0KPiAtCX0NCj4gLX0NCj4gK3Zv
aWQgX19pNDBlX2FkZF9zdGF0X3N0cmluZ3ModTggKipwLCBjb25zdCBzdHJ1Y3QgaTQwZV9zdGF0
cyBzdGF0c1tdLA0KPiArCQkJICAgICBjb25zdCB1bnNpZ25lZCBpbnQgc2l6ZSwgLi4uKTsNCj4g
DQo+ICAvKioNCj4gICAqIDQwZV9hZGRfc3RhdF9zdHJpbmdzIC0gY29weSBzdGF0IHN0cmluZ3Mg
aW50byBldGh0b29sIGJ1ZmZlcg0KPiAtLQ0KPiAyLjE4LjANCg0K
