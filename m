Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0605C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAE42089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="lhMRKlXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAE42089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeGIEO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:14:57 -0400
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:32816 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750791AbeGIEOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1531109695; x=1562645695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sgd/HABpuQroxIUtXJtgSu1xOEEhQIt9jND9TQmLQMg=;
  b=lhMRKlXC4UMwoziUV7KQIFsE3Ghjg47Sw2g7I8Sjsa0+q6qMX5eAu3KB
   OCySw47nNDS+RmF3EicCIwxOJwLDjOrpMuwFOdmB7rtSRIC6ZhzESJ8IY
   yOLuwg5brVOp6viffHEC5AKv5nFxrBpjfcpEKKV/MnlszUPgPo8opj9Sn
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EeBgAa4EJbmD+a6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQdgQ0oCoNwlDiCB4M4hH6OdguEbAIXghchNxUBAgEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEBAQgLCwYpL4I1IoJhAQEBAQMjBA1FDAQCAQgRBAEBAQICIwMCAgIfJQEIC?=
 =?us-ascii?q?AIEAQ0FCIMYgWgDFakLgWkzhwsNgS6BOoELh2OCFYEPgw+CVoFtToJqglUCkWo?=
 =?us-ascii?q?EhzYrBwKMGYMDjWWLB4cJgVeBdXCDOYIkDgmOF2+NCIEugRoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EeBgAa4EJbmD+a6ERcGgEBAQEBAgEBAQEIAQEBAYQdgQ0?=
 =?us-ascii?q?oCoNwlDiCB4M4hH6OdguEbAIXghchNxUBAgEBAgEBAgEBAhABAQEBAQgLCwYpL?=
 =?us-ascii?q?4I1IoJhAQEBAQMjBA1FDAQCAQgRBAEBAQICIwMCAgIfJQEICAIEAQ0FCIMYgWg?=
 =?us-ascii?q?DFakLgWkzhwsNgS6BOoELh2OCFYEPgw+CVoFtToJqglUCkWoEhzYrBwKMGYMDj?=
 =?us-ascii?q?WWLB4cJgVeBdXCDOYIkDgmOF2+NCIEugRoBAQ?=
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 23:14:51 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 10:14:25 +0600
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.51,328,1526360400"; 
   d="scan'208";a="270345826"
X-DLP:  DLP_GlobalPCIDSS
To:     <pali.rohar@gmail.com>, <damien@dtbo.net>
CC:     <mjg59@srcf.ucam.org>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dell-laptop: Fix backlight detection
Thread-Topic: [PATCH] dell-laptop: Fix backlight detection
Thread-Index: AQHUFsy4Ladconfto0aqXabxGnEeR6SFwXsAgACHgJA=
Date:   Mon, 9 Jul 2018 04:14:50 +0000
Message-ID: <b8e9239fd2a74c1187aea671f89cd854@ausx13mpc120.AMER.DELL.COM>
References: <20180708170220.35f40818@anakin>
 <20180708150914.x4tpxbe5yq54hw6a@pali>
