Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5261C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4A3208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LHpax/X8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4A3208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeHQBR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:17:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36621 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeHQBR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:17:28 -0400
Received: by mail-it0-f68.google.com with SMTP id p81-v6so8936362itp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NzW2/MkenckITEon2Sc7c1PDvG6EUmEi4Mi8Ch5Y4V4=;
        b=LHpax/X8lFAeH0pPdDNAsYG8ROSkOnoP9/d7bNDQ+qP8/NRicIFs9gz38l9fVS7oFF
         Ct+X31L7kNwLE5ytbmNWNow/bszqRkiWZGEoBNmMRkn8YU49NWJ/EYfZpcSdDIqOKrqq
         TOPwVcoKBxq9VGBn3Rc8HSijnCjDVMdi5oQpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NzW2/MkenckITEon2Sc7c1PDvG6EUmEi4Mi8Ch5Y4V4=;
        b=PKYA4QpsJ5psFMhkecSrmrme7qBMVOhjtAI2yqJzjSudQM95YiN6U2yrEhLThNHUWz
         398eNVHjYY+tdY/YIdwna54K0/rJpKWBFszB4Pe620bNf3soPu4hGw9TK7K7xlcOW5jg
         sRYhR9sMkeFnzHX1YWVuCdQkncsBnm23umimLSHBAD4kQ287yT1tORd1VrUyMBSywQPz
         Ies+ZMda9R3Aer8MZS6POQoF7a4MfL8blnBQv3R96ApxiYSAEXAloekTjloGJtyEd6QM
         v9z4g1u8Wg2Yct/UYlEtjtHL12+tWv2yDfxBqOjMg5jh/5hb+micBEWa93T9HgL8dZUj
         XoTw==
X-Gm-Message-State: AOUpUlGTWKEnsqiA2e7Aj+cYVRGHFTGA6ztOZ8bkERgrofk4wmLKd5LS
        xptw8c9nYaJqISMxNNRF3huBR/Uo/2l0Mo6d9ZxgjQ==
X-Google-Smtp-Source: AA+uWPxznWU9F+1y6eqbOduvdC2yX6yZV54yzPmP0lTcwoBi8NKoxKqREGpZv6LlARiIErSbuF6LVLsBgB/jrGTqBOY=
X-Received: by 2002:a24:6e0f:: with SMTP id w15-v6mr23673454itc.77.1534457795091;
 Thu, 16 Aug 2018 15:16:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e502:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 15:16:34
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <CALAqxLVrZXRT875-AxN=jt_kSD5=Nb9SuCW4PEsVL=pQkT_ugw@mail.gmail.com>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
 <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
 <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
 <CALAqxLWq-wgbc+aS0p45rvxmPj3KicsOV5ucCB-tcKWr74uqCQ@mail.gmail.com>
 <CAKMK7uEbfa24DaDbWjxgerzH69q-niHS5==z6NqJd3Yxi0q+7A@mail.gmail.com> <CALAqxLVrZXRT875-AxN=jt_kSD5=Nb9SuCW4PEsVL=pQkT_ugw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 17 Aug 2018 00:16:34 +0200
X-Google-Sender-Auth: uSLRm1AfVe1opZoiyw65ghboYRM
Message-ID: <CAKMK7uHrCAQpUhd2D4PpiizascLwP1kYgMM6cZv3B8OGez66Sw@mail.gmail.com>
Subject: Re: [git pull] drm for 4.19-rc1
To:     John Stultz <john.stultz@linaro.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:21 PM, John Stultz <john.stultz@linaro.org> wrot=
e:
> On Thu, Aug 16, 2018 at 1:46 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Thu, Aug 16, 2018 at 10:38 PM, John Stultz <john.stultz@linaro.org> w=
rote:
>>> On Thu, Aug 16, 2018 at 12:16 AM, Daniel Vetter <daniel@ffwll.ch> wrote=
:
>>>> On Thu, Aug 16, 2018 at 8:04 AM, John Stultz <john.stultz@linaro.org> =
wrote:
>>>>> On Tue, Aug 14, 2018 at 7:53 PM, Dave Airlie <airlied@gmail.com> wrot=
e:
>>>>>> This is the main drm pull request for 4.19.
>>>>>>
>>>>>> Rob has some new hardware support for new qualcomm hw that I'll send=
 along
