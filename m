Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96085C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330FF20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Iu2XIRpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330FF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeH3ROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:14:49 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51026 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3ROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:14:48 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D404E24E0D52;
        Thu, 30 Aug 2018 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535634763; bh=0r577okg2iePe5QvFmgcHtM1Od5UnuKhXbLCtTFxLA4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Iu2XIRpvvOXrqP2CglGhwt1QIe/IkA9F5VjQBu05I968MnzdzVYBYifbson+em1iQ
         e/zFnyru/YLpiayw1Sm35QDXS7Z08CIBKvAcKbavkH3ru21YdZD3zkMWXkwmqxGsUV
         Y4fcNTBw6Sgr6sOQ+XjyDu7V+tEUCMQIQSY1PAKX+wuemQpS4F4OzIfdCMtTh+QWaO
         L8Wjl16HPfAa/ibqDjIXmQ3QDqFlQ3PmPQXi3p7PV7AmeNXtbP+VJ5e/aE7HHWJdHB
         0ESxqYe4+qsP1zn1YgcrurD81U/IqyrmcK6pSUnJSHUVmlp4wssIsQyyhmcJk8yz1B
         FrRSyV/GhzoZg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id B68455C7F;
        Thu, 30 Aug 2018 06:12:43 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 30 Aug 2018 06:12:43 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 30 Aug 2018 15:12:40 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys GPIO via CREG
 bindings
Thread-Topic: [PATCH v2 2/2] dt-bindings: Document the Synopsys GPIO via
 CREG bindings
Thread-Index: AQHUPsIhxB1AAPfufUm06BH0xqwcvqTVyOAAgAJeVAA=
Date:   Thu, 30 Aug 2018 13:12:39 +0000
Message-ID: <1535634758.4465.63.camel@synopsys.com>
References: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com>
         <20180828112721.28178-3-Eugeniy.Paltsev@synopsys.com>
         <20180829010230.GA16393@bogus>
