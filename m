Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3288027-1519665286-2-1129697458609697126
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
    t=1519665285; b=ZsAgYrtCtaXMzgVyORQWCkuLqVsLDaSVTXBwjGym5jlKd24
    I2MY+UJls1c6AOSdZ75gfAS4MKCvW4rraLkMzM3sfH8+Dth6NlD9dk06GqlFVBCX
    P68cIhUuOegcykXkTMVatD63oM2AMfD61cyzMP3Sx7VMOdFY15QNj4gxaWM2IsYF
    qzr3LeNg9OIxYsxKsVQjdsCmgQlXY9qhWNMZqiBoBKksvDCtzG/51IruKzXEnmql
    1KjcbhAyonGDRlB2yUmArn5bc46Mn9Wp5boygMIjuOKOcPwWMgEES7m8Zkm8I5/N
    LmE4rWPC4/LlC6yoraFsVfhceQnMQ01TzJO6HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1519665285; bh=1X3imi97zb6Ut9lTYAh1JoYwzShYbFb5kkMphl
    I5yTA=; b=FjV7Kj1lHU05BTw6AqIwaiAHBWhBg9lprOPmrdCIRIsSLNsFL7nigR
    KjdeEgXAMKG+9ho50QeYqFaPpyRQC+6rbH3lBqbcqhT8Eto+aI9CTinBuTUQQQaV
    W97ukcKfPPqslXM2lgQYO1k69CM+LmJ+cmN9xgYwUKrOYfBJ/VaM5A8r+W0IOSJw
    48dwxB0chsK5fXhu1LtyfaC97QTkmF0IuNwX4CesZocBNzwup9IFYVLnzpVR2Gp4
    xqhUIwAlmuR9axTruAGvCpzCPfbaT4F2UvfjVo9ooKcPgkhVjr2MNo+GUxeTJ2yV
    Ud8IrgqiHZt1tqUxDtVLPuhTX4qIxMdQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBZROa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 12:14:30 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:37751 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeBZRO3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 12:14:29 -0500
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
Thread-Index: AQHTrw7y5v+veqB6IUm1pHeksspcV6O2sHSAgAAJnQCAABvLAIAABcOA
Date: Mon, 26 Feb 2018 17:14:26 +0000
Message-ID: <1519665265.31245.6.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
         <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
         <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
         <1519658060.31245.4.camel@synopsys.com>
         <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
In-Reply-To: <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCD185991A9D7A469EF6B385638C80C0@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uLCAyMDE4LTAyLTI2IGF0IDE4OjUzICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI2LCAyMDE4IGF0IDU6MTQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPEV2
Z2VuaXkuRGlkaW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTgtMDItMjYg
YXQgMTY6MzkgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+IE9uIE1vbiwgRmVi
IDI2LCAyMDE4IGF0IDQ6MzQgUE0sIEV2Z2VuaXkgRGlkaW4NCj4gPiA+IDxFdmdlbml5LkRpZGlu
QHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPiA+IEluIGNvbW1pdCA0YzIzNTdmNTdkZDUgKCJt
bWM6IGR3X21tYzogRml4IHRoZSBDVE8gdGltZW91dCBjYWxjdWxhdGlvbiIpDQo+ID4gPiA+IGhh
dmUgYmVlbiBtYWRlIGNoYW5nZXMgd2hpY2ggY2FuIGNhdXNlIG11bHRpcGx5IG92ZXJmbG93IGZv
ciAzMi1iaXQgc3lzdGVtcy4NCj4gPiA+ID4gVGhlIHZhbHVlIG9mIGN0b19tcyBpcyBsb3dlciB0
aGUgZHJ0b19tcywgYnV0IG5ldmVydGhlbGVzcyBvdmVyZmxvdyBjYW4gb2NjdXIuDQo+ID4gPiA+
IExldHMgY2FzdCB0aGlzIG11bHRpcGx5IHRvIHU2NCB0eXBlIHdoaWNoIHByZXZlbnRzIG92ZXJm
bG93Lg0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqBjdG9fbXMgPSBESVZfUk9VTkRfVVAoTVNFQ19Q
RVJfU0VDICogY3RvX2Nsa3MgKiBjdG9fZGl2LCBob3N0LT5idXNfaHopOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGN0b19tcyA9IERJVl9ST1VORF9VUCgodTY0KU1TRUNfUEVS
X1NFQyAqIGN0b19jbGtzICogY3RvX2RpdiwgaG9zdC0+YnVzX2h6KTsNCj4gPiA+IA0KPiA+ID4g
SUlSQywgc29tZW9uZSBjb21tZW50ZWQgb24gdGhpcyBvciBzaW1pbGFyLCBpLmUuDQo+ID4gPiAN
Cj4gPiA+IERJVl9ST1VORF9VUF9VTEwoKSA/DQo+ID4gDQo+ID4gU3dpdGNoIERJVl9ST1VORF9V
UCBtYWNybyB0byBESVZfUk9VTkRfVVBfVUxMIGlzIG5vdCByZWFzb25hYmxlDQo+ID4gYmVjYXVz
ZSBvdmVyZmxvdyBoYXBwZW5zIG9uIG11bHRpcGx5IGFuZCBESVZfUk9VTkRfVVBfVUxMIGhlbHBz
DQo+ID4gd2l0aCBzdW0gb3ZlcmZsb3cuDQo+IA0KPiBEaWQgeW91IHRyeSB0byBjb21waWxlIHlv
dXIgY29kZSBmb3IgMzItYml0IHRhcmdldD8NClllcywgd2UgaGF2ZSBjb21waWxlZCBjb2RlIGZv
ciAzMi1iaXQgc3lzdGVtLsKgDQpJIGFtIHdvbmRlcmluZyB3aHkgYXJlIHlvdSBhc2tpbmcgdGhh
dD8NCg0KLS0NCkJlc3QgcmVnYXJkcywNCkV2Z2VuaXkgRGlkaW4=
