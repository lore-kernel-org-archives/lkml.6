Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBEAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DDD25DC7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="ZD9TlRUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DDD25DC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeGBNde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:33:34 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:28613 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752117AbeGBNdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1530538411; x=1562074411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5/UW/YIPGW5JjVfDWsi0Sy35UudPRxWlumDv6/9Uey8=;
  b=ZD9TlRUzIKl2eK+v5uXj7OcI2JquFifCTfnoOMq69+epg7uwzIpe9LvK
   ZNDm4CH5tc4HUeZznP98Cg6Jgdoez51ceND3vyX3GnPJHNegX6o8U4mCz
   wUlu918TlvrRUkgpyT0oWsf3Pe25Oxnn/oNLLVbZmA+eeQ1rJzrs3NERK
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EnAQDGKDpbmD+a6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQdgQ0oCoNvlECCB5Bvhi8LhGwCF4McITgUAQIBAQIBAQIBAQIQAQE?=
 =?us-ascii?q?BAQEICwsGKS+CNSKCYQEBAQEDIxFFDAQCAQgRBAEBAwIjAwICAkQBCAgCBAENB?=
 =?us-ascii?q?QiDGIIAp0qCHIhJgS6BC4dighWDaTWEQ4M4glUCmUYHAo8VjV0rkVyBWIF0cIM?=
 =?us-ascii?q?5gjIajgZvjxOBLoEaAQE?=
X-IPAS-Result: =?us-ascii?q?A2EnAQDGKDpbmD+a6ERcGgEBAQEBAgEBAQEIAQEBAYQdgQ0?=
 =?us-ascii?q?oCoNvlECCB5Bvhi8LhGwCF4McITgUAQIBAQIBAQIBAQIQAQEBAQEICwsGKS+CN?=
 =?us-ascii?q?SKCYQEBAQEDIxFFDAQCAQgRBAEBAwIjAwICAkQBCAgCBAENBQiDGIIAp0qCHIh?=
 =?us-ascii?q?JgS6BC4dighWDaTWEQ4M4glUCmUYHAo8VjV0rkVyBWIF0cIM5gjIajgZvjxOBL?=
 =?us-ascii?q?oEaAQE?=
Received: from esa3.dell-outbound2.iphmx.com ([68.232.154.63])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 08:33:31 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 19:28:38 +0600
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.51,299,1526360400"; 
   d="scan'208";a="1104718477"
X-DLP:  DLP_GlobalPCIDSS
To:     <colin.king@canonical.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-smbios-wmi: make function
 dell_smbios_wmi_call static
Thread-Topic: [PATCH] platform/x86: dell-smbios-wmi: make function
 dell_smbios_wmi_call static
Thread-Index: AQHUEGtXiG2hbxmxnk+xccRmPGi846R78Y8Q
Date:   Mon, 2 Jul 2018 13:33:29 +0000
Message-ID: <2ebb046f53e047e6aefc78c0f73594dc@ausx13mpc120.AMER.DELL.COM>
References: <20180630121024.18993-1-colin.king@canonical.com>
In-Reply-To: <20180630121024.18993-1-colin.king@canonical.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gS2luZyBbbWFp
bHRvOmNvbGluLmtpbmdAY2Fub25pY2FsLmNvbV0NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgMzAs
IDIwMTggNzoxMCBBTQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvOyBEYXJyZW4gSGFydDsgQW5k
eSBTaGV2Y2hlbmtvOyBwbGF0Zm9ybS1kcml2ZXItDQo+IHg4NkB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBwbGF0Zm9ybS94ODY6IGRlbGwtc21iaW9zLXdt
aTogbWFrZSBmdW5jdGlvbg0KPiBkZWxsX3NtYmlvc193bWlfY2FsbCBzdGF0aWMNCj4gDQo+IEZy
b206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGUg
ZnVuY3Rpb24gZGVsbF9zbWJpb3Nfd21pX2NhbGwgaXMgbG9jYWwgdG8gdGhlIHNvdXJjZSBhbmQg
ZG9lcyBub3QNCj4gbmVlZCB0byBiZSBpbiBnbG9iYWwgc2NvcGUsIHNvIG1ha2UgaXQgc3RhdGlj
Lg0KPiANCj4gQ2xlYW5zIHVwIHNwYXJzZSB3YXJuaW5nOg0KPiBzeW1ib2wgJ2RlbGxfc21iaW9z
X3dtaV9jYWxsJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4N
Cg0KU2FtZSB2YWluIGFzIHRoZSBvdGhlciBvbmUgb2YgdGhlc2UsIG1ha2VzIHNlbnNlIHRvIG1l
Lg0KDQpBY2tlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGRlbGwu
Y29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC1zbWJpb3Mtd21pLmMg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLXNtYmlvcy13bWku
YyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtDQo+IHNtYmlvcy13bWkuYw0KPiBpbmRleCBm
YmVmZWRiMWMxNzIuLjg4YWZlNTY1MWQyNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9y
bS94ODYvZGVsbC1zbWJpb3Mtd21pLmMNCj4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVs
bC1zbWJpb3Mtd21pLmMNCj4gQEAgLTgyLDcgKzgyLDcgQEAgc3RhdGljIGludCBydW5fc21iaW9z
X2NhbGwoc3RydWN0IHdtaV9kZXZpY2UgKndkZXYpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0K
PiAtaW50IGRlbGxfc21iaW9zX3dtaV9jYWxsKHN0cnVjdCBjYWxsaW5nX2ludGVyZmFjZV9idWZm
ZXIgKmJ1ZmZlcikNCj4gK3N0YXRpYyBpbnQgZGVsbF9zbWJpb3Nfd21pX2NhbGwoc3RydWN0IGNh
bGxpbmdfaW50ZXJmYWNlX2J1ZmZlciAqYnVmZmVyKQ0KPiAgew0KPiAgCXN0cnVjdCB3bWlfc21i
aW9zX3ByaXYgKnByaXY7DQo+ICAJc2l6ZV90IGRpZmZlcmVuY2U7DQo+IC0tDQo+IDIuMTcuMQ0K
DQo=
