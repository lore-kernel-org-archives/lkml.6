Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D5420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ravfEcEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAOH0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:26:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40901 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfAOH0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:26:03 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so3089647ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 23:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJlg7UDv823W51FZR5L9hQOxxuEOpYTa3DBA12ck1aU=;
        b=ravfEcEVjc1PWtNHe5JFNQpvrDPHkP7/913XlgPu4Lo65Qpi7M4y+0Hx3zbCAuRd5c
         gljum53+MwHk9zKIYmQK0HswGkN2GpeEbz6rtYRyXOW49f7BvDuoKRsDFYhoqCCmtwH/
         YYuAwOpTXEt1nJhXZJEQu7XFyvXtBLPXhEiRDtXbIEFlQaNDt5glkBT1a6GqwWyV7SFf
         4f8/u4z1IHe9LslaLQZtxWuToviE2IWbrktRxtDs47zq8oEqrcYq5jxsm0uKuFA5dL7z
         zrA8b2uoDFGiTEIXhQHFNSGSXgYtyscjVtrFuhLiehdFZTbyrpSbIyi+Y3SFhvdDWOTD
         qs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJlg7UDv823W51FZR5L9hQOxxuEOpYTa3DBA12ck1aU=;
        b=qdqwi/0L2iHCGs534/oskluWxn9KtVTG0GlMBSN5B1J1uQsTuxRCR4mM9TDxhf0DSz
         KmEAu+avzpCUIJjufGQKJ3I6ZACxiYDx+G2Vf9ntiCQ7+k89hv48O330PHFO6hupvUO+
         NJNgajSs13RWl/F/rlKk2AlOj2XSLXX3LfPcKryLEP+v5wgP18TkXLjoxVdiUwloe4fn
         BP9606RINPYi67R0MhTPEqtvz5YF+VjE5G7Kr0rUk8i7Kptfx8E1xj0JQYtUpZy9a3wx
         OeJIpB24dBwPRU09G2oYgNRstjXDNHsg6FFYKa2Pj8UDzjrE282FtBgMnuP7HTo2ndqX
         HpKg==
X-Gm-Message-State: AJcUukeOYNTseV1qB0VKEpkzAY+01I/47cNWWxcNlEYKeE7kAuK3KbKa
        Au6ZMKu7aXJc9PyBxC3Zba+0Kbvgff7oZ7ao25D0gg==
X-Google-Smtp-Source: ALg8bN6YwqPFj4vZ8gQa/IMFGLXOomw5FoQoxDAjYLZwlX4XMCYOudW9/yWBmkcSKEQtLmarYinnVvK17onysjZsjuk=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr1237735jan.72.1547537162534;
 Mon, 14 Jan 2019 23:26:02 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f49537057f77cb00@google.com>
In-Reply-To: <000000000000f49537057f77cb00@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Jan 2019 08:25:51 +0100
Message-ID: <CACT4Y+Zj0h69KdTKD8N7bcpJF4AMyDK0WGEQ8uueL5Nf3DC1YQ@mail.gmail.com>
Subject: Re: KASAN: use-after-scope Read in corrupted
To:     syzbot <syzbot+bd36b7dd9330f67037ab@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:43 AM syzbot
<syzbot+bd36b7dd9330f67037ab@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1bdbe2274920 Merge tag 'vfio-v5.0-rc2' of git://github.co=
m..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1519d39f40000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dedf1c3031097c=
304
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbd36b7dd9330f67=
037ab
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10fce14f400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D110b201740000=
0

Based on the reproducer this is:

#syz dup: kernel panic: stack is corrupted in udp4_lib_lookup2


> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+bd36b7dd9330f67037ab@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-scope in debug_lockdep_rcu_enabled.part.0+0x50/0x60
> kernel/rcu/update.c:249
> Read of size 4 at addr ffff8880a945eabc by task
> `9=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD#=EF=BF=BD(  =EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD<=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD  k=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDE=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD>9h=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDA/-2122188634
>
> CPU: 0 PID: -2122188634 Comm: =EF=BF=BD=EF=BF=BDE=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BDO2=EF=BF=BD Not tainted 5.0.0-rc1+
> #19
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> ------------[ cut here ]------------
> Bad or missing usercopy whitelist? Kernel memory overwrite attempt detect=
ed
> to SLAB object 'task_struct' (offset 1344, size 8)!
> WARNING: CPU: 0 PID: -1455036288 at mm/usercopy.c:78
> usercopy_warn+0xeb/0x110 mm/usercopy.c:78
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: -1455036288 Comm: =EF=BF=BD=EF=BF=BDE=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BDO2=EF=BF=BD Not tainted 5.0.0-rc1+
> #19
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000f49537057f77cb00%40google.com.
> For more options, visit https://groups.google.com/d/optout.
