Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1183928-1524214009-2-3368775795332297744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524214008; b=HBIuCQ77LWH3kRwkpC5fFnAu6AoNm2UUnIv3sBtPv80sJelYcB
    INgHHPRARaKhNWYZ6SFLaJkBFBaKPez73OEFZFEB3cRcLX0BbmhhN9bb7JNNKOwQ
    lkCnfKHsLnCVGShHzNXESsrjDMcNvffky2ogxc27NHrX3vo08RQ1n8aVFgzQiKhl
    wRei95y000zrCZHkv8hi/nz6I3j2vrrk3fBLe8DiF0Of37sMqD2Z/Evdfc2ARX0u
    JJuAz0BSSDKRjlrk+5P43CxWMMKdvs4GDj4rUUBTKx6ZmMoO3IrOo5XW8CpBKIrk
    CZVbOqbV5pHPSz2FaBJOwyPnjSv01PxqIM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524214008; bh=LlZHWY2caLsskdApzW0jRSVP+V5GkBbiovQMS2nae6o=; b=
    NrOZVdyje9Fz/XEYE03of7fGUTHYFvig920F6AAIlxfOFLpq/x/KW9rkPg165+jW
    157lXSl1N7YBv2V5PaQIpob92ADmqaNMMrgQI+48PH26v6BniIw20F9i1g4X33uQ
    A8EcKUvUXGTwjtwJIGn95CVYohwpAvrUHSCVeSVnaWX/o5NnX89LjAl9e5M2peya
    zcEEXPZ/XuFqEjTiFsZGicBqAScWJM4azGEt6Y6VjXKytGpA8a3aTRXWLkteXyGI
    yi0AiDRvojOxHYRTUFFlQI3opSeGSqNddmdnlPpSWFKc5YSuS5Xlsf0O2Yy+DekD
    ftsfMmEKRpveGaeBDmj9xw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGfAkIb54NsWavIuWqF9HUc0mQDIOiHq+wiWj0zqc9poMVQG7F2BpwoaEEznpiRGnhX8W4aoLrmHrpfalnpeWy0k5T83w5azYyYNX+QjTKqjScqnDXBe
    TeHM8SaNwNjEFyjTmiMvddn/vFPL2JkZsfDO3KUJv4EUaEZhXzUbU0cL/zUwDXgiqIe84uijdjBU/tgaqt5eHsvbbtpmNLKW5Vq/OCUw4og0aI4AMIrTdLvq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=sNq-o9mpgxkA:10 a=IkcTkHD0fZMA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=LDBv8-xUAAAA:8 a=8b9GpE9nAAAA:8
    a=VwQbUJbxAAAA:8 a=0oQILLyoOORbv9Wz_-kA:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=DZeXCJrVpAJBw65Qk4Ds:22 a=T3LWEMljR5ZiDmsYVIUa:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeDTIqr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 04:46:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9687 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754073AbeDTIqp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Apr 2018 04:46:45 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 53/61] tty: serial: simplify getting .drvdata