In-Reply-To: <20180708150914.x4tpxbe5yq54hw6a@pali>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYWxpIFJvaMOhciBbbWFpbHRv
OnBhbGkucm9oYXJAZ21haWwuY29tXQ0KPiBTZW50OiBTdW5kYXksIEp1bHkgOCwgMjAxOCA4OjA5
IEFNDQo+IFRvOiBEYW1pZW4gVGjDqWJhdWx0DQo+IENjOiBNYXR0aGV3IEdhcnJldHQ7IERhcnJl
biBIYXJ0OyBBbmR5IFNoZXZjaGVua287IExpbW9uY2llbGxvLCBNYXJpbzsgcGxhdGZvcm0tDQo+
IGRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRlbGwtbGFwdG9wOiBGaXggYmFja2xpZ2h0IGRldGVj
dGlvbg0KPiANCj4gT24gU3VuZGF5IDA4IEp1bHkgMjAxOCAxNzowMjoyMCBEYW1pZW4gVGjDqWJh
dWx0IHdyb3RlOg0KPiA+IEZpeCByZXR1cm4gY29kZSBjaGVjayBmb3IgIm1heCBicmlnaHRuZXNz
IiBBQ1BJIGNhbGwuDQo+ID4NCj4gPiBUaGUgZGVsbCBsYXB0b3AgQUNQSSB2aWRlbyBicmlnaHRu
ZXNzIGNvbnRyb2wgaXMgbm90IHByZXNlbnQgb24gZGVsbA0KPiA+IGxhcHRvcHMgYW55bW9yZSwg
YnV0IHdhcyBwcmVzZW50IGluIG9sZGVyIGtlcm5lbCB2ZXJzaW9ucy4NCj4gPg0KPiA+IFRoZSBj
b2RlIHRoYXQgY2hlY2tzIHRoZSByZXR1cm4gdmFsdWUgaXMgaW5jb3JyZWN0IHNpbmNlIHRoZSBT
TU0NCj4gPiByZWZhY3RvcmluZy4NCj4gPg0KPiA+IFRoZSBvbGQgY29kZSB3YXM6DQo+ID4gICBp
ZiAoYnVmZmVyLT5vdXRwdXRbMF0gPT0gMCkNCj4gPg0KPiA+IFdoaWNoIHdhcyBjaGFuZ2VkIHRv
Og0KPiA+ICAgcmV0ID0gZGVsbF9zZW5kX3JlcXVlc3QoLi4uKQ0KPiA+ICAgaWYgKHJldCkNCj4g
Pg0KPiA+IEhvd2V2ZXIsIGRlbGxfc2VuZF9yZXF1ZXN0KCkgd2lsbCByZXR1cm4gMCBpZiBidWZm
ZXItPm91dHB1dFswXSA9PSAwLA0KPiA+IHNvIHdlIG11c3QgY2hhbmdlIHRoZSBjaGVjayB0bzoN
Cj4gPiAgIGlmIChyZXQgPT0gMCkNCj4gDQo+IFlvdSBhcmUgcmlnaHQsIGRlbGxfc2VuZF9yZXF1
ZXN0KCkgcmV0dXJuIG5vbi16ZXJvIHZhbHVlIG9uIGVycm9yLg0KPiANCj4gPiBUaGlzIGlzc3Vl
IHdhcyBmb3VuZCBvbiBhIERlbGwgTTQ4MDAgbGFwdG9wLCBhbmQgdGhlIGZpeCB0ZXN0ZWQgb24g
aXQNCj4gPiBhcyB3ZWxsLg0KPiA+DQo+ID4gRml4ZXM6IDU0OWI0OTMwZjA1NyAoImRlbGwtc21i
aW9zOiBJbnRyb2R1Y2UgZGlzcGF0Y2hlciBmb3IgU01NIGNhbGxzIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEYW1pZW4gVGjDqWJhdWx0IDxkYW1pZW5AZHRiby5uZXQ+DQo+ID4gVGVzdGVkLWJ5OiBE
YW1pZW4gVGjDqWJhdWx0IDxkYW1pZW5AZHRiby5uZXQ+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
cGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMNCj4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2RlbGwtbGFwdG9wLmMgaW5kZXggZjFmYTg2MTJkYjQwLi4wNjk3OGMxNGM4M2INCj4gPiAxMDA2
NDQgLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC1sYXB0b3AuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtbGFwdG9wLmMNCj4gPiBAQCAtMjE4NSw3ICsyMTg1LDcg
QEAgc3RhdGljIGludCBfX2luaXQgZGVsbF9pbml0KHZvaWQpDQo+ID4gIAkJZGVsbF9maWxsX3Jl
cXVlc3QoJmJ1ZmZlciwgdG9rZW4tPmxvY2F0aW9uLCAwLCAwLCAwKTsNCj4gPiAgCQlyZXQgPSBk
ZWxsX3NlbmRfcmVxdWVzdCgmYnVmZmVyLA0KPiA+ICAJCQkJCUNMQVNTX1RPS0VOX1JFQUQsDQo+
ID4gU0VMRUNUX1RPS0VOX0FDKTsNCj4gPiAtCQlpZiAocmV0KQ0KPiA+ICsJCWlmIChyZXQgPT0g
MCkNCj4gPiAgCQkJbWF4X2ludGVuc2l0eSA9IGJ1ZmZlci5vdXRwdXRbM107DQo+ID4gIAl9DQo+
ID4NCj4gDQo+IFJldmlld2VkLWJ5OiBQYWxpIFJvaMOhciA8cGFsaS5yb2hhckBnbWFpbC5jb20+
DQo+IA0KDQpUaGFua3MgZm9yIHRoaXMgY2F0Y2guDQoNClJldmlld2VkLWJ5OiBNYXJpbyBMaW1v
bmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AZGVsbC5jb20+DQoNClRoaXMgc2hvdWxkIHByb2Jh
Ymx5IGdvIHRvIHN0YWJsZSBhcyB3ZWxsLg0K
