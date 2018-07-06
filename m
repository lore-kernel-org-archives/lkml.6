Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E38C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412F124001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IAphBGNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412F124001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeGFNG4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:06:56 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37051 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932679AbeGFNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:06:54 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AC80C10C1AA6;
        Fri,  6 Jul 2018 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530882414; bh=aoDOF05gr1ELn0Cz5RH0NsBbtV4CpTcjWaeDAxYni+E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IAphBGNHykq0bdL2gKqwNHYyam1r/wMzsaobMRpvdrVjT2ZS3LDuBIRkI0PeHEqKW
         ff9w9Z6PYiJxRYYvYJrZvJOSe+hLznKKy0xskftAxo8dhGE6Dw883B2AngeQRwkz2e
         GxPrSF/tCAIFtNHAv2a6qLfSKBnJ5DIMEegBbtBT/1lBJ5ndUVirkyJ9EMPC4WCF0p
         OlroH6kgBuhc/1OGb9d9shLf9/ffmOvUM5yP+ghuwRqfx0oTB/Y0EUrI8iW/z/cXe2
         +wxdLaGd8x25vSSbFFqSXxl9snY42EdM4aZvV24aWf6fHPzLev1yvb/BZlFdCdmdSP
         BhlsgyQtwBZKQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2D96F3B82;
        Fri,  6 Jul 2018 06:06:54 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 6 Jul 2018 06:06:54 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 6 Jul 2018 15:06:51 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Remove CONFIG_INITRAMFS_SOURCE from defconfigs
Thread-Topic: [PATCH] ARC: Remove CONFIG_INITRAMFS_SOURCE from defconfigs
Thread-Index: AQHT/ZZAQPzQLziQ006pkmMep2B7t6RTSz+AgC7sdAA=
Date:   Fri, 6 Jul 2018 13:06:51 +0000
Message-ID: <ebb7bf8e51d6d50ef950ad6c16bbf879b6f7ee75.camel@synopsys.com>
References: <20180606125938.12986-1-abrodkin@synopsys.com>
         <CAOi56cVxHKh4V1i8W8wS+n3E88UbzBiCo0PozhCeoN3YEnVmBw@mail.gmail.com>
In-Reply-To: <CAOi56cVxHKh4V1i8W8wS+n3E88UbzBiCo0PozhCeoN3YEnVmBw@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5183109314E7A440912D8D14AC38B207@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBXZWQsIDIwMTgtMDYtMDYgYXQgMDk6MzIgLTA3MDAsIEtldmluIEhp
bG1hbiB3cm90ZToNCj4gT24gV2VkLCBKdW4gNiwgMjAxOCBhdCA1OjU5IEFNLCBBbGV4ZXkgQnJv
ZGtpbg0KPiA8QWxleGV5LkJyb2RraW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBXZSB1c2Vk
IHRvIGhhdmUgcHJlLXNldCBDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSB3aXRoIGxvY2FsIHBhdGgN
Cj4gPiB0byBpbnRyYW1mcyBpbiBBUkMgZGVmY29uZmlncy4gVGhpcyB3YXMgcXVpdGUgY29udmVu
aWVudCBmb3INCj4gPiBpbi1ob3VzZSBkZXZlbG9wbWVudCBidXQgbm90IHRoYXQgY29udmVuaWVu
dCBmb3IgbmV3Y29tZXJzDQo+ID4gd2hvIG9idml1c2x5IGRvbid0IGhhdmUgZm9sZGVycyBsaWtl
ICJhcmNfaW5pdHJhbWZzIiBuZXh0IHRvDQo+ID4gdGhlIExpbnV4IHNvdXJjZSB0cmVlLiBXaGlj
aCBsZWFkcyB0byBxdWl0ZSBzdXJwcmlzaW5nIGZhaWx1cmUNCj4gPiBvZiBkZWZjb25maWcgYnVp
bGRpbmc6DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIC4uL3NjcmlwdHMvZ2VuX2luaXRyYW1mc19saXN0LnNo
OiBDYW5ub3Qgb3BlbiAnLi4vLi4vYXJjX2luaXRyYW1mc19ocy8nDQo+ID4gLi4vdXNyL01ha2Vm
aWxlOjU3OiByZWNpcGUgZm9yIHRhcmdldCAndXNyL2luaXRyYW1mc19kYXRhLmNwaW8uZ3onIGZh
aWxlZA0KPiA+IG1ha2VbMl06ICoqKiBbdXNyL2luaXRyYW1mc19kYXRhLmNwaW8uZ3pdIEVycm9y
IDENCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+IA0KPiA+IFNvIG5vdyB3aGVuIG1vcmUgYW5kIG1vcmUgcGVvcGxl
IHN0YXJ0IHRvIGRlYWwgd2l0aCBvdXIgZGVmY29uZmlncw0KPiA+IGxldCdzIG1ha2UgdGhlaXIg
bGlmZSBlYXNpZXIgd2l0aCByZW1vdmFsIG9mIENPTkZJR19JTklUUkFNRlNfU09VUkNFLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBzeW5vcHN5cy5j
b20+DQo+ID4gQ2M6IEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+DQo+ID4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4ZXkg
QnJvZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEtldmlu
IEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+DQo+IFRlc3RlZC1ieTogS2V2aW4gSGlsbWFu
IDxraGlsbWFuQGJheWxpYnJlLmNvbT4NCg0KQW55IGNoYW5jZSBmb3IgdGhpcyBvbmUgdG8gaGl0
IHVwc3RyZWFtIHNvbWV0aW1lIHNvb24/DQoNCi1BbGV4ZXk=
