Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04EC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768F4218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAYCGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:06:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:52907 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbfAYCGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:06:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 18:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,519,1539673200"; 
   d="scan'208";a="132914672"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2019 18:06:38 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
To:     Joerg Roedel <joro@8bytes.org>
References: <20190124023132.20410-1-baolu.lu@linux.intel.com>
 <20190124132250.k3rnlpaqazmatzaf@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f2aa4ab2-4a3b-9d6c-357b-367fe142f47a@linux.intel.com>
Date:   Fri, 25 Jan 2019 10:02:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124132250.k3rnlpaqazmatzaf@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 1/24/19 9:22 PM, Joerg Roedel wrote:
> On Thu, Jan 24, 2019 at 10:31:32AM +0800, Lu Baolu wrote:
>> Commit 765b6a98c1de3 ("iommu/vt-d: Enumerate the scalable
>> mode capability") enables VT-d scalable mode if hardware
>> advertises the capability. As we will bring up different
>> features and use cases to upstream in different patch
>> series, it will leave some intermediate kernel versions
>> which support partial features. Hence, end user might run
>> into problems when they use such kernels on bare metals
>> or virtualization environments.
> 
> I don't get it, can you be more specific about the problems that users
> might run into?

Sorry, I didn't make it clear in the message.

Around VT-d scalable mode, we plan to enable several features.
For example,

(1)basic scalable mode support;
(2)aux domain;
(3)system level pasid allocation;
....

Since they will be submitted in different patch series for reviewing and
merging, users will face compatible problems. For example, when users
run kernel v5.0, they might fail to assign an ADI (Assignable Device
Interface) to a VM because the aux domain is not included yet. They will
complain "I have a kernel claimed to support scalable mode, but when I
tried to assign an ADI to a VM, ...".

So we decide to leave it off by default, and turn it default on later
when all the features get merged. Users could try scalable mode features
with "intel-iommu=sm_on" in kernel command line.

> And is this patch needed as a fix for v5.0 or is it just
> a precaution because future patches might break something for users?

It will be better if it can be a fix for v5.0.

Best regards,
Lu Baolu
