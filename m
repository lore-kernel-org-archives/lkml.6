Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F45C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qYUnjWGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfAYSJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:09:39 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:11730 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfAYSJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548439778; x=1579975778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=RtN0eCVD+m2p7HBVUVMdxqA5xD4fsxlfDNU5Ef8Tk6w=;
  b=qYUnjWGrwzGlIKNbBHL0yxJsIqJxJlKLyN1k6QUYG5J5aAqStFIzmnXL
   IuTSWt0/EHXcYnd+tzzm22V694hT02zUMEgBsrrNDfZk17DbBB7KmJ5y9
   6pYsrVNDLA+ARr4GJgzGsHTxvnXTaPVBApp0/Mhd9JxZJkPOcANQlEPUi
   A=;
X-IronPort-AV: E=Sophos;i="5.56,522,1539648000"; 
   d="scan'208";a="714778832"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Jan 2019 18:09:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0PI9YE3026320
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 25 Jan 2019 18:09:36 GMT
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:09:34 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB003.ant.amazon.com (10.43.166.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:09:34 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 25 Jan 2019 18:09:33 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v5 04/13] KVM: Introduce a new guest mapping API
Thread-Topic: [PATCH v5 04/13] KVM: Introduce a new guest mapping API
Thread-Index: AQHUp/+fIW2FwIMK7UGPk3GrajXzfaW9ODUAgAMqCoA=
Date:   Fri, 25 Jan 2019 18:09:33 +0000
Message-ID: <1548439773.17444.16.camel@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
         <1547026933-31226-5-git-send-email-karahmed@amazon.de>
         <20190123175014.GK19289@Konrads-MacBook-Pro.local>
In-Reply-To: <20190123175014.GK19289@Konrads-MacBook-Pro.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.122]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE0D6C6394C44545949815A63256F93D@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAxLTIzIGF0IDEyOjUwIC0wNTAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsg
d3JvdGU6DQo+ID4gDQo+ID4gKwlpZiAoZGlydHkpDQo+ID4gKwkJa3ZtX3JlbGVhc2VfcGZuX2Rp
cnR5KG1hcC0+cGZuKTsNCj4gPiArCWVsc2UNCj4gPiArCQlrdm1fcmVsZWFzZV9wZm5fY2xlYW4o
bWFwLT5wZm4pOw0KPiA+ICsJbWFwLT5odmEgPSBOVUxMOw0KPiANCj4gSSBrZWVwIG9uIGhhdmlu
ZyB0aGlzIGduYXdpbmcgZmVlbGluZyB0aGF0IHdlIE1VU1Qgc2V0IG1hcC0+cGFnZSB0bw0KPiBO
VUxMLg0KPiANCj4gVGhhdCBpcyBJIGNhbiBzZWUgaG93IGl0IGlzIG5vdCBuZWVkZWQgaWYgeW91
IGFyZSB1c2luZyAnbWFwJyBhbmQNCj4gJ3VubWFwJyB0b2dldGhlciAtIGZvciB0aGF0IHdlIGFy
ZSBnb29kLiBCdXQgd2hhdCBJIGFtIHdvcnJpZWQgaXMgdGhhdA0KPiBzb21lIG9uZSB1bm1hcHMg
aXQgLi4gYW5kIGluc3RlYWQgb2YgY2hlY2tpbmcgbWFwLT5odmEgdGhleSBlbmQgdXANCj4gY2hl
Y2tpbmcgbWFwLT5wYWdlIGFuZCB0aGluayB0aGUgcGFnZSBpcyBtYXBwZWQuDQo+IA0KPiBXb3Vs
ZCB5b3UgYmUgT0sgYWRkaW5nIHRoYXQgZXh0cmEgc3RhdGVtZW50IGp1c3QgYXMgYSBmYWlsLXNh
ZmUNCj4gbWVjaGFuaXNtIGluIGNhc2Ugc29tZW9uZXMgbWlzdWVzIHRoZSBBUElzPw0KDQpHb29k
IHBvaW50LCB3aWxsIGRvLgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21i
SApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IENocmlzdGlh
biBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gKVXN0LUlEOiBERSAyODkgMjM3IDg3OQpFaW5nZXRy
YWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIKCg==

