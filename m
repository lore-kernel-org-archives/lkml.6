Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F335C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BF520874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeL1PZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:25:44 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59441 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbeL1PZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:25:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,410,1539640800"; 
   d="scan'208";a="362015778"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 28 Dec 2018 16:25:41 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <zx2c4@kernel.org>
Subject: [PATCH] scripts/coccinelle: check for redeclaration
Date:   Fri, 28 Dec 2018 15:49:01 +0100
Message-Id: <1546008541-3175-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid reporting on the use of an iterator index variable when
the variable is redeclared.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/iterators/use_after_iter.cocci |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
index ce8cc9c..66a1140 100644
--- a/scripts/coccinelle/iterators/use_after_iter.cocci
+++ b/scripts/coccinelle/iterators/use_after_iter.cocci
@@ -35,6 +35,7 @@ iterator name hlist_for_each_entry_from;
 iterator name hlist_for_each_entry_safe;
 statement S;
 position p1,p2;
+type T;
 @@
 
 (
@@ -125,6 +126,8 @@ sizeof(<+...c...+>)
 |
  &c->member
 |
+T c;
+|
 c = E
 |
 *c@p2

