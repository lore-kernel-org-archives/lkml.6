Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E99C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9833120858
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9833120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH1XEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:04:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:57802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1XEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:04:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 12:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="scan'208";a="257974925"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2018 12:11:04 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 28 Aug 2018 20:11:03 +0100
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.41]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.243]) with mapi id 14.03.0319.002;
 Tue, 28 Aug 2018 20:11:03 +0100
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Ian W MORRISON <ianwmorrison@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy
 in case of 'none'"
Thread-Topic: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy
 in case of 'none'"
Thread-Index: AQHUPvJYZg1EMsvkNEyjRKkIJiuR8KTVhbJA
Date:   Tue, 28 Aug 2018 19:11:02 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C266411@IRSMSX106.ger.corp.intel.com>
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
 <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk>
 <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
 <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
 <702eb090-2bf4-69d1-bfb6-afdca4ba5c5f@kernel.dk>
In-Reply-To: <702eb090-2bf4-69d1-bfb6-afdca4ba5c5f@kernel.dk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTg5NjU4YTMtNGY4MC00MGIyLWJiM2ItZDQ2OWRhNThlNmRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN3BwZEVLTnRzTldUZEkwWkkydnhiaWUrM1wvWGJoODlcL0E3dnYzSjhkNFFmcWpRenRhV2pUZDV4UjZudGRmcjJRIn0=
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZW5zIEF4Ym9lIFttYWlsdG86
YXhib2VAa2VybmVsLmRrXQ0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjgsIDIwMTggODoxMiBQ
TQ0KPiBUbzogSWFuIFcgTU9SUklTT04gPGlhbndtb3JyaXNvbkBnbWFpbC5jb20+DQo+IENjOiBs
aW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGthc2h5YXAuZGVzYWlAYnJvYWRjb20uY29tOyBsb2Jlcm1hbkByZWRoYXQuY29tOyBvc2Fu
ZG92QGZiLmNvbTsNCj4gaGNoQGxzdC5kZTsgYmFydC52YW5hc3NjaGVAd2RjLmNvbTsgaGFyZUBz
dXNlLmRlOw0KPiBtaW5nLmxlaUByZWRoYXQuY29tOyBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1
bnRlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJldmVydCAiYmxrLW1xOiBp
c3N1ZSBkaXJlY3RseSBpZiBodyBxdWV1ZSBpc24ndCBidXN5IGluDQo+IGNhc2Ugb2YgJ25vbmUn
Ig0KPiANCj4gT24gOC8yOC8xOCAxMTowMSBBTSwgSWFuIFcgTU9SUklTT04gd3JvdGU6DQo+ID4g
T24gV2VkLCAyOSBBdWcgMjAxOCBhdCAwMjoxMywgSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRr
PiB3cm90ZToNCj4gPj4NCj4gPj4gT24gOC8yOC8xOCAxMDoxMCBBTSwgSWFuIFcgTU9SUklTT04g
d3JvdGU6DQo+ID4+PiBPbiBXZWQsIDI5IEF1ZyAyMDE4IGF0IDAyOjA5LCBKZW5zIEF4Ym9lIDxh
eGJvZUBrZXJuZWwuZGs+IHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4gT24gOC8yOC8xOCAxMDowNyBB
TSwgSWFuIFcgTU9SUklTT04gd3JvdGU6DQo+ID4+Pj4+IE9uIFdlZCwgMjkgQXVnIDIwMTggYXQg
MDE6NDgsIEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gd3JvdGU6DQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gT24gOC8yOC8xOCA5OjQ3IEFNLCBJYW4gVyBNT1JSSVNPTiB3cm90ZToNCj4gPj4+
Pj4+PiBLZXJuZWwgb29wcyB3aGVuIGJvb3Rpbmcgb24gQmF5IGFuZCBDaGVycnkgVHJhaWwgZGV2
aWNlcyBzdWNoIGFzDQo+ID4+Pj4+Pj4gSW50ZWwgQ29tcHV0ZSBTdGljay4gQmlzZWN0ZWQgYXM6
DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBjb21taXQgNmNlM2RkNmVlYzExICgiYmxrLW1xOiBpc3N1
ZSBkaXJlY3RseSBpZiBodyBxdWV1ZSBpc24ndA0KPiA+Pj4+Pj4+IGJ1c3kgaW4gY2FzZSBvZiAn
bm9uZSciKQ0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gVGhpcyBwYXRjaCByZXZlcnRzIHRoZSBhYm92
ZSBjb21taXQuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gRGlkIEkgbWlzcyB0aGUgcG9zdGluZyBvZiB0
aGF0IG9vcHM/IEp1c3QgY3VyaW91cyB3aGVyZSB0aGlzIGlzDQo+ID4+Pj4+PiBnb2luZyB3cm9u
Zy4gTm90IGFkdmVyc2UgdG8gcmV2ZXJ0aW5nLCBidXQgSSdkIGxpa2UgdG8gdHJ5IHRvDQo+ID4+
Pj4+PiB1bmRlcnN0YW5kIHRoZSBpc3N1ZSBmaXJzdC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiAtLQ0K
PiA+Pj4+Pj4gSmVucyBBeGJvZQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSd2ZSBub3Qg
YmVlbiBhYmxlIHRvIGNhcHR1cmUgaXQgaG93ZXZlciBtYW51YWxseSB0cmFuc2NyaWJpbmcNCj4g
Pj4+Pj4gd2hhdCBpcyBvbiB0aGUgc2NyZWVuOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBtbWMwOiBHb3Qg
ZGF0YSBpbnRlcnJ1cHQgMHgwMDAwMDAwMiBldmVuIHRob3VnaCBubyBkYXRhIG9wZXJhdGlvbg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBmb2xsb3dlZCBieToNCj4gPj4+Pj4NCj4gPj4+Pj4gbW1jMDogc2Ro
Y2k6ID09PT09PT09PT09PT0gU0RIQ0kgUkVHSVNURVIgRFVNUA0KPiA9PT09PT09PT09PT09PQ0K
PiA+Pj4+Pg0KPiA+Pj4+PiBEbyB5b3Ugd2FudCBhbnkgc3BlY2lmaWMgcmVnaXN0ZXIgdmFsdWUg
b3Igc2hvdWxkIEkgdHJhbnNjcmliZQ0KPiA+Pj4+PiBlYWNoIChhcyBJIGFtIHdvcmtpbmcgZnJv
bSBhbiBpbWFnZSB0YWtlbiBhdCBib290KT8NCj4gPj4+Pg0KPiA+Pj4+IEp1c3QgdGFrZSBhIHBp
Y3R1cmUgb2YgdGhlIHNjcmVlbiwgdGhhdCBzaG91bGQgYmUgZ29vZCBlbm91Z2guDQo+ID4+Pj4N
Cj4gPj4+PiAtLQ0KPiA+Pj4+IEplbnMgQXhib2UNCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEF0dGFj
aGVkIGFzIHJlcXVlc3RlZC4NCj4gPj4NCj4gPj4gQ2FuIHlvdSBzZWUgaWYgdGhpcyBwYXRjaCBo
ZWxwcz8NCj4gPj4NCj4gPj4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbW1jJm09MTUzNDg1
MzI2MDI1MzAxJnc9Mg0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiBKZW5zIEF4Ym9lDQo+ID4+DQo+ID4N
Cj4gPiBJIGNvbmZpcm0gdGhhdCB0aGUgYWJvdmUgcGF0Y2ggd29ya3Mgd2l0aCBjb21taXQgNmNl
M2RkNmVlYzExIGFuZA0KPiA+IHJlbW92ZXMgdGhlIG5lZWQgZm9yIHJldmVydGluZyBpdCBvbiBl
TU1DIGJhc2VkIGRldmljZXMuDQo+ID4NCj4gPiBUZXN0ZWQgb24gQmF5IFRyYWlsLCBDaGVycnkg
VHJhaWwgKGJvdGggbm93IHdvcmtpbmcpIGFuZCBLYWJ5IExha2UNCj4gPiAobm90IGFmZmVjdGVk
KSBkZXZpY2VzLg0KPiANCj4gR3JlYXQsIHRoYW5rcyBmb3IgdGVzdGluZy4gQWRyaWFuLCB3aGVu
IGlzIHRoaXMgZ29pbmcgdXBzdHJlYW0/DQoNCkl0IGlzIGluIFVsZidzIGZpeGVzIGJyYW5jaCwg
c28gbW9zdCBsaWtlbHkgdjQuMTktcmMyIC4gIFRoZW4gdG8gc3RhYmxlIGluIGR1ZSBjb3Vyc2Uu
DQoNCglodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC91bGZo
L21tYy5naXQvY29tbWl0Lz9oPWZpeGVzJmlkPTI2Y2FkZGYyNzRjZjFlODlmZDRjZTQ0YWIyYjhk
YmM3YTdmOTc2ODENCg0K
