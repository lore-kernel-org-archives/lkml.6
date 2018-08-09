Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE666C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CE021A13
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CE021A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbeHIKzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:55:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:32423 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeHIKzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:55:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 01:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,214,1531810800"; 
   d="scan'208";a="79848101"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2018 01:31:33 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 9 Aug 2018 01:31:33 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Thu, 9 Aug 2018 16:31:31 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Kenneth Lee <liguozhu@hisilicon.com>,
        Jerome Glisse <jglisse@redhat.com>
CC:     Kenneth Lee <nek.in.cn@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Philippe Ombredanne" <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
Subject: RE: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Topic: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Index: AQHUKYHSUTvc9I1u4EGviW0yiW9YHKSqmCAAgAElIaD//5XZgIAArFOAgADg0ICAALZGAIAD9xYAgADOyACAAjMwAIAA7XWAgAEY3wCAAIxngA==
Date:   Thu, 9 Aug 2018 08:31:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912B39B3@SHSMSX101.ccr.corp.intel.com>
References: <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802040557.GL160746@Turing-Arch-b> <20180802142243.GA3481@redhat.com>
 <20180803034721.GC91035@Turing-Arch-b> <20180803143944.GA4079@redhat.com>
 <20180806031252.GG91035@Turing-Arch-b> <20180806153257.GB6002@redhat.com>
 <11bace0e-dc14-5d2c-f65c-25b852f4e9ca@gmail.com>
 <20180808151835.GA3429@redhat.com> <20180809080352.GI91035@Turing-Arch-b>
In-Reply-To: <20180809080352.GI91035@Turing-Arch-b>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODBjMWY4N2EtNDljNC00MGFhLTk5ZmYtOTY0OWU3ZDVkZDRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSTNVSm9Mdmx6QnJVY2lBMW4xK3RtRjlNOU04VnV0VW0xaTdUMWVpN3hkdVB3eG9nUWxZU1lQRlVPWWM3dzllSCJ9
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
bnQ6IFRodXJzZGF5LCBBdWd1c3QgOSwgMjAxOCA0OjA0IFBNDQo+IA0KPiBCdXQgd2UgaGF2ZSBh
bm90aGVyIHJlcXVpcmVtZW50IHdoaWNoIGlzIHRvIGNvbWJpbmUgc29tZSBkZXZpY2UNCj4gdG9n
ZXRoZXIgdG8NCj4gc2hhcmUgdGhlIHNhbWUgYWRkcmVzcyBzcGFjZS4gVGhpcyBpcyBhIGxpdHRs
ZSBsaWtlIHRoZXNlIGtpbmRzIG9mIHNvbHV0aW9uOg0KPiANCj4gaHR0cDovL3RjZS50ZWNobmlv
bi5hYy5pbC93cC1jb250ZW50L3VwbG9hZHMvc2l0ZXMvOC8yMDE1LzA2L1NDLTcuMi1NLi0NCj4g
U2lsYmVyc3RlaW4ucGRmDQo+IA0KPiBXaXRoIHRoYXQsIHRoZSBhcHBsaWNhdGlvbiBjYW4gZGly
ZWN0bHkgcGFzcyB0aGUgTmlDIHBhY2tldCBwb2ludGVyIHRvIHRoZQ0KPiBkZWNyeXB0aW9uIGFj
Y2VsZXJhdG9yLCBhbmQgZ2V0IHRoZSBiYXJlIGRhdGEgaW4gcGxhY2UuIFRoaXMgaXMgdGhlIGZl
YXR1cmUNCj4gdGhhdA0KPiB0aGUgVkZJTyBjb250YWluZXIgY2FuIHByb3ZpZGUuDQoNCmFib3Zl
IGlzIG5vdCBhIGdvb2QgYXJndW1lbnQsIGF0IGxlYXN0IGluIHRoZSBjb250ZXh0IG9mIHlvdXIg
ZGlzY3Vzc2lvbi4NCklmIGVhY2ggZGV2aWNlIGhhcyB0aGVpciBvd24gaW50ZXJmYWNlIChzaW1p
bGFyIHRvIEdQVSkgZm9yIHByb2Nlc3MgdG8gYmluZCANCndpdGgsIHRoZW4gaGF2aW5nIHRoZSBw
cm9jZXNzIGJpbmRpbmcgdG8gbXVsdGlwbGUgZGV2aWNlcyBvbmUtYnktb25lIHRoZW4NCnlvdSBz
dGlsbCBnZXQgc2FtZSBhZGRyZXNzIHNwYWNlIHNoYXJlZCBjcm9zcyB0aGVtLi4uDQoNClRoYW5r
cw0KS2V2aW4NCg==
