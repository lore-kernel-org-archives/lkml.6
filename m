Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424728AbeBOQNA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:13:00 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.119]:15492 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1425587AbeBOQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:12:56 -0500
Subject: Re: [PATCH] drm/amdkfd: Use ARRAY_SIZE macro in
 kfd_build_sysfs_node_entry
To: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20180119003955.GA28885@embeddedor.com>
 <1fea2528-11a5-0210-6350-e916ebfebbdf@amd.com>
 <422e897f-4b65-10f6-4184-36b78b6ea274@embeddedor.com>
 <CAFCwf13TGeBGiS_4KiTWwbY3T23JZkWod6DJE-Mi=RmYXRr54w@mail.gmail.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <ea676cf7-622e-1ba7-18ff-3510410261e8@embeddedor.com>
Date: Thu, 15 Feb 2018 10:10:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFCwf13TGeBGiS_4KiTWwbY3T23JZkWod6DJE-Mi=RmYXRr54w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emM7e-003t8A-E7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:45678
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded,

On 02/15/2018 04:08 AM, Oded Gabbay wrote:
> Hi Gustavo,
> The patch is queued for the merge window of kernel 4.17 (opens in
> about 7 weeks from now).
> 

Awesome.

Thanks for the info.
--
Gustavo

> Oded
> 
> On Wed, Feb 14, 2018 at 11:30 PM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>> Hi all,
>>
>> I was just wondering about the status of this patch.
>>
>> Thanks
>> --
>> Gustavo
>>
>>
>> On 01/19/2018 04:18 PM, Felix Kuehling wrote:
>>>
>>> Looks good. This change is Reviewed-by: Felix Kuehling
>>> <Felix.Kuehling@amd.com>
>>>
>>> Regards,
>>>     Felix
>>>
>>>
>>> On 2018-01-18 07:39 PM, Gustavo A. R. Silva wrote:
>>>>
>>>> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
>>>>
>>>> This issue was detected with the help of Coccinelle.
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> index c6a7609..7783250 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> @@ -677,7 +677,7 @@ static int kfd_build_sysfs_node_entry(struct
>>>> kfd_topology_device *dev,
>>>>          }
>>>>          /* All hardware blocks have the same number of attributes. */
>>>> -       num_attrs = sizeof(perf_attr_iommu)/sizeof(struct kfd_perf_attr);
>>>> +       num_attrs = ARRAY_SIZE(perf_attr_iommu);
>>>>          list_for_each_entry(perf, &dev->perf_props, list) {
>>>>                  perf->attr_group = kzalloc(sizeof(struct kfd_perf_attr)
>>>>                          * num_attrs + sizeof(struct attribute_group),
>>>
>>>
>>
