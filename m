Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23BF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392835AbfAPMt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390338AbfAPMt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:49:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18F1558E59;
        Wed, 16 Jan 2019 12:49:56 +0000 (UTC)
Received: from [10.36.116.96] (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F184A1019633;
        Wed, 16 Jan 2019 12:49:49 +0000 (UTC)
Subject: Re: [RFC v3 17/21] iommu/smmuv3: Report non recoverable faults
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
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
 <c0328bbe-e02c-c337-ec52-c899dc0025d3@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <93599256-947f-d267-6b72-0759e17b4df1@redhat.com>
Date:   Wed, 16 Jan 2019 13:49:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c0328bbe-e02c-c337-ec52-c899dc0025d3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Jan 2019 12:49:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 1/16/19 1:25 PM, Jean-Philippe Brucker wrote:
> On 15/01/2019 21:06, Auger Eric wrote:
>>>> +		iommu_report_device_fault(master->dev, &event);
>>>
>>> We should return here if the fault is successfully injected
>>
>> Even if the fault gets injected in the guest can't it be still useful to
>> get the message below on host side?
> 
> I don't think we should let the guest flood the host log by issuing
> invalid DMA (or are there other cases where the guest can freely print
> stuff in the host?) We do print all errors at the moment, but we should
> tighten this once there is an upstream solution to let the guest control
> DMA mappings.
OK thank you for the clarification. Yes it makes sense to skip those
traces then.

Thanks

Eric
> 
> Thanks,
> Jean
> 
