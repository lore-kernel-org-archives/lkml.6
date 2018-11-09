Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD521C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8981320840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFOCwxdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8981320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeKITLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:11:00 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42931 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKITLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:11:00 -0500
Received: by mail-vk1-f195.google.com with SMTP id y14so253860vky.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yw9v2cipb9c3G8A+3P4qPhBJ7WXKqb0NPwagFMFU4g=;
        b=LFOCwxdO03JU/SE9i6maKdUhGE4+fZkPUOvBoFt5sjMwfnFVd0HaAmBkup0UYQPm7v
         oLmIiFJOhGR8jEWE4OwG8RWFzde6aqtW574iFBB7Ic0hezlzrkUTHgqfp8uQaoDah62j
         kdftw7PSKMPB7VqnlIxC71NX7av/w/A7sDR/ipC/dgacT6AfouIKlwiPF0SCu8d92Tcp
         Lj5PfiJTnbALeRhTpduZm+Y13vtYeAOo3i8tdQ4RwSIJMtB/tPUFMe5urJJW7HzVi8LR
         zpYCe/Esdxa/Q0+Ov2Zj4SYfAXhmaeN/aqjR7YNOiJj9+IARIvfGFaBjj0V92ComHhb/
         ziSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yw9v2cipb9c3G8A+3P4qPhBJ7WXKqb0NPwagFMFU4g=;
        b=t3AVUUpilxmsLK7Ctcgu1uaZpHrQJNvNsUAOo5E7UdTMTyjEDODhLqqKPF+9o1wXVT
         kEm2+cRxK9owyRBvm9hfa2FfdY+PypCj0jy5NKUvIf2iwuBWHdhLv1nt3W/rR0jTmMlP
         0F7pdXetaDj58EEmRr8BYOgJBxu1q2IdrtY9BlVVW0bvPMnPiA0dofGB2hjoj+Q7kvqZ
         vth2BDnRhwNd/AUw5DrjGueTbHNs7wSPqJO56YO29qlpT+L1mcu+GDX//ZINGmano4cq
         v/Jd6CYy/U1zOI0TPpGygtr+RJLMToEmYAheygnrkQhc6GKXqPCkoqwXdZU5wFum48X2
         4mwA==
X-Gm-Message-State: AGRZ1gL57Glp6vln9zQGmpy5xFfLoA4TAO/pQYTxiwk8QgDRZPBBMjht
        Uo+/ZSqCGnkRs8EzY9ug5k0YUn+9qQJOLt6/fDyptEG+KCrohg==
X-Google-Smtp-Source: AJdET5eh+FGbUJaJjpWT5xKOQ6eYGJZnxbCT1YSBeRbzUXplQX5Z7uD750bRXRCRC5DsI5vXsqcfgzl9e+9HleZ/HCg=
X-Received: by 2002:a1f:82c2:: with SMTP id e185mr3522634vkd.22.1541755876306;
 Fri, 09 Nov 2018 01:31:16 -0800 (PST)
