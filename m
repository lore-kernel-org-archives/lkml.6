Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5003121907
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="D1+COK9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbeLUDM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:12:59 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:53265 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbeLUDM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:12:58 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wBL3Ci1p003819;
        Fri, 21 Dec 2018 12:12:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wBL3Ci1p003819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545361965;
        bh=sPoUWgm9HoTObFyYcNyHA9wD9gNx+jYnO+blEKMDeJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1+COK9RzxFZQJvuqL19LNaQDQdet8mQnLEhTxsnijMbqjWv14oiJB+swLCchj5ek
         8y0wHpPWfdyHs540RyRIBdBlN0tHhwmM7W2Rq+4Lg95o/TYbu51bT4+nh9kFNnlGZn
         ZuR24M39PzexLa7Qba9+dqF3LKTWhVsYgpS78+O/QzGVfa7orS9m/GTPMWjjRObbg5
         1Orz8QSuiwsEIIhz0qKiw2hywauQUIk2J7PpM3obJ1QZNy2Mkmg0sjpvombKvqqe/0
         XcdTBc8SPJk6ZjGtPguSIIsUeO3FITl7vRipy38FuoUctC9YrKJZZUTLatNz542NFl
         yMEh0w6AWEY2Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] firmware: remove unnecessary patterns in .gitignore
Date:   Fri, 21 Dec 2018 12:12:40 +0900
Message-Id: <1545361961-31990-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545361961-31990-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545361961-31990-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit df85b2d767aa ("firmware: Restore support for built-in firmware")
should not have restored this .gitignore blindly.

What git should ignore is merely *.gen.S now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 firmware/.gitignore | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/firmware/.gitignore b/firmware/.gitignore
index d9c6901..9c8bdb9 100644
--- a/firmware/.gitignore
+++ b/firmware/.gitignore
@@ -1,6 +1 @@
 *.gen.S
-*.fw
-*.bin
-*.csp
-*.dsp
-ihex2fw
-- 
2.7.4

