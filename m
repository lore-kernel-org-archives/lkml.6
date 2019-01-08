Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D10DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575332070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfAHIok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:44:40 -0500
Received: from [38.106.11.25] ([38.106.11.25]:46986 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727446AbfAHIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:44:40 -0500
X-ASG-Debug-ID: 1546937067-107606139f1522d0001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id peZgjZHYSryJneP0 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 08 Jan 2019 16:44:27 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 16:44:21 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Tue, 8 Jan 2019 16:44:21 +0800
From:   "Liu, Xiaoting" <xiaoting.liu@hxt-semitech.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: RE: [PATCH v2 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
 driver_data
Thread-Topic: [PATCH v2 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
 driver_data
X-ASG-Orig-Subj: RE: [PATCH v2 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
 driver_data
Thread-Index: AQHUpnWQKdl5kb2Vok2bPPWrHBsVLqWjULEAgAG88EA=
Date:   Tue, 8 Jan 2019 08:44:20 +0000
Message-ID: <8f9416cbbc864a0ab49da385c96926b7@HXTBJIDCEMVIW02.hxtcorp.net>
References: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <b336867f159242e141f21e2bef7182adbc624fbd.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <db6cdd06-c895-566c-0514-fe56a362d215@roeck-us.net>
In-Reply-To: <db6cdd06-c895-566c-0514-fe56a362d215@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.1.98]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1546937067
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 6186
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4558 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65314
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VlbnRlciBSb2VjaywNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3VlbnRlciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21h
aWwuY29tXSBPbiBCZWhhbGYgT2YgR3VlbnRlciBSb2Vjaw0KU2VudDogMjAxOeW5tDHmnIg35pel
IDIyOjA0DQpUbzogTGl1LCBYaWFvdGluZyA8eGlhb3RpbmcubGl1QGh4dC1zZW1pdGVjaC5jb20+
OyBqZGVsdmFyZUBzdXNlLmNvbQ0KQ2M6IG9wZW5ibWNAbGlzdHMub3psYWJzLm9yZzsgbGludXgt
aHdtb25Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZYW5n
LCBTaHVueW9uZyA8c2h1bnlvbmcueWFuZ0BoeHQtc2VtaXRlY2guY29tPjsgV2FuZywgRG9uZ3No
ZW5nIDxkb25nc2hlbmcud2FuZ0BoeHQtc2VtaXRlY2guY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzRdIHBtYnVzOiBhc3NvY2lhdGUgUE1CVVNfU0tJUF9TVEFUVVNfQ0hFQ0sgd2l0aCBk
cml2ZXJfZGF0YQ0KDQpPbiAxLzcvMTkgMjo1NyBBTSwgWGlhb3RpbmcgTGl1IHdyb3RlOg0KPiBD
dXJyZW50IGNvZGUgY29tcGFyZXMgZGV2aWNlIG5hbWUgd2l0aCBuYW1lIGluIGkyY19kZXZpY2Vf
aWQgdG8gZGVjaWRlDQo+IHdoZXRoZXIgUE1CVVNfU0tJUF9TVEFUVVNfQ0hFQ0sgc2hvdWxkIGJl
IHNldCBpbiBwbWJ1c19wbGF0Zm9ybV9kYXRhLA0KPiB3aGljaCBtYWtlcyBhZGRpbmcgbmV3IGRl
dmljZXMgd2l0aCBQTUJVU19TS0lQX1NUQVRVU19DSEVDSyBzaG91bGQgYWxzbw0KPiBtb2RpZnkg
Y29kZSBpbiBwbWJ1c19wcm9iZSgpLg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIHBtYnVzX2Rldmlj
ZV9pbmZvIHRvIHNhdmUgcGFnZXMgYW5kIGZsYWdzLiBJdHMgcG9pbnRlcg0KPiBpcyBwdXQgaW4g
ZHJpdmVyX2RhdGEgb2YgaTJjX2RldmljZV9pZCwgd2hpY2ggbWFrZXMgYWRkaW5nIG5ldyBkZXZp
Y2UNCj4gbW9yZSBzdHJhaWdodGZvcndhcmQuDQo+IA0KDQo+IFNpZ25lZC1vZmYtYnk6IFNodW55
b25nIFlhbmcgPHNodW55b25nLnlhbmdAaHh0LXNlbWl0ZWNoLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogWGlhb3RpbmcgTGl1IDx4aWFvdGluZy5saXVAaHh0LXNlbWl0ZWNoLmNvbT4NCj4gLS0tDQo+
IHYyOg0KPiAgICBNb3ZlIHN0cnVjdCBwbWJ1c19kZXZpY2VfaW5mbyBkZWZpbml0aW9uIGxvY2F0
aW9uIGZyb20gcG1idXMuaCB0byBwbWJ1cy5jLg0KPiAgICBDaGFuZ2Ugc3RydWN0IG5hbWUgZnJv
bSBkZWZhdWx0X3BtYnVzX2luZm8gdG8gcG1idXNfaW5mb19vbmUuDQo+ICAgIENoYW5nZSBzdHJ1
Y3QgbmFtZSBmcm9tIHBtYnVzX2luZm8gdG8gcG1idXNfaW5mb196ZXJvLg0KPiAgICBSZXBsYWNl
IHN0cnVjdCBuYW1lIGRwczQ2MF9wbWJ1c19pbmZvIGFuZCBzZ2QwMDlfcG1idXNfaW5mbyB3aXRo
DQo+ICAgIHBtYnVzX2luZm9fb25lX3NraXAuDQo+IC0tLQ0KPiAgIGRyaXZlcnMvaHdtb24vcG1i
dXMvcG1idXMuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3BtYnVzL3BtYnVzLmMgYi9kcml2
ZXJzL2h3bW9uL3BtYnVzL3BtYnVzLmMNCj4gaW5kZXggNzY4OGRhYjMyZjZlLi5lMzhkZDk3Y2M0
OWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMvcG1idXMuYw0KPiArKysgYi9k
cml2ZXJzL2h3bW9uL3BtYnVzL3BtYnVzLmMNCj4gQEAgLTI4LDYgKzI4LDExIEBADQo+ICAgI2lu
Y2x1ZGUgPGxpbnV4L3BtYnVzLmg+DQo+ICAgI2luY2x1ZGUgInBtYnVzLmgiDQo+IA0KPiArc3Ry
dWN0IHBtYnVzX2RldmljZV9pbmZvIHsNCj4gKyAgICAgICBpbnQgcGFnZXM7DQo+ICsgICAgICAg
dTMyIGZsYWdzOw0KPiArfTsNCj4gKw0KPiAgIC8qDQo+ICAgICogRmluZCBzZW5zb3IgZ3JvdXBz
IGFuZCBzdGF0dXMgcmVnaXN0ZXJzIG9uIGVhY2ggcGFnZS4NCj4gICAgKi8NCj4gQEAgLTE3Miwx
MyArMTc3LDE1IEBAIHN0YXRpYyBpbnQgcG1idXNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCwNCj4gICAgICAgICAgc3RydWN0IHBtYnVzX2RyaXZlcl9pbmZvICppbmZvOw0KPiAgICAg
ICAgICBzdHJ1Y3QgcG1idXNfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBOVUxMOw0KPiAgICAgICAg
ICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmY2xpZW50LT5kZXY7DQo+ICsgICAgICAgc3RydWN0IHBt
YnVzX2RldmljZV9pbmZvICpkZXZpY2VfaW5mbzsNCj4gDQo+ICAgICAgICAgIGluZm8gPSBkZXZt
X2t6YWxsb2MoZGV2LCBzaXplb2Yoc3RydWN0IHBtYnVzX2RyaXZlcl9pbmZvKSwgR0ZQX0tFUk5F
TCk7DQo+ICAgICAgICAgIGlmICghaW5mbykNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVO
T01FTTsNCj4gDQo+IC0gICAgICAgaWYgKCFzdHJjbXAoaWQtPm5hbWUsICJkcHM0NjAiKSB8fCAh
c3RyY21wKGlkLT5uYW1lLCAiZHBzODAwIikgfHwNCj4gLSAgICAgICAgICAgIXN0cmNtcChpZC0+
bmFtZSwgInNnZDAwOSIpKSB7DQo+ICsgICAgICAgZGV2aWNlX2luZm8gPSAoc3RydWN0IHBtYnVz
X2RldmljZV9pbmZvICopaWQtPmRyaXZlcl9kYXRhOw0KPiArDQoNClBsZWFzZSBubyBlbXB0eSBs
aW5lIGJldHdlZW4gYXNzaWdubWVudHMgYW5kIGNoZWNraW5nIGl0cyByZXN1bHRzLg0KDQpPaywg
d2Ugd2lsbCByZW1vdmUgdGhlIGVtcHR5IGxpbmUuDQoNCj4gKyAgICAgICBpZiAoZGV2aWNlX2lu
Zm8tPmZsYWdzICYgUE1CVVNfU0tJUF9TVEFUVVNfQ0hFQ0spIHsNCj4gICAgICAgICAgICAgICAg
ICBwZGF0YSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZihzdHJ1Y3QgcG1idXNfcGxhdGZvcm1f
ZGF0YSksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5F
TCk7DQo+ICAgICAgICAgICAgICAgICAgaWYgKCFwZGF0YSkNCj4gQEAgLTE4NywzNiArMTk0LDQw
IEBAIHN0YXRpYyBpbnQgcG1idXNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4g
ICAgICAgICAgICAgICAgICBwZGF0YS0+ZmxhZ3MgPSBQTUJVU19TS0lQX1NUQVRVU19DSEVDSzsN
Cj4gICAgICAgICAgfQ0KPiANCj4gLSAgICAgICBpbmZvLT5wYWdlcyA9IGlkLT5kcml2ZXJfZGF0
YTsNCj4gKyAgICAgICBpbmZvLT5wYWdlcyA9IGRldmljZV9pbmZvLT5wYWdlczsNCj4gICAgICAg
ICAgaW5mby0+aWRlbnRpZnkgPSBwbWJ1c19pZGVudGlmeTsNCj4gICAgICAgICAgZGV2LT5wbGF0
Zm9ybV9kYXRhID0gcGRhdGE7DQo+IA0KPiAgICAgICAgICByZXR1cm4gcG1idXNfZG9fcHJvYmUo
Y2xpZW50LCBpZCwgaW5mbyk7DQo+ICAgfQ0KPiANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcG1i
dXNfZGV2aWNlX2luZm8gcG1idXNfaW5mb19vbmUgPSB7MSwgMH07DQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHBtYnVzX2RldmljZV9pbmZvIHBtYnVzX2luZm9femVybyA9IHswLCAwfTsNCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgcG1idXNfZGV2aWNlX2luZm8gcG1idXNfaW5mb19vbmVfc2tpcCA9
IHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxLCBQTUJVU19TS0lQX1NUQVRV
U19DSEVDS307DQo+ICAgLyoNCj4gICAgKiBVc2UgZHJpdmVyX2RhdGEgdG8gc2V0IHRoZSBudW1i
ZXIgb2YgcGFnZXMgc3VwcG9ydGVkIGJ5IHRoZSBjaGlwLg0KPiAgICAqLw0KPiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBwbWJ1c19pZFtdID0gew0KPiAtICAgICAgIHsiYWRw
NDAwMCIsIDF9LA0KPiAtICAgICAgIHsiYm1yNDUzIiwgMX0sDQo+IC0gICAgICAgeyJibXI0NTQi
LCAxfSwNCj4gLSAgICAgICB7ImRwczQ2MCIsIDF9LA0KPiAtICAgICAgIHsiZHBzODAwIiwgMX0s
DQo+IC0gICAgICAgeyJtZHQwNDAiLCAxfSwNCj4gLSAgICAgICB7Im5jcDQyMDAiLCAxfSwNCj4g
LSAgICAgICB7Im5jcDQyMDgiLCAxfSwNCj4gLSAgICAgICB7InBkdDAwMyIsIDF9LA0KPiAtICAg
ICAgIHsicGR0MDA2IiwgMX0sDQo+IC0gICAgICAgeyJwZHQwMTIiLCAxfSwNCj4gLSAgICAgICB7
InBtYnVzIiwgMH0sDQo+IC0gICAgICAgeyJzZ2QwMDkiLCAxfSwNCj4gLSAgICAgICB7InRwczQw
NDAwIiwgMX0sDQo+IC0gICAgICAgeyJ0cHM1NDRiMjAiLCAxfSwNCj4gLSAgICAgICB7InRwczU0
NGIyNSIsIDF9LA0KPiAtICAgICAgIHsidHBzNTQ0YzIwIiwgMX0sDQo+IC0gICAgICAgeyJ0cHM1
NDRjMjUiLCAxfSwNCj4gLSAgICAgICB7InVkdDAyMCIsIDF9LA0KPiArICAgICAgIHsiYWRwNDAw
MCIsIChrZXJuZWxfdWxvbmdfdCkmcG1idXNfaW5mb19vbmV9LA0KPiArICAgICAgIHsiYm1yNDUz
IiwgKGtlcm5lbF91bG9uZ190KSZwbWJ1c19pbmZvX29uZX0sDQo+ICsgICAgICAgeyJibXI0NTQi
LCAoa2VybmVsX3Vsb25nX3QpJnBtYnVzX2luZm9fb25lfSwNCj4gKyAgICAgICB7ImRwczQ2MCIs
IChrZXJuZWxfdWxvbmdfdCkmcG1idXNfaW5mb19vbmVfc2tpcH0sDQo+ICsgICAgICAgeyJkcHM4
MDAiLCAoa2VybmVsX3Vsb25nX3QpJnBtYnVzX2luZm9fb25lX3NraXB9LA0KPiArICAgICAgIHsi
bWR0MDQwIiwgKGtlcm5lbF91bG9uZ190KSZwbWJ1c19pbmZvX29uZX0sDQo+ICsgICAgICAgeyJu
Y3A0MjAwIiwgKGtlcm5lbF91bG9uZ190KSZwbWJ1c19pbmZvX29uZX0sDQo+ICsgICAgICAgeyJu
Y3A0MjA4IiwgKGtlcm5lbF91bG9uZ190KSZwbWJ1c19pbmZvX29uZX0sDQo+ICsgICAgICAgeyJw
ZHQwMDMiLCAoa2VybmVsX3Vsb25nX3QpJnBtYnVzX2luZm9fb25lfSwNCj4gKyAgICAgICB7InBk
dDAwNiIsIChrZXJuZWxfdWxvbmdfdCkmcG1idXNfaW5mb19vbmV9LA0KPiArICAgICAgIHsicGR0
MDEyIiwgKGtlcm5lbF91bG9uZ190KSZwbWJ1c19pbmZvX29uZX0sDQo+ICsgICAgICAgeyJwbWJ1
cyIsIChrZXJuZWxfdWxvbmdfdCkmcG1idXNfaW5mb196ZXJvfSwNCj4gKyAgICAgICB7InNnZDAw
OSIsIChrZXJuZWxfdWxvbmdfdCkmcG1idXNfaW5mb19vbmVfc2tpcH0sDQo+ICsgICAgICAgeyJ0
cHM0MDQwMCIsIChrZXJuZWxfdWxvbmdfdCkmcG1idXNfaW5mb19vbmV9LA0KPiArICAgICAgIHsi
dHBzNTQ0YjIwIiwgKGtlcm5lbF91bG9uZ190KSZwbWJ1c19pbmZvX29uZX0sDQo+ICsgICAgICAg
eyJ0cHM1NDRiMjUiLCAoa2VybmVsX3Vsb25nX3QpJnBtYnVzX2luZm9fb25lfSwNCj4gKyAgICAg
ICB7InRwczU0NGMyMCIsIChrZXJuZWxfdWxvbmdfdCkmcG1idXNfaW5mb19vbmV9LA0KPiArICAg
ICAgIHsidHBzNTQ0YzI1IiwgKGtlcm5lbF91bG9uZ190KSZwbWJ1c19pbmZvX29uZX0sDQo+ICsg
ICAgICAgeyJ1ZHQwMjAiLCAoa2VybmVsX3Vsb25nX3QpJnBtYnVzX2luZm9fb25lfSwNCj4gICAg
ICAgICAge30NCj4gICB9Ow0KPiANCj4gLS0NCj4gMS44LjMuMQ0KPiANCj4gDQo+IA0KPiANCj4g
VGhpcyBlbWFpbCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgbmFtZWQgYWRkcmVzc2VlLiBJdCBt
YXkgY29udGFpbiBpbmZvcm1hdGlvbiB0aGF0IGlzIGNvbmZpZGVudGlhbC9wcml2YXRlLCBsZWdh
bGx5IHByaXZpbGVnZWQsIG9yIGNvcHlyaWdodC1wcm90ZWN0ZWQsIGFuZCB5b3Ugc2hvdWxkIGhh
bmRsZSBpdCBhY2NvcmRpbmdseS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCwgeW91IGRvIG5vdCBoYXZlIGxlZ2FsIHJpZ2h0cyB0byByZXRhaW4sIGNvcHksIG9yIGRpc3Ry
aWJ1dGUgdGhpcyBlbWFpbCBvciBpdHMgY29udGVudHMsIGFuZCBzaG91bGQgcHJvbXB0bHkgZGVs
ZXRlIHRoZSBlbWFpbCBhbmQgYWxsIGVsZWN0cm9uaWMgY29waWVzIGluIHlvdXIgc3lzdGVtOyBk
byBub3QgcmV0YWluIGNvcGllcyBpbiBhbnkgbWVkaWEuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRo
aXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBwcm9tcHRseS4gVGhh
bmsgeW91Lg0KPiANCg0KSSB0aGluayBJIG1lbnRpb25lZCB0aGF0IGJlZm9yZS4gVGhpcyBsZWdh
bGVzZSBtYWtlcyBpdCBhbGwgYnV0IGltcG9zc2libGUNCmZvciBtZSB0byBhcHBseSB5b3VyIHBh
dGNoZXMuDQoNCldlIHdpbGwgbm90IHNob3cgdGhpcyBtZXNzYWdlIGFueSBtb3JlLg0KDQpUaGFu
a3MsDQpYaWFvdGluZw0KDQpHdWVudGVyDQoNCg0K
