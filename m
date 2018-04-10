Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeDJIvl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:51:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37568 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeDJIvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:51:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Apr 2018 16:51:37 +0800
From: yuankuiz@codeaurora.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, fweisbec@gmail.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] time: tick-sched: use bool for tick_stopped
In-Reply-To: <9ee70560651fefffcc61949d8a37315d@codeaurora.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <9ee70560651fefffcc61949d8a37315d@codeaurora.org>
Message-ID: <ab6167c5ea5be81f0482a7da54d781a4@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From: John Zhao <yuankuiz@codeaurora.org>

Variable tick_stopped returned by tick_nohz_tick_stopped
can only be true / false values. Since the return type
of the tick_nohz_tick_stopped is also bool, variable
tick_stopped nice to have data type as 'bool' in place of
the 'unsigned int'.
Moreover, the executed instructions cost could be minimal
without potiential data type conversion.

Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
---
  kernel/time/tick-sched.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 6de959a..4d34309 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -48,8 +48,8 @@ struct tick_sched {
  	unsigned long			check_clocks;
  	enum tick_nohz_mode		nohz_mode;

+	bool				tick_stopped	: 1;
  	unsigned int			inidle		: 1;
-	unsigned int			tick_stopped	: 1;
  	unsigned int			idle_active	: 1;
  	unsigned int			do_timer_last	: 1;
  	unsigned int			got_idle_tick	: 1;
