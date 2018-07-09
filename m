Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AAA2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JOil1Sr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AAA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGIOdc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:33:32 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51503 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbeGIOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:33:29 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 142E910C1AF0;
        Mon,  9 Jul 2018 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531146809; bh=DaNqrIiGrFaywrZeqLe+M5AR6aAgtPq2J6cOGeAOWLY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JOil1Sr/vdRaye7FsJiD2cLl/UvXH4XByBG0rMGpLHz+LO1kvBwqcJHWv/EzkBOx3
         L9MidER3vOVaWlUHxmbNXRs6zpu0hwefUdbaLWkpetTDR2b/juvfJgVlLsrvMtUQ3Y
         nB45uBgSZIMm+fUfJYzfEEzlbreO0s7YGesEH5GkSYl8gtidTwXyn7B8R4ovfIME1F
         mIwE9qczGfWbsQqVicoKRf1NB6Sij8OIx4XMEpl8yozhlmfao6N/yiFgj1SYZAA7E+
         mzWwo8SFZrFw7PRryeGXtW13XPUcArNeP8I7ADhiRnPfm6HtPVlDPp9okbpY4MQGtH
         rDS3GjpN90xJg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id EC1D7330D;
        Mon,  9 Jul 2018 07:33:28 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 07:33:28 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 16:33:26 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Topic: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Index: AQHUF4swC8s+UKwhqUSMtDZM6j3qZaSGy6yAgAABBQCAAAZHAA==
Date:   Mon, 9 Jul 2018 14:33:26 +0000
Message-ID: <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
         <20180709140717.GR2476@hirez.programming.kicks-ass.net>
         <20180709141056.GR2512@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709141056.GR2512@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B1B0798FF2934384504C10F3BF1D1F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNjoxMCArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA0OjA3OjE3UE0gKzAyMDAs
IFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA0OjQ1
OjUwUE0gKzAzMDAsIEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+ID4gLS0tIGEvZHJpdmVycy9i
YXNlL2RldnJlcy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiA+IEBA
IC0yNCw4ICsyNCwxMiBAQCBzdHJ1Y3QgZGV2cmVzX25vZGUgew0KPiA+ID4gIA0KPiA+ID4gIHN0
cnVjdCBkZXZyZXMgew0KPiA+ID4gIAlzdHJ1Y3QgZGV2cmVzX25vZGUJCW5vZGU7DQo+ID4gPiAt
CS8qIC0tIDMgcG9pbnRlcnMgKi8NCj4gPiA+IC0JdW5zaWduZWQgbG9uZyBsb25nCQlkYXRhW107
CS8qIGd1YXJhbnRlZSB1bGwgYWxpZ25tZW50ICovDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIGRh
dGFbXSBtdXN0IGJlIDY0IGJpdCBhbGlnbmVkIGV2ZW4gb24gMzIgYml0IGFyY2hpdGVjdHVyZXMN
Cj4gPiA+ICsJICogYmVjYXVzZSBpdCBtaWdodCBiZSBhY2Nlc3NlZCBieSBpbnN0cnVjdGlvbnMg
dGhhdCByZXF1aXJlDQo+ID4gPiArCSAqIGFsaWduZWQgbWVtb3J5IGFyZ3VtZW50cyBzdWNoIGFz
IGF0b21pYzY0X3QuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwl1OCBfX2FsaWduZWQoOCkJCQlkYXRh
W107DQo+ID4gPiAgfTsNCj4gPiANCj4gPiBTZWVpbmcgdGhhdCB0aGlzIGVuZHMgdXAgaW4gYSBz
ZW1pIGdlbmVyaWMgYWxsb2NhdGlvbiB0aGluZywgSSBkb24ndA0KPiA+IGZlZWwgdGhpcyBzaG91
bGQgYmUgZGlmZmVyZW50IGZyb20gQVJDSF9LTUFMTE9DX01JTkFMSUdOLg0KPiANCj4gSW4gZmFj
dCwgc2luY2UgYWxsb2NfZHIoKSB1c2VzIGttYWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUgZW50aXJl
IHRoaW5nLA0KPiBpdCBpcyBpbXBvc3NpYmxlIHRvIGd1YXJhbnRlZSBhIGxhcmdlciBhbGlnbm1l
bnQgdGhhbiBrbWFsbG9jIGRvZXMuDQoNCldlbGwgYnV0IDQtYnl0ZXMgW3doaWNoIGlzIGNyaXRp
Y2FsIGZvciBhdG9taWM2NF90XSBzaG91bGQgYmUgbXVjaCBsZXNzDQp0aGFuIGEgc2FuZSBjYWNo
ZSBsaW5lIGxlbmd0aCBzbyBhYm92ZSBzaG91bGQgd29yay4NCg0KLUFsZXhleQ==
