Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F8C282DB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE2F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LLp3cF71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBDByl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 20:54:41 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:47475 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbfBDByl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 20:54:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x141rNQN008993;
        Mon, 4 Feb 2019 10:53:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x141rNQN008993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549245205;
        bh=3ZnGgtKPoc0ZuFDxzJZCCpJljtU9NUQgpqwHwbBwNSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLp3cF71m2uYNFZeSPKqDBh1seL+z8mk1hCJhQ9ZsY6JAuFAr885qIS1iwYW2i6Iq
         ro3bGuYMMGGn2dqX2wkDQjdmVQEz0PmjXLwfDl0OTm7pRUwVZQcQiKcr+gpcjC0dRW
         AJo+MZfv1GdhTEjp6c2cnZzQIkHshHdoRdrEh7r+B+QwlAq5N1590LDsVL1+fEThQC
         dsrLafCzCf4Hj2TObqrSV66mY5OWwIpZgWwt09tjZd52+o0bdtn9XumUpTAxC1VA9E
         dPqgm1pmx2W3sB4Wcbz1S/xnIPgnoJ43K66dQ+LUKuCwBN8OaQzHRUGwddHJcTd4eY
         ilsyWhHgCKFjQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        nixiaoming <nixiaoming@huawei.com>,
        Jan Beulich <JBeulich@suse.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 2/3] kallsyms: remove unneeded memset() calls
Date:   Mon,  4 Feb 2019 10:53:17 +0900
Message-Id: <1549245198-6182-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549245198-6182-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549245198-6182-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global variables in the .bss section are zeroed out before the program
starts to run.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index fc00bb0..f1b5749 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -596,9 +596,6 @@ static void insert_real_symbols_in_table(void)
 {
 	unsigned int i, j, c;
 
-	memset(best_table, 0, sizeof(best_table));
-	memset(best_table_len, 0, sizeof(best_table_len));
-
 	for (i = 0; i < table_cnt; i++) {
 		for (j = 0; j < table[i].len; j++) {
 			c = table[i].sym[j];
-- 
2.7.4

