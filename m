Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4793BC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF586217B9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF586217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeHELlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 07:41:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeHELlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 07:41:52 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 0ACD4331431C9;
        Sun,  5 Aug 2018 17:37:53 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Sun, 5 Aug 2018 17:37:53 +0800
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.75]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0399.000;
 Sun, 5 Aug 2018 17:37:44 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "serge@hallyn.com" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lizefan <lizefan@huawei.com>, "miaoxie (A)" <miaoxie@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: maybe resource leak in security/selinux/selinuxfs.c
Thread-Topic: maybe resource leak in security/selinux/selinuxfs.c
Thread-Index: AdQpeVHZ6C+RBxudSMK/r1O5xUSIwQBn/rAAAGGKKYA=
Date:   Sun, 5 Aug 2018 09:37:43 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A736D15@dggemm507-mbx.china.huawei.com>
References: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
 <CAHC9VhS4nwcErVriwBzvvRQTFLZ=U_p8gA7xQnjs1wBKtmSgxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS4nwcErVriwBzvvRQTFLZ=U_p8gA7xQnjs1wBKtmSgxQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0dXJkYXksIEF1Z3VzdCAwNCwgMjAxOCAzOjAxIEFNIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPk9uIFdlZCwgQXVnIDEsIDIwMTggYXQgNTozOSBBTSBOaXhp
