Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeDXJQw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:16:52 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33814 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeDXJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:16:50 -0400
X-Google-Smtp-Source: AIpwx4+3+LKSou64FBNVpks/UP1ajJfujM422VCowd1EDUq6/85uAF7+U+YFGntaTbnnqd9O0uRHWoHQzpocMH8q3mw=
MIME-Version: 1.0
In-Reply-To: <4aac97a5-4efa-8667-3a87-d6f4182dd1e7@amd.com>
References: <1522376717-136486-1-git-send-email-weiyongjun1@huawei.com> <4aac97a5-4efa-8667-3a87-d6f4182dd1e7@amd.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Tue, 24 Apr 2018 12:16:19 +0300
Message-ID: <CAFCwf13=M4LiNh+VK9aVZv4stnJHZ3=Oe7LT6p2E4=2O9tudkA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdkfd: Fix the error return code in kfd_ioctl_unmap_memory_from_gpu()
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:02 PM, Felix Kuehling <felix.kuehling@amd.com> wrote:
> Thanks for catching that. I'd use -ENODEV to match what is done a few
> lines below for peer_pdd. With that fixed, this patch is Reviewed-by:
> Felix Kuehling <Felix.Kuehling@amd.com>
>
> Regards,
>   Felix
>
>
> On 2018-03-29 10:25 PM, Wei Yongjun wrote:
>> Passing NULL pointer to PTR_ERR will result in return value of 0
>> indicating success which is clearly not what it is intended here.
>> This patch returns -EINVAL instead.
>>
>> Fixes: 5ec7e02854b3 ("drm/amdkfd: Add ioctls for GPUVM memory management")
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index cd679cf..c32a341 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1421,7 +1421,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>
>>       pdd = kfd_get_process_device_data(dev, p);
>>       if (!pdd) {
>> -             err = PTR_ERR(pdd);
>> +             err = -EINVAL;
>>               goto bind_process_to_device_failed;
>>       }
>>
>

Thanks!
Applied to -fixes with the -ENODEV return code

Oded
