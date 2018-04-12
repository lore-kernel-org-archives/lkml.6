Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeDLMXt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:23:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39530 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbeDLMXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:23:48 -0400
X-Google-Smtp-Source: AIpwx4/4jwAY+rWfZA2HHFx8noWdmgJjTqa32YUI6iBgcjUJsdAaaVG7TP8BoDIJG55T0dA6NYWwug==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 1/2] tools/memory-model: Model 'smp_store_mb()'
Date: Thu, 12 Apr 2018 14:22:49 +0200
Message-Id: <1523535770-10781-2-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Says that 'smp_store_mb(x, val);' is _semantically_ equivalent to
'WRITE_ONCE(x, val); smp_mb();'.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 397e4e67e8c84..acf86f6f360a7 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -14,6 +14,7 @@ smp_store_release(X,V) { __store{release}(*X,V); }
 smp_load_acquire(X) __load{acquire}(*X)
 rcu_assign_pointer(X,V) { __store{release}(X,V); }
 rcu_dereference(X) __load{once}(X)
+smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
 smp_mb() { __fence{mb} ; }
-- 
2.7.4
