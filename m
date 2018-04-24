Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757021AbeDXL5p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:57:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756242AbeDXL5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:57:41 -0400
Subject: Re: [RFC 1/2] iommu/arm-smmu-v3: Remove bypass in
 arm_smmu_reset_device
To: Robin Murphy <robin.murphy@arm.com>, <will.deacon@arm.com>,
        <joro@8bytes.org>
References: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
 <1524483959-54940-2-git-send-email-xieyisheng1@huawei.com>
 <9e2f8646-482a-e721-d1b6-e674de48e276@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <liubo95@huawei.com>, <dingtianhong@huawei.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <85c3b7d4-19c0-ea9c-b698-18e199b1da6d@huawei.com>
Date: Tue, 24 Apr 2018 19:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <9e2f8646-482a-e721-d1b6-e674de48e276@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for your comment!
On 2018/4/24 0:07, Robin Murphy wrote:
> On 23/04/18 12:45, Yisheng Xie wrote:
>> Add a bypass parameter in arm_smmu_device to keep whether smmu device
>> should pypass or not, so parameter bypass in arm_smmu_reset_device can
>> be removed.
> 
> Given that the GBPA configuration implied by the bypass argument here
> is only there to avoid initialising a full stream table when the firmware
> is terminally broken, I wonder if it would make sense to simply skip
> allocating a stream table at all in that case. Then we could just base
> the subsequent SMMUEN/GPBA decision on whether strtab_cfg.strtab is valid or not.
> 
Yes, it may save many memory, and should be care about not access strtab when attach
device or other similar scenario, anyway software can achieve this after move bypass
to struct arm_smmu_device.

Thanks
Yisheng
> Robin.
> 
