Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeBLRDa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:03:30 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:41628 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbeBLRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:03:28 -0500
X-Google-Smtp-Source: AH8x224enHG1Js2g63B6y0/L6hW/eusKhkKp29IDIUlJYCMqGnR69IXfUGTo0vqlPA86VHOxoYYU7w==
Date: Mon, 12 Feb 2018 09:03:25 -0800
From: Tejun Heo <tj@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: dennisszhou@gmail.com, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Subject: Re: lost connection to test machine (4)
Message-ID: <20180212170325.GW695913@devbig577.frc2.facebook.com>
References: <001a113f8734783e94056505f8fd@google.com>
 <CACT4Y+ZBHw7VZBFOeqLmrpmzgn4owW88qvP5v=xnr9966hbM_Q@mail.gmail.com>
 <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Daniel.

On Mon, Feb 12, 2018 at 06:00:13PM +0100, Daniel Borkmann wrote:
> [ +Dennis, +Tejun ]
> 
> Looks like we're stuck in percpu allocator with key/value size of 4 bytes
> each and large number of entries (max_entries) in the reproducer in above
> link.
> 
> Could we have some __GFP_NORETRY semantics and let allocations fail instead
> of triggering OOM killer?

For some part, maybe, but not generally.  The virt area allocation
goes down to page table allocation which is hard coded to use
GFP_KERNEL in arch mm code.

Thanks.

-- 
tejun