YW9taW5nIDxuaXhpYW9taW5nQGh1YXdlaS5jb20+IHdyb3RlOg0KPj4NCj4+IGFkdmlzb3J5Og0K
Pj4gMSBBZnRlciBjcmVhdGluZyBkZW50cnkgaW4gZF9hbGxvY19uYW1lLCBzaG91bGQgSSBjYWxs
IGRwdXQgdG8gcmVsZWFzZSByZXNvdXJjZXMgYmVmb3JlIHRoZSBleGNlcHRpb24gZXhpdD8NCj4+
IDIgQWZ0ZXIgY2FsbGluZyB0aGUgbmV3X2lub2RlIHRvIGNyZWF0ZSBhbiBpbm9kZSwgc2hvdWxk
IHRoZSBpbm9kZSByZXNvdXJjZSBiZSByZWxlYXNlZCBiZWZvcmUgdGhlIGV4Y2VwdGlvbiBleGl0
Pw0KPj4NCj4+IElmIHRoZSBkZW50cnkgYW5kIGlub2RlIHJlc291cmNlcyBuZWVkIHRvIGJlIGFj
dGl2ZWx5IHJlbGVhc2VkLCB0aGVyZSBhcmUgbXVsdGlwbGUgcmVzb3VyY2UgbGVha3MgaW4gc2Vj
dXJpdHkvc2VsaW51eC9zZWxpbnV4ZnMuYy4NCj4NCj5IZWxsby4gIFNvcnJ5IGZvciB0aGUgZGVs
YXkgaW4gcmVzcG9uZGluZywgY29tbWVudHMgaW5saW5lIC4uLg0KPg0KPj4gRXhhbXBsZToNCj4+
IExpbnV4IG1hc3RlciBicmFuY2ggdjQuMTgtcmM1DQo+PiBUaGUgZnVuY3Rpb24gc2VsX21ha2Vf
YXZjX2ZpbGVzIGluIHNlY3VyaXR5L3NlbGludXgvc2VsaW51eGZzLmMuDQo+Pg0KPj4gMTU2NiBz
dGF0aWMgaW50IHNlbF9tYWtlX2F2Y19maWxlcyhzdHJ1Y3QgZGVudHJ5ICpkaXIpDQo+PiAuLi4u
Li4uDQo+PiAxNTgwICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShmaWxlcyk7IGkrKykg
ew0KPj4gMTU4MSAgICAgICAgIHN0cnVjdCBpbm9kZSAqaW5vZGU7DQo+PiAxNTgyICAgICAgICAg
c3RydWN0IGRlbnRyeSAqZGVudHJ5Ow0KPj4gMTU4Mw0KPj4gMTU4NCAgICAgICAgIGRlbnRyeSA9
IGRfYWxsb2NfbmFtZShkaXIsIGZpbGVzW2ldLm5hbWUpOw0KPj4gMTU4NSAgICAgICAgIGlmICgh
ZGVudHJ5KQ0KPj4gLypSZXNvdXJjZSBsZWFrOiB3aGVuIGkhPTAsIHRoZSByZWxlYXNlIGFjdGlv
biBvZiBkZW50cnkgYW5kIGlub2RlIHJlc291cmNlcyBpcyBtaXNzaW5nKi8NCj4NCj5JIGRvbid0
IHVuZGVyc3RhbmQgdGhlIGxlYWsgaW4gdGhpcyBjYXNlPyAgSWYgZF9hbGxvY19uYW1lKCkgZmFp
bHMgb24NCj5hIHBhcnRpYWxseSBjb25zdHJ1Y3RlZCAvc3lzL2ZzL3NlbGludXgvYXZjIGRpcmVj
dG9yeSB0aGUgcHJldmlvdXNseQ0KPmFsbG9jYXRlZCBkZW50cnkvaW5vZGVzIGFyZSBub3QgbG9z
dCBvciBsZWFrZWQsIGRfYWxsb2NfbmFtZSgpDQo+YXR0YWNoZWQgdGhlbSB0byB0aGUgcGFyZW50
IGRlbnRyeS4NCj4NClNvcnJ5LCBJIGRpZG4ndCBub3RpY2UgdGhlIGRpcmVjdG9yeSByZWxlYXNl
IGNvZGUgaW4gc2VsX2tpbGxfc2IgYmVmb3JlLg0KDQo+PiAxNTg2ICAgICAgICAgICAgIHJldHVy
biAtRU5PTUVNOw0KPj4gMTU4Nw0KPj4gMTU4OCAgICAgICAgIGlub2RlID0gc2VsX21ha2VfaW5v
ZGUoZGlyLT5kX3NiLCBTX0lGUkVHfGZpbGVzW2ldLm1vZGUpOw0KPj4gMTU4OSAgICAgICAgIGlm
ICghaW5vZGUpDQo+PiAvKlJlc291cmNlIGxlYWs6IG1pc3NpbmcgZHB1dChkZW50cnkpKi8NCj4+
IC8qUmVzb3VyY2UgbGVhazogd2hlbiBpIT0wLCB0aGUgcmVsZWFzZSBhY3Rpb24gb2YgZGVudHJ5
IGFuZCBpbm9kZSByZXNvdXJjZXMgaXMgbWlzc2luZyovDQo+DQo+WWVzLCBpbiB0aGlzIGNhc2Ug
aXQgZG9lcyBsb29rIGxpa2Ugd2UgYXJlIG1pc3NpbmcgYSBjYWxsIHRvIGRwdXQoKS4NCj5Xb3Vs
ZCB5b3UgbGlrZSB0byBzdWJtaXQgYSBwYXRjaCB0byBmaXggdGhpcyBhcyB3ZWxsIGFzIHRoZSBv
dGhlcnMgaW4NCj5zZWxpbnV4ZnMuYz8NCj4NClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIg
cmV2aWV3LiANCkkgd2lsbCBzdWJtaXQgdGhlIHBhdGNoIGFzIHNvb24gYXMgcG9zc2libGUuDQoN
Cj4+IDE1OTAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiAxNTkxDQo+PiAxNTkyICAg
ICAgICAgaW5vZGUtPmlfZm9wID0gZmlsZXNbaV0ub3BzOw0KPj4gMTU5MyAgICAgICAgIGlub2Rl
LT5pX2lubyA9ICsrZnNpLT5sYXN0X2lubzsNCj4+IDE1OTQgICAgICAgICBkX2FkZChkZW50cnks
IGlub2RlKTsNCj4+IDE1OTUgICAgIH0NCj4+IDE1OTYNCj4+IDE1OTcgICAgIHJldHVybiAwOw0K
Pj4gMTU5OCB9DQo+Pg0KPj4gVGhlcmUgYXJlIHNpbWlsYXIgcmVzb3VyY2UgbGVha2luZyBmdW5j
dGlvbnM6DQo+PiBTZWxfbWFrZV9ib29scw0KPj4gU2VsX21ha2VfYXZjX2ZpbGVzDQo+PiBTZWxf
bWFrZV9pbml0Y29uX2ZpbGVzDQo+PiBTZWxfbWFrZV9wZXJtX2ZpbGVzDQo+PiBTZWxfbWFrZV9j
bGFzc19kaXJfZW50cmllcw0KPj4gU2VsX21ha2VfcG9saWN5Y2FwDQo+PiBTZWxfZmlsbF9zdXBl
cg0KPj4gU2VsX21ha2VfcG9saWN5X25vZGVzDQo+PiBTZWxfbWFrZV9jbGFzc2VzDQo+DQo+LS0g
DQo+cGF1bCBtb29yZQ0KPnd3dy5wYXVsLW1vb3JlLmNvbQ0KPg0KDQpUaGFua3MNCg0K