In-Reply-To: <20180829010230.GA16393@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.36]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD686D552B71D340988D6C9C6B2A5231@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTI4IGF0IDIwOjAyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBBdWcgMjgsIDIwMTggYXQgMDI6Mjc6MjFQTSArMDMwMCwgRXVnZW5peSBQYWx0c2V2
IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBkb2N1bWVudGF0aW9uIG9mIGRldmljZSB0cmVl
IGJpbmRpbmdzIGZvciB0aGUgU3lub3BzeXMNCj4gPiBHUElPIHZpYSBDUkVHIGRyaXZlci4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBz
eW5vcHN5cy5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8v
c25wcyxjcmVnLWdwaW8udHh0ICAgIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vc25wcyxjcmVnLWdwaW8udHh0
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9ncGlvL3NucHMsY3JlZy1ncGlvLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9ncGlvL3NucHMsY3JlZy1ncGlvLnR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5lYjAyMmQ0NGNjZGENCj4gPiAtLS0gL2Rldi9udWxsDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vc25wcyxjcmVn
LWdwaW8udHh0DQo+ID4gQEAgLTAsMCArMSw0OSBAQA0KPiA+ICtHUElPIHZpYSBDUkVHIChDb250
cm9sIFJFR2lzZXJzKSBkcml2ZXINCj4gDQo+IEJpbmRpbmdzIGRvbid0IGRlc2NyaWJlIGRyaXZl
cnMuDQo+IA0KPiA+ICsNCj4gPiArVGhpcyBpcyBpcyBzaW5nbGUtcmVnaXN0ZXIgTU1JTyBHUElP
IGRyaXZlciB0byBjb250cm9sIHN1Y2ggc3RyYW5nZWx5IG1hcHBlZCANCj4gPiArb3V0cHV0czoN
Cj4gPiArDQo+ID4gKzMxICAgICAgICAgICAgMTEgICAgICAgIDggICAgICAgICA3ICAgICAgICA1
ICAgICAgICAgMCAgIDwgYml0IG51bWJlcg0KPiA+ICt8ICAgICAgICAgICAgICB8ICAgICAgICB8
ICAgICAgICAgfCAgICAgICAgfCAgICAgICAgIHwNCj4gPiArWyAgIG5vdCB1c2VkICAgfCBncGlv
LTEgfCBzaGlmdC0xIHwgZ3Bpby0wIHwgc2hpZnQtMCBdICAgPCAzMiBiaXQgTU1JTyByZWdpc3Rl
cg0KPiA+ICsgICAgICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgIF4NCj4gPiArICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICB3cml0ZSAweDIgPT0gc2V0IG91dHB1dCB0byAiMSIgKG9uKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgd3JpdGUgMHgzID09IHNldCBvdXRwdXQg
dG8gIjAiIChvZmYpDQo+ID4gKyAgICAgICAgICAgICAgICAgICB8DQo+ID4gKyAgICAgICAgICAg
IHdyaXRlIDB4MSA9PSBzZXQgb3V0cHV0IHRvICIxIiAob24pDQo+ID4gKyAgICAgICAgICAgIHdy
aXRlIDB4NCA9PSBzZXQgb3V0cHV0IHRvICIwIiAob2ZmKQ0KPiANCj4gV2hhdCBraW5kIG9mIGNy
YXp5IGgvdyBkZXNpZ25lciBkZXNpZ25lZCB0aGlzPw0KDQpBY3R1YWxseSB0aGlzIGZpZWxkcyBp
biByZWdpc3RlciBjb250cm9scyBzb21lIG11bHRpcGxleGVycywgd2hpY2ggd2Ugd2FudCB0byB1
c2UgYXMgSU8gcG9ydCwNCnNlZSB0aGUgZXhhbXBsZTogIA0KDQogICAgICAgICAgICAgICAgL3wN
CiAgICAgICAgICAgICAgIC8gfA0KICAgICAgICAgICAgICB8ICB8LS0tLS0tIHNvbWUgaW50ZXJu
YWwgbGluZSANCklPIFBJTiAtLS0tLS0tfCAgfC0tLS0tLSBsb2dpYyAwDQogICAgICAgICAgICAg
IHwgIHwtLS0tLS0gbG9naWMgMQ0KICAgICAgICAgICAgICB8ICB8LS0tLS0tIG5vdCB1c2VkDQog
ICAgICAgICAgICAgICBcIHwNCiAgICAgICAgICAgICAgIHxcfA0KICAgICAgICAgICAgICAgfA0K
ICAgICAgICAgICAgICAgQ1JFRyBmaWVsZA0KDQoNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoN
Cj4gPiArLSBjb21wYXRpYmxlIDogInNucHMsY3JlZy1ncGlvIg0KPiA+ICstIHJlZyA6IEV4YWN0
bHkgb25lIHJlZ2lzdGVyIHJhbmdlIHdpdGggbGVuZ3RoIDB4NC4NCj4gPiArLSAjZ3Bpby1jZWxs
cyA6IFNob3VsZCBiZSBvbmUgLSB0aGUgcGluIG51bWJlci4NCj4gPiArLSBncGlvLWNvbnRyb2xs
ZXIgOiBNYXJrcyB0aGUgZGV2aWNlIG5vZGUgYXMgYSBHUElPIGNvbnRyb2xsZXIuDQo+ID4gKy0g
c25wcyxuZ3Bpb3M6IE51bWJlciBvZiBHUElPIHBpbnMuDQo+ID4gKy0gc25wcyxiaXQtcGVyLWxp
bmU6IE51bWJlciBvZiBiaXRzIHBlciBlYWNoIGdwaW8gbGluZSAoc2VlIHBpY3R1cmUpLg0KPiA+
ICsgIEFycmF5IHRoZSBzaXplIG9mICJzbnBzLG5ncGlvcyINCj4gPiArLSBzbnBzLHNoaWZ0OiBT
aGlmdCAoaW4gYml0cykgb2YgdGhlIGVhY2ggR1BJTyBmaWVsZCBmcm9tIHRoZSBwcmV2aW91cyBv
bmUgaW4NCj4gPiArICByZWdpc3RlciAoc2VlIHBpY3R1cmUpLiBBcnJheSB0aGUgc2l6ZSBvZiAi
c25wcyxuZ3Bpb3MiDQo+ID4gKy0gc25wcyxvbi12YWw6IFZhbHVlIHNob3VsZCBiZSBzZXQgaW4g
Y29ycmVzcG9uZGluZyBmaWVsZCB0byBzZXQNCj4gPiArICBvdXRwdXQgdG8gIjEiIChzZWUgcGlj
dHVyZSkuIEFycmF5IHRoZSBzaXplIG9mICJzbnBzLG5ncGlvcyINCj4gPiArLSBzbnBzLG9mZi12
YWw6IFZhbHVlIHNob3VsZCBiZSBzZXQgaW4gY29ycmVzcG9uZGluZyBmaWVsZCB0byBzZXQNCj4g
PiArICBvdXRwdXQgdG8gIjAiIChzZWUgcGljdHVyZSkuIEFycmF5IHRoZSBzaXplIG9mICJzbnBz
LG5ncGlvcyINCj4gDQo+IENvbnZpbmNlIG1lIHdlIG5lZWQgdG8gcGFyYW1ldGVyaXplIGFsbCB0
aGlzLiBXZSB0cnkgdG8gYXZvaWQgZGVzY3JpYmluZyANCj4gaC93IGxpa2UgdGhpcy4NCg0KV2Vs
bCwgSSBnb2luZyB0byB1c2UgdGhpcyBkcml2ZXIgb24gMyBhbHJlYWR5IHVwc3RyZWFtZWQgcGxh
dGZvcm1zIGFuZCBvbmUgdXBjb21pbmcuDQpUaGV5IGFsbCBoYXZlIHN1Y2ggQ1JFRyAnR1BJT3Mn
IGRpZmZlcmVudGx5IG1hcHBlZCB3aXRoIGRpZmZlcmVudCBJTyBsaW5lcyBudW1iZXIsDQpkaWZm
ZXJlbnQgZW5hYmxlL2Rpc2FibGUgdmFsdWUsIGV0Yy4uLg0KDQpTbyBJIHJlYWxseSB3YW50IHRv
IGNyZWF0ZSBzb21lIGdlbmVyaWMgYW5kIGNvbmZpZ3VyYWJsZSBkcml2ZXIgdG8gaGFuZGxlIGJv
dGggZXhpc3RpbmcNCmFuZCB1cGNvbWluZyBwbGF0Zm9ybXMuDQoNCj4gPiArDQo+ID4gK09wdGlv
bmFsIHByb3BlcnRpZXM6DQo+ID4gKy0gc25wcyxkZWZhdWx0LXZhbDogZGVmYXVsdCBvdXRwdXQg
ZmllbGQgdmFsdWVzLiBBcnJheSB0aGUgc2l6ZSBvZiAic25wcyxuZ3Bpb3MiDQo+ID4gKw0KPiA+
ICtFeGFtcGxlIChzZWUgcGljdHVyZSk6DQo+ID4gKw0KPiA+ICtncGlvOiBncGlvQGYwMDAxNGIw
IHsNCj4gPiArCWNvbXBhdGlibGUgPSAic25wcyxjcmVnLWdwaW8iOw0KPiA+ICsJcmVnID0gPDB4
ZjAwMDE0YjAgMHg0PjsNCj4gPiArCWdwaW8tY29udHJvbGxlcjsNCj4gPiArCSNncGlvLWNlbGxz
ID0gPDE+Ow0KPiA+ICsJc25wcyxuZ3Bpb3MgPSA8Mj47DQo+ID4gKwlzbnBzLHNoaWZ0ID0gPDUg
MT47DQo+ID4gKwlzbnBzLGJpdC1wZXItbGluZSA9IDwyIDM+Ow0KPiA+ICsJc25wcyxvbi12YWwg
PSA8MiAxPjsNCj4gPiArCXNucHMsb2ZmLXZhbCA9IDwzIDQ+Ow0KPiA+ICsJc25wcyxkZWZhdWx0
LXZhbCA9IDwyIDE+Ow0KPiA+ICt9Ow0KPiA+IC0tIA0KPiA+IDIuMTQuNA0KPiA+IA0KLS0gDQog
RXVnZW5peSBQYWx0c2V2
