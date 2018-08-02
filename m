Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7577CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DA4208B0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DA4208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeHBG3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:29:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:10450 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeHBG3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:29:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 21:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="71898448"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2018 21:39:47 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 21:39:39 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Thu, 2 Aug 2018 12:39:38 +0800
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
Subject: RE: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
 spimdev
Thread-Topic: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
 spimdev
Thread-Index: AQHUKYHWQk1Lvdz7XEqv7xkSwudUdqSryvAw//+K6oCAAIwQgA==
Date:   Thu, 2 Aug 2018 04:39:37 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19129107A@SHSMSX101.ccr.corp.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-3-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290F49@SHSMSX101.ccr.corp.intel.com>
 <20180802041547.GM160746@Turing-Arch-b>
In-Reply-To: <20180802041547.GM160746@Turing-Arch-b>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjkyNmExNzYtM2Q1OS00OTc5LTgxNzItYjE0NmIzMTQ2NjZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM2t2Z0t3NGZ1K3ljcDIyT09Icjd0V0JvNzg1ckNxZmdMT2xkQk9nM2drQVV4NXpCTm80eDRsOHlSbXM4QkxoUiJ9
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
MTYgUE0NCj4gDQo+IE9uIFRodSwgQXVnIDAyLCAyMDE4IGF0IDAzOjE3OjAzQU0gKzAwMDAsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogS2VubmV0aCBMZWUNCj4gPiA+IFNlbnQ6IFdl
ZG5lc2RheSwgQXVndXN0IDEsIDIwMTggNjoyMiBQTQ0KPiA+ID4NCj4gPiA+IEZyb206IEtlbm5l
dGggTGVlIDxsaWd1b3podUBoaXNpbGljb24uY29tPg0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0Y2gg
YWRkIHNoYXJpbmcgaW50ZXJmYWNlIGZvciBhIGlvbW11X2dyb3VwLiBUaGUgbmV3IGludGVyZmFj
ZToNCj4gPiA+DQo+ID4gPiAJaW9tbXVfZ3JvdXBfc2hhcmVfZG9tYWluKCkNCj4gPiA+IAlpb21t
dV9ncm91cF91bnNoYXJlX2RvbWFpbigpDQo+ID4gPg0KPiA+ID4gY2FuIGJlIHVzZWQgYnkgc29t
ZSB2aXJ0dWFsIGlvbW11X2dyb3VwIChzdWNoIGFzIGlvbW11X2dyb3VwIGZvcg0KPiA+ID4gc3Bp
bWRldikNCj4gPiA+IHRvIHNoYXJlIHRoZWlyIHBhcmVudCdzIGlvbW11X2dyb3VwLg0KPiA+ID4N
Cj4gPiA+IFdoZW4gdGhlIGRvbWFpbiBvZiB0aGUgZ3JvdXAgaXMgc2hhcmVkLCBpdCBjYW5ub3Qg
YmUgY2hhbmdlZCBiZWZvcmUNCj4gPiA+IHVuc2hhcmVkLiAgSW4gdGhlIGZ1dHVyZSwgbm90aWZp
Y2F0aW9uIGNhbiBiZSBhZGRlZCBpZiB1cGRhdGUgaXMgcmVxdWlyZWQuDQo+ID4NCj4gPiBJcyBp
dCBuZWNlc3Nhcnkgb3IganVzdCBhc2tpbmcgVkZJTyB0byB1c2UgcGFyZW50IGRvbWFpbiBkaXJl
Y3RseT8NCj4gPg0KPiBFdmVuIHdlIGFkZCB0byBWRklPLCB0aGUgaW9tbXUgc3RpbGwgbmVlZCB0
byBiZSBjaGFuZ2VkLiBXZSBjYW4gbW92ZQ0KPiB0aGUgdHlwZTENCj4gcGFydCB0byBWRklPIGlm
IHdlIGhhdmUgYWdyZWVtZW50IGluIFJGQyBzdGFnZS4NCg0KV2UgaGF2ZSBzaW1pbGFyIGNvbnNp
ZGVyYXRpb24gaW4gSU9NTVUgYXdhcmUgbWRldiBzZXJpZXMuIE5vdw0Kd2UgYXJlIGluY2xpbmVk
IHRvIGF2b2lkIGZha2VkIGVudGl0eSB3aXRoaW4gSU9NTVUgbGF5ZXIgLSBsZWF2ZSB0bw0KY2Fs
bGVyIHRvIGZpZ3VyZSBvdXQgcmlnaHQgcGh5c2ljYWwgZW50aXR5IGZvciBhbnkgSU9NTVUgb3Bz
LiBUaGF0IA0KbWlnaHQgYmUgbGV2ZXJhZ2VkIGhlcmUgdG9vIGFmdGVyIHdlIGdldCBhIG5ldyB2
ZXJzaW9uLg0KDQpUaGFua3MNCktldmluDQo=