MIME-Version: 1.0
References: <00000000000021d9a9057a2d364e@google.com>
In-Reply-To: <00000000000021d9a9057a2d364e@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 9 Nov 2018 10:31:03 +0100
Message-ID: <CAG_fn=WnKks-EqmAP5V2VtLPvAgtbopaPUz4fFk_H8TkaSkuVA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in linear_transfer (2)
To:     syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: multipart/mixed; boundary="000000000000571ade057a3803bf"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000571ade057a3803bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 8, 2018 at 9:38 PM syzbot
<syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    7438a3b20295 kmsan: print user address when reporting inf=
o..
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15b4213340000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8df5fc509a1b3=
51b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1cb36954e127c98=
dd037
> compiler:       clang version 8.0.0 (trunk 343298)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12be9825400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13e2c42540000=
0
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+1cb36954e127c98dd037@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __arch_swab32
> arch/x86/include/uapi/asm/swab.h:10 [inline]
> BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:59 [inlin=
e]
> BUG: KMSAN: uninit-value in do_convert sound/core/oss/linear.c:50 [inline=
]
> BUG: KMSAN: uninit-value in convert sound/core/oss/linear.c:81 [inline]
> BUG: KMSAN: uninit-value in linear_transfer+0x92d/0xca0
> sound/core/oss/linear.c:110
> CPU: 1 PID: 6835 Comm: syz-executor866 Not tainted 4.19.0+ #78
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x32d/0x480 lib/dump_stack.c:113
>   kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
>   __msan_warning+0x76/0xd0 mm/kmsan/kmsan_instr.c:415
>   __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
>   __fswab32 include/uapi/linux/swab.h:59 [inline]
>   do_convert sound/core/oss/linear.c:50 [inline]
>   convert sound/core/oss/linear.c:81 [inline]
>   linear_transfer+0x92d/0xca0 sound/core/oss/linear.c:110
>   snd_pcm_plug_read_transfer+0x3bf/0x590 sound/core/oss/pcm_plugin.c:659
>   snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1480 [inline]
>   snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1518 [inline]
>   snd_pcm_oss_read+0xe6d/0x1cb0 sound/core/oss/pcm_oss.c:2758
>   __vfs_read+0x1e2/0xb10 fs/read_write.c:416
>   vfs_read+0x380/0x6b0 fs/read_write.c:452
>   ksys_read fs/read_write.c:578 [inline]
>   __do_sys_read fs/read_write.c:588 [inline]
>   __se_sys_read+0x17a/0x370 fs/read_write.c:586
>   __x64_sys_read+0x4a/0x70 fs/read_write.c:586
>   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x446379
> Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 7b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fcd5b97cda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00000000006dac38 RCX: 0000000000446379
> RDX: 0000000000000184 RSI: 0000000020002180 RDI: 0000000000000003
> RBP: 00000000006dac30 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac3c
> R13: 7073642f7665642f R14: 00800000c0045002 R15: 0000000000000001
>
> Uninit was stored to memory at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
>   kmsan_save_stack mm/kmsan/kmsan.c:267 [inline]
>   kmsan_internal_chain_origin+0x136/0x240 mm/kmsan/kmsan.c:569
>   kmsan_memcpy_origins+0x13d/0x1b0 mm/kmsan/kmsan.c:393
>   __msan_memcpy+0x6f/0x80 mm/kmsan/kmsan_instr.c:242
>   do_convert sound/core/oss/linear.c:48 [inline]
>   convert sound/core/oss/linear.c:81 [inline]
>   linear_transfer+0x74c/0xca0 sound/core/oss/linear.c:110
>   snd_pcm_plug_read_transfer+0x3bf/0x590 sound/core/oss/pcm_plugin.c:659
>   snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1480 [inline]
>   snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1518 [inline]
>   snd_pcm_oss_read+0xe6d/0x1cb0 sound/core/oss/pcm_oss.c:2758
>   __vfs_read+0x1e2/0xb10 fs/read_write.c:416
>   vfs_read+0x380/0x6b0 fs/read_write.c:452
>   ksys_read fs/read_write.c:578 [inline]
>   __do_sys_read fs/read_write.c:588 [inline]
>   __se_sys_read+0x17a/0x370 fs/read_write.c:586
>   __x64_sys_read+0x4a/0x70 fs/read_write.c:586
>   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
>
> Uninit was created at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
>   kmsan_internal_alloc_meta_for_pages+0x155/0x740 mm/kmsan/kmsan.c:689
>   kmsan_alloc_page+0x77/0xe0 mm/kmsan/kmsan_hooks.c:320
>   __alloc_pages_nodemask+0x12cc/0x6640 mm/page_alloc.c:4416
>   alloc_pages_current+0x584/0x7e0 mm/mempolicy.c:2093
>   alloc_pages include/linux/gfp.h:511 [inline]
>   __vmalloc_area_node mm/vmalloc.c:1689 [inline]
>   __vmalloc_node_range+0x879/0x12a0 mm/vmalloc.c:1752
>   __vmalloc_node mm/vmalloc.c:1797 [inline]
>   __vmalloc_node_flags mm/vmalloc.c:1811 [inline]
>   vmalloc+0xd8/0xf0 mm/vmalloc.c:1833
>   snd_pcm_plugin_alloc+0x255/0xc80 sound/core/oss/pcm_plugin.c:71
>   snd_pcm_plug_alloc+0x281/0x600 sound/core/oss/pcm_plugin.c:137
>   snd_pcm_oss_change_params_locked+0x5e40/0x6e30
> sound/core/oss/pcm_oss.c:1039
>   snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1107 [inline]
>   snd_pcm_oss_get_active_substream+0x4f7/0x5a0 sound/core/oss/pcm_oss.c:1=
124
>   snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1774 [inline]
>   snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1766 [inline]
>   snd_pcm_oss_ioctl+0x4adb/0x8860 sound/core/oss/pcm_oss.c:2614
>   do_vfs_ioctl+0xf77/0x2d30 fs/ioctl.c:46
>   ksys_ioctl fs/ioctl.c:702 [inline]
>   __do_sys_ioctl fs/ioctl.c:709 [inline]
>   __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:707
>   __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:707
>   do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I am actually unsure whether this is a true positive or not.
snd_pcm_plugin_alloc() allocates plugin->buf using vmalloc(size) (see
https://elixir.bootlin.com/linux/v4.20-rc1/source/sound/core/oss/pcm_plugin=
.c#L70)
KMSAN doesn't know where this buffer is initialized (any help finding
this out is welcome!), so we mark |size| bytes starting from
plugin->buf as initialized:
https://github.com/google/kmsan/blob/master/sound/core/oss/pcm_plugin.c#L78
But when |size| is not page-aligned vmalloc() still allocates whole
page, and in the report above linear_transfer() appears to run past
|size| bytes and read the tail bytes.
KASAN doesn't detect this bug, because it doesn't handle vmalloc'ed
(and these bytes are addressable anyway).
The reproducer that triggers this bug is attached.
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000021d9a9057a2d364e%40google.com.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

