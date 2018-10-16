Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5CBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F5520866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxWmFvQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F5520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJPOxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:53:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeJPOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:53:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so10396297pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FAowNU2Le7w5YJvjpIycOrYvvQJDBUjpEbsXPhhb+kM=;
        b=LxWmFvQhBF2jJwTFicVPM3wXKKOegEt5rsmKhLXvwFJ7+5t1caw9PfIVHihvrr3+FN
         wizs5h1OZDr1ed+5tX7J3gfYcL8eV0or+cHxj3gtfx4maGvZzUcgfgs5+sz9EKBgZTSR
         reHTZXVh5MlqFRrhdQtbWgIgu9pXPNzL1ceWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FAowNU2Le7w5YJvjpIycOrYvvQJDBUjpEbsXPhhb+kM=;
        b=pOvXHVYh64SZpO2QBhb9lu8WortAelyL7CbJS5DyovuSO9Q91/uY8NCD5h1rG2PcVw
         zqFqgACZrlpYH/WWIVSqw4BQTl+YsdWidMrQQwpS+fv3wyErwyzx68XPmkKsDB8hMgOv
         psXVUs6T1icPSN5pX2azwkfkOEUdE+M3BLLTt4uxun3ympAIRBD5Bu8h5YRHSl3pBfsa
         ZToITMIRui797JXgB1nFowwaao9GbV2zfNF+FnsoVXyByzx4T5xQ7RCDPN4SPJvW0IDX
         UDVDQBQc2OQnqqOJGLI4QKITwmawmSodgiaYL0hnssePoCIudQQFF1RALQrsV/A/VuTA
         JeLg==
X-Gm-Message-State: ABuFfojo7eugdqB2gJYOfJMNXcok/xSv4s5Xd6GJK3hpe6EpE6Mmcssx
        0C9NNwFHVmURK+Ifl4MwcgqUvg==
X-Google-Smtp-Source: ACcGV62T7ClwqFF6oijL81mLD+e8pGRlw08UTtITH+aErZGrAI9FZBN32oV4yVlF3tTye2Vc/Xsp0w==
X-Received: by 2002:a62:ce83:: with SMTP id y125-v6mr20957910pfg.201.1539673457368;
        Tue, 16 Oct 2018 00:04:17 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u21-v6sm21775107pfa.176.2018.10.16.00.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:04:16 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 2/5] parisc: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Tue, 16 Oct 2018 12:33:35 +0530
Message-Id: <1539673418-7279-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
References: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in PARISC architecture. This macro is currently the
part of uapi/asm/unistd.h file. We have to change the value
of __NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file. The
syscall.tbl file contains the number of system call inform-
ation. So we have two option to update __NR_Linux_syscalls
value.

1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system call
   or delete an existing system call.

2. We can keep this feature it above mentioned script, that
   will count the number of syscalls and keep it in a gener-
   ated file. In this case we don't need to explicitly update
   __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved
the __NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/
unistd.h. The macro __NR_syscalls also added for making the
name convention same across all architecture. While __NR_sys-
calls isn't strictly part of the uapi, having it as part of
the generated header to simplifies the implementation. We also
need to enclose this macro with #ifdef __KERNEL__ to avoid
side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 2 ++
 arch/parisc/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 93fd9f6..d30fdbcb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -4,6 +4,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __NR_Linux_syscalls     __NR_syscalls
+
 #ifndef __ASSEMBLY__
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..f10d065 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,9 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#ifdef __KERNEL__
+#define __NR_syscalls           351
+#endif
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1

