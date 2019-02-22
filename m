Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3109E20878
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP+p1d8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfBVMyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:54:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfBVMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:53:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so2250376wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBwzVVFrwl/lt9+IMfY2XIzbrADnd5gfL2MVdMoEoBA=;
        b=SP+p1d8f0BVnFGmwpzP5ObmgqSe7l5anq9SYK3Z0/3NQEWTdLTfJgPvtmksh4rCpqp
         IfRqUp24iOQF92rOfMBXwE8SN4Qg9+J3Ff0nPtSyfwTEqbyNm+DeeN5PWzbyT11CnE2+
         NiNjrCubovAK/wbw8TnBd9rAdhYi2JGQm/9ZBjiURbGSLjfWJPtszQ5Wp43UoL05Tluv
         TlBFrRQljeAOUxOv3LCaFgOpw7HH2il9JHvSEnJIjNEhD/hw3TxMJV0heNgWZ4hyYnqc
         k67G6tBgxNf5nw4KsRQIR60AgXHPgBerP6BueL5DUb/aboLZYnGfKfMCtobiEEHXKnw+
         xU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBwzVVFrwl/lt9+IMfY2XIzbrADnd5gfL2MVdMoEoBA=;
        b=oigfOm4RT4gKp2a1OS5p956H4ZzoeKzOQsiFnUtlsLZU7va3y5DU03cx7XOfuXcs7z
         WGbntsDues0xxfzZHHgsFw2E5vV6Uua3yCvOHITyXHEAi7un8FHG/SJhB9/soQS1ACyI
         0SeSrZC0p0u1JQgCOFwYMWaE0ygdf5MCnwAWGL8Ys79i3jq6NnIrknIS2U3sbteF8XmK
         gz+XY/XlAcppY1yjPTpg1vbWbVbJ9jtnRM2ipWH+ozG/YDJU9iuYWwd2PeeGzF67GH+x
         DN/24MF+cyMFr1PbEPhWLKSLLzuvVY412bMvK5mX3+5b2cVCAup8Ruoq5jFu6gz++IZG
         p0dw==
X-Gm-Message-State: AHQUAubvkWPX7uBnH+9ieCcqmAu3xB8lfqZcy5ocC35nMBc8LXJ5IO7w
        XyWYj0NbzK8udgAkexDm3NYsGQ==
X-Google-Smtp-Source: AHgI3IZQ0MX6sfukCDFdoJfLKBs/7VPcUCMns2qTz5bt2s0RG4yqp/Tz4fV7jNtbv7px50I5nWPT9w==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr3073265wrp.164.1550840031452;
        Fri, 22 Feb 2019 04:53:51 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:53:50 -0800 (PST)
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 11/12] arm64: update Documentation/arm64/tagged-pointers.txt
Date:   Fri, 22 Feb 2019 13:53:23 +0100
Message-Id: <e555d752859291bc74d550a5ea7e8ecd1876a308.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
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
2.21.0.rc0.258.g878e2cd30e-goog

