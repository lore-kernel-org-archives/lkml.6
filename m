Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeEWGid (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:38:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37678 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbeEWGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:38:31 -0400
X-Google-Smtp-Source: AB8JxZr8UefJasMp0J7LpzXoCiH3+Alv8RpfJ8cKb4/Vj/oH8CeZ52I3Yw3Sav1wn+SlcO76KY27+g==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/4] cleanups, fixes for rcu/dev
Date: Tue, 22 May 2018 23:38:11 -0700
Message-Id: <20180523063815.198302-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Here's an updated series for rcu/dev addressing some of your comments along
with the performance optimization. I also threw in the RCU-tasks speed up
patch again, hopefully that doesn't annoy you :)

cheers,
 - Joel

Joel Fernandes (Google) (4):
  rcu: Speed up calling of RCU tasks callbacks
  rcu: Add comment documenting how rcu_seq_snap works
  rcu: Use better variable names in funnel locking loop
  rcu: Identify grace period is in progress as we advance up the tree

 kernel/rcu/rcu.h    | 34 ++++++++++++++++++++++++++-
 kernel/rcu/tree.c   | 57 +++++++++++++++++++++++----------------------
 kernel/rcu/update.c | 12 +++++++++-
 3 files changed, 73 insertions(+), 30 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog
