Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC562148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="REjn47MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC562148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbeHPJAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:00:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbeHPJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:00:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so3006904wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 23:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zkFWPQuwM0C/VxBX8QeMmLf3lHUvpYjoImeMLy9Pw10=;
        b=REjn47MXebqS+6aW0uEKtJCC6hoRWFsU1EFFZ6oD3nMp1QQeJNWMQ6I42IMaZbwnRc
         3ME3yVohhcXPXTfckc+Sj2MtXZmv94c5hDqCBTj/zQWJQquC83o6jua16KJ59UGBvHNk
         RIbsBRz/zakFcb5vcm9uZ1i+xFSjd8PsTTVjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zkFWPQuwM0C/VxBX8QeMmLf3lHUvpYjoImeMLy9Pw10=;
        b=Y1hFkQDsMBZgJr0+qwMAmt+DE165vh0RJlbOtN9xuJP/sZSsBpj7vkN2oE3MwToFz0
         F0pZ1uBilvCqEalihEklse5FJ0RW4M8SgkJVLNs1SCacPsPf4p/T98OqIAWZMyqLNmjV
         biM4SoiSvECjpjlC9ArrK2ChvG3I+1iWWInVG7tPkzIR5/IpDZy672A8kmidVR9ywsmb
         pz2V1RCf85+5iRV97ZAls8cinYwsqUnPNE0MJ0nDCMx+pSP3ugjqZAklgIOc0CZkCoRV
         ZozUCo2GdNqPA62qHWEHKDlX1S1JqUlP2d2D0mwL7TdBr7VRfSPgB9s3eNkma2eQatoe
         kj9w==
X-Gm-Message-State: AOUpUlGouWXTgs1skmE7DbGn5F5+shKPehIHN0DAwOyPxr0S1j6A3Xa9
        TWLQXqVm79xIz0stKylesry4ohW8V3bKiImGLSFU5Q==
X-Google-Smtp-Source: AA+uWPyAYra3+M4jkKFpRUG/e96RuwWwAG8HAOTyA5d+i0aZu17n5OEXRd21kwnNBENyvz4FLDhtt2rLu6u8StVRIYc=
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr18557414wrt.265.1534399471501;
 Wed, 15 Aug 2018 23:04:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 23:04:30
 -0700 (PDT)
In-Reply-To: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Aug 2018 23:04:30 -0700
Message-ID: <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
Subject: Re: [git pull] drm for 4.19-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 7:53 PM, Dave Airlie <airlied@gmail.com> wrote:
> This is the main drm pull request for 4.19.
>
> Rob has some new hardware support for new qualcomm hw that I'll send alon=
g
> separately. This has the display part of it, the remaining pull is for th=
e
> acceleration engine.
>
> This also contains a wound-wait/wait-die mutex rework, Peter has acked it
> for merging via my tree.
>
> Otherwise mostly the usual level of activity.

Hey Folks,
  Since this branch landed, I've been seeing the following panic on
bootup w/ the HiKey board (which uses the hisilicon/kirin drm driver):

[    8.088388] Unable to handle kernel read from unreadable memory at
virtual address 0000000000000030
[    8.088393] Mem abort info:
[    8.088397]   ESR =3D 0x96000005
[    8.088402]   Exception class =3D DABT (current EL), IL =3D 32 bits
[    8.088406]   SET =3D 0, FnV =3D 0
[    8.088410]   EA =3D 0, S1PTW =3D 0
[    8.088413] Data abort info:
[    8.088417]   ISV =3D 0, ISS =3D 0x00000005
[    8.088421]   CM =3D 0, WnR =3D 0
[    8.088427] user pgtable: 4k pages, 39-bit VAs, pgdp =3D (____ptrval____=
)
[    8.088432] [0000000000000030] pgd=3D0000000000000000, pud=3D00000000000=
00000
[    8.088443] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    8.088453] CPU: 5 PID: 1414 Comm: kworker/5:2 Tainted: G        W
       4.18.0-07439-gbf1fba4 #633
