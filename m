Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4009665-1520844702-2-4984072374774999522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520844701; b=on/KieKb1o74aNTLkBTwgAfuRgppZ6bvmBFZv7TJfN78Qmv
    Y90yipszRHcjwl6eetuPBqglvNbAsQPpSSN0gAm+fPUltXf8Qvc2FLNZo6mWAw9A
    zYSBnkxTVyD/cEpBBmtH1FQ0l0aspcz0y3pYhs6aJmWUPPW2WWZJOFKcXEWz5x/9
    Fop1VqDhQNOc7y3Q/TwU+rCOQ183Blho5jiQ5tWsZPtot04ml/LBp8v7498BIdjZ
    D68WhSCwQV4h+71/0rCgVa5WZeK7y0Og+FLKJUc5bXXKkPFsIC16vlJe7DYX3JP8
    dpEPd4taDZ4mnGSgrYNse5MoER/inLhwKnuntyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520844701; bh=F66002aVg4nq8ck+zK1h5tD3wdFADQgY1aUaxt
    rN3/Q=; b=skSpZKSPDX40fV836Im37zTye8mD6EbJ/o6ircH6yQQzYx30BK1Fo+
    ZnqwLDLD71ZaQfDNbXvlImlIQJ2NeXG/XWazj/rcfyxcASmnghZFr39p3rvsvVjF
    mqKwnj6SO/+JHOcb0jGU9X1isDA17YL8UtOez2F7LxKQE4iLuFfiEBPJrtvxQQny
    L/8K2YVDJmrvbCENFprM5JfEC9ol9zpGpO9lKuIck9XXyOWePa/QR3yfQ6KCwYtT
    /VMeVyorIofLKUMp90KoXVUx8KFdsC7hzoGO5XrYX4svkYxC6XNNTUb1F/hKdzU5
    SNAJnn3l/BYQk+H/IOb4OjXamK69pSjw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeCLIvA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 04:51:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34834 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751618AbeCLIui (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Mar 2018 04:50:38 -0400
From: Bich HEMON <bich.hemon@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
Thread-Topic: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
Thread-Index: AQHTsVj+oIHYuI2hpUGPrP1VhQsGlKPMSsOA
Date: Mon, 12 Mar 2018 08:50:03 +0000
Message-ID: <405c95e3-00e4-ad2a-f5b5-c5e7e2e5abdf@st.com>
References: <1519907380-15135-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1519907380-15135-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5627FA88C6B13438188C842E03EFC1C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_04:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgYWxsLA0KDQpPbiAwMy8wMS8yMDE4IDAxOjI5IFBNLCBCaWNoIEhFTU9OIHdyb3RlOg0KPiBN
YWtlIHN1cmUgdG8gYXBwbHkgdGhlIGNvcnJlY3QgcGluIHN0YXRlIGluIHN1c3BlbmQvcmVzdW1l
IGNhbGxiYWNrcy4NCj4gUHV0dGluZyBwaW5zIGluIHNsZWVwIHN0YXRlIHNhdmVzIHBvd2VyLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQmljaCBIZW1vbiA8YmljaC5oZW1vbkBzdC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jIHwgNCArKysrDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2Nhbi9tX2Nhbi9tX2Nhbi5jIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCj4gaW5k
ZXggMjU5NGY3Ny4uYTg2ZWY2OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL21fY2Fu
L21fY2FuLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCj4gQEAgLTE3
MDAsNiArMTcwMCw4IEBAIHN0YXRpYyBfX21heWJlX3VudXNlZCBpbnQgbV9jYW5fc3VzcGVuZChz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCQltX2Nhbl9jbGtfc3RvcChwcml2KTsNCj4gICAJfQ0K
PiAgIA0KPiArCXBpbmN0cmxfcG1fc2VsZWN0X3NsZWVwX3N0YXRlKGRldik7DQo+ICsNCj4gICAJ
cHJpdi0+Y2FuLnN0YXRlID0gQ0FOX1NUQVRFX1NMRUVQSU5HOw0KPiAgIA0KPiAgIAlyZXR1cm4g
MDsNCj4gQEAgLTE3MTAsNiArMTcxMiw4IEBAIHN0YXRpYyBfX21heWJlX3VudXNlZCBpbnQgbV9j
YW5fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAJc3RydWN0IG5ldF9kZXZpY2UgKm5k
ZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gICAJc3RydWN0IG1fY2FuX3ByaXYgKnByaXYg
PSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gICANCj4gKwlwaW5jdHJsX3BtX3NlbGVjdF9kZWZhdWx0
X3N0YXRlKGRldik7DQo+ICsNCj4gICAJbV9jYW5faW5pdF9yYW0ocHJpdik7DQo+ICAgDQo+ICAg
CXByaXYtPmNhbi5zdGF0ZSA9IENBTl9TVEFURV9FUlJPUl9BQ1RJVkU7DQo+IA0KDQpTb3JyeSwg
bXkgbWlzdGFrZS4gT2YgY291cnNlIHRoaXMgaXMgdGhlIHdyb25nIG1haWxpbmcgbGlzdC4gUGxl
YXNlIA0KaWdub3JlIHRoaXMgcGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCg0KQmljaA==
