Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NvCgMlAfHVsDVwAAmS7hNA
	; Sun, 10 Jun 2018 13:03:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52E7F607E7; Sun, 10 Jun 2018 13:03:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZXBGiDZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A871B605A5;
	Sun, 10 Jun 2018 13:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A871B605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbeFJNDa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 09:03:30 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41460 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeFJND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 09:03:28 -0400
Received: by mail-qk0-f195.google.com with SMTP id w23-v6so11482387qkb.8;
        Sun, 10 Jun 2018 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A9U9Snzm2We4BuSvUXwdjryNGkskR4omDNWMB6raU7c=;
        b=LZXBGiDZM94GYOp2dRLM7YXqTBYhBurRXI8utQd2zDZxx0EgkVnQ1zc4l4KI6aWhZ8
         mZW8euXWuayGIE5mgCE2thZ/HP7PCNnkqNJ/liVmETHe06kNPMpZz+Gb+GfRQcW1T5D/
         1Sa/BzTLTZIf0Gc75oCBCW5vlFjeiIYpR7WDyqp9ljK38t8qodiL51TtOR4ZE/6dliEr
         Ru2tU0QK7M0hG43xe8cqlKEKLEXaWSXMWLNOHSFeA2p3YNo2EgH3kxYFN6yMcLAztVC9
         3vzRBPElnwFsD7SqOGvJ1L2tJEtRurhdWrqfkQXSHAluiLhf6yR9Pj6LOjOiNmhI15fo
         XIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A9U9Snzm2We4BuSvUXwdjryNGkskR4omDNWMB6raU7c=;
        b=Dg5IW4K33MaHd/b8fdXtD4UP9RwtH8MBWRKjEEuut6ADkl8gaJt/6kvpJtZ5X+eBNF
         CV2acQg6AaL6Lw7WjzZuZ0yTLHateGg/OKeAMWqE7kGj4IrSRDimX2kq+2Jl5jFJ9IWk
         o0ci0SsPcQWPtL45HnjxUGxawY3P3Xq3sTz95WVNzy/JaGBvy67ojJC2y8ckPqr5/WJ/
         OMbRCLUc+yhFik+gToOdpAMZGW1dikRmt6ItiFjIOmoEvF2pEB1MJAOZqWx9l6aB+34k
         z94ZZ82ynbWEpphB5oViNZBUzzICrPiOUfEUyOGqfs97T4XmSbN+NYegJz3mAuowrqN+
         KP2Q==
X-Gm-Message-State: APt69E25dRKNSXvtkarfKoTbYRhCjaHay8/DrcwI1UYdLHAFL0t5kC17
        ILbl+QbP5nyh+dhrw5H8WSCJW0drNTQCO2uXdZg=
X-Google-Smtp-Source: ADUXVKLTjKSD2eJr0sxUiD0gKKGUqctD0svqoI/xS75AdzbbFjeZB+2rVwanK/pULCnduXI6VdMM15HHQa75NJbgTWo=
X-Received: by 2002:a37:7b86:: with SMTP id w128-v6mr10817964qkc.123.1528635807992;
 Sun, 10 Jun 2018 06:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000092de58056e3d4b96@google.com> <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
 <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
 <CACT4Y+bfZK6yucoDrXPPW3Tc40RYq61u0Zcb=CKtdao8E+v1cQ@mail.gmail.com> <13f6777a-2170-d0cc-1066-1b48a27ec981@i-love.sakura.ne.jp>
In-Reply-To: <13f6777a-2170-d0cc-1066-1b48a27ec981@i-love.sakura.ne.jp>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date: Sun, 10 Jun 2018 15:03:14 +0200
Message-ID: <CAJ+HfNh9pRGcd9EO7BEfPPEdCmP5EDdu_rNgLR7r4oDrcLgvQQ@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To: penguin-kernel@i-love.sakura.ne.jp
Cc: dvyukov@google.com,
        syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den s=C3=B6n 10 juni 2018 kl 14:53 skrev Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp>:
>
> On 2018/06/10 20:52, Dmitry Vyukov wrote:
> > On Sun, Jun 10, 2018 at 11:31 AM, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gm=
ail.com> wrote:
> >> Den s=C3=B6n 10 juni 2018 kl 04:53 skrev Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp>:
> >>>
> >>> On 2018/06/10 7:47, syzbot wrote:
> >>>> Hello,
> >>>>
> >>>> syzbot found the following crash on:
> >>>>
> >>>> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git:/=
/git.k..
> >>>> git tree:       upstream
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1073f68f=
800000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df04d8d0a=
2afb789a
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4abadc5d69=
117b346506
> >>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=3D13c975=
6f800000
> >>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16366f9f=
800000
> >>>>
> >>>> IMPORTANT: if you fix the bug, please add the following tag to the c=
ommit:
> >>>> Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
> >>>>
> >>>> random: sshd: uninitialized urandom read (32 bytes read)
> >>>> random: sshd: uninitialized urandom read (32 bytes read)
> >>>> random: sshd: uninitialized urandom read (32 bytes read)
> >>>> random: sshd: uninitialized urandom read (32 bytes read)
> >>>> random: sshd: uninitialized urandom read (32 bytes read)
> >>>> WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/=
0x70 mm/slab_common.c:996
> >>>> Kernel panic - not syncing: panic_on_warn set ...
> >>>
> >>> syzbot gave up upon kmalloc(), but actually error handling path has
> >>> NULL pointer dereference bug.
> >>>
> >>
> >> Thanks Tetsuo! This crash has been fixed by Daniel Borkmann in commit
> >> c09290c56376 ("bpf, xdp: fix crash in xdp_umem_unaccount_pages").
> >
> > Let's tell syzbot about this:
> >
> > #syz fix: bpf, xdp: fix crash in xdp_umem_unaccount_pages
> >
> >
> Excuse me, but that patch fixes NULL pointer dereference which occurs aft=
er kmalloc()'s
> "WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70=
 mm/slab_common.c:996"
> message. That is, "Too large memory allocation" itself is not yet fixed.

The code relies on that the sl{u,a,o}b layer says no, and the
setsockopt bails out. The warning could be opted out using
__GFP_NOWARN. Is there another preferred way? Two get_user_pages
calls, where the first call would set pages to NULL just to fault the
region? Walk the process' VMAs? Something else?


Bj=C3=B6rn
