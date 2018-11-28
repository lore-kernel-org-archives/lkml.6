Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DB920989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DB920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeK2AUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:20:33 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:57260 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2AUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:20:33 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 86B1D6797E5;
        Wed, 28 Nov 2018 14:18:49 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 28 Nov
 2018 14:18:49 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 28 Nov 2018 14:18:49 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peron.clem@gmail.com" <peron.clem@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: [PATCH v2] mtd: spinand: Fix ECC status and OOB layout for Toshiba
 TC58CVG2S0H
Thread-Topic: [PATCH v2] mtd: spinand: Fix ECC status and OOB layout for
 Toshiba TC58CVG2S0H
Thread-Index: AQHUhxzmBPjHV702Ak6bmI64xMLgtg==
Date:   Wed, 28 Nov 2018 13:18:48 +0000
Message-ID: <1543411097-24229-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3B53CE3B986244AB670E464E4AEC6C7@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 86B1D6797E5.AE3EC
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com,
        peron.clem@gmail.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiByZWFkaW5nIHRoZSBzdGF0dXMgb2YgdGhlIG9uLWNoaXAgRUNDLCB0aGUgVG9zaGliYSBj
aGlwIHJldHVybnMNCnR3byBkaWZmZXJlbnQgc3RhdGVzIGZvciByZXBvcnRpbmcgY29ycmVjdGVk
IGJpdGZsaXBzLiBXZSBzaG91bGQgY2hlY2sNCmZvciBib3RoIG9mIHRoZW0uDQoNCkFsc28gcmV0
dXJuIHRoZSBmcmVlIE9PQiBieXRlcyBhcyBvbmUgY29udGlndW91cyBhcmVhLCBpbnN0ZWFkIG9m
DQptdWx0aXBsZSBzZWN0aW9ucy4NCg0KU3VnZ2VzdGVkLWJ5OiBDbMOpbWVudCBQw6lyb24gPHBl
cm9uLmNsZW1AZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJp
ZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KLS0tDQogZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9z
aGliYS5jIHwgMTAgKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3No
aWJhLmMgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMNCmluZGV4IDI5NGJjZjYuLjk3
MzE3NTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMNCisrKyBi
L2RyaXZlcnMvbXRkL25hbmQvc3BpL3Rvc2hpYmEuYw0KQEAgLTExLDYgKzExLDcgQEANCiAjaW5j
bHVkZSA8bGludXgvbXRkL3NwaW5hbmQuaD4NCiANCiAjZGVmaW5lIFNQSU5BTkRfTUZSX1RPU0hJ
QkEJCTB4OTgNCisjZGVmaW5lIFRPU0hfU1RBVFVTX0VDQ19IQVNfQklURkxJUFNfVAkoMyA8PCA0
KQ0KIA0KIHN0YXRpYyBTUElOQU5EX09QX1ZBUklBTlRTKHJlYWRfY2FjaGVfdmFyaWFudHMsDQog
CQlTUElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1g0X09QKDAsIDEsIE5VTEwsIDApLA0KQEAg
LTMzLDE5ICszNCwxNyBAQCBzdGF0aWMgaW50IHRjNThjdmcyczBoX29vYmxheW91dF9lY2Moc3Ry
dWN0IG10ZF9pbmZvICptdGQsIGludCBzZWN0aW9uLA0KIAlyZWdpb24tPm9mZnNldCA9IDEyOCAr
IDE2ICogc2VjdGlvbjsNCiAJcmVnaW9uLT5sZW5ndGggPSAxNjsNCiANCi0NCiAJcmV0dXJuIDA7
DQogfQ0KIA0KIHN0YXRpYyBpbnQgdGM1OGN2ZzJzMGhfb29ibGF5b3V0X2ZyZWUoc3RydWN0IG10
ZF9pbmZvICptdGQsIGludCBzZWN0aW9uLA0KIAkJCQkgICAgICBzdHJ1Y3QgbXRkX29vYl9yZWdp
b24gKnJlZ2lvbikNCiB7DQotCWlmIChzZWN0aW9uID4gNykNCisJaWYgKHNlY3Rpb24gPiAwKQ0K
IAkJcmV0dXJuIC1FUkFOR0U7DQogDQotCXJlZ2lvbi0+b2Zmc2V0ID0gMiArIDE2ICogc2VjdGlv
bjsNCi0JcmVnaW9uLT5sZW5ndGggPSAxNDsNCi0NCisJcmVnaW9uLT5vZmZzZXQgPSAyOw0KKwly
ZWdpb24tPmxlbmd0aCA9IDEyNjsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTcwLDYgKzY5LDcg
QEAgc3RhdGljIGludCB0YzU4Y3ZnMnMwaF9lY2NfZ2V0X3N0YXR1cyhzdHJ1Y3Qgc3BpbmFuZF9k
ZXZpY2UgKnNwaW5hbmQsDQogCQlyZXR1cm4gLUVCQURNU0c7DQogDQogCWNhc2UgU1RBVFVTX0VD
Q19IQVNfQklURkxJUFM6DQorCWNhc2UgVE9TSF9TVEFUVVNfRUNDX0hBU19CSVRGTElQU19UOg0K
IAkJLyoNCiAJCSAqIExldCdzIHRyeSB0byByZXRyaWV2ZSB0aGUgcmVhbCBtYXhpbXVtIG51bWJl
ciBvZiBiaXRmbGlwcw0KIAkJICogaW4gb3JkZXIgdG8gYXZvaWQgZm9yY2luZyB0aGUgd2Vhci1s
ZXZlbGluZyBsYXllciB0byBtb3ZlDQotLSANCjIuNy40DQo=
