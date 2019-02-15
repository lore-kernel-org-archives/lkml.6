Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0BD21B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403999AbfBOIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:17:43 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:39266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfBOIRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:17:42 -0500
Received: from DGGEMA405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id B5C208B2A1A9FFB50115;
        Fri, 15 Feb 2019 16:17:39 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.64]) by
 DGGEMA405-HUB.china.huawei.com ([10.3.20.46]) with mapi id 14.03.0415.000;
 Fri, 15 Feb 2019 16:17:36 +0800
From:   "chenzefeng (A)" <chenzefeng2@huawei.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB4ODY6IGxpdmVwYXRjaDogVHJlYXQgUl9YODZfNjRf?=
 =?gb2312?B?UExUMzIgYXMgUl9YODZfNjRfUEMzMg==?=
Thread-Topic: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Thread-Index: AdTE0VS6YxuMC8nAT2u21pUoQUU8y///1zKA//9wvuA=
Date:   Fri, 15 Feb 2019 08:17:36 +0000
Message-ID: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A889B@DGGEMA503-MBX.china.huawei.com>
References: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
 <nycvar.YFH.7.76.1902150826400.11598@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1902150826400.11598@cbobk.fhfr.pm>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.50.95]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEksIEppcmkgS29zaW5hLA0KDQpPbiBGcmksIDE1IEZlYiAyMDE5LCBKaXJpIEtvc2luYSB3cm90
ZToNCj5PbiBGcmksIDE1IEZlYiAyMDE5LCBjaGVuemVmZW5nIChBKSB3cm90ZToNCg0KPj4gT24g
eDg2LTY0LCBmb3IgMzItYml0IFBDLXJlbGFjaXZlIGJyYW5jaGVzLCB3ZSBjYW4gZ2VuZXJhdGUg
UExUMzIgDQo+PiByZWxvY2F0aW9uLCBpbnN0ZWFkIG9mIFBDMzIgcmVsb2NhdGlvbi4gYW5kIFJf
WDg2XzY0X1BMVDMyIGNhbiBiZSANCj4+IHRyZWF0ZWQgdGhlIHNhbWUgYXMgUl9YODZfNjRfUEMz
MiBzaW5jZSBsaW51eCBrZXJuZWwgZG9lc24ndCB1c2UgUExULg0KPj4gDQo+PiBJbiBsaW51eCA0
LjQgY29tbWl0IGIyMWViZjJmYjRjZCAoIng4NjogVHJlYXQgUl9YODZfNjRfUExUMzIgYXMNCj4+
IFJfWDg2XzY0X1BDMzIiKSBiZWVuIGZpeGVkIGZvciB0aGUgbW9kdWxlIGxvYWRpbmcsIGJ1dCBu
b3QgZml4ZWQgZm9yIA0KPj4gbGl2ZXBhdGNoIHJlbG9jYXRpb24sIHdoaWNoIHdpbGwgZmFpbCB0
byBsb2FkIGxpdmVwYXRjaCB3aXRoIHRoZSBlcnJvciANCj4+IG1lc3NhZ2UgYXMgZm9sbG93OiBy
ZWxvY2F0aW9uIGZhaWxlZCBmb3Igc3ltYm9sIDxzeW1ib2wgbmFtZT4gYXQgDQo+PiA8c3ltYm9s
DQo+PiBhZGRyZXNzPg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBjaGVuemVmZW5nIDxjaGVuemVm
ZW5nMkBodWF3ZWkuY29tPg0KDQo+V2hhdCBrZXJuZWwgdmVyc2lvbiBpcyB0aGlzIHBhdGNoIGJh
c2VkIG9uPyBXZSd2ZSBnb3QgcmlkIG9mIHg4Ni1zcGVjaWZpYyBtb2R1bGUgbG9hZGluZyBzdHVi
IGFuZCBvZmZsb2FkZWQgYWxsIHRoZSByZWxvY2F0aW9uIGhhbmRsaW5nIHRvIGdlbmVyaWMga21v
ZCBsb2FkZXIgbG9uZyB0aW1lIGFnby4NCg0KVGhlIHBhdGNoIGlzIGJhc2VkIG9uIGtlcm5lbCB2
ZXJzaW9uIExpbnV4IDQuNC4xNzQuDQoNClRoYW5rcy4NCmNoZW56ZWZlbmcNCg0K
