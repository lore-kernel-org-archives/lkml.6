Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-382436-1524057614-2-11247156866370606699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='COM', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524057614; b=nJPc6WwrUZiN40DFcIM+MwolE6DXkuJLl7gVjTJADao9skSIXa
    qzF8Jd3YVkWrUX/dn+YmK0OmJl5S0b0SylZxzRJpuwFxmGcKTQ+6p/2OEycMwYod
    rtYNF97J42heDJQfeYRVqgRt8TMS24s9PWgVxe1sawUh9RNi9QdAjzELYkJsAPFh
    x2ed3m7iXWjjpFEwCmjnEvbidJ/qepGd+6/mJCqUZPxECEMihESEu0+6QLD2zLbY
    bfc/2Py0zw1BuSxkOnnKOb65cOKoPRirQZFQKGJCqjSPHKnxWlOu7wpx+rozAMh4
    x3pNJWKvJ6u7iz+g1sycU/X0bEdKHMgujA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524057614; bh=EixijnPhZu
    RrthjsqOSBSNqdEkNtIzdy88T6gZ1LLa4=; b=pAJOQj/aUcEyp1OB+gcjKlI0EV
    oF2NaPTQyQcfW2KP1sWqlqEzjmnXrqS+YjYRbToVtUXbOEz+yHeGJ+eIeaD4VMNw
    UfR0CV7d3/zlwXv0BVRHe3DRLbAXY3SFfL3QMhoIBV0xcJNiV8aOXD+ls758rnIu
    gpnao1ekpcdo8ZxqfOBgG7bm9P/vZD/B6Aj+Q6o7Tl5ST6YejjlR05Fn/SpnUmd3
    d2Tf54PzWUpxV8kNgNRj5SdODyoBf6tDx2hc/4trt6rA5S3MwSkDKMlHUsCzcbYZ
    E4tkqZf46sMgnIowEf9efDnzqLvWrmzvIowQfeGeEPL0vmfEW3sdsuq8ol3g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=aculab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=aculab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNG/JyNy1nDivBw4O+EIird+7EqhrHU4734y+Y8t2mPcHFtOx7XxILxX3R0/KhK546Z1qoeceNBICvZ16pP8PS6NK4lsXxHcWmDHzQTe2q3PATEnblaL
    z3i0odbgBUCNwJJ6OirT8MSvKmprFh0SmYvIiR//Wjrkbys4/AhL656kJcMBJgOJiuCFPA6tte2n9S+8bo37bzzHzT+vdwX9rp30sfqVFkoOxB9Kdf2cDB+l
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=tAi6d84QYPMA:10 a=IkcTkHD0fZMA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8 a=DzXjDd6b9xqsc4LyiKcA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDRNUJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 09:20:09 -0400
Received: from smtp-out4.electric.net ([192.162.216.195]:64480 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeDRNUH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 09:20:07 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tom Talpey' <tom@talpey.com>,
        "longli@microsoft.com" <longli@microsoft.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Topic: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
Thread-Index: AQHT1wogTZ8+5HKvXUChG+baTPbyBKQGfjqg
Date: Wed, 18 Apr 2018 13:08:53 +0000
Message-ID: <e9e7f77032c5402e848de0293e4db3ee@AcuMS.aculab.com>
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
 <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
In-Reply-To: <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVG9tIFRhbHBleQ0KPiBTZW50OiAxOCBBcHJpbCAyMDE4IDEyOjMyDQouLi4NCj4gT24g
NC8xNy8yMDE4IDg6MzMgUE0sIExvbmcgTGkgd3JvdGU6DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9u
Z2xpQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBUaGUgZGF0YSBidWZmZXIgYWxsb2NhdGVkIG9u
IHRoZSBzdGFjayBjYW4ndCBiZSBETUEnZWQsIGFuZCBoZW5jZSBjYW4ndCBzZW5kDQo+ID4gdGhy
b3VnaCBSRE1BIHZpYSBTTUIgRGlyZWN0Lg0KPiANCj4gVGhpcyBjb21tZW50IGlzIGNvbmZ1c2lu
Zy4gQW55IHJlZ2lzdGVyZWQgbWVtb3J5IGNhbiBiZSBETUEnZCwgbmVlZCB0bw0KPiBzdGF0ZSB0
aGUgcmVhc29uIGZvciB0aGUgY2hvaWNlIGhlcmUgbW9yZSBjbGVhcmx5Lg0KDQpUaGUgc3RhY2sg
Y291bGQgYmUgYWxsb2NhdGVkIHdpdGggdm1hbGxvYygpLg0KSW4gd2hpY2ggY2FzZSB0aGUgcGFn
ZXMgbWlnaHQgbm90IGJlIHBoeXNpY2FsbHkgY29udGlndW91cyBhbmQgdGhlcmUgaXMgbm8NCihz
ZW5zaWJsZSkgY2FsbCB0byBnZXQgdGhlIHBoeXNpY2FsIGFkZHJlc3MgcmVxdWlyZWQgYnkgdGhl
IGRtYSBjb250cm9sbGVyDQoob3Igb3RoZXIgYnVzIG1hc3RlcikuDQoNCglEYXZpZA0KDQo=
