Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeBGHYB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 02:24:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:52543 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbeBGHYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 02:24:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,471,1511856000";
   d="scan'208";a="28792964"
Message-ID: <5A7AAA2E.5090809@intel.com>
Date: Wed, 07 Feb 2018 15:26:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, huangzhichao@huawei.com
Subject: Re: [PATCH v26 2/2 RESEND] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
References: <1517972467-14352-1-git-send-email-wei.w.wang@intel.com> <20180207062846-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180207062846-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 12:34 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 07, 2018 at 11:01:06AM +0800, Wei Wang wrote:
>> Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature indicates the
>> support of reporting hints of guest free pages to host via virtio-balloon.
>>
>> Host requests the guest to report free page hints by sending a new cmd
>> id to the guest via the free_page_report_cmd_id configuration register.
>>
>> When the guest starts to report, the first element added to the free page
>> vq is the cmd id given by host. When the guest finishes the reporting
>> of all the free pages, VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID is added
>> to the vq to tell host that the reporting is done. Host polls the free
>> page vq after sending the starting cmd id, so the guest doesn't need to
>> kick after filling an element to the vq.
>>
>> Host may also requests the guest to stop the reporting in advance by
>> sending the stop cmd id to the guest via the configuration register.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> ---
>>   drivers/virtio/virtio_balloon.c     | 255 +++++++++++++++++++++++++++++++-----
>>   include/uapi/linux/virtio_balloon.h |   7 +
>>   mm/page_poison.c                    |   6 +
>>   3 files changed, 232 insertions(+), 36 deletions(-)
>>
>> Resend Change:
>> 	- Expose page_poisoning_enabled to kernel modules
> RESEND tag is for reposting unchanged patches.
> you want to post a v27, and you want the mm patch
> as a separate one, so you can get an ack on it from
> someone on linux-mm.
>
> In fact, I would probably add reporting the poison value as
> a separate feature/couple of patches.
>

OK. I have made them separate patches in v27. Thanks a lot for reviewing 
so many versions, I learned a lot from the comments and discussion.

Best,
Wei
