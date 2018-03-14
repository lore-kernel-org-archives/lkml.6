Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1913331-1521039245-2-14485707639894090935
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
    t=1521039245; b=lcINefPbMgn6MHaFmya3ep5NzSaEUGtL0tGsuV/LWYTavk4
    ikVhQr3M+hbBQyfIXRC3zvJGHIAktRKif3Ni7e3GSFmZoKhIvA8OKAsVToHS3egN
    dSEwigXHIqAO0EOzQu3p1XtgEZrpQNxLuhpXCk9VSeFzSpMLo1V0U56IpOvOXui0
    7Qnf85ZtZzz7qB+CA2zWDLwXFpqgLfR7nhV5PY0ax0ru1XrlVlEBh7KVpK/PgVz1
    5VmV34COzLGk9tkkfrF3vwj87eRxEnoqRpeZ18ivSqxVnRutMpOZFGEewaPyevuh
    worIiJfLriMZCkNmSsKUQIFJIg/Crmt0vDusEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521039245; bh=BIs+01Jd1CaneLOxTFgzaoFn30oB7rHmNXJo1y
    Vwack=; b=klUHEwZ+oCcidFjCiq38tFPHtf57JDeBeJ6SQOqTg506kxXfv2pcvu
    Oz7V6N3HcPsSYX0YQxJCv28UJ0/BhsUah97PCCzIONgA4H7qxtX+6q/a8Pq9QMy0
    XfLn+FUHVxEulnjoGv5aG7jLlaVo3ZbQK48Qr0lcSXgi57zHjHdkozCOWM4pCoZc
    mXvk8F4hZNVTge3kJIFi6BjqrpWHYvn+rkYb65Nd07viDyrbuauaqMcbdoqso8WZ
    NZG10gB1pLc8fBD9VCr4QKrQJ0IfjzytPdnSKyn0ZhHcsnw3W9K1ha5y3Cy2/HDx
    //WM/zXgBkbiIHiQZTujXgHYwWLvQFEA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1752244AbeCNOxw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 10:53:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8778 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751459AbeCNOxu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 10:53:50 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] ARM: dts: STi: Remove "console=ttyASN" from
 bootargs for STi boards
Thread-Topic: [PATCH v4 3/3] ARM: dts: STi: Remove "console=ttyASN" from
 bootargs for STi boards
Thread-Index: AQHTtjq1cNwqPqVpLkWcbhppylQHgKPPu22AgAAPuYA=
Date: Wed, 14 Mar 2018 14:53:17 +0000
Message-ID: <55befee5-dd68-c175-6d20-29ccda6f323f@st.com>
References: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
 <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
 <20180314135701.GA20286@kroah.com>
In-Reply-To: <20180314135701.GA20286@kroah.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <59513823E431AF4CA47FCC14B24FF83F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_07:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgR3JlZw0KDQpPbiAwMy8xNC8yMDE4IDAyOjU3IFBNLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBX
ZWQsIE1hciAwNywgMjAxOCBhdCAwNjozNTozNFBNICswMTAwLCBwYXRyaWNlLmNob3RhcmRAc3Qu
Y29tIHdyb3RlOg0KPj4gRnJvbTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3Qu
Y29tPg0KPj4NCj4+IEFzIHNlcmlhbCBpbnRlcmZhY2UgaXMgYWxyZWFkeSBzcGVjaWZpZWQgaW50
byBzdGRvdXQtcGF0aCBwcm9wZXJ0eSwNCj4+ICJjb25zb2xlPXR0eUFTTiwxMTUyMDAiIGZyb20g
Ym9vdGFyZ3MgY2FuIGJlIHJlbW92ZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGF0cmljZSBD
aG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0KPj4gLS0tDQo+PiB2NDogXyBub25lDQo+
PiB2MzogXyByZW1vdmUgImNvbnNvbGU9c2VyaWFsTiwxMTUyMDAiIGZyb20gYm9vdGFyZ3MgYW5k
IHVzZSBwcmVmZXJlZA0KPj4gICAgICAgIHN0ZG91dC1wYXRoIHByb3BlcnR5DQo+PiB2MjogXyBu
b25lDQo+Pg0KPiANCj4gVGhpcyBwYXRjaCBkb2VzIG5vdCBhcHBseSBhdCBhbGwsIGFyZSB5b3Ug
c3VyZSB5b3UgbWFkZSBpdCBjb3JyZWN0bHk/DQo+IA0KPiBDYW4geW91IHBsZWFzZSBmaXggaXQg
dXAgYW5kIHJlc2VuZD8NCg0KTm8gcHJvYmxlbSwgdGhlIHBhdGNoIGhhcyBqdXN0IGJlZW4gc2Vu
dC4NCg0KVGhhbmtzDQoNClBhdHJpY2UNCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgN
Cj4g
