Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C140256CE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C140256CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeF1Bkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:40:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5565 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751614AbeF1Bkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:40:41 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id B55A2377085FF;
        Thu, 28 Jun 2018 09:40:37 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.80]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0382.000;
 Thu, 28 Jun 2018 09:40:31 +0800
From:   "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBleHQ0OiBlMmZzcHJvZ3M6IGZpeCBpbm9kZSBiaXRt?=
 =?gb2312?B?YXAgbnVtIG5vdCBpbnRlZ2VyLGluY29tcGF0aWJsZSBmb3IgYW5jaWVudCBh?=
 =?gb2312?Q?ndroid_devices?=
Thread-Topic: [PATCH] ext4: e2fsprogs: fix inode bitmap num not
 integer,incompatible for ancient android devices
Thread-Index: AQHUDiB7bBM9P+9CgUmyd+rfiNQEzqR03/Qw
Date:   Thu, 28 Jun 2018 01:40:30 +0000
Message-ID: <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
In-Reply-To: <20180627140937.GA3348@thunk.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.189.158.207]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgdHl0c28sDQoNCkkgaGF2ZSBjaGVja2VkIHRoYXQgbWFrZV9leHQ0ZnMgY29kZSB3YXMgZGVs
ZXRlZCBvIEp1biAyMXRoIDIwMTggb24gbWFzdGVyIGJyYW5jaCBvZiAvc3lzdGVtL2V4dHJhcyBy
ZXBvc2l0b3J5Lg0KZS5nLiANCmh0dHBzOi8vYW5kcm9pZC1yZXZpZXcuZ29vZ2xlc291cmNlLmNv
bS9jL3BsYXRmb3JtL3N5c3RlbS9leHRyYXMvKy83MDgwMDMNCg0KdGhhdCBtZWFucyB0aGlzIHRv
b2xzIGhhcyBiZWVuIHdpZGVseSB1c2VkIGFsb25nIHNlcnZhbCB5ZWFycy4NCkFuZCBpdCBpcyBw
cm9iYWJseSB0aGF0IG1hbnkgbWFueSBkZXZpY2VzIGhhdmUgYmVlbiBkZWxpdmVyeWVkIGluIHNl
dmVyYWwgeWVhciBmcm9tIGFuZHJvaWQgMy4wIHRvIGFuZHJvaWQgOC4wLCB3aGljaCB1c2VkIG1h
a2VfZXh0NGZzLg0KQW5kIG9mIGNvdXJzZSB0aGVzZSBkZXZpY2VzIGNhbm5vdCBiZSByZWNhbGxl
ZC4NCg0KSWYgdGhpcyBidWcgd2FzIGluZHVjZWQgaW4gc29tZSBhbmRyb2lkIGRldmljZXMsIHdo
ZW4gbWFrZV9leHQ0ZnMgdG9vbCBwcm9kdWNlIGV4dDQgZmlsZXN5c3RlbSB3aXRoIGlub2RlbWFw
IG51bSBub3QgaW50ZWdlci4NCklmIHNvbWUgZXJyb3Igb2NjdXJzIHdpdGggdGhpcyBmaWxlc3lz
dGVtICwgdGhlIGUyZnNjayB0cnkgdG8gZml4IGl0LiBDb250cmFyaWx5LCBpdCBpbmR1Y2VkIG1v
cmUgZXJyb3JzLg0KDQpJIGhhdmUgY2hlY2tlZCB0dW5lMmZzLHJlc2l6ZTJmcywgdGhlc2UgdHdv
IHByb2dzIG5vdCB1c2VkIHNvbWV0aGluZyBsaWtlICIgRVhUMl9JTk9ERVNfUEVSX0dST1VQKGZz
LT5zdXBlcikgLyA4IiAsIG9yIHVzZWQgbGliIHdoaWNoIHdhcyBtb2RpZmllZCBieSBtZS4NCg0K
UmVnYXJkcywNCk1pbmcNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IFRoZW9kb3JlIFku
IFRzJ28gW21haWx0bzp0eXRzb0BtaXQuZWR1XSANCreiy83KsbzkOiAyMDE4xOo21MIyN8jVIDIy
OjEwDQrK1bz+yMs6IEdhb21pbmcgKG1pbmcsIGNvbnN1bWVyIEJHKQ0Ks63LzTogbGludXgtZXh0
NEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpcWluZ2No
YW8gKHNvcnApOyBTaGVuY2hlbiAoaGFycnkpOyBtaWFveGllIChBKQ0K1vfM4jogUmU6IFtQQVRD
SF0gZXh0NDogZTJmc3Byb2dzOiBmaXggaW5vZGUgYml0bWFwIG51bSBub3QgaW50ZWdlcixpbmNv
bXBhdGlibGUgZm9yIGFuY2llbnQgYW5kcm9pZCBkZXZpY2VzDQoNCk9uIFR1ZSwgSnVuIDI2LCAy
MDE4IGF0IDA3OjU0OjA2UE0gKzA4MDAsIEdhb01pbmcgd3JvdGU6DQo+IGZvciBleGFtcGxlLCAx
NzA4IGlub2RlcyBldmVyeSBncm91cCwzIGJsb2NrIGdyb3VwcywgYml0bWFwIGJ5dGVzIGFyZSAx
NzA4Lzg9MjEzLjUgd2hlbiB0aGUgaW5vZGUgYml0bWFwIGhhcyBzb21lIGVycm9ycywgZTJmc3By
b2dzIGNhbm5vdCBmaXggaXQNCj4NCj4gU2lnbmVkLW9mZi1ieTogR2FvTWluZyA8Z2FvbWluZzIw
QGh1YXdlaS5jb20+DQoNCkZpbGUgc3lzdGVtcyBsaWtlIHRoaXMgc2hvdWxkIG5vdCBleGlzdC4g
IENhbiB5b3UgcGxlYXNlIHBsZWFzZSBwbGVhc2UNCm1ha2Ugc3VyZSB0aGF0IGFueSB1c2Ugb2Yg
bWFrZV9leHQyZnMgYXJlIHJpcHBlZCBvdXQgYnkgdGhlIHJvb3RzPw0KDQpXaGF0IEkgKnNob3Vs
ZCogZG8gaXMgaGF2ZSBlMmZzY2sgcmVqZWN0IHRoZXNlIGZpbGUgc3lzdGVtcyBhcw0KY29tcGxl
dGVseSBpbnZhbGlkIGluIHBhc3MgMCwgd2hlbiB3ZSBjaGVjayBmb3Igc3VwZXJibG9jayBzYW5p
dHkuICBJDQpoYXZlbid0IGJlY2F1c2UgdGhlcmUgYXJlIHNvbWUgb2xkZXIgQW5kcm9pZCBzeXN0
ZW1zIHRoYXQgdXNlDQptYWtlX2V4dDJmcy4gIEJ1dCBhdCB0aGlzIHBvaW50LCB3aGF0IEkgYW0g
KipzZXJpb3VzbHkqKiBkb2luZyBpcyB0bw0KbWFrZSBlMmZzY2sgcmVqZWN0IHRoZXNlIGZpbGUg
c3lzdGVtcyBieSBkZWZhdWx0LCB1bmxlc3MgYSBzZXR0aW5nIGluDQplMmZzY2suY29uZiBpcyBz
ZXQgdG8gYWxsb3cgdGhlbSBhcyBhbiBleGNlcHRpb24uDQoNCk15IGNvbmNlcm4gYWJvdXQgYXBw
bHlpbmcgdGhpcyBwYXRjaCBpcyB0aGF0IGl0IHdpbGwgYmUgdGFrZW4gYXMNCmFjY2VwdGFuY2Ug
b2YgZTJmc3Byb2dzIHRvIGZ1bGx5IHN1cHBvcnQgdGhlc2Ugc29ydHMgb2YgaW52YWxpZCBmaWxl
DQpzeXN0ZW1zLiAgSW4gcGFydGljdWxhciwgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQgdmFy
aW91cyB0dW5lMmZzDQpvcHRpb25zLCByZXNpemUyZnMsIGV0Yy4sIHdpbGwgd29yayBjb3JyZWN0
bHkgZXZlbiB3aXRoIHlvdXIgcGF0Y2guDQoNCgkgCSAgICAJICAgICAgIAkgICAgCSAgICAgIC0g
VGVkDQo=
