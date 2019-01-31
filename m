Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B77CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6C820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfAaKJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:09:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:55335 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbfAaKJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:09:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 02:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="139468136"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2019 02:09:33 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX107.ger.corp.intel.com ([169.254.10.127]) with mapi id 14.03.0415.000;
 Thu, 31 Jan 2019 10:09:32 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: RE: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Topic: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Index: AQHUrYYWOOwEuMXWwEOBiuSRPC5USKW5sWmAgAABJYCAD4jdQIAAAryAgAAAtbA=
Date:   Thu, 31 Jan 2019 10:09:32 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B9BC4B@IRSMSX102.ger.corp.intel.com>
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <20190121123836.GC47506@lakrids.cambridge.arm.com>
 <CACT4Y+Y6JNyQ+SSZXDSYVcBXZ_e1Hf3OMpoz=1eqGNhNKqYikg@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B9BBF9@IRSMSX102.ger.corp.intel.com>
 <CACT4Y+Y5Y54iWn3w2jifjecDb+dZa_B=qZBsKTH8immHktij2Q@mail.gmail.com>
In-Reply-To: <CACT4Y+Y5Y54iWn3w2jifjecDb+dZa_B=qZBsKTH8immHktij2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjE4YTFiYWItMjAxZC00MGY1LTkxMjEtZTNhNjEzYzMxMjE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTmhMcGNDRWZBZ1NtU2l0UFBrSUNqb0ZXaVRLZU5CcVwvSlRwemg5WUsyR1ZyXC9pTXA3S0xyNlwvaFpWUXpsMWpvVSJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIEphbiAzMSwgMjAxOSBhdCAxMTowNCBBTSBSZXNoZXRvdmEsIEVsZW5hDQo+IDxl
bGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+ICA+IEp1c3QgdG8gY2hl
Y2ssIGhhcyB0aGlzIGJlZW4gdGVzdGVkIHdpdGggQ09ORklHX1JFRkNPVU5UX0ZVTEwgYW5kDQo+
ID4gPiA+IHNvbWV0aGluZyBwb2tpbmcga2Nvdj8NCj4gPiA+ID4NCj4gPiA+ID4gR2l2ZW4gbGli
L3JlZmNvdW50LmMgaXMgaW5zdHJ1bWVudGVkLCB0aGUgcmVmY291bnRfKigpIGNhbGxzIHdpbGwN
Cj4gPiA+ID4gcmVjdXJzZSBiYWNrIGludG8gdGhlIGtjb3YgY29kZS4gSXQgbG9va3MgbGlrZSB0
aGF0J3MgZmluZSwgZ2l2ZW4gdGhlc2UNCj4gPiA+ID4gYXJlIG9ubHkgbWFuaXB1bGF0ZWQgaW4g
c2V0dXAvdGVhcmRvd24gcGF0aHMsIGJ1dCBpdCB3b3VsZCBiZSBuaWNlIHRvIGJlDQo+ID4gPiA+
IHN1cmUuDQo+ID4gPg0KPiA+ID4gQSBzaW1wbGUgcHJvZ3JhbSB1c2luZyBLQ09WIGlzIGF2YWls
YWJsZSBoZXJlOg0KPiA+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMC1y
YzMvc291cmNlL0RvY3VtZW50YXRpb24vZGV2LQ0KPiA+ID4gdG9vbHMva2Nvdi5yc3QjTDQyDQo+
ID4gPiBvciBoZXJlIChpdCdzIGxpa2Ugc3RyYWNlIGJ1dCBjb2xsZWN0cyBhbmQgcHJpbnRzIEtD
T1YgY292ZXJhZ2UpOg0KPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS9zeXprYWxsZXIv
YmxvYi9tYXN0ZXIvdG9vbHMva2NvdnRyYWNlL2tjb3Z0cmFjZS5jDQo+ID4gPg0KPiA+DQo+ID4g
T2ssIHNvIEkgZmluYWxseSBnb3QgdG8gY29tcGlsZSBrY292IGluIGFuZCB0cnkgdGhlIGZpcnN0
IHRlc3QgcHJvZ3JhbQ0KPiA+IGFuZCBpdCB3b3JrcyBmaW5lIGFzIGZhciBhcyBJIGNhbiBzZWU6
IHJ1bnMsIHByaW50cyByZXN1bHRzLCBhbmQgbm8gV0FSTnMgYW55d2hlcmUNCj4gPiB2aXNpYmxl
IHdpdGggcmVnYXJkcyB0byByZWZjb3VudF90Lg0KPiA+DQo+ID4gSSBkaWQgbXkgdGVzdCBvbiA0
LjIwIHdpdGggQ09ORklHX1JFRkNPVU5UX0ZVTEw9eQ0KPiA+IHNpbmNlIEkgaGF2ZSBzZXJpb3Vz
IGlzc3VlcyBnZXR0aW5nIDUuMCBydW5uaW5nIGFzIGl0IGlzIGV2ZW4gZnJvbQ0KPiA+IHRoZSBz
dGFibGUgYnJhbmNoLCBidXQgdW5sZXNzIGtjb3YgdW5kZXJ3ZW50IHNvbWUgc2VyaW91cyBjaGFu
Z2VzIHNpbmNlDQo+IERlY2VtYmVyLA0KPiA+IGl0IHNob3VsZCBub3QgYWZmZWN0Lg0KPiANCj4g
VGhlcmUgd2VyZSBubyBjaGFuZ2VzIHRoYXQgc2hvdWxkIGFmZmVjdCB0aGlzIHBhcnQuDQo+IA0K
PiBSZXZpZXdlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KDQoNClRo
YW5rIHlvdSEgV2lsbCB5b3UgYmUgYWJsZSB0byB0YWtlIHRoaXMgY2hhbmdlIGZvcndhcmQgYXMg
Zm9yIA0Kb3RoZXIgbm9ybWFsIGtjb3YgY2hhbmdlcz8gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5h
Lg0K
