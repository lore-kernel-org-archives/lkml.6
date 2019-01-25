Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59661C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23785218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jMzy0r07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfAYSRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:17:31 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55861 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfAYSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548440244; x=1579976244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=MhWeZrRQcKAjmSpWReigvorT9K00za/+mPd3S6e6q/A=;
  b=jMzy0r07+DyGcPHiG4X1LNLL/cQHZ9mncbyDwPJfpKn7I3NWnbNHdBpO
   HLwLKvH1icW/ttaq146dQwEQFmzGeHcBuQEVq6ohCXd8woKGpvo/gTvPf
   IL0woXbEsiSvKl0RI6r6kSJetZ0MHEOtLuslbhD05Om/k7ooDpt8wjPtj
   0=;
X-IronPort-AV: E=Sophos;i="5.56,522,1539648000"; 
   d="scan'208";a="714779778"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Jan 2019 18:17:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id D58DDA257F;
        Fri, 25 Jan 2019 18:17:15 +0000 (UTC)
Received: from EX13D01EUB004.ant.amazon.com (10.43.166.180) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:17:14 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB004.ant.amazon.com (10.43.166.180) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:17:13 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 25 Jan 2019 18:17:13 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v5 13/13] KVM/nVMX: Use page_address_valid in a few more
 locations
Thread-Topic: [PATCH v5 13/13] KVM/nVMX: Use page_address_valid in a few more
 locations
Thread-Index: AQHUp/+hXFSe3mcPMkeFhhSGW/c5HaW9P/2AgAMkZQA=
Date:   Fri, 25 Jan 2019 18:17:12 +0000
Message-ID: <1548440232.17444.23.camel@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
         <1547026933-31226-14-git-send-email-karahmed@amazon.de>
         <20190123181807.GS19289@Konrads-MacBook-Pro.local>
