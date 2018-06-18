Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30787C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2C92083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="jgjOBnKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C92083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeFRNej (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:34:39 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:2809 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933557AbeFRNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1529328251; x=1560864251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MnJCrWmhb34D6tXAjkx+uYtfC13QuSbboMWY5Zjjtb0=;
  b=jgjOBnKYENbKA3tsO3JeCS/JVpkonnf8/O+yk/VP3OIopHTvh10Vwv/7
   JJG1ClDMBVaRW5cbPQ/QBLhv5FAg3D/HKShL9+eq4KepVbFGCUpgJ9E1z
   iJbgoiVaUPaXFc6hvLDn2f3JljFAY6UcpWJXeoc9TTitwbRNvAPUcBqeb
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EVAQDKsydbmMqZ6ERbGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQcgQ0oCoNvlFOBf5RxFIFkC4RsAheCRSE1FwECAQEBAQEBAgE?=
 =?us-ascii?q?BAhABAQEBAQgLCwYpL4I1IoJTAQEBAwEjBA1FDAQCAQgRBAEBAQICHwQDAgICR?=
 =?us-ascii?q?AEICAIEAQ0FCIMdgXkIqQGBaTOIQ4FogQuHSYITgQ+CXi6EOYM9glUCh0uGFIs?=
 =?us-ascii?q?3BwKPAYFHhACHfJFNgUMBgghwgxOCIQ4JEY4Gb483gRoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EVAQDKsydbmMqZ6ERbGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?cgQ0oCoNvlFOBf5RxFIFkC4RsAheCRSE1FwECAQEBAQEBAgEBAhABAQEBAQgLC?=
 =?us-ascii?q?wYpL4I1IoJTAQEBAwEjBA1FDAQCAQgRBAEBAQICHwQDAgICRAEICAIEAQ0FCIM?=
 =?us-ascii?q?dgXkIqQGBaTOIQ4FogQuHSYITgQ+CXi6EOYM9glUCh0uGFIs3BwKPAYFHhACHf?=
 =?us-ascii?q?JFNgUMBgghwgxOCIQ4JEY4Gb483gRoBAQ?=
Received: from esa2.dell-outbound2.iphmx.com ([68.232.153.202])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 08:24:10 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 19:32:49 +0600
X-LoopCount0: from 10.166.132.189
X-IronPort-AV: E=Sophos;i="5.51,239,1526360400"; 
   d="scan'208";a="1099380511"
X-DLP:  DLP_GlobalPCIDSS
To:     <mihai.dontu@gmail.com>, <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: wmi: usercopy: Kernel memory overwrite attempt detected to spans
 multiple pages (offset 0, size 4104)
Thread-Topic: wmi: usercopy: Kernel memory overwrite attempt detected to spans
 multiple pages (offset 0, size 4104)
Thread-Index: AQHUBnGu37oOk00VWkO1VLWd8OIH5qRmBQmQ
Date:   Mon, 18 Jun 2018 13:34:35 +0000
Message-ID: <00bb7cdf16034d2b8832bbc9f9ed284f@ausx13mpc120.AMER.DELL.COM>
References: <1529182886.3450.3.camel@gmail.com>
         <1529186697.2784.2.camel@gmail.com>
         <CAGXu5jLwA37YJWi50i7bQZ6N7MtctvbXjsVg337zgD11AQ=9SA@mail.gmail.com>
 <1529263827.6069.4.camel@gmail.com>
