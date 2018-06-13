Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8CE3EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3999C208BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3999C208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934934AbeFMAGA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:06:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:19811 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932490AbeFMAF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:05:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 17:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="64063301"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2018 17:05:58 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 12 Jun 2018 17:05:58 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 12 Jun 2018 17:05:57 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.51]) with mapi id 14.03.0319.002;
 Wed, 13 Jun 2018 08:05:56 +0800
From:   "Xu, Even" <even.xu@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>
CC:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Thread-Topic: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Thread-Index: AQHUASd9wHD/F8upPEi0DX5gInteeKRcMcAAgAAKbACAARXlwA==
Date:   Wed, 13 Jun 2018 00:05:55 +0000
Message-ID: <9577C59DB499174B9340876B077C2E9569DF11EC@SHSMSX101.ccr.corp.intel.com>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
         <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
 <634cd945beca786dc77876f71e39459cef6fbd75.camel@linux.intel.com>
In-Reply-To: <634cd945beca786dc77876f71e39459cef6fbd75.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2M3YWIyOTMtZmRkYS00ZThiLWEwOGMtNWRkYmJhOWRlMjBmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibWZaMGh6aDl1OHdLbzdWZjlzdkw2ak9tZDBSY2tWcDFlRnVEMWR3M1ZBOTR3Q2NYNk54dW5FQWNhc3ZGZllWcyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2ssIHN1cmUsIEkgd2lsbCB1cGRhdGUgcGF0Y2ggY29tbWVudHMgYW5kIHJlc3VibWl0Lg0KVGhh
bmtzIFNyaW5pdmFzIQ0KDQpCZXN0IFJlZ2FyZHMsDQpFdmVuIFh1DQoNCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU3Jpbml2YXMgUGFuZHJ1dmFkYSBbbWFpbHRvOnNyaW5p
dmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tXSANClNlbnQ6IFR1ZXNkYXksIEp1bmUgMTIs
IDIwMTggMTE6MzEgUE0NClRvOiBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz47IFh1LCBF
dmVuIDxldmVuLnh1QGludGVsLmNvbT4NCkNjOiBiZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNv
bTsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBYdSwgRXZlbiA8ZXZlbi54dUBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBo
aWQ6IGludGVsX2lzaC1oaWQ6IGlwYzogcmVnaXN0ZXIgbW9yZSBwbSBjYWxsYmFja3MgdG8gc3Vw
cG9ydCBoaWJlcm5hdGlvbg0KDQpPbiBUdWUsIDIwMTgtMDYtMTIgYXQgMTY6NTMgKzAyMDAsIEpp
cmkgS29zaW5hIHdyb3RlOg0KPiBPbiBTdW4sIDEwIEp1biAyMDE4LCBTcmluaXZhcyBQYW5kcnV2
YWRhIHdyb3RlOg0KPiANCj4gPiBGcm9tOiBFdmVuIFh1IDxldmVuLnh1QGludGVsLmNvbT4NCj4g
PiANCj4gPiBDdXJyZW50IGlzaCBkcml2ZXIgb25seSByZWdpc3RlciByZXN1bWUvc3VzcGVuZCBQ
TSBjYWxsYmFja3Mgd2hpY2ggDQo+ID4gZG9uJ3Qgc3VwcG9ydCBoaWJlcm5hdGlvbiAoc3VzcGVu
ZCB0byBkaXNrKS4gTm93IHVzZSB0aGUNCj4gPiBTSU1QTEVfREVWX1BNX09QUygpIE1BQ1JPIGlu
c3RlYWQgb2Ygc3RydWN0IGRldl9wbV9vcHMgZGlyZWN0bHkuDQo+ID4gVGhlIHN1c3BlbmQgYW5k
IHJlc3VtZSBmdW5jdGlvbnMgd2lsbCBub3cgYmUgdXNlZCBmb3IgYm90aCBzdXNwZW5kIA0KPiA+
IHRvIFJBTSBhbmQgaGliZXJuYXRpb24uDQo+ID4gDQo+ID4gSWYgcG93ZXIgbWFuYWdlbWVudCBp
cyBkaXNhYmxlLCBTSU1QTEVfREVWX1BNX09QUyB3aWxsIGRvIG5vdGhpbmcsIA0KPiA+IHRoZSBz
dXNwZW5kIGFuZCByZXN1bWUgcmVsYXRlZCBmdW5jdGlvbnMgd29uJ3QgYmUgdXNlZCwgc28gbWFy
ayB0aGVtIA0KPiA+IGFzIF9fbWF5YmVfdW51c2VkIHRvIGNsYXJpZnkgdGhhdCB0aGlzIGlzIGlu
dGVuZGVkIGJlaGF2aW9yLCBhbmQgDQo+ID4gcmVtb3ZlICNpZmRlZnMgZm9yIHBvd2VyIG1hbmFn
ZW1lbnQuDQo+IA0KPiBUaGlzIGRlc2NyaWJlcyBkZXRhaWxzIHRoZSBwYXRjaCBkb2VzIG9uIGNv
ZGUgbGV2ZWwsIGJ1dCB3aGF0IGFyZSB0aGUgDQo+IHVzZXIgb2JzZXJ2YWJsZSBlZmZlY3RzPyBI
aWJlcm5hdGlvbiByZXN1bWUgZG9lc24ndCBmYWlsIGFueSBtb3JlPw0KPiBIaWJlcm5hdGlvbg0K
PiBpcyBwb3NzaWJsZSAoYW5kIHdhc24ndCBiZWZvcmUpPyBEaWQga2VybmVsIGNyYXNoIHdoaWxl
IHRyeWluZyB0byANCj4gaGliZXJuYXRlIGFuZCB0aGlzIGlzIHRoZSBmaXg/IE9yIC4uLiA/DQpF
dmVuLA0KQ2FuIHlvdSBhZGQgbW9yZSBkZXRhaWxzIGFuZCByZXN1Ym1pdCBBU0FQPw0KDQpCYXNp
Y2FsbHkgYWZ0ZXIgaGliZXJhdGlvbiwgdGhlIElTSCBjYW4ndCByZXN1bWUgcHJvcGVybHkgYW5k
IHVzZXIgbWF5IG5vdCBzZWUgc2Vuc29yIGV2ZW50cyAoZm9yIGV4YW1wbGU6IHNjcmVlbiByb3Rh
dGlvbiBtYXkgbm90IHdvcmspLg0KVXNlciB3aWxsIG5vdCBzZWUgYSBjcmFzaCBvciBwYW5pYyBv
ciBhbnl0aGluZyBleGNlcHQgdGhlIGZvbGxvd2luZyBtZXNzYWdlIGluIGxvZzoNCmhpZC1zZW5z
b3ItaHViIDAwMUY6ODA4NjoyMkQ4LjAwMDE6IHRpbWVvdXQgd2FpdGluZyBmb3IgcmVzcG9uc2Ug
ZnJvbSBJU0hUUCBkZXZpY2UgDQoNClNvIHRoaXMgaXMgYWRkaW5nIHN1cHBvcnQgZm9yIFM0L2hp
YmVyYmF0aW9uIHRvIElTSC4NCg0KDQoNClRoYW5rcywNClNyaW5pdmFzDQoNCj4gDQo+IFRoYW5r
cywNCj4gDQo=
