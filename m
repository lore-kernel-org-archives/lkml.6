Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9267B208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9267B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeKNUqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:46:54 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:53267 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727816AbeKNUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:46:53 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-73-uX21be24NWeMQqICkGQcyA-1; Wed, 14 Nov 2018 10:44:07 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 14 Nov 2018 10:44:13 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 14 Nov 2018 10:44:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'James Bottomley' <jejb@linux.vnet.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        John Garry <john.garry@huawei.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        "satishkh@cisco.com" <satishkh@cisco.com>,
        "sebaddel@cisco.com" <sebaddel@cisco.com>,
        "kartilak@cisco.com" <kartilak@cisco.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brajeswar.linux@gmail.com" <brajeswar.linux@gmail.com>
Subject: RE: [PATCH] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
Thread-Topic: [PATCH] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
Thread-Index: AQHUe2uOXsenqPM5DUyjbJgu9QHkHKVPFVhg
Date:   Wed, 14 Nov 2018 10:44:12 +0000
Message-ID: <d5ff3e3cb7cb435a9eff8d159e85f704@AcuMS.aculab.com>
References: <5beae8ff.1c69fb81.bd59a.b7fa@mx.google.com>
         <a34379dd-f6f0-b439-b6de-f2db142f1823@huawei.com>
         <13d3418f-49d1-d683-48a6-cedbc073d86f@suse.de>
 <1542125473.3042.6.camel@linux.vnet.ibm.com>
In-Reply-To: <1542125473.3042.6.camel@linux.vnet.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: uX21be24NWeMQqICkGQcyA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFtZXMgQm90dG9tbGV5DQo+IFNlbnQ6IDEzIE5vdmVtYmVyIDIwMTggMTY6MTENCj4g
DQo+IE9uIFR1ZSwgMjAxOC0xMS0xMyBhdCAxNjo1MyArMDEwMCwgSm9oYW5uZXMgVGh1bXNoaXJu
IHdyb3RlOg0KPiA+IE9uIDEzLzExLzIwMTggMTY6NDQsIEpvaG4gR2Fycnkgd3JvdGU6DQo+ID4g
PiBPbiAxMy8xMS8yMDE4IDE1OjA4LCBTYWJ5YXNhY2hpIEd1cHRhIHdyb3RlOg0KPiBbLi4uXQ0K
PiA+ID4gPiAtICAgIGZuaWNfdHJhY2VfYnVmX3AgPSAodW5zaWduZWQgbG9uZyl2bWFsbG9jKCh0
cmFjZV9tYXhfcGFnZXMgKg0KPiA+ID4gPiBQQUdFX1NJWkUpKTsNCj4gPiA+ID4gKyAgICBmbmlj
X3RyYWNlX2J1Zl9wID0gKHVuc2lnbmVkIGxvbmcpdnphbGxvYygodHJhY2VfbWF4X3BhZ2VzICoN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEFHRV9TSVpFKSk7DQo+
ID4gPg0KPiA+ID4gSWYgeW91IHJlbW92ZSB0aGUgZXh0cmEgYnJhY2tldHMgaW4gdnphbGxvYygp
IGFyZ3VtZW50IHRoZW4geW91IG1heQ0KPiA+ID4gbm90IHNwaWxsIG9udG8gdGhlIG5leHQgbGlu
ZS4NCj4gPg0KPiA+IEFuZCByZW1vdmUgdGhlIHVubmVjZXNzYXJ5IGNhc3QuIHZ6YWxsb2MoKSAo
anVzdCBsaWtlIHZtYWxsb2MoKSkNCj4gPiByZXR1cm5zIGEgdm9pZCosIHNvIG5vIHJlYXNvbiB0
byBjYXN0IGl0Lg0KPiANCj4gVGhpcyBpcyBpbmNvcnJlY3QgYWR2aWNlOiB0aGVyZSdzIG5vIG5l
ZWQgdG8gY2FzdCBpdCB0byBvdGhlciAqcG9pbnRlcioNCj4gdHlwZXMsIGJ1dCBpZiB5b3UgY2Fz
dCBpdCB0byBhIG5vbi1wb2ludGVyIHR5cGUgKHdoaWNoIHRoaXMgaXMgZG9pbmcpDQo+IHRoZSBj
b21waWxlciB3aWxsIGNvbXBsYWluIGlmIHRoZXJlIGlzIG5vIGV4cGxpY2l0IGNhc3QuDQoNClRo
ZSByZWFsIHF1ZXN0aW9uIGlzIHdoeSBpcyB0aGlzIGNvZGUgdXNpbmcgJ3Vuc2lnbmVkIGxvbmcn
DQp0byBob2xkIHBvaW50ZXJzPw0KDQpOZXZlciBtaW5kIHdoeSBpdCBpcyBhbGxvY2F0aW5nIGEg
bGFyZ2UgbWVtb3J5IGJsb2NrIHRoZW4gc2V0dGluZw0KdXAgYW5vdGhlciBhcnJheSB3aXRoIHBv
aW50ZXJzIHRvIGV2ZXJ5IDY0IGJ5dGVzIGRvd24gaXQuDQoNCkFsc28gd2h5IGRlZmF1bHQgdG8g
MTYgKiBQQUdFX1NJWkUgLSB0aGF0IGlzIHNpbGx5IGlmIHBhZ2VzIGFyZSBiaWcuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

