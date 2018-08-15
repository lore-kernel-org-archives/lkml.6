Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD65EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A889A214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ie5I+9U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A889A214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeHPBl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:41:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38666 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeHPBl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:41:56 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so2345882iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeARcT9GI0hh+87nakk8rmv7PIk/Ox7xJkOc5qfP350=;
        b=Ie5I+9U+TdRRZOwETo59RoAu+HM1cccZihDRwhOSlBcW9kJRHDD27XkRLZjJbLGntA
         46AwKVU4hZExKrcKMGmIDI01m1t67wvsInBJR8KUwRynPGDuv/Mpwc1MGTXt8J5UO9vV
         MXn3PZKkJZZNnjgqr7+ybAr/rASH5Dny60zXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeARcT9GI0hh+87nakk8rmv7PIk/Ox7xJkOc5qfP350=;
        b=d2H9cXTNtUHY8XbFOxTRYawTfG8t+sNyodDjQGf0qnEMjnepNvm1OQXBcZLjXC9dXO
         Fbwe7YEZgISJzdjEsd482ubiLgS1m3oXIdw4R8J9OFKOXn8QUT9PNDJUyCfxuUMb/mTn
         mJVUA3FhGzBJ9Kp6nuJqGHdP/bhAvpKkPfrPJ+ct2TvZtUyS3MlFEEU6i9KQHR2uizXq
         niauzd3ZicfjonBAOkGdQQW8ym9DTN7IXOgqNdBYcuP5LtwT68DlFN17QWGVNcoPUQQY
         0z0nPEn76uuDRNMz9BuKEOWo+4kvTk8ynUkMvA+F6u6XER+d1+HYMIT3/ipLVOlWvVHw
         Q+oQ==
X-Gm-Message-State: AOUpUlFkWrUfn0b9eVvMQPGKfghZ9LsxTDYEo2cjhKYs7FWPwds2pJMJ
        5sYqnyCaXfiPA/h3wQEhALclRZuj7FKkfKOaQA4=
X-Google-Smtp-Source: AA+uWPxQ/qiZ/NW05rXUkbfRJg2M64W9CTTw/08DlZD9WYqAqNGDQVGLwcQ8RQlE3KNwqFn9mfmFAOyHARpBD2cMhgo=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr7142662ioh.259.1534373263021;
 Wed, 15 Aug 2018 15:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <s5h36vhazyp.wl-tiwai@suse.de>
In-Reply-To: <s5h36vhazyp.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 15:47:32 -0700
Message-ID: <CA+55aFx_ZgBBGoFCqQDCBTs6jq7t4SmVpzc1zzvd-B2E65mJEw@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.19-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 5:35 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> please pull sound updates for v4.19-rc1 from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-4.19-rc1

Uhhoh. This doesn't work for me on my laptop. I get this

  input: HDA Intel PCH Headphone Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input24
  input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input25
  input: HDA Intel PCH HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input26
  input: HDA Intel PCH HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input27
  input: HDA Intel PCH HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input28
  input: HDA Intel PCH HDMI/DP,pcm=10 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input29
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  PGD 0 P4D 0
  Oops: 0010 [#1] SMP PTI
  CPU: 3 PID: 863 Comm: alsactl Not tainted 4.18.0-03113-g0a957467c5fd #35
  Hardware name: Dell Inc. XPS 13 9350/09JHRY, BIOS 1.5.1 08/18/2017
  RIP: 0010:          (null)
  Code: Bad RIP value.
  RSP: 0018:ffff914e01f87d60 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: ffff88c5ab78acc0 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: ffffffffc08d118b RDI: 0000000000000001
  RBP: ffff88c5a6d3a000 R08: ffffffffffffffff R09: 0000000000000000
  R10: 0000000000000f07 R11: 0000000000000000 R12: ffff88c5aac07800
  R13: ffff88c5abe65000 R14: 00007ffe1c1abaa0 R15: 0000000000000000
  FS:  00007fc33ddc9740(0000) GS:ffff88c5bed80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffffffffd6 CR3: 0000000468a96002 CR4: 00000000003606e0
  Call Trace:
   ? cap_single_sw_put+0x4a/0x60 [snd_hda_codec_generic]
   ? snd_ctl_elem_write+0xd1/0x1a0 [snd]
   ? __kmalloc_track_caller+0x58/0x210
   ? _copy_from_user+0x37/0x60
   ? snd_ctl_ioctl+0x636/0x700 [snd]
   ? __seccomp_filter+0x44/0x4c0
   ? do_vfs_ioctl+0xa4/0x620
   ? set_close_on_exec+0x2a/0x60
   ? ksys_ioctl+0x70/0x80
   ? __x64_sys_ioctl+0x16/0x20
   ? do_syscall_64+0x55/0x170
   ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
  CR2: 0000000000000000
  ---[ end trace cc6a1092bf03ff70 ]---
  RIP: 0010:          (null)
  Code: Bad RIP value.
  RSP: 0018:ffff914e01f87d60 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: ffff88c5ab78acc0 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: ffffffffc08d118b RDI: 0000000000000001
  RBP: ffff88c5a6d3a000 R08: ffffffffffffffff R09: 0000000000000000
  R10: 0000000000000f07 R11: 0000000000000000 R12: ffff88c5aac07800
  R13: ffff88c5abe65000 R14: 00007ffe1c1abaa0 R15: 0000000000000000
  FS:  00007fc33ddc9740(0000) GS:ffff88c5bed80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffffffffd6 CR3: 0000000468a96002 CR4: 00000000003606e0

and I haven't tried to figure out what exactly broke yet. So no
bisection or similar, thought I'd send this out first.

But iooks like something jumps through a NULL pointer.

Any ideas?

            Linus
