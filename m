Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD38CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2828E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GK2Bm0ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2828E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbeGRNmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:42:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42116 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeGRNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:42:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so246937plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZHAAccBlISS2hXHEB9QIVnh9K3rzjM6gV9VSn5ePmhk=;
        b=GK2Bm0kaSW9YugQyaIV7LxvOHd3ntaRmHJdvCzfJ/ljwAWw+qXwcPyV2VBEZK3fbl2
         5QLCatiBKziA5MeoDUBV+SVlgw8gwewRdDBhBMetOFIbhbwzGYBhRgJ1zEHWSq0NSqWg
         Zgo0NU4NG5jUBtdVDY2BxAC/CjE4FAobC7/Xul8QxqOFpnjUctCpr1cRU+xnsgXgn8lA
         xhE0xkBcDVS+/CP71evT7+9+eVKzEFHXkfRb9KGAqgSl97thy5z+rDScVUi6D4Qe2Zb8
         6AV55VZR4taUBiihruhhmKaFseM5II7pXPrIiI5GkH1f6f8tOHSCV5uCXPdoKXNNwLo3
         2gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZHAAccBlISS2hXHEB9QIVnh9K3rzjM6gV9VSn5ePmhk=;
        b=JWH/rXss3FFeImvQeFKo0/1DwlqaTolpEz4L5kS9uqvG82EK6SMKArx/UzjvH5B8fU
         WnZPTLAsOjcoxllxlybVrggF2pmnmjXB4R9AVbI3XnaOFsrjeeKXX7xNuLeA2gtHbviH
         wBGvB/3MADR64O1K78ojPtXAzRzMjz7cv+InlqgFDXcE2RKXWAVhMz6vo4k0mYc3tcaF
         Zzcb/p7MsEIu9V0rmXneSFKC4//QNzGXQ4qsQTqsvuoItgUfOqLD0WDSzu+bWGc2Pyav
         NScR4DkVWlGlm8XDk33shvg54FKA/e1zGchSY46RyCV15Hcn4llgH61Lh/+qzu2NCofS
         bRvQ==
X-Gm-Message-State: AOUpUlGsfTdN4yLtg/GrnPmMsxQ/YNE8l7bauSMG5aR0B17DMmRCS672
        CubyrKY1rdVbblpAznJqomfcFvIA/qhuoN/9eDtBSQ==
X-Google-Smtp-Source: AAOMgpf4WhV1in2Uu/OiyozbhqVcweijoe8TIT4RW3c7uj2Ob7LvVetCgWpUfAcsa5sgL5xnffIdhfWP7l8aPFyT+a0=
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr5746375plr.264.1531919101110;
 Wed, 18 Jul 2018 06:05:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 06:04:40
 -0700 (PDT)
In-Reply-To: <0adc592b-d4a3-f6da-3c5c-22490f641eb9@i-love.sakura.ne.jp>
References: <0000000000002f5541057143a85e@google.com> <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
 <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
 <CACT4Y+bM1tfisT+7=ZChHRZKZkddbWp0kNi5q46EqOYBSptXtg@mail.gmail.com> <0adc592b-d4a3-f6da-3c5c-22490f641eb9@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 15:04:40 +0200
Message-ID: <CACT4Y+YqDFNrdtk+aet9UVBxyvxs+O85YLnMYL3FvoPckBx-Mg@mail.gmail.com>
Subject: Re: INFO: task hung in grab_super
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:53 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/07/18 20:41, Dmitry Vyukov wrote:
>> This seems to be related to 9p. After rerunning the log I got:
>>
>> root@syzkaller:~# ps afxu | grep syz
>> root     18253  0.0  0.0      0     0 ttyS0    Zl   10:16   0:00  \_
>> [syz-executor] <defunct>
>> root@syzkaller:~# cat /proc/18253/task/*/stack
>> [<0>] p9_client_rpc+0x3a2/0x1400
>> [<0>] p9_client_flush+0x134/0x2a0
>> [<0>] p9_client_rpc+0x122c/0x1400
>> [<0>] p9_client_create+0xc56/0x16af
>> [<0>] v9fs_session_init+0x21a/0x1a80
>> [<0>] v9fs_mount+0x7c/0x900
>> [<0>] mount_fs+0xae/0x328
>> [<0>] vfs_kern_mount.part.34+0xdc/0x4e0
>> [<0>] do_mount+0x581/0x30e0
>> [<0>] ksys_mount+0x12d/0x140
>> [<0>] __x64_sys_mount+0xbe/0x150
>> [<0>] do_syscall_64+0x1b9/0x820
>> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [<0>] 0xffffffffffffffff
>>
>> There is a bunch of hangs in 9p, so let's do:
>>
>> #syz dup: INFO: task hung in flush_work
>>
> Then, is dumping all threads when khungtaskd fires a candidate
> for CONFIG_DEBUG_AID_FOR_SYZBOT=y path?

Perhaps would be useful. But maybe only tasks that are blocked for
more than timeout/2? and/or unkillable tasks? killable tasks are not a
problem.

Btw, I see that p9_client_rpc uses wait_event_killable, why wasn't it
killed along with the whole process?
