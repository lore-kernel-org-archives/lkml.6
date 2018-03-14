Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2203218-1521048016-2-14150032534124267472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521048016; b=h9FA3N/OC+rTykYeC6hamkDmYePm+wBg8XWKXRuVLQeRqSB
    Jhuea6dwsDotTTeRXf9dWrAeUZi1V6H4WNpcV/dFUc/kTM+45yp+4hocoYwPE+oZ
    QKEFt3oiXTI+nbcO4tw15I5YI4LedlRz942SFtG1ORMitjFzxs/E5hcUAqF7CRv9
    1klj2A8yW05nIjelu753f3ISoj0dJ7d/NaASvgcJ8jd08XExKfAtltqmIYnWjmL6
    0QU2UdgBIucZJ31u8lNdVtdBDsKqr+m6TsbS9wY+N/mukOmBktdoVxToOqqMcW0/
    aIrYJS9OQtw0C8KFj1vGQhDZsUuioxoGrQU+a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521048016; bh=no6ECmIAXcvsTCN8FmYoGyWYzZJTICAt6nTIpz
    FxPCI=; b=JysF+NA2TKvtjI9YZprIkcnKXmweX6MV/4dc4xJ7+ZS+yvINcYiID4
    q4qxgAh6cXG2hYRgqNedE7bGPPMHyVcMOR81ntCk+wW+c5FH9obcYJ+oYGbO01BL
    jwrmQfMS8lXUEmJNm+fXh7ttFNu6kYjK3m3Stbl5tuck6qQTnBObQjLWk29+iPuS
    LKTdRg1u8IpHZPJPRt4L0iEbQrwh1N1BTvdhOfdWevhLJrGDX+Xb0gmjJFjECnJW
    CidWcvKS9m5NRjo2oIrHwv/y7Qimfug6gVFkh+9sfdO5Wx12WLlt18EjQYEyNQx1
    1X3y1IVXh+ibrFNou7zpr8DFAUrdCYFw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCNRUA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 13:20:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49003 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751362AbeCNRT6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 13:19:58 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [RESEND PATCH v4 3/3] ARM: dts: STi: Remove console=ttyASN from
 bootargs for STi boards] ARM: dts: STi: Remove "console=ttyASN" from bootargs
 for STi boards
Thread-Topic: [RESEND PATCH v4 3/3] ARM: dts: STi: Remove console=ttyASN from
 bootargs for STi boards] ARM: dts: STi: Remove "console=ttyASN" from bootargs
 for STi boards
Thread-Index: AQHTu7iWVCnNXxu9p0enlgZ7Wg96LQ==
Date: Wed, 14 Mar 2018 17:19:19 +0000
Message-ID: <315aff9e-506c-cbdc-874a-082c147fe81c@st.com>
References: <1521039159-16655-1-git-send-email-patrice.chotard@st.com>
In-Reply-To: <1521039159-16655-1-git-send-email-patrice.chotard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F55E529FEAD6FB48B630264F516092AE@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

