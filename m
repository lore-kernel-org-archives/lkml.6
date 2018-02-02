Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeBBMqJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:46:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:35011 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeBBMqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:46:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="24381714"
Message-ID: <5A745E27.7070002@intel.com>
Date: Fri, 02 Feb 2018 20:48:39 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com
Subject: Re: [PATCH v25 0/2] Virtio-balloon: support free page reporting
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com> <20180201211525-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180201211525-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 03:15 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 25, 2018 at 05:14:04PM +0800, Wei Wang wrote:
>> This patch series is separated from the previous "Virtio-balloon
>> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>> implemented by this series enables the virtio-balloon driver to report
>> hints of guest free pages to the host. It can be used to accelerate live
>> migration of VMs. Here is an introduction of this usage:
>>
>> Live migration needs to transfer the VM's memory from the source machine
>> to the destination round by round. For the 1st round, all the VM's memory
>> is transferred. From the 2nd round, only the pieces of memory that were
>> written by the guest (after the 1st round) are transferred. One method
>> that is popularly used by the hypervisor to track which part of memory is
>> written is to write-protect all the guest memory.
>>
>> The second feature enables the optimization of the 1st round memory
>> transfer - the hypervisor can skip the transfer of guest free pages in the
>> 1st round. It is not concerned that the memory pages are used after they
>> are given to the hypervisor as a hint of the free pages, because they will
>> be tracked by the hypervisor and transferred in the next round if they are
>> used and written.
> Could you post performance numbers please?

Yes, it was posted here https://lkml.org/lkml/2018/1/25/698

I just changed the host side to poll the vq so that we don't need kick 
in the driver, it works pretty well. I'll test a little bit more and 
post out a new version with new performance numbers attached in the 
cover letter.

Best,
Wei
