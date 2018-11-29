Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6F32081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6F32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeK2LFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:05:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:1076 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeK2LFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:05:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 16:02:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,292,1539673200"; 
   d="scan'208";a="113349124"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2018 16:02:16 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.161]) with mapi id 14.03.0415.000;
 Wed, 28 Nov 2018 16:02:16 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 2/2] x86/modules: Make x86 allocs to flush when free
Thread-Topic: [PATCH 2/2] x86/modules: Make x86 allocs to flush when free
Thread-Index: AQHUhrIVy+5FSQqQvkm6Ovse+HnrpaVmWC6AgAAOrYA=
Date:   Thu, 29 Nov 2018 00:02:15 +0000
Message-ID: <c4d6ce8af83ab9f92e76f36bce7ffa5574f7104b.camel@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
         <20181128000754.18056-3-rick.p.edgecombe@intel.com>
         <20181128151145.78a3d8b1f66f6b8fd66f0629@linux-foundation.org>
In-Reply-To: <20181128151145.78a3d8b1f66f6b8fd66f0629@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.128]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD3C3FE40262C94EB56C735C4EBC5A4F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTI4IGF0IDE1OjExIC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBUdWUsIDI3IE5vdiAyMDE4IDE2OjA3OjU0IC0wODAwIFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IENoYW5nZSB0aGUgbW9k
dWxlIGFsbG9jYXRpb25zIHRvIGZsdXNoIGJlZm9yZSBmcmVlaW5nIHRoZSBwYWdlcy4NCj4gPiAN
Cj4gPiAuLi4NCj4gPiANCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbW9kdWxlLmMNCj4gPiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvbW9kdWxlLmMNCj4gPiBAQCAtODcsOCArODcsOCBAQCB2b2lk
ICptb2R1bGVfYWxsb2ModW5zaWduZWQgbG9uZyBzaXplKQ0KPiA+ICAJcCA9IF9fdm1hbGxvY19u
b2RlX3JhbmdlKHNpemUsIE1PRFVMRV9BTElHTiwNCj4gPiAgCQkJCSAgICBNT0RVTEVTX1ZBRERS
ICsgZ2V0X21vZHVsZV9sb2FkX29mZnNldCgpLA0KPiA+ICAJCQkJICAgIE1PRFVMRVNfRU5ELCBH
RlBfS0VSTkVMLA0KPiA+IC0JCQkJICAgIFBBR0VfS0VSTkVMX0VYRUMsIDAsIE5VTUFfTk9fTk9E
RSwNCj4gPiAtCQkJCSAgICBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOw0KPiA+ICsJCQkJ
ICAgIFBBR0VfS0VSTkVMX0VYRUMsIFZNX0lNTUVESUFURV9VTk1BUCwNCj4gPiArCQkJCSAgICBO
VU1BX05PX05PREUsIF9fYnVpbHRpbl9yZXR1cm5fYWRkcmVzcygwKSk7DQo+ID4gIAlpZiAocCAm
JiAoa2FzYW5fbW9kdWxlX2FsbG9jKHAsIHNpemUpIDwgMCkpIHsNCj4gPiAgCQl2ZnJlZShwKTsN
Cj4gPiAgCQlyZXR1cm4gTlVMTDsNCj4gDQo+IFNob3VsZCBhbnkgb3RoZXIgYXJjaGl0ZWN0dXJl
cyBkbyB0aGlzPw0KDQpJIHdvdWxkIHRoaW5rIGV2ZXJ5dGhpbmcgdGhhdCBoYXMgc29tZXRoaW5n
IGxpa2UgYW4gTlggYml0IGFuZCBkb2Vzbid0IHVzZSB0aGUNCmRlZmF1bHQgbW9kdWxlX2FsbG9j
IGltcGxlbWVudGF0aW9uLg0KDQpJIGNvdWxkIGFkZCB0aGUgZmxhZyBmb3IgZXZlcnkgYXJjaCB0
aGF0IGRlZmluZXMgUEFHRV9LRVJORUxfRVhFQywgYnV0IEkgZG9uJ3QNCmhhdmUgYSBnb29kIHdh
eSB0byB0ZXN0IG9uIGFsbCBvZiB0aG9zZSBhcmNoaXRlY3R1cmVzLg0KDQpUaGFua3MsDQoNClJp
Y2sNCg==
