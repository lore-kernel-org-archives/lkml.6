Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbeDIRxd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:53:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33119 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeDIRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:53:32 -0400
X-Google-Smtp-Source: AIpwx49xdFuU9xilI3u3STCL9l3EkGq+iXzSzCPQq+JnRt+V5msRL8gus8Qc01xZTTbNa0PIVy7nLyntCc4oDgCdTC4=
MIME-Version: 1.0
In-Reply-To: <20180409161817.bnmokplnoagyxwrc@gmail.com>
References: <20180409122339.1709840-1-arnd@arndb.de> <20180409161817.bnmokplnoagyxwrc@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 9 Apr 2018 19:53:30 +0200
X-Google-Sender-Auth: HGraCfj5PQOOTqw1e-FUTBoirYQ
Message-ID: <CAK8P3a0dY++MwoLhxCEHHHg6AVpcaSDrDcqioh_mT0yxkg7Ujw@mail.gmail.com>
Subject: Re: [PATCH] tick-sched: avoid a maybe-uninitialized warning
To: Ingo Molnar <mingo@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 6:18 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Arnd Bergmann <arnd@arndb.de> wrote:
>
>> The use of bitfields seems to confuse gcc, leading to a false-positive
>> warning in all compiler versions:
>>
>> kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
>> kernel/time/tick-sched.c:538:2: error: 'now' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>
>> This introduces a temporary variable to track the flags so gcc
>> doesn't have to evaluate twice, eliminating the code path that
>> leads to the warning.
>>
>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85301
>> Fixes: 1cae544d42d2 ("nohz: Gather tick_sched booleans under a common flag field")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Which tree is this against? There's no such commit either in -tip, upstream or in
> -next AFAICS.

It's in today's linux-next. I found that it came in through Rafael's
pm/linux-next tree.

      Arnd
