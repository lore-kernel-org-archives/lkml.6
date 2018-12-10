Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3816C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8954E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmCoquOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8954E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeLJMvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:51:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50831 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeLJMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:51:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so10865008wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ngEuYePF0Ik8OjXWCCgTn5YSoHew/I/tp51mGRx8kg4=;
        b=CmCoquOIItufHfboXmnykNLOniuP3oph0acoA+XTBGrVSB7mLajVT1E+hcpN/loM2U
         pgTqfe0K46l6v8uQ0po6d+HH/BYTwg03g4AD3w73FEou0gcZfxKBvZoNJNbXyq/i9XXq
         oWIL8wgRBrxDFD26bNkbcOl20YzQpb3jqpOq4y7dvxu1hztX+EIEmh8/dbUf5WisLWNC
         nJQM6fa0ao0AoCzQ9ilewLkC5FCYnwtOcEWLjmZXH3V3s+2vp4n9VdbDuwx1wbwkHrB5
         jrV/DTMHI0R2v5vA8+fGBVABLCaGz/a67XaqV0DDQBL/XUY+fQXzNAstsF+zSaEwaMrF
         3tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngEuYePF0Ik8OjXWCCgTn5YSoHew/I/tp51mGRx8kg4=;
        b=kKAoxqf8/mALM/J9/eyEjfNg53ucLTHPK4s6a2bU0ThtbGFcPzqLioziDrBun/ap8q
         BC0R6fIKhtRLnNpJkvl9aNDRLuqiUqSzhR/gY5xLRR6E7GWNaFm8lW/9/7A+3+/QNcmW
         RMRFh+v8E2WXhVUs7/7QAE1WJgsUZTmp+Jvyyud3A0bh4B6shFfSbD/pDIEQRmEA2+lr
         8AfTRPNSWi4yVAuGupLCy8nVnGXjlyvnvzYMjCvZuzn8DhfbbUFIrSON5nShlcD4BhQ2
         CBD16nxQt2WCVtYoT67zcVzp98b+mrckpbgfYGeTvPTqtbr+GZ+k23gk9d2zRoJLisyT
         tqcg==
X-Gm-Message-State: AA+aEWYZ5I4geajiBOYpWNjGIdXhCgBT41ciIMtT+Ggd0ne9SivmyXn8
        ZEoh1LvgcsT+beAhkAPVJjD6IA==
X-Google-Smtp-Source: AFSGD/WCzFmonEHgoYAEBEhZecfqFKbM9P4hOtWijVGXyq92rKZT6lTyCBXPbqUfxWdZxWq3rWTdTg==
X-Received: by 2002:a1c:da92:: with SMTP id r140mr11005051wmg.136.1544446279827;
        Mon, 10 Dec 2018 04:51:19 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:51:19 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v9 7/8] arm64: update Documentation/arm64/tagged-pointers.txt
Date:   Mon, 10 Dec 2018 13:51:04 +0100
Message-Id: <5b08153a9d69a5aa958071dcc5477c881f56dcde.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the changes in Documentation/arm64/tagged-pointers.txt.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..f4cf1f5cf362 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -17,13 +17,22 @@ this byte for application use.
 Passing tagged addresses to the kernel
 --------------------------------------
 
-All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+The kernel supports tags in pointer arguments (including pointers in
+structures) for a limited set of syscalls, the exceptions are:
 
-This includes, but is not limited to, addresses found in:
+ - memory syscalls: brk, madvise, mbind, mincore, mlock, mlock2, move_pages,
+   mprotect, mremap, msync, munlock, munmap, pkey_mprotect, process_vm_readv,
+   process_vm_writev, remap_file_pages;
 
- - pointer arguments to system calls, including pointers in structures
-   passed to system calls,
+ - ioctls that accept user pointers that describe virtual memory ranges;
+
+ - TCP_ZEROCOPY_RECEIVE setsockopt.
+
+The kernel supports tags in user fault addresses. However the fault_address
+field in the sigcontext struct will contain an untagged address.
+
+All other interpretations of userspace memory addresses by the kernel
+assume an address tag of 0x00, in particular:
 
  - the stack pointer (sp), e.g. when interpreting it to deliver a
    signal,
@@ -33,11 +42,7 @@ This includes, but is not limited to, addresses found in:
 
 Using non-zero address tags in any of these locations may result in an
 error code being returned, a (fatal) signal being raised, or other modes
-of failure.
-
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
-strongly discouraged.
+of failure. Using a non-zero address tag for sp is strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
 address tags may suffer impaired or inaccurate debug and profiling
-- 
2.20.0.rc2.403.gdbc3b29805-goog

