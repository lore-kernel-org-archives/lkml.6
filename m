Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23355C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C072170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C072170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHTSr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:47:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:22909 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeHTSr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:47:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 08:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="78445952"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2018 08:31:23 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 08:31:22 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.225]) with mapi id 14.03.0319.002;
 Mon, 20 Aug 2018 08:31:22 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: RE: [PATCH RFC v2 3/5] LSM: Security module checking for
 side-channel dangers
Thread-Topic: [PATCH RFC v2 3/5] LSM: Security module checking for
 side-channel dangers
Thread-Index: AQHUNnfy9iCQCcft8Ea25S4ssHdZeqTFEyAAgAO1bVA=
Date:   Mon, 20 Aug 2018 15:31:22 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732143F7A4@ORSMSX107.amr.corp.intel.com>
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-4-casey.schaufler@intel.com>
 <CAG48ez3aB5X9=hqepovG6L4vQYZjzHZ6fWqdd4Vtzh92u2J5fQ@mail.gmail.com>
In-Reply-To: <CAG48ez3aB5X9=hqepovG6L4vQYZjzHZ6fWqdd4Vtzh92u2J5fQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmMxMWM1NDYtMTQyNi00OTNjLTk3MmQtYzFjOThlMDg2ZTc5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVThlVk9DOHNLVzlGc2xWMW1CUEE2djRlcTZySlVsZ2FCTWpOZTZRYUlZcjZVYnBnT2dKWnFnZEFyRjl2bngxVCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW5uIEhvcm4gW21haWx0bzpq
YW5uaEBnb29nbGUuY29tXQ0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAxNywgMjAxOCA0OjUzIFBN
DQo+IFRvOiBTY2hhdWZsZXIsIENhc2V5IDxjYXNleS5zY2hhdWZsZXJAaW50ZWwuY29tPg0KPiBD
YzogS2VybmVsIEhhcmRlbmluZyA8a2VybmVsLWhhcmRlbmluZ0BsaXN0cy5vcGVud2FsbC5jb20+
OyBrZXJuZWwgbGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXNl
Y3VyaXR5LW1vZHVsZSA8bGludXgtc2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc+
OyBzZWxpbnV4QHR5Y2hvLm5zYS5nb3Y7IEhhbnNlbiwgRGF2ZQ0KPiA8ZGF2ZS5oYW5zZW5AaW50
ZWwuY29tPjsgRG9jaywgRGVuZWVuIFQgPGRlbmVlbi50LmRvY2tAaW50ZWwuY29tPjsNCj4ga3Jp
c3RlbkBsaW51eC5pbnRlbC5jb207IEFyamFuIHZhbiBkZSBWZW4gPGFyamFuQGxpbnV4LmludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgdjIgMy81XSBMU006IFNlY3VyaXR5IG1v
ZHVsZSBjaGVja2luZyBmb3Igc2lkZS0NCj4gY2hhbm5lbCBkYW5nZXJzDQo+IA0KPiBPbiBTYXQs
IEF1ZyAxOCwgMjAxOCBhdCAxMjoxNyBBTSBDYXNleSBTY2hhdWZsZXINCj4gPGNhc2V5LnNjaGF1
ZmxlckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQ2FzZXkgU2NoYXVmbGVyIDxj
c2NoYXVmbGVyQGxvY2FsaG9zdC5sb2NhbGRvbWFpbj4NCj4gPg0KPiA+IFRoZSBzaWRlY2hhbm5l
bCBMU00gY2hlY2tzIGZvciBjYXNlcyB3aGVyZSBhIHNpZGUtY2hhbm5lbA0KPiA+IGF0dGFjayBt
YXkgYmUgZGFuZ2Vyb3VzIGJhc2VkIG9uIHNlY3VyaXR5IGF0dHJpYnV0ZXMgb2YgdGFza3MuDQo+
ID4gVGhpcyBpbmNsdWRlczoNCj4gPiAgICAgICAgIEVmZmVjdGl2ZSBVSUQgb2YgdGhlIHRhc2tz
IGlzIGRpZmZlcmVudA0KPiA+ICAgICAgICAgQ2FwYWJsaXR5IHNldHMgYXJlIGRpZmZlcmVudA0K
PiA+ICAgICAgICAgVGFza3MgYXJlIGluIGRpZmZlcmVudCBuYW1lc3BhY2VzDQo+ID4gQW4gb3B0
aW9uIGlzIGFsc28gcHJvdmlkZWQgdG8gYXNzZXJ0IHRoYXQgdGFzayBhcmUgbmV2ZXINCj4gPiB0
byBiZSBjb25zaWRlcmVkIHNhZmUuIFRoaXMgaXMgaGlnaCBwYXJhbm9pYSwgYW5kIGV4cGVuc2l2
ZQ0KPiA+IGFzIHdlbGwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDYXNleSBTY2hhdWZsZXIg
PGNhc2V5LnNjaGF1ZmxlckBpbnRlbC5jb20+DQo+IFsuLi5dDQo+ID4gKyNpZmRlZiBDT05GSUdf
U0VDVVJJVFlfU0lERUNIQU5ORUxfVUlEUw0KPiA+ICtzdGF0aWMgaW50IHNhZmVfYnlfdWlkKHN0
cnVjdCB0YXNrX3N0cnVjdCAqcCkNCj4gPiArew0KPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IGNy
ZWQgKmNjcmVkID0gY3VycmVudF9yZWFsX2NyZWQoKTsNCj4gPiArICAgICAgIGNvbnN0IHN0cnVj
dCBjcmVkICpwY3JlZCA9IGdldF90YXNrX2NyZWQocCk7DQo+ID4gKw0KPiA+ICsgICAgICAgLyoN
Cj4gPiArICAgICAgICAqIENyZWRlbnRpYWwgY2hlY2tzLiBDb25zaWRlcmVkIHNhZmUgaWY6DQo+
ID4gKyAgICAgICAgKiAgICAgIFVJRHMgYXJlIHRoZSBzYW1lDQo+ID4gKyAgICAgICAgKi8NCj4g
PiArICAgICAgIGlmIChjY3JlZCAhPSBwY3JlZCAmJiBjY3JlZC0+ZXVpZC52YWwgIT0gcGNyZWQt
PmV1aWQudmFsKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVBQ0NFUzsNCj4gPiArICAg
ICAgIHJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGxvb2tzIGJvZ3VzLiBn
ZXRfdGFza19jcmVkKCkgYnVtcHMgdGhlIHJlZmNvdW50IG9uIHRoZQ0KPiByZXR1cm5lZCBjcmVk
IHN0cnVjdCBwb2ludGVyLCBidXQgeW91IGRvbid0IGRyb3AgaXQuIFlvdSBwcm9iYWJseSB3YW50
DQo+IHRvIHVzZSBzb21ldGhpbmcgdGhhdCBkb2Vzbid0IGZpZGRsZSB3aXRoIHRoZSByZWZjb3Vu
dCBhdCBhbGwgaGVyZSB0bw0KPiBhdm9pZCBjYWNoZWxpbmUgYm91bmNpbmcgLSBwb3NzaWJseSBh
IHJhdyByY3VfZGVyZWZlcmVuY2VfcHJvdGVjdGVkKCkNCj4gaWYgdGhlcmUgYXJlIG5vIGJldHRl
ciBoZWxwZXJzLg0KPiANCj4gU2FtZSB0aGluZyBmb3IgdGhlIG90aGVyIGdldF90YXNrX2NyZWQo
KSBjYWxscyBmdXJ0aGVyIGRvd24gaW4gdGhlIHBhdGNoLg0KDQpUaGFua3MuIExvb2tzIGxpa2Ug
SSB3aGFja2VkIG91dCB2MiBhIGJpdCBoYXN0aWx5Lg0KDQo=
