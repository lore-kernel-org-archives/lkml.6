Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48E8C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56052146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56052146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKUOkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:40:03 -0500
Received: from mx.socionext.com ([202.248.49.38]:13501 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeKUOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:40:02 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Nov 2018 13:07:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id CF129180BD6;
        Wed, 21 Nov 2018 13:07:20 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Wed, 21 Nov 2018 13:07:20 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX02V.e01.socionext.com (10.213.24.22) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Wed, 21 Nov 2018 13:07:20 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Wed, 21 Nov 2018 13:07:20 +0900
From:   <sugaya.taichi@socionext.com>
To:     <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <linux@armlinux.org.uk>, <jslaby@suse.com>,
        <masami.hiramatsu@linaro.org>, <jaswinder.singh@linaro.org>
Subject: RE: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
Thread-Topic: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
Thread-Index: AQHUf6NHu62F4PMl3kuaRfAZNU8J/aVWoOoAgALuGJA=
Date:   Wed, 21 Nov 2018 04:07:19 +0000
Message-ID: <7f32b467a1d84987b9d80cdd540e035b@SOC-EX02V.e01.socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
 <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
In-Reply-To: <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.3.2
x-shieldmailcheckerpolicyversion: POLICY180220
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaCtkdEBrZXJuZWwu
b3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMCwgMjAxOCAxMjoyMSBBTQ0KPiBUbzog
U3VnYXlhLCBUYWljaGkv6I+F6LC3IOWkquS4gA0KPiBDYzogbGludXgtY2xrOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRQ0KPiBJTVggLyBN
WEMgQVJNIEFSQ0hJVEVDVFVSRTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgb3BlbiBs
aXN0OlNFUklBTA0KPiBEUklWRVJTOyBNaWNoYWVsIFR1cnF1ZXR0ZTsgU3RlcGhlbiBCb3lkOyBN
YXJrIFJ1dGxhbmQ7IEdyZWcgS3JvYWgtSGFydG1hbjsNCj4gRGFuaWVsIExlemNhbm87IFRob21h
cyBHbGVpeG5lcjsgUnVzc2VsbCBLaW5nOyBKaXJpIFNsYWJ5OyBNYXNhbWkgSGlyYW1hdHN1Ow0K
PiBKYXNzaSBCcmFyDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDMvMTRdIEFSTTogbWlsYmVhdXQ6
IEFkZCBNaWxiZWF1dCBNMTBWIGVhcmx5IHByaW50aw0KPiANCj4gT24gU3VuLCBOb3YgMTgsIDIw
MTggYXQgNzowMCBQTSBTdWdheWEgVGFpY2hpDQo+IDxzdWdheWEudGFpY2hpQHNvY2lvbmV4dC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIE1pbGJlYXV0IE0xMFYgZWFybHlwcmludGsuDQo+IA0K
PiBEbyB5b3UgcmVhbGx5IG5lZWQgZWFybHlwcmludGs/IGVhcmx5Y29uIGlzIHByZWZlcnJlZCBp
bnN0ZWFkLiBJdCdzDQo+IG5vdCBxdWl0ZSBhcyBlYXJseSwgYnV0IGRvZXNuJ3QgcmVxdWlyZSBy
ZWJ1aWxkaW5nIHRoZSBrZXJuZWwgYW5kDQo+IHN1cHBvcnRzIG1vcmUgdGhhbiAxIGZpeGVkIGRl
dmljZS4gSWYgeW91IGNyYXNoIGJlZm9yZSBlYXJseWNvbiBpcw0KPiBlbmFibGVkLCB0aGF0IHBy
ZXR0eSBtdWNoIG1lYW5zIGVpdGhlciBhIGJhZCBkdGIgbWVtb3J5IG5vZGUgb3IganVzdA0KPiBm
bGFreSBtZW1vcnkuDQpPSy4gSSB1c2UgZWFybHljb24gc2luY2Ugd291bGQgbGlrZSB0byB1c2Ug
ZmxleGlibGUgZnVuY3Rpb25zLg0KDQpUaGFua3MNClN1Z2F5YSBUYWljaGkNCg0KPiANCj4gUm9i
DQo=
