Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeDMXnc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 19:43:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeDMXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 19:43:31 -0400
Subject: Re: [PATCH] virtio_balloon: add array of stat names
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <1523627031-370966-1-git-send-email-mst@redhat.com>
 <8ac55da5-3c2b-a546-7597-ec6c82ff9590@oracle.com>
 <20180414010537-mutt-send-email-mst@kernel.org>
From: Jonathan Helman <jonathan.helman@oracle.com>
Organization: Oracle Corporation
Message-ID: <c166130b-c768-9c33-82b8-10cf373d0785@oracle.com>
Date: Fri, 13 Apr 2018 16:43:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180414010537-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8862 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804130219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/13/2018 03:07 PM, Michael S. Tsirkin wrote:
> On Fri, Apr 13, 2018 at 11:53:31AM -0700, Jonathan Helman wrote:
>>
>>
>> On 04/13/2018 06:44 AM, Michael S. Tsirkin wrote:
>>> Jason Wang points out that it's vary hard for users to build an array of
>>
>> s/vary/very
>>
>>> stat names. The naive thing is to use VIRTIO_BALLOON_S_NR but that
>>> breaks if we add more stats.
>>>
>>> Let's add an array of reasonably readable names.
>>
>> Thanks for doing this, this is goodness. Clients of this interface will now
>> only require a modification to their internal copy of the header file (if
>> they have one), rather than updating their string array as well.
>>
>>>
>>> Fixes: 6c64fe7f2 ("virtio_balloon: export hugetlb page allocation counts")
>>
>> I think this is a tad bit confusing since the only way you'd know why this
>> patch "fixes" 6c64fe7f2 is by reading the LKML archives and finding Jason's
>> comment.
> 
> So
> 
> ... add more stats as recently by commit 6c64fe7f2 ("virtio_balloon: export hugetlb page allocation counts")
> 
> 

Sure. Thanks.

Jon

> 
> 
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: Jonathan Helman <jonathan.helman@oracle.com>, > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Reviewed-by: Jonathan Helman <jonathan.helman@oracle.com>
>>
>>> ---
>>>    include/uapi/linux/virtio_balloon.h | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
>>> index 9e02137..1477c17 100644
>>> --- a/include/uapi/linux/virtio_balloon.h
>>> +++ b/include/uapi/linux/virtio_balloon.h
>>> @@ -64,6 +64,21 @@ struct virtio_balloon_config {
>>>    #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
>>>    #define VIRTIO_BALLOON_S_NR       10
>>> +#define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "swap-out", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "major-faults", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "minor-faults", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "free-memory", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "total-memory", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
>>> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \ > +}
>>> +
>>> +#define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
>>> +
>>>    /*
>>>     * Memory statistics structure.
>>>     * Driver fills an array of these structures and passes to device.
>>>
