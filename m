Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeDZXZ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:25:59 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36463 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbeDZXZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:25:58 -0400
X-Google-Smtp-Source: AB8JxZqPP37tluzvzD1XrPS6HXp9JV+cr0felq2R4a0hp++wtRKXIITBcKOIm2bFOn9kiEbMNE+sKCdlTTu5S6qHJIQ=
MIME-Version: 1.0
In-Reply-To: <CACAvsv6NhUrskZGMJGyO42LtuNTWygsutddo_-fuhHRPCs2KWA@mail.gmail.com>
References: <20180313162411.GA1983@embeddedgus> <20180314110834.GB8564@ulmo> <CACAvsv6NhUrskZGMJGyO42LtuNTWygsutddo_-fuhHRPCs2KWA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 26 Apr 2018 16:25:56 -0700
X-Google-Sender-Auth: d6NzKf1mhVKOjminwT49qkGfH4E
Message-ID: <CAGXu5j+OyUWm8N0s-6NnREFakpR6xFJTt7+KK99JRm4i+ZAmyQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/secboot: remove VLA usage
To: Ben Skeggs <skeggsb@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        David Laight <David.Laight@aculab.com>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 7:05 PM, Ben Skeggs <skeggsb@gmail.com> wrote:
> On 14 March 2018 at 21:08, Thierry Reding <thierry.reding@gmail.com> wrote:
>> On Tue, Mar 13, 2018 at 11:24:11AM -0500, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wvla, remove VLA. In this particular
>>> case directly use macro NVKM_MSGQUEUE_CMDLINE_SIZE instead of local
>>> variable cmdline_size. Also, remove cmdline_size as it is not
>>> actually useful anymore.
>>>
>>> The use of stack Variable Length Arrays needs to be avoided, as they
>>> can be a vector for stack exhaustion, which can be both a runtime bug
>>> or a security flaw. Also, in general, as code evolves it is easy to
>>> lose track of how big a VLA can get. Thus, we can end up having runtime
>>> failures that are hard to debug.
>>>
>>> Also, fixed as part of the directive to remove all VLAs from
>>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>> Changes in v2:
>>>  - Use sizeof(buf) instead of NVKM_MSGQUEUE_CMDLINE_SIZE. This change
>>>    is based on the feedback provided by David Laight. Thanks David.
>>>
>>>  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Thanks everyone.  I've taken the patch in my tree.

Hi!

Just checking in on this -- I don't see this patch in linux-next. Is
this queued somewhere else?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
