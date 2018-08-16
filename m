Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A64C214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QT4VYQkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A64C214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbeHPKNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:13:13 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36948 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389228AbeHPKNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:13:13 -0400
Received: by mail-io0-f193.google.com with SMTP id z19-v6so3084607ioh.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=e5VWh6EO3wADMLsrRdgR+Xg6f/jFsWhx2Q5ROFY0Fy8=;
        b=QT4VYQkbLgNP+JTZSZCPA5EnR5ggtXBY4JSXJMDrNcTZlbAW7wvVBS39awbALc0xEp
         VZbc4dUE6nt0QYNjvQrHFpD5chsi9LjP+5dfWYUr0ymHDAhgGwwe2YFl4vFVMhAns9Rm
         Hm+vP/s0vtEIv0cQPWhdR3h6rsfgNCxCV36sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=e5VWh6EO3wADMLsrRdgR+Xg6f/jFsWhx2Q5ROFY0Fy8=;
        b=iyYZOA1LltRjUzniOBR1dSA/L6l8XO6jq6m0C4oYk04bYPVcKvEcpufKf9prDOjYjx
         NfTdRyEL6Y7I0Y4KZmrqY+eXwSHcrIUMdvOIWxF7cY92enp8RQMDIVS16epxmxunEZqT
         HRTw2R91c9cbGIvh2Gi/6YVCA3yMqRD9DXDuo8efD5vXd73eIhndGMAx9rjMxez0441l
         39XXNJ5Z4NnFxW9cj5wxp84TVcTegwaxS7Ig7bNpgGkADNlSjH8HN35XLOK8Wf+ZECVb
         tAzwFahwqaCPG5FZXrtLOjDYBF1wm+Q7vgg+UMaeG+flGNiYQbpn+zTsrVAkwHVHauor
         krtA==
X-Gm-Message-State: AOUpUlHbP7a7ft8Inbt1coLaswtZ5HRlaDChCsWQGTsQAg+xHqqdi+vy
        unVFqnVXEoYxFBKsKGVCRixdLN4DVwRnigQcfvPGuQ==
X-Google-Smtp-Source: AA+uWPxpUx3ipHSLCynlGdnlW+4DyHjbMHnUPB/GVCBz3C5OWfbrWJFFqm2S1yLWTU1miZ1HrALALGifGbscGeUjjAo=
X-Received: by 2002:a5e:d50d:: with SMTP id e13-v6mr8972282iom.291.1534403805070;
 Thu, 16 Aug 2018 00:16:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e502:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 00:16:44
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
 <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 16 Aug 2018 09:16:44 +0200
X-Google-Sender-Auth: 2q4trg5yktEcDAhBEL3-xy3x9JA
Message-ID: <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
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

