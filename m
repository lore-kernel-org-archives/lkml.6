Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76654C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2961C21A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AwpL1C6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2961C21A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeHFPeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:34:05 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:32822 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeHFPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:34:05 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5A0BF24E13A1;
        Mon,  6 Aug 2018 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533561899; bh=HWPVPG0b9E1tK64tmihvvipZeJt7j9bxEavrMjyWzXA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AwpL1C6c00Wz32kb5pCMOQHkW0Cm3RtwF6wP1LNmj5J3o8Oqk1ztCEf2qhvwaX3CM
         Hq4xv/6pzLtK5Z8ZuGdsHNxRwt0EWZZWVhlhhXbp7szni0/tECTVK97aOatiAsbGft
         emWbzwjxAXKNHISC3Bcy9hI6Px7Mns2qATmSq2EA0nNXShruGrit/IWH2tCu1t2+rn
         Ymm9Nz3BK3AyRs7LXJK63kP1lNR45Pb8RCbzgOOlzUsp8RMsYcZCA0Ubzo01c1qr3g
         z/NccfhTuhmnfB15AdvkmxPG0Nl258zq1G4vcRk2xGwgNQ0TilbE7FjpT7furZEInQ
         NY4t65kenxnFQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id ACC13569A;
        Mon,  6 Aug 2018 06:24:58 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 6 Aug 2018 06:24:58 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 6 Aug 2018 15:24:56 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARC: AXS10x/HSDK: Allow U-Boot to pass MAC-address to
 the kernel
Thread-Topic: [PATCH] ARC: AXS10x/HSDK: Allow U-Boot to pass MAC-address to
 the kernel
Thread-Index: AQHUKkphJA4fd9vL60ehYkv7kOD2taSym50A
Date:   Mon, 6 Aug 2018 13:24:56 +0000
Message-ID: <1533561894.32021.5.camel@synopsys.com>
References: <20180802101937.6202-1-abrodkin@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B089D74@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B089D74@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4E6042A1C81F54A915278050E0284FD@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBUaHUsIDIwMTgtMDgtMDIgYXQgMjE6NTggKzAwMDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMDgvMDIvMjAxOCAwMzoxOSBBTSwgQWxleGV5IEJyb2RraW4gd3Jv
dGU6DQo+ID4gT3RoZXJ3aXNlIGtlcm5lbCB1c2VzIHJhbmRvbSBNQUMgd2hpY2ggaXMgbm90IHZl
cnkgY29udmVuaWV0Lg0KPiANCj4gQ3VyaW91cyB3aGF0IGV4YWN0bHkgaXMgdGhlIGlzc3VlIC0g
d2h5IGRvZXMgdGhlIHVzZXIgY2FyZSB3aGF0IE1BQyBpcyBhc3NpZ25lZCA/DQo+IA0KPiA+IFdp
dGggdGhhdCBjaGFuZ2UgaW4gcGxhY2UgdXNlIG1pZ2h0IHNldCBkZXNpcmVkIE1BQyBpbiBVLUJv
b3QNCj4gPiB3aXRoICJzZXRlbnYgZXRoYWRkciAxMToyMjozMzo0NDo1NTo2NiIsIHNhdmUgZW52
aXJvbm1lbnQgYW5kDQo+ID4gdGhlbiBmcm9tIGJvb3QgdG8gYm9vdCB0aGUgc2FtZSBNQUMgd2ls
bCBiZSB1c2VkIGJ5IHRoZSBrZXJuZWwuDQo+ID4gDQo+IA0KPiBBbmQgd2hhdCBpZiBvbmUgaXMg
cnVubmluZyB3aXRob3V0IHVib290IC0gaXQgd2lsbCByZXNvcnQgdG8gYWxsIHplcm9zIHZzLiBy
YW5kb20NCj4geWV0IHdvcmtpbmcgTUFDID8NCj4gDQoNCklmIG9uZSBpcyBydW5uaW5nIHdpdGhv
dXQgdS1ib290IC0gaXQgd2lsbCByZXNvcnQgdG8gcmFuZG9tIE1BQyBhcyB3ZSBkb24ndCB0cmVh
dCANCiIwMDowMDowMDowMDowMDowMCIgYXMgYSB2YWxpZCBFdGhlcm5ldCBhZGRyZXNzLg0KDQpM
b29rIGF0IGZvbGxvd2luZyBsaW5rIGZvciBtb3JlIGRldGFpbHMuDQpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92NC4xOC1yYzgvc291cmNlL2luY2x1ZGUvbGludXgvZXRoZXJkZXZp
Y2UuaCNMMTg0DQoNCg0KQlRXOg0KVGVzdGVkLWJ5OiBFdmdlbml5IFBhbHRzZXYgPHBhbHRzZXZA
c3lub3BzeXMuY29tPg0KDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBsaW51eC1zbnBzLWFyYyBtYWlsaW5nIGxpc3QNCj4gbGludXgtc25w
cy1hcmNAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cC0zQV9fbGlzdHMuaW5mcmFkZWFkLm9yZ19tYWlsbWFuX2xpc3Rp
bmZvX2xpbnV4LTJEc25wcy0yRGFyYyZkPUR3SUNBZyZjPURQTDZfWF82SmtYRng3QVhXcUIwdGcm
cj1abEpODQo+IDFNcmlQVVRrQktDclBTeDY3R21hcGxFVUdjQUVrOXlQdENMZFVYSSZtPXBFZTMx
TXE0RkMyMFpCUTFTTUdkQ3Blc1BtUUZ5YVFDZHBZOS1OX2FXUmMmcz1sd0k3dlRxQW1iVlBIZGZN
el9GbE96ZkJEdnRZQ1FETC02cy1aMkZGcl9ZJmU9DQotLSANCiBFdWdlbml5IFBhbHRzZXY=