In-Reply-To: <20190123181807.GS19289@Konrads-MacBook-Pro.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.122]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0BF24A3F6C07046957D07FC0D0F1545@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAxLTIzIGF0IDEzOjE4IC0wNTAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsg
d3JvdGU6DQo+IE9uIFdlZCwgSmFuIDA5LCAyMDE5IGF0IDEwOjQyOjEzQU0gKzAxMDAsIEthcmlt
QWxsYWggQWhtZWQgd3JvdGU6DQo+ID4gDQo+ID4gVXNlIHBhZ2VfYWRkcmVzc192YWxpZCBpbiBh
IGZldyBtb3JlIGxvY2F0aW9ucyB0aGF0IGlzIGFscmVhZHkgY2hlY2tpbmcgZm9yDQo+ID4gYSBw
YWdlIGFsaWduZWQgYWRkcmVzcyB0aGF0IGRvZXMgbm90IGNyb3NzIHRoZSBtYXhpbXVtIHBoeXNp
Y2FsIGFkZHJlc3MuDQo+IA0KPiBXaGVyZSBpcyB0aGlzIHBhZ2VfYWRkcmVzc192YWxpZCBkZWNs
YXJlZD8gVGhlIGxhdGVzdCBsaW51cydzIHRyZWUgZG9lcw0KPiBub3QgaGF2ZSBpdCwgbm9yIGRv
ZXMgeW91ciBwYXRjaHNldD8NCg0KSXQgaXMgYWxyZWFkeSBkZWZpbmVkIGluIHRoZSBjb2RlLCBJ
IGNhbiBub3Qgc2VlIGFueSBjb21taXRzIHRoYXQgcmVtb3ZlZCBpdDoNCg0KJCBnaXQgZ3JlcCBw
YWdlX2FkZHJlc3NfdmFsaWQNCmFyY2gveDg2L2t2bS92bXgvbmVzdGVkLmM6c3RhdGljIGJvb2wg
cGFnZV9hZGRyZXNzX3ZhbGlkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCmdwYV90IGdwYSkNCmFy
Y2gveDg2L2t2bS92bXgvbmVzdGVkLmM6wqDCoMKgwqDCoMKgaWYgKCFwYWdlX2FkZHJlc3NfdmFs
aWQodmNwdSwgdm1jczEyLQ0KPmlvX2JpdG1hcF9hKSB8fA0KYXJjaC94ODYva3ZtL3ZteC9uZXN0
ZWQuYzrCoMKgwqDCoMKgwqDCoMKgwqDCoCFwYWdlX2FkZHJlc3NfdmFsaWQodmNwdSwgdm1jczEy
LT5pb19iaXRtYXBfDQpiKSkNCmFyY2gveDg2L2t2bS92bXgvbmVzdGVkLmM6wqDCoMKgwqDCoMKg
aWYgKCFwYWdlX2FkZHJlc3NfdmFsaWQodmNwdSwgdm1jczEyLQ0KPm1zcl9iaXRtYXApKQ0KYXJj
aC94ODYva3ZtL3ZteC9uZXN0ZWQuYzrCoMKgwqDCoMKgwqBpZiAoIXBhZ2VfYWRkcmVzc192YWxp
ZCh2Y3B1LCB2bWNzMTItDQo+dmlydHVhbF9hcGljX3BhZ2VfYWRkcikpDQphcmNoL3g4Ni9rdm0v
dm14L25lc3RlZC5jOsKgwqDCoMKgwqDCoMKgwqDCoMKgIXBhZ2VfYWRkcmVzc192YWxpZCh2Y3B1
LCB2bWNzMTItDQo+YXBpY19hY2Nlc3NfYWRkcikpDQphcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5j
OsKgwqDCoMKgwqDCoMKgwqDCoMKgIXBhZ2VfYWRkcmVzc192YWxpZCh2Y3B1LCB2bWNzMTItDQo+
cG1sX2FkZHJlc3MpKQ0KYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYzrCoMKgwqDCoMKgwqBpZiAo
IXBhZ2VfYWRkcmVzc192YWxpZCh2Y3B1LCB2bWNzMTItDQo+dm1yZWFkX2JpdG1hcCkgfHwNCmFy
Y2gveDg2L2t2bS92bXgvbmVzdGVkLmM6wqDCoMKgwqDCoMKgwqDCoMKgwqAhcGFnZV9hZGRyZXNz
X3ZhbGlkKHZjcHUsIHZtY3MxMi0NCj52bXdyaXRlX2JpdG1hcCkpDQphcmNoL3g4Ni9rdm0vdm14
L25lc3RlZC5jOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAhcGFnZV9hZGRyZXNzX3ZhbGlkKHZjcHUsDQp2bWNzMTItPmVwdHBfbGlzdF9hZGRyZXNz
KSkNCmFyY2gveDg2L2t2bS92bXgvbmVzdGVkLmM6wqDCoMKgwqDCoMKgaWYgKCFwYWdlX2FkZHJl
c3NfdmFsaWQodmNwdSwgdm1jczEyLQ0KPnZtY3NfbGlua19wb2ludGVyKSkNCmFyY2gveDg2L2t2
bS92bXgvbmVzdGVkLmM6wqDCoMKgwqDCoMKgaWYgKCFwYWdlX2FkZHJlc3NfdmFsaWQodmNwdSwg
a3ZtX3N0YXRlLQ0KPnZteC52bXhvbl9wYSkpDQphcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5jOsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCFwYWdlX2FkZHJlc3NfdmFsaWQodmNw
dSwga3ZtX3N0YXRlLQ0KPnZteC52bWNzX3BhKSkNCg0KPiA+IA0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEthcmltQWxsYWggQWhtZWQgPGthcmFobWVkQGFtYXpvbi5kZT4NCj4gPiAtLS0NCj4g
PiAgYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyB8IDYgKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2t2bS92bXgvbmVzdGVkLmMgYi9hcmNoL3g4Ni9rdm0vdm14L25lc3RlZC5j
DQo+ID4gaW5kZXggY2NiM2I2My4uNzdhYWQ0NiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9r
dm0vdm14L25lc3RlZC5jDQo+ID4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYw0KPiA+
IEBAIC00MjAzLDcgKzQyMDMsNyBAQCBzdGF0aWMgaW50IGhhbmRsZV92bW9uKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSkNCj4gPiAgCSAqIE5vdGUgLSBJQTMyX1ZNWF9CQVNJQ1s0OF0gd2lsbCBuZXZl
ciBiZSAxIGZvciB0aGUgbmVzdGVkIGNhc2U7DQo+ID4gIAkgKiB3aGljaCByZXBsYWNlcyBwaHlz
aWNhbCBhZGRyZXNzIHdpZHRoIHdpdGggMzINCj4gPiAgCSAqLw0KPiA+IC0JaWYgKCFQQUdFX0FM
SUdORUQodm1wdHIpIHx8ICh2bXB0ciA+PiBjcHVpZF9tYXhwaHlhZGRyKHZjcHUpKSkNCj4gPiAr
CWlmICghcGFnZV9hZGRyZXNzX3ZhbGlkKHZjcHUsIHZtcHRyKSkNCj4gPiAgCQlyZXR1cm4gbmVz
dGVkX3ZteF9mYWlsSW52YWxpZCh2Y3B1KTsNCj4gPiAgDQo+ID4gIAlpZiAoa3ZtX3JlYWRfZ3Vl
c3QodmNwdS0+a3ZtLCB2bXB0ciwgJnJldmlzaW9uLCBzaXplb2YocmV2aXNpb24pKSB8fA0KPiA+
IEBAIC00MjY2LDcgKzQyNjYsNyBAQCBzdGF0aWMgaW50IGhhbmRsZV92bWNsZWFyKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSkNCj4gPiAgCWlmIChuZXN0ZWRfdm14X2dldF92bXB0cih2Y3B1LCAmdm1w
dHIpKQ0KPiA+ICAJCXJldHVybiAxOw0KPiA+ICANCj4gPiAtCWlmICghUEFHRV9BTElHTkVEKHZt
cHRyKSB8fCAodm1wdHIgPj4gY3B1aWRfbWF4cGh5YWRkcih2Y3B1KSkpDQo+ID4gKwlpZiAoIXBh
Z2VfYWRkcmVzc192YWxpZCh2Y3B1LCB2bXB0cikpDQo+ID4gIAkJcmV0dXJuIG5lc3RlZF92bXhf
ZmFpbFZhbGlkKHZjcHUsDQo+ID4gIAkJCVZNWEVSUl9WTUNMRUFSX0lOVkFMSURfQUREUkVTUyk7
DQo+ID4gIA0KPiA+IEBAIC00NDczLDcgKzQ0NzMsNyBAQCBzdGF0aWMgaW50IGhhbmRsZV92bXB0
cmxkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gPiAgCWlmIChuZXN0ZWRfdm14X2dldF92bXB0
cih2Y3B1LCAmdm1wdHIpKQ0KPiA+ICAJCXJldHVybiAxOw0KPiA+ICANCj4gPiAtCWlmICghUEFH
RV9BTElHTkVEKHZtcHRyKSB8fCAodm1wdHIgPj4gY3B1aWRfbWF4cGh5YWRkcih2Y3B1KSkpDQo+
ID4gKwlpZiAoIXBhZ2VfYWRkcmVzc192YWxpZCh2Y3B1LCB2bXB0cikpDQo+ID4gIAkJcmV0dXJu
IG5lc3RlZF92bXhfZmFpbFZhbGlkKHZjcHUsDQo+ID4gIAkJCVZNWEVSUl9WTVBUUkxEX0lOVkFM
SURfQUREUkVTUyk7DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDIuNy40DQo+ID4gDQoKCgpBbWF6b24g
RGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IENocmlzdGlhbiBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gK
VXN0LUlEOiBERSAyODkgMjM3IDg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90
dGVuYnVyZyBIUkIgMTQ5MTczIEIKCg==

