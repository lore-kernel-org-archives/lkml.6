Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeC0XZk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:25:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39129 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752247AbeC0XZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:25:39 -0400
Date: Tue, 27 Mar 2018 16:13:21 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] locking/debug: Add a master lock debugging switch
Message-ID: <20180327231321.4on2kczby5ejqglt@linux-n805>
References: <1522186690-10526-1-git-send-email-longman@redhat.com>
 <1522186690-10526-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1522186690-10526-3-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Waiman Long wrote:

>Add a new master LOCK_DEBUGGING Kconfig option to turn on all the lock
>debugging options except the selftests and the torture tests.

For what purpose?

I'm not sure we want yet another config debug option. These are all expert
level configuration and honestly I would rather such users _think_ about
what options they are enabling instead of giving them a large hammer.

If enough load, this can also make boxes completely locked up for any sort of
testing/debugging. I vote no.

Also, CI efforts such 0-day already have the necessary scripting to cover the
debug options that make sense.

Thanks,
Davidlohr
