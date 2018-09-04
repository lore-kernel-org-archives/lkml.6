Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF88CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D2B20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D2B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIDNIA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:08:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:6860 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbeIDNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:08:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 01:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="77801856"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2018 01:43:52 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 01:43:52 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 01:43:51 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 16:43:42 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>
Subject: RE: [RFC 01/13] iommu: Introduce bind_guest_stage API
Thread-Topic: [RFC 01/13] iommu: Introduce bind_guest_stage API
Thread-Index: AQHUOttfqy1SkTByKESItK+VEUbEjaTM7zGAgAxtLACAAAuEgIAGZ4Rg//+CZACAAIvdQP//fKsAgACGfiA=
Date:   Tue, 4 Sep 2018 08:43:42 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912EFDAB@SHSMSX101.ccr.corp.intel.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
        <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
        <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
        <b7909f1b-57ce-f4db-d916-140a63283232@arm.com>
        <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1912EFB76@SHSMSX101.ccr.corp.intel.com>
        <220e4c2a-d31c-d8fb-2d77-d902d2f13bb2@redhat.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1912EFCD8@SHSMSX101.ccr.corp.intel.com>
 <8da25040-42fe-5ce8-2647-ee6b8d795bc9@redhat.com>
In-Reply-To: <8da25040-42fe-5ce8-2647-ee6b8d795bc9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTM5NmE4ZWYtYjg5MS00ODJiLTljM2QtOGIwOTI5ODFhNTA4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjdrbnlHVSs2eGlqdGdSbXEwV1o1UHcyMTBIUUN3UTJPcW5PKzlGRzNBRExuRDVrSWlXTDZ4ODF4QnpLOVNxaSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Auger Eric
> Sent: Tuesday, September 4, 2018 4:41 PM
> 
> Hi Kevin,
> 
> On 09/04/2018 10:34 AM, Tian, Kevin wrote:
> >> From: Auger Eric
> >> Sent: Tuesday, September 4, 2018 4:11 PM
> >>
> >> Hi Kevin,
> >> On 09/04/2018 09:57 AM, Tian, Kevin wrote:
> >>>> From: Auger Eric
> >>>> Sent: Friday, August 31, 2018 9:52 PM
> >>>>
> >>>> Hi Jean-Philippe,
> >>>>
> >>>> On 08/31/2018 03:11 PM, Jean-Philippe Brucker wrote:
> >>>>> Hi Eric,
> >>>>>
> >>>>> On 23/08/18 16:25, Auger Eric wrote:
> >>>>>>> +int iommu_bind_guest_stage(struct iommu_domain *domain,
> >> struct
> >>>> device *dev,
> >>>>>>> +			   struct iommu_guest_stage_config *cfg)
> >>>>>
> >>>>> About the name change from iommu_bind_pasid_table: is the intent
> to
> >>>>> reuse this API for SMMUv2, which supports nested but not PASID?
> >> Seems
> >>>>> like a good idea but "iommu_bind_table" may be better since "stage"
> is
> >>>>> only used by Arm.
> >>>>
> >>>> At the moment I don't target SMUv2 but just SMMUv3. My focus was
> on
> >>>> nested stage enablement without enabling the multi-CD feature
> (PASID),
> >>>> whish is not supported by the QEMU vSMMUv3. Afterwards I realized
> >> that
> >>>> basically we are pointing to a CD or PASID table and that's about the
> >>>> same. I don't have a strong opinion on the name,
> >> iommu_bind_guest_table
> >>>> or iommu_bind_pasid_table would be fine with me. Indeed "stage" is
> >> ARM
> >>>> vocable (level for Intel?)
> >>>
> >>> Intel uses first level/second level.
> >>>
> >>> iommu_bind_table is a bit confusing. what should people take table as?
> >>> there is PASID table. there is also page table linked in each stage/level.
> >> and
> >>> maybe other tables in vendor-specific definition.
> >>>
> >>> to me iommu_bind_pasid_table is still clearer. anyway in other places
> >>> we've used pasid explicitly in vfio/iommu APIs, then it should be
> general
> >>> enough to represent various implementations.
> >>
> >> Fine for me.
> >>
> >> However I I would suggest to rename the original iommu_sva_invalidate
> >> into something that is SVA unrelated. iommu_tlb_invalidate is not OK as
> >> this API also is used to invalidate context caches - which are not
> >> iotlbs -. What about iommu_cache_invalidate?
> >>
> >> At least we must clarify that this API can be used for something else
> >> than SVA enablement.
> >>
> >
> > Agree. using SVA is limiting.
> >
> > I also agree that iommu_cache_invalidate is better, though I don't think
> > you want to pass guest context cache invalidation to host. that
> information
> > is fully under host control. :-)
> 
> I think the confusion comes from the different terminology used in VTD
> and ARM SMMU spec.
> 
> Your PASID table ~ ARM SMMU Context Descriptor (CD) table
> Your Root Entry/Context Entry ~ ARM SMMU Stream Table Entry (STE)
> 
> So I meant guesr invalidates its Context Descriptor cache. He "owns"
> those. Host owns the STE.
> 

yes, then it makes sense.

Thanks
Kevin
