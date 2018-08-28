Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D33C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7402089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T95BkHmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7402089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeH1NEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:04:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35383 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH1NEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:04:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9-v6so474301plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sQYqTs3KalLIJHgMhjvXK8CYgG+y1HcpEC8mGDkiQzs=;
        b=T95BkHmNmUUVTKjW+K925gUu/ZtzlH8F8B7raoFlpxZ9wq5Mc4hJ6GLTU+d1iOjZ2q
         peq7PHLh7naKtWgeCWnx4TEFbjHwsDbSd6b23W4b5tsM4CK52mYGB4IqtVI2oqb9Gyvg
         qkNrVoEsoJQmcNLQ/yrJsvtAwOT2IuJqGicyHMC4kYVYov1qkndTIZGpgGXFXEYBX8mP
         8NLU8etIY4Y68QZMw5nyNJWiLgzE9MK5RtBHGQ6WwJAuFg5HUhTJPotvkym3OTgX7X/2
         Pdri1s9RsIsDcM+MjLfMrLBVPzbpjmRs3qtAvwvDO8xQufyHP85uiEUJjLJ3kL0tllCz
         VgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sQYqTs3KalLIJHgMhjvXK8CYgG+y1HcpEC8mGDkiQzs=;
        b=rcwie7/Cug5GKIjP8/Bwpnkwo4IdIaaqpPnRPdVshDlHUm4q2C36TT08jGqxxhkOl2
         9O48UetSzBdSypWNO3PYxNZcsPovcXGp9JyUpvKuW2GTy/LzBsCWpM9zeu1iSj9vmObr
         I6HdOx+iztE70eo7lpYE5rlOc6UzGOpxkhQMAgaHBdjM1ho2DCC11hrxX9oMSyk71irW
         21UxePM5XAQXVLrOtT7i8OoOkxlyaJMqybN22ZTS+4qLp+OKXtIVCw2VMso2CGyrT8L4
         zGAVRFaFlGaXCJvs4PW8nUZoARj5xc2ty7F9iKN9VrfP6DkZEIsQhxcOJy1rBrtwO2VO
         ZxBw==
X-Gm-Message-State: APzg51CsHS9IDEpJ0J84jz+CO15ZERg4hiTAobFeXIleuY+kGD/3n98V
        Hi0tVE0+b67ign+nJakqT5pxDS/r
X-Google-Smtp-Source: ANB0Vda3yIT/JcA0d8PM+A516KYGh93LqRmXBQMDFb4ALtdJLiSgI+w8UABf6MjGxNPlEI78r8kTYQ==
X-Received: by 2002:a17:902:158b:: with SMTP id m11-v6mr692158pla.102.1535447616977;
        Tue, 28 Aug 2018 02:13:36 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id l9-v6sm1083027pgg.79.2018.08.28.02.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:13:36 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nds32: Fix a kernel panic issue because of wrong frame pointer access.
Date:   Tue, 28 Aug 2018 17:12:21 +0800
Message-Id: <20180828091222.31672-2-greentime@andestech.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828091222.31672-1-greentime@andestech.com>
References: <20180828091222.31672-1-greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can make sure that trace_hardirqs_off/trace_hardirqs_on can get a correct
return address by frame pointer through __builtin_return_address() in this fix.

Unable to handle kernel paging request at virtual address fffffffc
pgd = 3c42e9cf
[fffffffc] *pgd=02a9c000

