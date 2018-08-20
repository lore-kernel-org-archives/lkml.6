Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7442172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7442172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeHTSBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:01:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:33241 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbeHTSBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:01:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 07:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="63796093"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2018 07:45:12 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 07:45:11 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.195]) with mapi id 14.03.0319.002;
 Mon, 20 Aug 2018 07:45:11 -0700
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
Subject: RE: [PATCH RFC v2 2/5] X86: Support LSM determination of
 side-channel vulnerability
Thread-Topic: [PATCH RFC v2 2/5] X86: Support LSM determination of
 side-channel vulnerability
Thread-Index: AQHUNnfxqicfKrr44E68NP+tZyvMZaTFE9UAgAOi9EA=
Date:   Mon, 20 Aug 2018 14:45:10 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732143F769@ORSMSX107.amr.corp.intel.com>
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-3-casey.schaufler@intel.com>
 <CAG48ez23G+wcnkCMNZV_mxYMS=h+pZkpx1451Wz5GB9_tcDv3Q@mail.gmail.com>
In-Reply-To: <CAG48ez23G+wcnkCMNZV_mxYMS=h+pZkpx1451Wz5GB9_tcDv3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDVjZTU0ZmYtZDg1Yi00NmY4LTkwOTEtZDRmNTc1ZmNlNTRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUGJNbkRmYmRleDN3XC8zRXNuM3lBVXJwM004OFVFQTVMQUhhSGphQ2hDOUdSN1UrckMyMjVWS1hSVDNkZTVmRE4ifQ==
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
YW5uaEBnb29nbGUuY29tXQ0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAxNywgMjAxOCA0OjU1IFBN
DQo+IFRvOiBTY2hhdWZsZXIsIENhc2V5IDxjYXNleS5zY2hhdWZsZXJAaW50ZWwuY29tPg0KPiBD
YzogS2VybmVsIEhhcmRlbmluZyA8a2VybmVsLWhhcmRlbmluZ0BsaXN0cy5vcGVud2FsbC5jb20+
OyBrZXJuZWwgbGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXNl
Y3VyaXR5LW1vZHVsZSA8bGludXgtc2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc+
OyBzZWxpbnV4QHR5Y2hvLm5zYS5nb3Y7IEhhbnNlbiwgRGF2ZQ0KPiA8ZGF2ZS5oYW5zZW5AaW50
ZWwuY29tPjsgRG9jaywgRGVuZWVuIFQgPGRlbmVlbi50LmRvY2tAaW50ZWwuY29tPjsNCj4ga3Jp
c3RlbkBsaW51eC5pbnRlbC5jb207IEFyamFuIHZhbiBkZSBWZW4gPGFyamFuQGxpbnV4LmludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgdjIgMi81XSBYODY6IFN1cHBvcnQgTFNN
IGRldGVybWluYXRpb24gb2Ygc2lkZS0NCj4gY2hhbm5lbCB2dWxuZXJhYmlsaXR5DQo+IA0KPiBP
biBTYXQsIEF1ZyAxOCwgMjAxOCBhdCAxMjoxNyBBTSBDYXNleSBTY2hhdWZsZXINCj4gPGNhc2V5
LnNjaGF1ZmxlckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQ2FzZXkgU2NoYXVm
bGVyIDxjc2NoYXVmbGVyQGxvY2FsaG9zdC5sb2NhbGRvbWFpbj4NCj4gPg0KPiA+IFdoZW4gc3dp
dGNoaW5nIGJldHdlZW4gdGFza3MgaXQgbWF5IGJlIG5lY2Vzc2FyeQ0KPiA+IHRvIHNldCBhbiBp
bmRpcmVjdCBicmFuY2ggcHJlZGljdGlvbiBiYXJyaWVyIGlmIHRoZQ0KPiA+IHRhc2tzIGFyZSBw
b3RlbnRpYWxseSB2dWxuZXJhYmxlIHRvIHNpZGUtY2hhbm5lbA0KPiA+IGF0dGFja3MuIFRoaXMg
YWRkcyBhIGNhbGwgdG8gc2VjdXJpdHlfdGFza19zYWZlX3NpZGVjaGFubmVsDQo+ID4gc28gdGhh
dCBzZWN1cml0eSBtb2R1bGVzIGNhbiB3ZWlnaCBpbiBvbiB0aGUgZGVjaXNpb24uDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDYXNleSBTY2hhdWZsZXIgPGNhc2V5LnNjaGF1ZmxlckBpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L21tL3RsYi5jIHwgMTIgKysrKysrKystLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vdGxiLmMgYi9hcmNoL3g4Ni9tbS90bGIuYw0K
PiA+IGluZGV4IDZlYjFmMzRjM2M4NS4uODcxNGQ0YWYwNmFhIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gveDg2L21tL3RsYi5jDQo+ID4gKysrIGIvYXJjaC94ODYvbW0vdGxiLmMNCj4gPiBAQCAtNyw2
ICs3LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvY3B1Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9zZWN1cml0eS5oPg0KPiA+DQo+ID4gICNpbmNsdWRlIDxhc20vdGxiZmx1c2gu
aD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9tbXVfY29udGV4dC5oPg0KPiA+IEBAIC0yNzAsMTEgKzI3
MSwxNCBAQCB2b2lkIHN3aXRjaF9tbV9pcnFzX29mZihzdHJ1Y3QgbW1fc3RydWN0ICpwcmV2LA0K
PiBzdHJ1Y3QgbW1fc3RydWN0ICpuZXh0LA0KPiA+ICAgICAgICAgICAgICAgICAgKiB0aHJlYWRz
LiBJdCB3aWxsIGFsc28gbm90IGZsdXNoIGlmIHdlIHN3aXRjaCB0byBpZGxlDQo+ID4gICAgICAg
ICAgICAgICAgICAqIHRocmVhZCBhbmQgYmFjayB0byB0aGUgc2FtZSBwcm9jZXNzLiBJdCB3aWxs
IGZsdXNoIGlmIHdlDQo+ID4gICAgICAgICAgICAgICAgICAqIHN3aXRjaCB0byBhIGRpZmZlcmVu
dCBub24tZHVtcGFibGUgcHJvY2Vzcy4NCj4gPiArICAgICAgICAgICAgICAgICogSWYgYSBzZWN1
cml0eSBtb2R1bGUgdGhpbmtzIHRoYXQgdGhlIHRyYW5zaXRpb24NCj4gPiArICAgICAgICAgICAg
ICAgICogaXMgdW5zYWZlIGRvIHRoZSBmbHVzaC4NCj4gPiAgICAgICAgICAgICAgICAgICovDQo+
ID4gLSAgICAgICAgICAgICAgIGlmICh0c2sgJiYgdHNrLT5tbSAmJg0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgdHNrLT5tbS0+Y29udGV4dC5jdHhfaWQgIT0gbGFzdF9jdHhfaWQgJiYNCj4gPiAt
ICAgICAgICAgICAgICAgICAgIGdldF9kdW1wYWJsZSh0c2stPm1tKSAhPSBTVUlEX0RVTVBfVVNF
UikNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpbmRpcmVjdF9icmFuY2hfcHJlZGljdGlv
bl9iYXJyaWVyKCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICh0c2sgJiYgdHNrLT5tbSAmJiB0
c2stPm1tLT5jb250ZXh0LmN0eF9pZCAhPSBsYXN0X2N0eF9pZCkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChnZXRfZHVtcGFibGUodHNrLT5tbSkgIT0gU1VJRF9EVU1QX1VTRVIg
fHwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VjdXJpdHlfdGFza19zYWZlX3Np
ZGVjaGFubmVsKHRzaykgIT0gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGluZGlyZWN0X2JyYW5jaF9wcmVkaWN0aW9uX2JhcnJpZXIoKTsNCj4gPiArICAgICAgICAgICAg
ICAgfQ0KPiANCj4gV2hlbiB5b3UgcG9zdGVkIHYxIG9mIHRoaXMgc2VyaWVzLCBJIGFza2VkOg0K
PiANCj4gfCBEb2VzIHRoaXMgZW5mb3JjZSB0cmFuc2l0aXZpdHk/IFdoYXQgaGFwcGVucyBpZiB3
ZSBmaXJzdCBzd2l0Y2ggZnJvbQ0KPiB8IGFuIGF0dGFja2VyIHRhc2sgdG8gYSB0YXNrIHdpdGhv
dXQgLT5tbSwgYW5kIGltbWVkaWF0ZWx5IGFmdGVyd2FyZHMNCj4gfCBmcm9tIHRoZSB0YXNrIHdp
dGhvdXQgLT5tbSB0byBhIHZpY3RpbSB0YXNrPyBJbiB0aGF0IGNhc2UsIHdoZXRoZXIgYQ0KPiB8
IGZsdXNoIGhhcHBlbnMgYmV0d2VlbiB0aGUgYXR0YWNrZXIgdGFzayBhbmQgdGhlIHZpY3RpbSB0
YXNrIGRlcGVuZHMgb24NCj4gfCB3aGV0aGVyIHRoZSBMU00gdGhpbmtzIHRoYXQgdGhlIG1tLWxl
c3MgdGFzayBzaG91bGQgaGF2ZSBhY2Nlc3MgdG8gdGhlDQo+IHwgdmljdGltIHRhc2ssIHJpZ2h0
Pw0KPiANCj4gSGF2ZSB5b3UgYWRkcmVzc2VkIHRoYXQ/IEkgZG9uJ3Qgc2VlIGl0Li4uDQoNCk5v
cGUuIFRoYXQncyBnb2luZyB0byByZXF1aXJlIG1haW50YWluaW5nIHN0YXRlIGFib3V0IGFsbCB0
aGUNCnRhc2tzIGluIHRoZSBjaGFpbiB0aGF0IG1pZ2h0IHN0aWxsIGhhdmUgY2FjaGUgaW52b2x2
ZW1lbnQuDQoNCglBIC0+IEIgLT4gQyAtPiBEDQoNCklmIEIgYW5kIEMgZG9uJ3QgZG8gYW55dGhp
bmcgY2FjaGV3b3J0aHkgRCBjb3VsZCBjb25jZWl2YWJseSBhdHRhY2sgQS4NClRoZSBhbW91bnQg
b2Ygc3RhdGUgcmVxdWlyZWQgdG8gZGV0ZWN0IHRoaXMgY2FzZSB3b3VsZCBiZSBwcm9oaWJpdGl2
ZS4NCkkgdGhpbmsgdGhhdCBpZiB5b3UncmUgc3VmZmljaWVudGx5IGNvbmNlcm5lZCBhYm91dCB0
aGlzIGNhc2UgeW91IHNob3VsZCBqdXN0DQpnbyBhaGVhZCBhbmQgc2V0IHRoZSBiYXJyaWVyLiBJ
J20gd2lsbGluZyB0byBsZWFybiBzb21ldGhpbmcgdGhhdCBzYXlzIEknbQ0Kd3JvbmcuDQoNCg==
