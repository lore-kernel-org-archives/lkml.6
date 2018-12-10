Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D7FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D0A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 03:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D0A20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLJDVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 22:21:11 -0500
Received: from mail2.tencent.com ([163.177.67.195]:43478 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJDVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 22:21:10 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Dec 2018 22:21:09 EST
Received: from EXHUB-SZMAIL04.tencent.com (unknown [10.14.6.35])
        by mail2.tencent.com (Postfix) with ESMTP id BCB10183C9;
        Mon, 10 Dec 2018 11:14:14 +0800 (CST)
Received: from EXMBX-SZ087.tencent.com ([fe80::1d8e:2b7b:8b4e:4d80]) by
 EXHUB-SZMAIL04.tencent.com ([::1]) with mapi id 14.03.0415.000; Mon, 10 Dec
 2018 11:14:13 +0800
From:   =?gb2312?B?Z3VvbWluY2hlbiizwrn6w/Ep?= <guominchen@tencent.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "gchen.guomin@gmail.com" <gchen.guomin@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSAgRml4IG1tLT5vd25lciBwb2ludCB0byBhIHRhc2sg?=
 =?gb2312?Q?that_does_not_exists(Internet_mail)?=
Thread-Topic: [PATCH]  Fix mm->owner point to a task that does not
 exists(Internet mail)
Thread-Index: AQHUj4/chvvhQlbOVUu+JtflB9j6hqV2rEsAgACL7QA=
Date:   Mon, 10 Dec 2018 03:14:10 +0000
Message-ID: <0D556C4F8D27C74EB25927291B4B0602A90358@EXMBX-SZ087.tencent.com>
References: <1544340077-11491-1-git-send-email-gchen.guomin@gmail.com>
 <20181209201309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181209201309-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.87.58]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gRnJvbTogZ3VvbWluY2hlbiA8Z3VvbWluY2hlbkB0ZW5jZW50LmNvbT4NCj4+IA0KPj4gICBV
bmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlcyxXaGVuIGRvX2V4aXQgZXhpdHMsIG1tLT5vd25lciB3
aWxsDQo+PiAgIGJlIHVwZGF0ZWQsIGJ1dCB3aGVuIHRoZSBrZXJuZWwgcHJvY2VzcyBjYWxscyB1
bnVzZV9tbSBhbmQgZXhpdHMsDQo+PiAgIG1tLT5vd25lciBjYW5ub3QgYmUgdXBkYXRlZC4gQW5k
IHdpbGwgcG9pbnQgdG8gYSB0YXNrIHRoYXQgaGFzDQo+PiAgIGJlZW4gcmVsZWFzZWQuDQo+PiAN
Cj4+ICAgQmVsb3cgaXMgbXkgaXNzdWUgb24gdmhvc3RfbmV0Og0KPj4gICAgIEEsIEIgYXJlIHR3
byBrZXJuZWwgcHJvY2Vzc2VzKHN1Y2ggYXMgdmhvc3Rfd29ya2VyKSwNCj4+ICAgICBDIGlzIGEg
dXNlciBzcGFjZSBwcm9jZXNzKHN1Y2ggYXMgcWVtdSksIGFuZCBhbGwNCj4+ICAgICB0aHJlZSB1
c2UgdGhlIG1tIG9mIHRoZSB1c2VyIHByb2Nlc3MgQy4NCj4+ICAgICBOb3csIGJlY2F1c2UgdXNl
ciBwcm9jZXNzIEMgZXhpdHMgYWJub3JtYWxseSwgdGhlIG93bmVyIG9mIHRoaXMNCj4+ICAgICBt
bSBiZWNvbWVzIEEuIFdoZW4gQSBjYWxscyB1bnVzZV9tbSBhbmQgZXhpdHMsIHRoaXMgbW0tPm93
ZXINCj4+ICAgICBzdGlsbCBwb2ludHMgdG8gdGhlIEEgdGhhdCBoYXMgYmVlbiByZWxlYXNlZC4N
Cj4+ICAgICBXaGVuIEIgYWNjZXNzZXMgdGhpcyBtbS0+b3duZXIgYWdhaW4sIEEgaGFzIGJlZW4g
cmVsZWFzZWQuDQo+PiANCj4+ICAgUHJvY2VzcyBBCQlQcm9jZXNzIEINCj4+ICB2aG9zdF93b3Jr
ZXIoKQkgICAgICAgdmhvc3Rfd29ya2VyKCkNCj4+ICAgLS0tLS0tLS0tICAgIAkJLS0tLS0tLS0t
DQo+PiAgIHVzZV9tbSgpCQl1c2VfbW0oKQ0KPj4gICAgLi4uDQo+PiAgIHVudXNlX21tKCkNCj4+
ICAgICAgdHNrLT5tbT1OVUxMDQo+PiAgICBkb19leGl0KCkgICAgIAlwYWdlIGZhdWx0DQo+PiAg
ICAgZXhpdF9tbSgpCSAJYWNjZXNzIG1tLT5vd25lcg0KPj4gICAgY2FuJ3QgdXBkYXRlIG93bmVy
CWtlcm5lbCBPb3BzDQo+PiANCj4+IAkJCXVudXNlX21tKCkNCj4+IA0KPj4gQ2M6IDxsaW51eC1t
bUBrdmFjay5vcmc+DQo+PiBDYzogPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+PiBD
YzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPg0KPj4gQ2M6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+PiBDYzogPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBndW9taW5jaGVuIDxndW9taW5jaGVuQHRlbmNlbnQuY29tPg0K
Pj4gLS0tDQo+PiAgbW0vbW11X2NvbnRleHQuYyB8IDEgLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9tbS9tbXVfY29udGV4dC5jIGIvbW0v
bW11X2NvbnRleHQuYyBpbmRleCANCj4+IDNlNjEyYWUuLjE4NWJiMjMgMTAwNjQ0DQo+PiAtLS0g
YS9tbS9tbXVfY29udGV4dC5jDQo+PiArKysgYi9tbS9tbXVfY29udGV4dC5jDQo+PiBAQCAtNTYs
NyArNTYsNiBAQCB2b2lkIHVudXNlX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPj4gIA0KPj4g
IAl0YXNrX2xvY2sodHNrKTsNCj4+ICAJc3luY19tbV9yc3MobW0pOw0KPj4gLQl0c2stPm1tID0g
TlVMTDsNCj4+ICAJLyogYWN0aXZlX21tIGlzIHN0aWxsICdtbScgKi8NCj4+ICAJZW50ZXJfbGF6
eV90bGIobW0sIHRzayk7DQo+PiAgCXRhc2tfdW5sb2NrKHRzayk7DQoNCj5TbyB0aGF0IHdpbGwg
d29yayBmb3Igdmhvc3QgYmVjYXVzZSB3ZSBuZXZlciBkcm9wIHRoZSBtbSByZWZlcmVuY2UgYmVm
b3JlIGRlc3Ryb3lpbmcgdGhlIHRhc2suDQo+SSB3b25kZXIgd2hldGhlciB0aGF0J3MgdHJ1ZSBm
b3Igb3RoZXIgdXNlcnMgdGhvdWdoLg0KDQo+SXQgd291bGQgc2VlbSBjbGVhbmVyIHRvIG9udm9r
ZSBzb21lIGNhbGxiYWNrIHNvIHRhc2tzIHN1Y2ggYXMgdmhvc3QgY2FuIGRyb3AgdGhlIHJlZmVy
ZW5jZS4NCg0KWWVzLCBJIGNhbiByZW1vdmUgdGhpcyBjYWxsIGluIHZob3N0LCBidXQgSSB0aGlu
ayB1c2VfbW0oKSwgYW5kIHVudXNlX21tKCkgYXJlIGNhbGxlZCBpbiBwYWlycyBpbg0Kb3JkZXIg
dG8gc2hhcmUgbW0uDQpBbmQgZXhpdF9tbSgpIGFzIGEgdW5pZmllZCBtbSBoYW5kbGVyLCBpdCBk
b2luZyB2ZXJ5IHdlbGwsIFNvIHdlIHNob3VsZCBsZWF2ZSBtbSB0byBleGl0X21tKCkgDQp0byBo
YW5kbGUgaXQuDQoNCj5BbmQgbG9va2luZyBhdCBhbGwgdGhpcyBjb2RlLCBJIGRvbid0IHVuZGVy
c3RhbmQgd2h5IGlzIG1tLT5vd25lciBzYWZlIHRvIGNoYW5nZSBsaWtlIHRoaXM6DQo+ICAgICAg
ICBtbS0+b3duZXIgPSBOVUxMOw0KPndoZW4gdXNlcnMgc2VlbSB0byB1c2UgaXQgdW5kZXIgUkNV
Lg0KDQpJIHRoaW5rIHRoYXQgbW0tPm93bmVyPU5VTEwganVzdCBjaGFuZ2VzIHRoZSB2YWx1ZSBv
ZiB0aGUgcG9pbnRlciwgYW5kIHRoZSB0YXNrX3N0cnVjdCBpdCBwb2ludHMgdG8gDQppcyBwcmVz
ZW50IGFuZCBub3QgcmVsZWFzZWQuDQoNCg0KPj4gLS0NCj4+IDEuOC4zLjENCg0K
