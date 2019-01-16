Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B400C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0100220657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392563AbfAPMZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:25:57 -0500
Received: from foss.arm.com ([217.140.101.70]:47010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732749AbfAPMZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:25:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6A19A78;
        Wed, 16 Jan 2019 04:25:56 -0800 (PST)
Received: from [10.1.196.128] (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D7423F5AF;
        Wed, 16 Jan 2019 04:25:54 -0800 (PST)
Subject: Re: [RFC v3 17/21] iommu/smmuv3: Report non recoverable faults
To:     Auger Eric <eric.auger@redhat.com>,
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
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
 <20190108102633.17482-18-eric.auger@redhat.com>
 <dae89fd8-6a82-d2f0-a8c7-ddbf12a7b047@arm.com>
 <e634adee-f7ab-b90d-aac6-06400fa9ffb4@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c0328bbe-e02c-c337-ec52-c899dc0025d3@arm.com>
Date:   Wed, 16 Jan 2019 12:25:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e634adee-f7ab-b90d-aac6-06400fa9ffb4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2019 21:06, Auger Eric wrote:
>>> +		iommu_report_device_fault(master->dev, &event);
>>
>> We should return here if the fault is successfully injected
> 
> Even if the fault gets injected in the guest can't it be still useful to
> get the message below on host side?

I don't think we should let the guest flood the host log by issuing
invalid DMA (or are there other cases where the guest can freely print
stuff in the host?) We do print all errors at the moment, but we should
tighten this once there is an upstream solution to let the guest control
DMA mappings.

Thanks,
Jean
