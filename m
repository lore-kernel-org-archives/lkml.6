Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F605C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010B2208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010B2208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeHBGNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:13:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:26181 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeHBGNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:13:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 21:24:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="72638062"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2018 21:24:26 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 21:24:26 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Thu, 2 Aug 2018 12:24:24 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Kenneth Lee <liguozhu@hisilicon.com>
CC:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 3/7] vfio: add spimdev support
Thread-Topic: [RFC PATCH 3/7] vfio: add spimdev support
Thread-Index: AQHUKYHWBPQR7BYVIEOBxWGqW0GRJaSry7Bw//+CP4CAAI85UA==
Date:   Thu, 2 Aug 2018 04:24:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19129102C@SHSMSX101.ccr.corp.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-4-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290F7B@SHSMSX101.ccr.corp.intel.com>
 <20180802034727.GK160746@Turing-Arch-b>
In-Reply-To: <20180802034727.GK160746@Turing-Arch-b>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmRiM2E1NzYtMDFhZi00YzE2LWFkZjEtNDRjNzJlZmQ2YmY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2o2SDliT3FWRTJNT1JaeEZYazdsOFAxRzRjc0pkOGxneVlqMGhJZ3dRS0lnV2dVdHNkZVJsT0h4cnRxVGRINSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBLZW5uZXRoIExlZSBbbWFpbHRvOmxpZ3Vvemh1QGhpc2lsaWNvbi5jb21dDQo+IFNl
bnQ6IFRodXJzZGF5LCBBdWd1c3QgMiwgMjAxOCAxMTo0NyBBTQ0KPiANCj4gPg0KPiA+ID4gRnJv
bTogS2VubmV0aCBMZWUNCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDEsIDIwMTggNjoy
MiBQTQ0KPiA+ID4NCj4gPiA+IEZyb206IEtlbm5ldGggTGVlIDxsaWd1b3podUBoaXNpbGljb24u
Y29tPg0KPiA+ID4NCj4gPiA+IFNQSU1ERVYgaXMgIlNoYXJlIFBhcmVudCBJT01NVSBNZGV2Ii4g
SXQgaXMgYSB2ZmlvLW1kZXYuIEJ1dCBkaWZmZXINCj4gZnJvbQ0KPiA+ID4gdGhlIGdlbmVyYWwg
dmZpby1tZGV2Og0KPiA+ID4NCj4gPiA+IDEuIEl0IHNoYXJlcyBpdHMgcGFyZW50J3MgSU9NTVUu
DQo+ID4gPiAyLiBUaGVyZSBpcyBubyBoYXJkd2FyZSByZXNvdXJjZSBhdHRhY2hlZCB0byB0aGUg
bWRldiBpcyBjcmVhdGVkLiBUaGUNCj4gPiA+IGhhcmR3YXJlIHJlc291cmNlIChBIGBxdWV1ZScp
IGlzIGFsbG9jYXRlZCBvbmx5IHdoZW4gdGhlIG1kZXYgaXMNCj4gPiA+IG9wZW5lZC4NCj4gPg0K
PiA+IEFsZXggaGFzIGNvbmNlcm4gb24gZG9pbmcgc28sIGFzIHBvaW50ZWQgb3V0IGluOg0KPiA+
DQo+ID4gCWh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2t2bS9tc2cxNzI2NTIuaHRtbA0K
PiA+DQo+ID4gcmVzb3VyY2UgYWxsb2NhdGlvbiBzaG91bGQgYmUgcmVzZXJ2ZWQgYXQgY3JlYXRp
b24gdGltZS4NCj4gDQo+IFllcy4gVGhhdCBpcyB3aHkgSSBrZWVwIHRlbGxpbmcgdGhhdCBTUElN
REVWIGlzIG5vdCBmb3IgIlZNIiwgaXQgaXMgZm9yICJtYW55DQo+IHByb2Nlc3NlcyIsIGl0IGlz
IGp1c3QgYW4gYWNjZXNzIHBvaW50IHRvIHRoZSBwcm9jZXNzLiBOb3QgYSBkZXZpY2UgdG8gVk0u
IEkNCj4gaG9wZQ0KPiBBbGV4IGNhbiBhY2NlcHQgaXQ6KQ0KPiANCg0KVkZJTyBpcyBqdXN0IGFi
b3V0IGFzc2lnbmluZyBkZXZpY2UgcmVzb3VyY2UgdG8gdXNlciBzcGFjZS4gSXQgZG9lc24ndCBj
YXJlDQp3aGV0aGVyIGl0J3MgbmF0aXZlIHByb2Nlc3NlcyBvciBWTSB1c2luZyB0aGUgZGV2aWNl
IHNvIGZhci4gQWxvbmcgdGhlIGRpcmVjdGlvbg0Kd2hpY2ggeW91IGRlc2NyaWJlZCwgbG9va3Mg
VkZJTyBuZWVkcyB0byBzdXBwb3J0IHRoZSBjb25maWd1cmF0aW9uIHRoYXQNCnNvbWUgbWRldnMg
YXJlIHVzZWQgZm9yIG5hdGl2ZSBwcm9jZXNzIG9ubHksIHdoaWxlIG90aGVycyBjYW4gYmUgdXNl
ZA0KZm9yIGJvdGggbmF0aXZlIGFuZCBWTS4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgdGhlcmUgaXMg
YSBjbGVhbiB3YXkgdG8NCmVuZm9yY2UgaXQuLi4NCg0KTGV0J3MgaGVhciBmcm9tIEFsZXgncyB0
aG91Z2h0Lg0KDQpUaGFua3MNCktldmluDQo=
