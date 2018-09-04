Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68202C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD122086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD122086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeIDORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:17:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39752 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbeIDORs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:17:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC68D7A9;
        Tue,  4 Sep 2018 02:53:26 -0700 (PDT)
Received: from [10.4.13.76] (ostrya.emea.arm.com [10.4.13.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378873F5BC;
        Tue,  4 Sep 2018 02:53:24 -0700 (PDT)
Subject: Re: [RFC 01/13] iommu: Introduce bind_guest_stage API
To:     Auger Eric <eric.auger@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Cc:     Marc Zyngier <Marc.Zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        Christoffer Dall <Christoffer.Dall@arm.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
 <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
 <b7909f1b-57ce-f4db-d916-140a63283232@arm.com>
 <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912EFB76@SHSMSX101.ccr.corp.intel.com>
 <220e4c2a-d31c-d8fb-2d77-d902d2f13bb2@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912EFCD8@SHSMSX101.ccr.corp.intel.com>
 <8da25040-42fe-5ce8-2647-ee6b8d795bc9@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c05ac969-2921-3166-e715-af3595291666@arm.com>
Date:   Tue, 4 Sep 2018 10:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <8da25040-42fe-5ce8-2647-ee6b8d795bc9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 09:41, Auger Eric wrote:
> I think the confusion comes from the different terminology used in VTD
> and ARM SMMU spec.
> 
> Your PASID table ~ ARM SMMU Context Descriptor (CD) table
> Your Root Entry/Context Entry ~ ARM SMMU Stream Table Entry (STE)

In past discussions we used "PASID table (entry)" and "device context"
respectively. For clarity we should probably stick to those names unless
we discuss arch-specific patches

Thanks,
Jean
