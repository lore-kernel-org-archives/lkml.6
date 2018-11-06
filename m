Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ED4C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FF32086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QD3UiXEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FF32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbeKGB7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:59:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40738 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388925AbeKGB7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:59:10 -0500
Received: by mail-io1-f66.google.com with SMTP id a23-v6so9689638iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T8H4MQ6/Kj94BJWrsGKrfoTtHY8YNEd5V2bJ3Nrt7EU=;
        b=QD3UiXEvcc4ksRQ1BWjStAQ9sHv77Rk/9dz6WJU26Ok9YCkyIodRNZwM3Tm4Ln2z9N
         Ir7O5sD2uJP4vDXeA8CYGsETGLtN2NtYq+H6N3VSUgMnNWQ9grNKlI6RHZxcRoJBmsxG
         lDrr8FL91v49zwdmk7jcEeKRfdodT0i4y6CmIBrdlo0qi9/d2pkI2MtnUdBwgeJCnJD8
         tbjT4XCpemLy/HjM4iU7Isi1QjYAmDNt7KFQnub3ZZGdTTnkB1ykhBWX3XQ03XRymUVS
         WHEPbED2bjRKlQwDa/iMnxhQGsBUlMPYF9roxwo/flJ9sgZsh4xMmRqP5i4J+9d/l+to
         4Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T8H4MQ6/Kj94BJWrsGKrfoTtHY8YNEd5V2bJ3Nrt7EU=;
        b=IBd7lBQ7qGbcIOoOcAbZ1crTwuKzaPgwK53494+CzCNxIhrrJ3UAxldKu7LH1wQl9L
         ZLhdH1Q2UMJDdpBfQlNcD9xA7jKxNIp/kEIBdPpr3AJ2clPA2b7D81pEaZP6zZvA7c6l
         0ZZUqJ1YsYd2UfMEOis+M2prTbgzMmckLVTNAGExf8eX/Qa+b7Yi9xq/RucPiAvIGWXF
         axG3AJ5H/ruu5moMkxYTaXqhPTzLZV7aJUsDWKGY1sJs8xvLnGEDouFrUx2QTrUQlpqf
         A/9lxLk2nqo+knR0hdTm/qDuebWqr+hSnibFLloGgdIuZI8WS2TeUxp4IcrQIFaCMIKz
         HSfw==
X-Gm-Message-State: AGRZ1gJ+DF/Q/rvvSJ9t1JRKboOQtwEwAv47JTzkbJSlyZast/AaIkCC
        ewS7glv6m1Zrh3isz+ltWMukdNweRrh0ubYlYp4nKUODDhLIAw==
X-Google-Smtp-Source: AJdET5fjwuc40zW+y9LZkoEfxImrVACAODQUTU+cLGCmcBBgXwclt5gChvfj07zi/JyT4avDNKDA5JN4C3soq13FxXg=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr18917509iod.282.1541521988733;
 Tue, 06 Nov 2018 08:33:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 08:32:48 -0800 (PST)
In-Reply-To: <CAJfpegtGz2Z4c4mGE+LMC9ZoEQd9wJtL=segqrFo72-g4MdAig@mail.gmail.com>
References: <000000000000c25cca0579982a05@google.com> <CACT4Y+YLFp4OXRyroL8coE5Mw6yMdbajKPeu8kzkHunVGypx0Q@mail.gmail.com>
 <CAJfpegsNzxc3c=ojjYHgdiKiHXXutOkKCUAO131cifwKyLhqOg@mail.gmail.com> <CAJfpegtGz2Z4c4mGE+LMC9ZoEQd9wJtL=segqrFo72-g4MdAig@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 6 Nov 2018 08:32:48 -0800
Message-ID: <CACT4Y+bck9DxYrq89waGAqAyYhk6+nrFg8k99KUiyzJQ=+UdCA@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_sb_destroy
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:03 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Mon, Nov 5, 2018 at 11:40 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Thu, Nov 1, 2018 at 12:05 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Thu, Nov 1, 2018 at 11:49 AM, syzbot
>>> <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com> wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    59fc453b21f7 Merge branch 'akpm' (patches from Andrew)
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15fb2447400000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea045471e4c756e8
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=6339eda9cb4ebbc4c37b
>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178a105d400000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16651133400000
>>>
>>>
>>> I can easily reproduce this.
>>
>> I can't reproduce on my meager dual core notebook.
>>
>>>
>>> The repro gives me a task hanged at:
>>>
>>> # cat /proc/7563/task/*/stack
>>> [<0>] fuse_wait_aborted+0x20b/0x320
>>> [<0>] fuse_sb_destroy+0xe2/0x1d0
>>> [<0>] fuse_kill_sb_anon+0x15/0x20
>>> [<0>] deactivate_locked_super+0x97/0x100
>>> [<0>] deactivate_super+0x2bb/0x320
>>> [<0>] cleanup_mnt+0xbf/0x160
>>> [<0>] __cleanup_mnt+0x16/0x20
>>> [<0>] task_work_run+0x1e8/0x2a0
>>> [<0>] exit_to_usermode_loop+0x318/0x380
>>> [<0>] do_syscall_64+0x6be/0x820
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> [<0>] 0xffffffffffffffff
>>>
>>> I double checked that writing to /sys/fs/fuse/connections/44/abort did
>>> not help (the only entry in fuse/connections). Wrote multiple times,
>>> and tried to kill the task, nothing helps.
>>
>> What's the output of
>>
>> cat /sys/fs/fuse/connections/NN/waiting
>>
>> ?
>
> I think I found the culprit.  Does the attached patch fix it?

Hi Miklos,

I am travelling for next weeks, but you can ask syzbot to test any patches:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
