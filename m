Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B2EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C8F2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C8F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeIEFEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:04:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:38175 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeIEFEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:04:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 17:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,331,1531810800"; 
   d="scan'208";a="230244020"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2018 17:36:36 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 17:36:36 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 17:36:35 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 08:36:23 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Auger Eric <eric.auger@redhat.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>
CC:     Marc Zyngier <Marc.Zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        Christoffer Dall <Christoffer.Dall@arm.com>
Subject: RE: [RFC 01/13] iommu: Introduce bind_guest_stage API
Thread-Topic: [RFC 01/13] iommu: Introduce bind_guest_stage API
Thread-Index: AQHUOttfqy1SkTByKESItK+VEUbEjaTM7zGAgAxtLACAAAuEgIAGZ4Rg//+CZACAAIvdQP//fKsAgAAUCYCAAXyN8A==
Date:   Wed, 5 Sep 2018 00:36:23 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912F0BC2@SHSMSX101.ccr.corp.intel.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
 <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
 <b7909f1b-57ce-f4db-d916-140a63283232@arm.com>
 <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912EFB76@SHSMSX101.ccr.corp.intel.com>
 <220e4c2a-d31c-d8fb-2d77-d902d2f13bb2@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912EFCD8@SHSMSX101.ccr.corp.intel.com>
 <8da25040-42fe-5ce8-2647-ee6b8d795bc9@redhat.com>
 <c05ac969-2921-3166-e715-af3595291666@arm.com>
In-Reply-To: <c05ac969-2921-3166-e715-af3595291666@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjE5YzBmNzItNGEwOS00Y2ZmLWFlOGItNzk3ZjQwNGMwZjI2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVWhrUUdhN000Z0tVY1NNcEpza210a09tZmMweloxVGdld3pHY2FxUWFIUFVmOEp3NE40UGtHRlZPR29XbG1NZiJ9
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

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDQsIDIwMTggNTo1MyBQTQ0K
PiANCj4gT24gMDQvMDkvMjAxOCAwOTo0MSwgQXVnZXIgRXJpYyB3cm90ZToNCj4gPiBJIHRoaW5r
IHRoZSBjb25mdXNpb24gY29tZXMgZnJvbSB0aGUgZGlmZmVyZW50IHRlcm1pbm9sb2d5IHVzZWQg
aW4gVlREDQo+ID4gYW5kIEFSTSBTTU1VIHNwZWMuDQo+ID4NCj4gPiBZb3VyIFBBU0lEIHRhYmxl
IH4gQVJNIFNNTVUgQ29udGV4dCBEZXNjcmlwdG9yIChDRCkgdGFibGUNCj4gPiBZb3VyIFJvb3Qg
RW50cnkvQ29udGV4dCBFbnRyeSB+IEFSTSBTTU1VIFN0cmVhbSBUYWJsZSBFbnRyeSAoU1RFKQ0K
PiANCj4gSW4gcGFzdCBkaXNjdXNzaW9ucyB3ZSB1c2VkICJQQVNJRCB0YWJsZSAoZW50cnkpIiBh
bmQgImRldmljZSBjb250ZXh0Ig0KPiByZXNwZWN0aXZlbHkuIEZvciBjbGFyaXR5IHdlIHNob3Vs
ZCBwcm9iYWJseSBzdGljayB0byB0aG9zZSBuYW1lcyB1bmxlc3MNCj4gd2UgZGlzY3VzcyBhcmNo
LXNwZWNpZmljIHBhdGNoZXMNCj4gDQoNCnllcywgdGhhdCBpcyBhIGdvb2QgYWJzdHJhY3Rpb24u
IGxldCdzIHRyeSB0byB1c2UgdGhlbSBpbiByZWxhdGVkIGRpc2N1c3Npb25zDQphbmQgcGF0Y2gg
c2VyaWVzLg0KDQpUaGFua3MNCktldmluDQo=
