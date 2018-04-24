Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756745AbeDXJx5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:53:57 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36514 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756286AbeDXJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:53:52 -0400
X-Google-Smtp-Source: AIpwx4+osV80Alw01MUYYlIfmX+OH5EFtG4ubLNNWUPrWMG3/WfKsk8Prfe7BfRokD0EBpzJICMagRQWAcVGF8sFQHg=
MIME-Version: 1.0
In-Reply-To: <57c0cfd4-7be6-2572-0bb8-6e1d3e87ef33@amd.com>
References: <20180328155340.2253343-1-arnd@arndb.de> <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
 <CADYN=9LTmdLzeszPDeLZ1==9g1ciS1ubunC6jdjLJUiv6J6N3Q@mail.gmail.com> <57c0cfd4-7be6-2572-0bb8-6e1d3e87ef33@amd.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 24 Apr 2018 12:53:21 +0300
Message-ID: <CAFCwf10WSwMUXyvK3-W4qFXak94nrvCQbdJSA4A80yGHpTmzBw@mail.gmail.com>
Subject: Re: [PATCH] amdkfd: always select MMU_NOTIFIER
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3O9s3kL023976

Thanks, but I took Randy's patch as it was earlier in my email queue.

Oded

On Thu, Apr 19, 2018 at 8:47 PM, Felix Kuehling <felix.kuehling@amd.com> wrote:
> On 2018-04-19 06:56 AM, Anders Roxell wrote:
>> On 28 March 2018 at 18:04, Christian König <christian.koenig@amd.com> wrote:
>>> Am 28.03.2018 um 17:53 schrieb Arnd Bergmann:
>>>> Building amdkfd without MMU notifiers is broken:
>>>>
>>>> In file included from drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c:28:
>>>> drivers/gpu/drm/amd/amdkfd/kfd_priv.h:584:22: error: field 'mmu_notifier'
>>>> has incomplete type
>>>>
>>>> This adds the missing 'select MMU_NOTIFIER' line to make it build
>>>> cleanly all the time.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Acked-by: Christian König <christian.koenig@amd.com>, but I would wait on
>>> what Felix says to that.
>> Tested-by: Anders Roxell <anders.roxell@linaro.org>
>>
>> Randy sent the same patch [1] and its still required.
>>
>> Cheers,
>> Anders
>> [1] https://patchwork.kernel.org/patch/10340885/
> Yes, looks good. I think this probably broke when we relaxed the
> dependency on iommuv2.
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Regards,
>   Felix
>
>
>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>>> b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>>> index ed2f06c9f346..5a26acb90e19 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>>> @@ -4,6 +4,7 @@
>>>>     config HSA_AMD
>>>>         tristate "HSA kernel driver for AMD GPU devices"
>>>> +       select MMU_NOTIFIER
>>>>         depends on DRM_AMDGPU && X86_64
>>>>         imply AMD_IOMMU_V2
>>>>         help
>>>
>
