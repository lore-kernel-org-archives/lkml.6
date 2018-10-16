Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39045C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D986920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D986920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeJPLL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:11:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbeJPLL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:11:28 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 900155936BD98;
        Tue, 16 Oct 2018 11:23:08 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.186]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0399.000;
 Tue, 16 Oct 2018 11:23:05 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: Can we just remove the sw_lpm_support from current xhci driver?
Thread-Topic: Can we just remove the sw_lpm_support from current xhci driver?
Thread-Index: AQHUZIAt+ciMdjt1RRm6ul2Nx4VbyqUhNevQ
Date:   Tue, 16 Oct 2018 03:23:05 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED1F18ECDC@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED1F18C855@dggemm526-mbx.china.huawei.com>
 <155e2a10-d324-6bc6-b3fc-b23d15a3af25@intel.com>
In-Reply-To: <155e2a10-d324-6bc6-b3fc-b23d15a3af25@intel.com>
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

SGkgTWF0aGlhczoNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWF0aGlh
cyBOeW1hbiBbbWFpbHRvOm1hdGhpYXMubnltYW5AaW50ZWwuY29tXQ0KPlNlbnQ6IE1vbmRheSwg
T2N0b2JlciAxNSwgMjAxOCA4OjExIFBNDQo+VG86IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhp
c2lsaWNvbi5jb20+OyBHcmVnIEtIDQo+PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPkNj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
DQo+U3ViamVjdDogUmU6IENhbiB3ZSBqdXN0IHJlbW92ZSB0aGUgc3dfbHBtX3N1cHBvcnQgZnJv
bSBjdXJyZW50IHhoY2kNCj5kcml2ZXI/DQo+DQo+T24gMTUuMTAuMjAxOCAxMjozNSwgWmVuZ3Rh
byAoQikgd3JvdGU6DQo+PiBIaToNCj4+DQo+PiBJIGFtIHJlY2VudGx5IHJlYWRpbmcgdGhlIExQ
TSByZWxhdGVkIGNvZGUgaW4geGhjaSBkcml2ZXIsIGFuZCBJIGZpbmQNCj4+IHRoYXQgdGhlIHho
Y2ktPnN3X2xwbV9zdXBwb3J0IGlzIG5vdCByZWFsbHkgdXNlZCwgYnV0IEkgYW0gbm90IHN1cmUN
Cj4+ICAgd2hldGhlciB3ZSBzaG91bGQgcmVtb3ZlIGl0IG9yIG5vdD8NCj4+DQo+PiBBbnkgaWRl
YXMsIFRoYW5rcy4NCj4NCj5JIHRoaW5rIGl0IHdhcyB1c2VkIHRvIHByZXZlbnQgTFBNIGluIHBy
ZS0wLjk2IHhIQyBjb250cm9sbGVycy4NCj5Ob3cgZHJpdmVyIG9ubHkgc3VwcG9ydHMgSFcgTFBN
IGZvciAxLjAgYW5kIGxhdGVyIGNvbnRyb2xsZXJzLCBzbw0KPnhoY2ktPnN3X2xwbV9zdXBwb3J0
IGRvZXNuJ3QgcmVhbGx5IGRvIGFueXRoaW5nLg0KPg0KPllvdSBjYW4gc2VuZCBhIHBhdGNoIHJl
bW92aW5nIGl0DQo+DQpPaywgSSB3aWxsIHNlbmQgYSBwYXRjaCB0byBkbyBpdCwgdGhhbmtzLg0K
DQo+VGhhbmtzDQo+LU1hdGhpYXMNCg==
