Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDIOnt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:43:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49384 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeDIOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:43:46 -0400
Date: Mon, 09 Apr 2018 10:43:40 -0400 (EDT)
Message-Id: <20180409.104340.1690774596565022032.davem@davemloft.net>
To: dvyukov@google.com
Cc: syzbot+b09ac67a2af842b12eab@syzkaller.appspotmail.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org, edumazet@google.com
Subject: Re: WARNING in ip_rt_bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <CACT4Y+YfM=SL3-cgeJ_7JCvAwX2KsyMWV=HHpGfLV=-RKo7TQQ@mail.gmail.com>
References: <001a11408d9c43ff4a0569641a3f@google.com>
        <CACT4Y+YfM=SL3-cgeJ_7JCvAwX2KsyMWV=HHpGfLV=-RKo7TQQ@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 9 Apr 2018 08:06:20 +0200

> +Eric said that perhaps we just need to revert:
> 
> commit c378a9c019cf5e017d1ed24954b54fae7bebd2bc
> Date:   Sat May 21 07:16:42 2011 +0000
>     ipv4: Give backtrace in ip_rt_bug().

And I replied to him that we shouldn't.

Reverting makes the backtrace, and all the useful debugging
information, go away.  It won't fix the actual bug, which seems
to be that ICMP's route lookup tried to use an input route
for sending a packet.
