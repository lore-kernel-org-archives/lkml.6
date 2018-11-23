Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86046C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8C720672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8C720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439382AbeKWMwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:52:54 -0500
Received: from mail2.tencent.com ([163.177.67.195]:56467 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733249AbeKWMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:52:53 -0500
Received: from EXHUB-SZMail03.tencent.com (unknown [10.14.6.33])
        by mail2.tencent.com (Postfix) with ESMTP id 18E618EA10;
        Fri, 23 Nov 2018 10:10:38 +0800 (CST)
Received: from EXMBX-SZMAIL003.tencent.com ([fe80::b5c3:10b3:7066:5904]) by
 EXHUB-SZMail03.tencent.com ([::1]) with mapi id 14.03.0415.000; Fri, 23 Nov
 2018 10:10:37 +0800
From:   =?utf-8?B?ZGJ5aW4o5bC554OoKQ==?= <dbyin@tencent.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGZzL3hmczogZml4IGZfZmZyZWUgdmFsdWUgZm9y?=
 =?utf-8?B?IHN0YXRmcyB3aGVuIHByb2plY3QgcXVvdGEgaXMgc2V0KEludGVybmV0IG1h?=
 =?utf-8?Q?il)?=
Thread-Topic: [PATCH] fs/xfs: fix f_ffree value for statfs when project
 quota is set(Internet mail)
Thread-Index: AQHUgo0N3+qIJgJ6Tkafp0qa1NWuOKVcnizA
Date:   Fri, 23 Nov 2018 02:10:34 +0000
Message-ID: <6EC51EE77FA0264BB8DAD779E0C341C9014BD78CB5@EXMBX-SZMAIL003.tencent.com>
References: <6EC51EE77FA0264BB8DAD779E0C341C9014BD77C91@EXMBX-SZMAIL003.tencent.com>
 <20181122175801.GV6792@magnolia>
In-Reply-To: <20181122175801.GV6792@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.219.177]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2Ugc2V0IHhmcyBwcm9qZWN0IHF1b3RhIHdpdGggb3ZlcmxheWZzIGZvciBkb2NrZXIgY29udGFp
bmVyLiBXaGVuIEkgZW50ZXIgaW50byB0aGUgY29udGFpbmVyIGFuZCBydW4gdGhlIGNvbW1hbmQg
J2RmIC1paCcsIHRoZSAnSUZyZWUnIGFuZCAnSVVzZWQnIGFyZSB1bmNvcnJlY3Q6DQoNCiNkZiAt
aWgNCkZpbGVzeXN0ZW0gICAgICAgICAgICBJbm9kZXMgICBJVXNlZCAgIElGcmVlIElVc2UlIE1v
dW50ZWQgb24NCm92ZXJsYXkgICAgICAgICAgICAgICAgIDEwMDAgICAtMjM1TSAgICAyMzVNICAg
IC0gIC8NCg0KU28gSSB3YW50IHRvIGZpeCB0aGlzIGZsYXcsIGFuZCB0aGlzIGlzIHZlcnkgbWVh
bmluZ2Z1bCBmb3Igb3VyIGFwcGxpY2F0aW9ucy4NClllDQoNCj4gDQo+IE9uIFRodSwgTm92IDIy
LCAyMDE4IGF0IDAxOjI4OjA0UE0gKzAwMDAsIGRieWluKOWwueeDqCkgd3JvdGU6DQo+ID4gV2hl
biBwcm9qZWN0IGlzIHNldCwgd2Ugc2hvdWxkIHVzZSBpbm9kZSBsaW1pdCBtaW51cyB0aGUgdXNl
ZCBjb3VudA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWUgWWluIDxkYnlpbkB0ZW5jZW50LmNv
bT4NCj4gDQo+IFRoaXMgbWFrZXMgc2Vuc2UgdG8gbWUsIGJ1dCAuLi4gaXQncyBiZWVuIGJyb2tl
biBsaWtlIHRoaXMgc2luY2UgMjAwNi4NCj4gSXMgdGhlcmUgYSByZWFzb24gd2h5IChzb21lb25l
IG5hbWVkIEdsZW4pIHdyb3RlIGl0IHRoaXMgd2F5Pw0KPiANCj4gUmV2aWV3ZWQtYnk6IERhcnJp
Y2sgSi4gV29uZyA8ZGFycmljay53b25nQG9yYWNsZS5jb20+DQo+IA0KPiAtLUQNCj4gDQo+ID4g
LS0tDQo+ID4gIGZzL3hmcy94ZnNfcW1fYmh2LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Zz
L3hmcy94ZnNfcW1fYmh2LmMgYi9mcy94ZnMveGZzX3FtX2Jodi5jIGluZGV4DQo+ID4gNzNhMWQ3
N2VjMTg3Li4zMDkxZTRiYzA0ZWYgMTAwNjQ0DQo+ID4gLS0tIGEvZnMveGZzL3hmc19xbV9iaHYu
Yw0KPiA+ICsrKyBiL2ZzL3hmcy94ZnNfcW1fYmh2LmMNCj4gPiBAQCAtNDAsNyArNDAsNyBAQCB4
ZnNfZmlsbF9zdGF0dmZzX2Zyb21fZHF1b3QoDQo+ID4gICAgICAgICAgICAgICAgIHN0YXRwLT5m
X2ZpbGVzID0gbGltaXQ7DQo+ID4gICAgICAgICAgICAgICAgIHN0YXRwLT5mX2ZmcmVlID0NCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAoc3RhdHAtPmZfZmlsZXMgPiBkcXAtPnFfcmVzX2lj
b3VudCkgPw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAoc3RhdHAtPmZfZmZyZWUgLSBk
cXAtPnFfcmVzX2ljb3VudCkgOiAwOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAoc3Rh
dHAtPmZfZmlsZXMgLSBkcXAtPnFfcmVzX2ljb3VudCkgOiAwOw0KPiA+ICAgICAgICAgfQ0KPiA+
ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTYuMg0KDQo=
