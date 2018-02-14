Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163109AbeBNTsG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:48:06 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:41040 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163075AbeBNTsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:48:04 -0500
X-Google-Smtp-Source: AH8x2260HL3rIi3fGtmFlHEXwiXUI4ygWmM5k+Ut36IHfmOg4oatAj7kkQqW0mLpHjqK00lxBhPB13l2iV9KuZ2+qHo=
MIME-Version: 1.0
In-Reply-To: <3746a404-0811-0529-1e6a-faab5aaffe2e@amd.com>
References: <1518619577-19771-1-git-send-email-clabbe@baylibre.com> <3746a404-0811-0529-1e6a-faab5aaffe2e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Feb 2018 14:48:03 -0500
Message-ID: <CADnq5_ONUjBJEwpcEEiwUUC9NefLzc4KbwjYYz=NsoRtGtyCbg@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] gpu: drm: amd: remove unused headers
To: Tom St Denis <tom.stdenis@amd.com>
Cc: Corentin Labbe <clabbe@baylibre.com>,
        Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 2:35 PM, Tom St Denis <tom.stdenis@amd.com> wrote:
> This will break umr since we source the headers from the kernel.  The kernel
> might not use them but the different IP blocks have deltas that umr is aware
> of.
>
> One might argue that we should then publish the headers somewhere else that
> is public but the kernel is our vehicle right now.
>
> Thoughts Alex/Christian?

I also like having them there for debugging so I can use the defines
for accessing registers and bitfields without having to look them up
and add local defines or magic numbers.  The non-register headers can
be removed however since they are mostly leftover from code cleanups.

Alex

>
> Tom
>
>
>
> On 14/02/18 09:46 AM, Corentin Labbe wrote:
>>
>> Hello
>>
>> This patchset remove several headers which are not used by any source
>> file.
>>
>> Regards
>>
>> Change since v1:
>> - splited in multiple patchs
>>
>> Change since v2
>> - Use --irreversible-delete for format-patch
>>
>> Corentin Labbe (13):
>>    drm/amd/include: remove unused asic_reg/oss headers
>>    drm/amd/include: remove unused asic_reg/bif headers
>>    drm/amd/include: remove unused asic_reg/dce headers
>>    drm/amd/include: remove unused asic_reg/gca headers
>>    drm/amd/include: remove unused asic_reg/gmc headers
>>    drm/amd/include: remove unused asic_reg/smu headers
>>    drm/amd/include: remove unused asic_reg/umc headers
>>    drm/amd/include: remove unused asic_reg/uvd headers
>>    drm/amd/include: remove unused asic_reg/vce headers
>>    drm/amd/include: remove unused asic_reg/sdma headers
>>    drm/amd/include: remove unused asic_reg/nbif headers
>>    drm/amd/include: remove unused displayobject.h header
>>    drm/amd/powerplay: remove unused headers
>>
>>   .../drm/amd/include/asic_reg/bif/bif_5_0_enum.h    |  1198 --
>>   .../drm/amd/include/asic_reg/bif/bif_5_1_enum.h    |  1068 -
>>   .../drm/amd/include/asic_reg/dce/dce_11_2_enum.h   |  6813 ------
>>   .../drm/amd/include/asic_reg/dce/dce_8_0_enum.h    |  1117 -
>>   .../gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h   |  2791 ---
>>   .../drm/amd/include/asic_reg/gca/gfx_8_1_enum.h    |  6808 ------
>>   .../drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h | 21368
>> -------------------
>>   .../drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h    |  1198 --
>>   .../drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h    |  1068 -
>>   .../amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h   | 10281 ---------
>>   .../drm/amd/include/asic_reg/oss/oss_2_4_enum.h    |  1340 --
>>   .../drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h  |  1464 --
>>   .../drm/amd/include/asic_reg/oss/oss_3_0_enum.h    |  1497 --
>>   .../amd/include/asic_reg/sdma0/sdma0_4_0_default.h |   286 -
>>   .../amd/include/asic_reg/sdma1/sdma1_4_0_default.h |   282 -
>>   .../gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h   |   148 -
>>   .../drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h |   715 -
>>   .../gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h |  1344 --
>>   .../drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h  |  1191 --
>>   .../amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h   |  5648 -----
>>   .../drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h  |  1205 --
>>   .../drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h  |  1246 --
>>   .../drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h  |  1282 --
>>   .../drm/amd/include/asic_reg/smu/smu_8_0_enum.h    |  1072 -
>>   .../drm/amd/include/asic_reg/umc/umc_6_0_default.h |    31 -
>>   .../drm/amd/include/asic_reg/umc/umc_6_0_offset.h  |    52 -
>>   .../drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h |   795 -
>>   .../drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h    |  1211 --
>>   .../drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h    |  1081 -
>>   .../gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h   |    64 -
>>   .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |    99 -
>>   drivers/gpu/drm/amd/include/displayobject.h        |   249 -
>>   .../gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h    |   412 -
>>   drivers/gpu/drm/amd/powerplay/inc/pp_feature.h     |    67 -
>>   34 files changed, 76491 deletions(-)
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_enum.h
>>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/oss/oss_2_4_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h
>>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/smu/smu_8_0_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h
>>   delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
>>   delete mode 100644
>> drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
>>   delete mode 100644 drivers/gpu/drm/amd/include/displayobject.h
>>   delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
>>   delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h
>>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
