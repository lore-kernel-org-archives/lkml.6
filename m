Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeEUEdW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:33:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34583 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeEUEdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:33:20 -0400
X-Google-Smtp-Source: AB8JxZrfokaujJTb0/Hk/klB67h7hJ/pFpxE1u1Cx+haDhBsET1EiqQqnSNV14VRnnPafkdrgfaYow==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH v2 0/4] fixes, cleanups for rcu/dev
Date: Sun, 20 May 2018 21:32:47 -0700
Message-Id: <20180521043251.120953-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Here are some patches reworked with a few comments on few of the patches
from previous series: https://lkml.org/lkml/2018/5/13/296

4/4 is a new addition which fixes a potential issue.

Let me know what you think, thanks!

Joel Fernandes (4):
  rcu: Add comment documenting how rcu_seq_snap works
  rcu: Cleanup the variables used to request a new grace period
  rcu: Use better variable names in funnel locking loop
  rcu: Unlock non-start node only after accessing its gp_seq_needed

 include/trace/events/rcu.h | 15 +++----
 kernel/rcu/rcu.h           | 33 +++++++++++++++-
 kernel/rcu/tree.c          | 80 +++++++++++++++++++++-----------------
 3 files changed, 85 insertions(+), 43 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog
