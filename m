Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeBVJYM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:24:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33650 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbeBVJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:24:10 -0500
X-Google-Smtp-Source: AH8x224UinmWtVlU6xD7z+sufFdxknKaxHsokAbAfyu9jpdsomkki2ihoVW8BkATik7Q289/sUiiVg==
From: Andrea Parri <parri.andrea@gmail.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 0/2] locking/xchg/alpha: Additional fixes
Date: Thu, 22 Feb 2018 10:23:41 +0100
Message-Id: <1519291421-5638-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of two more fixes, on top of tip:locking/urgent, to Alpha's
implementations of xchg() and cmpxchg():

  - The first, suggested by Will, removing the macro '__ASM__MB'
    in favour of smp_mb();

  - The second, reported by Will, adding a leading smp_mb().

Compile tested only.

Cheers,
  Andrea

Andrea Parri (2):
  locking/xchg/alpha: Use smp_mb() in place of __ASM__MB
  locking/xchg/alpha: Add leading smp_mb() to xchg(), cmpxchg()

 arch/alpha/include/asm/cmpxchg.h |  6 ------
 arch/alpha/include/asm/xchg.h    | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.7.4
