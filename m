Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B3BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91D20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB91D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJ3SR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:17:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbeJ3SR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:17:27 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 8507079581EEE;
        Tue, 30 Oct 2018 17:24:41 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 17:24:39 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.186]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 17:24:38 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Oliver Neukum <oneukum@suse.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC:     "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: scsi_set_medium_removal timeout issue
Thread-Topic: scsi_set_medium_removal timeout issue
Thread-Index: AQHUcC6BuQCtt3bAAkehTnv046vWHKU3g21g
Date:   Tue, 30 Oct 2018 09:24:38 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED1F19F218@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED1F19F1CF@dggemm526-mbx.china.huawei.com>
 <1540889786.12349.9.camel@suse.com>
In-Reply-To: <1540889786.12349.9.camel@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGk6DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE9saXZlciBOZXVrdW0g
W21haWx0bzpvbmV1a3VtQHN1c2UuY29tXQ0KPlNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMzAsIDIw
MTggNDo1NiBQTQ0KPlRvOiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsg
amVqYkBsaW51eC52bmV0LmlibS5jb207DQo+Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IG1h
cnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOw0KPnN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHUNCj5D
YzogdXNiLXN0b3JhZ2VAbGlzdHMub25lLWV5ZWQtYWxpZW4ubmV0OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPmxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdl
ci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IHNjc2lfc2V0X21lZGl1bV9yZW1vdmFsIHRpbWVv
dXQgaXNzdWUNCj4NCj5PbiBEaSwgMjAxOC0xMC0zMCBhdCAwODoyOCArMDAwMCwgIFplbmd0YW8g
KEIpICB3cm90ZToNCj4+IEhpDQo+DQo+PiBGb3IgdGhlIGlzc3VlIGl0c2VsZiwgdGhlcmUgaXMg
bXkgb2JzZXJ2YXRpb246DQo+PiBJbiB0aGUgc3RlcCA0LCB0aGUgSG9zdCB3aWxsIGlzc3VlIGFu
DQo+UFJFVkVOVF9BTExPV19NRURJVU1fUkVNT1ZBTCBzY3NpIGNvbW1hbmQuDQo+PiBhbmQgYW5k
IHRpbWVvdXQgaGFwcGVucyBkdWUgdG8gdGhlIGRldmljZSAncyB2ZXJ5IHNsb3cNCj5mc2dfbHVu
X2ZzeW5jX3N1Yi4NCj4+IEkgZm91bmQgdGhlcmUgYXJlIHR3byBtZXRob2RzIHRvIHdvcmthcm91
bmQgdGhlIGlzc3VlOg0KPj4gMS4gQ2hhbmdlIHRoZSB0aW1lb3V0IHZhbHVlIG9mIGhvc3Qgc2Nz
aSBjb21tYW5kDQo+PiBQUkVWRU5UX0FMTE9XX01FRElVTV9SRU1PVkFMIHRvIHRvIGFib3V0IDYw
IHNlY29uZHMgZnJvbSAxMA0KPnNlY29uZHMuDQo+DQo+VGhhdCBpcyBuZWFyIHVzZWxlc3MsIGJl
Y2F1c2UgdGhlIGdhZGdldCBjYW4gYmUgdXNlZCB3aXRoIG90aGVyIHN5c3RlbXMuDQo+DQoNCklz
IGl0IHJlYXNvbmFibGUgdG8ga2VlcCB0aGUgY3VycmVudCB2YWx1ZT8gT3IgY2FuIHdlIGNoYW5n
ZSBpdCB0byBjb3Zlcg0KYXMgbXVjaCBzeXN0ZW1zIGFzIHBvc3NpYmxlLiANCg0KPj4gMi4gUmVt
b3ZlIHRoZSBmc2dfbHVuX2ZzeW5jX3N1YiBpbiB0aGUgZGV2aWNlJ3MgTWFzcyBzdG9yYWdlIGdh
ZGdldA0KPmRyaXZlci4NCj4NCj5JdCBleGlzdHMgZm9yIGEgcmVhc29uLiBUaGUgYmxvY2tzIGhh
dmUgdG8gYmUgb24gdGhlIG1lZGl1bS4NCj5JdCBzZWVtcyB0byBtZSB0aGF0IHlvdXIgZ2FkZ2V0
IGp1c3QgYWxsb3dzIHRvbyBtYW55IGRpcnR5IHBhZ2VzIGluIHRoZQ0KPmNhY2hlLg0KPg0KPglS
ZWdhcmRzDQo+CQlPbGl2ZXINCg0KUmVnYXJkcw0KWmVuZ3RhbyANCg0K
