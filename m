Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E940C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2121021545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2121021545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeHOXfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:35:09 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19329 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeHOXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:35:09 -0400
X-IronPort-AV: E=Sophos;i="5.53,244,1531810800"; 
   d="scan'208";a="17746854"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Aug 2018 13:41:23 -0700
Received: from CHN-SV-EXMX02.mchp-main.com ([fe80::7dfe:3761:863e:3963]) by
 CHN-SV-EXCH04.mchp-main.com ([::1]) with mapi id 14.03.0352.000; Wed, 15 Aug
 2018 13:41:23 -0700
From:   <Bryan.Whitehead@microchip.com>
To:     <arnd@arndb.de>
CC:     <UNGLinuxDriver@MicrochipTechnology.Mail.Onmicrosoft.com>,
        <davem@davemloft.net>, <yuehaibing@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Thread-Topic: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Thread-Index: AQHUNMCYlbXSpfUC+UKbWoa5lLa8NqTBGY5wgACgm4D//4t1kA==
Date:   Wed, 15 Aug 2018 20:41:23 +0000
Message-ID: <90A7E81AE28BAE4CBDDB3B35F187D2644073EA26@CHN-SV-EXMX02.mchp-main.com>
References: <20180815175040.3736548-1-arnd@arndb.de>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com>
In-Reply-To: <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com>
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

PiA+ID4gUXVlc3Rpb246IHRoaXMgaXMgdGhlIG9ubHkgcHRwIGRyaXZlciB0aGF0IHNldHMgdGhl
IGhhcmR3YXJlIHRpbWUgdG8NCj4gPiA+IHRoZSBjdXJyZW50IHN5c3RlbSB0aW1lIGluIFRBSS4g
V2h5IGRvZXMgaXQgZG8gdGhhdD8NCj4gPg0KPiA+IFRoaXMgaXMgZG9uZSB3aGVuIHRoZSBkcml2
ZXIgc3RhcnRzIHVwIGFmdGVyIHJlc2V0LiBPdGhlcndpc2UgdGhlIGNsb2NrIGlzIG9mZg0KPiBi
eSA0OCB5ZWFycy4NCj4gPiBJdCBzZWVtZWQgdG8gbWUgdGhhdCB0aGUgc3lzdGVtIHRpbWUgd2Fz
IHRoZSBtb3N0IGFwcHJvcHJpYXRlIGNsb2NrIHRvDQo+IHN5bmMgdG8uDQo+ID4gSWYgbXkgcmVh
c29uaW5nIGlzIGluY29ycmVjdCwgcGxlYXNlIGVubGlnaHRlbiBtZS4NCj4gDQo+IEkndmUgbmV2
ZXIgd29ya2VkIHdpdGggUFRQLCBidXQgbXkgdW5kZXJzdGFuZGluZyBmcm9tIGxvb2tpbmcgYXQg
dGhlIG90aGVyDQo+IGRyaXZlcnMgaXMgdGhhdCB0aGUgdGltZSBub3JtYWxseSBnZXRzIHNldCBl
aXRoZXIgZnJvbSBhbm90aGVyIGhvc3QgdGhyb3VnaA0KPiB0aGUgUFRQIHByb3RvY29sLCBvciB1
c2luZyBjbG9ja19zZXR0aW1lKCkgZnJvbSB1c2VyIHNwYWNlIHdpdGggdGhlIGN1cnJlbnQNCj4g
dGltZS4NCg0KVGhvc2UgbWV0aG9kcyB3aWxsIHN0aWxsIHdvcmsuIEJ1dCBpZiBpdCdzIG5vdCBz
ZXQgYnkgdGhvc2UgbWV0aG9kcywgSSB0aG91Z2h0IHRoZSBjbG9jayBzaG91bGQgYXQgbGVhc3Qg
YmUgc2V0IG9uY2Ugb24gZHJpdmVyIHN0YXJ0dXAgdG8gYWxpZ24gd2l0aCB0aGUgc3lzdGVtIGNs
b2NrLiBBZnRlciB0aGF0LCBvdGhlciBtZXRob2RzIGFyZSBmcmVlIHRvIHJlc2V0IGl0IGFnYWlu
Lg0KDQpCcnlhbg0K
