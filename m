Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC120882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DC120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeGIKRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:17:07 -0400
Received: from smtp-out6.electric.net ([192.162.217.186]:51179 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGIKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:17:05 -0400
Received: from 1fcTE1-0003jI-Uf by out6d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcTE4-0003wm-US; Mon, 09 Jul 2018 03:17:00 -0700
Received: by emcmailer; Mon, 09 Jul 2018 03:17:00 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcTE1-0003jI-Uf; Mon, 09 Jul 2018 03:16:57 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Jul 2018 11:18:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Jul 2018 11:18:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Brodkin' <Alexey.Brodkin@synopsys.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz/Ztg2k3cQGIk2o/MVnG+7l9qSGmpBQ///9QYCAABVykA==
Date:   Mon, 9 Jul 2018 10:18:36 +0000
Message-ID: <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
 <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
In-Reply-To: <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IEJyb2RraW4NCj4gU2VudDogMDkgSnVseSAyMDE4IDExOjAwDQouLi4NCj4g
VGhhdCdzIGEgZ29vZCBpZGVhIGluZGVlZCBidXQgaXQgZG9lc24ndCBzb2x2ZSB0aGUgcHJvYmxl
bSB3aXRoDQo+IHN0cnVjdCBkZXZyZXNfbm9kZS4gQ29uc2lkZXIgdGhlIGZvbGxvd2luZyBzbmlw
cGV0Og0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAJc3RydWN0IG15c3RydWN0IHsNCj4gCQlhdG9taWM2NF90IG15
dmFyOw0KPiAJfQ0KPiANCj4gCXN0cnVjdCBteXN0cnVjdCAqcDsNCj4gCXAgPSBkZXZtX2t6YWxs
b2MoZGV2LCBzaXplb2YoKnApLCBHRlBfS0VSTkVMKTsNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEhlcmUg
bXl2YXIgYWRkcmVzcyB3aWxsIG1hdGNoIGFkZHJlc3Mgb2YgImRhdGEiIG1lbWJlciBvZiBzdHJ1
Y3QgZGV2cmVzX25vZGUuDQo+IFNvIGlmICJkYXRhIiBpcyBoYXMgb2Zmc2V0IG9mIDEyIGJ5dGVz
IGZyb20gdGhlIGJlZ2lubmluZyBvZiBhIHBhZ2UgdGhlbg0KPiBteXZhciB3b24ndCBiZSA2NC1i
aXQgYWxpZ25lZCByZWdhcmRsZXNzIG9mIG15dmFyJ3MgYXR0cmlidXRlLCByaWdodD8NCi4uLg0K
PiA+ID4gLQl1bnNpZ25lZCBsb25nIGxvbmcJCWRhdGFbXTsJLyogZ3VhcmFudGVlIHVsbCBhbGln
bm1lbnQgKi8NCg0KQWhoLCB0aGF0IGxpbmUgc2hvdWxkIGJlOg0KCXU4IGRhdGFbXSBfX2FsaWdu
ZWQoOCk7IC8qIEd1YXJhbnRlZSA2NGJpdCBhbGlnbm1lbnQgKi8NCg0KCURhdmlkDQoNCg==
