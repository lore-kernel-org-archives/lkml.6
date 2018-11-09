Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7336820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jh9ygEzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7336820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeKIV6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:58:01 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46548 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIV6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:58:01 -0500
Received: by mail-vs1-f65.google.com with SMTP id r14so867041vsc.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kShg017Lb1rxDUjSl6cGUrOaXrdK2AGTuLJjYIJcIZ4=;
        b=jh9ygEzCqE8gFlxUBd1WkaMbasj3f/3t5lfd5f7z4QZpq3rVE8cIYPiISwwaMuF5d9
         kbkcda41dpBGCHmpgwLwtcdZfPmseNiWQPgUJhQHTq52VXoTm3suL51nUMl2o9RXHrHZ
         QMiCwRZTgJ8pnVkmYw9DiIgmIGyqzBqtXbiDmOxGGbjSkGDJFpGIbATVJCADn7TnOTJb
         CWRjujAK/kcp7lj8+8qQVUX7hZPHfnnjtPE4kIYBPrSwovia4pOZxSZdBrznfc2plOCX
         LHbH52iF/zt0FmjVyqxN1v5gIX9YSYuJtbuNs+SvvfUYYsfSOdSyiFEiTEt8P8XicQeD
         pEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kShg017Lb1rxDUjSl6cGUrOaXrdK2AGTuLJjYIJcIZ4=;
        b=R1yNQwjcWTMnebd+BzBrLt38EiKblg2xg9dtSScrUGDAxPll/zi7SULIYhOu1OhT8N
         ztcKuy93J3NeG0agy8oCsI1t5er07+6iNHTYSaF5wv6nZ99CEjEIlyLYk9KnX1CXxVnH
         fupTzP9l0HVyxFDbHo/oZtQ2TzdO0Y2ab7S4PWnnYK6cfbtdiLkgQICE7vpim53WG+0i
         PwuW7yE1HgT9RgDcJ4kVcwHVUBaTuuB41owW2nV2GTVWgE7UR1vNBqj2va0YwxC4u/lK
         ZoyOIME2W35iuOTDEPOIC9LwtxkMawBgXG2ZSkYe3iFD6f7o43xqv5YceDPGT8EEShi/
         o6Hg==
X-Gm-Message-State: AGRZ1gLpjWqw+agnzNjWHDtJER/lz6++A7V9wz+Km9OB2FDD5n3TsDwI
        UOQlpA38KHh9Gp+2ArTXtPDKA0i2euy1Jjrj3s1Tpg==
X-Google-Smtp-Source: AJdET5eWupIgeKRAKSMSWzHE+WRrQEoyH3czxY8xnFKVKVSBoznXL6xMbmHWn5Q/aDnhdOcxl1qf+05J+ygKxdGGzPs=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr3679891vsd.103.1541765857687;
 Fri, 09 Nov 2018 04:17:37 -0800 (PST)
MIME-Version: 1.0
References: <00000000000021d9a9057a2d364e@google.com> <CAG_fn=WnKks-EqmAP5V2VtLPvAgtbopaPUz4fFk_H8TkaSkuVA@mail.gmail.com>
 <s5h1s7u1ott.wl-tiwai@suse.de>
In-Reply-To: <s5h1s7u1ott.wl-tiwai@suse.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 9 Nov 2018 13:17:25 +0100
Message-ID: <CAG_fn=U8joA4f1e0+qjxJ7HhGf9z2ugdw_SmwL2ay-MCiT7EEA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in linear_transfer (2)
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com,
        alsa-devel@alsa-project.org, syzkaller-bugs@googlegroups.com,
        perex@perex.cz, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 12:18 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 09 Nov 2018 10:31:03 +0100,
> Alexander Potapenko wrote:
> >
> > On Thu, Nov 8, 2018 at 9:38 PM syzbot
> > <syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    7438a3b20295 kmsan: print user address when reporting=
 info..
