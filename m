Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB12CC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B86C216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B86C216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeHFT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:28:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:44796 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeHFT2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:28:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 10:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="252373219"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2018 10:18:39 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 6 Aug 2018 10:18:39 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 FMSMSX102.amr.corp.intel.com ([169.254.10.114]) with mapi id 14.03.0319.002;
 Mon, 6 Aug 2018 10:18:39 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "hehy1@lenovo.com" <hehy1@lenovo.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [External]  Re: [PATCH] ACPI: nfit: return -ENODEV if fail to
 find NFIT at startup
Thread-Topic: [External]  Re: [PATCH] ACPI: nfit: return -ENODEV if fail to
 find NFIT at startup
Thread-Index: AQHUKw9W31TJeaGVuEmcv5V4mRjBQqSuuU+AgAQQXQCAAKiQAA==
Date:   Mon, 6 Aug 2018 17:18:38 +0000
Message-ID: <1533575914.25865.2.camel@intel.com>
References: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
         <1533316299.8557.71.camel@intel.com>
         <HK0PR03MB3170E6D5D62D14B02F39FAE089200@HK0PR03MB3170.apcprd03.prod.outlook.com>
In-Reply-To: <HK0PR03MB3170E6D5D62D14B02F39FAE089200@HK0PR03MB3170.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.191.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <540CCDD9AF417548BEAD19DBDABC3FF3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA4LTA2IGF0IDA3OjE1ICswMDAwLCBPY2VhbiBIWTEgSGUgd3JvdGU6DQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBWZXJtYSwgVmlzaGFsIEwg
PHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gPiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDA0
LCAyMDE4IDE6MTIgQU0NCj4gPiBUbzogV2lsbGlhbXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb20+OyByb3NzLnp3aXNsZXJAbGludXguaW50ZWwuY29tOw0KPiA+IG9jZWFuaGVoeUBn
bWFpbC5jb207IEppYW5nLCBEYXZlIDxkYXZlLmppYW5nQGludGVsLmNvbT47IGxlbmJAa2VybmVs
Lm9yZzsNCj4gPiByandAcmp3eXNvY2tpLm5ldA0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBsaW51eC0NCj4gPiBhY3BpQHZn
ZXIua2VybmVsLm9yZzsgT2NlYW4gSFkxIEhlIDxoZWh5MUBsZW5vdm8uY29tPg0KPiA+IFN1Ympl
Y3Q6IFtFeHRlcm5hbF0gUmU6IFtQQVRDSF0gQUNQSTogbmZpdDogcmV0dXJuIC1FTk9ERVYgaWYg
ZmFpbCB0byBmaW5kIE5GSVQgYXQNCj4gPiBzdGFydHVwDQo+ID4gDQo+ID4gDQo+ID4gT24gRnJp
LCAyMDE4LTA4LTAzIGF0IDA1OjM5IC0wNDAwLCBPY2VhbiBIZSB3cm90ZToNCj4gPiA+IEZyb206
IE9jZWFuIEhlIDxoZWh5MUBsZW5vdm8uY29tPg0KPiA+ID4gDQo+ID4gPiBJbiB0aGUgYmVnaW5u
aW5nIG9mIGFjcGlfbmZpdF9hZGQsIGlmIGZhaWwgdG8gZmluZCBORklUIHRhYmxlIHRoZW4NCj4g
PiA+IHNob3VsZA0KPiA+ID4gcmV0dXJuIC1FTk9ERVYsIGluc3RlYWQgb2YgMC4NCj4gPiA+IA0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogT2NlYW4gSGUgPGhlaHkxQGxlbm92by5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgfCAyICstDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMgYi9kcml2ZXJzL2FjcGkvbmZpdC9j
b3JlLmMNCj4gPiA+IGluZGV4IDdjNDc5MDAuLjE3OTBkN2MgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9uZml0L2Nv
cmUuYw0KPiA+ID4gQEAgLTMzNTUsNyArMzM1NSw3IEBAIHN0YXRpYyBpbnQgYWNwaV9uZml0X2Fk
ZChzdHJ1Y3QgYWNwaV9kZXZpY2UNCj4gPiA+ICphZGV2KQ0KPiA+ID4gIAlpZiAoQUNQSV9GQUlM
VVJFKHN0YXR1cykpIHsNCj4gPiA+ICAJCS8qIFRoaXMgaXMgb2ssIHdlIGNvdWxkIGhhdmUgYW4g
bnZkaW1tIGhvdHBsdWdnZWQNCj4gPiA+IGxhdGVyICovDQo+ID4gPiAgCQlkZXZfZGJnKGRldiwg
ImZhaWxlZCB0byBmaW5kIE5GSVQgYXQgc3RhcnR1cFxuIik7DQo+ID4gPiAtCQlyZXR1cm4gMDsN
Cj4gPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+IA0KPiA+IEhtLCB0aGUgY29tbWVudCBkaXJl
Y3RseSBhYm92ZSB0aGlzIHNheXMgdGhpcyBpcyBvay4uDQo+ID4gSGFzIHRoaXMgY2F1c2VkIGFu
eSBwcm9ibGVtcyBpbiBwcmFjdGljZT8NCj4gPiANCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBjb21t
ZW50cy4gQWZ0ZXIgZ29pbmcgdGhyb3VnaCByZWxhdGVkIGNvZGVzIGFuZCBzb21lIHRlc3QsIEkg
YW0gDQo+IG5vdyB0aGlua2luZyBpdCdzIHJpZ2h0IHRvIGtlZXAgInJldHVybiAwIiBpZiBORklU
IG5vdCBmb3VuZCBhdCBib290IHRpbWUuDQo+IA0KPiBQZXIgY2hhcHRlciA5LjIwLjIgTlZESU1N
IFJvb3QgRGV2aWNlIGluIEFDUEkgNi4yIHNwZWM6DQo+IFRoZSBOVkRJTU0gcm9vdCBkZXZpY2Ug
aXMgcmVwcmVzZW50ZWQgYnkgYW4gQUNQSSBuYW1lc3BhY2UgZGV2aWNlIHdpdGggYSBfSElEIA0K
PiBvZiAiQUNQSTAwMTIiLiBUaGlzIGRldmljZSBhbGxvd3MgdGhlIE9TIHRvIHRyaWdnZXIgZW51
bWVyYXRpb24gb2YgTlZESU1NcyANCj4gdGhyb3VnaCBORklUIGF0IGJvb3QgdGltZSBhbmQgcmUt
ZW51bWVyYXRpb24gYXQgcm9vdCBsZXZlbCB2aWEgdGhlIF9GSVQgbWV0aG9kIA0KPiBkdXJpbmcg
cnVudGltZS4gDQo+IA0KPiBUaGUgYWNwaV9uZml0X2RyaXZlciBpcyByZWdpc3RlcmVkIHRvIEFD
UEkgYnVzIHRvIHN1cHBvcnQgIkFDUEkwMDEyIi4gDQo+IFRoZSBhY3BpX25maXRfZHJpdmVyLmFj
cGlfbmZpdF9hZGQgaXMgdXNlZCB0byBlbnVtZXJhdGUgTlZESU1NcyB0aHJvdWdoIE5GSVQgDQo+
IGF0IGJvb3QgdGltZTsgVGhlIGFjcGlfbmZpdF9kcml2ZXIuYWNwaV9uZml0X25vdGlmeSBpcyB1
c2VkIHRvIGVudW1lcmF0ZSANCj4gTlZESU1NcyBkdXJpbmcgcnVudGltZS4NCj4gDQo+IEluIG15
IExlbm92byBUaGlua1N5c3RlbSBTUjYzMCB3aGljaCBzdXBwb3J0IE5WRElNTXMsIElmIEkgcmVt
b3ZlIA0KPiBhbGwgTlZESU1NcywgdGhlIE5GSVQgdGFibGUgaXMgZ29uZSBhZnRlciBzeXN0ZW0g
Ym9vdCB1cC4gSWYga2VlcCAicmV0dXJuIDAiIA0KPiBpbiBhY3BpX25maXRfYWRkLCB0aGVuIGFj
cGlfbmZpdF9kcml2ZXIgd291bGQgc3RpbGwgYmUgYXR0YWNoZWQgdG8gIkFDUEkwMDEyIi4gDQo+
IE9uY2UgYSBOVkRJTU0gaXMgaG90cGx1Z2dlZCBpbnRvIHN5c3RlbSBkdXJpbmcgcnVudGltZSwg
dGhlbiANCj4gYWNwaV9uZml0X2RyaXZlci5hY3BpX25maXRfbm90aWZ5IGNhbiBiZSBjYWxsZWQg
dG8gZW51bWVyYXRlIE5WRElNTXMgKEkgY291bGQNCj4gbm90IGRvIGhvdHBsdWcgdGVzdCBiZWNh
dXNlIGZpcm13YXJlIGRvZXNuJ3Qgc3VwcG9ydCkuIA0KPiBPdGhlcndpc2UsICJyZXR1cm4gLUVO
T0RFViIgd291bGQgYmxvY2sgTlZESU1NIGVudW1lcmF0aW9uIGR1cmluZyBydW50aW1lLg0KPiAN
Cj4gSG93IGRvIHlvdSB0aGluayB0byBhZGp1c3QgYW5ub3RhdGlvbiBhcyBmb2xsb3dpbmc/DQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5jIGIvZHJpdmVycy9hY3Bp
L25maXQvY29yZS5jDQo+IGluZGV4IDdjNDc5MDAuLjE2NzMxNjEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvYWNwaS9uZml0L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMN
Cj4gQEAgLTMzNTMsNyArMzM1MywxMyBAQCBzdGF0aWMgaW50IGFjcGlfbmZpdF9hZGQoc3RydWN0
IGFjcGlfZGV2aWNlICphZGV2KQ0KPiAgDQo+ICAgICAgICAgc3RhdHVzID0gYWNwaV9nZXRfdGFi
bGUoQUNQSV9TSUdfTkZJVCwgMCwgJnRibCk7DQo+ICAgICAgICAgaWYgKEFDUElfRkFJTFVSRShz
dGF0dXMpKSB7DQo+IC0gICAgICAgICAgICAgICAvKiBUaGlzIGlzIG9rLCB3ZSBjb3VsZCBoYXZl
IGFuIG52ZGltbSBob3RwbHVnZ2VkIGxhdGVyICovDQo+ICsgICAgICAgICAgICAgICAvKiBUaGUg
TlZESU1NIHJvb3QgZGV2aWNlIGFsbG93cyBPUyB0byB0cmlnZ2VyIGVudW1lcmF0aW9uIG9mIA0K
PiArICAgICAgICAgICAgICAgICogTlZESU1NcyB0aHJvdWdoIE5GSVQgYXQgYm9vdCB0aW1lIGFu
ZCByZS1lbnVtZXJhdGlvbiBhdCANCj4gKyAgICAgICAgICAgICAgICAqIHJvb3QgbGV2ZWwgdmlh
IHRoZSBfRklUIG1ldGhvZCBkdXJpbmcgcnVudGltZS4NCj4gKyAgICAgICAgICAgICAgICAqIFRo
aXMgaXMgb2sgdG8gcmV0dXJuIDAgaGVyZSwgd2UgY291bGQgaGF2ZSBhbiBudmRpbW0gDQo+ICsg
ICAgICAgICAgICAgICAgKiBob3RwbHVnZ2VkIGxhdGVyIGFuZCBldmFsdWF0ZSBfRklUIG1ldGhv
ZCB3aGljaCByZXR1cm5zIA0KPiArICAgICAgICAgICAgICAgICogZGF0YSBpbiB0aGUgZm9ybWF0
IG9mIGEgc2VyaWVzIG9mIE5GSVQgU3RydWN0dXJlcy4NCj4gKyAgICAgICAgICAgICAgICAqLw0K
PiAgICAgICAgICAgICAgICAgZGV2X2RiZyhkZXYsICJmYWlsZWQgdG8gZmluZCBORklUIGF0IHN0
YXJ0dXBcbiIpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgICAgfQ0KDQpZ
ZXMsIHRoaXMgc291bmRzIHJlYXNvbmFibGUgdG8gbWUuDQoNClRoYW5rcywNCgktVmlzaGFsDQoN
Cj4gDQo+IE9jZWFuLg0KPiANCj4gPiA+ICAJfQ0KPiA+ID4gDQo+ID4gPiAgCXJjID0gZGV2bV9h
ZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgYWNwaV9uZml0X3B1dF90YWJsZSwNCj4gPiA+IHRibCk7
