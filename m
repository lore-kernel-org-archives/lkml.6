Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F75C282DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292B42082C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="K7GtuYsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfBDBys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 20:54:48 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:47654 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbfBDByr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 20:54:47 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x141rNQM008993;
        Mon, 4 Feb 2019 10:53:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x141rNQM008993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549245204;
        bh=oNydtwERVpbddTeO5/87kDpAW3quEv1odTeJy35hRtw=;
        h=From:To:Cc:Subject:Date:From;
        b=K7GtuYsQmL0rWx5SIuEm2ZntkvgkNmg3lPIf8eWtRFGCNUbfXYcF/2Ngb2FdB7PwB
         DoRB+p392tGLhOvCBnwoGjEc4dvy1cffjhlU/OwC3q7oiEghTfUqWjCiWnXu4f3k9e
         +sjJ8kn6xIGahKlWn4nvzraVkiU6uM35/yaEbiJ1t+3RjQkbhQNnGWrtJRK/2rUywj
         CzqwR0eU2fCBo6Wk/MYufffJohOlqa8l6z5fR0epg4SBGmu+f+fRNCxx7gggUdAmPG
         hEZMbzVR0RwPtFgi9rbluXbPA9SUM23I8aSUsjfyI0yo8H2Wc8xUJ8TJxJd7mX56i3
         KPoBN8X7CCGkQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        nixiaoming <nixiaoming@huawei.com>,
        Jan Beulich <JBeulich@suse.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 1/3] kallsyms: add static qualifiers where missing
Date:   Mon,  4 Feb 2019 10:53:16 +0900
Message-Id: <1549245198-6182-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

scripts/kallsyms.c:65:5: warning: symbol 'token_profit' was not declared. Should it be static?
scripts/kallsyms.c:68:15: warning: symbol 'best_table' was not declared. Should it be static?
scripts/kallsyms.c:69:15: warning: symbol 'best_table_len' was not declared. Should it be static?

Also, remove 'inline' from is_arm_mapping_symbol(). The compiler
will inline it anyway when it is appropriate to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 77cebad..fc00bb0 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -62,11 +62,11 @@ static int all_symbols = 0;
 static int absolute_percpu = 0;
 static int base_relative = 0;
 
-int token_profit[0x10000];
+static int token_profit[0x10000];
 
 /* the table that holds the result of the compression */
-unsigned char best_table[256][2];
-unsigned char best_table_len[256];
+static unsigned char best_table[256][2];
+static unsigned char best_table_len[256];
 
 
 static void usage(void)
@@ -80,7 +80,7 @@ static void usage(void)
  * This ignores the intensely annoying "mapping symbols" found
  * in ARM ELF files: $a, $t and $d.
  */
-static inline int is_arm_mapping_symbol(const char *str)
+static int is_arm_mapping_symbol(const char *str)
 {
 	return str[0] == '$' && strchr("axtd", str[1])
 	       && (str[2] == '\0' || str[2] == '.');
-- 
2.7.4

