Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A48C282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DD7214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGYzjANM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfBDIU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:20:29 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36743 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfBDIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:20:28 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so19201746itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 00:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Am2O3i+oQQSGfLMLXg4ZnpoSIYOB0PsdVvbAcomlW2I=;
        b=MGYzjANMxDwNC1YDWGk7Dd4N4dnFgFR5XJLb0Y7vihSPhRQw3Ta99S7qASrYxjkpRX
         7lBRzCUDj6bK2Y6ZPoWLSydZndc2mktamyUE2bYcRqE+JNQAa7VPuXorzJCJnOcuD+fd
         heMJsexmORVQCStfsTpK2FmCl1Ltff7QCDLrsd+FEQ9GbE9mlH6OeueJdNAvTWsWwzN0
         ZfBHMsC5f1sGQyhNJihe8J8jmAMvoomeBH89Mo02TnHC9RudEQtvNSkm5Tk5pMbApCFq
         GbfeyDQ1unrYsxvhvQsKtsXA2r2NddwIAit/OB67LPRWXTgrxUEIErkBJ9EHImwNeprm
         PDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Am2O3i+oQQSGfLMLXg4ZnpoSIYOB0PsdVvbAcomlW2I=;
        b=DkizlsH6tSbT/QK5vba5iv3IochdLJe6Zn93ZWYI2NGmc0UqyNFORfCco/lyGlOGGT
         PLps2E9ujvoZy6dFPNq8wxjxzkc1Qz5SuuP7kqN+BMx6bz8u0Xd47+AyPw3jz2tTJdAF
         aSGgcVERqlX3an5rllAcozfNq/sUVA0DZNgTdXYe73V2xcGGqI/rQzox9nFrnhTf3mgP
         3QKzYW3hxHDFcqnmSIAcBdqQ96UegM3gNzK58is+1QzsKoAOmYt+Ki57CkKLiUAXE+6K
         iiMRnUzBiRnTpW3HhPw7xSvVvfzdrmXRxJcVxPnU5SHHf2+X9+igDpwgyo3wxoVHtZKe
         HUSw==
X-Gm-Message-State: AHQUAuYPfF/Itt8bduM+EnlzQZPtyDwWp4i2C+zAwG2UuCagUHIO/+VF
        JzrYXAFqdsL6qZnJvG7TGDMYqXiT6yBiRCfING9pMA==
X-Google-Smtp-Source: AHgI3IYtZ6Z2Co+M1yICymW1dCl2QTQydgLaKwkPkYnRZqBFb+2Y95VopA7t/DreKbc4h+ZY0YsOdFD1BOPST3nC2NI=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr7312592iti.166.1549268427827;
 Mon, 04 Feb 2019 00:20:27 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dc52b305810d0f49@google.com>
In-Reply-To: <000000000000dc52b305810d0f49@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Feb 2019 09:20:16 +0100
Message-ID: <CACT4Y+Y=-aFQXjqRviYg8Z0eve+_qb1fRkdezeBpio0NkZiK=A@mail.gmail.com>
Subject: Re: linux-next boot error: can't ssh into the instance (2)
To:     syzbot <syzbot+94522064b07f06df116d@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 9:13 AM syzbot
<syzbot+94522064b07f06df116d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    66d54fa79f95 Add linux-next specific files for 20190204
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17823b28c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f0f6544db42451b4
> dashboard link: https://syzkaller.appspot.com/bug?extid=94522064b07f06df116d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+94522064b07f06df116d@syzkaller.appspotmail.com

[    6.272518][    T1] BUG: KASAN: global-out-of-bounds in
fs_validate_description+0x109/0x6e9

Probably introduced by:

commit 82685adaccb3e756d04161ebfc9d188b57def10c
Author: David Howells
Date:   Thu Nov 1 23:07:24 2018 +0000

    vfs: Add configuration parser helpers



> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
