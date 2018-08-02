Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4050C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811AC208B0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811AC208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHBGcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:32:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:10557 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeHBGcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:32:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 21:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="59789913"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2018 21:41:35 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 21:41:35 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 21:41:35 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.173]) with mapi id 14.03.0319.002;
 Thu, 2 Aug 2018 12:41:33 +0800
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
Subject: RE: [RFC PATCH 1/7] vfio/spimdev: Add documents for WarpDrive
 framework
Thread-Topic: [RFC PATCH 1/7] vfio/spimdev: Add documents for WarpDrive
 framework
Thread-Index: AQHUKYHXaS8CB/iapUSbwJgmaNts7qSrx2yw//+QVICAAIsL0A==
Date:   Thu, 2 Aug 2018 04:41:32 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191291097@SHSMSX101.ccr.corp.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-2-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290F04@SHSMSX101.ccr.corp.intel.com>
 <20180802042235.GN160746@Turing-Arch-b>
In-Reply-To: <20180802042235.GN160746@Turing-Arch-b>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjg4ZDc2OTctYjUyMy00YzRiLThlNjItM2M2YjcwNTVkZGY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRlljNEUrcTBDSitvMDRhNmt5R3ZEc0dzYkhZbUw0NFJkREloZjhNakszTmxuWlUyZ0dDclwvdGNQWVwvRUdYWjhBIn0=
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

PiBGcm9tOiBLZW5uZXRoIExlZQ0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIsIDIwMTggMTI6
MjMgUE0NCj4gDQo+IE9uIFRodSwgQXVnIDAyLCAyMDE4IGF0IDAzOjE0OjM4QU0gKzAwMDAsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBLZW5uZXRoIExlZQ0KPiA+ID4gU2Vu
dDogV2VkbmVzZGF5LCBBdWd1c3QgMSwgMjAxOCA2OjIyIFBNDQo+ID4gPg0KPiA+ID4gRnJvbTog
S2VubmV0aCBMZWUgPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+DQo+ID4gPg0KPiA+ID4gV2FycERy
aXZlIGlzIGEgY29tbW9uIHVzZXIgc3BhY2UgYWNjZWxlcmF0b3IgZnJhbWV3b3JrLiAgSXRzIG1h
aW4NCj4gPiA+IGNvbXBvbmVudA0KPiA+ID4gaW4gS2VybmVsIGlzIGNhbGxlZCBzcGltZGV2LCBT
aGFyZSBQYXJlbnQgSU9NTVUgTWVkaWF0ZWQgRGV2aWNlLiBJdA0KPiA+DQo+ID4gTm90IHN1cmUg
d2hldGhlciAic2hhcmUgcGFyZW50IElPTU1VIiBpcyBhIGdvb2QgdGVybSBoZXJlLiBiZXR0ZXIN
Cj4gPiBzdGljayB0byB3aGF0IGNhcGFiaXR5IHlvdSBicmluZyB0byB1c2VyIHNwYWNlLCBpbnN0
ZWFkIG9mIGRlc2NyaWJpbmcNCj4gPiBpbnRlcm5hbCB0cmljay4uLg0KPiBBZ3JlZS4gVGhlICJT
UEkiIGlzIGFsc28gc3Ryb25nbHkgaGludCB0byAiU2hhcmUgUGVyaXBoZXJhbCBJbnRlcnJ1cHQi
IG9yDQo+ICJTZXJpYWwNCj4gUGVyaXBoZXJhbCBJbnRlcmZhY2UiLiBQZXJzb25hbGx5IEkgaGF0
ZSB0aGlzIG5hbWUuIEJ1dCBJIGNhbm5vdCBmaW5kIGEgYmV0dGVyDQo+IG9uZS4gSW4gdGhlIHVz
ZXIgc3BhY2UsIHdlIGNhbiB1c2UgYSBpbXBhc3NpYmxlIG5hbWUgKFdhcnBEcml2ZSkuIEJ1dA0K
PiBrZXJuZWwNCj4gcmVxdWlyZSBhIG5hbWUgcG9pbnQgdG8gaXRzIGZlYXR1cmUuLi4gbWF5YmUg
SSBzaG91bGQgdXNlICJQcm9jZXNzLVNoYXJlZA0KPiBNZGV2Ig0KPiBpbiBuZXh0IHZlcnNpb24/
DQoNCm9yIG1heWJlIG5vIG5ldyBuYW1lLiBKdXN0IHN0aWNrIHRvIG1kZXYgYnV0IGludHJvZHVj
aW5nIHNvbWUNCm5ldyBhdHRyaWJ1dGUvY2FwYWJpbGl0eSB0byBpbmRpY2F0ZSBzdWNoIHB1cnBv
c2UuDQoNClRoYW5rcw0KS2V2aW4NCg==