In-Reply-To: <1529263827.6069.4.camel@gmail.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwbGF0Zm9ybS1kcml2ZXIteDg2
LW93bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOnBsYXRmb3JtLWRyaXZlci14ODYtDQo+IG93
bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIE1paGFpIERvbj91DQo+IFNlbnQ6IFN1
bmRheSwgSnVuZSAxNywgMjAxOCAyOjMwIFBNDQo+IFRvOiBLZWVzIENvb2sNCj4gQ2M6IExLTUw7
IERhcnJlbiBIYXJ0OyBBbmR5IFNoZXZjaGVua287IFBsYXRmb3JtIERyaXZlcg0KPiBTdWJqZWN0
OiBSZTogd21pOiB1c2VyY29weTogS2VybmVsIG1lbW9yeSBvdmVyd3JpdGUgYXR0ZW1wdCBkZXRl
Y3RlZCB0byBzcGFucw0KPiBtdWx0aXBsZSBwYWdlcyAob2Zmc2V0IDAsIHNpemUgNDEwNCkNCj4g
DQo+IE9uIFN1biwgMjAxOC0wNi0xNyBhdCAxMDozNiAtMDcwMCwgS2VlcyBDb29rIHdyb3RlOg0K
PiA+IE9uIFNhdCwgSnVuIDE2LCAyMDE4IGF0IDM6MDQgUE0sIE1paGFpIERvbsibdSB3cm90ZToN
Cj4gPiA+IE9uIFN1biwgMjAxOC0wNi0xNyBhdCAwMDowMSArMDMwMCwgTWloYWkgRG9uyJt1IHdy
b3RlOg0KPiA+ID4gPiBXaGlsZSB0cnlpbmcgdG8gYWRqdXN0IHRoZSBrZXlib2FyZCBiYWNrbGln
aHQgbW9kZSwgSSBoaXQgdGhpcyBCVUc6DQo+ID4gPiA+DQo+ID4gPiA+IEp1biAxNiAyMjoxNjow
NyBtZG9udHUtbCBrZXJuZWw6IHVzZXJjb3B5OiBLZXJuZWwgbWVtb3J5IG92ZXJ3cml0ZSBhdHRl
bXB0DQo+IGRldGVjdGVkIHRvIHNwYW5zIG11bHRpcGxlIHBhZ2VzIChvZmZzZXQgMCwgc2l6ZSA0
MTA0KSENCj4gPg0KPiA+IENPTkZJR19IQVJERU5FRF9VU0VSQ09QWV9QQUdFU1BBTj15IGlzIHJl
YWxseSBvbmx5IHVzZWZ1bCBmb3INCj4gPiBkZWJ1Z2dpbmcgc3BlY2lhbCBjYXNlcy4gRm9yIG5v
dywgSSByZWNvbW1lbmQgbGVhdmluZyBpdCBkaXNhYmxlZCwNCj4gPiBzaW5jZSB0aGVyZSBhcmUg
YSBsb3Qgb2YgY2FzZXMgaXQgc3RpbGwgdHJpcHMgb3Zlci4NCj4gPg0KPiA+ID4gSSBldmVudHVh
bGx5IHNwcmlua2xlZCBzb21lIHByaW50ay1zIGFuZCBnb3QgdGhpczoNCj4gPiA+DQo+ID4gPiAg
ODU1ICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKGJ1ZiwgaW5wdXQsIHdibG9jay0+cmVxX2J1
Zl9zaXplKSkgew0KPiA+ID4gIDg1NiAgICAgICAgICAgICAgICAgZGV2X2RiZygmd2Jsb2NrLT5k
ZXYuZGV2LCAiQ29weSAlbGx1IGZyb20gdXNlciBmYWlsZWRcbiIsDQo+ID4gPiAgODU3ICAgICAg
ICAgICAgICAgICAgICAgICAgIHdibG9jay0+cmVxX2J1Zl9zaXplKTsNCj4gPiA+ICA4NTggICAg
ICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7DQo+ID4gPiAgODU5ICAgICAgICAgICAgICAgICBn
b3RvIG91dF9pb2N0bDsNCj4gPiA+ICA4NjAgICAgICAgICB9DQo+ID4NCj4gPiBIb3dldmVyLCBz
aW5jZSB5b3UgdHJhY2tlZCB0aGlzIG9uZSBkb3duLCBJIHRoaW5rIHRoaXMgd291bGQgYmUgZml4
ZWQNCj4gPiBieSBhZGp1c3RpbmcgdGhlIGhhbmRsZXJfZGF0YSBhbGxvY2F0aW9uOg0KPiA+DQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvd21pLmMgYi9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni93bWkuYw0KPiA+IGluZGV4IDhlM2QwMTQ2ZmY4Yy4uZWE2YmY5OGYxOTdh
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3dtaS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvd21pLmMNCj4gPiBAQCAtOTE4LDggKzkxOCw4IEBAIHN0YXRp
YyBpbnQgd21pX2Rldl9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICAgICAg
ICAgIH0NCj4gPg0KPiA+ICAgICAgICAgICAgICAgICBjb3VudCA9IGdldF9vcmRlcih3YmxvY2st
PnJlcV9idWZfc2l6ZSk7DQo+ID4gLSAgICAgICAgICAgICAgIHdibG9jay0+aGFuZGxlcl9kYXRh
ID0gKHZvaWQgKilfX2dldF9mcmVlX3BhZ2VzKEdGUF9LRVJORUwsDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvdW50
KTsNCj4gPiArICAgICAgICAgICAgICAgd2Jsb2NrLT5oYW5kbGVyX2RhdGEgPSAodm9pZCAqKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIF9fZ2V0X2ZyZWVfcGFnZXMoR0ZQX0tFUk5FTCB8
IF9fR0ZQX0NPTVAsIGNvdW50KTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKCF3YmxvY2stPmhh
bmRsZXJfZGF0YSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBwcm9iZV9mYWlsdXJlOw0KPiA+DQo+
IA0KPiBZb3VyIHBhdGNoIHdvcmtzIE9LIGZvciBtZSwgdGhhbmsgeW91LiBUaGUgbGlic21iaW9z
IHRvb2wsIGhvd2V2ZXIsIG5vdA0KPiBzbyBtdWNoLiBJdCBhcHBlYXJzIHRvIGJlIGJlaGluZCBs
YXRlc3QgZGV2ZWxvcG1lbnRzLg0KPiANCj4gIyBlY2hvICIra2V5Ym9hcmQiID4vc3lzL2NsYXNz
L2xlZHMvZGVsbFw6XDprYmRfYmFja2xpZ2h0L3N0YXJ0X3RyaWdnZXJzDQoNClBsZWFzZSBmZWVs
IGZyZWUgdG8gc2VuZCBhIFBSIHRvIGF1Z21lbnQgbGlic21iaW9zIHRvIHByZWZlciB0aGlzIHN5
c2ZzIGludGVyZmFjZQ0KaWYgaXQncyBwcmVzZW50IG92ZXIgdGhlIGRpcmVjdCBjb21tdW5pY2F0
aW9uIHBhdGguDQoNCj4gDQo+IGlzIGFsbCB0aGF0IGlzIG5lZWRlZCB0b2RheS4NCj4gDQo+IFJl
Z2FyZHMsDQo+IA0KPiA+IEJ1dCBpbiBsb29raW5nIGZ1cnRoZXIsIEkgZG9uJ3Qga25vdyB3aHkg
dGhpcyBpcyB1c2luZw0KPiA+IF9fZ2V0X2ZyZWVfcGFnZXMoKSBpbnN0ZWFkIG9mIGttYWxsb2M/
IEluIGZhY3QsIHRoZXJlIGlzIGEga2ZyZWUoKSBpbg0KPiA+IHRoZSBlcnJvciBwYXRoLCB3aGlj
aCBsb29rcyB3cm9uZzoNCj4gPg0KPiA+ICAgICAgICAga2ZyZWUod2Jsb2NrLT5oYW5kbGVyX2Rh
dGEpOw0KPiA+DQo+ID4gSSB0aGluayB0aGlzIHNob3VsZCBqdXN0IGJlIGNvbnZlcnRlZCB0byB1
c2luZyBrbWFsbG9jL2tmcmVlIGV2ZXJ5d2hlcmUuDQo+IA0KPiAtLQ0KPiBNaWhhaSBEb27Im3UN
Cg0K
