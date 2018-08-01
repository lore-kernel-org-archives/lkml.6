Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4076C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D70920841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqfOhZ6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D70920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeHAUQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:16:54 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:41102 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbeHAUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:16:53 -0400
Received: by mail-it0-f73.google.com with SMTP id w132-v6so32610ita.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E0pOoV86/sap3VuxCkq6uFz8gZPwpjEJfKICnjceoZ0=;
        b=aqfOhZ6FRy2ioyzCjxdL/cLCDqaSL9SwI6gd2LaExafojxciUD8Jgnoqu1+28Qsbmf
         vWT0+gxOr8DWuxGI3uR9zXjyBkjklYQDiG/6/r/dYNzcfzixuQ34tjTQ/LV3Jkg4d9q3
         Iqpt+4T+XQsZseRpWyPTIc5m3dV9c+LaWxm6AVJvKzDyz5mdCjVqPH7kIZtqsx/DYOHx
         dsqyviNp1fdYSebgZObaEp1asCj6e5D2bSFQAp53hxF6Y2SpEdFpjIZpbLRxvREV/Zd1
         SNKjGWQyne/lZs5jke14WnP2wQ1jduAiRDtWLuP0JKcE6LQ79o+5lhnxZICFitlJPuhS
         1AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E0pOoV86/sap3VuxCkq6uFz8gZPwpjEJfKICnjceoZ0=;
        b=W1GNT60zxKOnW5seuBTT5ZcOUoNxmqsLYRlBy0ulyTSEb6yJL2AFm6yBVl/geF17pW
         2fqEq/e88MuCM0iT5nF4vml5OQ1BXO0uZoP/zasJlYWQi3D3YcjChApWuIG/1PaDLOeI
         T4Vl2wUEBVZaSLDRlvVGVe0OR+oD0+e++fRfs/DDv6IdOrds4k2IdWwHO+pCpGWHbH24
         zTpJMEx5Nu3OCEKZ5a0eaFdaog+kL4FNX22d5s6qRyJ6Ey6oVog1771QBsBpHi2PSfIY
         V1bEnpaTt+XuLRWf6wDmcH+gUg5rPraTMrReU3rLEpDXUu3PbTf713REf6xqBb/85sCk
         B7Yg==
X-Gm-Message-State: AOUpUlHex4KooEI+a1bPvcIF4mIwrRI5Qf7Nb35pgICep2nbLm33ZFOL
        e6/Tu7rikWHju8HtejgY9Y78cvr0bBmz/GWWMgA=
X-Google-Smtp-Source: AAOMgpcc9L8E7dW6ed5fUeis3PaULv2qAfm2LhAIze+syT3PLNXxiTeEPQhOWjaxeiVLdCiF+vQhwVePxvzbS69twF4=
X-Received: by 2002:a6b:6310:: with SMTP id p16-v6mr10561579iog.43.1533148191800;
 Wed, 01 Aug 2018 11:29:51 -0700 (PDT)
Date:   Wed,  1 Aug 2018 11:29:43 -0700
Message-Id: <20180801182943.22176-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] sh: dwarf: prefer _THIS_IP_ to current_text_addr
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     akpm@linux-foundation.org, alexander.levin@verizon.com,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to reduce the code duplication between _THIS_IP_
and current_text_addr(), let's consolidate callers of
current_text_addr() to use _THIS_IP_.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sh/kernel/dwarf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index 1a2526676a87..bb511e2d9d68 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -599,7 +599,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 	 * time this function makes its first function call.
 	 */
 	if (!pc || !prev)
-		pc = (unsigned long)current_text_addr();
+		pc = _THIS_IP_;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/*
-- 
2.18.0.597.ga71716f1ad-goog