> > > git tree:       https://github.com/google/kmsan.git/master
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15b421334=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8df5fc509=
a1b351b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1cb36954e12=
7c98dd037
> > > compiler:       clang version 8.0.0 (trunk 343298)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12be982=
5400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13e2c4254=
00000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> > > Reported-by: syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KMSAN: uninit-value in __arch_swab32
> > > arch/x86/include/uapi/asm/swab.h:10 [inline]
> > > BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:59 [i=
nline]
> > > BUG: KMSAN: uninit-value in do_convert sound/core/oss/linear.c:50 [in=
line]
> > > BUG: KMSAN: uninit-value in convert sound/core/oss/linear.c:81 [inlin=
e]
> > > BUG: KMSAN: uninit-value in linear_transfer+0x92d/0xca0
> > > sound/core/oss/linear.c:110
> > > CPU: 1 PID: 6835 Comm: syz-executor866 Not tainted 4.19.0+ #78
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS
> > > Google 01/01/2011
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x32d/0x480 lib/dump_stack.c:113
> > >   kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
> > >   __msan_warning+0x76/0xd0 mm/kmsan/kmsan_instr.c:415
> > >   __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
> > >   __fswab32 include/uapi/linux/swab.h:59 [inline]
> > >   do_convert sound/core/oss/linear.c:50 [inline]
> > >   convert sound/core/oss/linear.c:81 [inline]
> > >   linear_transfer+0x92d/0xca0 sound/core/oss/linear.c:110
> > >   snd_pcm_plug_read_transfer+0x3bf/0x590 sound/core/oss/pcm_plugin.c:=
659
> > >   snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1480 [inline]
> > >   snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1518 [inline]
> > >   snd_pcm_oss_read+0xe6d/0x1cb0 sound/core/oss/pcm_oss.c:2758
> > >   __vfs_read+0x1e2/0xb10 fs/read_write.c:416
> > >   vfs_read+0x380/0x6b0 fs/read_write.c:452
> > >   ksys_read fs/read_write.c:578 [inline]
> > >   __do_sys_read fs/read_write.c:588 [inline]
> > >   __se_sys_read+0x17a/0x370 fs/read_write.c:586
> > >   __x64_sys_read+0x4a/0x70 fs/read_write.c:586
> > >   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> > >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > > RIP: 0033:0x446379
> > > Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 =
89 f7
> > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff
> > > ff 0f 83 7b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> > > RSP: 002b:00007fcd5b97cda8 EFLAGS: 00000246 ORIG_RAX: 000000000000000=
0
> > > RAX: ffffffffffffffda RBX: 00000000006dac38 RCX: 0000000000446379
> > > RDX: 0000000000000184 RSI: 0000000020002180 RDI: 0000000000000003
> > > RBP: 00000000006dac30 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac3c
> > > R13: 7073642f7665642f R14: 00800000c0045002 R15: 0000000000000001
> > >
> > > Uninit was stored to memory at:
> > >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
> > >   kmsan_save_stack mm/kmsan/kmsan.c:267 [inline]
> > >   kmsan_internal_chain_origin+0x136/0x240 mm/kmsan/kmsan.c:569
> > >   kmsan_memcpy_origins+0x13d/0x1b0 mm/kmsan/kmsan.c:393
> > >   __msan_memcpy+0x6f/0x80 mm/kmsan/kmsan_instr.c:242
> > >   do_convert sound/core/oss/linear.c:48 [inline]
> > >   convert sound/core/oss/linear.c:81 [inline]
> > >   linear_transfer+0x74c/0xca0 sound/core/oss/linear.c:110
> > >   snd_pcm_plug_read_transfer+0x3bf/0x590 sound/core/oss/pcm_plugin.c:=
659
> > >   snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1480 [inline]
> > >   snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1518 [inline]
> > >   snd_pcm_oss_read+0xe6d/0x1cb0 sound/core/oss/pcm_oss.c:2758
> > >   __vfs_read+0x1e2/0xb10 fs/read_write.c:416
> > >   vfs_read+0x380/0x6b0 fs/read_write.c:452
> > >   ksys_read fs/read_write.c:578 [inline]
> > >   __do_sys_read fs/read_write.c:588 [inline]
> > >   __se_sys_read+0x17a/0x370 fs/read_write.c:586
> > >   __x64_sys_read+0x4a/0x70 fs/read_write.c:586
> > >   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> > >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > >
> > > Uninit was created at:
> > >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
> > >   kmsan_internal_alloc_meta_for_pages+0x155/0x740 mm/kmsan/kmsan.c:68=
9
> > >   kmsan_alloc_page+0x77/0xe0 mm/kmsan/kmsan_hooks.c:320
> > >   __alloc_pages_nodemask+0x12cc/0x6640 mm/page_alloc.c:4416
> > >   alloc_pages_current+0x584/0x7e0 mm/mempolicy.c:2093
> > >   alloc_pages include/linux/gfp.h:511 [inline]
> > >   __vmalloc_area_node mm/vmalloc.c:1689 [inline]
> > >   __vmalloc_node_range+0x879/0x12a0 mm/vmalloc.c:1752
> > >   __vmalloc_node mm/vmalloc.c:1797 [inline]
> > >   __vmalloc_node_flags mm/vmalloc.c:1811 [inline]
> > >   vmalloc+0xd8/0xf0 mm/vmalloc.c:1833
> > >   snd_pcm_plugin_alloc+0x255/0xc80 sound/core/oss/pcm_plugin.c:71
> > >   snd_pcm_plug_alloc+0x281/0x600 sound/core/oss/pcm_plugin.c:137
> > >   snd_pcm_oss_change_params_locked+0x5e40/0x6e30
> > > sound/core/oss/pcm_oss.c:1039
> > >   snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1107 [inline]
> > >   snd_pcm_oss_get_active_substream+0x4f7/0x5a0 sound/core/oss/pcm_oss=
.c:1124
> > >   snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1774 [inline]
> > >   snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1766 [inline]
> > >   snd_pcm_oss_ioctl+0x4adb/0x8860 sound/core/oss/pcm_oss.c:2614
> > >   do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
> > >   ksys_ioctl fs/ioctl.c:702 [inline]
> > >   __do_sys_ioctl fs/ioctl.c:709 [inline]
> > >   __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
> > >   __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
> > >   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
> > >   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I am actually unsure whether this is a true positive or not.
> > snd_pcm_plugin_alloc() allocates plugin->buf using vmalloc(size) (see
> > https://elixir.bootlin.com/linux/v4.20-rc1/source/sound/core/oss/pcm_pl=
ugin.c#L70)
> > KMSAN doesn't know where this buffer is initialized (any help finding
> > this out is welcome!), so we mark |size| bytes starting from
> > plugin->buf as initialized:
> > https://github.com/google/kmsan/blob/master/sound/core/oss/pcm_plugin.c=
#L78
> > But when |size| is not page-aligned vmalloc() still allocates whole
> > page, and in the report above linear_transfer() appears to run past
> > |size| bytes and read the tail bytes.
> > KASAN doesn't detect this bug, because it doesn't handle vmalloc'ed
> > (and these bytes are addressable anyway).
>
> It's still strange that the conversion function gets called for the
> uninitialized source.  But we should clear the vmalloc page in anyway
> for avoiding such a problem.  And even better would be to use
> kvzalloc() for a better performance.
>
> Could you check whether the patch works?
The patch works and fixes the problem for me.
> I forgot the way to trigger the test for kmsan stuff.  IIRC, just
> pushing to my tree and triggering syz test won't work for KMSAN,
> right?
Right, you need to test against KMSAN tree, see
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: oss: Use kvzalloc() for local buffer allocations
>
> PCM OSS layer may allocate a few temporary buffers, one for the core
> read/write and another for the conversions via plugins.  Currently
> both are allocated via vmalloc().  But as the allocation size is
> equivalent with the PCM period size, the required size might be quite
> small, depending on the application.
>
> This patch replaces these vmalloc() calls with kvzalloc() for covering
> small period sizes better.  Also, we use "z"-alloc variant here for
> addressing the possible uninitialized access reported by syzkaller.
>
> [ More reported-by and tested-by here in the final version ]
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/oss/pcm_oss.c    | 6 +++---
>  sound/core/oss/pcm_plugin.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index f8d4a419f3af..467039b342b5 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -1062,8 +1062,8 @@ static int snd_pcm_oss_change_params_locked(struct =
snd_pcm_substream *substream)
>         runtime->oss.channels =3D params_channels(params);
>         runtime->oss.rate =3D params_rate(params);
>
> -       vfree(runtime->oss.buffer);
> -       runtime->oss.buffer =3D vmalloc(runtime->oss.period_bytes);
> +       kvfree(runtime->oss.buffer);
> +       runtime->oss.buffer =3D kvzalloc(runtime->oss.period_bytes, GFP_K=
ERNEL);
>         if (!runtime->oss.buffer) {
>                 err =3D -ENOMEM;
>                 goto failure;
> @@ -2328,7 +2328,7 @@ static void snd_pcm_oss_release_substream(struct sn=
d_pcm_substream *substream)
>  {
>         struct snd_pcm_runtime *runtime;
>         runtime =3D substream->runtime;
> -       vfree(runtime->oss.buffer);
> +       kvfree(runtime->oss.buffer);
>         runtime->oss.buffer =3D NULL;
>  #ifdef CONFIG_SND_PCM_OSS_PLUGINS
>         snd_pcm_oss_plugin_clear(substream);
> diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
> index 141c5f3a9575..31cb2acf8afc 100644
> --- a/sound/core/oss/pcm_plugin.c
> +++ b/sound/core/oss/pcm_plugin.c
> @@ -66,8 +66,8 @@ static int snd_pcm_plugin_alloc(struct snd_pcm_plugin *=
plugin, snd_pcm_uframes_t
>                 return -ENXIO;
>         size /=3D 8;
>         if (plugin->buf_frames < frames) {
> -               vfree(plugin->buf);
> -               plugin->buf =3D vmalloc(size);
> +               kvfree(plugin->buf);
> +               plugin->buf =3D kvzalloc(size, GFP_KERNEL);
>                 plugin->buf_frames =3D frames;
>         }
>         if (!plugin->buf) {
> @@ -191,7 +191,7 @@ int snd_pcm_plugin_free(struct snd_pcm_plugin *plugin=
)
>         if (plugin->private_free)
>                 plugin->private_free(plugin);
>         kfree(plugin->buf_channels);
> -       vfree(plugin->buf);
> +       kvfree(plugin->buf);
>         kfree(plugin);
>         return 0;
>  }
> --
> 2.19.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
