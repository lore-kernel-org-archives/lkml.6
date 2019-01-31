Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BF4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FBC2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfAaLxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:53:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:53636 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfAaLxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:53:04 -0500
Received: by mail-it1-f198.google.com with SMTP id i12so2303220ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5DxVAjUzueJPHXu22nFZUL0mvmZ8UsheISr9iPmh3tI=;
        b=shs8TYQgnF/QcmfuynV+YR79ktA0Bcd/DQceB1O3hohXWOs7lACDlRrBaN7wvSbqec
         wglm9b25KRX0w+DqJM5pj1RVUscKpS05z6Bx2FyrDBAahI5RL0/1C7XEdIfSXbWgtNd0
         Oel7FTTj8WrN3FVlcNbR8DQeLYhDqcfWuyArLKivRbtPkYz3o+b+m4Ttves46ahvS9aQ
         1d2Y+ds5gHbT8B5Erz5seIYTQLAhKzVBEEcSkDbggCePvcLOUlw8xVo61rTu8S2hr9d1
         uBWNoz6hAwIF8CKl0//LPu9hOBhACPkxRa6vx83Gy6I132lEqK7N8VDUpEzg6Pm/eRZy
         jg4g==
X-Gm-Message-State: AHQUAuYL0JHp6BTLKFy0BUn20+H345yujWmbYykyl7d+R0YrBARywwdx
        I3KXngTxu8w0SUMqmd1gEHEkxm26UollDDgHm0JnI/+KE7dL
X-Google-Smtp-Source: AHgI3IaQbAim8A05l5ZKdosLXo23TbC6ecX80jKKXLm7xXxgHG8DjBvEII3UMzoc25EekilkFPxmExsSzm9d9bedwyN4x5gSyrGg
MIME-Version: 1.0
X-Received: by 2002:a02:4dc9:: with SMTP id t70mr9858797jad.0.1548935583249;
 Thu, 31 Jan 2019 03:53:03 -0800 (PST)
Date:   Thu, 31 Jan 2019 03:53:03 -0800
In-Reply-To: <20190131112241.GA8383@kroah.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038383f0580bfabd3@google.com>
Subject: Re: general protection fault in relay_open_buf
From:   syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, ebiggers@google.com,
        gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com

Tested on:

commit:         37ea7b630ae5 debugfs: debugfs_lookup() should return NULL ..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git  
driver-core-linus
kernel config:  https://syzkaller.appspot.com/x/.config?x=a04dcc98f2be2fd8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ecad28c00000

Note: testing is done by a robot and is best-effort only.
