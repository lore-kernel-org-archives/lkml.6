Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF72C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4D20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DB1bypTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA4D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeICSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:02:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38760 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeICSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:02:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id f4-v6so245663pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XsypVM3ypYNF470j5bucwV/rFLG8iMRDh+P0uxK3k+k=;
        b=DB1bypTP4rsN2D79cSPrt5nEiDuzlAGP7U1iLwBVjp0pR5nDevnKgevGralqNwyS/3
         kySHyHgzq5ij/43yjgHhwCjW4BpPk0QrdOvIMnztwY6bAszitqd5RohayPkNULBMJaNc
         m+g11RhYZQi4mKIROpsIBz5UUyvfaoa1gpNOHGcjpt/lKAEjtAzn1s3bbQu43pSKpkrR
         LtjZf6yANnY6F70QVG53HbRIKujBzf4Q9vb0x6sinwYKSaKebhi4xsOzVuQJMh/qpur6
         e0CtxQl8oNshl5kmrPauMIJ7vbYShELHBQH2lsPmjE95X7YQlzW0GvVw28vmcs1KFIWO
         w85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XsypVM3ypYNF470j5bucwV/rFLG8iMRDh+P0uxK3k+k=;
        b=ldfIqa166NT2EzxJA9wzh1qjg0p3hNF4YH6wbw8nI1d+APg1SEZ5o8rjoQNSFDQrUk
         M3Kpnz6JTUCqAMkoUfXAd/w0ZzYrzTnDPg8MdKln7O8+uQX1Cm7MSv71AIKFUS/+4+DL
         kbv5rp/OGKqdlAzmsbbFFyXD30wyLfV28nvXzn2Zx/Xr4/lE/JN4KSv32CR4AO7spP3I
         L2zXdAQgXBPNADFrJxUCLLsoGJqlIVxBKxoTY3VV3QWgtTXij3Q8X+B+2uibbswNLytk
         qObBMyXRkIKC0JopyMLGa56TVyiKJKBP20qr340VmZALz7daIsDhY545GOYGbpnmdhV1
         naJQ==
X-Gm-Message-State: APzg51AbbnOjASpdA8B38iekdaIgZ4M1HBzGyqPBEhylBMjb7nREmKiD
        86g6gZT2bLIYEF6hki8ZmwDtWSqxZfF6kOttIP+/5A==
X-Google-Smtp-Source: ANB0VdZM1BIU/PQJoUQM3Hm+wtUkGPyRGv9EPIc70UrBsbs4TerLKdkbyn1VRxlwqN0S3AiuQknY5JeJ7Vbqxp3ex8A=
X-Received: by 2002:a63:6501:: with SMTP id z1-v6mr11550549pgb.419.1535982117444;
 Mon, 03 Sep 2018 06:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 3 Sep 2018 06:41:36
 -0700 (PDT)
In-Reply-To: <s5h4lf6hfcq.wl-tiwai@suse.de>
References: <s5ha7oyhg0v.wl-tiwai@suse.de> <000000000000a25ae50574f76ff0@google.com>
 <s5h7ek2hfp6.wl-tiwai@suse.de> <CACT4Y+bJM4dfx_2_qwPLOYdU_snGv7Zhhu3g_sHuzUM3sjnZQQ@mail.gmail.com>
 <s5h4lf6hfcq.wl-tiwai@suse.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Sep 2018 15:41:36 +0200
Message-ID: <CACT4Y+ZjXmdTb552cEOYdhz4PVOHdS39q7ynW_3uz=STvVmr5w@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in snd_midi_event_encode_byte
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com>,
        alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 3:37 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 03 Sep 2018 15:33:12 +0200,
