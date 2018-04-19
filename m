Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeDSK43 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:56:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39428 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeDSK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:56:27 -0400
X-Google-Smtp-Source: AIpwx4/FQ/hvtM+dUFUYK7Anr2JfgBMUHxz2jZYEuyyh94cCggqLhNdDgEfRnbvs05hepjeUV3c8N+UjP1dFILN8ibs=
MIME-Version: 1.0
In-Reply-To: <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
References: <20180328155340.2253343-1-arnd@arndb.de> <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 19 Apr 2018 12:56:26 +0200
Message-ID: <CADYN=9LTmdLzeszPDeLZ1==9g1ciS1ubunC6jdjLJUiv6J6N3Q@mail.gmail.com>
Subject: Re: [PATCH] amdkfd: always select MMU_NOTIFIER
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3JAuYxw024578

On 28 March 2018 at 18:04, Christian König <christian.koenig@amd.com> wrote:
> Am 28.03.2018 um 17:53 schrieb Arnd Bergmann:
>>
>> Building amdkfd without MMU notifiers is broken:
>>
>> In file included from drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c:28:
>> drivers/gpu/drm/amd/amdkfd/kfd_priv.h:584:22: error: field 'mmu_notifier'
>> has incomplete type
>>
>> This adds the missing 'select MMU_NOTIFIER' line to make it build
>> cleanly all the time.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>
> Acked-by: Christian König <christian.koenig@amd.com>, but I would wait on
> what Felix says to that.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Randy sent the same patch [1] and its still required.

Cheers,
Anders
[1] https://patchwork.kernel.org/patch/10340885/

>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig
>> b/drivers/gpu/drm/amd/amdkfd/Kconfig
>> index ed2f06c9f346..5a26acb90e19 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
>> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
>> @@ -4,6 +4,7 @@
>>     config HSA_AMD
>>         tristate "HSA kernel driver for AMD GPU devices"
>> +       select MMU_NOTIFIER
>>         depends on DRM_AMDGPU && X86_64
>>         imply AMD_IOMMU_V2
>>         help
>
>
