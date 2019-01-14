Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B10620873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfANNwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:52:07 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:59250 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfANNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:51:49 -0500
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id QDrm1z00B3XaVaC01DrmHV; Mon, 14 Jan 2019 14:51:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj2eY-0000Eq-3t; Mon, 14 Jan 2019 14:51:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gj2eY-0006oG-2u; Mon, 14 Jan 2019 14:51:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 08/12] selftests: timestamping: Remove superfluous rules
Date:   Mon, 14 Jan 2019 14:51:40 +0100
Message-Id: <20190114135144.26096-9-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114135144.26096-1-geert+renesas@glider.be>
References: <20190114135144.26096-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Makefile:14: warning: overriding recipe for target 'clean'
    ../../lib.mk:137: warning: ignoring old recipe for target 'clean'

"all" and "clean" are already handled by the included lib.mk.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/testing/selftests/networking/timestamping/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
index 9050eeea5f5f2953..49ede79660c0208d 100644
--- a/tools/testing/selftests/networking/timestamping/Makefile
+++ b/tools/testing/selftests/networking/timestamping/Makefile
@@ -4,11 +4,6 @@ CFLAGS += -I../../../../../usr/include
 TEST_GEN_FILES := hwtstamp_config rxtimestamp timestamping txtimestamp
 TEST_PROGS := txtimestamp.sh
 
-all: $(TEST_PROGS)
-
 top_srcdir = ../../../../..
 KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
-
-clean:
-	rm -fr $(TEST_GEN_FILES)
-- 
2.17.1

