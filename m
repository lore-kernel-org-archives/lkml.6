Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3923664-1526042675-2-15013951074952431015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526042675; b=l5DgRj0vOLjyJnBvfbM91Vfe3JquQOmiOYhOlSp7dGIkUw58a0
    7qRN5CB8vTQkGlfs8oKv/mYD/frZRGV5yFE4HYdq1LJgpeA2ElOjCK8CfMiHLRfv
    47j2pi9wdsqmlfKMdhYTHe8vekh/5+9YslFGS2GtR1JesphGHOkN9hPqMXswIYyX
    KhduvnF4z1UURPWgp4TxS/FoW11fOOlIfbPupQhi4rjLQm2eXkXvpg104XTff0uR
    vXksyAm45USRCgzdDGHTI9cM9QZPeH7YM1gwFC0uSfKpdoeUbr0HzTyu4ma2+71A
    zjcKKnLRe8Rffi6Z/FtiCfUphRj4gwaLRD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526042675; bh=KyUXvawQz5uattqB6YgoFMntMTQN3H7XV8HDfljxL/c=; b=
    H8bqoFRY2+86xwom+QmduY1ya6q41Qg8x/loyXiYwMKBN329exW8ckzsWw2LRDyS
    ogoK4aqiSd6iB/63zMEsVxzpVyjEzqxDxBDS14F8rqyU3FJHjlyfPvihEMU9Lvop
    W78K4q0fRxN+7bsfJ4JuvxBnCUuTk/v5WKujg7BDewKjQzwC3VadOhNfccVUbTKg
    Hq9rQ6EvnQ7Aj1kPejPPDHXeiWoR0Kj2CJqlC8xzdVfsKsAk9HlRWFv1Sh/kD/nr
    pIfLk0VogNobcHisHW7kDMo+qvXl6+H+s/8HneWi7iDmrZMRA79rVSMMfFksPZdk
    m1Cf7wssQK7nKmD7rcgW1Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
    header.i=@synopsys.com header.b=AlU+700e x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=synopsys.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
      header.i=@synopsys.com header.b=AlU+700e x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=synopsys.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMR+NYvxB0FkIyjym6tRkBIeycXiRETI596rJs1SuLplJSHZrec4xDAXmXjE8Pgg+mKFdBj3MBB1nSyqwIfqwKxG4yolbB0ToLNvP0eBc/T7FGkW7laT
    Xc2Jhe0TNWxPotZnBM/EPgOMpHzQNss0Ag0RkkgpSvjru/iWonoPFjoZnIIBoQZFYGdUhTs3fXB31R82TAhVWIOzhJV3AJSgit1T6W/1GN5UkxR1PkzwMlQW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=qJjIXQE9WAAA:10 a=IkcTkHD0fZMA:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=gfPmG6xZwV3XGw6L0kcA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEKMoc (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 08:44:32 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50454 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeEKMob (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 08:44:31 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "hch@lst.de" <hch@lst.de>
CC: "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 03/20] arc: use generic dma_noncoherent_ops
Thread-Topic: [PATCH 03/20] arc: use generic dma_noncoherent_ops
Thread-Index: AQHT6P6OnpXig9S2zE6C6YX6KW7bXqQqWA0A
Date: Fri, 11 May 2018 12:44:23 +0000
Message-ID: <1526042662.19036.31.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
         <20180511075945.16548-4-hch@lst.de>
In-Reply-To: <20180511075945.16548-4-hch@lst.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <971F7A34D96DA94FBA9D4F8C88AF4970@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgQ2hyaXN0b3BoLA0KDQpPbiBGcmksIDIwMTgtMDUtMTEgYXQgMDk6NTkgKzAyMDAsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPiBTd2l0Y2ggdG8gdGhlIGdlbmVyaWMgbm9uY29oZXJlbnQg
ZGlyZWN0IG1hcHBpbmcgaW1wbGVtZW50YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICBhcmNoL2FyYy9LY29uZmlnICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL0tidWlsZCAg
ICAgICAgfCAgIDEgKw0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCB8ICAy
MSAtLS0tLQ0KPiAgYXJjaC9hcmMvbW0vZG1hLmMgICAgICAgICAgICAgICAgICB8IDE0MSArKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCAxNDggZGVsZXRpb25zKC0pDQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMv
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaA0KDQpTb3JyeSBJIGRpZG4ndCB0cnkgeW91ciBwcm9w
b3NlZCBmaXggZWFybGllciAtIHdhcyBhd2F5IGZvciBhIGNvdXBsZSBvZiBkYXlzLg0KDQpCdXQg
dGhhdCBuZXdlciB2ZXJzaW9uIHdpdGggZml4ZWQgbGliL2RtYS1ub25jb2hlcmVudC5jIHN0aWxs
IGRvZXNuJ3Qgd29yayBvbiBBUkMuDQoNClVTQiBFQ0hJIGNvbnRyb2xsZXIgZmFpbHMgbGlrZSB0
aGF0Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KdXNiIDEtMTogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyBlaGNp
LXBsYXRmb3JtDQp1c2IgMS0xOiBjYW4ndCBzZXQgY29uZmlnICMxLCBlcnJvciAtMzINCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQWdhaW4g
d2l0aCBlbnRpcmUgc2VyaWVzIHJldmVydGVkIFVTQiBzdGFydHMgdG8gd29yay4NCkxldCdzIHdh
aXQgZm9yIG90aGVyIGFyY2hlcyBwcmV2aW91c2x5IGFmZmVjdGVkIHRvIHVwZGF0ZSBvbiB0aGVp
ciBzdGF0dXMuDQoNCi1BbGV4ZXk=
