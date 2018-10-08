Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7463C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887F220652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887F220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJHS07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:26:59 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49240 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeJHS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:26:58 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id kzFk1y00B3XaVaC01zFk1Z; Mon, 08 Oct 2018 13:15:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TVo-00055z-KS; Mon, 08 Oct 2018 13:15:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TVo-0006o9-JI; Mon, 08 Oct 2018 13:15:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] reset: Improve reset controller kernel docs
Date:   Mon,  8 Oct 2018 13:15:43 +0200
Message-Id: <20181008111543.26128-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grammar and indentation fixes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/reset.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 29af6d6b2f4b8103..d01ea059e2beee6e 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -138,7 +138,7 @@ __must_check reset_control_get_exclusive(struct device *dev, const char *id)
  *
  * Returns a struct reset_control or IS_ERR() condition containing errno.
  * This function is intended for use with reset-controls which are shared
- * between hardware-blocks.
+ * among hardware blocks.
  *
  * When a reset-control is shared, the behavior of reset_control_assert /
  * deassert is changed, the reset-core will keep track of a deassert_count
@@ -187,7 +187,7 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 }
 
 /**
- * of_reset_control_get_shared - Lookup and obtain an shared reference
+ * of_reset_control_get_shared - Lookup and obtain a shared reference
  *                               to a reset controller.
  * @node: device to be reset by the controller
  * @id: reset line name
@@ -229,7 +229,7 @@ static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 }
 
 /**
- * of_reset_control_get_shared_by_index - Lookup and obtain an shared
+ * of_reset_control_get_shared_by_index - Lookup and obtain a shared
  *                                        reference to a reset controller
  *                                        by index.
  * @node: device to be reset by the controller
@@ -322,7 +322,7 @@ devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 
 /**
  * devm_reset_control_get_shared_by_index - resource managed
- * reset_control_get_shared
+ *                                          reset_control_get_shared
  * @dev: device to be reset by the controller
  * @index: index of the reset controller
  *
-- 
2.17.1