> Dmitry Vyukov wrote:
>>
>> On Mon, Sep 3, 2018 at 3:29 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Mon, 03 Sep 2018 15:22:42 +0200,
>> > syzbot wrote:
>> >>
>> >> > On Mon, 03 Sep 2018 03:53:03 +0200,
>> >> > syzbot wrote:
>> >>
>> >> >> syzbot has found a reproducer for the following crash on:
>> >>
>> >> >> HEAD commit:    28f0ca98eadf kmsan: don't instrument
>> >> >> do_syscall_64() and  _..
>> >> >> git tree:       https://github.com/google/kmsan.git/master
>> >> >> console output: https://syzkaller.appspot.com/x/log.txt?x=10556c92400000
>> >> >> kernel config:
>> >> >> https://syzkaller.appspot.com/x/.config?x=3431f03869413153
>> >> >> dashboard link:
>> >> >> https://syzkaller.appspot.com/bug?extid=194dffdb8b22fc5d207a
>> >> >> compiler:       clang version 8.0.0 (trunk 339414)
>> >> >> syz repro:
>> >> >> https://syzkaller.appspot.com/x/repro.syz?x=123a520a400000
>> >> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16068dc1400000
>> >>
>> >> >> IMPORTANT: if you fix the bug, please add the following tag to the
>> >> >> commit:
>> >> >> Reported-by: syzbot+194dffdb8b22fc5d207a@syzkaller.appspotmail.com
>> >>
>> >> >> ==================================================================
>> >> >> BUG: KMSAN: uninit-value in snd_midi_event_encode_byte+0x569/0xff0
>> >> >> sound/core/seq/seq_midi_event.c:195
>> >> >> CPU: 1 PID: 1659 Comm: kworker/1:1H Not tainted 4.19.0-rc1+ #40
>> >> >> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> >> >> BIOS  Google 01/01/2011
>> >> >> Workqueue: events_highpri snd_vmidi_output_work
>> >> >> Call Trace:
>> >> >>   __dump_stack lib/dump_stack.c:77 [inline]
>> >> >>   dump_stack+0x14b/0x190 lib/dump_stack.c:113
>> >> >>   kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
>> >> >>   __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
>> >> >>   snd_midi_event_encode_byte+0x569/0xff0
>> >> >> sound/core/seq/seq_midi_event.c:195
>> >> >>   snd_vmidi_output_work+0x34e/0x5b0 sound/core/seq/seq_virmidi.c:161
>> >> >>   process_one_work+0x1605/0x1f40 kernel/workqueue.c:2153
>> >> >>   worker_thread+0x11a2/0x2590 kernel/workqueue.c:2296
>> >> >>   kthread+0x465/0x4a0 kernel/kthread.c:247
>> >> >>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416
>> >>
>> >> >> Uninit was stored to memory at:
>> >> >>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
>> >> >>   kmsan_save_stack mm/kmsan/kmsan.c:271 [inline]
>> >> >>   kmsan_internal_chain_origin+0x128/0x210 mm/kmsan/kmsan.c:573
>> >> >>   __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:482
>> >> >>   __snd_rawmidi_transmit_peek sound/core/rawmidi.c:1103 [inline]
>> >> >>   snd_rawmidi_transmit+0xa75/0xbf0 sound/core/rawmidi.c:1228
>> >> >>   snd_vmidi_output_work+0x2ac/0x5b0 sound/core/seq/seq_virmidi.c:159
>> >> >>   process_one_work+0x1605/0x1f40 kernel/workqueue.c:2153
>> >> >>   worker_thread+0x11a2/0x2590 kernel/workqueue.c:2296
>> >> >>   kthread+0x465/0x4a0 kernel/kthread.c:247
>> >> >>   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416
>> >>
>> >> >> Uninit was created at:
>> >> >>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
>> >> >>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
>> >> >>   kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
>> >> >>   __kmalloc_node+0x7bf/0x11c0 mm/slub.c:3828
>> >> >>   kmalloc_node include/linux/slab.h:555 [inline]
>> >> >>   kvmalloc_node+0x19d/0x3e0 mm/util.c:423
>> >> >>   kvmalloc include/linux/mm.h:577 [inline]
>> >> >>   snd_rawmidi_runtime_create sound/core/rawmidi.c:132 [inline]
>> >> >>   open_substream+0x3c8/0xaa0 sound/core/rawmidi.c:276
>> >> >>   rawmidi_open_priv+0x347/0x1000 sound/core/rawmidi.c:327
>> >> >>   snd_rawmidi_open+0x7d4/0x1120 sound/core/rawmidi.c:424
>> >> >>   soundcore_open+0x9be/0xa60 sound/sound_core.c:597
>> >> >>   chrdev_open+0xc26/0xdb0 fs/char_dev.c:417
>> >> >>   do_dentry_open+0xce6/0x1740 fs/open.c:771
>> >> >>   vfs_open+0xaf/0xe0 fs/open.c:880
>> >> >>   do_last fs/namei.c:3418 [inline]
>> >> >>   path_openat+0x1799/0x6870 fs/namei.c:3534
>> >> >>   do_filp_open+0x259/0x610 fs/namei.c:3564
>> >> >>   do_sys_open+0x630/0x940 fs/open.c:1063
>> >> >>   __do_sys_open fs/open.c:1081 [inline]
>> >> >>   __se_sys_open+0xad/0xc0 fs/open.c:1076
>> >> >>   __x64_sys_open+0x4a/0x70 fs/open.c:1076
>> >> >>   do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
>> >> >>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
>> >> >> ==================================================================
>> >>
>> >> > This looks like some small race at virmidi reading and the buffer
>> >> > handling, which should be almost harmless by itself.
>> >> > Nevertheless, the fix should be easy, just replacing kvmalloc() with
>> >> > kvzalloc(), as below.
>> >>
>> >> > Let's check whether this works.
>> >>
>> >> > #syz test:
>> >> > git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>> >> > topic/rawmidi-fixes
>> >>
>> >> KMSAN bugs can only be tested on https://github.com/google/kmsan.git tree
>> >> because KMSAN tool is not upstreamed yet.
>> >> See
>> >> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs
>> >> for details.
>> >
>> > So how is the procedure to test a patch for bugs spotted by KMSAN?
>> >
>> > In this case, the fix is trivial, so I can put it to my tree for the
>> > next pull request.  Of course, it'd be better if it can be confirmed
>> > to work beforehand...
>>
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs
>>
>> Which means you need to attach a patch because it's not in that tree.
>
> OK, it would have been helpful if the description there was more clear
> :)
>
> And no automated way for that?

What exactly do you mean? Please elaborate.

> I mean, I already attached patch in
> the previous reply (together with syz-magic command to point the git
> branch URL).  Do I need anything else?

Just issue the command against "https://github.com/google/kmsan.git
master" and attach the patch.
