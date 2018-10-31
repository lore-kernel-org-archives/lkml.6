Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63551ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206B72082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206B72082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeJaLaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:30:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6469 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726984AbeJaLaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:30:21 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 4D1354A6965AB;
        Wed, 31 Oct 2018 10:34:17 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 31 Oct 2018 10:34:18 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.186]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0415.000;
 Wed, 31 Oct 2018 10:34:15 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: RE: scsi_set_medium_removal timeout issue 
Thread-Topic: scsi_set_medium_removal timeout issue 
Thread-Index: AQHUcFn+y+cITluAQnWJAza/Xxh90aU4oaOg
Date:   Wed, 31 Oct 2018 02:34:15 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED1F19F98A@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED1F19F1CF@dggemm526-mbx.china.huawei.com>
 <Pine.LNX.4.44L0.1810301005200.1515-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1810301005200.1515-100000@iolanthe.rowland.org>
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

SGk6DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsYW4gU3Rlcm4gW21h
aWx0bzpzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1XQ0KPlNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIg
MzAsIDIwMTggMTA6MDggUE0NCj5UbzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29u
LmNvbT4NCj5DYzogamVqYkBsaW51eC52bmV0LmlibS5jb207IG1hcnRpbi5wZXRlcnNlbkBvcmFj
bGUuY29tOw0KPmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBsaW51eC1zY3NpQHZnZXIua2Vy
bmVsLm9yZzsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOw0KPnVzYi1zdG9yYWdlQGxpc3RzLm9uZS1leWVkLWFsaWVuLm5ldA0KPlN1Ympl
Y3Q6IFJlOiBzY3NpX3NldF9tZWRpdW1fcmVtb3ZhbCB0aW1lb3V0IGlzc3VlDQo+DQo+T24gVHVl
LCAzMCBPY3QgMjAxOCwgWmVuZ3RhbyAoQikgd3JvdGU6DQo+DQo+PiBIaQ0KPj4NCj4+IEkgaGF2
ZSByZWNlbnRseSBtZXQgYSBzY3NpX3NldF9tZWRpdW1fcmVtb3ZhbCB0aW1lb3V0IGlzc3VlLCBh
bmQgaXQncw0KPj4gcmVsYXRlZCAgdG8gYm90aCBTQ1NJIGFuZCBVU0IgTUFTUyBzdG9yYWdlLg0K
Pj4gU2luY2UgaSBhbSBub3QgYW4gZXhwZXJ0IGluIGVpdGhlciBzY3NpIG9yIHVzYiBtYXNzIHN0
b3JhZ2UsIGkgYW0NCj4+IHdyaXRpbmcgdG8gcmVwb3J0IHRoZSBpc3N1ZSBhbmQgYXNrIGZvciBh
IHNvbHV0aW9uIGZyb20geW91IGd1eXMuDQo+Pg0KPj4gTXkgdGVzdCBzY2VuYXJpbyBpcyBhcyBm
b2xsb3c6DQo+PiAxLkxpbnV4IEhPU1QtLS0tLUxpbnV4IG1hc3Mgc3RvcmFnZSBnYWRnZXQodGhl
IGJhY2sgc3RvcmUgaXMgYSBmbGFzaA0KPnBhcnRpdGlvbikuDQo+PiAyLkhvc3QgbW91bnQgdGhl
IGRldmljZS4NCj4+IDMuSG9zdCB3cml0ZXMgc29tZSBkYXRhIHRvIHRoZSBNYXNzIHN0b3JhZ2Ug
ZGV2aWNlLg0KPj4gNC5Ib3N0IFVubW91bnQgdGhlIGRldmljZS4NCj4+IEJvdGggTGludXgga2Vy
bmVscyhIb3N0IGFuZCBEZXZpY2UpIGFyZSBMaW51eCA0LjkuDQo+PiBTb21lIGhhcyByZXBvcnRl
ZCB0aGUgc2FtZSBpc3N1ZSBhIGxvbmcgdGltZSBhZ28sIGJ1dCBpdCByZW1haW5zIHRoZXJlLg0K
Pj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtdXNiL21zZzUzNzM5Lmh0bWwN
Cj4+DQo+PiBGb3IgdGhlIGlzc3VlIGl0c2VsZiwgdGhlcmUgaXMgbXkgb2JzZXJ2YXRpb246DQo+
PiBJbiB0aGUgc3RlcCA0LCB0aGUgSG9zdCB3aWxsIGlzc3VlIGFuDQo+UFJFVkVOVF9BTExPV19N
RURJVU1fUkVNT1ZBTCBzY3NpIGNvbW1hbmQuDQo+PiBhbmQgYW5kIHRpbWVvdXQgaGFwcGVucyBk
dWUgdG8gdGhlIGRldmljZSAncyB2ZXJ5IHNsb3cNCj5mc2dfbHVuX2ZzeW5jX3N1Yi4NCj4NCj5T
b21ldGhpbmcgaXMgd3JvbmcgaGVyZS4gIEJlZm9yZSBzZW5kaW5nIFBSRVZFTlQtQUxMT1cgTUVE
SVVNDQo+UkVNT1ZBTCwgdGhlIGhvc3Qgc2hvdWxkIGlzc3VlIFNZTkNIUk9OSVpFIENBQ0hFLiAg
VGhpcyB3aWxsIGZvcmNlDQo+ZnNnX2x1bl9mc3luY19zdWIgdG8gcnVuLCBhbmQgdGhlIGhvc3Qg
c2hvdWxkIGFsbG93IGEgbG9uZyB0aW1lb3V0IGZvcg0KPnRoaXMgY29tbWFuZC4gIFRoZW4gd2hl
biBQUkVWRU5ULUFMTE9XIE1FRElVTSBSRU1PVkFMIGlzIHNlbnQsDQo+bm90aGluZyB3aWxsIG5l
ZWQgdG8gYmUgZmx1c2hlZC4NCj4NCg0KRGVmaW5pdGVseSwgSSBoYXZlbid0IHNlZW4gdGhlIFNZ
TkNIUk9OSVpFIENBQ0hFIGZyb20gdGhlIGhvc3QsIGl0IGRpcmVjdGx5DQppc3N1ZWQgdGhlIFBS
RVZFTlQtQUxMT1cgTUVESVVNIFJFTU9WQUwsIHNvIG1heWJlIHNvbWV0aGluZyB3cm9uZw0Kd2l0
aCB0aGUgc2NzaSBsYXllciBvciBzb21ldGhpbmcgd3Jvbmcgd2l0aCB0aGUgbWFzcyBzdG9yYWdl
IGNsYXNzIGRyaXZlcj8NCg0KWmVuZ3RhbyANCg0KPkFsYW4gU3Rlcm4NCj4NCj4+IEkgZm91bmQg
dGhlcmUgYXJlIHR3byBtZXRob2RzIHRvIHdvcmthcm91bmQgdGhlIGlzc3VlOg0KPj4gMS4gQ2hh
bmdlIHRoZSB0aW1lb3V0IHZhbHVlIG9mIGhvc3Qgc2NzaSBjb21tYW5kDQo+PiBQUkVWRU5UX0FM
TE9XX01FRElVTV9SRU1PVkFMIHRvIHRvIGFib3V0IDYwIHNlY29uZHMgZnJvbSAxMA0KPnNlY29u
ZHMuDQo+PiAyLiBSZW1vdmUgdGhlIGZzZ19sdW5fZnN5bmNfc3ViIGluIHRoZSBkZXZpY2UncyBN
YXNzIHN0b3JhZ2UgZ2FkZ2V0DQo+ZHJpdmVyLg0KPj4NCj4+IFRoYW5rcw0KPj4NCj4+IFJlZ2Fy
ZHMNCj4+IHplbnRhbw0KDQo=
