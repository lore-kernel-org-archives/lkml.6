Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127C2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BE52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BE52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeGRHyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:54:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43387 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbeGRHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:54:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6I78mh9018631;
        Wed, 18 Jul 2018 09:17:50 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k88qvvga5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 18 Jul 2018 09:17:50 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAB9F38;
        Wed, 18 Jul 2018 07:17:48 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B92AA15A8;
        Wed, 18 Jul 2018 07:17:48 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Jul
 2018 09:17:48 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 18 Jul 2018 09:17:48 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Srinivas Kandagatla <srinivas.kandagatla@st.com>
CC:     Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] ARM: STi: warn if scu mapping fails
Thread-Topic: [PATCH V2] ARM: STi: warn if scu mapping fails
Thread-Index: AQHUHQwWlXZcUI9Rb0uhFLSZlc4VMaSUcz0A
Date:   Wed, 18 Jul 2018 07:17:48 +0000
Message-ID: <6cf0542b-cb50-33d4-25eb-51b7e303905d@st.com>
References: <1531748809-12540-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1531748809-12540-1-git-send-email-hofrat@osadl.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A0967D77C7A7E4E9ABCDA335EEDFA8E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljaG9sYXMNCg0KT24gMDcvMTYvMjAxOCAwMzo0NiBQTSwgTmljaG9sYXMgTWMgR3VpcmUg
d3JvdGU6DQo+ICAgSWYgdGhlIGRldmljZSBub2RlIGlzIG5vdCBmb3VuZCBvciB0aGUgb2ZfaW9t
YXAoKSBmYWlsZWQsIGNhbGxpbmcNCj4gc2N1X2VuYWJsZSB3b3VsZCBub3QgYmUgc2FmZSBhbmQg
Y291bGQgbGVhZCB0byBhbiB1bmRlZmluZWQgc3lzdGVtDQo+IHN0YXRlLiBTbyB3YXJuIGluIGJv
dGggZmFpbHVyZSBwYXRocyBiZWZvcmUgcmV0dXJuaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TmljaG9sYXMgTWMgR3VpcmUgPGhvZnJhdEBvc2FkbC5vcmc+DQo+IExpbms6IGh0dHA6Ly9sa21s
Lm9yZy9sa21sLzIwMTgvNy8xNi8yMTkNCj4gRml4ZXM6IGNvbW1pdCA2NWViY2MxMTU4ODkgKCJB
Uk06IHN0aTogQWRkIFNUaUg0MTUgU09DIHN1cHBvcnQiKQ0KPiAtLS0NCj4gDQo+IFYyOiByZXBs
YWNlbWVudCBvZiBXQVJOX09OKCkgYnkgYSBtZWFuaW5nZnVsIHByX2VyciBhcyBzdWdnZXN0ZWQg
YnkNCj4gICAgICBQYXRyaWNlIENIT1RBUkQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+Lg0KPiAN
Cj4gUHJvYmxlbSB3YXMgZm91bmQgYnkgYW4gZXhwZXJpbWVudGFsIGNvY2NpbmVsbGUgc2NyaXB0
DQo+IA0KPiBQYXRjaCB3YXMgY29tcGlsZSB0ZXN0ZWQgd2l0aDogbXVsdGlfdjdfZGVmY29uZmln
IChpbXBsaWVzDQo+IENPTkZJR19BUkNIX1NUST15LCBDT05GSUdfU01QPXkpDQo+ICh3aXRoIG9u
ZSBzcGFyc2Ugd2FybmluZyB1bnJlbGF0ZWQgdG8gdGhlIHByb3Bvc2VkIGNoYW5nZSkNCj4gDQo+
IFBhdGNoIGlzIGFnYWluc3QgNC4xOC1yYzQgKGxvY2FsdmVyc2lvbi1uZXh0IGlzIG5leHQtMjAx
ODA3MTYpDQo+IA0KPiAgIGFyY2gvYXJtL21hY2gtc3RpL3BsYXRzbXAuYyB8IDE4ICsrKysrKysr
KysrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtc3RpL3BsYXRzbXAuYyBi
L2FyY2gvYXJtL21hY2gtc3RpL3BsYXRzbXAuYw0KPiBpbmRleCAyMzFmMTllLi41MzBlOWE1IDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLXN0aS9wbGF0c21wLmMNCj4gKysrIGIvYXJjaC9h
cm0vbWFjaC1zdGkvcGxhdHNtcC5jDQo+IEBAIC0xMDcsMTIgKzEwNywyMiBAQCBzdGF0aWMgdm9p
ZCBfX2luaXQgc3RpX3NtcF9wcmVwYXJlX2NwdXModW5zaWduZWQgaW50IG1heF9jcHVzKQ0KPiAg
IA0KPiAgIAlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJhcm0sY29y
dGV4LWE5LXNjdSIpOw0KPiAgIA0KPiAtCWlmIChucCkgew0KPiAtCQlzY3VfYmFzZSA9IG9mX2lv
bWFwKG5wLCAwKTsNCj4gLQkJc2N1X2VuYWJsZShzY3VfYmFzZSk7DQo+IC0JCW9mX25vZGVfcHV0
KG5wKTsNCj4gKwlpZiAoIW5wKSB7DQo+ICsJCXByX2VycigiU0NVIG5vdCBmb3VuZCBhdCAlczol
cygpOiVkXG4iLA0KPiArCQkgICAgICAgX19GSUxFX18sIF9fZnVuY19fLCBfX0xJTkVfXyk7DQo+
ICsJCXJldHVybjsNCj4gICAJfQ0KPiAgIA0KPiArCXNjdV9iYXNlID0gb2ZfaW9tYXAobnAsIDAp
Ow0KPiArCW9mX25vZGVfcHV0KG5wKTsNCj4gKwlpZiAoIXNjdV9iYXNlKSB7DQo+ICsJCXByX2Vy
cigiU0NVIHJlbWFwIGZhaWxlZCBhdCAlczolcygpOiVkXG4iLA0KPiArCQkgICAgICAgX19GSUxF
X18sIF9fZnVuY19fLCBfX0xJTkVfXyk7DQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsNCj4gKwlz
Y3VfZW5hYmxlKHNjdV9iYXNlKTsNCj4gKw0KPiAgIAlpZiAobWF4X2NwdXMgPD0gMSkNCj4gICAJ
CXJldHVybjsNCj4gICANCj4gDQpBY2tlZC1ieTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNo
b3RhcmRAc3QuY29tPg0KDQpQYXRyaWNl
