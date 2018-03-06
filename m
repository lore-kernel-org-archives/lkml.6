Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-5053-1520330363-2-13050165594764122708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520330362; b=hI8ZdM+2Pb45oor3OwKmfTZ2+6/VoczWEIrZpcoZzV3LRiw
    Bpmbj6SEW+ITJU+hnXiptSpkeJ0urpOjrmStXN3540SFB+yP+UuFGukrP5w1KmTu
    voYe73jqeZBXcjaHWWx91G0UdYTjLzGhPbsV26yXls/u0cg2f2Min4O3CXfLAjic
    Yoj72roQCEsM8Iwki+jTXJ3ec31Bo6ss9UoDlpztSWAYHctrnQvmh8gTRVlHVWFu
    vhUqYqqfHhLNqjFwT/8uM3MJtlTv6/HauwMEns7JUy6wd94OvO+MrSTEc/dUs8cS
    eqsmY2xkPInnOU6PIxrlSMH+rbnRaE1+ERaAvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520330362; bh=m/1KGQgMEzCmHlcDmVLTEjuZh5drILc5pgSNPN
    k5wm4=; b=R9SrqTtprTsytBZ/NJZ6vmHDw24SsV7nCLXuzYm1uyGYgz8P71TgBz
    kUfaTqEQZ84SARFb6iLPmAhnHDAIBoOVdu1n6t9wFg9rpZq5xaego/XcUsn82Tqn
    cgb8IxL7xU4Ha2+oP0ZtzUNZ030O47lbrO5jqIAztF33Giz1Byl17JzWoQE8galt
    pkcJ9URwQueOH7/uhBvL+CJaVXC82MSKomMS+GaBPvGTP1TY518IE0EUfjjJ1Ny6
    sgBKNBUi+H8IW7UK0CFsDON7ut89Ef5589vYl0XsdzTSvU4FndyIKBBvDqgX6zqR
    LL02Rk37O6VgZtRNUQx/gUwpkhuhiI+Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1753335AbeCFJ7J (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 04:59:09 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42658 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750836AbeCFJ7H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Mar 2018 04:59:07 -0500
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
Subject: Re: [PATCH 0/2] Update interrupt names
Thread-Topic: [PATCH 0/2] Update interrupt names
Thread-Index: AQHTsIIPpjIbAcUZf0OKeLK3O9cgzKPC8Z0A
Date: Tue, 6 Mar 2018 09:58:38 +0000
Message-ID: <d855b529-be9b-13d9-8834-c2d0b7a16884@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AA9BE539F3A4A4AAAC39B354D85FF2F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_05:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgYWxsLA0KDQpPbiAwMi8yOC8yMDE4IDExOjUxIEFNLCBCaWNoIEhFTU9OIHdyb3RlOg0KPiBU
aGlzIHBhdGNoc2V0IHVwZGF0ZXMgZXhpc3Rpbmcgc3RtMzIgdXNhcnQgZHJpdmVyIGJ5IHVwZGF0
aW5nIGludGVycnVwdA0KPiBpbml0aWFsaXphdGlvbiBieSBuYW1lLg0KPiANCj4gQmljaCBIZW1v
biAoMik6DQo+ICAgIGR0LWJpbmRpbmdzOiBzZXJpYWw6IHN0bTMyOiBhZGQgd2FrZXVwIG9wdGlv
biB1c2luZyBub3RlDQo+ICAgIHNlcmlhbDogc3RtMzI6IHVwZGF0ZSBpbnRlcnJ1cHQgaW5pdGlh
bGl6YXRpb24NCj4gDQo+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nlcmlh
bC9zdCxzdG0zMi11c2FydC50eHQgfCA0ICsrKysNCj4gICBkcml2ZXJzL3R0eS9zZXJpYWwvc3Rt
MzItdXNhcnQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQgKystLQ0KPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCg0KUGxlYXNl
IG5vdGUgdGhhdCB0aGlzIHBhdGNoIHNldCBpcyBhYmFuZG9uZWQuIEFzIFJvYiBwb2ludGVkIHRo
YXQgb3V0LCANCnRoZSBpbnRlcnJ1cHQgaW5kaWNlcyBhcmUgZml4ZWQsIHNvIHRoZXJlIGlzIG5v
IG5lZWQgdG8ga2VlcCB0aGVzZSBwYXRjaGVzLg0KDQpCZXN0IHJlZ2FyZHMsDQoNCkJpY2g=
