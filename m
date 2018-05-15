Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeEOGfP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:35:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeEOGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:35:13 -0400
Date: Mon, 14 May 2018 23:34:49 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-05604e7e3adbd78f074b7f86b14f50888bf66252@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com, andrea.parri@amarulasolutions.com,
        akpm@linux-foundation.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, akpm@linux-foundation.org, mingo@kernel.org,
        will.deacon@arm.com, andrea.parri@amarulasolutions.com,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <1526340837-12222-16-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-16-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Fix coding style in
 'lock.cat'
Git-Commit-ID: 05604e7e3adbd78f074b7f86b14f50888bf66252
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  05604e7e3adbd78f074b7f86b14f50888bf66252
Gitweb:     https://git.kernel.org/tip/05604e7e3adbd78f074b7f86b14f50888bf66252
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:33:54 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:18 +0200

tools/memory-model: Fix coding style in 'lock.cat'

This commit uses tabs for indentation and adds spaces around binary
operator.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526340837-12222-16-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/lock.cat | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index cd002a33ca8a..305ded17e741 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -84,16 +84,16 @@ let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
 
 (* rfe for LF events *)
 let all-possible-rfe-lf =
-  (*
-   * Given an LF event r, compute the possible rfe edges for that event
-   * (all those starting from LKW events in other threads),
-   * and then convert that relation to a set of single-edge relations.
-   *)
-  let possible-rfe-lf r =
-    let pair-to-relation p = p ++ 0
-    in map pair-to-relation ((LKW * {r}) & loc & ext)
-  (* Do this for each LF event r that isn't in rfi-lf *)
-  in map possible-rfe-lf (LF \ range(rfi-lf))
+	(*
+	 * Given an LF event r, compute the possible rfe edges for that event
+	 * (all those starting from LKW events in other threads),
+	 * and then convert that relation to a set of single-edge relations.
+	 *)
+	let possible-rfe-lf r =
+		let pair-to-relation p = p ++ 0
+		in map pair-to-relation ((LKW * {r}) & loc & ext)
+	(* Do this for each LF event r that isn't in rfi-lf *)
+	in map possible-rfe-lf (LF \ range(rfi-lf))
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
@@ -110,10 +110,10 @@ let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
 
 (* rfe for RU events: an RU may read from an external UL or the initial write *)
 let all-possible-rfe-ru =
-   let possible-rfe-ru r =
-     let pair-to-relation p = p ++ 0
-     in map pair-to-relation (((UL|IW) * {r}) & loc & ext)
-  in map possible-rfe-ru RU
+	let possible-rfe-ru r =
+		let pair-to-relation p = p ++ 0
+		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
+	in map possible-rfe-ru RU
 
 (* Generate all rf relations for RU events *)
 with rfe-ru from cross(all-possible-rfe-ru)
