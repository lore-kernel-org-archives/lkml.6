Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935174AbeEXAra (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:47:30 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45870 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935060AbeEXAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:47:27 -0400
X-Google-Smtp-Source: AB8JxZpiC8YE4jvspcGbZUps/pMBe3rqUCjmfHCwBBmLwoLHiybBIKp7UVnKKc1GN3QP8S3BkZECJE0VFHF+KJem0B4=
MIME-Version: 1.0
In-Reply-To: <CABDvA=mfOyx9X5JFvQaAYSQhvfaCZdqvVj7pD6=M0TX0AqQjcA@mail.gmail.com>
References: <20180313162411.GA1983@embeddedgus> <20180314110834.GB8564@ulmo>
 <CACAvsv6NhUrskZGMJGyO42LtuNTWygsutddo_-fuhHRPCs2KWA@mail.gmail.com>
 <CAGXu5j+OyUWm8N0s-6NnREFakpR6xFJTt7+KK99JRm4i+ZAmyQ@mail.gmail.com>
 <CAGXu5jKAVxzftPJkY3YJ2P-M4bfk1+8UHZZYRG32qBxauTf43g@mail.gmail.com> <CABDvA=mfOyx9X5JFvQaAYSQhvfaCZdqvVj7pD6=M0TX0AqQjcA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 23 May 2018 17:47:24 -0700
X-Google-Sender-Auth: QVb63A5Wh5n5K-6bDjnu-MrO-Xw
Message-ID: <CAGXu5jKUZwiA7GgeZCKYshitavmTW+7AHxd_Pm3xtK+v=1RbeA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/secboot: remove VLA usage
To: Ben Skeggs <bskeggs@redhat.com>
Cc: Ben Skeggs <skeggsb@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 5:36 PM, Ben Skeggs <bskeggs@redhat.com> wrote:
> On Thu, May 24, 2018 at 8:48 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Apr 26, 2018 at 4:25 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Thu, Mar 15, 2018 at 7:05 PM, Ben Skeggs <skeggsb@gmail.com> wrote:
>>>> On 14 March 2018 at 21:08, Thierry Reding <thierry.reding@gmail.com> wrote:
>>>>> On Tue, Mar 13, 2018 at 11:24:11AM -0500, Gustavo A. R. Silva wrote:
>>>>>> In preparation to enabling -Wvla, remove VLA. In this particular
>>>>>> case directly use macro NVKM_MSGQUEUE_CMDLINE_SIZE instead of local
>>>>>> variable cmdline_size. Also, remove cmdline_size as it is not
>>>>>> actually useful anymore.
>>>>>>
>>>>>> The use of stack Variable Length Arrays needs to be avoided, as they
>>>>>> can be a vector for stack exhaustion, which can be both a runtime bug
>>>>>> or a security flaw. Also, in general, as code evolves it is easy to
>>>>>> lose track of how big a VLA can get. Thus, we can end up having runtime
>>>>>> failures that are hard to debug.
>>>>>>
>>>>>> Also, fixed as part of the directive to remove all VLAs from
>>>>>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>>>>>
>>>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>>  - Use sizeof(buf) instead of NVKM_MSGQUEUE_CMDLINE_SIZE. This change
>>>>>>    is based on the feedback provided by David Laight. Thanks David.
>>>>>>
>>>>>>  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c | 7 +++----
>>>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>>>
>>>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>>> Thanks everyone.  I've taken the patch in my tree.
>>>
>>> Hi!
>>>
>>> Just checking in on this -- I don't see this patch in linux-next. Is
>>> this queued somewhere else?
>>
>> Hi, it's been another month; I still don't see this in linux-next.
>> Daniel, can this go via drm-misc?
> It's already queued in drm-next.

Ah-ha, great, thanks! Looks like I just got unlucky with linux-next
pausing on the 17th and this getting committed on the 18th. :) But,
yes, I see it now:
https://cgit.freedesktop.org/drm/drm/commit/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c?id=7bf5b70befd7817b9e42acbd2291b2042ea1bf81

-Kees

-- 
Kees Cook
Pixel Security