Thread-Topic: [PATCH 53/61] tty: serial: simplify getting .drvdata
Thread-Index: AQHT1+e4Pcsj6WqDyEil/XmiewhVVaQJNrsA
Date: Fri, 20 Apr 2018 08:46:13 +0000
Message-ID: <ed0d46b6-8fee-ac98-5fce-90f3c278b245@st.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.117]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0054C5B023B6904CA3010A56A486D780@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgV29sZnJhbQ0KDQpPbiAwNC8xOS8yMDE4IDA0OjA2IFBNLCBXb2xmcmFtIFNhbmcgd3JvdGU6
DQo+IFdlIHNob3VsZCBnZXQgZHJ2ZGF0YSBmcm9tIHN0cnVjdCBkZXZpY2UgZGlyZWN0bHkuIEdv
aW5nIHZpYQ0KPiBwbGF0Zm9ybV9kZXZpY2UgaXMgYW4gdW5uZWVkZWQgc3RlcCBiYWNrIGFuZCBm
b3J0aC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2Fu
Zy1lbmdpbmVlcmluZy5jb20+DQo+IC0tLQ0KPiANCj4gQnVpbGQgdGVzdGVkIG9ubHkuIGJ1aWxk
Ym90IGlzIGhhcHB5LiBQbGVhc2UgYXBwbHkgaW5kaXZpZHVhbGx5Lg0KPiANCj4gICBkcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMgICAgICAgICAgICAgIHwgMTggKysrKysrLS0tLS0tLS0tLS0tDQo+
ICAgZHJpdmVycy90dHkvc2VyaWFsL3Fjb21fZ2VuaV9zZXJpYWwuYyB8ICA2ICsrLS0tLQ0KPiAg
IGRyaXZlcnMvdHR5L3NlcmlhbC9zdC1hc2MuYyAgICAgICAgICAgfCAgNiArKy0tLS0NCj4gICBk
cml2ZXJzL3R0eS9zZXJpYWwveGlsaW54X3VhcnRwcy5jICAgIHwgIDYgKystLS0tDQo+ICAgNCBm
aWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
aW14LmMNCj4gaW5kZXggOTFmM2ExYTVjYjdmLi5mMzcwYzFjZjRmMjcgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14
LmMNCj4gQEAgLTI0MDgsOCArMjQwOCw3IEBAIHN0YXRpYyB2b2lkIGlteF91YXJ0X2VuYWJsZV93
YWtldXAoc3RydWN0IGlteF9wb3J0ICpzcG9ydCwgYm9vbCBvbikNCj4gICANCj4gICBzdGF0aWMg
aW50IGlteF91YXJ0X3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIHsNCj4g
LQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7
DQo+IC0Jc3RydWN0IGlteF9wb3J0ICpzcG9ydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYp
Ow0KPiArCXN0cnVjdCBpbXhfcG9ydCAqc3BvcnQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
ICANCj4gICAJaW14X3VhcnRfc2F2ZV9jb250ZXh0KHNwb3J0KTsNCj4gICANCj4gQEAgLTI0MjAs
OCArMjQxOSw3IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICAgDQo+ICAgc3RhdGljIGludCBpbXhfdWFydF9yZXN1bWVfbm9pcnEoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiAgIHsNCj4gLQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+IC0Jc3RydWN0IGlteF9wb3J0ICpzcG9ydCA9
IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiArCXN0cnVjdCBpbXhfcG9ydCAqc3BvcnQg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gICAJaW50IHJldDsNCj4gICANCj4gICAJcmV0ID0g
Y2xrX2VuYWJsZShzcG9ydC0+Y2xrX2lwZyk7DQo+IEBAIC0yNDM1LDggKzI0MzMsNyBAQCBzdGF0
aWMgaW50IGlteF91YXJ0X3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgDQo+
ICAgc3RhdGljIGludCBpbXhfdWFydF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICB7
DQo+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShk
ZXYpOw0KPiAtCXN0cnVjdCBpbXhfcG9ydCAqc3BvcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShw
ZGV2KTsNCj4gKwlzdHJ1Y3QgaW14X3BvcnQgKnNwb3J0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+ICAgCXVhcnRfc3VzcGVuZF9wb3J0KCZpbXhfdWFydF91
YXJ0X2RyaXZlciwgJnNwb3J0LT5wb3J0KTsNCj4gQEAgLTI0NTQsOCArMjQ1MSw3IEBAIHN0YXRp
YyBpbnQgaW14X3VhcnRfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgDQo+ICAgc3Rh
dGljIGludCBpbXhfdWFydF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIHsNCj4gLQlz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+
IC0Jc3RydWN0IGlteF9wb3J0ICpzcG9ydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0K
PiArCXN0cnVjdCBpbXhfcG9ydCAqc3BvcnQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gICAN
Cj4gICAJLyogZGlzYWJsZSB3YWtldXAgZnJvbSBpLk1YIFVBUlQgKi8NCj4gICAJaW14X3VhcnRf
ZW5hYmxlX3dha2V1cChzcG9ydCwgZmFsc2UpOw0KPiBAQCAtMjQ3MCw4ICsyNDY2LDcgQEAgc3Rh
dGljIGludCBpbXhfdWFydF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIA0KPiAgIHN0
YXRpYyBpbnQgaW14X3VhcnRfZnJlZXplKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICB7DQo+IC0J
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0K
PiAtCXN0cnVjdCBpbXhfcG9ydCAqc3BvcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsN
Cj4gKwlzdHJ1Y3QgaW14X3BvcnQgKnNwb3J0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAg
DQo+ICAgCXVhcnRfc3VzcGVuZF9wb3J0KCZpbXhfdWFydF91YXJ0X2RyaXZlciwgJnNwb3J0LT5w
b3J0KTsNCj4gICANCj4gQEAgLTI0ODAsOCArMjQ3NSw3IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRf
ZnJlZXplKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICANCj4gICBzdGF0aWMgaW50IGlteF91YXJ0
X3RoYXcoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIHsNCj4gLQlzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+IC0Jc3RydWN0IGlteF9wb3J0
ICpzcG9ydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiArCXN0cnVjdCBpbXhfcG9y
dCAqc3BvcnQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gICANCj4gICAJdWFydF9yZXN1bWVf
cG9ydCgmaW14X3VhcnRfdWFydF9kcml2ZXIsICZzcG9ydC0+cG9ydCk7DQo+ICAgDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvcWNvbV9nZW5pX3NlcmlhbC5jIGIvZHJpdmVycy90
dHkvc2VyaWFsL3Fjb21fZ2VuaV9zZXJpYWwuYw0KPiBpbmRleCA2NWZmNjY5MzczZDQuLjY2NTU4
ZDQyZDk4MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3Fjb21fZ2VuaV9zZXJp
YWwuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvcWNvbV9nZW5pX3NlcmlhbC5jDQo+IEBA
IC0xMDg1LDggKzEwODUsNyBAQCBzdGF0aWMgaW50IHFjb21fZ2VuaV9zZXJpYWxfcmVtb3ZlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgDQo+ICAgc3RhdGljIGludCBfX21heWJl
X3VudXNlZCBxY29tX2dlbmlfc2VyaWFsX3N5c19zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gICB7DQo+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRm
b3JtX2RldmljZShkZXYpOw0KPiAtCXN0cnVjdCBxY29tX2dlbmlfc2VyaWFsX3BvcnQgKnBvcnQg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gKwlzdHJ1Y3QgcWNvbV9nZW5pX3Nlcmlh
bF9wb3J0ICpwb3J0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAgCXN0cnVjdCB1YXJ0X3Bv
cnQgKnVwb3J0ID0gJnBvcnQtPnVwb3J0Ow0KPiAgIA0KPiAgIAl1YXJ0X3N1c3BlbmRfcG9ydCh1
cG9ydC0+cHJpdmF0ZV9kYXRhLCB1cG9ydCk7DQo+IEBAIC0xMDk1LDggKzEwOTQsNyBAQCBzdGF0
aWMgaW50IF9fbWF5YmVfdW51c2VkIHFjb21fZ2VuaV9zZXJpYWxfc3lzX3N1c3BlbmRfbm9pcnEo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQg
cWNvbV9nZW5pX3NlcmlhbF9zeXNfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
ICB7DQo+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2Rldmlj
ZShkZXYpOw0KPiAtCXN0cnVjdCBxY29tX2dlbmlfc2VyaWFsX3BvcnQgKnBvcnQgPSBwbGF0Zm9y
bV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gKwlzdHJ1Y3QgcWNvbV9nZW5pX3NlcmlhbF9wb3J0ICpw
b3J0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAgCXN0cnVjdCB1YXJ0X3BvcnQgKnVwb3J0
ID0gJnBvcnQtPnVwb3J0Ow0KPiAgIA0KPiAgIAlpZiAoY29uc29sZV9zdXNwZW5kX2VuYWJsZWQg
JiYgdXBvcnQtPnN1c3BlbmRlZCkgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFs
L3N0LWFzYy5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3N0LWFzYy5jDQo+IGluZGV4IDVmOWYwMWZh
YzZkZC4uNzk3MTk5N2NkZWFkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3Qt
YXNjLmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3N0LWFzYy5jDQo+IEBAIC04NDIsMTYg
Kzg0MiwxNCBAQCBzdGF0aWMgaW50IGFzY19zZXJpYWxfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAgI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiAgIHN0YXRpYyBpbnQg
YXNjX3NlcmlhbF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICB7DQo+IC0Jc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiAtCXN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gKwlz
dHJ1Y3QgdWFydF9wb3J0ICpwb3J0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAgDQo+ICAg
CXJldHVybiB1YXJ0X3N1c3BlbmRfcG9ydCgmYXNjX3VhcnRfZHJpdmVyLCBwb3J0KTsNCj4gICB9
DQo+ICAgDQo+ICAgc3RhdGljIGludCBhc2Nfc2VyaWFsX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ICAgew0KPiAtCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9y
bV9kZXZpY2UoZGV2KTsNCj4gLQlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0ID0gcGxhdGZvcm1fZ2V0
X2RydmRhdGEocGRldik7DQo+ICsJc3RydWN0IHVhcnRfcG9ydCAqcG9ydCA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiAgIA0KPiAgIAlyZXR1cm4gdWFydF9yZXN1bWVfcG9ydCgmYXNjX3VhcnRf
ZHJpdmVyLCBwb3J0KTsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwv
eGlsaW54X3VhcnRwcy5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYw0KPiBp
bmRleCBhYmNiNGQwOWEyZDguLjNlYzRlZmJmMjVhOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwveGls
aW54X3VhcnRwcy5jDQo+IEBAIC0xNDMwLDggKzE0MzAsNyBAQCBzdGF0aWMgaW50IGNkbnNfdWFy
dF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2aWNlKQ0KPiAgICNlbmRpZiAvKiAhIENPTkZJR19Q
TV9TTEVFUCAqLw0KPiAgIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgY2Ruc19ydW50aW1lX3N1
c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIHsNCj4gLQlzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+IC0Jc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiArCXN0cnVjdCB1YXJ0X3Bv
cnQgKnBvcnQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gICAJc3RydWN0IGNkbnNfdWFydCAq
Y2Ruc191YXJ0ID0gcG9ydC0+cHJpdmF0ZV9kYXRhOw0KPiAgIA0KPiAgIAljbGtfZGlzYWJsZShj
ZG5zX3VhcnQtPnVhcnRjbGspOw0KPiBAQCAtMTQ0MSw4ICsxNDQwLDcgQEAgc3RhdGljIGludCBf
X21heWJlX3VudXNlZCBjZG5zX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ICAgDQo+ICAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBjZG5zX3J1bnRpbWVfcmVzdW1lKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gICB7DQo+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiAtCXN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gKwlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAgCXN0cnVjdCBjZG5zX3VhcnQgKmNkbnNfdWFy
dCA9IHBvcnQtPnByaXZhdGVfZGF0YTsNCj4gICANCj4gICAJY2xrX2VuYWJsZShjZG5zX3VhcnQt
PnBjbGspOw0KPiANCg0KRm9yIHN0LWFzYzoNCg0KQWNrZWQtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8
cGF0cmljZS5jaG90YXJkQHN0LmNvbT4NCg0KVGhhbmtz
