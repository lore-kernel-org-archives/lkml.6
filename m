Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FA7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564562082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564562082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJYSqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:46:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:47195 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbeJYSqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:46:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 03:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="94902601"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2018 03:14:15 -0700
Message-ID: <5BD1988D.7010606@intel.com>
Date:   Thu, 25 Oct 2018 18:18:53 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dgilbert@redhat.com, torvalds@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com, quintela@redhat.com
Subject: Re: [PATCH v37 0/3] Virtio-balloon: support free page reporting
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com> <20181024205759-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181024205759-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 08:58 AM, Michael S. Tsirkin wrote:
> On Mon, Aug 27, 2018 at 09:32:16AM +0800, Wei Wang wrote:
>> The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT, implemented by this
>> series enables the virtio-balloon driver to report hints of guest free
>> pages to host. It can be used to accelerate virtual machine (VM) live
>> migration. Here is an introduction of this usage:
>>
>> Live migration needs to transfer the VM's memory from the source machine
>> to the destination round by round. For the 1st round, all the VM's memory
>> is transferred. From the 2nd round, only the pieces of memory that were
>> written by the guest (after the 1st round) are transferred. One method
>> that is popularly used by the hypervisor to track which part of memory is
>> written is to have the hypervisor write-protect all the guest memory.
>>
>> This feature enables the optimization by skipping the transfer of guest
>> free pages during VM live migration. It is not concerned that the memory
>> pages are used after they are given to the hypervisor as a hint of the
>> free pages, because they will be tracked by the hypervisor and transferred
>> in the subsequent round if they are used and written.
> OK so it will be in linux-next.  Now can I trouble you for a virtio spec
> patch with the description please?

No problem, I'll start to patch the spec. Thanks!

Best,
Wei
