Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-679374-1521133700-5-17591541270165540474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521133700; b=WsSM2483pJTMosz+39HZ6ajx0CQN26FGKi8x/lk/mWtspgB
    QeAvcYnWU9sIDOlV4kQdyJm6s8CeoJmOXw9yr+TjBq8C70T4SIalMQZbZ22wzFMb
    2LpZ6TucMjlVlwQhAmQVL0iouaOUdu4H9lNepWvcy1nuFDhOysCrNNSOmqdiMAmH
    alaQPCxVEK2AeMj6GqDlKKB97p3+kOEkhbcTeV+WliqMg0KHvn03ZDjgthG54vuu
    3glPyHmFehBDap/85LYRe93vCtKaviOzXfQZssUw18GzwSyFc08T9q8LrkIfVC6l
    CI8uhcswoOrxgipBqncJoAYDouo3T/heetoeGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521133700; bh=VeLE5NoK4u1SHA75lCP/jWvqCNCNRuyBWa01ahEpgV8=; b=m
    GUBPbnORd9paYkLX1Yb5ed/3tVNKY5N8YV9esb+2i5zsfPJYlkU4zVUptBZMRBMn
    ggGTumSDwgoVE3TGRmGar8a+7Y4PH1D4XJ1AVsfNE+5Q2J7WsuLa0Iq0YTHFMFEY
    MudAXDESHIWIT+bvNcDoIa/pj31LHuIdsJ2/Z3+s4kZb6Fj44dVLe1R3Z2GYzut8
    VVy8elY8ptZRHnuhLr9HLQhF8PKfryGZkLs/VSIR9Wy4YONFFpd8z8W5hgZxCjKf
    twL2cK9IcB8OL6nzvt7LuPqzfirorhImHxW41fLbJWuwu+12TQ4eklDOkwmIOD22
    qKuWaZez7t4ivQ32pCWZw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=Q3xyju18 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=Q3xyju18 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeCORID (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 13:08:03 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:22418 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbeCORIB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 13:08:01 -0400
X-IronPort-AV: E=Sophos;i="5.48,311,1517875200";
   d="scan'208";a="335973166"
From: "Shah, Amit" <aams@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen/pirq: fix error path cleanup when binding MSIs
Thread-Topic: [PATCH] xen/pirq: fix error path cleanup when binding MSIs
Thread-Index: AQHTsHU0jwsHO2BVC0WoTlOJqSC8JKPRn2MA
Date: Thu, 15 Mar 2018 17:07:52 +0000
Message-ID: <1521133672.18764.78.camel@amazon.com>
References: <20180228091903.99889-1-roger.pau@citrix.com>
In-Reply-To: <20180228091903.99889-1-roger.pau@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F376E8C3E2D2D4CAC44961614A6CBE3@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQpPbiBNaSwgMjAxOC0wMi0yOCBhdCAwOToxOSArMDAwMCwgUm9nZXIgUGF1IE1vbm5lIHdyb3Rl
Og0KPiBDdXJyZW50IGNsZWFudXAgaW4gdGhlIGVycm9yIHBhdGggb2YgeGVuX2JpbmRfcGlycV9t
c2lfdG9faXJxIGlzDQo+IHdyb25nLiBGaXJzdCBvZiBhbGwgdGhlcmUncyBhbiBvZmYtYnktb25l
IGluIHRoZSBjbGVhbnVwIGxvb3AsIHdoaWNoDQo+IGNhbiBsZWFkIHRvIHVuYmluZGluZyB3cm9u
ZyBJUlFzLg0KPiANCj4gU2Vjb25kbHkgSVJRcyBub3QgYm91bmQgd29uJ3QgYmUgZnJlZWQsIHRo
dXMgbGVha2luZyBJUlEgbnVtYmVycy4NCj4gDQo+IE5vdGUgdGhhdCB0aGVyZSdzIG5vIG5lZWQg
dG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIGJvdW5kIGFuZCB1bmJvdW5kDQo+IElSUXMgd2hlbiBm
cmVlaW5nIHRoZW0sIF9fdW5iaW5kX2Zyb21faXJxIHdpbGwgZGVhbCB3aXRoIGJvdGggb2YgdGhl
bQ0KPiBjb3JyZWN0bHkuDQo+IA0KPiBGaXhlczogNDg5MmM5YjRhZGE5ZjkgKCJ4ZW46IGFkZCBz
dXBwb3J0IGZvciBNU0kgbWVzc2FnZSBncm91cHMiKQ0KPiBSZXBvcnRlZC1ieTogSG9vbWFuIE1p
cmhhZGkgPG1pcmhhZGloQGFtYXpvbi5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFBhdSBN
b25uw6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPg0KPiAtLS0NCj4gQ2M6IEJvcmlzIE9zdHJvdnNr
eSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IENjOiBBbWl0IFNoYWggPGFhbXNAYW1hem9uLmNvbT4NCj4gQ0M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9y
Zw0KDQpUaGUgQ0MgdG8gc3RhYmxlIGdvdCBsb3N0IG9uIGNvbW1pdCwgc28gdGhpcyBkaWRuJ3Qg
YWN0dWFsbHkgbWFrZQ0KaXQgdG8gdGhlIHN0YWJsZSBxdWV1ZS4gwqBDYW4geW91IHBsZWFzZSBn
ZXQgaXQgcXVldWVkPw0KDQpUaGFua3MsDQpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1h
bnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFjaGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vuc3Ry
LiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBEci4gUmFsZiBIZXJicmljaCwg
Q2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERFMjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFtIEFt
dHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgo=