>>>>>> separately. This has the display part of it, the remaining pull is f=
or the
>>>>>> acceleration engine.
>>>>>>
>>>>>> This also contains a wound-wait/wait-die mutex rework, Peter has ack=
ed it
>>>>>> for merging via my tree.
>>>>>>
>>>>>> Otherwise mostly the usual level of activity.
>>>>>
>>>>> Hey Folks,
>>>>>   Since this branch landed, I've been seeing the following panic on
>>>>> bootup w/ the HiKey board (which uses the hisilicon/kirin drm driver)=
:
>>>>>
>>>>> [    8.088388] Unable to handle kernel read from unreadable memory at
>>>>> virtual address 0000000000000030
>>>>> [    8.088393] Mem abort info:
>>>>> [    8.088397]   ESR =3D 0x96000005
>>>>> [    8.088402]   Exception class =3D DABT (current EL), IL =3D 32 bit=
s
>>>>> [    8.088406]   SET =3D 0, FnV =3D 0
>>>>> [    8.088410]   EA =3D 0, S1PTW =3D 0
>>>>> [    8.088413] Data abort info:
>>>>> [    8.088417]   ISV =3D 0, ISS =3D 0x00000005
>>>>> [    8.088421]   CM =3D 0, WnR =3D 0
>>>>> [    8.088427] user pgtable: 4k pages, 39-bit VAs, pgdp =3D (____ptrv=
al____)
>>>>> [    8.088432] [0000000000000030] pgd=3D0000000000000000, pud=3D00000=
00000000000
>>>>> [    8.088443] Internal error: Oops: 96000005 [#1] PREEMPT SMP
>>>>> [    8.088453] CPU: 5 PID: 1414 Comm: kworker/5:2 Tainted: G        W
>>>>>        4.18.0-07439-gbf1fba4 #633
>>>>> [    8.088457] Hardware name: HiKey Development Board (DT)
>>>>> [    8.088474] Workqueue: events adv7511_hpd_work
>>>>> [    8.088482] pstate: 40400005 (nZcv daif +PAN -UAO)
>>>>> [    8.088493] pc : drm_sysfs_hotplug_event+0x40/0x78
>>>>> [    8.088499] lr : drm_sysfs_hotplug_event+0x40/0x78
>>>>> [    8.088502] sp : ffffff800ba73d20
>>>>> [    8.088506] x29: ffffff800ba73d20 x28: 0000000000000000
>>>>> [    8.088514] x27: ffffff8009293cd8 x26: ffffffc074e55938
>>>>> [    8.088522] x25: 0000000000000000 x24: ffffffc07ff85000
>>>>> [    8.088530] x23: ffffffc0742c4a78 x22: ffffffc07ff86c00
>>>>> [    8.088537] x21: ffffffc0750d0e00 x20: 0000000000000000
>>>>> [    8.088545] x19: ffffff8009009a48 x18: 0000000000000000
>>>>> [    8.088552] x17: 0000000000000000 x16: ffffffc074fbde80
>>>>> [    8.088560] x15: 0000000000000000 x14: ffffffc005f96c00
>>>>> [    8.088568] x13: 00000040770c9000 x12: 0000000034d5d91d
>>>>> [    8.088575] x11: 0000000000000000 x10: 0000000000000990
>>>>> [    8.088582] x9 : ffffff800ba739b0 x8 : ffffff800913e000
>>>>> [    8.088589] x7 : 0000000000000000 x6 : ffffff8009009a48
>>>>> [    8.088596] x5 : ffffff80090588d0 x4 : 0000000000000000
>>>>> [    8.088602] x3 : ffffff8009009a48 x2 : 0000000000000000
>>>>> [    8.088608] x1 : 18701cfc97cf1200 x0 : 0000000000000000
>>>>> [    8.120775] Process kworker/5:2 (pid: 1414, stack limit =3D 0x(___=
_ptrval____))
>>>>> [    8.120778] Call trace:
>>>>> [    8.120787]  drm_sysfs_hotplug_event+0x40/0x78
>>>>> [    8.120794]  drm_kms_helper_hotplug_event+0x14/0x40
>>>>> [    8.120800]  adv7511_hpd_work+0x64/0xe0
>>>>> [    8.120807]  process_one_work+0x12c/0x320
>>>>> [    8.120814]  worker_thread+0x48/0x458
>>>>> [    8.126654]  kthread+0xf8/0x128
>>>>> [    8.126661]  ret_from_fork+0x10/0x18
>>>>> [    8.126672] Code: aa0003f4 52800020 a902ffa2 94006637 (f9401a80)
>>>>> [    8.135638] ---[ end trace cf7120942e6f40fa ]---
>>>>>
>>>>> And earlier in boot we see:
>>>>>
>>>>> [    4.620909] kirin-drm f4100000.ade: bound f4107800.dsi (ops dsi_op=
s)
>>>>> [    4.627304] [drm] Supports vblank timestamp caching Rev 2 (21.10.2=
013).
>>>>> [    4.633935] [drm] No driver support for vblank timestamp query.
>>>>> [    4.732910] kirin-drm f4100000.ade: [drm:drm_fb_helper_fbdev_setup=
]
>>>>> *ERROR* Failed to set fbdev configuration
>>>>> [    4.742948] [drm:kirin_drm_bind] *ERROR* failed to initialize fbde=
v.
>>>>> [    4.749585] kirin-drm f4100000.ade: master bind failed: -22
>>>>> [    4.755218] dw-dsi: probe of f4107800.dsi failed with error -22
>>>>>
>>>>> I've also seen similar trouble w/ the HiKey960 which uses a similar
>>>>> but still out of tree driver that also utilizes the cma fbhelper code=
,
>>>>> which makes me suspect it has to do with the drm/cma-helper changes
>>>>> below:
>>>>>
>>>>>> Noralf Tr=C3=B8nnes (15):
>>>>>>       drm/file: Don't set master on in-kernel clients
>>>>>>       drm: Make ioctls available for in-kernel clients
>>>>>>       drm: Begin an API for in-kernel clients
>>>>>>       drm/fb-helper: Add generic fbdev emulation .fb_probe function
>>>>>>       drm/pl111: Set .gem_prime_vmap and .gem_prime_mmap
>>>>>>       drm/cma-helper: Use the generic fbdev emulation
>>>>>>       drm/debugfs: Add internal client debugfs file
>>>>>>       drm/fb-helper: Finish the generic fbdev emulation
>>>>>>       drm/tinydrm: Use drm_fbdev_generic_setup()
>>>>>>       drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs()
>>>>>
>>>>> Though I've not yet had time to bisect this down tonight.
>>>>>
>>>>> I'll spend some more time on this tomorrow, but wanted to give folks =
a
>>>>> heads up in the meantime.
>>>>
>>>> Hm, not immediately seeing what's going boom here. Bisect would indeed
>>>> be good, but maybe we need to chase the callchain to figure out where
>>>> exactly that -EINVAL is coming from in the reworked code (and why
>>>> hikey is the first to hit that, there's lots of cma based drivers
>>>> after all).
>>>
>>> So I can confirm reverting:
>>> 85b5bafb86e6 ("drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs(=
)")
>>> and
>>> 894a677f4b3e ("drm/cma-helper: Use the generic fbdev emulation")
>>>
>>> makes things work again.
>>>
>>> Though without the reverts, I was digging to understand what was
>>> failing, and it seems when we call into
>>> drm_client_framebuffer_create(), as Noralf suggested, we're eventually
>>> failing at drm_internal_framebuffer_create() when checking
>>> config->max_height.  The kirin driver is somewhat limited w/ max
>>> width/height values at 2048 each.
>>>
>>> Though I'm on a 1920x1080 monitor (max resolution supported by the
>>> board), it seems we're trying to allocate a 1920x2160 buffer? I know
>>> Android tries to allocate 2x Y for page-flipping, but I'm not sure yet
>>> why the old code didn't hit this problem.
>>>
>>> Unfortunately bumping the max width/height values to 4096 cause the
>>> system to hard hang as userspace starts up (and setting it to
>>> 2048/2160 does the same).
>>>
>>> So yea, I'm going to continue to dig at the hard-hang issue, and
>>> hopefully we can just  bump the max width/height, but if there are
>>> other suggestions, please let me know.
>>
>> You happen to have set drm_fb_overalloc respectively
>> CONFIG_DRM_FBDEV_OVERALLOC? Was added so that mali blob can pageflip,
>> would explain what's going on at least.
>
> Yep. CONFIG_DRM_FBDEV_OVERALLOC is set to 200.

So ->max_height is indeed the limit (or should be, minus driver bugs)
for framebuffers. That's enforced in drm_framebuffer_create_internal
for everything (both ioctl and should also for all internal callers),
except the cma helpers never made sure this is correct. So I'd call
this a bugfix.

Now the question is whether the fbdev page-flipping actually worked on
older kernels for you or not ...
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
