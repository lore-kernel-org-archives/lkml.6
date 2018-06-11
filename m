Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V1F7OY4NHlsoHwAAmS7hNA
	; Mon, 11 Jun 2018 05:50:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C3CF860791; Mon, 11 Jun 2018 05:50:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D00JzaE+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C5562605A5;
	Mon, 11 Jun 2018 05:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5562605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeFKFuE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 01:50:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32863 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753866AbeFKFuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:50:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so11664849plp.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RXu/bK4SWzQwSBoMmfKrOHsvAv5YDAlr/Ir6D+SL3wE=;
        b=D00JzaE+jiFKHc3essOkZL20NK8Va03GcMX2Pj5TuPYaawhWB/JNsEpdFd1XOuHwCF
         5bTnp95UA1F1qeWxW3uoGP8vnaFk0Hj55lY/xwWTBt8PUSuof2FcP9qOBRPDM7XkOGk8
         yaSQkPQyWnr9oeSy3lWoWRzv5Sq5PahcBV50whWqFLfbsT/1MN+MbdeX28UW2hXED+8s
         TQbofZ94pNqUeihRFK4o4/9yt1AFJp+EeWG/9+ezcPYuZkJbaCFHDE6cWKJv7qectIUy
         OGKYLfnqUUp2ZMmVXmWwV0AcvxHICMOOOifaDXlZCt8n6VsZOndzn5iatH6qQwmngIaN
         Dt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXu/bK4SWzQwSBoMmfKrOHsvAv5YDAlr/Ir6D+SL3wE=;
        b=lKSCJGo3MqSj+s+GbN4zr2eDjFmb3wAMfNfOGLYVtW/wsudj33HbP8+tCDexptz7tZ
         XQ4VspZ0Q+onN+tlx9BedoIzYDfDRlLjHqJb1H23fEUWFFtyT7PyIK6J7uq6RkwQIHC6
         mPaK+5qpUxnJJj8LUV7BPx23eaH3+qMd7BgtTb+FaiS978srXOTifgg8C2AuVqltJ0YS
         paqMFBzS4qlyrzISyzjtznhJ/MgJTJtqRflOQwkMGZDWcP2AVKP6gj5CLbgmop+TPNOa
         SqWM9szKtwPGe2Y6DyFQEmxsYiMlVVMiAiEl32e8jy8mFx+qOwTBHJAZJf8cR8kjc4iW
         Y0Ww==
X-Gm-Message-State: APt69E16TWY5g0ILzhavvfWWjElhhThrdcgpRgllp5iINRy47BCRuVv1
        B80OqWFKS1L8VOO+rpB9XmpVxfUdWtiXw7xYbWQD6w==
X-Google-Smtp-Source: ADUXVKKkgRd0rxCH1foVl0j0vKrHhqc0tAamSihaGwq5uproW0Aw9ES5YhuC8W2rMgHoUiR+8gA/NyrgIMqAuhw59oI=
X-Received: by 2002:a17:902:8491:: with SMTP id c17-v6mr16721670plo.97.1528696201639;
 Sun, 10 Jun 2018 22:50:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Sun, 10 Jun 2018 22:49:41
 -0700 (PDT)
In-Reply-To: <CAJ+HfNh9pRGcd9EO7BEfPPEdCmP5EDdu_rNgLR7r4oDrcLgvQQ@mail.gmail.com>
References: <00000000000092de58056e3d4b96@google.com> <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
 <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
 <CACT4Y+bfZK6yucoDrXPPW3Tc40RYq61u0Zcb=CKtdao8E+v1cQ@mail.gmail.com>
 <13f6777a-2170-d0cc-1066-1b48a27ec981@i-love.sakura.ne.jp> <CAJ+HfNh9pRGcd9EO7BEfPPEdCmP5EDdu_rNgLR7r4oDrcLgvQQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 07:49:41 +0200
Message-ID: <CACT4Y+ZYNjPTkDZxCranM9X1C3yB4GSy8qQd=U0NoeHiJtmV-w@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 3:03 PM, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.c=
om> wrote:
>> On 2018/06/10 20:52, Dmitry Vyukov wrote:
>> > On Sun, Jun 10, 2018 at 11:31 AM, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@g=
mail.com> wrote:
>> >> Den s=C3=B6n 10 juni 2018 kl 04:53 skrev Tetsuo Handa
>> >> <penguin-kernel@i-love.sakura.ne.jp>:
>> >>>
>> >>> On 2018/06/10 7:47, syzbot wrote:
>> >>>> Hello,
>> >>>>
>> >>>> syzbot found the following crash on:
>> >>>>
>> >>>> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git:=
//git.k..
>> >>>> git tree:       upstream
>> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1073f68=
f800000
>> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df04d8d0=
a2afb789a
>> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4abadc5d6=
9117b346506
>> >>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=3D13c97=
56f800000
>> >>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16366f9=
f800000
>> >>>>
>> >>>> IMPORTANT: if you fix the bug, please add the following tag to the =
commit:
>> >>>> Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
>> >>>>
>> >>>> random: sshd: uninitialized urandom read (32 bytes read)
>> >>>> random: sshd: uninitialized urandom read (32 bytes read)
>> >>>> random: sshd: uninitialized urandom read (32 bytes read)
>> >>>> random: sshd: uninitialized urandom read (32 bytes read)
>> >>>> random: sshd: uninitialized urandom read (32 bytes read)
>> >>>> WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56=
/0x70 mm/slab_common.c:996
>> >>>> Kernel panic - not syncing: panic_on_warn set ...
>> >>>
>> >>> syzbot gave up upon kmalloc(), but actually error handling path has
>> >>> NULL pointer dereference bug.
>> >>>
>> >>
>> >> Thanks Tetsuo! This crash has been fixed by Daniel Borkmann in commit
>> >> c09290c56376 ("bpf, xdp: fix crash in xdp_umem_unaccount_pages").
>> >
>> > Let's tell syzbot about this:
>> >
>> > #syz fix: bpf, xdp: fix crash in xdp_umem_unaccount_pages
>> >
>> >
>> Excuse me, but that patch fixes NULL pointer dereference which occurs af=
ter kmalloc()'s
>> "WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x7=
0 mm/slab_common.c:996"
>> message. That is, "Too large memory allocation" itself is not yet fixed.
>
> The code relies on that the sl{u,a,o}b layer says no, and the
> setsockopt bails out. The warning could be opted out using
> __GFP_NOWARN. Is there another preferred way? Two get_user_pages
> calls, where the first call would set pages to NULL just to fault the
> region? Walk the process' VMAs? Something else?

Hi Bj=C3=B6rn,

Yes, either __GFP_NOWARN for allocations with user-controllable size
or stricter custom limit (if we don't want current sla/u/ob
implementation details to be part of public kernel interface).
