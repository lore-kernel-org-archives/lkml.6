Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932449AbeDWURb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:17:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932335AbeDWUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:17:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 201576071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        sulrich@codeaurora.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rajat Jain <rajatja@google.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
 <290e9530-dcde-9c10-7ae0-59ac4c509db4@codeaurora.org>
 <20180420140049.GP28657@bhelgaas-glaptop.roam.corp.google.com>
 <20180420090420.03fb1e6c@w520.home>
 <10d9cf68-29ed-d205-a25f-b8dade53cdd8@codeaurora.org>
 <20180423131044.53471670@w520.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f7022685-9c99-7d49-a2f3-07b387d96e8d@codeaurora.org>
Date: Mon, 23 Apr 2018 16:17:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423131044.53471670@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/2018 3:10 PM, Alex Williamson wrote:
>> But, we need to think about what to do about VFIO and other endpoint
>> initiated reset cases. My suggestion was to move this into a single API and
>> remove all other APIs from include/linux/pci.h.
> I'm a little confused about the relation between reset and retrain.
> AIUI we can retrain the link without any sort of endpoint reset and if
> some sort of driver/firmware setup is required on the endpoint to
> achieve the target link speed, then I'd think we only want to retrain.

I'm guessing on why you may want to do a secondary bus reset instead of just
retrain bit in the PCI Express Capabilities register...

The maximum link speed is embedded into the TS1s that are exchanged during
initial link training. 

If device only advertises gen1 during boot, no matter what you do with retrain
bit link may not reach to gen3.

A lot of guess here.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