--000000000000571ade057a3803bf
Content-Type: text/x-csrc; charset="US-ASCII"; name="dev_dsp.c"
Content-Disposition: attachment; filename="dev_dsp.c"
Content-Transfer-Encoding: base64
Content-ID: <f_jo9tmq7a0>
X-Attachment-Id: f_jo9tmq7a0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPHN0ZGludC5oPgojaW5j
bHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy90eXBl
cy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+Cgp1aW50NjRfdCBm
ZCA9IC0xOwoKI2RlZmluZSBCVUZfU0laRSAweDE4CnN0YXRpYyB2b2lkIGV4ZWN1dGVfb25lKCkK
ewogIGxvbmcgcmVzOwogIGNoYXIgYnVmW0JVRl9TSVpFXTsKICByZXMgPSBvcGVuYXQoQVRfRkRD
V0QsICIvZGV2L2RzcCIsIDB4ZTAyLCAwKTsKICBpZiAocmVzICE9IC0xKQogICAgZmQgPSByZXM7
CiAgdWludDY0X3QgYXJnID0gMHgxMDAwMDsKICBpb2N0bChmZCwgMHg4MDAwMDBjMDA0NTAwMiwg
JmFyZyk7CiAgdXNsZWVwKDEwMDAwMCk7CiAgcmVhZChmZCwgYnVmLCBCVUZfU0laRSk7Cn0KCmlu
dCBtYWluKHZvaWQpCnsKICBpbnQgcHJvY2lkOwogIGZvciAocHJvY2lkID0gMDsgcHJvY2lkIDwg
NDsgcHJvY2lkKyspIHsKICAgIGlmIChmb3JrKCkgPT0gMCkgewogICAgICBleGVjdXRlX29uZSgp
OwogICAgfQogIH0KICBzbGVlcCgxMDAwMDAwKTsKICByZXR1cm4gMDsKfQo=
--000000000000571ade057a3803bf--
