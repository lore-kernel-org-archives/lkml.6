Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09407C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAAC20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAAC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeK0T1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:27:34 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:34758 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbeK0T1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:27:34 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 2235067968C;
        Tue, 27 Nov 2018 09:30:25 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 27 Nov
 2018 09:30:24 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 27 Nov 2018 09:30:24 +0100
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
Thread-Index: AQHUhiUV+bbi1IymHUOKrtHQUP0AvaVjN6EAgAACMwA=
Date:   Tue, 27 Nov 2018 08:30:24 +0000
Message-ID: <9365718c-4993-7e3b-1519-8fef0c08c0db@kontron.de>
References: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
 <20181127092232.3a6d1661@bbrezillon>
In-Reply-To: <20181127092232.3a6d1661@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FB3C31B07BFE1458731A2FD4C566831@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2235067968C.AC08A
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

T24gMjcuMTEuMTggMDk6MjIsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gVHVlLCAyNyBO
b3YgMjAxOCAwNzo0NDo1MiArMDAwMA0KPiBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJl
bXBmQGtvbnRyb24uZGU+IHdyb3RlOg0KPiANCj4+IEZpeCB0aGUgc2l6ZSBvZiB0aGUgYnVmZmVy
IGFsbG9jYXRlZCB0byBzdG9yZSB0aGUgaW4tbWVtb3J5IEJCVC4NCj4+IFRoaXMgYnVnIHdhcyBw
cmV2aW91c2x5IGhpZGRlbiBieSBhIGRpZmZlcmVudCBidWcsIHRoYXQgd2FzIGZpeGVkIGluDQo+
PiBkMDk4MDkzYmEwNmUuDQo+IA0KPiBPb3BzIDotLy4NCj4gDQo+Pg0KPj4gRml4ZXM6IDljMzcz
NmEzZGUyMSAoIm10ZDogbmFuZDogQWRkIGNvcmUgaW5mcmFzdHJ1Y3R1cmUgdG8gZGVhbCB3aXRo
IE5BTkQgZGV2aWNlcyIpDQo+PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9tdGQvbmFuZC9iYnQuYyB8IDMgKystDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tdGQvbmFuZC9iYnQuYyBiL2RyaXZlcnMvbXRkL25hbmQvYmJ0LmMNCj4+
IGluZGV4IDU2Y2RlMzguLmMxMjQ5N2YgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9uYW5k
L2JidC5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9uYW5kL2JidC5jDQo+PiBAQCAtMjcsNyArMjcs
OCBAQCBpbnQgbmFuZGRldl9iYnRfaW5pdChzdHJ1Y3QgbmFuZF9kZXZpY2UgKm5hbmQpDQo+PiAg
IAl1bnNpZ25lZCBpbnQgbndvcmRzID0gRElWX1JPVU5EX1VQKG5ibG9ja3MgKiBiaXRzX3Blcl9i
bG9jaywNCj4+ICAgCQkJCQkgICBCSVRTX1BFUl9MT05HKTsNCj4+ICAgDQo+PiAtCW5hbmQtPmJi
dC5jYWNoZSA9IGt6YWxsb2MobndvcmRzLCBHRlBfS0VSTkVMKTsNCj4+ICsJbmFuZC0+YmJ0LmNh
Y2hlID0ga3phbGxvYyhud29yZHMgKiAoQklUU19QRVJfTE9ORyAvIEJJVFNfUEVSX0JZVEUpLA0K
PiANCj4gSSBwcmVmZXINCj4gDQo+IAkJCQkJICogc2l6ZW9mKCpuYW5kLT5iYnQuY2FjaGUpDQo+
IElmIHlvdSdyZSBva2F5IHdpdGggdGhpcyBjaGFuZ2UsIEknbGwgZml4IGl0IHdoZW4gYXBwbHlp
bmcgKG5vIG5lZWQgdG8NCj4gc2VuZCBhIG5ldyB2ZXJzaW9uKS4NCg0KU3VyZSwgdGhhdCdzIG9r
Lg==
