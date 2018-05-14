Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeENDP4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:15:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46374 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeENDPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:15:55 -0400
X-Google-Smtp-Source: AB8JxZpZ4/SINVjBQPDsE2Ng3ZAxvTUoLZjUDQRz99QVhyb8NWCpl0cSEJmqR543S2QHM+EExUanjA==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 0/8] rcu fixes, clean ups for rcu/dev
Date: Sun, 13 May 2018 20:15:33 -0700
Message-Id: <20180514031541.67247-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are some fixes, clean ups and some code comments changes mostly
for the new funnel locking, gp_seq changes and some tracing. Its based
on latest rcu/dev branch.

thanks,

- Joel

Joel Fernandes (Google) (8):
  rcu: Add comment documenting how rcu_seq_snap works
  rcu: Clarify usage of cond_resched for tasks-RCU
  rcu: Add back the cpuend tracepoint
  rcu: Get rid of old c variable from places in tree RCU
  rcu: Use rcu_node as temporary variable in funnel locking loop
  rcu: Add back the Startedleaf tracepoint
  rcu: trace CleanupMore condition only if needed
  rcu: Fix cpustart tracepoint gp_seq number

 include/linux/rcupdate.h   | 11 +++--
 include/trace/events/rcu.h | 19 ++++----
 kernel/rcu/rcu.h           | 24 +++++++++-
 kernel/rcu/tree.c          | 92 +++++++++++++++++++++++---------------
 4 files changed, 97 insertions(+), 49 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog
