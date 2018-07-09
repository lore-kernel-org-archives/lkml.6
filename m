Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF95EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BC220877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GWmPIKtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BC220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeGIKYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:24:49 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43984 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeGIKYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:24:02 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6E46324E1F08;
        Mon,  9 Jul 2018 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531131841; bh=rtwneEDASmSQjfyIeuxZz3YLfm9xrdAOxHRZE4ZViP0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GWmPIKtS7O2qSOqOx6a9xDnebBjJXmtXL92igW6fSBjJkh3jFDzf5iRh3V9qRaEHw
         iI9DS4tuKwir+v1nzLVOKqDpET7hNnhgxQ2T9ZVLWnfLC9la+xK0iOcROFPMlP7dlV
         9nADL3MXw91n5mjy/zqgv0dKQ6y1mbDuRCdTQCbYvjXq0e/G01GCh1cVTemrbnHgii
         EViuuMayolOWirj5vSdRAlP5AEWc3zjj4tJ/SIzNdwSwmI/RaiLKECn3HtYBhDxDan
         euDmyExJi3ZgyBvpKO1+pe++6xWQywQCVHebjvnVv8N0bCPyNK5jJGNFkwHeXGruWC
         cm2RccYScGl5Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4E31F3C6A;
        Mon,  9 Jul 2018 03:24:01 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 03:24:01 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 12:23:59 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz+a+E6GQfxV7UuzGYUzCAFtDqSGew4AgAAL/YCAAAVTAIAAAX+A
Date:   Mon, 9 Jul 2018 10:23:58 +0000
Message-ID: <82d2b36fa913bca6d56c7bf32a653324970817b8.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
         <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
         <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
In-Reply-To: <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FE62AD68A7BDD4BA7A10A97E9CFE6D3@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxMDoxOCArMDAwMCwgRGF2aWQgTGFp
Z2h0IHdyb3RlOg0KPiBGcm9tOiBBbGV4ZXkgQnJvZGtpbg0KPiA+IFNlbnQ6IDA5IEp1bHkgMjAx
OCAxMTowMA0KPiANCj4gLi4uDQo+ID4gVGhhdCdzIGEgZ29vZCBpZGVhIGluZGVlZCBidXQgaXQg
ZG9lc24ndCBzb2x2ZSB0aGUgcHJvYmxlbSB3aXRoDQo+ID4gc3RydWN0IGRldnJlc19ub2RlLiBD
b25zaWRlciB0aGUgZm9sbG93aW5nIHNuaXBwZXQ6DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAJc3RydWN0
IG15c3RydWN0IHsNCj4gPiAJCWF0b21pYzY0X3QgbXl2YXI7DQo+ID4gCX0NCj4gPiANCj4gPiAJ
c3RydWN0IG15c3RydWN0ICpwOw0KPiA+IAlwID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpw
KSwgR0ZQX0tFUk5FTCk7DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiANCj4gPiBIZXJlIG15dmFyIGFkZHJl
c3Mgd2lsbCBtYXRjaCBhZGRyZXNzIG9mICJkYXRhIiBtZW1iZXIgb2Ygc3RydWN0IGRldnJlc19u
b2RlLg0KPiA+IFNvIGlmICJkYXRhIiBpcyBoYXMgb2Zmc2V0IG9mIDEyIGJ5dGVzIGZyb20gdGhl
IGJlZ2lubmluZyBvZiBhIHBhZ2UgdGhlbg0KPiA+IG15dmFyIHdvbid0IGJlIDY0LWJpdCBhbGln
bmVkIHJlZ2FyZGxlc3Mgb2YgbXl2YXIncyBhdHRyaWJ1dGUsIHJpZ2h0Pw0KPiANCj4gLi4uDQo+
ID4gPiA+IC0JdW5zaWduZWQgbG9uZyBsb25nCQlkYXRhW107CS8qIGd1YXJhbnRlZSB1bGwgYWxp
Z25tZW50ICovDQo+IA0KPiBBaGgsIHRoYXQgbGluZSBzaG91bGQgYmU6DQo+IAl1OCBkYXRhW10g
X19hbGlnbmVkKDgpOyAvKiBHdWFyYW50ZWUgNjRiaXQgYWxpZ25tZW50ICovDQoNCkFuZCB0aGF0
IHByZXR0eSBtdWNoIHdoYXQgSSBzdWdnZXN0ZWQgaW4gbXkgaW5pdGlhbCBwYXRjaCA6KQ0KDQpG
b3IgdGhlIHJlY29yZCB4ODYgaGFzIGV4YWN0bHkgdGhlIHNhbWUgYXRvbWljNjRfdCBhcyB5b3Ug
c3VnZ2VzdGVkLA0Kc2VlIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9z
b3VyY2UvYXJjaC94ODYvaW5jbHVkZS9hc20vYXRvbWljNjRfMzIuaCNMMTM6DQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0NCnR5cGVkZWYgc3RydWN0IHsNCgl1NjQg
X19hbGlnbmVkKDgpIGNvdW50ZXI7DQp9IGF0b21pYzY0X3Q7DQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0NCg0KLUFsZXhleQ==
