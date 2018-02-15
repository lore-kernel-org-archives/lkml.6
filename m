Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbeBOKJS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:09:18 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43446 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755240AbeBOKJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:09:15 -0500
X-Google-Smtp-Source: AH8x224NL8HjjkIpv4vZOgoh8c2GoTdprjIobUc9vuEYcp5N6nnhSDwcuvu6zS+SOZxk9NpX8LApkGRxRp5tTQkTRGM=
MIME-Version: 1.0
In-Reply-To: <422e897f-4b65-10f6-4184-36b78b6ea274@embeddedor.com>
References: <20180119003955.GA28885@embeddedor.com> <1fea2528-11a5-0210-6350-e916ebfebbdf@amd.com>
 <422e897f-4b65-10f6-4184-36b78b6ea274@embeddedor.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Thu, 15 Feb 2018 12:08:44 +0200
Message-ID: <CAFCwf13TGeBGiS_4KiTWwbY3T23JZkWod6DJE-Mi=RmYXRr54w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use ARRAY_SIZE macro in kfd_build_sysfs_node_entry
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,
The patch is queued for the merge window of kernel 4.17 (opens in
about 7 weeks from now).

Oded

On Wed, Feb 14, 2018 at 11:30 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Hi all,
>
> I was just wondering about the status of this patch.
>
> Thanks
> --
> Gustavo
>
>
> On 01/19/2018 04:18 PM, Felix Kuehling wrote:
>>
>> Looks good. This change is Reviewed-by: Felix Kuehling
>> <Felix.Kuehling@amd.com>
>>
>> Regards,
>>    Felix
>>
>>
>> On 2018-01-18 07:39 PM, Gustavo A. R. Silva wrote:
>>>
>>> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
>>>
>>> This issue was detected with the help of Coccinelle.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index c6a7609..7783250 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -677,7 +677,7 @@ static int kfd_build_sysfs_node_entry(struct
>>> kfd_topology_device *dev,
>>>         }
>>>         /* All hardware blocks have the same number of attributes. */
>>> -       num_attrs = sizeof(perf_attr_iommu)/sizeof(struct kfd_perf_attr);
>>> +       num_attrs = ARRAY_SIZE(perf_attr_iommu);
>>>         list_for_each_entry(perf, &dev->perf_props, list) {
>>>                 perf->attr_group = kzalloc(sizeof(struct kfd_perf_attr)
>>>                         * num_attrs + sizeof(struct attribute_group),
>>
>>
>
