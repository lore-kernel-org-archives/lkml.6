Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5431DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4862081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXht8r8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4862081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeKIAMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:12:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33380 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeKIAMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:12:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so11162987wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfT6+8vP45oXrV17rGSZ9pzYS0my+RLSPjgVa2gqAd4=;
        b=UXht8r8Y+LVp07kCtfXSBeRBhpCaVOvYm1P+l9gMKK/QSvkAY4eFI/F/7dNdhFa+6s
         03WsHwOPySnNl0C8RLlGZrgGNvf5upI9wpT2QD8fZu8QPcUo14dOOKGhsT3Vt3N2Xsfz
         jNCbI1daeAMYzEOF5k+/52Kcgvpjbbd1ZJorRlAFSppDB08ydUZoSHLoh0bXliV119yC
         tyWxnr6yN/1x8ngIwCnTTq6z3enqkxHT7u0Gob0KyEf1crq1MQb3JzblYwR/nihHzcHC
         ZK14++eId0uzOYOuwdG4frYt1cxu7q2wA7WvAPLwPwotre1YMk4rWNPG7CM0tgU1zuH6
         v3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfT6+8vP45oXrV17rGSZ9pzYS0my+RLSPjgVa2gqAd4=;
        b=exKskDr6FaN6oP1T8FcKQ1Cipj+qOS3H92yjJDkYCr8oRP9fJdwEM6ETRQOpbzogxU
         /Lb+DF8UdXjXdAGzJjGRcHP7nST6azG0n4+erY4HQAVLJH6lI3rexrerMcsPLOljl3NK
         YwTZuIFGYsfQsKpD/6LhmWzlaNiQ5xxBPX3RD/LhD8aKETC49gRuxqTyDUYOWpawHSss
         YsnUgm9Oj5CoY5QZesRGyFmnCovIXsVDs3RM1MZH7zGirtOtoj5FkV238OV8N9edfG2o
         cQkg0jKH4jdbRAIyJZVsM5voYOqpfFks8upxHIbgA60bSUjLq+YBz9Ds6jRdBq/qrdfV
         8zlg==
X-Gm-Message-State: AGRZ1gJ8aPH5wijhvj88u/iti6Ajj27E80uHAyz3rrI2coe/kel+89Mh
        XQMnz9JJnwLbULjkZ509ni28zg==
X-Google-Smtp-Source: AJdET5cd+Vxy+CiHtQ9mm6FtFF35wdB6lNLfr2BV8z1ME65fDt3kZ6JEKazzaGEHLM0pA02L2pbaZA==
X-Received: by 2002:a05:6000:1182:: with SMTP id g2mr4510493wrx.310.1541687790933;
        Thu, 08 Nov 2018 06:36:30 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id k5-v6sm5421068wre.82.2018.11.08.06.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 06:36:30 -0800 (PST)
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
Subject: [PATCH v8 7/8] arm64: update Documentation/arm64/tagged-pointers.txt
Date:   Thu,  8 Nov 2018 15:36:14 +0100
Message-Id: <8526edb07fd5a762847306bba89fbadbb19210b7.1541687720.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
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
2.19.1.930.g4563a0d9d0-goog

