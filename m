Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E540E218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdJsWL37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLRUxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:53:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36486 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeLRUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:53:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so16357242wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 12:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BOHy+hnH4lZnOs23lifYwnxqIe7rQvW+2oL4j+OiENU=;
        b=YdJsWL37R8oqruDF5Y2Wk55CvWa9UvYe5ev3P9fF+ZPbmFpiy1hz4aJPRp93hV9xLr
         PnlN2bUj1iBrGgRm2ImnKdi5Yufx3uEXv5P1cefwFDAujCZFcSOOVLGHLuj8lUH5dxhy
         b2jC+M6br0HN+/J/T2A1/ysD/BMk+HFmUO5r/jppCfpppuhRK7O6OCbeZWi4UB9Xk1Z6
         o/d4m3mpvrWfLGlbSzQ87k0958ZVeLSg4hiIgZ5V3X3fbXIiw+Uu20XFdEyK8+t6shpj
         rS3jBGu3h0iwk5NGbIRNajvSzzyk/DsheslfpIwW/viQ7IToJb6fbSXsxQAQGnawyca8
         TwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BOHy+hnH4lZnOs23lifYwnxqIe7rQvW+2oL4j+OiENU=;
        b=rqxCLIBuKEUD6Y/e9OMSYpXN37HpEBp6PTvReqRJ0X2SBN3xa1SNM3c31jyg1lJHBI
         1GyqnEq+FqoOSEXue8W1Mlv9xnGx8tgrYIKvrt6dDwUnevhzhznjWi5CqZ0EmoY1wr/V
         mI45apzIHMa4YqB//Gzlox1wqxay1rTUObjaIEC+Rx6mMN+IeUxTqOkhsbbu9ShmqioC
         9+hg/0ntnyTLpXxzIr3CHbWHPAfI0C5zNkVDwnrMoRZkYFtJGCIQwW5X6Mn6FoLambaC
         mHAT8TdeRB7Y+dpVX1eau+AjTXJs4dqdkUyikYyR3ylCP4xQG+0HSfu/DZq/nvUCSH8v
         wdnw==
X-Gm-Message-State: AA+aEWazaNIaaCOOF4CmdrDDCl3W5qAHyfuIbL6+IwrXjumk8/BMqX6P
        Zku9G4cVh3aCtxZ3csj/L+I=
X-Google-Smtp-Source: AFSGD/XuiRyxHTFbWbKnIE7zw66Ng50gg4JJ0q7b3tMlrhKzde0rk0I0qOjfXCGV4w08a4S14lcvhA==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr16727434wrs.117.1545166403353;
        Tue, 18 Dec 2018 12:53:23 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id m4sm3870895wmi.3.2018.12.18.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 12:53:22 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 44819114106E; Tue, 18 Dec 2018 21:53:21 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ptrace: fix empty-body warning
Date:   Tue, 18 Dec 2018 21:53:05 +0100
Message-Id: <20181218205305.26647-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit a225f1567405 ("powerpc/ptrace: replace ptrace_report_syscall()
with a tracehook call") an empty body if(); was added.

Replace ; with {} to remove a warning (treated as error) reported by gcc
using W=1:

  arch/powerpc/kernel/ptrace.c: In function ‘do_syscall_trace_enter’:
  arch/powerpc/kernel/ptrace.c:3281:4: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]

Fixes: a225f1567405 ("powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call")
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8314e8fed0ee..e1988892b3e7 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3277,8 +3277,8 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 		 * avoid clobbering any register also, thus, not 'gotoing'
 		 * skip label.
 		 */
-		if (tracehook_report_syscall_entry(regs))
-			;
+		if (tracehook_report_syscall_entry(regs)) {
+		}
 		return -1;
 	}
 
-- 
2.19.2

