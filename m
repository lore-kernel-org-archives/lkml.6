Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D4BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C19C2491A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C19C2491A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeFVVkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:40:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54060 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeFVVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:40:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so3461663wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=psplx+LrP0MprvapV9coicuBcq2rkDkvURH/PzCp4Q0=;
        b=dg5RwXpDNt2cJ9QhB0FKH/tlKg8owt5G3G6OvQ/VckHaBptWWL1DykcKPXTdUsZDXy
         nlOPoFF9NmxUYUfQ4A72aqhSdTWSF1XAez3OAGQ5Wnm07+nPDUECnZfANk5WtlUWQmKC
         0Fqve8q8HdSF0VCAnlPKRdAF2q2U1gZtZXWO7ogQDYO+B74kMwHWah2di/6Bt1I+yRew
         LrjqCt3b/C4F4Wes8bsDWr2gz+g2dgMEfFIM7+3Kk5AmQabNfRTmifSwEm+Sa68RXim4
         e8ufy9O543dQWjEOXvS7A1MSkO4SEzwPoj5+73mq+Kwr3H5H5XeFFvaNGAMt27+FJ8Wq
         w3+w==
X-Gm-Message-State: APt69E0kIaxybJqaHron4YOo9+F2MxTMPcsiFl98OnDyBoJmB6e+R0qU
        znCVeANQhHc0ATwn7bm/5cDgTh5Uai/N2J5TfgbBSvI6W2g=
X-Google-Smtp-Source: ADUXVKLrIqZHwtY7vHlGK48wApLcPV3zY72PIOxTa/HK1hNjJEHASzSyELtRB34N9/2sjsG+jdBXyI6kpq/DMIWrEac=
X-Received: by 2002:a1c:8d15:: with SMTP id p21-v6mr2627588wmd.145.1529703614127;
 Fri, 22 Jun 2018 14:40:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1714:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 14:40:13
 -0700 (PDT)
In-Reply-To: <CAGXu5jL3GyJxd9EJ=gKb+SY98t2h2Q4VMt0b0fYt8KBBuP2_9Q@mail.gmail.com>
References: <20180524172436.GA17738@beast> <CACO55ttzvFZqUjXNut5n0ENR9e2+N2WfWnKnjfaWgNesspQ9UA@mail.gmail.com>
 <CAGXu5jL3GyJxd9EJ=gKb+SY98t2h2Q4VMt0b0fYt8KBBuP2_9Q@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 22 Jun 2018 23:40:13 +0200
Message-ID: <CACO55tuUROCr14Eq-Yn_OcD21QBjfa33b0Oj4oAthEz5NHHhrA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/secboot/acr: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:34 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jun 22, 2018 at 10:50 AM, Karol Herbst <kherbst@redhat.com> wrote:
>> On Thu, May 24, 2018 at 7:24 PM, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> allocates the working buffers before starting the writing so it won't
>>> abort in the middle. This needs an initial walk of the lists to figure
>>> out how large the buffer should be.
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>  .../nouveau/nvkm/subdev/secboot/acr_r352.c    | 25 ++++++++++++++++---
>>>  .../nouveau/nvkm/subdev/secboot/acr_r367.c    | 16 +++++++++++-
>>>  2 files changed, 37 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>>> index a721354249ce..d02e183717dc 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>>> @@ -414,6 +414,20 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>>>  {
>>>         struct ls_ucode_img *_img;
>>>         u32 pos = 0;
>>> +       u32 max_desc_size = 0;
>>> +       u8 *gdesc;
>>> +
>>> +       /* Figure out how large we need gdesc to be. */
>>> +       list_for_each_entry(_img, imgs, node) {
>>> +               const struct acr_r352_ls_func *ls_func =
>>> +                                           acr->func->ls_func[_img->falcon_id];
>>> +
>>> +               max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
>>> +       }
>>> +
>>> +       gdesc = kmalloc(max_desc_size, GFP_KERNEL);
>>> +       if (!gdesc)
>>> +               return -ENOMEM;
>>>
>>>         nvkm_kmap(wpr_blob);
>>>
>>> @@ -421,7 +435,6 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>>>                 struct ls_ucode_img_r352 *img = ls_ucode_img_r352(_img);
>>>                 const struct acr_r352_ls_func *ls_func =
>>>                                             acr->func->ls_func[_img->falcon_id];
>>> -               u8 gdesc[ls_func->bl_desc_size];
>>>
>>
>> if there are no guarantees that (ls_func->bl_desc_size & 0x4 == 0),
>> then we need to memset a bit more, because 4 bytes at the time are
>> actually copied inside nvkm_gpuobj_memcpy_to later in that code, but
>> the last 4 bytes are only partly memset to 0.
>
> I think this is unchanged from the original code, yes? The memset() is
> always against bl_desc_size; I haven't changed that.
>

right, but I think before we would upload undefined data (because we
run out of bounds for cerain bl_desc_size), now we get what ever was
left inside the buffer from the previous iteration. Both cases are not
good. It isn't an issue with your patch, the code before wasn't 100%
correct either. But maybe that's fine, because bl_desc_size is always
a multple of 0x4.

>> If ls_func->bl_desc_size is always a multiple of 0x4, then it isn't as
>> important, but still better to be fixed. Or maybe
>> nvkm_gpuobj_memcpy_to should do that handling and check if the size is
>> a multiple of 0x4 and otherwise handle that case?
>>
>> Same is valid for the changes in the r367 file.
>
> Should I resend with both the allocation and the memset getting
> rounded up to the next multiple of 4?

Yeah, I think copying 0 is better than random data.

Your patch is fine as it is though, because it doesn't add a new
issue, it just showed us there is a potential one. We should keep that
in mind and see how we want to fix that up. I can imagine that this
might cause some issues in some places, maybe it is totally fine.

Thanks

>
> -Kees
>
> --
> Kees Cook
> Pixel Security
