Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C987CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CE42082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CE42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeK3FRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:17:32 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:59482 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeK3FRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:17:32 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id A381F67A862;
        Thu, 29 Nov 2018 19:11:11 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 29 Nov
 2018 19:11:11 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Thu, 29 Nov 2018 19:11:11 +0100
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
Thread-Index: AQHUhiUV+bbi1IymHUOKrtHQUP0AvaVlM7kAgAAEGQCAAAHSgIAABNkAgAACZQCAAb/fAA==
Date:   Thu, 29 Nov 2018 18:11:11 +0000
Message-ID: <fa05e203-430c-6ec4-55e9-a7f9f548e481@kontron.de>
References: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
 <20181128154104.577d5923@bbrezillon>
 <7634bb45-6167-31e8-e169-b5c9bf7e2fc5@kontron.de>
 <20181128160215.45e5162e@bbrezillon>
 <b7adc960-c81d-19c6-2122-cd6781b64a17@kontron.de>
 <20181128162810.597a7fd3@bbrezillon>
In-Reply-To: <20181128162810.597a7fd3@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <00599B8BC25BF4498569457C99E642F7@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: A381F67A862.ADA5D
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

T24gMjguMTEuMTggMTY6MjgsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gV2VkLCAyOCBO
b3YgMjAxOCAxNToxOTozNyArMDAwMA0KPiBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJl
bXBmQGtvbnRyb24uZGU+IHdyb3RlOg0KPiANCj4+IE9uIDI4LjExLjE4IDE2OjAyLCBCb3JpcyBC
cmV6aWxsb24gd3JvdGU6DQo+Pj4gT24gV2VkLCAyOCBOb3YgMjAxOCAxNDo1NTo0NSArMDAwMA0K
Pj4+IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4gd3JvdGU6
DQo+Pj4gICAgDQo+Pj4+IEhpIEJvcmlzLA0KPj4+Pg0KPj4+PiBPbiAyOC4xMS4xOCAxNTo0MSwg
Qm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPj4+Pj4gT24gVHVlLCAyNyBOb3YgMjAxOCAwNzo0NDo1
MiArMDAwMA0KPj4+Pj4gU2NocmVtcGYgRnJpZWRlciA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9u
LmRlPiB3cm90ZToNCj4+Pj4+ICAgICAgIA0KPj4+Pj4+IEZpeCB0aGUgc2l6ZSBvZiB0aGUgYnVm
ZmVyIGFsbG9jYXRlZCB0byBzdG9yZSB0aGUgaW4tbWVtb3J5IEJCVC4NCj4+Pj4+PiBUaGlzIGJ1
ZyB3YXMgcHJldmlvdXNseSBoaWRkZW4gYnkgYSBkaWZmZXJlbnQgYnVnLCB0aGF0IHdhcyBmaXhl
ZCBpbg0KPj4+Pj4+IGQwOTgwOTNiYTA2ZS4NCj4+Pj4+Pg0KPj4+Pj4+IEZpeGVzOiA5YzM3MzZh
M2RlMjEgKCJtdGQ6IG5hbmQ6IEFkZCBjb3JlIGluZnJhc3RydWN0dXJlIHRvIGRlYWwgd2l0aCBO
QU5EIGRldmljZXMiKQ0KPj4+Pj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRy
b24uZGU+DQo+Pj4+Pg0KPj4+Pj4gTG9va3MgbGlrZSB5b3VyIEZyb20gaGVhZGVyIGRvZXMgbm90
IG1hdGNoIHRoZSBTb0IgdGFnDQo+Pj4+PiAoJ0ZyaWVkZXIgU2NocmVtcGYnIHZzICdTY2hyZW1w
ZiBGcmllZGVyJykgYW5kIGNoZWNrcGF0Y2ggZG9lcyBub3QgbGlrZQ0KPj4+Pj4gdGhhdC4gSSds
bCBmaXggaXQgd2hlbiBhcHBseWluZywgYnV0IG1heWJlIHlvdSBzaG91bGQgZml4DQo+Pj4+PiB5
b3VyIC5naXRjb25maWcgdG8gbWFrZSB0aGVtIG1hdGNoLg0KPj4+Pg0KPj4+PiBBY3R1YWxseSB0
aGUgRnJvbSBoZWFkZXIgaW4gbXkgbG9jYWwgcGF0Y2ggaXMgY29ycmVjdCAoPGZpcnN0IG5hbWU+
DQo+Pj4+IDxsYXN0IG5hbWU+LCBGcmllZGVyIFNjaHJlbXBmKSBhcyBpdCBjb21lcyBmcm9tIG15
IGdpdCBjb25maWcuIEJ1dCBzaW5jZQ0KPj4+PiBvdXIgY29tcGFueSB3YXMgcmVuYW1lZCBhbmQg
b3VyIG1haWwgc2VydmVycyB3ZXJlIHRyYW5zZmVycmVkLCBvdXINCj4+Pj4gZS1tYWlscyBhcmUg
c2VudCB3aXRoIEZyb209PGxhc3QgbmFtZT4gPGZpcnN0IG5hbWU+Lg0KPj4+Pg0KPj4+PiBJdCBz
ZWVtcyBsaWtlIGdpdCBzZW5kLWVtYWlsIG9yIHBhdGNod29yayBvciB3aGF0ZXZlciB1c2VzIHRo
ZQ0KPj4+PiBpbmZvcm1hdGlvbiBmcm9tIHRoZSBlLW1haWwgaGVhZGVyIGluc3RlYWQgb2Ygd2hh
dCBpcyBpbiB0aGUgcGF0Y2guDQo+Pj4+DQo+Pj4+IEkgd2lsbCB0cnkgdG8gcmFpc2UgdGhpcyBp
c3N1ZSB3aXRoIG91ciBJVCBkZXBhcnRtZW50IGFzIHRoaXMgd291bGQgYmUNCj4+Pj4gYmVzdCBm
aXhlZCBvbiB0aGVpciBzaWRlLg0KPj4+DQo+Pj4gVGhlcmUncyBhbm90aGVyIHNvbHV0aW9uOiBt
YWtlIGdpdCBzZW5kLWVtYWlsIGFkZCBhIEZyb20gaGVhZGVyIGluIHRoZQ0KPj4+IG1lc3NhZ2Ug
Ym9keS4NCj4+Pg0KPj4+IGdpdCBjb25maWcgLS1nbG9iYWwgc2VuZGVtYWlsLmZyb20gIlNjaHJl
bXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4iDQo+Pg0KPj4gSSBkb24n
dCBnZXQgaXQuIEhvdyB3b3VsZCB0aGF0IGNoYW5nZSB0aGluZ3M/IE15IEZyb20gc3RpbGwgd291
bGRuJ3QNCj4+IG1hdGNoIG15IFNvQiB0YWdzLg0KPiANCj4gV2hlbiB0aGVyZSdzIGEgRnJvbSBs
aW5lIGluIHRoZSBtZXNzYWdlIEJvZHksIGdpdCBhbSB3aWxsIHVzZSB0aGlzIG9uZQ0KPiBpbnN0
ZWFkIG9mIHRoZSBvbmUgaW4gdGhlIGhlYWRlciBzZWN0aW9uLg0KDQpPaywgbm93IEkgZ290IGl0
LiBJIGRpZG4ndCBrbm93IHRoYXQgZ2l0IHNlbmQtZW1haWwgYWRkcyB0aGUgRnJvbSB0YWcgaW4g
DQp0aGUgYm9keSBpZiBzZW5kZW1haWwuZnJvbSBkaWZmZXJzIGZyb20gdGhlIGF1dGhvciwgYnV0
IHRoYXQgbWFrZXMgc2Vuc2UgDQppbmRlZWQuDQoNCkkganVzdCBjaGVja2VkIGFuZCB3aXRoIG15
IG9sZCBtYWlsIHNldHVwLCB0aGUgU01UUCBzZXJ2ZXIgd2FzIA0KcmVzcGVjdGluZyBteSBzZW5k
ZXIgYWRkcmVzcyBmcm9tIHRoZSBjbGllbnQgKHNlbmQtZW1haWwsIHRodW5kZXJiaXJkKS4NCg0K
VGhlIG5ldyBzZXR1cCB1c2VzIERhdk1haWwgR2F0ZXdheSB0byBzZW5kIHZpYSB0aGUgY29tcGFu
aWVzIEV4Y2hhbmdlIA0Kc2VydmVyIGFuZCBpdCBqdXN0IGlnbm9yZXMgbXkgc2VuZGVyIGZyb20g
dGhlIGNsaWVudCBhbmQgc2VuZHMgd2l0aCB0aGUgDQpyZXZlcnNlZCBuYW1lIGFzIHN0b3JlZCBp
biB0aGUgRXhjaGFuZ2Ugc2VydmVyLg0KDQpJIGRvbid0IGxpa2Ugc2VuZGluZyBtYWlsIHdpdGgg
cmV2ZXJzZWQgbmFtZXMgKHBlb3BsZSBzdGFydCBjYWxsaW5nIG1lIA0KYnkgbXkgbGFzdCBuYW1l
KSwgYnV0IHVzaW5nIGEgZGlmZmVyZW50IFNNVFAgc2VydmVyIHdvdWxkIGxpa2VseSBjYXVzZSAN
CnRyb3VibGUgd2l0aCBzb21lIHJlY2lwaWVudHMgdXNpbmcgU1BGIGZvciBzcGFtIGRldGVjdGlv
bi4NCg0KU28gSSBndWVzcyBJIGhhdmUgdG8gY29udmluY2Ugb3VyIElUIHRvIGNoYW5nZSB0aGUg
bmFtZXMsIGlmIGV2ZW4gDQpwb3NzaWJsZS4uLg0KT2gsIHdoeSBkbyBzdWNoIHNtYWxsIHRoaW5n
cyBhbHdheXMgY2F1c2Ugc28gbXVjaCB0cm91YmxlPw==
