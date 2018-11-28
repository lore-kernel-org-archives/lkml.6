Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA5AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9BA2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9BA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeK2CVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:21:39 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:32988 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:21:39 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 9A0A867A7D5;
        Wed, 28 Nov 2018 16:19:37 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 28 Nov
 2018 16:19:37 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 28 Nov 2018 16:19:37 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Thread-Topic: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Thread-Index: AQHUhiUV+bbi1IymHUOKrtHQUP0AvaVlM7kAgAAEGQCAAAHSgIAABNkA
Date:   Wed, 28 Nov 2018 15:19:37 +0000
Message-ID: <b7adc960-c81d-19c6-2122-cd6781b64a17@kontron.de>
References: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
 <20181128154104.577d5923@bbrezillon>
 <7634bb45-6167-31e8-e169-b5c9bf7e2fc5@kontron.de>
 <20181128160215.45e5162e@bbrezillon>
In-Reply-To: <20181128160215.45e5162e@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <964C622D6325BB4F83509DC02A69A437@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 9A0A867A7D5.AFC78
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjguMTEuMTggMTY6MDIsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gV2VkLCAyOCBO
b3YgMjAxOCAxNDo1NTo0NSArMDAwMA0KPiBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJl
bXBmQGtvbnRyb24uZGU+IHdyb3RlOg0KPiANCj4+IEhpIEJvcmlzLA0KPj4NCj4+IE9uIDI4LjEx
LjE4IDE1OjQxLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+Pj4gT24gVHVlLCAyNyBOb3YgMjAx
OCAwNzo0NDo1MiArMDAwMA0KPj4+IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZA
a29udHJvbi5kZT4gd3JvdGU6DQo+Pj4gICAgDQo+Pj4+IEZpeCB0aGUgc2l6ZSBvZiB0aGUgYnVm
ZmVyIGFsbG9jYXRlZCB0byBzdG9yZSB0aGUgaW4tbWVtb3J5IEJCVC4NCj4+Pj4gVGhpcyBidWcg
d2FzIHByZXZpb3VzbHkgaGlkZGVuIGJ5IGEgZGlmZmVyZW50IGJ1ZywgdGhhdCB3YXMgZml4ZWQg
aW4NCj4+Pj4gZDA5ODA5M2JhMDZlLg0KPj4+Pg0KPj4+PiBGaXhlczogOWMzNzM2YTNkZTIxICgi
bXRkOiBuYW5kOiBBZGQgY29yZSBpbmZyYXN0cnVjdHVyZSB0byBkZWFsIHdpdGggTkFORCBkZXZp
Y2VzIikNCj4+Pj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4N
Cj4+PiBMb29rcyBsaWtlIHlvdXIgRnJvbSBoZWFkZXIgZG9lcyBub3QgbWF0Y2ggdGhlIFNvQiB0
YWcNCj4+PiAoJ0ZyaWVkZXIgU2NocmVtcGYnIHZzICdTY2hyZW1wZiBGcmllZGVyJykgYW5kIGNo
ZWNrcGF0Y2ggZG9lcyBub3QgbGlrZQ0KPj4+IHRoYXQuIEknbGwgZml4IGl0IHdoZW4gYXBwbHlp
bmcsIGJ1dCBtYXliZSB5b3Ugc2hvdWxkIGZpeA0KPj4+IHlvdXIgLmdpdGNvbmZpZyB0byBtYWtl
IHRoZW0gbWF0Y2guDQo+Pg0KPj4gQWN0dWFsbHkgdGhlIEZyb20gaGVhZGVyIGluIG15IGxvY2Fs
IHBhdGNoIGlzIGNvcnJlY3QgKDxmaXJzdCBuYW1lPg0KPj4gPGxhc3QgbmFtZT4sIEZyaWVkZXIg
U2NocmVtcGYpIGFzIGl0IGNvbWVzIGZyb20gbXkgZ2l0IGNvbmZpZy4gQnV0IHNpbmNlDQo+PiBv
dXIgY29tcGFueSB3YXMgcmVuYW1lZCBhbmQgb3VyIG1haWwgc2VydmVycyB3ZXJlIHRyYW5zZmVy
cmVkLCBvdXINCj4+IGUtbWFpbHMgYXJlIHNlbnQgd2l0aCBGcm9tPTxsYXN0IG5hbWU+IDxmaXJz
dCBuYW1lPi4NCj4+DQo+PiBJdCBzZWVtcyBsaWtlIGdpdCBzZW5kLWVtYWlsIG9yIHBhdGNod29y
ayBvciB3aGF0ZXZlciB1c2VzIHRoZQ0KPj4gaW5mb3JtYXRpb24gZnJvbSB0aGUgZS1tYWlsIGhl
YWRlciBpbnN0ZWFkIG9mIHdoYXQgaXMgaW4gdGhlIHBhdGNoLg0KPj4NCj4+IEkgd2lsbCB0cnkg
dG8gcmFpc2UgdGhpcyBpc3N1ZSB3aXRoIG91ciBJVCBkZXBhcnRtZW50IGFzIHRoaXMgd291bGQg
YmUNCj4+IGJlc3QgZml4ZWQgb24gdGhlaXIgc2lkZS4NCj4gDQo+IFRoZXJlJ3MgYW5vdGhlciBz
b2x1dGlvbjogbWFrZSBnaXQgc2VuZC1lbWFpbCBhZGQgYSBGcm9tIGhlYWRlciBpbiB0aGUNCj4g
bWVzc2FnZSBib2R5Lg0KPiANCj4gZ2l0IGNvbmZpZyAtLWdsb2JhbCBzZW5kZW1haWwuZnJvbSAi
U2NocmVtcGYgRnJpZWRlciA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPiINCg0KSSBkb24n
dCBnZXQgaXQuIEhvdyB3b3VsZCB0aGF0IGNoYW5nZSB0aGluZ3M/IE15IEZyb20gc3RpbGwgd291
bGRuJ3QgDQptYXRjaCBteSBTb0IgdGFncy4=
