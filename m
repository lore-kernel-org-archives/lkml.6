Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B6CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB1F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB1F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeK2ORK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:17:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:6482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbeK2ORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:17:09 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 431DEA70AEB73;
        Thu, 29 Nov 2018 11:13:15 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.140]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0415.000;
 Thu, 29 Nov 2018 11:13:15 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Martin Petersen <martin.petersen@oracle.com>
CC:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: RE: scsi_set_medium_removal timeout issue 
Thread-Topic: scsi_set_medium_removal timeout issue 
Thread-Index: AQHUfC+ry+cITluAQnWJAza/Xxh90aVmKoJA
Date:   Thu, 29 Nov 2018 03:13:15 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24E0118D@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED1F1BC495@dggemm526-mbx.china.huawei.com>
 <Pine.LNX.4.44L0.1811141027420.1637-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1811141027420.1637-100000@iolanthe.rowland.org>
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

UGluZz8NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQWxhbiBTdGVybiBb
bWFpbHRvOnN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHVdDQo+U2VudDogV2VkbmVzZGF5LCBOb3Zl
bWJlciAxNCwgMjAxOCAxMTozNSBQTQ0KPlRvOiBNYXJ0aW4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRl
cnNlbkBvcmFjbGUuY29tPjsgWmVuZ3RhbyAoQikNCj48cHJpbWUuemVuZ0BoaXNpbGljb24uY29t
Pg0KPkNjOiBqZWpiQGxpbnV4LnZuZXQuaWJtLmNvbTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc7DQo+bGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+bGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgdXNiLXN0b3JhZ2VAbGlzdHMub25l
LWV5ZWQtYWxpZW4ubmV0DQo+U3ViamVjdDogUkU6IHNjc2lfc2V0X21lZGl1bV9yZW1vdmFsIHRp
bWVvdXQgaXNzdWUNCj4NCj5PbiBXZWQsIDE0IE5vdiAyMDE4LCBaZW5ndGFvIChCKSB3cm90ZToN
Cj4NCj4+IEkganVzdCBlbmFibGVkIHRoZSBzY3NpIGxvZyBpbiB0aGUgbWlkZGxlIG9mIHRoZSB1
bW91bnQgb3BlcmF0aW9uLA0KPj4gb3RoZXJ3aXNlIEkgY2FuJ3QgcmVwcm9kdWNlIHRoZSBpc3N1
ZSB3aGVuIHRoZSBzY3NpIGxvZyBpcyBlbmFibGVkLg0KPj4NCj4+ID5mcm9tIHRoZSBiZWdpbm5p
bmcuICBJbiBhbnkgY2FzZSwgaXQgd2Fzbid0IHdoYXQgSSB3YW50ZWQuICBJIGFza2VkDQo+PiA+
eW91IHRvIHBvc3QgdGhlIGRtZXNnIGxvZywgbm90IHRoZSBTQ1NJIGxvZy4NCj4+DQo+PiBQbGVh
c2UgcmVmZXIgdG8gdGhlIG5ldyBhdHRhY2htZW50IGZvciBkbWVzZyBsb2cuDQo+DQo+SGVoLCB5
ZXMsIEkgc2VlIG5vdy4NCj4NCj5NYXJ0aW4sIHNob3VsZG4ndCBzZF9yZWxlYXNlKCkgY2FsbCBz
ZF9zeW5jX2NhY2hlKCkgaW4gdGhlIHNhbWUgd2F5IHRoYXQNCj5zZF9zaHV0ZG93bigpIGRvZXMs
IGJlZm9yZSBpdCBjYWxscyBzY3NpX3NldF9tZWRpdW1fcmVtb3ZhbCgpPw0KPg0KPkFsYW4gU3Rl
cm4NCg0K
