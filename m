Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32169C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EC020672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EC020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeLMJUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:20:01 -0500
Received: from mail4.tencent.com ([183.57.53.109]:43604 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeLMJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:20:01 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2018 04:19:58 EST
Received: from EXHUB-SZMail05.tencent.com (unknown [10.14.6.11])
        by mail4.tencent.com (Postfix) with ESMTP id 35A5850ABA;
        Thu, 13 Dec 2018 17:13:36 +0800 (CST)
Received: from EXMBX-SZ087.tencent.com ([fe80::1d8e:2b7b:8b4e:4d80]) by
 EXHUB-SZMail05.tencent.com ([::1]) with mapi id 14.03.0415.000; Thu, 13 Dec
 2018 17:13:36 +0800
From:   =?utf-8?B?Z3VvbWluY2hlbijpmYjlm73msJEp?= <guominchen@tencent.com>
To:     Jason Wang <jasowang@redhat.com>,
        "gchen.guomin@gmail.com" <gchen.guomin@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIEV4cG9ydCBtbV91cGRhdGVfbmV4dF9vd25lciBm?=
 =?utf-8?Q?unction_for_vhost-net(Internet_mail)?=
Thread-Topic: [PATCH] Export mm_update_next_owner function for
 vhost-net(Internet mail)
Thread-Index: AQHUkq1zA1HRdcpd/E2xiMz/bcmpT6V8Plxg
Date:   Thu, 13 Dec 2018 09:13:34 +0000
Message-ID: <0D556C4F8D27C74EB25927291B4B0602A90693@EXMBX-SZ087.tencent.com>
References: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
 <94b66555-64cb-36c5-a5c0-c7256b659a0d@redhat.com>
In-Reply-To: <94b66555-64cb-36c5-a5c0-c7256b659a0d@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.87.58]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gICBVbmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlcyxXaGVuIGRvX2V4aXQgZXhpdHMsIG1tLT5v
d25lciB3aWxsDQo+PiAgIGJlIHVwZGF0ZWQgb24gZXhpdF9tbSgpLiBidXQgd2hlbiB0aGUga2Vy
bmVsIHByb2Nlc3MgY2FsbHMNCj4+ICAgdW51c2VfbW0oKSBhbmQgdGhlbiBleGl0cyxtbS0+b3du
ZXIgY2Fubm90IGJlIHVwZGF0ZWQuIEFuZCBpdA0KPj4gICB3aWxsIHBvaW50IHRvIGEgdGFzayB0
aGF0IGhhcyBiZWVuIHJlbGVhc2VkLg0KPj4NCj4+ICAgQmVsb3cgaXMgbXkgaXNzdWUgb24gdmhv
c3RfbmV0Og0KPj4gICAgICBBLCBCIGFyZSB0d28ga2VybmVsIHByb2Nlc3NlcyhzdWNoIGFzIHZo
b3N0X3dvcmtlciksDQo+PiAgICAgIEMgaXMgYSB1c2VyIHNwYWNlIHByb2Nlc3Moc3VjaCBhcyBx
ZW11KSwgYW5kIGFsbA0KPj4gICAgICB0aHJlZSB1c2UgdGhlIG1tIG9mIHRoZSB1c2VyIHByb2Nl
c3MgQy4NCj4+ICAgICAgTm93LCBiZWNhdXNlIHVzZXIgcHJvY2VzcyBDIGV4aXRzIGFibm9ybWFs
bHksIHRoZSBvd25lciBvZiB0aGlzDQo+PiAgICAgIG1tIGJlY29tZXMgQS4gV2hlbiBBIGNhbGxz
IHVudXNlX21tIGFuZCBleGl0cywgdGhpcyBtbS0+b3dlcg0KPj4gICAgICBzdGlsbCBwb2ludHMg
dG8gdGhlIEEgdGhhdCBoYXMgYmVlbiByZWxlYXNlZC4NCj4+ICAgICAgV2hlbiBCIGFjY2Vzc2Vz
IHRoaXMgbW0tPm93bmVyIGFnYWluLCBBIGhhcyBiZWVuIHJlbGVhc2VkLg0KDQoNClRoYW5rIHlv
dXIgZm9yIHRha2luZyBhIGxvb2sgYW5kIGFwb2xvZ2l6ZSBmb3IgbXkgZGlzdHJ1Yi4NCg0KPkNv
dWxkIHlvdSBkZXNjcmliZSBob3cgeW91IHJlcHJvZHVjZSB0aGlzIGlzc3VlPw0KU29ycnksIHRo
aXMgaXNzdWUgaXMgaGFyZCBmb3IgbXkgdG8gcmVwcm9kdWNlLCBCdXQgdGhlcmUgaXMgc3VjaCBh
IGNyaXRpY2FsIHNpdHVhdGlvbi4NCg0KPkkgYmVsaWV2ZSB2aG9zdCBwcm9jZXNzIHNob3VsZCBl
eGl0IGJlZm9yZSBwcm9jZXNzIEM/DQpZZXMsIHRoZSBBLCBCIHdpbGwgZXhpdCBiZWZvcmUgQywg
YmVjYXVzZSB1c3VhbGx5IEMgd2lsbCBjbG9zZSB0aGUgb3BlbiBmZCBhbmQgdGhlbiBleGl0Lg0K
SG93ZXZlciwgaWYgQyBpcyBhYm5vcm1hbGx5IGV4aXRlZCwgc3VjaCBhcyBraWxsZWQgYnkgc29t
ZSBmYXRhbCBzaWduYWwsIEEgbWF5IGV4aXQgYmVmb3JlIEMNCg0KVGhlIGN1cnJlbnQgaXNzdWUg
ZmxvdyBpcyBhcyBmb2xsb3dzOg0KUHJvY2VzcyBDICAgICAgICAgICAgICBQcm9jZXNzIEEgICAg
ICAgICBQcm9jZXNzIEINCnFlbXUtc3lzdGVtLXg4Nl82NDogICAgIGtlcm5lbDp2aG9zdF9uZXQg
IGtlcm5lbDogdmhvc3RfbmV0DQpvcGVuIC9kZXYvdmhvc3QtbmV0DQogIFZIT1NUX1NFVF9PV05F
UiAgIGNyZWF0ZSBrdGhyZWFkIHZob3N0LSVkICBjcmVhdGUga3RocmVhZCB2aG9zdC0lZA0KICBu
ZXR3b3JrIGluaXQgICAgICAgICAgIHVzZV9tbSgpICAgICAgICAgIHVzZV9tbSgpDQogICAuLi4g
ICAgICAgICAgICAgICAgICAgLi4uDQogICBBYm5vcm1hbCBleGl0ZWQNCiAgIC4uLg0KICBkb19l
eGl0DQogIGV4aXRfbW0oKQ0KICB1cGRhdGUgbW0tPm93bmVyIHRvIEENCiAgZXhpdF9maWxlcygp
DQogICBjbG9zZV9maWxlcygpDQogICBrdGhyZWFkX3Nob3VsZF9zdG9wKCkgdW51c2VfbW0oKQ0K
ICAgIFN0b3AgUHJvY2VzcyBBICAgICAgIHRzay0+bW09TlVMTA0KICAgICAgICAgICAgICAgICAg
ICAgICAgIGRvX2V4aXQoKQ0KICAgICAgICAgICAgICAgICAgICAgICAgIGNhbid0IHVwZGF0ZSBv
d25lcg0KICAgICAgICAgICAgICAgICAgICAgICAgIEEgZXhpdCBjb21wbGV0ZWQgICB2aG9zdC0l
ZCAgcmN2IGZpcnN0IHBhY2thZ2UNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmhvc3QtJWQgYnVpbGQgcmN2IGJ1ZmZlciBmb3IgdnENCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFnZSBmYXVsdA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3MgbW0gJiBtbS0+b3duZXINCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTk9XLG1tLT5vd25lciBzdGls
bCBwb2ludGVyIEENCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
a2VybmVsIE5VTEwgcG9pbnRlciBhdCBtZW1fY2dyb3VwX2Zyb21fdGFzaygpDQogICAgc3RvcCBQ
cm9jZXNzIEINCg0KPj4NCj4+IENjOiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5j
b20+DQo+PiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4+IENjOiBrdm1A
dmdlci5rZXJuZWwub3JnDQo+PiBDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcNCj4+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+PiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPj4gQ2M6ICJFcmljIFcuIEJpZWRlcm1hbiIgPGViaWVkZXJt
QHhtaXNzaW9uLmNvbT4NCj4+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRp
b24ub3JnPg0KPj4gQ2M6IFN1ZGlwIE11a2hlcmplZSA8c3VkaXBtLm11a2hlcmplZUBnbWFpbC5j
b20+DQo+PiBDYzogIkx1aXMgUi4gUm9kcmlndWV6IiA8bWNncm9mQGtlcm5lbC5vcmc+DQo+PiBD
YzogRG9taW5payBCcm9kb3dza2kgPGxpbnV4QGRvbWluaWticm9kb3dza2kubmV0Pg0KPj4gU2ln
bmVkLW9mZi1ieTogZ3VvbWluIGNoZW4gPGdjaGVuLmd1b21pbkBnbWFpbC5jb20+DQo+PiAtLS0N
Cj4+ICAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMSArDQo+PiAgIGtlcm5lbC9leGl0LmMgICAg
ICAgICB8IDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0
LmMNCj4+IGluZGV4IDZiOThkOGUuLjdjMDkwODcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3Zo
b3N0L3Zob3N0LmMNCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYw0KPj4gQEAgLTM2OCw2
ICszNjgsNyBAQCBzdGF0aWMgaW50IHZob3N0X3dvcmtlcih2b2lkICpkYXRhKQ0KPj4gICAJCX0N
Cj4+ICAgCX0NCj4+ICAgCXVudXNlX21tKGRldi0+bW0pOw0KPj4gKwltbV91cGRhdGVfbmV4dF9v
d25lcihkZXYtPm1tKTsNCg0KDQo+SWYgeW91IGFuYWx5c2lzIGlzIGNvcnJlY3QsIHRoaXMgaXMg
c3RpbGwgcmFjeSBpc24ndCBpdD8gKEUuZyBwYWdlIGZhdWx0IA0KPmhhcHBlbiBiZXR3ZWVuIHVu
dXNlX21tKCkgYW5kIG1tX3VwZGF0ZV9uZXh0X293bmVyKCkpLg0KDQpObywgSSB0aGluayB0aGlz
IGlzIG5vdCByYWN5LiANCldoZW4gcGFnZSBmYXVsdCBoYXBwZW5kIEJldHdlZW4gdW51c2VfbW0o
KSBhbmQgbW1fdXBkYXRlX25leHRfb3duZXIoKSwgQWx0aG91Z2ggdHNrLT5tbSA9TlVMTCwgDQpC
dXQgdHNrIGhhcyBub3QgZXhpdGVkLCBTbyBtbS0+b253ZXIgPSB0c2sgY2FuIHN0aWxsIGJlIGFj
Y2Vzc2VkLiAgDQoNClRoYW5rcyBhbmQgcmVnYXJkcw0KDQo=
