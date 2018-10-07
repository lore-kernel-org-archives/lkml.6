Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B67FC65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961612084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 20:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961612084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeJHDft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 23:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJHDfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 23:35:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68627308FC50;
        Sun,  7 Oct 2018 20:27:22 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 520CF63141;
        Sun,  7 Oct 2018 20:27:22 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 08CF91808855;
        Sun,  7 Oct 2018 20:27:21 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: base64
From:   Rodrigo Freire <rfreire@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] CIFS: Info-level log support, print message when attempting mount.
Message-Id: <9006BE8A-38BB-4249-BEBA-C0DB34560885@redhat.com>
Date:   Sun, 7 Oct 2018 16:27:21 -0400 (EDT)
References: <cover.1538873915.git.rfreire@redhat.com> <CAH2r5muEpTd4xG7oWV5BdA12AOogqscEnFdbUri9C=MFHrN_gQ@mail.gmail.com>
To:     Steve French <smfrench@gmail.com>
In-Reply-To: <CAH2r5muEpTd4xG7oWV5BdA12AOogqscEnFdbUri9C=MFHrN_gQ@mail.gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Thread-Topic: CIFS: Info-level log support, print message when attempting mount.
Thread-Index: 4Xvg4gPOyuBLdqWm7zv9mNmeiGNGAA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 07 Oct 2018 20:27:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIFN0ZXZlISBTb3JyeSBmb3Igb3Zlcmxvb2tpbmcgaXQsIHdob29wcy4NCg0KT25lIG1v
cmUgcXVlc3Rpb247IHdoYXTigJlzIHlvdXIvY29tbXVuaXR5IG9waW5pb24gb24gcmV3cml0aW5n
IHRoZSBleGlzdGluZyBwcl9ub3RpY2UgdG8gdGhlIG5ldyBjaWZzX2luZm8/DQoNCkkgY291bGQg
aGFwcGlseSByZXRyb2ZpdCBpdC4NCg0KSGF2ZSBhIGdyZWF0IHdlZWshDQoNCi0gUkYNClNlbnQg
ZnJvbSBhIG1vYmlsZSBkZXZpY2UNCg0KPiBPbiA3IE9jdCAyMDE4LCBhdCAxNTo1OSwgU3RldmUg
RnJlbmNoIDxzbWZyZW5jaEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gTWVyZ2VkIGludG8gY2lm
cy0yLjYuZ2l0IGZvci1uZXh0DQo+IA0KPiBNYWRlIGEgdHJpdmlhbCB0YWIvc3BhY2UgY29ycmVj
dGlvbiBpbiB0aGUgcGF0Y2ggKHBvaW50ZWQgb3V0IGJ5DQo+IGNoZWNrcGF0Y2gpIGFuZCB0aGVu
IGFkZGVkIGEgdHJpdmlhbCBmb2xsb3dvbiBwYXRjaCB0byBhZGRyZXNzIGENCj4gY29tbWVudC9z
dHlsZSAodHJpdmlhbCkNCj4gaXNzdWUgcG9pbnRlZCBvdXQgYnkgY2hlY2twYXRjaCBhbmQgdG8g
YWRkIGEgbGl0dGxlIG1vcmUgZGV0YWlsZWQNCj4gY29tbWVudHMgYWJvdXQgZ2VuZXJhbGx5IHdo
ZW4gdG8gdXNlIGVhY2ggZGVidWcgZnVuY3Rpb24uICBJZiBhbnkNCj4gb2JqZWN0aW9ucyBsZXQg
bWUga25vdy4NCj4gDQo+IA0KPj4gT24gU3VuLCBPY3QgNywgMjAxOCBhdCAxMDoyMSBBTSBSb2Ry
aWdvIEZyZWlyZSA8cmZyZWlyZUByZWRoYXQuY29tPiB3cm90ZToNCj4+IA0KPj4gSGkgU3RldmUs
DQo+PiBGcm9tIG91ciBjb252ZXJzYXRpb24gb3ZlciB2MiwgSSBjYW1lIG91dCB3aXRoIHRoaXMg
djMgcGF0Y2gsIHdoaWNoIEkgYnJva2UNCj4+IGluIHR3byBjb21taXRzOg0KPj4gDQo+PiAqIFRo
ZSBmaXJzdCBjb21taXQgaW4gY2lmc19kZWJ1Zy5oLCBjcmVhdGluZyB0aGUgY2lmc19pbmZvKCkg
ZnVuY3Rpb24uDQo+PiAgLSBUaGUgYWltIG9mIHRoaXMgY29tbWl0IGlzIHRvIGFsbG93IHRvIHRo
ZSBkZXZlbG9wZXIgdG8gYmUgYWJsZSB0byBwcmludA0KPj4gICAgaW5mb3JtYXRpb25hbC1sZXZl
bCBkYXRhIHdpdGhvdXQgaGF2aW5nIHRvIHVzZSBwcl9pbmZvLCBwcl9ub3RpY2UgZXRjLA0KPj4g
ICAgaW4gbGluZSB3aXRoIG90aGVyIGZpbGVzeXN0ZW1zLg0KPj4gICAgLiBPbmUgaW50ZXJlc3Rp
bmcgYW5kIG5vdGV3b3J0aHkgZmVhdHVyZSBvZiBjaWZzX2luZm8oKSBpcyB0aGF0IGl0IGlzDQo+
PiAgICAgIHRyYW5zcGFyZW50IHRvIHRoZSBDSUZTX0RFQlVHIGNvbmZpZyBzdGF0ZSwgZWl0aGVy
IGluICJ5IiBvciAibiIuDQo+PiAgICAuIEFsc28sIGJ5IHVzaW5nIEtFUk5fSU5GTyBsZXZlbCwg
aXQgY2FuIGJlIHNhZmVseSBmaWx0ZXJlZCBieSBhDQo+PiAgICAgIG1haW50YWluZXIgLyBhZG1p
bmlzdHJhdG9yLCB3aXRob3V0IGNsdXR0ZXJpbmcgdGhlaXIgbG9nIG1vbml0b3JzLA0KPj4gICAg
ICBzaW5jZSB0aGlzIGlzIGEgbG93IGxldmVsIGFsZXJ0Lg0KPj4gIC0gSSB0b29rIHRoZSBsaWJl
cnR5IHRvIG5vdCBhZGQgaXQgaW5zaWRlIHRoZSBleGlzdGluZyBwcl9kZWJ1ZywgYmVjYXVzZQ0K
Pj4gICAgb2YgdGhlIGV2ZW50dWFsIG5lZWQgb2Ygc29tZSBkZXZlbG9wZXIgdG8gcHJpbnQgc3R1
ZmYgdGhhdCBzaG91bGQgYmUNCj4+ICAgIHByaW50ZWQgbm90IG9ubHkgaW4gQ0lGU19ERUJVRyBt
b2RlIChhcyB0aGVyZSBhcmUgcGxlbnR5IG9mIHByX25vdGljZQ0KPj4gICAgc2NhdHRlcmVkIG92
ZXIgdGhlIGNvZGUpLg0KPj4gIC0gQWxzbywgdGhpcyBpcyBub3QgYSBkZWJ1ZyBidXQgYSBpbmZv
IG1lc3NhZ2UsIHNvIGkgbGlrZWQgY2lmc19pbmZvKCkNCj4+ICAgIG1vcmUgOy0pDQo+PiAgLSBJ
IHNhdyBwbGVudHkgb2YgcHJfbm90aWNlKCkgaW4gQ0lGUyBjb2RlLCBidXQgSSByZXNpc3RlZCB0
aGUgdXJnZSB0bw0KPj4gICAgY29udmVydCB0aGVtIHRvIGNpZnNfaW5mbygpLg0KPj4gDQo+PiAq
IFRoZSBzZWNvbmQgY29tbWl0IGNvbnRhaW5zIHRoZSBjb2RlIHByaW50aW5nIGEgY2lmc19pbmZv
KCkgd2hlbiBhdHRlbXB0aW5nDQo+PiAgYSBDSUZTIG1vdW50IG9wZXJhdGlvbi4NCj4+IA0KPj4g
QXBwcmVjaWF0ZSB5b3VyIHJldmlldy4NCj4+IA0KPj4gVjM6IENyZWF0ZWQgYSBuZXcgY2lmc19p
bmZvKCkgZnVuY3Rpb24sIG1vdmVkIHRoZSBtb3VudCBhdHRlbXB0IG1lc3NhZ2UgdG8NCj4+ICAg
IGNpZnNfaW5mbw0KPj4gDQo+PiBWMjogQ3JlYXRlZCBhIGxvb3AgdG8gc2VsZWN0IHRoZSByaWdo
dCBjaWZzX2RiZyBtZXNzYWdlIHRvIGJlIHByaW50ZWQsDQo+PiAgICBjb25zaWRlcmluZyB0aGUg
Y3VycmVudCBzeXN0ZW0ncyBzY2VuYXJpbywgaW4gb3JkZXIgdG8gYXZvaWQgYQ0KPj4gICAgZHVw
bGljYXRlIG1lc3NhZ2Ugb3Igc3RyaXBwaW5nIG91dCBpbXBvcnRhbnQgaW5mb3JtYXRpb24gaW4N
Cj4+ICAgIGRlYnVnLg0KPj4gDQo+PiBSb2RyaWdvIEZyZWlyZSAoMik6DQo+PiAgQ0lGUzogQWRk
cyBpbmZvcm1hdGlvbi1sZXZlbCBsb2dnaW5nIGZ1bmN0aW9uDQo+PiAgQ0lGUzogUHJpbnQgbWVz
c2FnZSB3aGVuIGF0dGVtcHRpbmcgYSBtb3VudA0KPj4gDQo+PiBmcy9jaWZzL2NpZnNfZGVidWcu
aCB8IDE2ICsrKysrKysrKysrKysrKysNCj4+IGZzL2NpZnMvY2lmc2ZzLmMgICAgIHwgIDcgKysr
KysrLQ0KPj4gZnMvY2lmcy90cmFuc3BvcnQuYyAgfCAgMiArLQ0KPj4gMyBmaWxlcyBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiAtLQ0KPj4gMS44LjMu
MQ0KPj4gDQo+IA0KPiANCj4gLS0gDQo+IFRoYW5rcywNCj4gDQo+IFN0ZXZlDQo+IDwwMDAxLWNp
ZnMtbWlub3ItY2xhcmlmaWNhdGlvbi1pbi1jb21tZW50cy5wYXRjaD4NCg==
