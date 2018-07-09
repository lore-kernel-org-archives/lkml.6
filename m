Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECE3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE9D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IxEVO4Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeGIJ7l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:59:41 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:46796 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeGIJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:59:38 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7043210C0F75;
        Mon,  9 Jul 2018 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531130378; bh=UegEyE9SJ5W7kJ6midVfUseFKxXy6XtRbsu6I+EtJlA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IxEVO4GrTpMkDlaBdJXQpsd4MmV7fOz4zRtX3SqYfHVGdzthqMW5PI5M1PdN/bxkY
         ElwLcfcXsHSg6/JBW/qoFsSGdBiGZbFEjBuM3ec8M+Rwc0P638pW85K/vgqzA4jlT5
         ukwzhTtxiry1c8V50S+OA39DgnaRYcIP9WEznk9kHJfti2lCjOZ/NS3bcIyagG59qv
         KhetFXrPpglDIZFEUyCEHr0BpMqrn8i/Sa4RH90mPoQHlUGSUwxa8tDnQCLvR01v1s
         qTB/1kvrL25J4WZAfGkUKDUmscGtdhq8CMSjNT+3rpgaQAAgWIgK5EvTtK1jl1NzPt
         hK/hd73AAhXlw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 417275C84;
        Mon,  9 Jul 2018 02:59:38 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 02:59:37 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 11:59:36 +0200
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
Thread-Index: AQHUFz+a+E6GQfxV7UuzGYUzCAFtDqSGew4AgAAL/YA=
Date:   Mon, 9 Jul 2018 09:59:35 +0000
Message-ID: <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
In-Reply-To: <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B5B9CC9727DAC43BA3405D0BA84E0F2@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAwOToxNiArMDAwMCwgRGF2aWQgTGFp
Z2h0IHdyb3RlOg0KPiBGcm9tOiBBbGV4ZXkgQnJvZGtpbg0KPiA+IFNlbnQ6IDA5IEp1bHkgMjAx
OCAwNTo0NQ0KPiA+IERlcGVuZGluZyBvbiBBQkkgImxvbmcgbG9uZyIgdHlwZSBvZiBhIHBhcnRp
Y3VsYXIgMzItYml0IENQVQ0KPiA+IG1pZ2h0IGJlIGFsaWduZWQgYnkgZWl0aGVyIHdvcmQgKDMy
LWJpdHMpIG9yIGRvdWJsZSB3b3JkICg2NC1iaXRzKS4NCj4gPiBNYWtlIHN1cmUgImRhdGEiIGlz
IHJlYWxseSA2NC1iaXQgYWxpZ25lZCBmb3IgYW55IDMyLWJpdCBDUFUuDQo+ID4gDQo+ID4gQXQg
bGVhc3QgZm9yIDMyLWJpdCBBUkMgY29yZXMgQUJJIHJlcXVpcmVzICJsb25nIGxvbmciIHR5cGVz
DQo+ID4gdG8gYmUgYWxpZ25lZCBieSBub3JtYWwgMzItYml0IHdvcmQuIFRoaXMgbWFrZXMgImRh
dGEiIGZpZWxkIGFsaWduZWQgdG8NCj4gPiAxMiBieXRlcy4gV2hpY2ggaXMgc3RpbGwgT0sgYXMg
bG9uZyBhcyB3ZSB1c2UgMzItYml0IGRhdGEgb25seS4NCj4gPiANCj4gPiBCdXQgb25jZSB3ZSB3
YW50IHRvIHVzZSBuYXRpdmUgYXRvbWljNjRfdCB0eXBlIChpLmUuIHdoZW4gd2UgdXNlIHNwZWNp
YWwNCj4gPiBpbnN0cnVjdGlvbnMgTExPQ0tEL1NDT05ERCBmb3IgYWNjZXNzaW5nIDY0LWJpdCBk
YXRhKSB3ZSBlYXNpbHkgaGl0DQo+ID4gbWlzYWxpZ25lZCBhY2Nlc3MgZXhjZXB0aW9uLg0KPiAN
Cj4gU2hvdWxkbid0IHRoZXJlIGJlIGEgdHlwZWRlZiBmb3IgdGhlIGFjdHVhbCB0eXBlLg0KPiBQ
ZXJoYXBzIGl0IGlzIGV2ZW4gYXRvbWljNjRfdCA/DQo+IEFuZCBoYXZlIHRoZSBfX2FsaWduZWQo
OCkgYXBwbGllZCB0byB0aGF0IHR5cGVkZWYgPz8NCg0KVGhhdCdzIGEgZ29vZCBpZGVhIGluZGVl
ZCBidXQgaXQgZG9lc24ndCBzb2x2ZSB0aGUgcHJvYmxlbSB3aXRoDQpzdHJ1Y3QgZGV2cmVzX25v
ZGUuIENvbnNpZGVyIHRoZSBmb2xsb3dpbmcgc25pcHBldDoNCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoJc3RydWN0IG15
c3RydWN0IHsNCgkJYXRvbWljNjRfdCBteXZhcjsNCgl9DQoNCglzdHJ1Y3QgbXlzdHJ1Y3QgKnA7
DQoJcCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcCksIEdGUF9LRVJORUwpOw0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCg0KSGVyZSBteXZhciBhZGRyZXNzIHdpbGwgbWF0Y2ggYWRkcmVzcyBvZiAiZGF0YSIgbWVt
YmVyIG9mIHN0cnVjdCBkZXZyZXNfbm9kZS4NClNvIGlmICJkYXRhIiBpcyBoYXMgb2Zmc2V0IG9m
IDEyIGJ5dGVzIGZyb20gdGhlIGJlZ2lubmluZyBvZiBhIHBhZ2UgdGhlbg0KbXl2YXIgd29uJ3Qg
YmUgNjQtYml0IGFsaWduZWQgcmVnYXJkbGVzcyBvZiBteXZhcidzIGF0dHJpYnV0ZSwgcmlnaHQ/
DQoNCg0KPiA+IFRoYXQncyBiZWNhdXNlIGV2ZW4gb24gQ1BVcyBjYXBhYmxlIG9mIG5vbi1hbGln
bmVkIGRhdGEgYWNjZXNzIExML1NDDQo+ID4gaW5zdHJ1Y3Rpb25zIHJlcXVpcmUgc3RyaWN0IGFs
aWdubWVudC4NCj4gDQo+IC4uLg0KPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9kZXZyZXMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvYmFzZS9kZXZyZXMuYw0KPiA+IEBAIC0yNCw4ICsyNCwxMiBAQCBzdHJ1
Y3QgZGV2cmVzX25vZGUgew0KPiA+IA0KPiA+ICBzdHJ1Y3QgZGV2cmVzIHsNCj4gPiAgCXN0cnVj
dCBkZXZyZXNfbm9kZQkJbm9kZTsNCj4gPiAtCS8qIC0tIDMgcG9pbnRlcnMgKi8NCj4gPiAtCXVu
c2lnbmVkIGxvbmcgbG9uZwkJZGF0YVtdOwkvKiBndWFyYW50ZWUgdWxsIGFsaWdubWVudCAqLw0K
PiA+ICsJLyoNCj4gPiArCSAqIERlcGVuZGluZyBvbiBBQkkgImxvbmcgbG9uZyIgdHlwZSBvZiBh
IHBhcnRpY3VsYXIgMzItYml0IENQVQ0KPiA+ICsJICogbWlnaHQgYmUgYWxpZ25lZCBieSBlaXRo
ZXIgd29yZCAoMzItYml0cykgb3IgZG91YmxlIHdvcmQgKDY0LWJpdHMpLg0KPiA+ICsJICogTWFr
ZSBzdXJlICJkYXRhIiBpcyByZWFsbHkgNjQtYml0IGFsaWduZWQgZm9yIGFueSAzMi1iaXQgQ1BV
Lg0KPiANCj4gSnVzdDoNCj4gCS8qIGRhdGFbXSBtdXN0IGJlIDY0IGJpdCBhbGlnbmVkIGV2ZW4g
b24gMzIgYml0IGFyY2hpdGVjdHVyZXMNCj4gCSAqIGJlY2F1c2UgaXQgbWlnaHQgYmUgYWNjZXNz
ZWQgYnkgaW5zdHJ1Y3Rpb25zIHRoYXQgcmVxdWlyZQ0KPiAJICogYWxpZ25lZCBtZW1vcnkgYXJn
dW1lbnRzLg0KPiANCj4gPiArCSAqLw0KPiA+ICsJdW5zaWduZWQgbG9uZyBsb25nCQlkYXRhW10g
X19hbGlnbmVkKHNpemVvZih1bnNpZ25lZCBsb25nIGxvbmcpKTsNCj4gDQo+IE9uZSBkYXkgYXNz
dW1pbmcgdGhhdCAndW5zaWduZWQgbG9uZyBsb25nJyBpcyBleGFjdGx5IDY0IGJpdHMgd2lsbCBi
aXRlLg0KPiBUaGlzIHByb2JhYmx5IG91Z2h0IHRvIGJlIHU2NCAob3Igc2ltaWxhcikuDQoNCkkg
YWdyZWUuIEluaXRpYWxseSBJIHdhbnRlZCB0byBrZWVwIGFzIGZldyBjaGFuZ2VzIGFzIHBvc3Np
YmxlIGJ1dA0KSU1ITyBzd2l0Y2hpbmcgdG8gbW9yZSBwcmVkaWN0YWJsZSBkYXRhIHR5cGUgbWFr
ZXMgc2Vuc2UuDQoNCi1BbGV4ZXk=
