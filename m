Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A917121479
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfABU6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbfABU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:57:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D01202C977B;
        Wed,  2 Jan 2019 20:57:58 +0000 (UTC)
Received: from redhat.com (ovpn-120-148.rdu2.redhat.com [10.10.120.148])
        by smtp.corp.redhat.com (Postfix) with SMTP id 81F3160C47;
        Wed,  2 Jan 2019 20:57:55 +0000 (UTC)
Date:   Wed, 2 Jan 2019 15:57:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH RFC 2/4] include/linux/compiler.h: allow memory operands
Message-ID: <20190102205715.14054-3-mst@redhat.com>
References: <20190102205715.14054-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 02 Jan 2019 20:57:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't really care whether the variable is in-register
or in-memory. Relax the constraint accordingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 1ad367b4cd8d..6601d39e8c48 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -154,7 +154,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #ifndef OPTIMIZER_HIDE_VAR
 /* Make the optimizer believe the variable can be manipulated arbitrarily. */
 #define OPTIMIZER_HIDE_VAR(var)						\
-	__asm__ ("" : "=r" (var) : "0" (var))
+	__asm__ ("" : "=rm" (var) : "0" (var))
 #endif
 
 /* Not-quite-unique ID. */
-- 
MST

