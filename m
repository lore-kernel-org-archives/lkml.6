Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3158083-1519659233-2-3927419935850220659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519659233; b=wJ+6MELrYe5oaQ0bD6+uUH5Fo85LwsBJ7JeFfhQHAksVbA6
    BYiDULw4NK/rjhWYpTcxWBz4iSeouhtt3dvYNVS3h+utJrKV5Qfs2mxaULwMCpub
    d66rnl1iE2FU9fSsYu7PQ4Vmgj/QlzLFPFA1whPmA2KzlwySq5CKx9s1gxCkQQeH
    vll3EzwGq3GppAMx1JaDkAn24cEhx857D386SYqGF5F7hhDmvKU53DmljnaYKqGQ
    f6Ew/HIwqa+zyqRJNu0qPB3XquzCqP77pKTRNvrUozzSSZ8V1osOqD354B2vyLkJ
    2RDvnDvl5CFPRX3ssyqRh1ocS8ul6cJLCDtrfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1519659233; bh=hhrNf/UYzWxKRZh8cBwYqLS1zeZvK+B7vL6BnJ
    jzK+I=; b=vuYpTMIg8iIDqjbdlw2JnekYSgp+9D8wSO32HjsTlbF3rGNrjTPGOy
    9edPzz7TXOwfoTFBL9NxuaDG7N/59Mz7EgJytyH/tgVzFQQL2e9TjlruTDufUgvh
    bnmAKHnbopfAO5NYlAj3uCDI0jy/zVI4q+jty6Bz52RgHLQ+ARR4pkQUlps95wkb
    7Tg573zCjF8oyYR6eJ+40yNMQWQldkpVd06jMuom+tr/2BTHZogjj4T7y1FtToXd
    PghZUOAoGTQhJ+epK3fCOFWV1/0pepu7GjBjrGvHyc+xJOg7AJszhmDalPeLG7eA
    VONfGAgSuwJJW4hY7H94zsuYL35ETrww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBZPdu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 10:33:50 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:35175 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeBZPdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 10:33:49 -0500
From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Thread-Topic: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Thread-Index: AQHTrw7y5v+veqB6IUm1pHeksspcV6O2sHSAgAAJnQA=
Date: Mon, 26 Feb 2018 15:14:21 +0000
Message-ID: <1519658060.31245.4.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
         <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
         <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
In-Reply-To: <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEEEA117F9F34B4FA13761F6BF868230@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAyMDE4LTAyLTI2IGF0IDE2OjM5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI2LCAyMDE4IGF0IDQ6MzQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPEV2
Z2VuaXkuRGlkaW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBJbiBjb21taXQgNGMyMzU3ZjU3
ZGQ1ICgibW1jOiBkd19tbWM6IEZpeCB0aGUgQ1RPIHRpbWVvdXQgY2FsY3VsYXRpb24iKQ0KPiA+
IGhhdmUgYmVlbiBtYWRlIGNoYW5nZXMgd2hpY2ggY2FuIGNhdXNlIG11bHRpcGx5IG92ZXJmbG93
IGZvciAzMi1iaXQgc3lzdGVtcy4NCj4gPiBUaGUgdmFsdWUgb2YgY3RvX21zIGlzIGxvd2VyIHRo
ZSBkcnRvX21zLCBidXQgbmV2ZXJ0aGVsZXNzIG92ZXJmbG93IGNhbiBvY2N1ci4NCj4gPiBMZXRz
IGNhc3QgdGhpcyBtdWx0aXBseSB0byB1NjQgdHlwZSB3aGljaCBwcmV2ZW50cyBvdmVyZmxvdy4N
Cj4gPiAtwqDCoMKgwqDCoMKgwqBjdG9fbXMgPSBESVZfUk9VTkRfVVAoTVNFQ19QRVJfU0VDICog
Y3RvX2Nsa3MgKiBjdG9fZGl2LCBob3N0LT5idXNfaHopOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqBjdG9fbXMgPSBESVZfUk9VTkRfVVAoKHU2NClNU0VDX1BFUl9TRUMgKiBjdG9fY2xrcyAq
IGN0b19kaXYsIGhvc3QtPmJ1c19oeik7DQo+IA0KPiBJSVJDLCBzb21lb25lIGNvbW1lbnRlZCBv
biB0aGlzIG9yIHNpbWlsYXIsIGkuZS4NCj4gDQo+IERJVl9ST1VORF9VUF9VTEwoKSA/DQpTd2l0
Y2ggRElWX1JPVU5EX1VQIG1hY3JvIHRvIERJVl9ST1VORF9VUF9VTEwgaXMgbm90IHJlYXNvbmFi
bGUNCmJlY2F1c2Ugb3ZlcmZsb3cgaGFwcGVucyBvbiBtdWx0aXBseSBhbmQgRElWX1JPVU5EX1VQ
X1VMTCBoZWxwcw0Kd2l0aCBzdW0gb3ZlcmZsb3cuDQoNCi0tDQpCZXN0IHJlZ2FyZHMsDQpFdmdl
bml5IERpZGlu
