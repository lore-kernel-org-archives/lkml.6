Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1180C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F82620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YP5b8TeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F82620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeIKUdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:33:07 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57546 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:33:06 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B18A024E217A;
        Tue, 11 Sep 2018 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536679997; bh=qry1n0gonA1AI/i3uMnFc79qyBzXGKoYhpHcK0JsLh0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YP5b8TeC1HdzjrgFF72U9UTheMrZztg3RixIFHJFvEQwNGESj7/8A8HTN9PN4lUca
         WguOgzuZabuZru8suARmndwZwY1a9QwH0xXV7vS4ZKLnxkggGAQMqMTBHi1nR1S7Lj
         za70wR3sqaQ0mKJXKutQpgJdyVZGCBetMVjyCWToMpfbHxLFYHVFJHXDdKBgfbN9oK
         9e8AmkewByMYP0oSw9Svu8EkPLELLzGdN3qePdOHC593x0TiZ0v5pfQIQ68k5UHRfk
         eSUebf6kE+2JD0BoBhNoR7GQekx8oAc9k127Z/StqqqLjQkjvDOIOviR+RYT/T/bDX
         /o2iI7AfbbVoA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id BA4275727;
        Tue, 11 Sep 2018 08:33:15 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 11 Sep 2018 08:33:15 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 11 Sep 2018 17:33:12 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH] etnaviv: setup missing dma_mask
Thread-Topic: [PATCH] etnaviv: setup missing dma_mask
Thread-Index: AQHUOv/Kx28ev3LVKUWyWWo2jTZoNqTrMfeA
Date:   Tue, 11 Sep 2018 15:33:12 +0000
Message-ID: <1536679991.5041.23.camel@synopsys.com>
References: <20180823163839.14824-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180823163839.14824-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.37]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEC6C436A060A74EAAD0013B9AE0BBDC@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVjYXMsDQoNCk1heWJlIHlvdSBoYXZlIGFueSBjb21tZW50cyBvciByZW1hcmtzIGFib3V0
IHRoaXMgcGF0Y2g/IEFuZCBpZiB5b3UgZG9uJ3QgY291bGQgeW91IHBsZWFzZSBhcHBseSBpdC4N
Cg0KVGhhbmtzIQ0KDQpPbiBUaHUsIDIwMTgtMDgtMjMgYXQgMTk6MzggKzAzMDAsIEV1Z2VuaXkg
UGFsdHNldiB3cm90ZToNCj4gQXMgZm9yIHRvZGF5IGV0bmF2aXYgZGV2aWNlIGRvZXNuJ3Qgc2V0
dXAgZG1hX21hc2suDQo+IFRoZSBldG5hdml2IGRldmljZSBpcyBhIHZpcnR1YWwgZGV2aWNlIG5v
dCByZXByZXNlbnRlZCBpbiBEVA0KPiBzbyBtaXNzaW5nIGRtYV9tYXNrIGlzbid0IHNldHVwIGJ5
IGdlbmVyaWMgcGxhZm9ybSBjb2RlDQo+IChieSBvZl9kbWFfY29uZmlndXJlIGZ1bmN0aW9uKS4N
Cj4gDQo+IE1pc3NpbmcgZG1hX21hc2sgY2F1c2VzIGZhaWxzIGluIHNvbWUgZG1hIGNhY2hlIG9w
cyBmdW5jdGlvbnMuDQo+IEZvciBleGFtcGxlIGl0IGNhdXNlcyBmYWlscyBvbiBtYXBfKiBvcGVy
YXRpb25zIGluIGdlbmVyaWMNCj4gZG1hX25vbmNvaGVyZW50X29wcyBhbmQgZG1hX2RpcmVjdF9v
cHMuDQo+IA0KPiBXZSBmYWNlZCB3aXRoIHRoaXMgYmVoYXZpb3VyIGFmdGVyIHN3aXRjaGluZyBB
UkMgdG8gZ2VuZXJpYw0KPiBkbWFfbm9uY29oZXJlbnQgY2FjaGUgb3BzIHVzaW5nLg0KPiANCj4g
U28gZml4IHRoaXMgYnkgc2V0dGluZyBkbWFfbWFzayB2aWEgZG1hX2NvZXJjZV9tYXNrX2FuZF9j
b2hlcmVudCgpDQo+IA0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2QHN5
bm9wc3lzLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2Ry
di5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9k
cnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZHJ2LmMNCj4gaW5kZXggNTQw
YjU5ZmI0MTAzLi42OWQ4MDkzN2UwMjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9l
dG5hdml2L2V0bmF2aXZfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRu
YXZpdl9kcnYuYw0KPiBAQCAtNTkzLDcgKzU5Myw3IEBAIHN0YXRpYyBpbnQgZXRuYXZpdl9wZGV2
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjsNCj4gIAlzdHJ1Y3QgY29tcG9uZW50X21hdGNoICptYXRjaCA9IE5V
TEw7DQo+ICANCj4gLQlkbWFfc2V0X2NvaGVyZW50X21hc2soJnBkZXYtPmRldiwgRE1BX0JJVF9N
QVNLKDMyKSk7DQo+ICsJZG1hX2NvZXJjZV9tYXNrX2FuZF9jb2hlcmVudCgmcGRldi0+ZGV2LCBE
TUFfQklUX01BU0soMzIpKTsNCj4gIA0KPiAgCWlmICghZGV2LT5wbGF0Zm9ybV9kYXRhKSB7DQo+
ICAJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY29yZV9ub2RlOw0KLS0gDQogRXVnZW5peSBQYWx0c2V2
