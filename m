Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-801052-1523271157-2-9862447282836138118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523271156; b=dxnbGougLFqtqP57gVRSHHVtMFkaNKG1H9+4G+ScRbZEKfNH/6
    TI83tY0RxliV+nBwHSVEaJthvJzfFDkBDkC8lumPohG5uQzfFozIUWSRu3ytkn1+
    zp7VaZj5f465NWkbM3DBgKmr9KeFKj2zNYmRrjY9OyZS4Sx3wZtt/K/MilurdoJE
    dsRbhuk2UAieMgcRgVimdCZMOifevwNJ7kPFP3N+zktLumk3FzjvpLQFUZl4ZQkL
    NPVU+aLFJeqBHpWd2UXS/1cwb3IUO/tTlguwYt7RpziYBBRQTalJtYGDuSpHI2sr
    1WRNgzDur60kbUP36iJaR6Yxzj/FaMkh4WRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523271156; bh=tihW4LCi2t3oorDrZ/aIwFwrJ0Mg7vqowTn0VXxrJaI=; b=
    Yr/5Bl+JgPCkdoWTElqEkZnE/ubqsj36z6vWhGem8/zOcBpKiJnl8rSLI/ujdiKe
    /9ElnWTye4a0nL9wbxm7JVEX9ePQBd6MpvqcDKUHzUnz8V5kvT+OPTDzc/Rk/d8i
    jewFuMqVX6iRkwzCg+kpt44PzF21hT0/xpOJZYwRGA4R9VUsNlSFNTZXkPInOlYk
    VoOUhGmjBlDZ+E3+6SmgsRkd82W1kIyWYy/pDhz2eiqjjw1xz3ZCMqphiY0T656a
    kjgpqHwlOqJC5h0v4EbP1DYf9QopI8V/ZEZExeGPgns3XWYX/+HTN1uJ3VmZtZkV
    w6PDHW5PlPqKkwBGaWAhxg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHKuQUaJMCWtdm2tQPDdUM6v2h3V3qjVgzyOP/tkxcYK/7BZx/UFtS5GZOsvzisvxKnV9tHCuUaS40YI25PbCAbq7H+CHDBDujQwCVZ/2RV3uawR8pcn
    c8TP763ZvQKSncsGPTX/TLDzfZXghCrItY8/hc8i1Hid3vYGbY3bRVRDtMWZhhjayisfy5eyMxvo7OGj6UxhcI1lqBufjwg65w/eXLg5WU2k4Q/pA2wFqt8W
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=DM7CVjP5n48A:10 a=IkcTkHD0fZMA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=JfrnYn6hAAAA:8 a=51FQaGoHpXbnp16tlO0A:9
    a=QEXdDO2ut3YA:10 a=d-TKu0b8h70A:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDIKwP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 06:52:15 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53637 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeDIKwN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 06:52:13 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sebott@linux.vnet.ibm.com" <sebott@linux.vnet.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: dma-mapping: clear harmful GFP_* flags in common code
Thread-Topic: dma-mapping: clear harmful GFP_* flags in common code
Thread-Index: AQHTz/DO6ni8/KLs20uKNIF21aVGhg==
Date: Mon, 9 Apr 2018 10:52:09 +0000
Message-ID: <1523271128.5268.32.camel@synopsys.com>
References: <20180328133535.17302-1-hch@lst.de>
         <20180328133535.17302-2-hch@lst.de> <1522249966.2593.14.camel@synopsys.com>
In-Reply-To: <1522249966.2593.14.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.57]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DA6D091281BFA4CA84A943AADC1B9D8@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGVsbG8sDQoNCk1heSB3ZSBoYXZlDQplODlmNWIzNzAxNTMgKCJkbWEtbWFwcGluZzogRG9uJ3Qg
Y2xlYXIgR0ZQX1pFUk8gaW4gZG1hX2FsbG9jX2F0dHJzIikNCmJhY2stcG9ydGVkIHRvIDQuMTYg
a2VybmVsIGFzIGl0IGZpeGVzOg0KDQo1N2JmNWE4ICgiZG1hLW1hcHBpbmc6IGNsZWFyIGhhcm1m
dWwgR0ZQXyogZmxhZ3MgaW4gY29tbW9uIGNvZGUiKS4NCg0KRm9yIG1vcmUgaW5mbyBhYm91dCBp
bnRyb2R1Y2VkIHByb2JsZW0gc2VlIHRoaXMgdGhyZWFkOg0KaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXNucHMtYXJjLzIwMTgtTWFyY2gvMDAzNjUyLmh0bWwNCg0K
LUFsZXhleQ==
