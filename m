Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C600C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBB7208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UvjyG+Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBB7208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964951AbeFNW0W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:26:22 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:52115 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964880AbeFNW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:26:20 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4E7551E04F7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529015179; bh=+Pk+TyJhte7wqG7KLRLQnNRdiCWTqPQFh2qNYAyRbT0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UvjyG+UmjVqzNkh1MzG0VR6YgVUjraX9ozqmPXlAZNxI07Y2FwqV2f6TRzJ7ppi/Y
         UxlTbBcLBOpmcDBMyUc7DcRsbzJ4HBzP74TKLrxfBg3180qndyRJZsaOEnGD1scDZd
         BOG0g7OaLw8Z9JVWUjD+jMu/cHKwx9fym3c1YIcn6TXoQykFzGz2Vt3iQjJYpYOKPs
         RJBB9a6Hr57f1qYOISyGRRK4ZyIm43fNj9dU4HLMbP11SY/COq2fa/3LTyn4wPMfgT
         69PNnDpQxZoD+g1g0KZHiMJAU/XFmyke3E+C/DvYOXNTq3AdnyeRCWrzDIZyI0/PVF
         4SRpAHVOKr78A==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id A8C7F3A92;
        Thu, 14 Jun 2018 15:26:18 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 14 Jun 2018 15:26:16 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 15 Jun 2018 00:26:13 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "wbx@uclibc-ng.org" <wbx@uclibc-ng.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Enable machine_desc->init_per_cpu for non-SMP
 configs
Thread-Topic: [PATCH] ARC: Enable machine_desc->init_per_cpu for non-SMP
 configs
Thread-Index: AQHTaSanPNcMJfLcsku5EPK772Lyc6MtIzgAgTRGWQA=
Date:   Thu, 14 Jun 2018 22:26:12 +0000
Message-ID: <59f6fc647175e3f22f530fc4497cc4104af355e7.camel@synopsys.com>
References: <20171129082145.23327-1-abrodkin@synopsys.com>
         <ee663800-7f72-c310-2a65-d8b52a811f15@synopsys.com>
In-Reply-To: <ee663800-7f72-c310-2a65-d8b52a811f15@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <90DA2368C6F8BE4EA0635370A37339CF@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBUaHUsIDIwMTctMTEtMzAgYXQgMDk6NDYgLTA4MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMTEvMjkvMjAxNyAxMjoyMSBBTSwgQWxleGV5IEJyb2RraW4gd3Jv
dGU6DQo+ID4gQXMgb2YgdG9kYXkgd2UgYXNzdW1lZCB0aGF0ICJtYWNoaW5lX2Rlc2MtPmluaXRf
cGVyX2NwdSIgY2FsbHMNCj4gPiBhcmUgb25seSB1c2FibGUgb24gU01QIHN5c3RlbXMgd2hlbiB3
ZSB3YW50IHRvIHJ1biBzb21lIHBpZWNlIG9mDQo+ID4gY29kZSBvbiBlYXJseSBib290IGZvciBl
YWNoIGFuZCBldmVyeSBjb3JlLCBJIGd1ZXNzIGFzc3VtcHRpb24gd2FzDQo+ID4gd2UgaGF2ZSAi
bWFjaGluZV9kZXNjLT5pbml0X2Vhcmx5IiBmb3Igc2luZ2xlLWNvcmUgY2FzZXMgd2hlcmUNCj4g
PiB0aGUgb25lIGFuZCBvbmx5IG1hc3RlciBjb3JlIGNhbiBkbyBhbGwgdGhlIHRoaW5ncy4NCj4g
PiANCj4gPiBCdXQgaXQgdHVybmVkIG91dCBmb3IgcGxhdGZvcm1zIHdoaWNoIG1pZ2h0IGJlIGJv
dGggVVAgYW5kIFNNUCBpdA0KPiA+IG1pZ2h0IGJlIGJlbmlmaWNpYWwgdG8gdXNlICJpbml0X3Bl
cl9jcHUiIGZvciBib3RoIFVQIGFuZCBTTVAgY2FzZXMNCj4gPiB3aXRoIHdoaWNoIHdlIGFjaGll
dmUgMiB0aGluZ3Mgc2ltdWx0YW5lb3VzbHk6DQo+ID4gICAxKSBFeGFjdGx5IHRoZSBzYW1lIG9u
ZSBjb2RlIHdpbGwgYmUgdXNlZCBmb3IgVVAmU01QIGZvcg0KPiA+ICAgICAgdGhpbmdzIHJlcXVp
cmVkIHRvIGJlIGRvbmUgb24gZWFjaCBhbiBldmVyeSBjb3JlIHJlZ2FyZGxlc3MgaWYgaXQncw0K
PiA+ICAgICAgYSBtYXN0ZXIgYW5kIHRoZSBvbmx5IGNvcmUgaW4gVVAgc3lzdGVtIG9yIGFueSBv
dGhlciBzbGF2ZSBjb3JlIGluIFNNUA0KPiA+ICAgICAgc2V0dXAuDQo+ID4gICAxKSBUaGVyZSB3
aWxsIGJlIG5vICJpZmRlZiBDT05GSUdfU01QIiBhcm91bmQgImluaXRfcGVyX2NwdSIuDQo+ID4g
DQo+IA0KPiBTZWVtcyBmaW5lIHRvIG1lLiBIb3dldmVyIHRoaXMgbmVlZHMgdG8gZ28gd2l0aCB0
aGUgYWN0dWFsIHBsYXRmb3JtIGNoYW5nZSB3aGljaCANCj4gbmVlZHMgaXQuDQoNCldlbGwgZm9y
IGV4YW1wbGUgdGhpcyBtaWdodCBnZXQgaW4gdGhlIHdheSBvZiBidWlsZGluZyBrZXJuZWwgZm9y
IEhTREsgd2l0aA0KQ09ORklHX1NNUCBkaXNhYmxlZCB3aGljaCBpcyBJTUhPIHF1aXRlIHZhbGlk
IGNhc2UgaW4gdGVybXMgb2YgdGVzdGluZw0KY29kZS1iYXNlIGNvbXBpbGVkIHdpdGggbm8gQ09O
RklHX1NNUCAoc29tZXRoaW5nIFdhbGRlbWFyIHdhcyB1cCB0bykuDQoNCklzIGl0IGEgc3Ryb25n
IGVub3VnaCByZWFzb24gZm9yIHRoYXQgcGF0Y2ggdG8gYmUgYXBwbGllZD8NCg0KLUFsZXhleQ==
