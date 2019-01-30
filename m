Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DEAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B232086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Dab2vbll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfA3QqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:46:10 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:56424 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfA3QqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:46:09 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 5C91510C1B61;
        Wed, 30 Jan 2019 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548866769; bh=0VhV34ex2YBAspiQbHZUlbPFEfjZrtbG4Ia3dhJeRmk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Dab2vbll4pwcmInCtyGdBUsAwSea+gC/pcM7OM+2w6Oz53+zcBmJ3ppOGZ4ciQZTV
         L7Qe8bd/KeOZN1EWTNcf4g9Er6LapMct4Vrrvk3XnDQq7Yd8W7cI2YX1+WkaejHzvj
         tDp4suvxRJoKOai4FBW9j7cpgNr3cb8vuowigA5ZuF3ryywIbbuBT0dy3A9JjwpL2z
         Rixtgp29PSaHvDBG7bntTgpd2nLdCykq3V2eddaEhap8Rxc/QGPo0H++Uu10reGtpm
         JY93m8lvRYgyppGUJm4NQiNDEW6GXr9yujhiPdInv5OcILvx8Ns1cV9nyTMLy/uFo0
         ZYxwkU46laj7g==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 29AEAA0091;
        Wed, 30 Jan 2019 16:46:09 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 30 Jan 2019 08:44:46 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 30 Jan 2019 17:44:44 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 2/5] ARCv2: introduce unaligned access under a Kconfig
 option
Thread-Topic: [PATCH 2/5] ARCv2: introduce unaligned access under a Kconfig
 option
Thread-Index: AQHUt8BeHzz+RssMKU6Lsi/5+ID9zaXH9e0A
Date:   Wed, 30 Jan 2019 16:44:43 +0000
Message-ID: <1548866682.29008.31.camel@synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
         <20190129104942.31705-3-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075014642D58D@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014642D58D@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D83D6FA9F2FC104CB3B5454604622E2E@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAxLTI5IGF0IDIxOjQ0ICswMDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDEvMjkvMTkgMjo0OSBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiA+IEFzIG9mIHRv
ZGF5IHdlIGVuYWJsZSB1bmFsaWduZWQgYWNjZXNzIHVuY29uZGl0aW9uYWxseSBvbiBBUkN2Mi4N
Cj4gPiBMZXRzIG1vdmUgaXQgdW5kZXIgS2NvbmZpZyBvcHRpb24gc28gd2UgY2FuIGRpc2FibGUg
aXQgaW4gY2FzZSBvZg0KPiA+IHVzaW5nIEhXIGNvbmZpZ3VyYXRpb24gd2hpY2ggbGFja3Mgb2Yg
aXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBh
bHRzZXZAc3lub3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FyYy9LY29uZmlnICAgICAg
ICAgICAgICAgICAgICAgIHwgOCArKysrKysrKw0KPiA+ICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9p
cnFmbGFncy1hcmN2Mi5oIHwgNCArKysrDQo+ID4gIGFyY2gvYXJjL2tlcm5lbC9pbnRjLWFyY3Yy
LmMgICAgICAgICAgfCA0ICsrKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2luY2x1
ZGUvYXNtL2lycWZsYWdzLWFyY3YyLmggYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9pcnFmbGFncy1h
cmN2Mi5oDQo+ID4gaW5kZXggOGE0Zjc3ZWEzMjM4Li45YjkxMWUyYzZiMzEgMTAwNjQ0DQo+ID4g
LS0tIGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vaXJxZmxhZ3MtYXJjdjIuaA0KPiA+ICsrKyBiL2Fy
Y2gvYXJjL2luY2x1ZGUvYXNtL2lycWZsYWdzLWFyY3YyLmgNCj4gPiBAQCAtNDQsOCArNDQsMTIg
QEANCj4gPiAgI2RlZmluZSBBUkNWMl9JUlFfREVGX1BSSU8JMQ0KPiA+ICANCj4gPiAgLyogc2Vl
ZCB2YWx1ZSBmb3Igc3RhdHVzIHJlZ2lzdGVyICovDQo+ID4gKyNpZmRlZiBDT05GSUdfQVJDX1VT
RV9VTkFMSUdORURfTUVNX0FDQ0VTUw0KPiA+ICAjZGVmaW5lIElTQV9JTklUX1NUQVRVU19CSVRT
CShTVEFUVVNfSUVfTUFTSyB8IFNUQVRVU19BRF9NQVNLIHwgXA0KPiA+ICAJCQkJCShBUkNWMl9J
UlFfREVGX1BSSU8gPDwgMSkpDQo+ID4gKyNlbHNlDQo+ID4gKyNkZWZpbmUgSVNBX0lOSVRfU1RB
VFVTX0JJVFMJKFNUQVRVU19JRV9NQVNLIHwgKEFSQ1YyX0lSUV9ERUZfUFJJTyA8PCAxKSkNCj4g
PiArI2VuZGlmIC8qIENPTkZJR19BUkNfVVNFX1VOQUxJR05FRF9NRU1fQUNDRVNTICovDQo+IA0K
PiBJJ2QgcHJlZmVyIHRvIGNoYW5nZSB0aGUgZGVmaW5lIG9mIFNUQVRVU19BRF9NQVNLIGl0c2Vs
ZiBhbmQga2VlcCBhbGwgb2YgdGhpcw0KPiB1bmNoYW5nZWQgIQ0KPiANCg0KQWN0dWFsbHkgSSdk
IHByZWZlciB0byBsZWF2ZSBTVEFUVVNfQURfTUFTSyB1bnRvdWNoZWQuIE90aGVyd2lzZSB3ZSB3
aWxsIGltcGxpY2l0bHkgYXNzaWduDQp3cm9uZyB2YWx1ZSB0byBTVEFUVVNfQURfTUFTSyB3aGlj
aCBpcyBxdWl0ZSBtaXNsZWFkaW5nLg0KDQpCVFcsIFNUQVRVU19BRF9NQVNLIGlzIHVzZWQgaW4g
QVNNIGNvZGUgaW4gdjIgcGF0Y2ggYW5kIGl0IHNob3VsZG4ndCBiZSBkZXBlbmRlbnQgb24NCkNP
TkZJR19BUkNfVVNFX1VOQUxJR05FRF9NRU1fQUNDRVNTLg0KDQotLSANCiBFdWdlbml5IFBhbHRz
ZXY=