On Thu, Aug 16, 2018 at 8:04 AM, John Stultz <john.stultz@linaro.org> wrote=
:
> On Tue, Aug 14, 2018 at 7:53 PM, Dave Airlie <airlied@gmail.com> wrote:
>> This is the main drm pull request for 4.19.
>>
>> Rob has some new hardware support for new qualcomm hw that I'll send alo=
ng
>> separately. This has the display part of it, the remaining pull is for t=
he
>> acceleration engine.
>>
>> This also contains a wound-wait/wait-die mutex rework, Peter has acked i=
t
>> for merging via my tree.
>>
>> Otherwise mostly the usual level of activity.
>
> Hey Folks,
>   Since this branch landed, I've been seeing the following panic on
> bootup w/ the HiKey board (which uses the hisilicon/kirin drm driver):
>
> [    8.088388] Unable to handle kernel read from unreadable memory at
> virtual address 0000000000000030
> [    8.088393] Mem abort info:
> [    8.088397]   ESR =3D 0x96000005
> [    8.088402]   Exception class =3D DABT (current EL), IL =3D 32 bits
> [    8.088406]   SET =3D 0, FnV =3D 0
> [    8.088410]   EA =3D 0, S1PTW =3D 0
> [    8.088413] Data abort info:
> [    8.088417]   ISV =3D 0, ISS =3D 0x00000005
> [    8.088421]   CM =3D 0, WnR =3D 0
> [    8.088427] user pgtable: 4k pages, 39-bit VAs, pgdp =3D (____ptrval__=
__)
> [    8.088432] [0000000000000030] pgd=3D0000000000000000, pud=3D000000000=
0000000
> [    8.088443] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [    8.088453] CPU: 5 PID: 1414 Comm: kworker/5:2 Tainted: G        W
>        4.18.0-07439-gbf1fba4 #633
> [    8.088457] Hardware name: HiKey Development Board (DT)
> [    8.088474] Workqueue: events adv7511_hpd_work
> [    8.088482] pstate: 40400005 (nZcv daif +PAN -UAO)
> [    8.088493] pc : drm_sysfs_hotplug_event+0x40/0x78
> [    8.088499] lr : drm_sysfs_hotplug_event+0x40/0x78
> [    8.088502] sp : ffffff800ba73d20
> [    8.088506] x29: ffffff800ba73d20 x28: 0000000000000000
> [    8.088514] x27: ffffff8009293cd8 x26: ffffffc074e55938
> [    8.088522] x25: 0000000000000000 x24: ffffffc07ff85000
> [    8.088530] x23: ffffffc0742c4a78 x22: ffffffc07ff86c00
> [    8.088537] x21: ffffffc0750d0e00 x20: 0000000000000000
> [    8.088545] x19: ffffff8009009a48 x18: 0000000000000000
> [    8.088552] x17: 0000000000000000 x16: ffffffc074fbde80
> [    8.088560] x15: 0000000000000000 x14: ffffffc005f96c00
> [    8.088568] x13: 00000040770c9000 x12: 0000000034d5d91d
> [    8.088575] x11: 0000000000000000 x10: 0000000000000990
> [    8.088582] x9 : ffffff800ba739b0 x8 : ffffff800913e000
> [    8.088589] x7 : 0000000000000000 x6 : ffffff8009009a48
> [    8.088596] x5 : ffffff80090588d0 x4 : 0000000000000000
> [    8.088602] x3 : ffffff8009009a48 x2 : 0000000000000000
> [    8.088608] x1 : 18701cfc97cf1200 x0 : 0000000000000000
> [    8.120775] Process kworker/5:2 (pid: 1414, stack limit =3D 0x(____ptr=
val____))
> [    8.120778] Call trace:
> [    8.120787]  drm_sysfs_hotplug_event+0x40/0x78
> [    8.120794]  drm_kms_helper_hotplug_event+0x14/0x40
> [    8.120800]  adv7511_hpd_work+0x64/0xe0
> [    8.120807]  process_one_work+0x12c/0x320
> [    8.120814]  worker_thread+0x48/0x458
> [    8.126654]  kthread+0xf8/0x128
> [    8.126661]  ret_from_fork+0x10/0x18
> [    8.126672] Code: aa0003f4 52800020 a902ffa2 94006637 (f9401a80)
> [    8.135638] ---[ end trace cf7120942e6f40fa ]---
>
> And earlier in boot we see:
>
> [    4.620909] kirin-drm f4100000.ade: bound f4107800.dsi (ops dsi_ops)
> [    4.627304] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
.
> [    4.633935] [drm] No driver support for vblank timestamp query.
> [    4.732910] kirin-drm f4100000.ade: [drm:drm_fb_helper_fbdev_setup]
> *ERROR* Failed to set fbdev configuration
> [    4.742948] [drm:kirin_drm_bind] *ERROR* failed to initialize fbdev.
> [    4.749585] kirin-drm f4100000.ade: master bind failed: -22
> [    4.755218] dw-dsi: probe of f4107800.dsi failed with error -22
>
> I've also seen similar trouble w/ the HiKey960 which uses a similar
> but still out of tree driver that also utilizes the cma fbhelper code,
> which makes me suspect it has to do with the drm/cma-helper changes
> below:
>
>> Noralf Tr=C3=B8nnes (15):
>>       drm/file: Don't set master on in-kernel clients
>>       drm: Make ioctls available for in-kernel clients
>>       drm: Begin an API for in-kernel clients
>>       drm/fb-helper: Add generic fbdev emulation .fb_probe function
>>       drm/pl111: Set .gem_prime_vmap and .gem_prime_mmap
>>       drm/cma-helper: Use the generic fbdev emulation
>>       drm/debugfs: Add internal client debugfs file
>>       drm/fb-helper: Finish the generic fbdev emulation
>>       drm/tinydrm: Use drm_fbdev_generic_setup()
>>       drm/cma-helper: Remove drm_fb_cma_fbdev_init_with_funcs()
>
> Though I've not yet had time to bisect this down tonight.
>
> I'll spend some more time on this tomorrow, but wanted to give folks a
> heads up in the meantime.

Hm, not immediately seeing what's going boom here. Bisect would indeed
be good, but maybe we need to chase the callchain to figure out where
exactly that -EINVAL is coming from in the reworked code (and why
hikey is the first to hit that, there's lots of cma based drivers
after all).
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
