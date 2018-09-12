Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBD2C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DC420866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DC420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeILNhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:37:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeILNhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:37:33 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E4C05F99FD976;
        Wed, 12 Sep 2018 09:34:00 +0100 (IST)
Received: from FRAEML704-CAH.china.huawei.com (10.206.14.35) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Wed, 12 Sep 2018 09:33:08 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 FRAEML704-CAH.china.huawei.com ([10.206.14.35]) with mapi id 14.03.0399.000;
 Wed, 12 Sep 2018 10:32:58 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "John Garry" <john.garry@huawei.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
Subject: RE: [PATCH v2 3/4] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v2 3/4] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHUI0QEVNn+nxciOE+KjTAFsGaj96Tpg1UAgABZb/CAAS6JAIABkO2g
Date:   Wed, 12 Sep 2018 08:32:58 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838786A46@FRAEML521-MBX.china.huawei.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-4-shameerali.kolothum.thodi@huawei.com>
 <935f7572-38d7-070a-dba6-3f18189de4d3@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838785947@FRAEML521-MBX.china.huawei.com>
 <5b98cd2c-02f7-0934-41c5-1da3e3557896@arm.com>
In-Reply-To: <5b98cd2c-02f7-0934-41c5-1da3e3557896@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDExIFNlcHRlbWJlciAyMDE4IDEx
OjI1DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IENjOiB3
aWxsLmRlYWNvbkBhcm0uY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgR3VvaGFuanVuIChIYW5q
dW4gR3VvKQ0KPiA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5
QGh1YXdlaS5jb20+Ow0KPiBwYWJiYUBjb2RlYXVyb3JhLm9yZzsgdmtpbGFyaUBjb2RlYXVyb3Jh
Lm9yZzsgcnJ1aWdyb2tAY29kZWF1cm9yYS5vcmc7DQo+IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IG5l
aWwubS5sZWVkZXJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy80XSBwZXJm
OiBhZGQgYXJtNjQgc21tdXYzIHBtdSBkcml2ZXINCj4gDQo+IE9uIDEwLzA5LzE4IDE3OjM3LCBT
aGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiBbLi4uXQ0KPiA+Pj4gQEAgLTAsMCAr
MSw4MzggQEANCj4gPj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4g
Pj4+ICsvKiBDb3B5cmlnaHQgKGMpIDIwMTcgVGhlIExpbnV4IEZvdW5kYXRpb24uIEFsbCByaWdo
dHMgcmVzZXJ2ZWQuDQo+ID4+PiArICoNCj4gPj4+ICsgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yDQo+ID4+PiArbW9kaWZ5DQo+
ID4+PiArICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSB2ZXJzaW9uIDIgYW5kDQo+ID4+PiArICogb25seSB2ZXJzaW9uIDIgYXMgcHVibGlzaGVk
IGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQo+ID4+PiArICoNCj4gPj4+ICsgKiBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVz
ZWZ1bCwNCj4gPj4+ICsgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0
aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPiA+Pj4gKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRO
RVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUNCj4gPj4+ICsgKiBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KPiA+Pg0KPiA+PiBZb3UgZG9u
J3QgcmVhbGx5IG5lZWQgdG8gYWRkIHRoZSBsaWNlbnNlIHRleHQgYXMgd2VsbCBhcyBTUERYLiBF
eGNlcHQgZm9yIHRoZQ0KPiBmYWN0DQo+ID4+IHRoYXQgaW4gdGhpcyBjYXNlIHRoZXkgZG9uJ3Qg
bWF0Y2ggLSB3aGljaCBpcyBpdD8NCj4gPg0KPiA+IFJpZ2h0LiBJIHdpbGwgc3RpY2sgdG8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+IA0KPiBNeSBxdWVzdGlvbiB0aGVyZSBp
cyBhYm91dCB0aGUgIisiIC0gdGhlIGxpY2Vuc2Ugb2YgdGhlIG9yaWdpbmFsIHBhdGNoDQo+IHdh
cyBHUEwtMi4wLCBhbmQgSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBsZWdpdGltYWN5IG9mIHF1aWV0
bHkgY2hhbmdpbmcNCj4gaXQgdG8gMi4wLW9yLWxhdGVyLCBlc3BlY2lhbGx5IHdpdGhvdXQgYW55
IHZpc2libGUgYWdyZWVtZW50IGZyb20NCj4gcHJldmlvdXMgY29udHJpYnV0b3JzLg0KDQpBaC4u
VG8gYXZvaWQgY29tcGxpY2F0aW9uLCBJIHdpbGwgY2hhbmdlIGl0IHRvIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLg0KDQo+IFsuLi5dDQo+ID4+IEFsc28sIGhvdyByZWxldmFudCBp
cyBpdCBnb2luZyB0byBiZSBmb3IgZnV0dXJlIERUIHN1cHBvcnQ/IFdlIGRvbid0IHJlYWxseQ0K
PiB3YW50DQo+ID4+IHRvbyBtYW55IGFydGlmaWNpYWwgZGVwZW5kZW5jaWVzIG9uIHRoZSB3YXkg
QUNQSSBzdXBwb3J0IGhhcHBlbnMgdG8NCj4gY3VycmVudGx5DQo+ID4+IGJlIGltcGxlbWVudGVk
Lg0KPiA+DQo+ID4gU29ycnksIGl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoYXQgaXMgcHJvcG9zZWQg
aGVyZSBhcyBmYXIgYXMgbmFtaW5nIHRoZSBQTVUgaXMNCj4gPiBjb25jZXJuZWQuIFBsZWFzZSBz
ZWUgYmVsb3cgYXMgd2VsbC4NCj4gDQo+IEhlcmUgSSBtZWFuIHdoZXRoZXIgcGRldi0+aWQgaXMg
bWVhbmluZ2Z1bCBmb3IgT0YgcGxhdGZvcm0gZGV2aWNlcyBpbg0KPiB0aGUgc2FtZSB3YXkgYXMg
Zm9yIElPUlQgZGV2aWNlcyBpbiB0ZXJtcyBvZiB1bmlxdWVuZXNzIC0gaXQgbWF5IHdlbGwNCj4g
YmUsIGJ1dCBpZiBpdCBpc24ndCB0aGVuIHdlIHNob3VsZCBmaW5kIGEgYmV0dGVyIGFsdGVybmF0
aXZlLg0KDQpPay4gVGhhbmtzIGZvciBjbGFyaWZ5aW5nIHRoaXMuDQogDQo+ID4+PiArb3V0Og0K
PiA+Pj4gKwlrZnJlZSh0ZW1wKTsNCj4gPj4+ICsJcmV0dXJuIHJldDsNCj4gPj4+ICt9DQo+ID4+
PiArDQo+ID4+PiArDQo+ID4+PiArc3RhdGljIGNoYXIgKnNtbXVfcG11X2Fzc2lnbl9uYW1lKHN0
cnVjdCBzbW11X3BtdSAqcG11KSB7DQo+ID4+PiArCXVuc2lnbmVkIGxvbmcgaWQ7DQo+ID4+PiAr
CXN0cnVjdCBkZXZpY2UgKnNtbXUsICpkZXYgPSBwbXUtPmRldjsNCj4gPj4+ICsJY2hhciAqc19u
YW1lID0gTlVMTCwgKnBfbmFtZSA9IE5VTEw7DQo+ID4+PiArDQo+ID4+PiArCXNtbXUgPSBpb3J0
X2ZpbmRfcG1jZ19yZWZfc21tdShkZXYpOw0KPiA+Pj4gKwlpZiAoc21tdSkgew0KPiA+Pj4gKwkJ
aWYgKCFzbW11X3BtdV9nZXRfZGV2X2lkKGRldl9uYW1lKHNtbXUpLCAmaWQpKQ0KPiA+Pj4gKwkJ
CXNfbmFtZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLA0KPiA+PiAiYXJtX3NtbXVfdjNfJWx1Iiwg
aWQpOw0KPiA+Pj4gKwl9DQo+ID4+PiArDQo+ID4+PiArCWlmICghc19uYW1lKQ0KPiA+Pj4gKwkJ
c19uYW1lID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICJhcm1fc21tdV92MyIpOw0KPiA+Pg0KPiA+
PiBBcyBJIHRvdWNoZWQgb24gYmVmb3JlLCBJIHRoaW5rIGl0J3Mgd29ydGggZ2VuZXJhbGlzaW5n
IHRoaXMgZnJvbSB0aGUgc3RhcnQsIGFuZA0KPiA+PiB0cnlpbmcgdG8gcmVzb2x2ZSB0aGUgY29t
cG9uZW50IHJlZmVyZW5jZSB0byBhIHN0cnVjdCBkZXZpY2UgcmF0aGVyIHRoYW4NCj4gPj4gSU9S
VC9TTU1VIHNwZWNpZmljIGludGVybmFscy4gSG93ZXZlciBpdCBhbHNvIG9jY3VycyB0byBtZSB0
aGF0IG1heWJlIHRoaXMNCj4gPj4gaXNuJ3QgYXMgaW1wb3J0YW50IGFzIGl0IGZpcnN0IHNlZW1l
ZCAtIHNpbmNlIHRoZSBhdXRvLW51bWJlcmVkIElEIGRvZXNuJ3QNCj4gPj4gYWN0dWFsbHkgc2F5
IHdoaWNoIFBNQ0cgaXMgd2hpY2gsIHRoZSBvbmx5IHdheSBmb3IgdGhlIHVzZXIgdG8gYWN0dWFs
bHkNCj4gaWRlbnRpZnkNCj4gPj4gd2hpY2ggUE1VIGlzIHRoZSBjb3JyZWN0IG9uZSB0byBjb3Vu
dCBldmVudHMgZm9yIGEgcGFydGljdWxhciBlbmRwb2ludCBpcw0KPiBzdGlsbCB0bw0KPiA+PiBn
cm92ZWwgdXAgdGhlIGJhc2UgYWRkcmVzcywgc28gYXMgbG9uZyBhcyB0aGUgUE1VIG5hbWUgdW5p
cXVlbHkgY29ycmVsYXRlcw0KPiB0bw0KPiA+PiB0aGUgUE1DRyBkZXZpY2UsIEknbSBub3Qgc3Vy
ZSBhbnl0aGluZyByZWFsbHkgbWF0dGVycyBiZXlvbmQgdGhhdC4NCj4gPg0KPiA+IFNvIElmIEkg
dW5kZXJzdGFuZCB0aGlzIGNvcnJlY3RseSwNCj4gPg0KPiA+IGlvcnRfZmluZF9wbWNnX3JlZl9z
bW11KCkgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlICBpb3J0X2ZpbmRfcG1jZ19yZWYoKQ0KPiA+
IHdoaWNoIHJldHVybnMgdGhlIGFzc29jaWF0ZWQgc3RydWN0IGRldmljZSBmb3IgdGhlIHJlZiBu
b2RlIGFuZCB0aGVuLCBwbXUgaXMNCj4gPiBuYW1lZCBhcywNCj4gPg0KPiA+IGFybV9zbW11X3Yz
X3hfcG1jZ195DQo+ID4gbmNfZGV2X25hbWVfeF9wbWNnX3kNCj4gPiBwY2lYWFhYX3BtY2dfeSAg
KEl04oCZcyBhIGJpdCB0cmlja3kgZm9yIFJDIGFzIHdlIHdpbGwgZW5kIHVwIHdpdGggc3RydWN0
IHBjaV9idXMpDQo+ID4NCj4gPiAod2hlcmUgeCBhbmQgeSBhcmUgYXV0byBpZHMpDQo+ID4NCj4g
PiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcyB3aGF0IGlzIHByb3Bvc2VkIGhlcmUuDQo+
IA0KPiBUaGF0J3MgbW9yZSBvciBsZXNzIHdoYXQgSSB3YXMgYW5nbGluZyBhdCwgYnV0IGFzIG1l
bnRpb25lZCBJIHJlYWxpc2UNCj4gaXQncyBmdW5kYW1lbnRhbGx5IGZsYXdlZCAobG9va2luZyBi
YWNrIGF0IHRoZSBvcmlnaW5hbCB0aHJlYWQsIEkgc2VlIGl0DQo+IHdhcyBtZSB0aGF0IHByb3Bv
c2VkIHRoZSBpZGVhLCBxdWVsbGUgc3VwcmlzZSEpDQo+IA0KPiBTYXkgeW91IHdhbnQgdG8gY291
bnQgZXZlbnRzIG9uIG9uZSBwYXJ0aWN1bGFyIHN0cmVhbSBJRCAtIGhvdyBkbyB5b3UNCj4gZGV0
ZXJtaW5lIHdoaWNoIG9mICJhcm1fc21tdV92M18wX3BtY2dfMCIgdG8NCj4gImFybV9zbW11X3Yz
XzBfcG1jZ182Ig0KPiByZXByZXNlbnRzIHRoZSBhY3R1YWwgVEJVIHRoYXQgY2FuIHNlZSB0aGF0
IFNJRD8gU3VyZSwgeW91IGhhdmUgYSAqYml0Kg0KPiBtb3JlIGluZm9ybWF0aW9uIHRoYW4gaWYg
dGhleSB3ZXJlIGp1c3QgbmFtZWQsIHNheSwgImFybV9wbWNnXzAiIHRvDQo+ICJhcm1fcG1jZ182
IiwgYnV0IGl0J3Mgbm90IGFjdHVhbGx5ICp1c2VmdWwqIGluZm9ybWF0aW9uIGJlY2F1c2UgdGhv
c2UNCj4gSURzIG9ubHkgcmVhbGx5IHJlcHJlc2VudCB0aGUgcHJvYmUgb3JkZXIsIGFuZCB0aGF0
IGRlcGVuZHMgZW50aXJlbHkgb24NCj4gdGhlIElPUlQvRFQgb3JkZXIgYW5kIHdoYXRldmVyIExp
bnV4IGZlbHQgbGlrZSBkb2luZy4NCj4gDQo+IFRodXMgaWYgZ29pbmcgdG8gYWxsIHRoaXMgZWZm
b3J0IHRvIGNvbXBvc2UgYSBjb21wbGV4IG5hbWUgc3RpbGwgZG9lc24ndA0KPiBhY3R1YWxseSBo
ZWxwIHRoZSB1c2VyIGluIG1vc3QgY2FzZXMsIGlzIGl0IHdvcnRoIGl0PyBJJ20gc3RhcnRpbmcg
dG8NCj4gdGhpbmsgbm90Lg0KPiANCj4gPiBJdCBpcyBwb3NzaWJsZSB0byBpbmNsdWRlIHRoZSBw
bWNnIGJhc2UgYWRkcmVzcyBpbnN0ZWFkIG9mIHRoZSBhdXRvLW51bWJlcmVkDQo+IGlkDQo+ID4g
YXMgcHJvcG9zZWQgaW4gdjEgc2VyaWVzLg0KPiANCj4gVGhhdCdzIHByb2JhYmx5IHRoZSBtb3N0
IHJvYnVzdCBvcHRpb24gZm9yIG5vdyB1bmxlc3MgYW55b25lIGNhbiBjb21lIHVwDQo+IHdpdGgg
YSBiZXR0ZXIgaWRlYSAoSSBkbyB3b25kZXIgYWJvdXQgZG9pbmcgc29tZXRoaW5nIGhvcnJpYmxl
IHdpdGgNCj4gcG11LT5kZXYucGFyZW50Li4uKSBNeSBiYWQgZm9yIG1pc3NpbmcgdGhhdCByYXRo
ZXIgc3VidGxlIHBvaW50IHRoZQ0KPiBmaXJzdCB0aW1lIGFyb3VuZCwgc29ycnkgZXZlcnlvbmUh
IA0KDQpBZ3JlZSB0byB0aGUgZmFjdCB0aGF0IHRoZSBiZW5lZml0IG91dCBvZiBhbGwgdGhlIGNv
bXBsZXhpdHkgaW52b2x2ZWQgaW4NCnNvcnRpbmcgb3V0IHRoZSByZWZlcmVuY2UgZGV2aWNlIGlz
IG5vdCB0aGF0IGdyZWF0LiBTbyBJIGFtIHBsYW5uaW5nIHRvDQpnbyBiYWNrIHRvIHRoZSB2MSB3
YXkgb2YgbmFtaW5nIHBtY2cgYWxvbmcgd2l0aCB0aGUgYmFzZSBhZGRyZXNzDQpmb3IgdGhlIG5l
eHQgcmV2aXNpb24gb2YgdGhpcyBzZXJpZXMsIHVubGVzcyB0aGVyZSBpcyBhIGJldHRlciBpZGVh
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg==
