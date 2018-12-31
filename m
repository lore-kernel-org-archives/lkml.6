Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D28C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E884C20815
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="e4WCFC11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLaEJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:09:30 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:25856 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLaEJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:09:29 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wBV493M1019639;
        Mon, 31 Dec 2018 13:09:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBV493M1019639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546229343;
        bh=deUjhUkdmp2Zvz+uvqSSvIMNyP8pCKxd7fqHZ4A5YZU=;
        h=From:To:Cc:Subject:Date:From;
        b=e4WCFC11xmPcNuBGhUU8kEiT6pFXCQpZTYEXM129KPMHyRmD6Cbws5BaaPHaljrIm
         KyPe4LWbYlUSSMY0BSVV2NjuX0SA6dDt2Z8elrtVnX01eNsmEBelhxLdAfiyHFSBXR
         f9qFYGgXgfocPJcpbTf1pRCOWso8EVxMGAo1VuyaIX8vhAc2PuYgyfydtcCY+r5KcM
         b5zlhBL9eK5m9TZseTHHRdb+zhMD27czQeEccTcBeMKpKw/SrKIuA4KdrWGxg6L9Ss
         aaEfElFURFdmlNZlLvsrpcl6qSM9k4Dlhey+xs1i5qcrEPgelx4PqYnKQTsgvS+V4o
         WLbGVExo5ETVg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: clean up rule_dtc_dt_yaml
Date:   Mon, 31 Dec 2018 13:09:00 +0900
Message-Id: <1546229340-19309-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3a2429e1faf4 ("kbuild: change if_changed_rule for multi-line
recipe") and commit 4f0e3a57d6eb ("kbuild: Add support for DT binding
schema checks") came in via different sub-systems.

This is a follow-up cleanup.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ed1f83d..b44ae6c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -304,8 +304,8 @@ quiet_cmd_dtb_check =	CHECK   $@
       cmd_dtb_check =	$(DT_CHECKER) -p $(DT_TMP_SCHEMA) $@ ;
 
 define rule_dtc_dt_yaml
-	$(call cmd_and_fixdep,dtc,yaml)		\
-	$(call echo-cmd,dtb_check) $(cmd_dtb_check)
+	$(call cmd_and_fixdep,dtc,yaml)
+	$(call cmd,dtb_check)
 endef
 
 $(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
-- 
2.7.4

