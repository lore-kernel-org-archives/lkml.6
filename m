Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C53C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B08121480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YrI3dkES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B08121480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeIXRJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:09:51 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50668 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:09:50 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D103B24E26E3;
        Mon, 24 Sep 2018 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537787298; bh=QfSXuDLBsHqZKPJzlHNUw4lM3cxFXBgmKquqaSRa608=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YrI3dkES4Rl31e6f2++rkJUrFSiTZhe9bPhAgqYmYd6AvicgqqKd9Q7waHNro5bZi
         HPJ+Lnipl3W0n86ydWpP1j5SZwN9X3jO574GVeBZmAxe1unseQ3MlB7XhoOW2YTGy5
         XHwPBBRCpT7uzflosTGmexhyopi/h8x5HG10WBW+x2ed3ICqxAuwJiNPMFa3mDST+v
         GyKQfGswdNDn+zxuevbhac8v/B8UKh0HZ9/7m7uM8+6J1scarUoh+CeyhiXwGsIyUO
         fS7iFrvbhmk8S15IESoZxcclGTKEDT3UiuGpnoKx9gqL9yjUozCyzy0Ftfm1VPytZS
         vJStyBOdWuXbQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id BB96836DB;
        Mon, 24 Sep 2018 04:08:16 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 24 Sep 2018 04:08:16 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 24 Sep 2018 13:08:14 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: HSDK: improve reset driver
Thread-Topic: [PATCH] ARC: HSDK: improve reset driver
Thread-Index: AQHUPhOUaZSCotcop0yU3vqnzO0KH6TvkGWAgA+/soA=
Date:   Mon, 24 Sep 2018 11:08:14 +0000
Message-ID: <1537787293.4902.22.camel@synopsys.com>
References: <20180827143803.28178-1-Eugeniy.Paltsev@synopsys.com>
         <1536921493.4112.6.camel@pengutronix.de>