Internal error: Oops: 1 [#1]
Modules linked in:
CPU: 0
PC is at trace_hardirqs_off+0x78/0xec
LP is at common_exception_handler+0xda/0xf4
pc : [<b23ea5a4>]    lp : [<b2352eba>]    Tainted: G        W
sp : ada60ab0  fp : efcaff48  gp : 3a020490
r25: efcb0000  r24: 00000000
r23: 00000000  r22: 00000000  r21: 00000000  r20: 000700c1
r19: 000700ca  r18: 3a21b018  r17: 00000001  r16: 00000002
r15: 00000001  r14: 0000002a  r13: 3a00a804  r12: ada60ab0
r11: 3a113af8  r10: 3a01c530  r9 : 3a124404  r8 : 00120f9c
r7 : b2352eba  r6 : 00000000  r5 : 3a126b58  r4 : 00000000
r3 : 3a1726a8  r2 : b2921000  r1 : 00000000  r0 : 00000000
  IRQs off  Segment user
Process init (pid: 1, stack limit = 0x069d7f15)
Stack: (0xada60ab0 to 0xada61000)
Stack: 0aa0:                                     00000000 00000003 3a110000 0011f000
Stack: 0ac0: 00000005 00000000 00000000 00000000 ada60b10 3a01fe68 ada60b0c ada60b08
Stack: 0ae0: 00000000 ada60ab8 ada60b30 3a020550 00000000 00000001 3a11c2f8 3a01c6e8
Stack: 0b00: 3a01cb80 fffffba8 3a113af8 3a21b018 3a122c28 00003ec4 00000165 00000000
Stack: 0b20: 3a126aec 0000006c 00000000 00000001 3a01fe68 00000000 00000003 00000000
Stack: 0b40: 00000001 000003f8 3a020930 3a01c530 00000008 ada60c18 3a020490 3a003120
Stack: 0b60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0b80: 00000000 00000000 00000000 00000000 ffff8000 00000000 00000000 00000000
Stack: 0ba0: 00000000 00000001 3a020550 00000000 3a01d020 00000000 fffff000 fffff000
Stack: 0bc0: 00000000 00000000 00000000 00000000 ada60f2c 00000000 00000001 00000000
Stack: 0be0: 00000000 00000000 3a01fe68 fffffab0 00008034 00000008 3a0010cc 3a01fe68
Stack: 0c00: 00000000 00000000 00000001 ada60c88 3a020490 3a0139d4 0009dc6f 00000000
Stack: 0c20: 00000000 00000000 ada60fce fffff000 00000000 0000ebe0 3a020038 3a020550
Stack: 0c40: ada60f20 ada60c90 3a0007f0 3a0002a8 ada60c8c 00000000 00000000 ada60c88
Stack: 0c60: 3a020490 3a004570 00000000 00000000 ada60f20 3a0007f0 3a000000 00000000
Stack: 0c80: 3a020490 3a004850 00000000 3a013f24 3a000000 00000000 3a01ff44 00000000
Stack: 0ca0: 00000000 00000000 00000000 00000000 00000000 00000000 3a01ff84 3a01ff7c
Stack: 0cc0: 3a01ff4c 3a01ff5c 3a01ff64 3a01ff9c 3a01ffa4 3a01ffac 3a01ff6c 3a01ff74
Stack: 0ce0: 00000000 00000000 3a01ff44 00000000 00000000 00000000 00000000 00000000
Stack: 0d00: 3a01ff8c 00000000 00000000 3a01ff94 00000000 00000000 00000000 00000000
Stack: 0d20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0d40: 3a01ffbc 3a01ffb4 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0d60: 00000000 00000000 00000000 00000000 00000000 3a01ffc4 00000000 00000000
Stack: 0d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0dc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 3a01ff54
Stack: 0de0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0e00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0e20: 00000000 00000004 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0e60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0e80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Stack: 0ec0: 00000000 00000000 00000000 00000000 ffffffff 00000000 00000000 00000000
Stack: 0ee0: 00000000 00000000 00000000 00000000 ada60f20 00000000 00000000 00000000
Stack: 0f00: 00000000 00000000 00000000 00000000 00000000 00000000 3a020490 3a000b24
Stack: 0f20: 00000001 ada60fde 00000000 ada60fe4 ada60feb 00000000 00000021 3a038000
Stack: 0f40: 00000010 0009dc6f 00000006 00001000 00000011 00000064 00000003 00008034
Stack: 0f60: 00000004 00000020 00000005 00000008 00000007 3a000000 00000008 00000000
Stack: 0f80: 00000009 0000ebe0 0000000b 00000000 0000000c 00000000 0000000d 00000000
Stack: 0fa0: 0000000e 00000000 00000017 00000000 00000019 ada60fce 0000001f ada60ff6
Stack: 0fc0: 00000000 00000000 00000000 b5010000 fa839914 23b5dd89 a2aea540 692fc82e
Stack: 0fe0: 0074696e 454d4f48 54002f3d 3d4d5245 756e696c 692f0078 0074696e 00000000
CPU: 0 PID: 1 Comm: init Tainted: G        W         4.18.0-00015-g1888b64a2558-dirty #112
Hardware name: andestech,ae3xx (DT)
Call Trace:
[<b27a8e34>] dump_stack+0x2c/0x38
[<b2354874>] die+0x128/0x18c
[<b2356f4c>] do_page_fault+0x3b8/0x4e0
[<b2352ed4>] ret_from_exception+0x0/0x10
[<b2352eba>] common_exception_handler+0xda/0xf4

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/ex-entry.S |  2 +-
 arch/nds32/kernel/ex-exit.S  |  4 ++--
 arch/nds32/kernel/ftrace.c   | 12 ++++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/kernel/ex-entry.S b/arch/nds32/kernel/ex-entry.S
index b8ae4e9a6b93..21a144071566 100644
--- a/arch/nds32/kernel/ex-entry.S
+++ b/arch/nds32/kernel/ex-entry.S
@@ -118,7 +118,7 @@ common_exception_handler:
 	/* interrupt */
 2:
 #ifdef CONFIG_TRACE_IRQFLAGS
-	jal     trace_hardirqs_off
+	jal     __trace_hardirqs_off
 #endif
 	move	$r0, $sp
 	sethi	$lp, hi20(ret_from_intr)
diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
index 03e4f7788a18..f00af92f7e22 100644
--- a/arch/nds32/kernel/ex-exit.S
+++ b/arch/nds32/kernel/ex-exit.S
@@ -138,8 +138,8 @@ no_work_pending:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	lwi	$p0, [$sp+(#IPSW_OFFSET)]
 	andi	$p0, $p0, #0x1
-	la	$r10, trace_hardirqs_off
-	la	$r9, trace_hardirqs_on
+	la	$r10, __trace_hardirqs_off
+	la	$r9, __trace_hardirqs_on
 	cmovz	$r9, $p0, $r10
 	jral	$r9
 #endif
diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index a646a8339052..a0a9679ad5de 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -295,3 +295,15 @@ int ftrace_disable_ftrace_graph_caller(void)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+noinline void __trace_hardirqs_off(void)
+{
+	trace_hardirqs_off();
+}
+noinline void __trace_hardirqs_on(void)
+{
+	trace_hardirqs_on();
+}
+#endif /* CONFIG_TRACE_IRQFLAGS */
-- 
2.18.0

