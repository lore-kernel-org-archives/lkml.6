Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E368A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E368A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbeGIJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:53:20 -0400
Received: from smtp-out6.electric.net ([192.162.217.181]:62747 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeGIJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:53:19 -0400
Received: from 1fcSr5-0007Md-T5 by out6a.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcSr6-0007VI-Uq; Mon, 09 Jul 2018 02:53:16 -0700
Received: by emcmailer; Mon, 09 Jul 2018 02:53:16 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6a.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcSr5-0007Md-T5; Mon, 09 Jul 2018 02:53:15 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Jul 2018 10:54:54 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Jul 2018 10:54:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Greg KH <greg@kroah.com>, Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>
Subject: RE: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz/Ztg2k3cQGIk2o/MVnG+7l9qSGmpBQ///zH4CAABiMsA==
Date:   Mon, 9 Jul 2018 09:54:54 +0000
Message-ID: <3e34f94963ff442ca09cef84fdf160fd@AcuMS.aculab.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
 <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
 <CAMuHMdUdTNpt6G1gzdd6tg9cTo4+kOQCP0Ekouhogug_1sJNPg@mail.gmail.com>
In-Reply-To: <CAMuHMdUdTNpt6G1gzdd6tg9cTo4+kOQCP0Ekouhogug_1sJNPg@mail.gmail.com>
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

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDA5IEp1bHkgMjAxOCAxMDoyMw0KPiBP
biBNb24sIEp1bCA5LCAyMDE4IGF0IDExOjE1IEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+IEZyb206IEFsZXhleSBCcm9ka2luDQo+ID4gPiBTZW50
OiAwOSBKdWx5IDIwMTggMDU6NDUNCj4gPiA+IERlcGVuZGluZyBvbiBBQkkgImxvbmcgbG9uZyIg
dHlwZSBvZiBhIHBhcnRpY3VsYXIgMzItYml0IENQVQ0KPiA+ID4gbWlnaHQgYmUgYWxpZ25lZCBi
eSBlaXRoZXIgd29yZCAoMzItYml0cykgb3IgZG91YmxlIHdvcmQgKDY0LWJpdHMpLg0KPiA+ID4g
TWFrZSBzdXJlICJkYXRhIiBpcyByZWFsbHkgNjQtYml0IGFsaWduZWQgZm9yIGFueSAzMi1iaXQg
Q1BVLg0KPiA+ID4NCj4gPiA+IEF0IGxlYXN0IGZvciAzMi1iaXQgQVJDIGNvcmVzIEFCSSByZXF1
aXJlcyAibG9uZyBsb25nIiB0eXBlcw0KPiA+ID4gdG8gYmUgYWxpZ25lZCBieSBub3JtYWwgMzIt
Yml0IHdvcmQuIFRoaXMgbWFrZXMgImRhdGEiIGZpZWxkIGFsaWduZWQgdG8NCj4gPiA+IDEyIGJ5
dGVzLiBXaGljaCBpcyBzdGlsbCBPSyBhcyBsb25nIGFzIHdlIHVzZSAzMi1iaXQgZGF0YSBvbmx5
Lg0KPiA+ID4NCj4gPiA+IEJ1dCBvbmNlIHdlIHdhbnQgdG8gdXNlIG5hdGl2ZSBhdG9taWM2NF90
IHR5cGUgKGkuZS4gd2hlbiB3ZSB1c2Ugc3BlY2lhbA0KPiA+ID4gaW5zdHJ1Y3Rpb25zIExMT0NL
RC9TQ09OREQgZm9yIGFjY2Vzc2luZyA2NC1iaXQgZGF0YSkgd2UgZWFzaWx5IGhpdA0KPiA+ID4g
bWlzYWxpZ25lZCBhY2Nlc3MgZXhjZXB0aW9uLg0KPiA+DQo+ID4gU2hvdWxkbid0IHRoZXJlIGJl
IGEgdHlwZWRlZiBmb3IgdGhlIGFjdHVhbCB0eXBlLg0KPiA+IFBlcmhhcHMgaXQgaXMgZXZlbiBh
dG9taWM2NF90ID8NCj4gPiBBbmQgaGF2ZSB0aGUgX19hbGlnbmVkKDgpIGFwcGxpZWQgdG8gdGhh
dCB0eXBlZGVmID8/DQo+IA0KPiBUaGF0IGluZGVlZCBzb3VuZHMgbGlrZSB0aGUgYmVzdCB0aGlu
ZyB0byBkbywgYXMgaXQgd2lsbCBmaXggdGhpcyBpc3N1ZSBpbiBvdGhlcg0KPiBwbGFjZXMsIHRv
by4NCg0KU29tZXRoaW5nIGxpa2U6DQp0eXBlZGVmIHN0cnVjdCB7DQoJdTY0IHZhbCBfX2FsaWdu
ZWQoOCk7DQp9IGF0b21pYzY0X3Q7DQoNCndvdWxkIHBpY2sgdXAgbW9zdCBlcnJvcnMuDQpJbmNs
dWRpbmcgYWxsIHRoZSBwbGFjZXMgdGhhdCBmYWlsIHRvIHVzZSBhdG9taWNfcmVhZCgpLg0KDQoJ
RGF2aWQNCg0K
