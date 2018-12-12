Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4286C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B1520849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B1520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeLLMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:32:38 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:21783 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727155AbeLLMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:32:25 -0500
X-IronPort-AV: E=Sophos;i="5.56,344,1539640800"; 
   d="scan'208";a="359976181"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 12 Dec 2018 13:32:22 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 2/2] scripts: coccinelle: Correct warning message
Date:   Wed, 12 Dec 2018 12:55:57 +0100
Message-Id: <1544615757-19356-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Assignment" requires the assigned value before the place that
value is stored into.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
---
 scripts/coccinelle/misc/boolinit.cocci | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
index 1b44feb..b0584a3 100644
--- a/scripts/coccinelle/misc/boolinit.cocci
+++ b/scripts/coccinelle/misc/boolinit.cocci
@@ -150,19 +150,19 @@ cocci.print_main("WARNING: Comparison to bool",p)
 p << r2.p;
 @@
 
-cocci.print_main("WARNING: Comparison of bool to 0/1",p)
+cocci.print_main("WARNING: Comparison of 0/1 to bool variable",p)
 
 @script:python depends on org@
 p1 << r3.p1;
 @@
 
-cocci.print_main("WARNING: Assignment of bool to 0/1",p1)
+cocci.print_main("WARNING: Assignment of 0/1 to bool variable",p1)
 
 @script:python depends on org@
 p2 << r4.p2;
 @@
 
-cocci.print_main("ERROR: Assignment of bool to non-0/1 constant",p2)
+cocci.print_main("ERROR: Assignment of non-0/1 constant to bool variable",p2)
 
 @script:python depends on report@
 p << r1.p;
@@ -174,16 +174,16 @@ coccilib.report.print_report(p[0],"WARNING: Comparison to bool")
 p << r2.p;
 @@
 
-coccilib.report.print_report(p[0],"WARNING: Comparison of bool to 0/1")
+coccilib.report.print_report(p[0],"WARNING: Comparison of 0/1 to bool variable")
 
 @script:python depends on report@
 p1 << r3.p1;
 @@
 
-coccilib.report.print_report(p1[0],"WARNING: Assignment of bool to 0/1")
+coccilib.report.print_report(p1[0],"WARNING: Assignment of 0/1 to bool variable")
 
 @script:python depends on report@
 p2 << r4.p2;
 @@
 
-coccilib.report.print_report(p2[0],"ERROR: Assignment of bool to non-0/1 constant")
+coccilib.report.print_report(p2[0],"ERROR: Assignment of non-0/1 constant to bool variable")
-- 
1.9.1

