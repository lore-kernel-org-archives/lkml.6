Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2279yOxD74m5mvaWTgPcp2XyKvbYHvQVaC3fla72Q6zVN/HBeerMiPq4pMDZEx8US+gImkzr
ARC-Seal: i=1; a=rsa-sha256; t=1518347463; cv=none;
        d=google.com; s=arc-20160816;
        b=Wf54qY+eI0vF7Q7HxjyuU6D70I6Ukaum4qBdORgikWMU6Ptjt2NJtVvmWbAcQqGq7X
         uN5MAURSnvY4y/l1H9DEA5w/tqYy0udY4U7RssEy4eHvXfxAl3cNpf+Cjbkh4+lJKgJN
         f0D17K1o/8iQNKEIFhEl/FOWNk9mCM3LKzh2dLujc2Av8eMwxo50e64U4zzIGniJ363P
         oHyoRCmjEXW1oPw29vSseQcpVupvqro6e92BI0jPhXCcva7R3UI9323Y1W1F1/+EfpIV
         lyqyL+8/L2+DEOYxNU0NZOD8W68AvaG4ls+SXAjkFsjHmB3pKSsybHh4HW1ZWl9867Ui
         hxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:to:from:arc-authentication-results;
        bh=Mp9mm+Lza4Hxfr93wFw5lrJlO8bDZCz3qf+8Uvh9qLc=;
        b=A8uZ2C4nZLfK+Y1i9L+CtQDbOmhPMQOzd61i2OTsgz8SuPP0C980+VWd1a8NYO8ZXy
         3Cl32YHx4euMWMqKHQp0qU5yLzKLPcTMHYWBOU+qz9QEaqSN+3hSn/+DXlaiHGSP3NZg
         jBhOgxyCDfMUEGKl5vOggXWqrpFTA7DrKZRu99uBOYAQ+CpIDG4HJNQd0++WePjaznDL
         wN26xk/xL5lq2JumDrAGu9xINCM9Hwwr0VDnOQ4T3hHzemG37ckki0nm+DjG3Ba6f8TV
         wk9RigBjYdV2V4BoWiMdH+98NAEiC7tgblLgZZHL6LzSOGIXCZApV8cm2HWpTBA8Mf5Y
         +Mqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbeBKLLC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:11:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:40614 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752812AbeBKLLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:11:02 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org
Subject: [PATCH 1/5] selftests/x86: 5lvl test has been moved
Date: Sun, 11 Feb 2018 12:10:09 +0100
Message-Id: <20180211111013.16888-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211111013.16888-1-linux@dominikbrodowski.net>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102709871860610?=
X-GMAIL-MSGID: =?utf-8?q?1592102709871860610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes: 235266b8e11c "selftests/vm: move 128TB mmap boundary test to generic directory"
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 10ca46df1449..ce2615a2d105 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,7 @@ TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt ptrace_sysc
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip 5lvl
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
 
 TARGETS_C_32BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_32BIT_ONLY)
 TARGETS_C_64BIT_ALL := $(TARGETS_C_BOTHBITS) $(TARGETS_C_64BIT_ONLY)
-- 
2.16.1

