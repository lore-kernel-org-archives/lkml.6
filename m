Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBFFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419CB20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419CB20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeIYNDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:03:05 -0400
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:59916 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbeIYNDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:03:05 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2018 09:03:03 EDT
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.54,301,1534802400"; 
   d="scan'208";a="57294189"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khoroshilov@ispras.ru" <khoroshilov@ispras.ru>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: Re: rtc: isl1208: avoid possible sysfs race
Thread-Topic: rtc: isl1208: avoid possible sysfs race
Thread-Index: AQHUVJtA0dWTdZv7nk2ctvoXuofcyqUAbDSA
Date:   Tue, 25 Sep 2018 06:46:24 +0000
Message-ID: <1537857983.4657.5.camel@diehl.com>
References: <20180915114343.31935-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180915114343.31935-1-alexandre.belloni@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <50F33F016665DB4AB0186339B93CE0A8@diehl.internal>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: PkB65aL1SqtESF35r/jQn1wcAP/6cinSQxhUfNfQmXqohSANlU2J/j7+vWF4KN9F
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCmp1c3QgZm9yIGNsYXJpZmljYXRpb246DQpUaGlzIGNoYW5nZXMgdXNlci1zcGFj
ZSByZXByZXNlbnRhdGlvbiBmcm9tDQovc3lzL2NsYXNzL3J0Yy9ydGNOL2RldmljZS97YXRy
aW0sZHRyaW0sdXNyfQ0KdG8NCi9zeXMvY2xhc3MvcnRjL3J0Y04ve2F0cmltLGR0cmltLHVz
cn0NCmFuZCBmaXhlcyB0aGUgIm1pc3Rha2UgbWFkZSBiYWNrIGluIDIwMDYiIHlvdSBtZW50
aW9uIGluDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzg4MTM5Ny8NCmNv
cnJlY3Q/DQoNClJlZ2FyZHMgRGVuaXMNCg0KQW0gU2Ftc3RhZywgZGVuIDE1LjA5LjIwMTgs
IDEzOjQzICswMjAwIHNjaHJpZWIgQWxleGFuZHJlIEJlbGxvbmk6DQo+IFVzZSBydGNfYWRk
X2dyb3VwIHRvIGFkZCB0aGUgY29tbW9uIHN5c2ZzIGdyb3VwIHRvIGF2b2lkIGEgcG9zc2li
bGUgcmFjZQ0KPiBjb25kaXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcmUg
QmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvcnRjL3J0Yy1pc2wxMjA4LmMgfCAxMSArLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ydGMvcnRjLWlzbDEyMDguYyBiL2RyaXZlcnMvcnRjL3J0Yy1pc2wx
MjA4LmMNCj4gaW5kZXggZWExOGE4ZjRiY2UwLi5lMWU5NDM0Yzk5NzIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvcnRjL3J0Yy1pc2wxMjA4LmMNCj4gKysrIGIvZHJpdmVycy9ydGMvcnRj
LWlzbDEyMDguYw0KPiBAQCAtODA0LDcgKzgwNCw3IEBAIGlzbDEyMDhfcHJvYmUoc3RydWN0
IGkyY19jbGllbnQgKmNsaWVudCwgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmlkKQ0K
PiDCoAkJZXZkZXRfaXJxID0gb2ZfaXJxX2dldF9ieW5hbWUobnAsICJldmRldCIpOw0KPiDC
oAl9DQo+IMKgDQo+IC0JcmMgPSBzeXNmc19jcmVhdGVfZ3JvdXAoJmNsaWVudC0+ZGV2Lmtv
YmosICZpc2wxMjA4X3J0Y19zeXNmc19maWxlcyk7DQo+ICsJcmMgPSBydGNfYWRkX2dyb3Vw
KHJ0YywgJmlzbDEyMDhfcnRjX3N5c2ZzX2ZpbGVzKTsNCj4gwqAJaWYgKHJjKQ0KPiDCoAkJ
cmV0dXJuIHJjOw0KPiDCoA0KPiBAQCAtODIxLDE0ICs4MjEsNiBAQCBpc2wxMjA4X3Byb2Jl
KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lk
ICppZCkNCj4gwqAJcmV0dXJuIHJ0Y19yZWdpc3Rlcl9kZXZpY2UocnRjKTsNCj4gwqB9DQo+
IMKgDQo+IC1zdGF0aWMgaW50DQo+IC1pc2wxMjA4X3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVu
dCAqY2xpZW50KQ0KPiAtew0KPiAtCXN5c2ZzX3JlbW92ZV9ncm91cCgmY2xpZW50LT5kZXYu
a29iaiwgJmlzbDEyMDhfcnRjX3N5c2ZzX2ZpbGVzKTsNCj4gLQ0KPiAtCXJldHVybiAwOw0K
PiAtfQ0KPiAtDQo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIGlzbDEy
MDhfaWRbXSA9IHsNCj4gwqAJeyAiaXNsMTIwOCIsIFRZUEVfSVNMMTIwOCB9LA0KPiDCoAl7
ICJpc2wxMjE4IiwgVFlQRV9JU0wxMjE4IH0sDQo+IEBAIC04NTEsNyArODQzLDYgQEAgc3Rh
dGljIHN0cnVjdCBpMmNfZHJpdmVyIGlzbDEyMDhfZHJpdmVyID0gew0KPiDCoAkJLm9mX21h
dGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGlzbDEyMDhfb2ZfbWF0Y2gpLA0KPiDCoAl9LA0K
PiDCoAkucHJvYmUgPSBpc2wxMjA4X3Byb2JlLA0KPiAtCS5yZW1vdmUgPSBpc2wxMjA4X3Jl
bW92ZSwNCj4gwqAJLmlkX3RhYmxlID0gaXNsMTIwOF9pZCwNCj4gwqB9Ow0KPiDCoA0KDQpE
aWVobCBDb25uZWN0aXZpdHkgU29sdXRpb25zIEdtYkgNCkdlc2Now6RmdHNmw7xocnVuZzog
SG9yc3QgTGVvbmJlcmdlcg0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBOw7xybmJlcmcgLSBS
ZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0DQpOw7xybmJlcmc6IEhSQiAzMjMxNQ0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCkRlciBJbmhh
bHQgZGVyIHZvcnN0ZWhlbmRlbiBFLU1haWwgaXN0IG5pY2h0IHJlY2h0bGljaCBiaW5kZW5k
LiBEaWVzZSBFLU1haWwgZW50aGFlbHQgdmVydHJhdWxpY2hlIHVuZC9vZGVyIHJlY2h0bGlj
aCBnZXNjaHVldHp0ZSBJbmZvcm1hdGlvbmVuLg0KSW5mb3JtaWVyZW4gU2llIHVucyBiaXR0
ZSwgd2VubiBTaWUgZGllc2UgRS1NYWlsIGZhZWxzY2hsaWNoZXJ3ZWlzZSBlcmhhbHRlbiBo
YWJlbi4gQml0dGUgbG9lc2NoZW4gU2llIGluIGRpZXNlbSBGYWxsIGRpZSBOYWNocmljaHQu
DQpKZWRlIHVuZXJsYXVidGUgRm9ybSBkZXIgUmVwcm9kdWt0aW9uLCBCZWthbm50Z2FiZSwg
QWVuZGVydW5nLCBWZXJ0ZWlsdW5nIHVuZC9vZGVyIFB1Ymxpa2F0aW9uIGRpZXNlciBFLU1h
aWwgaXN0IHN0cmVuZ3N0ZW5zIHVudGVyc2FndC4NClRoZSBjb250ZW50cyBvZiB0aGUgYWJv
dmUgbWVudGlvbmVkIGUtbWFpbCBpcyBub3QgbGVnYWxseSBiaW5kaW5nLiBUaGlzIGUtbWFp
bCBjb250YWlucyBjb25maWRlbnRpYWwgYW5kL29yIGxlZ2FsbHkgcHJvdGVjdGVkIGluZm9y
bWF0aW9uLiBQbGVhc2UgaW5mb3JtIHVzIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1t
YWlsIGJ5DQptaXN0YWtlIGFuZCBkZWxldGUgaXQgaW4gc3VjaCBhIGNhc2UuIEVhY2ggdW5h
dXRob3JpemVkIHJlcHJvZHVjdGlvbiwgZGlzY2xvc3VyZSwgYWx0ZXJhdGlvbiwgZGlzdHJp
YnV0aW9uIGFuZC9vciBwdWJsaWNhdGlvbiBvZiB0aGlzIGUtbWFpbCBpcyBzdHJpY3RseSBw
cm9oaWJpdGVkLiANCg==
