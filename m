Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8C9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361822154C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361822154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeHOXnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:43:52 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:1602 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHOXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:43:52 -0400
X-IronPort-AV: E=Sophos;i="5.53,244,1531810800"; 
   d="scan'208";a="18824971"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Aug 2018 13:50:04 -0700
Received: from CHN-SV-EXMX02.mchp-main.com ([fe80::7dfe:3761:863e:3963]) by
 CHN-SV-EXCH07.mchp-main.com ([::1]) with mapi id 14.03.0352.000; Wed, 15 Aug
 2018 13:50:04 -0700
From:   <Bryan.Whitehead@microchip.com>
To:     <arnd@arndb.de>
CC:     <UNGLinuxDriver@MicrochipTechnology.Mail.Onmicrosoft.com>,
        <davem@davemloft.net>, <yuehaibing@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <richardcochran@gmail.com>
Subject: RE: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Thread-Topic: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Thread-Index: AQHUNMCYlbXSpfUC+UKbWoa5lLa8NqTBGY5wgACgm4D//4t1kIAAd8UA//+LlJA=
Date:   Wed, 15 Aug 2018 20:50:03 +0000
Message-ID: <90A7E81AE28BAE4CBDDB3B35F187D2644073EA3B@CHN-SV-EXMX02.mchp-main.com>
References: <20180815175040.3736548-1-arnd@arndb.de>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073EA26@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a3guebtDLNhbQwNmA2nq=raKiP8ztGRpb03r0XD8h+ZNA@mail.gmail.com>
In-Reply-To: <CAK8P3a3guebtDLNhbQwNmA2nq=raKiP8ztGRpb03r0XD8h+ZNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiA+IFF1ZXN0aW9uOiB0aGlzIGlzIHRoZSBvbmx5IHB0cCBkcml2ZXIgdGhhdCBzZXRz
IHRoZSBoYXJkd2FyZQ0KPiA+ID4gPiA+IHRpbWUgdG8gdGhlIGN1cnJlbnQgc3lzdGVtIHRpbWUg
aW4gVEFJLiBXaHkgZG9lcyBpdCBkbyB0aGF0Pw0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGlzIGRv
bmUgd2hlbiB0aGUgZHJpdmVyIHN0YXJ0cyB1cCBhZnRlciByZXNldC4gT3RoZXJ3aXNlIHRoZQ0K
PiA+ID4gPiBjbG9jayBpcyBvZmYNCj4gPiA+IGJ5IDQ4IHllYXJzLg0KPiA+ID4gPiBJdCBzZWVt
ZWQgdG8gbWUgdGhhdCB0aGUgc3lzdGVtIHRpbWUgd2FzIHRoZSBtb3N0IGFwcHJvcHJpYXRlDQo+
ID4gPiA+IGNsb2NrIHRvDQo+ID4gPiBzeW5jIHRvLg0KPiA+ID4gPiBJZiBteSByZWFzb25pbmcg
aXMgaW5jb3JyZWN0LCBwbGVhc2UgZW5saWdodGVuIG1lLg0KPiA+ID4NCj4gPiA+IEkndmUgbmV2
ZXIgd29ya2VkIHdpdGggUFRQLCBidXQgbXkgdW5kZXJzdGFuZGluZyBmcm9tIGxvb2tpbmcgYXQg
dGhlDQo+ID4gPiBvdGhlciBkcml2ZXJzIGlzIHRoYXQgdGhlIHRpbWUgbm9ybWFsbHkgZ2V0cyBz
ZXQgZWl0aGVyIGZyb20gYW5vdGhlcg0KPiA+ID4gaG9zdCB0aHJvdWdoIHRoZSBQVFAgcHJvdG9j
b2wsIG9yIHVzaW5nIGNsb2NrX3NldHRpbWUoKSBmcm9tIHVzZXINCj4gPiA+IHNwYWNlIHdpdGgg
dGhlIGN1cnJlbnQgdGltZS4NCj4gPg0KPiA+IFRob3NlIG1ldGhvZHMgd2lsbCBzdGlsbCB3b3Jr
LiBCdXQgaWYgaXQncyBub3Qgc2V0IGJ5IHRob3NlIG1ldGhvZHMsIEkNCj4gPiB0aG91Z2h0IHRo
ZSBjbG9jayBzaG91bGQgYXQgbGVhc3QgYmUgc2V0IG9uY2Ugb24gZHJpdmVyIHN0YXJ0dXAgdG8g
YWxpZ24gd2l0aA0KPiB0aGUgc3lzdGVtIGNsb2NrLg0KPiA+IEFmdGVyIHRoYXQsIG90aGVyIG1l
dGhvZHMgYXJlIGZyZWUgdG8gcmVzZXQgaXQgYWdhaW4uDQo+IA0KPiAoYWRkaW5nIFJpY2hhcmQg
Q29jaHJhbiB0byBDYyBmb3IgbW9yZSBpbnNpZ2h0IGhlcmUpDQo+IA0KPiBJIHdvdWxkIGFyZ3Vl
IHRoYXQgaXQncyBtb3JlIGltcG9ydGFudCB0aGF0IHRoZSBkcml2ZXIgYmVoYXZlcyBsaWtlIGFs
bCBvdGhlcg0KPiBQVFAgaW1wbGVtZW50YXRpb25zLiBJZiB3ZSB3YW50IHRoZSBiZWhhdmlvciB0
byBiZSB0aGF0IHRoZSBpbml0aWFsIFBUUCB0aW1lDQo+IGlzIHNldCB0byB0aGUga3RpbWVfZ2V0
X2Nsb2NrdGFpX3RzNjQoKSB2YWx1ZSwgdGhlbiB0aGlzIHNob3VsZCBiZSBkb25lIGJ5IHRoZQ0K
PiBQVFAgY29yZSByYXRoZXIgdGhhbiB0aGUgZGV2aWNlIGRyaXZlci4gSWYgdGhlcmUgaXMgYSBn
b29kIHJlYXNvbiB0aGF0IHRoZQ0KPiBvdGhlciBkcml2ZXJzIGRvbid0IGRvIGl0IGxpa2UgdGhp
cywgdGhlbiBJIHdvdWxkIGFzc3VtZSB0aGUgc2FtZSByZWFzb24NCj4gYXBwbGllcyB0byBsYW43
NDN4Lg0KPiANCg0KU291bmRzIHJlYXNvbmFibGUgdG8gbWUuIEkgd2lsbCB5aWVsZCB0byBSaWNo
YXJkJ3MgaW5zaWdodC4NCkJ1dCBpdCB3b3VsZCBiZSBuaWNlIGlmIHJlcXVpcmVtZW50cyBsaWtl
IHRoZXNlIHdlcmUgZG9jdW1lbnRlZC4NCg0K
