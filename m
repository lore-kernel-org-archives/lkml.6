Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0144C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A775F20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfAVJFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:05:35 -0500
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:48799 "EHLO
        mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfAVJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:05:34 -0500
X-Greylist: delayed 667 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 04:05:34 EST
Received: from yt-mxauth.gw.nic.fujitsu.com (unknown [192.168.229.68]) by mgwym01.jp.fujitsu.com with smtp
         id 42dd_ef38_fa7a404b_621d_48a5_a09c_3940e63890ae;
        Tue, 22 Jan 2019 17:54:24 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
        by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id A96AAAC00E2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 17:54:23 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
        by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id C8A126925C1;
        Tue, 22 Jan 2019 17:54:22 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Tue, 22 Jan 2019
 17:54:22 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: [PATCH v2 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v2 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdSyLOgvncWewEHxSDCVdyamf7TefQ==
Date:   Tue, 22 Jan 2019 08:54:21 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A32D6@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gc29tZSB2YXJpYW50cyBvZiB0aGUgRnVqaXRzdS1BNjRGWCBjb3JlcyB2
ZXIoMS4wLCAxLjEpLA0KIG1lbW9yeSBhY2Nlc3NlcyBtYXkgY2F1c2UgdW5k
ZWZpbmVkIGZhdWx0IChEYXRhIGFib3J0LCBERlNDPTBiMTExMTExKS4NClRo
aXMgcHJvYmxlbSB3aWxsIGJlIGZpeGVkIGJ5IG5leHQgdmVyc2lvbiBvZiBG
dWppdHN1LUE2NEZYLg0KSSB3b3VsZCBsaWtlIHRvIHBvc3QgYSB3b3JrYXJv
dW5kIHRvIGF2b2lkIHRoaXMgcHJvYmxlbSBvbiBleGlzdGluZyB2ZXJzaW9u
Lg0KVGhlIHdvcmthcm91bmQgaXMgdG8gcmVwbGFjZSB0aGUgZmF1bHQgaGFu
ZGxlciBmb3IgRGF0YSBhYm9ydA0KREZTQz0wYjExMTExMSB3aXRoIGEgbmV3
IG9uZSB0byBpZ25vcmUgdGhpcyB1bmRlZmluZWQgZmF1bHQsIA0Kd2hpY2gg
d2lsbCBvbmx5IGFmZmVjdCB0aGUgRnVqaXRzdS1BNjRGWC4NCg0KVGhlIGRl
dGFpbCBmb3IgdGhpcyBwcm9ibGVtLg0KPiAqIFVuZGVyIHdoYXQgY29uZGl0
aW9ucyBjYW4gdGhlIGZhdWx0IG9jY3VyPyBlLmcuIGlzIHRoaXMgaW4gcGxh
Y2Ugb2YNCj4gICBzb21lIG90aGVyIGZhdWx0LCBvciBjb21wbGV0ZWx5IHNw
dXJpb3VzPw0KVGhpcyBmYXVsdCBjYW4gb2NjdXIgY29tcGxldGVseSBzcHVy
aW91cyB1bmRlciBhIA0Kc3BlY2lmaWMgaGFyZHdhcmUgY29uZGl0aW9uIGFu
ZCBpbnN0cnVjdGlvbnMgb3JkZXIuDQogDQo+ICogRG9lcyB0aGlzIG9ubHkg
b2NjdXIgZm9yIGRhdGEgYWJvcnQ/IGkuZS4gbm90IGluc3RydWN0aW9uIGFi
b3J0cz8NClllcy4gVGhpcyBmYXVsdCBvbmx5IG9jY3VycyBmb3IgZGF0YSBh
Ym9ydC4NCg0KPiAqIEhvdyBvZnRlbiBkb2VzIHRoaXMgZmF1bHQgb2NjdXI/
DQpJbiBteSB0ZXN0LCB0aGlzIGZhdWx0IG9jY3VycyBvbmNlIGV2ZXJ5IHNl
dmVyYWwgdGltZXMgDQppbiB0aGUgT1MgYm9vdCBzZXF1ZW5jZSwgYW5kIGFm
dGVyIHRoZSBjb21wbGV0aW9uIG9mIE9TIGJvb3QsIA0KdGhpcyBmYXVsdCBo
YXZlIG5ldmVyIG9jY3VycmVkLg0KSW4gbXkgb3BpbmlvbiwgdGhpcyBmYXVs
dCByYXJlbHkgb2NjdXJzIGFmdGVyIHRoZSBjb21wbGV0aW9uIG9mIE9TIGJv
b3QuDQoNCj4gKiBEb2VzIHRoaXMgb25seSBhcHBseSB0byBTdGFnZS0xLCBv
ciBjYW4gdGhlIHNhbWUgZmF1bHRzIGJlIHRha2VuIGF0DQo+ICAgU3RhZ2Ut
Mj8NClRoaXMgZmF1bHQgY2FuIGJlIHRha2VuIG9ubHkgYXQgU3RhZ2UtMS4N
Cg0KPiBJJ20gYSBiaXQgc3VycHJpc2VkIGJ5IHRoZSBzaW5nbGUgcmV0cnku
IElzIHRoZXJlIGFueSBndWFyYW50ZWUgdGhhdCBhIA0KPiB0aHJlYWQgd2ls
bCBldmVudHVhbGx5IHN0b3AgZGVsaXZlcmluZyB0aGlzIGZhdWx0IGNvZGU/
DQpJIGd1YXJhbnRlZSB0aGF0IGEgdGhyZWFkIHdpbGwgc3RvcCBkZWxpdmVy
aW5nIHRoaXMgZmF1bHQgY29kZSBieSB0aGUgdGhpcyBwYXRjaC4NClRoZSBo
YXJkd2FyZSBjb25kaXRpb24gd2hpY2ggY2F1c2UgdGhpcyBmYXVsdCBpcyBy
ZXNldCBhdCBleGNlcHRpb24gZW50cnksIA0KdGhlcmVmb3JlIGV4ZWN1dGlv
biBvZiBhdCBsZWFzdCBvbmUgaW5zdHJ1Y3Rpb24gaXMgDQpndWFyYW50ZWVk
IGJ5IHRoaXMgc2luZ2xlIHJldHJ5Lg0KDQpDaGFuZ2VzIHNpbmNlIFt2MV0N
CkFzIE1hcmsncyByZXZpZXc6DQoNCiAqIEFkb3B0ZWQgZXJyYXRhIGZyYW1l
d29yay4NCg0KSSBoYXZlIGNvbmZpcm1lZCBhcyBmb2xsb3dpbmdzOg0KICog
RnVqaXRzdSBBNjRGWCAtIFRoZSBwcm9ibGVtIGRvZXNuJ3QgaGFwcGVuLg0K
ICogUUVNVSAgICAgICAgICAtIE5vIHByb2JsZW1zIHRvIGJvb3QuDQoNCkkg
ZnVsbHkgYXBwcmVjaWF0ZSB0aGF0IGlmIHNvbWVvbmUgY2FuIHRlc3QgdGhp
cyBwYXRjaCBvbiBkaWZmZXJlbnQgY2hpcHMgDQp0byB2ZXJpdHkgbm8gaGFy
bWZ1bCBlZmZlY3Qgb24gb3RoZXIgY2hpcHMuDQoNCklmIHRoZXJlIGlzIG5v
IHByb2JsZW0gb24gb3RoZXIgY2hpcHMsIHBsZWFzZSBtZXJnZSB0aGlzIHBh
dGNoLg0KDQpUaGUgcGF0Y2ggYmFzZWQgb24gbGludXgtNS4wLXJjMi4NCg0K
WmhhbmcgTGVpICgxKToNCiAgYXJtNjQ6IEFkZCB3b3JrYXJvdW5kIGZvciBG
dWppdHN1IEE2NEZYIGVycmF0dW0gMDEwMDAxLg0KDQogRG9jdW1lbnRhdGlv
bi9hcm02NC9zaWxpY29uLWVycmF0YS50eHQgfCAgMSArDQogYXJjaC9hcm02
NC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysr
KysrDQogYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVjYXBzLmggICAgICAg
fCAgMyArKy0NCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2NwdXR5cGUuaCAg
ICAgICB8ICA0ICsrKysNCiBhcmNoL2FybTY0L2tlcm5lbC9jcHVfZXJyYXRh
LmMgICAgICAgICB8ICA4ICsrKysrKysrDQogYXJjaC9hcm02NC9tbS9mYXVs
dC5jICAgICAgICAgICAgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysr
KysrKy0NCiA2IGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQoNCi0tIA0KMS44LjMuMQ0K
