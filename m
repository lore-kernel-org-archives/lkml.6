Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1495249-1525720351-2-16722726210506089694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525720349; b=HebZNO8kyOhLLnP9mtifE8VTcV/8PcrQDjUOFEdhVsXzDkHpvC
    cSRJJlOkhYls94/8Z/EfnqKoat6tqB1r4zWT8cN7l4FuzZDOltxB7ahW5MstVhf4
    k6nlAgc6AQNonwkZwA54JOFzf1Nd4mncqRxPXPvAYI81POsXcZVw1u1qyWXf2AXY
    OJGyzrjobl59+5RHva2EO7+Q2a2hOntZylFHSPwj/fSRJH8xygwF/bHc0Aoa7T0U
    gvBaMNZC5lp5Q1Qj1oYjhcJj0VrSJfRj67ixRLH8hqJ5Q7kJAKImxOWSTJiB5hut
    UTTgsjD4lJm/6yS1UOTFdWcK6n1mVOuR5vUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525720349; bh=ldl003uV5kDL1QLPG4moUQvWegMY2mEFZyArfe/XX2A=; b=
    aM/VUwGUPTUybo+iTdv6lCGzo+h3wwKljHbC676pzna9BsEayd75VT7e7V3Pgas5
    G0Pv2Kfb9/OY3DAj96mA0PRXSmoP/c1ltotE0l3kKHX+hdMe6OjYc5XJ8SPYO9sy
    3G6tSBOLRy1VUXJDEJfAQ7eOIIp7BcKMxLPmhs042j7NPQM2a/SxXigdnps/3Zt+
    Etu7uSaYuz3kjd04ZdXx3WTZwqfrafRcvMvuJQtoXTKoNei+bAKa3bSuxzB0IRZP
    /LGwflQyhPLNzm3EXUEREz5kYr2MP3ZYxFo5/F/gSp2CzeuLV/8JGjYTzu3kCYhT
    Y7O2Dowrdo7p3fSzTZcM5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.com
    header.i=@amazon.com header.b=gFznOUGT x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amazon.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.com
      header.i=@amazon.com header.b=gFznOUGT x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amazon.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDcN/M50W8bfK3VX/IT8CccUYhpZ9YG/IFekaT5AQaLEnyEnHGTbCJbDdby6yJ7h+JlLRYKZnTEdjkXw39xXXcoiG+IcKsFD7jQtDUEwvaPT+MbWvZ/c
    ha+iQboB9Jg3MuDOumiLbxgQzSjCE8KHA1ElRMZp54+yvPIX93O3okM26GZUkjo9zZg9kU/Z2ZrNkSWKJtDbJ7LQX7gtCg3V2xr8mL+ks1G6m75I3DurJfEi
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=2Vfq7ykRpsQA:10 a=IkcTkHD0fZMA:10
    a=O76VCmqbo-wA:10 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8 a=Bfqbt9Xgqvb8JkKIDpAA:9
    a=QEXdDO2ut3YA:10 a=wcPYYFxWKMAA:10 a=fkqBw3BD5RLjSgApC7jY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeEGTM1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 15:12:27 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:39255 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeEGTM0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 May 2018 15:12:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,375,1520899200";
   d="scan'208";a="677960183"
From: "van der Linden, Frank" <fllinden@amazon.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jgross@suse.com" <jgross@suse.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info
 remap
Thread-Topic: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info
 remap
Thread-Index: AQHT4+Qi8Y/Xj7e/qEORkG6cypvfEqQkZMKA//+4loCAAIVbgP//jtIA
Date: Mon, 7 May 2018 19:12:22 +0000
Message-ID: <93859B55-41C2-4AF2-9CD7-C8A8AB11097F@amazon.com>
References: <C508E5F5-024E-4F71-A91E-7BB0BE046F5D@amazon.com>
 <965354d1-e2e7-1764-a14e-bb4258b9ed13@oracle.com>
 <B3C02FE4-651D-4A89-90BB-78E389764688@amazon.com>
 <ab71bf69-5074-ca7d-ceb5-1b42b0a70457@oracle.com>
In-Reply-To: <ab71bf69-5074-ca7d-ceb5-1b42b0a70457@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.65]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A27F10D3DA154B41A56CB4DB1BFAD916@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCu+7v09uIDUvNy8xOCwgMTE6NTQgQU0sICJCb3JpcyBPc3Ryb3Zza3kiIDxib3Jpcy5vc3Ry
b3Zza3lAb3JhY2xlLmNvbT4gd3JvdGU6DQoNCiAgICANCiAgICBPSywgZmFpciBlbm91Z2guIFRo
aXMgc2hvdWxkIGdvIHRvIHN0YWJsZSBhcyB3ZWxsIEkgdGhpbmsgKDQuMTIrKSwNCiAgICBjb3B5
aW5nIHRoZW0uDQogICAgDQogICAgUmV2aWV3ZWQtYnk6IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMu
b3N0cm92c2t5QG9yYWNsZS5jb20+DQogICAgDQpHcmVhdCwgdGhhbmtzIEJvcmlzLg0KDQpGcmFu
aw0KDQo=
