Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756464AbeDXJw3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:52:29 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43709 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755791AbeDXJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:52:26 -0400
X-Google-Smtp-Source: AIpwx4+Tl5e4UEefQuIeZJFK/+HT71V1/iQzttbx22O7x7zgiA23C4DQfdP/AmsqKRimpXoeX6oj4qs+DmOtV3KuZ80=
MIME-Version: 1.0
In-Reply-To: <CADYN=9KhMhgCzmwg1P5FHEt0EaTH-EoELeF7mCCc-KtWocEGOQ@mail.gmail.com>
References: <20180414002933.6h3S5%akpm@linux-foundation.org>
 <cf7fe470-1b8f-a4a2-d3a1-3360ec1cc578@infradead.org> <CADYN=9KhMhgCzmwg1P5FHEt0EaTH-EoELeF7mCCc-KtWocEGOQ@mail.gmail.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 24 Apr 2018 12:51:55 +0300
Message-ID: <CAFCwf10nfNixtZrWkP7kGBfGyctrqZP2kwaFp1-KUDFtTgu-4g@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/amd/amdkfd: fix build, select MMU_NOTIFIER
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 1:46 PM, Anders Roxell <anders.roxell@linaro.org> wrote:
> On 14 April 2018 at 04:49, Randy Dunlap <rdunlap@infradead.org> wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> When CONFIG_MMU_NOTIFIER is not enabled, struct mmu_notifier has an
>> incomplete type definition, which causes build errors.
>>
>> ../drivers/gpu/drm/amd/amdkfd/kfd_priv.h:607:22: error: field 'mmu_notifier' has incomplete type
>> ../include/linux/kernel.h:979:32: error: dereferencing pointer to incomplete type
>> ../include/linux/kernel.h:980:18: error: dereferencing pointer to incomplete type
>> ../drivers/gpu/drm/amd/amdkfd/kfd_process.c:434:2: error: implicit declaration of function 'mmu_notifier_unregister_no_release' [-Werror=implicit-function-declaration]
>> ../drivers/gpu/drm/amd/amdkfd/kfd_process.c:435:2: error: implicit declaration of function 'mmu_notifier_call_srcu' [-Werror=implicit-function-declaration]
>> ../drivers/gpu/drm/amd/amdkfd/kfd_process.c:438:21: error: variable 'kfd_process_mmu_notifier_ops' has initializer but incomplete type
>> ../drivers/gpu/drm/amd/amdkfd/kfd_process.c:439:2: error: unknown field 'release' specified in initializer
>> ../drivers/gpu/drm/amd/amdkfd/kfd_process.c:439:2: warning: excess elements in struct initializer [enabled by default]
>> ../drivers/gpu/drm/amd/amdkfd/kfd_process.c:439:2: warning: (near initialization for 'kfd_process_mmu_notifier_ops') [enabled by default]
>> ../drivers/gpu/drm/amd/amdkfd/kfd_process.c:534:2: error: implicit declaration of function 'mmu_notifier_register' [-Werror=implicit-function-declaration]
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Oded Gabbay <oded.gabbay@gmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
>
>> ---
>> From linux-next, not mmotm, but found in mmotm builds.
>>
>>  drivers/gpu/drm/amd/amdkfd/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- mmotm-2018-0413-1728.orig/drivers/gpu/drm/amd/amdkfd/Kconfig
>> +++ mmotm-2018-0413-1728/drivers/gpu/drm/amd/amdkfd/Kconfig
>> @@ -6,5 +6,6 @@ config HSA_AMD
>>         tristate "HSA kernel driver for AMD GPU devices"
>>         depends on DRM_AMDGPU && X86_64
>>         imply AMD_IOMMU_V2
>> +       select MMU_NOTIFIER
>>         help
>>           Enable this if you want to use HSA features on AMD GPU devices.
>>

Thanks, taken to -fixes
Oded
