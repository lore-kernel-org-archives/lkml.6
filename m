Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbeEQKqX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:46:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26586 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeEQKqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:46:22 -0400
Subject: Re: general protection fault in n_tty_flush_buffer
To: syzbot <syzbot+083228748980909eb453@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        syzkaller-bugs@googlegroups.com
References: <000000000000d2d1fe056c641bd7@google.com>
Cc: linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <88227098-aac7-1084-9cd6-04744fb992bd@I-love.SAKURA.ne.jp>
Date: Thu, 17 May 2018 19:45:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000d2d1fe056c641bd7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be essentially same with below one.
ioctl(TIOCVHANGUP) versus ioctl(TCSETS) can race.

#syz dup: KASAN: user-memory-access Write in n_tty_set_termios