U29ycnkNCg0KSSBqdXN0IG5vdGljZWQgIHRoYXQgdGhlIGNvbW1pdCBoZWFkZXIgaXMgY29ycnVw
dGVkDQpJIHdpbGwgcmVzZW5kIHRoaXMgcGF0Y2gNCg0KUGF0cmljZQ0KDQpPbiAwMy8xNC8yMDE4
IDAzOjUyIFBNLCBwYXRyaWNlLmNob3RhcmRAc3QuY29tIHdyb3RlOg0KPiBGcm9tOiBQYXRyaWNl
IENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQo+IA0KPiBBcyBzZXJpYWwgaW50ZXJm
YWNlIGlzIGFscmVhZHkgc3BlY2lmaWVkIGludG8gc3Rkb3V0LXBhdGggcHJvcGVydHksDQo+ICJj
b25zb2xlPXR0eUFTTiwxMTUyMDAiIGZyb20gYm9vdGFyZ3MgY2FuIGJlIHJlbW92ZWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+
DQo+IC0tLQ0KPiANCj4gdjQ6IF8gbm9uZQ0KPiB2MzogXyByZW1vdmUgImNvbnNvbGU9c2VyaWFs
TiwxMTUyMDAiIGZyb20gYm9vdGFyZ3MgYW5kIHVzZSBwcmVmZXJlZA0KPiAgICAgICAgc3Rkb3V0
LXBhdGggcHJvcGVydHkNCj4gdjI6IF8gbm9uZQ0KPiANCj4gICBhcmNoL2FybS9ib290L2R0cy9z
dGloNDA3LWIyMTIwLmR0cyB8IDIgKy0NCj4gICBhcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIy
MTIwLmR0cyB8IDIgKy0NCj4gICBhcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMjYwLmR0cyB8
IDIgKy0NCj4gICBhcmNoL2FybS9ib290L2R0cy9zdGloNDE4LWIyMTk5LmR0cyB8IDIgKy0NCj4g
ICA0IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWIyMTIwLmR0cyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL3N0aWg0MDctYjIxMjAuZHRzDQo+IGluZGV4IDM3ZjJkZGJmYTA5OS4uYTdh
MGY3NmU5Y2JjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWIyMTIw
LmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWIyMTIwLmR0cw0KPiBAQCAt
MTQsNyArMTQsNyBAQA0KPiAgIAljb21wYXRpYmxlID0gInN0LHN0aWg0MDctYjIxMjAiLCAic3Qs
c3RpaDQwNyI7DQo+ICAgDQo+ICAgCWNob3NlbiB7DQo+IC0JCWJvb3RhcmdzID0gImNvbnNvbGU9
dHR5QVMwLDExNTIwMCBjbGtfaWdub3JlX3VudXNlZCI7DQo+ICsJCWJvb3RhcmdzID0gImNsa19p
Z25vcmVfdW51c2VkIjsNCj4gICAJCWxpbnV4LHN0ZG91dC1wYXRoID0gJnNiY19zZXJpYWwwOw0K
PiAgIAl9Ow0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxMC1i
MjEyMC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMTIwLmR0cw0KPiBpbmRleCBh
NmYwMGE2Njg3YTkuLjZjNmI0Y2MzN2U5NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvc3RpaDQxMC1iMjEyMC5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxMC1i
MjEyMC5kdHMNCj4gQEAgLTE0LDcgKzE0LDcgQEANCj4gICAJY29tcGF0aWJsZSA9ICJzdCxzdGlo
NDEwLWIyMTIwIiwgInN0LHN0aWg0MTAiOw0KPiAgIA0KPiAgIAljaG9zZW4gew0KPiAtCQlib290
YXJncyA9ICJjb25zb2xlPXR0eUFTMCwxMTUyMDAgY2xrX2lnbm9yZV91bnVzZWQiOw0KPiArCQli
b290YXJncyA9ICJjbGtfaWdub3JlX3VudXNlZCI7DQo+ICAgCQlsaW51eCxzdGRvdXQtcGF0aCA9
ICZzYmNfc2VyaWFsMDsNCj4gICAJfTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL3N0aWg0MTAtYjIyNjAuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQxMC1iMjI2
MC5kdHMNCj4gaW5kZXggNjI3NzA0OTZlMzI4Li41MGQzNjc1ODM5MWMgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAtYjIyNjAuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL3N0aWg0MTAtYjIyNjAuZHRzDQo+IEBAIC0xNSw3ICsxNSw3IEBADQo+ICAgCWNvbXBh
dGlibGUgPSAic3Qsc3RpaDQxMC1iMjI2MCIsICJzdCxzdGloNDEwIjsNCj4gICANCj4gICAJY2hv
c2VuIHsNCj4gLQkJYm9vdGFyZ3MgPSAiY29uc29sZT10dHlBUzEsMTE1MjAwIGNsa19pZ25vcmVf
dW51c2VkIjsNCj4gKwkJYm9vdGFyZ3MgPSAiY2xrX2lnbm9yZV91bnVzZWQiOw0KPiAgIAkJbGlu
dXgsc3Rkb3V0LXBhdGggPSAmdWFydDE7DQo+ICAgCX07DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9ib290L2R0cy9zdGloNDE4LWIyMTk5LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0
aWg0MTgtYjIxOTkuZHRzDQo+IGluZGV4IDM2ZjQwZjU4MTU1ZC4uN2Y1ZjMyNTJiZmM3IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDE4LWIyMTk5LmR0cw0KPiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9zdGloNDE4LWIyMTk5LmR0cw0KPiBAQCAtMTQsNyArMTQsNyBAQA0K
PiAgIAljb21wYXRpYmxlID0gInN0LHN0aWg0MTgtYjIxOTkiLCAic3Qsc3RpaDQxOCI7DQo+ICAg
DQo+ICAgCWNob3NlbiB7DQo+IC0JCWJvb3RhcmdzID0gImNvbnNvbGU9dHR5QVMwLDExNTIwMCBj
bGtfaWdub3JlX3VudXNlZCI7DQo+ICsJCWJvb3RhcmdzID0gImNsa19pZ25vcmVfdW51c2VkIjsN
Cj4gICAJCWxpbnV4LHN0ZG91dC1wYXRoID0gJnNiY19zZXJpYWwwOw0KPiAgIAl9Ow0KPiAgIA0K
PiA=
