Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBWIvh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:51:37 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:45570 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBWIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:51:35 -0500
X-Google-Smtp-Source: AG47ELtUu87XKTa0ZMEkpL06sVU1QNz0ytP/vji9hTAGOKVUo0K+jGAlXslKGE/GxN4hiLpegwz7JanAyGs0ppeKppo=
MIME-Version: 1.0
In-Reply-To: <CA+M3ks7VmVsHFZ4qo6qPyX5tCoqYAVHhKB+EXyteEuL_EFjn4w@mail.gmail.com>
References: <20180208122146.28399-1-benjamin.gaignard@linaro.org>
 <CAK8P3a0-qZM8aaXSNjuQctZVirN6wEsOsU4pyDG7QhqcG2LBjA@mail.gmail.com> <CA+M3ks7VmVsHFZ4qo6qPyX5tCoqYAVHhKB+EXyteEuL_EFjn4w@mail.gmail.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 23 Feb 2018 09:51:34 +0100
Message-ID: <CA+M3ks484t7Rx12zCGws2kZTeaoAWtqZTt=j-k3Oa5w60rTfVA@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom_scm: use correct parameter type for dma_alloc_coherent
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-08 15:26 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> 2018-02-08 15:09 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
>> On Thu, Feb 8, 2018 at 1:21 PM, Benjamin Gaignard
>> <benjamin.gaignard@linaro.org> wrote:
>>> dma_alloc_coherent expects it third argument type to be dma_addr_t and
>>> not phys_addr_t.
>>> When phys_addr_t is defined as u32 and dma_addr_t as u64 that generate
>>> a compilation issue.
>>> Change the variable name because dma_alloc_coherent returns a bus
>>> address not a physical address.
>>>
>>
>>> @@ -480,14 +480,14 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>>
>>>         /* Fill details of mem buff to map */
>>>         mem_to_map = ptr + ALIGN(src_sz, SZ_64);
>>> -       mem_to_map_phys = ptr_phys + ALIGN(src_sz, SZ_64);
>>> +       mem_to_map_phys = handle + ALIGN(src_sz, SZ_64);
>>>         mem_to_map[0].mem_addr = cpu_to_le64(mem_addr);
>>>         mem_to_map[0].mem_size = cpu_to_le64(mem_sz);
>>>
>>>         next_vm = 0;
>>>         /* Fill details of next vmid detail */
>>>         destvm = ptr + ALIGN(mem_to_map_sz, SZ_64) + ALIGN(src_sz, SZ_64);
>>> -       dest_phys = ptr_phys + ALIGN(mem_to_map_sz, SZ_64) + ALIGN(src_sz, SZ_64);
>>> +       dest_phys = handle + ALIGN(mem_to_map_sz, SZ_64) + ALIGN(src_sz, SZ_64);
>>
>> This still assigns from a 'dma' address to a 'phys' address without a
>> long comment
>> explaining why you do it. There is also another instance of the naming confusion
>> in qcom_scm_pas_init_image and __qcom_scm_pas_init_image, so maybe they
>> should be addressed at the same time.
>
> This patch just fix a compilation issue, nothing else.

Gentle ping on this patch since the problem still exist on 4.16-rc2

>
>>
>>        Arnd