In-Reply-To: <1536921493.4112.6.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2D7D6CCC89834419151E2F5CE9A5A99@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwLA0KDQpPbiBGcmksIDIwMTgtMDktMTQgYXQgMTI6MzggKzAyMDAsIFBoaWxpcHAg
WmFiZWwgd3JvdGU6DQo+IEhpIEV1Z2VuaXksDQo+IA0KPiBPbiBNb24sIDIwMTgtMDgtMjcgYXQg
MTc6MzggKzAzMDAsIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gPiBBcyBmb3IgdG9kYXkgSFNE
SyByZXNldCBkcml2ZXIgaW1wbGVtZW50cyBvbmx5DQo+ID4gLnJlc2V0KCkgY2FsbGJhY2suDQo+
ID4gDQo+ID4gSW4gY2FzZSBvZiBkcml2ZXIgd2hpY2ggaW1wbGVtZW50cyBvbmUgb2Ygc3RhbmRh
cmQNCj4gPiByZXNldCBjb250cm9sbGVyIHVzYWdlIHBhdHRlcm4NCj4gPiAoY2FsbCAqX2RlYXNz
ZXJ0KCkgaW4gcHJvYmUoKSwgY2FsbCAqX2Fzc2VydCgpIGluIHJlbW92ZSgpKQ0KPiA+IHRoYXQg
bGVhZHMgdG8gaW5vcGVyYWJpbGl0eSBvZiB0aGlzIHJlc2V0IGRyaXZlci4NCj4gPiANCj4gPiBJ
bXByb3ZlIEhTREsgcmVzZXQgZHJpdmVyIGJ5IGNhbGxpbmcgLnJlc2V0KCkgY2FsbGJhY2sgaW5z
aWRlIG9mDQo+ID4gLmFzc2VydCgpLy5kZWFzc2VydCgpIGNhbGxiYWNrcyB0byBhdm9pZCBlYWNo
IHJlc2V0IGNvbnRyb2xsZXINCj4gPiB1c2VyIGFkYXB0YXRpb24gZm9yIHdvcmsgd2l0aCBib3Ro
IHJlc2V0IG1ldGhvZHMNCj4gPiAocmVzZXQoKSBhbmQgLmFzc2VydCgpLy5kZWFzc2VydCgpIHBh
aXIpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBh
bHRzZXZAc3lub3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWhz
ZGsuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWhzZGsuYyBiL2RyaXZlcnMvcmVz
ZXQvcmVzZXQtaHNkay5jDQo+ID4gaW5kZXggOGJjZTM5MWM2OTQzLi4xZmQ5MWRmOTEzNDMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC1oc2RrLmMNCj4gPiArKysgYi9kcml2
ZXJzL3Jlc2V0L3Jlc2V0LWhzZGsuYw0KPiA+IEBAIC04Niw2ICs4Niw4IEBAIHN0YXRpYyBpbnQg
aHNka19yZXNldF9yZXNldChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+
ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyBoc2RrX3Jlc2V0
X29wcyA9IHsNCj4gPiAgCS5yZXNldAk9IGhzZGtfcmVzZXRfcmVzZXQsDQo+ID4gKwkgPSBoc2Rr
X3Jlc2V0X3Jlc2V0LA0KPiANCj4gVGhpcyBpcyBpbmNvcnJlY3QgZm9yIGV4Y2x1c2l2ZSByZXNl
dCBjb250cm9scy4NCj4gSXQgd2lsbCBjYXVzZSByZXNldF9jb250cm9sX2Fzc2VydCgpIHRvIHJl
dHVybiBzdWNjZXNzIGZvciBleGNsdXNpdmUNCj4gcmVzZXQgY29udHJvbHMsIGV2ZW4gdGhvdWdo
IHRoZSAuYXNzZXJ0IG9wIGZhaWxlZCB0byBsZWF2ZSB0aGUgcmVzZXQNCj4gbGluZSBhc3NlcnRl
ZCBhZnRlciB0aGUgZnVuY3Rpb24gcmV0dXJucy4NCj4gDQo+IFdoaWxlIGNhbGxpbmcgaHNka19y
ZXNldF9yZXNldCBmcm9tIC5hc3NlcnQgZm9yIHNoYXJlZCByZXNldCBjb250cm9scw0KPiB3b3Vs
ZCBiZSBmaW5lLCBJIGRvbid0IHNlZSBob3cgdGhpcyBpcyBuZWNlc3Nhcnkgb2YgdXNlZnVsLg0K
PiBJZiBhIGNvbnN1bWVyIGRyaXZlciByZXF1aXJlcyB0aGUgcmVzZXQgdG8gYmUgYXNzZXJ0ZWQg
dXBvbiByZW1vdmUoKSwgaXQNCj4gbXVzdCBub3QgcmVxdWVzdCBhIHNoYXJlZCByZXNldCBjb250
cm9sIGFueXdheSwgYmVjYXVzZSB3aXRoIHNoYXJlZA0KPiByZXNldCBjb250cm9scyBvdGhlciBk
cml2ZXJzIG1heSBrZWVwIHRoZSByZXNldCBsaW5lIGRlYXNzZXJ0ZWQNCj4gaW5kZWZpbml0ZWx5
Lg0KDQpPaywgSSBhZ3JlZSB0aGF0IGRvaW5nIHJlc2V0IGZyb20gLmFzc2VydCBpc24ndCBuZWNl
c3NhcnkvdXNlZnVsIGhlcmUuDQpUaGUgcmVhc29uIEkgYWRkZWQgaHNka19yZXNldF9yZXNldCBp
bnRvIC5hc3NlcnQgaXMgdG8gcHJldmVudCAtRU5PVFNVUFANCnJldHVybmluZyBieSByZXNldF9j
b250cm9sX2Fzc2VydCgpLg0KDQpMb3RzIG9mIGRyaXZlcnMgaW1wbGVtZW50IGZvbGxvd2luZyBw
YXR0ZXJuIHRvIHJlc2V0IEhXOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpyZXNldF9jb250cm9sX2Fzc2VydChyZXNldHMpOw0KdXNs
ZWVwX3JhbmdlKDEwLCAxMDAwKTsNCnJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocmVzZXRzKTsNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
DQpBbmQgc29tZSBvZiB0aGVtIGNoZWNrIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KCkgYW5kIHJlc2V0
X2NvbnRyb2xfZGVhc3NlcnQoKQ0KcmV0dXJuIHN0YXR1cy4NCg0KU28gdGhlc2UgZHJpdmVyIHdp
bGwgZmFpbCBpZiBJIGltcGxlbWVudCBvbmx5IC5yZXNldCBhbmQgLmRlYXNzZXJ0IGNhbGxiYWNr
IGluIG15DQpyZXNldCBkcml2ZXIuDQoNCkkgY2FuIGltcGxlbWVudCBzb21ldGhpbmcgbGlrZSB0
aGF0Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQpzdGF0aWMgaW50IGhzZGtfZHVtbXlfYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9s
bGVyX2RldiAqcmQsIHVuc2lnbmVkIGxvbmcgaWQpDQp7DQoJcmV0dXJuIDA7DQp9DQoNCnN0YXRp
YyBjb25zdCBzdHJ1Y3QgcmVzZXRfY29udHJvbF9vcHMgaHNka19yZXNldF9vcHMgPSB7DQoJLnJl
c2V0ICAgID0gaHNka19yZXNldF9yZXNldCwNCgkuYXNzZXJ0ICAgPSBoc2RrX2R1bW15X2Fzc2Vy
dCwNCgkuZGVhc3NlcnQgPSBoc2RrX3Jlc2V0X3Jlc2V0LA0KfTsNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQoNCg0KPiA+ICsJLmRl
YXNzZXJ0ID0gaHNka19yZXNldF9yZXNldCwNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGZpbmUuIA0K
DQo+IEkgd29uZGVyIGZyb20gdGltZSB0byB0aW1lIHdoZXRoZXIgdGhpcyBzaG91bGQgYmUNCj4g
aW1wbGVtZW50ZWQgaW4gdGhlIGNvcmUsIGluIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoKS4NCg0K
U291bmRzIE9LIGZvciBtZS4gQXQgbGVhc3QgSSBkb24ndCBzZWUgYW55IGlzc3VlcyBpdCBtYXkg
Y2F1c2UuDQoNCj4gcmVnYXJkcw0KPiBQaGlsaXBwDQotLSANCiBFdWdlbml5IFBhbHRzZXY=
