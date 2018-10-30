Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9A1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A9720831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A9720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJ3RUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:20:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6467 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbeJ3RUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:20:46 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B97CC4D67181;
        Tue, 30 Oct 2018 16:28:12 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.186]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 16:28:09 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: scsi_set_medium_removal timeout issue 
Thread-Topic: scsi_set_medium_removal timeout issue 
Thread-Index: AdRwJyVwy+cITluAQnWJAza/Xxh90Q==
Date:   Tue, 30 Oct 2018 08:28:09 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED1F19F1CF@dggemm526-mbx.china.huawei.com>
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

SGkgDQoNCkkgaGF2ZSByZWNlbnRseSBtZXQgYSBzY3NpX3NldF9tZWRpdW1fcmVtb3ZhbCB0aW1l
b3V0IGlzc3VlLCBhbmQgaXQncyByZWxhdGVkDQogdG8gYm90aCBTQ1NJIGFuZCBVU0IgTUFTUyBz
dG9yYWdlLiANClNpbmNlIGkgYW0gbm90IGFuIGV4cGVydCBpbiBlaXRoZXIgc2NzaSBvciB1c2Ig
bWFzcyBzdG9yYWdlLCBpIGFtIHdyaXRpbmcgdG8gcmVwb3J0DQp0aGUgaXNzdWUgYW5kIGFzayBm
b3IgYSBzb2x1dGlvbiBmcm9tIHlvdSBndXlzLg0KDQpNeSB0ZXN0IHNjZW5hcmlvIGlzIGFzIGZv
bGxvdzoNCjEuTGludXggSE9TVC0tLS0tTGludXggbWFzcyBzdG9yYWdlIGdhZGdldCh0aGUgYmFj
ayBzdG9yZSBpcyBhIGZsYXNoIHBhcnRpdGlvbikuDQoyLkhvc3QgbW91bnQgdGhlIGRldmljZS4N
CjMuSG9zdCB3cml0ZXMgc29tZSBkYXRhIHRvIHRoZSBNYXNzIHN0b3JhZ2UgZGV2aWNlLg0KNC5I
b3N0IFVubW91bnQgdGhlIGRldmljZS4NCkJvdGggTGludXgga2VybmVscyhIb3N0IGFuZCBEZXZp
Y2UpIGFyZSBMaW51eCA0LjkuICANClNvbWUgaGFzIHJlcG9ydGVkIHRoZSBzYW1lIGlzc3VlIGEg
bG9uZyB0aW1lIGFnbywgYnV0IGl0IHJlbWFpbnMgdGhlcmUuDQpodHRwczovL3d3dy5zcGluaWNz
Lm5ldC9saXN0cy9saW51eC11c2IvbXNnNTM3MzkuaHRtbA0KDQpGb3IgdGhlIGlzc3VlIGl0c2Vs
ZiwgdGhlcmUgaXMgbXkgb2JzZXJ2YXRpb246DQpJbiB0aGUgc3RlcCA0LCB0aGUgSG9zdCB3aWxs
IGlzc3VlIGFuIFBSRVZFTlRfQUxMT1dfTUVESVVNX1JFTU9WQUwgc2NzaSBjb21tYW5kLg0KYW5k
IGFuZCB0aW1lb3V0IGhhcHBlbnMgZHVlIHRvIHRoZSBkZXZpY2UgJ3MgdmVyeSBzbG93IGZzZ19s
dW5fZnN5bmNfc3ViLg0KSSBmb3VuZCB0aGVyZSBhcmUgdHdvIG1ldGhvZHMgdG8gd29ya2Fyb3Vu
ZCB0aGUgaXNzdWU6IA0KMS4gQ2hhbmdlIHRoZSB0aW1lb3V0IHZhbHVlIG9mIGhvc3Qgc2NzaSBj
b21tYW5kIFBSRVZFTlRfQUxMT1dfTUVESVVNX1JFTU9WQUwgdG8NCnRvIGFib3V0IDYwIHNlY29u
ZHMgZnJvbSAxMCBzZWNvbmRzLg0KMi4gUmVtb3ZlIHRoZSBmc2dfbHVuX2ZzeW5jX3N1YiBpbiB0
aGUgZGV2aWNlJ3MgTWFzcyBzdG9yYWdlIGdhZGdldCBkcml2ZXIuDQoNClRoYW5rcw0KDQpSZWdh
cmRzDQp6ZW50YW8NCg==
