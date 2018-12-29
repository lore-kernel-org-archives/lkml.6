Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4143A21019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeL2GvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 01:51:07 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:20417
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728933AbeL2GvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 01:51:06 -0500
X-IronPort-AV: E=Sophos;i="5.56,412,1539640800"; 
   d="scan'208";a="290374218"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 29 Dec 2018 07:51:03 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] scripts: coccinelle: boolinit: drop warnings on named constants
Date:   Sat, 29 Dec 2018 07:14:16 +0100
Message-Id: <1546064056-15569-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle doesn't always have access to the values of named
(#define) constants, and they may likely often be bound to true
and false values anyway, resulting in false positives.  So stop
warning about them.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/boolinit.cocci |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
index b0584a3..aabb581 100644
--- a/scripts/coccinelle/misc/boolinit.cocci
+++ b/scripts/coccinelle/misc/boolinit.cocci
@@ -136,9 +136,14 @@ position p1;
 @r4 depends on !patch@
 bool b;
 position p2;
+identifier i;
 constant c != {0,1};
 @@
+(
+ b = i
+|
 *b@p2 = c
+)
 
 @script:python depends on org@
 p << r1.p;

