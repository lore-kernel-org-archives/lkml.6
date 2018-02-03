Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeBCIO1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 03:14:27 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:26687
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750798AbeBCIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 03:14:18 -0500
X-IronPort-AV: E=Sophos;i="5.46,453,1511823600";
   d="scan'208";a="253495767"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: deref_null: avoid useless computation
Date: Sat,  3 Feb 2018 08:44:58 +0100
Message-Id: <1517643898-2801-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The effect of the rules ifm1, pr11, and pr12 is only used in the final rule,
which depends on context && !org && !report.  Thus these rules should only
be performed in those circumstances.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/null/deref_null.cocci |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle/null/deref_null.cocci
index f192d60..b16ccb7 100644
--- a/scripts/coccinelle/null/deref_null.cocci
+++ b/scripts/coccinelle/null/deref_null.cocci
@@ -212,7 +212,7 @@ else S3
 // The following three rules are duplicates of ifm, pr1 and pr2 respectively.
 // It is need because the previous rule as already made a "change".
 
-@ifm1@
+@ifm1 depends on context && !org && !report@
 expression *E;
 statement S1,S2;
 position p1;
@@ -220,7 +220,7 @@ position p1;
 
 if@p1 ((E == NULL && ...) || ...) S1 else S2
 
-@pr11 expression@
+@pr11 depends on context && !org && !report expression@
 expression *ifm1.E;
 identifier f;
 position p1;
@@ -228,7 +228,7 @@ position p1;
 
  (E != NULL && ...) ? <+...E->f@p1...+> : ...
 
-@pr12 expression@
+@pr12 depends on context && !org && !report expression@
 expression *ifm1.E;
 identifier f;
 position p2;
