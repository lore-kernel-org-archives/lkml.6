Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A970FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A722084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A722084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJZAg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:36:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:36247 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbeJZAg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:36:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-158-KvKsrfukMCi8vJWANVghuA-1; Thu, 25 Oct 2018 17:03:32 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 25 Oct 2018 17:03:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 25 Oct 2018 17:03:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Colin King' <colin.king@canonical.com>,
        Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/cxgb3: Fix unintended sign extension
Thread-Topic: [PATCH] RDMA/cxgb3: Fix unintended sign extension
Thread-Index: AQHUbG94GPwrjqgPaEyPystlkveTaqUwHnXA
Date:   Thu, 25 Oct 2018 16:03:35 +0000
Message-ID: <25e5b2a5255b42ca92add0177fa4832d@AcuMS.aculab.com>
References: <20181025143131.4048-1-colin.king@canonical.com>
In-Reply-To: <20181025143131.4048-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: KvKsrfukMCi8vJWANVghuA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ29saW4gS2luZw0KPiBTZW50OiAyNSBPY3RvYmVyIDIwMTggMTU6MzINCj4gDQo+IEZy
b206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBJbiB0
aGUgZXhwcmVzc2lvbiAidXR4X2xlbiA8PCAyOCIsIHV0eF9sZW4gc3RhcnRzIGFzIHU4LCBidXQg
aXMgcHJvbW90ZWQNCj4gdG8gYSBzaWduZWQgaW50LCB0aGVuIHNpZ24tZXh0ZW5kZWQgdG8gdTY0
LiAgSWYgdXR4X2xlbiBpcyAweGY4IG9yIGdyZWF0ZXINCj4gdGhlbiB0aGUgc2lnbiBleHRlbnNp
b24gd2lsbCBzZXQgYWxsIHRoZSB1cHBlciBiaXRzIG9mIHV0eF9jbWQgd2hpY2ggaXMNCj4gcHJv
YmFibHkgbm90IHdoYXQgd2FzIGludGVuZGVkLiAgQ2FzdCB0byB1dHhfbGVuIHRvIHU2NCAgdG8g
YXZvaWQgdGhlIHNpZ24NCj4gZXh0ZW5zaW9uLg0KDQpSVEZDLi4uDQp1dHhfbGVuIGlzIG9ubHkg
ZXZlciAxLCAyIG9yIDMuDQpUaGUgJ3Byb2JsZW0nIHdvdWxkIGFyaXNlIGlmIHV0eF9sZW4gPDwg
Mjggc2V0IHRoZSBoaWdoIGJpdC4NClRoaXMgY2FuIG9ubHkgaGFwcGVuIGlmIHV0eF9sZW4gaXMg
bW9yZSB0aGFuIDcgKE5GSSB3aGVyZSAweGY4IGNhbWUgZnJvbSkuDQoNCkluIGFueSBjYXNlIHRo
ZSBiZXN0IGZpeCBpcyB0byB1c2UgJ3Vuc2lnbmVkIGludCcgZm9yIHdyX2xlbiBhbmQgdXR4X2xl
bi4NClRoZXJlIGlzIG5vIHBvaW50IG1ha2luZyBsb2NhbCB2YXJpYWJsZSAob3IgZnVuY3Rpb25z
IHBhcmFtZXRlcnMvcmVzdWx0cykNCnNtYWxsZXIgdGhhdCAnaW50JyB1bmxlc3MgeW91IGV4cGxp
Y2l0bHkgd2FudCB0aGUgYXJpdGhtZXRpYyB0byB3cmFwLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