[    8.088457] Hardware name: HiKey Development Board (DT)
[    8.088474] Workqueue: events adv7511_hpd_work
[    8.088482] pstate: 40400005 (nZcv daif +PAN -UAO)
[    8.088493] pc : drm_sysfs_hotplug_event+0x40/0x78
[    8.088499] lr : drm_sysfs_hotplug_event+0x40/0x78
[    8.088502] sp : ffffff800ba73d20
[    8.088506] x29: ffffff800ba73d20 x28: 0000000000000000
[    8.088514] x27: ffffff8009293cd8 x26: ffffffc074e55938
[    8.088522] x25: 0000000000000000 x24: ffffffc07ff85000
[    8.088530] x23: ffffffc0742c4a78 x22: ffffffc07ff86c00
[    8.088537] x21: ffffffc0750d0e00 x20: 0000000000000000
[    8.088545] x19: ffffff8009009a48 x18: 0000000000000000
[    8.088552] x17: 0000000000000000 x16: ffffffc074fbde80
[    8.088560] x15: 0000000000000000 x14: ffffffc005f96c00
[    8.088568] x13: 00000040770c9000 x12: 0000000034d5d91d
[    8.088575] x11: 0000000000000000 x10: 0000000000000990
[    8.088582] x9 : ffffff800ba739b0 x8 : ffffff800913e000
[    8.088589] x7 : 0000000000000000 x6 : ffffff8009009a48
[    8.088596] x5 : ffffff80090588d0 x4 : 0000000000000000
[    8.088602] x3 : ffffff8009009a48 x2 : 0000000000000000
[    8.088608] x1 : 18701cfc97cf1200 x0 : 0000000000000000
[    8.120775] Process kworker/5:2 (pid: 1414, stack limit =3D 0x(____ptrva=
l____))
[    8.120778] Call trace:
[    8.120787]  drm_sysfs_hotplug_event+0x40/0x78
[    8.120794]  drm_kms_helper_hotplug_event+0x14/0x40
[    8.120800]  adv7511_hpd_work+0x64/0xe0
[    8.120807]  process_one_work+0x12c/0x320
[    8.120814]  worker_thread+0x48/0x458
[    8.126654]  kthread+0xf8/0x128
[    8.126661]  ret_from_fork+0x10/0x18
[    8.126672] Code: aa0003f4 52800020 a902ffa2 94006637 (f9401a80)
[    8.135638] ---[ end trace cf7120942e6f40fa ]---

And earlier in boot we see:

[    4.620909] kirin-drm f4100000.ade: bound f4107800.dsi (ops dsi_ops)
[    4.627304] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.633935] [drm] No driver support for vblank timestamp query.
[    4.732910] kirin-drm f4100000.ade: [drm:drm_fb_helper_fbdev_setup]
*ERROR* Failed to set fbdev configuration
[    4.742948] [drm:kirin_drm_bind] *ERROR* failed to initialize fbdev.
[    4.749585] kirin-drm f4100000.ade: master bind failed: -22
[    4.755218] dw-dsi: probe of f4107800.dsi failed with error -22

I've also seen similar trouble w/ the HiKey960 which uses a similar
but still out of tree driver that also utilizes the cma fbhelper code,
which makes me suspect it has to do with the drm/cma-helper changes
below:

> Noralf Tr=C3=B8nnes (15):
>       drm/file: Don't set master on in-kernel clients
>       drm: Make ioctls available for in-kernel clients
>       drm: Begin an API for in-kernel clients
>       drm/fb-helper: Add generic fbdev emulation .fb_probe function
>       drm/pl111: Set .gem_prime_vmap and .gem_prime_mmap
>       drm/cma-helper: Use the generic fbdev emulation
>       drm/debugfs: Add internal client debugfs file
>       drm/fb-helper: Finish the generic fbdev emulation
>       drm/tinydrm: Use drm_fbdev_generic_setup()
>       drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs()

Though I've not yet had time to bisect this down tonight.

I'll spend some more time on this tomorrow, but wanted to give folks a
heads up in the meantime.

thanks
-john
