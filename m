Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934952AbeEWWsP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:48:15 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40510 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934544AbeEWWsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:48:14 -0400
X-Google-Smtp-Source: AB8JxZpcGnmlAZY2yfOmwVKignMIrKu6OQ3dLKtVB2GUsRUl/fqKqF0vSrEdBCiiVH7t8SwjuaRyBI+skECqx/1tZiA=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+OyUWm8N0s-6NnREFakpR6xFJTt7+KK99JRm4i+ZAmyQ@mail.gmail.com>
References: <20180313162411.GA1983@embeddedgus> <20180314110834.GB8564@ulmo>
 <CACAvsv6NhUrskZGMJGyO42LtuNTWygsutddo_-fuhHRPCs2KWA@mail.gmail.com> <CAGXu5j+OyUWm8N0s-6NnREFakpR6xFJTt7+KK99JRm4i+ZAmyQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 23 May 2018 15:48:12 -0700
X-Google-Sender-Auth: xLD7YV5Bjof2xLwrG0_9hnyPAW4
Message-ID: <CAGXu5jKAVxzftPJkY3YJ2P-M4bfk1+8UHZZYRG32qBxauTf43g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/secboot: remove VLA usage
To: Ben Skeggs <skeggsb@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
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

On Thu, Apr 26, 2018 at 4:25 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Mar 15, 2018 at 7:05 PM, Ben Skeggs <skeggsb@gmail.com> wrote:
>> On 14 March 2018 at 21:08, Thierry Reding <thierry.reding@gmail.com> wrote:
>>> On Tue, Mar 13, 2018 at 11:24:11AM -0500, Gustavo A. R. Silva wrote:
>>>> In preparation to enabling -Wvla, remove VLA. In this particular
>>>> case directly use macro NVKM_MSGQUEUE_CMDLINE_SIZE instead of local
>>>> variable cmdline_size. Also, remove cmdline_size as it is not
>>>> actually useful anymore.
>>>>
>>>> The use of stack Variable Length Arrays needs to be avoided, as they
>>>> can be a vector for stack exhaustion, which can be both a runtime bug
>>>> or a security flaw. Also, in general, as code evolves it is easy to
>>>> lose track of how big a VLA can get. Thus, we can end up having runtime
>>>> failures that are hard to debug.
>>>>
>>>> Also, fixed as part of the directive to remove all VLAs from
>>>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>> ---
>>>> Changes in v2:
>>>>  - Use sizeof(buf) instead of NVKM_MSGQUEUE_CMDLINE_SIZE. This change
>>>>    is based on the feedback provided by David Laight. Thanks David.
>>>>
>>>>  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c | 7 +++----
>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>> Thanks everyone.  I've taken the patch in my tree.
>
> Hi!
>
> Just checking in on this -- I don't see this patch in linux-next. Is
> this queued somewhere else?

Hi, it's been another month; I still don't see this in linux-next.
Daniel, can this go via drm-misc?

-Kees

-- 
Kees Cook
Pixel Security
