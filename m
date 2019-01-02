Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2C1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2656206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkd+kiC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfABLYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:24:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33365 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfABLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:24:20 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so38591890itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ii3sL5q34fQiXrzTs3grgYrgvEUImYFe1IT0jv6/kY=;
        b=qkd+kiC+ItWvKXPDGgepExeB/cNlaTlVx+ZcAhIgcfvzKu/GkZCUqyWwjJgMXrDD9J
         nXvNngQSpzaAP1U84ESzdbH9Rqi55M9Z0AGWNnPy812KECPUXQIuu7DXVq+5l49wSUSy
         b+aqSOujUlpQ9GUqZ6WzaPPF/HVNzRbwgKchbVzELIyl+XNBhSNsr1zgvc/7qpQNu/SQ
         /+uFqRIcrhJqXNDm4EdVE/Rvnl2UiwxmTiIHb0fc0deRj7QmhHG6HLaWY9JAmdVI7UUG
         LHErotLEYhFNQ4nHuJb3EWtm/qKrLInYa5yvtP0pAAOvoG31UFOiMP/Jh5VUslX6TVOP
         zd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ii3sL5q34fQiXrzTs3grgYrgvEUImYFe1IT0jv6/kY=;
        b=gpdFU3Zo/kMt2bkqLIAbHl9cHAnkp/KPl0UtwpGHB6CDhQSuhXQMX8DkJMjmkwVO4H
         n4e1Okg/u7CdBTCoHs7vRRtlPK0T4eDHObQKimv6l1vi+64OUk7r9FNEKQjuV1iOxQoo
         JjES/P0V/Y+rsKjvtz6afL9FfJjFqNLKOMHYraqkDGvZ5Ge0OUNl8wnvUlhvcM+6RC+P
         PDx8CoWrFV+AiGj6DDZkVvbXCZRy6jVE/vg7Ooy5dpSrdyoPUh0QNPfN5exi30L8qXaM
         6V44rHR7Hw6YuYNC3x9O+D/hh8+er57Axu+3HchT57y9A6Co259aHzHj3GGQYUmYo3S9
         v4Sg==
X-Gm-Message-State: AA+aEWYYEs7+X1Pdn9Kf27tIEYIfkAiXf53LjjH4FNuFCqxa+kmxTgpU
        QOHnnD+9H8cg/os82IgA66O4Ju4HwE260mz7lgR8Pg==
X-Google-Smtp-Source: AFSGD/Xb3WPz+00cVnQaG5EomMr/jdDM191xiEJCBg/YyGMZYHlrZCyJMFEWJXi38znBdxz+NYeDmUrw/7pUO3wWtsM=
X-Received: by 2002:a02:8904:: with SMTP id o4mr28048501jaj.35.1546428258820;
 Wed, 02 Jan 2019 03:24:18 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c2c4b9057e7788d1@google.com>
In-Reply-To: <000000000000c2c4b9057e7788d1@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 12:24:07 +0100
Message-ID: <CACT4Y+aJSrvgdRGG6eQ3Xi_JqtHo56k5Gx7Qnt3mFf+mFneR=g@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space! (3)
To:     syzbot <syzbot+42e36e1ae3de3f22a7ed@syzkaller.appspotmail.com>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 11:59 AM syzbot
<syzbot+42e36e1ae3de3f22a7ed@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    903b77c63167 Merge tag 'linux-kselftest-4.21-rc1' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1424673b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=53a2f2aa0b1f7606
> dashboard link: https://syzkaller.appspot.com/bug?extid=42e36e1ae3de3f22a7ed
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1453eabf400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a492bf400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+42e36e1ae3de3f22a7ed@syzkaller.appspotmail.com

#syz dup: WARNING: lock held when returning to user space in set_property_atomic

> RBP: 00000000006cf018 R08: 0000000000000001 R09: 0000000000000032
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
>
> ================================================
> WARNING: lock held when returning to user space!
> 4.20.0+ #395 Not tainted
> ------------------------------------------------
> syz-executor520/8085 is leaving the kernel with locks still held!
>
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
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c2c4b9057e7788d1%40google.com.
> For more options, visit https://groups.google.com/d/optout.
