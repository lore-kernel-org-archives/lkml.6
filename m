Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393FECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70D420827
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FWPURrhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70D420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJ1NOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:14:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43389 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJ1NOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:14:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so2300985pgv.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 21:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPwV39yVWYSq+/56VBRD2t57nMmrSpoLnd3/XxZuTIs=;
        b=FWPURrhSOWLSVbyhGjwNqXQf16eap69uOf//XVQN4QPJqdK/Lu+w0JC0ci3G9t1mE1
         VsKIaEoekOkKoK0lhZFhJ1J+YZMmf4jSoWMYyYD4jvdefeignKUO4ScyqSfZaIJiJ8/S
         ogCUNkuPlM6DPDcub22e6W/+6IHjqs4d8ftNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPwV39yVWYSq+/56VBRD2t57nMmrSpoLnd3/XxZuTIs=;
        b=DSssILIu8dEY45con42dYOGxRf1pa54Hcz+927VfylRY1bTlyjM8CWlGhPVVB/Y80a
         caNuXTbtyP0QlH0Xx1UNujW8W7ahHvd6H5SHNQRNRaJc+/ccMLVXvcutVa6cFWRiPdrx
         PQz+i/8tnniOaUeJbvbmM5FPTkLOClXNht7a3Ty7ey4ID1+98W3V/HoZj9gPMg7z2+YN
         3+C5FwO371iBiAAR/DUN9M01ohzvOPxsmoxBQyujSnH6Kn/JdKBei5600s962E4zb4Dw
         ixeE9NJM8uCet9Zh1rpEVco5eqX7ToF7x8HwNU65WZErsFoi5xYPywHpANC/zwY4PsUl
         oYag==
X-Gm-Message-State: AGRZ1gL8ov1Dz1QIQ66TII5eCr6jRPQYfEIOYhqgu50L+nbb5XjJUIJr
        I9dWORyjed0cSdLM8yca8PZFGCKIDuA=
X-Google-Smtp-Source: AJdET5erxsFM/Yv33Fs95qDNZ5UgfcCoU8FbyE7UrgEJ7K2kj4/dKCHatO7s2xMADHQsuBI+19/6QQ==
X-Received: by 2002:a63:7f0e:: with SMTP id a14-v6mr9095170pgd.296.1540701057824;
        Sat, 27 Oct 2018 21:30:57 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q26-v6sm20791609pfi.165.2018.10.27.21.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 21:30:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Date:   Sat, 27 Oct 2018 21:30:46 -0700
Message-Id: <20181028043046.198403-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per this thread [1], it seems this smp_mb isn't needed anymore:
"So the smp_mb() that I was trying to add doesn't need to be there."

So let us remove this part from the memory ordering documentation.

[1] https://lkml.org/lkml/2017/10/6/707

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../Tree-RCU-Memory-Ordering.html             | 32 +------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
index a346ce0116eb..0fb1511763d4 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
@@ -77,7 +77,7 @@ The key point is that the lock-acquisition functions, including
 <tt>smp_mb__after_unlock_lock()</tt> immediately after successful
 acquisition of the lock.
 
-<p>Therefore, for any given <tt>rcu_node</tt> struction, any access
+<p>Therefore, for any given <tt>rcu_node</tt> structure, any access
 happening before one of the above lock-release functions will be seen
 by all CPUs as happening before any access happening after a later
 one of the above lock-acquisition functions.
@@ -162,36 +162,6 @@ an <tt>atomic_add_return()</tt> of zero) to detect idle CPUs.
 <tr><td>&nbsp;</td></tr>
 </table>
 
-<p>The approach must be extended to handle one final case, that
-of waking a task blocked in <tt>synchronize_rcu()</tt>.
-This task might be affinitied to a CPU that is not yet aware that
-the grace period has ended, and thus might not yet be subject to
-the grace period's memory ordering.
-Therefore, there is an <tt>smp_mb()</tt> after the return from
-<tt>wait_for_completion()</tt> in the <tt>synchronize_rcu()</tt>
-code path.
-
-<table>
-<tr><th>&nbsp;</th></tr>
-<tr><th align="left">Quick Quiz:</th></tr>
-<tr><td>
-	What?  Where???
-	I don't see any <tt>smp_mb()</tt> after the return from
-	<tt>wait_for_completion()</tt>!!!
-</td></tr>
-<tr><th align="left">Answer:</th></tr>
-<tr><td bgcolor="#ffffff"><font color="ffffff">
-	That would be because I spotted the need for that
-	<tt>smp_mb()</tt> during the creation of this documentation,
-	and it is therefore unlikely to hit mainline before v4.14.
-	Kudos to Lance Roy, Will Deacon, Peter Zijlstra, and
-	Jonathan Cameron for asking questions that sensitized me
-	to the rather elaborate sequence of events that demonstrate
-	the need for this memory barrier.
-</font></td></tr>
-<tr><td>&nbsp;</td></tr>
-</table>
-
 <p>Tree RCU's grace--period memory-ordering guarantees rely most
 heavily on the <tt>rcu_node</tt> structure's <tt>-&gt;lock</tt>
 field, so much so that it is necessary to abbreviate this pattern
-- 
2.19.1.568.g152ad8e336-goog

