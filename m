Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D12C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A187420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0/h3p8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A187420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeJXGCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:02:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46901 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbeJXGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id o2-v6so2328336lfl.13;
        Tue, 23 Oct 2018 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=6qJTNFwbH1TFDI3gbUvOjFkxUhT0SMG0kbjMlNfa96U=;
        b=A0/h3p8FiatFWDDQDLLr5RaEKmvC2OBV5CByt0aO7U3tkHCDzbEKHcuvyKbqrM79at
         B3DmjiNeG77aasQEPLLhdRBHG9rpmRDrnVbE6D9rhTdkzgvnT7f6dY1oLcu077JMxoik
         oRTu7OWVsK8ogbADS7YVE4uEMP7Jx8pQXNI0XrGPOLmrSR9F9jYgv3/3p4O14ws5XB6X
         gVath+ld78AmukgiCr7IMQoqAAGvV63hUhU06m1gmhZ1As5SPVAUMdI4bAmQmxaGVFaU
         YKggE6rs4nc+lXTGeyf/x4UDHs0bWe/8c8zeqPEGH0Sf4MdWx3soJY8ZzG/wnD/5ZN6J
         fWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=6qJTNFwbH1TFDI3gbUvOjFkxUhT0SMG0kbjMlNfa96U=;
        b=SAakgKUA2KEdKFV+oe/AD04ZQA06ucLt1HKJYjiHkxWV0G/Tof4FITDCPEfdkonvTH
         fmzc2cDF7Penmohwu1pRwdwP4K20FvNbCFpo66w3pRx5eKoLbzbOOx7difEH3RRuZUqS
         tN1Lar8X+QxqOF+GbMXlgiRtK4Yh51L+EzF/dvkNKLOytk2fN7ZtUGF1dkMZPiUFUOzi
         hLAcewnCkrjuhqZ7yAqhAxRWmbsJiq/RoR0efCMaoM1yOwURLn3Arx2A7dXS5SVwa9N7
         GTi7jIMGMwM/vd5XNgK8ad5JXgW5Nu9lrolowcGemLN8IhpkhtTC2GN6NLOBf22wh1sb
         Am9Q==
X-Gm-Message-State: ABuFfohVoo5xPRhL1VamfZXoaqIskA/7lYC/ek7g5fl9ie21mhYvu5HN
        opzbBeq47VE4WwrI8eOPc9M=
X-Google-Smtp-Source: ACcGV60oU4v9dmfm2pngODIU85Xo5lMoQ72mDmXmBqMbWj/N/dPKow1IaFhEzTDAdhPWjJt0crJx8Q==
X-Received: by 2002:a19:2102:: with SMTP id h2-v6mr12783512lfh.119.1540330571974;
        Tue, 23 Oct 2018 14:36:11 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:11 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] prmem: documentation
Date:   Wed, 24 Oct 2018 00:34:57 +0300
Message-Id: <20181023213504.28905-11-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for protected memory.

Topics covered:
* static memory allocation
* dynamic memory allocation
* write-rare

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Randy Dunlap <rdunlap@infradead.org>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/core-api/index.rst |   1 +
 Documentation/core-api/prmem.rst | 172 +++++++++++++++++++++++++++++++
 MAINTAINERS                      |   1 +
 3 files changed, 174 insertions(+)
 create mode 100644 Documentation/core-api/prmem.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 26b735cefb93..1a90fa878d8d 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -31,6 +31,7 @@ Core utilities
    gfp_mask-from-fs-io
    timekeeping
    boot-time-mm
+   prmem
 
 Interfaces for kernel debugging
 ===============================
diff --git a/Documentation/core-api/prmem.rst b/Documentation/core-api/prmem.rst
new file mode 100644
index 000000000000..16d7edfe327a
--- /dev/null
+++ b/Documentation/core-api/prmem.rst
@@ -0,0 +1,172 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _prmem:
+
+Memory Protection
+=================
+
+:Date: October 2018
+:Author: Igor Stoppa <igor.stoppa@huawei.com>
+
+Foreword
+--------
+- In a typical system using some sort of RAM as execution environment,
+  **all** memory is initially writable.
+
+- It must be initialized with the appropriate content, be it code or data.
+
+- Said content typically undergoes modifications, i.e. relocations or
+  relocation-induced changes.
+
+- The present document doesn't address such transient.
+
+- Kernel code is protected at system level and, unlike data, it doesn't
+  require special attention.
+
+Protection mechanism
+--------------------
+
+- When available, the MMU can write protect memory pages that would be
+  otherwise writable.
+
+- The protection has page-level granularity.
+
+- An attempt to overwrite a protected page will trigger an exception.
+- **Write protected data must go exclusively to write protected pages**
+- **Writable data must go exclusively to writable pages**
+
+Available protections for kernel data
+-------------------------------------
+
+- **constant**
+   Labelled as **const**, the data is never supposed to be altered.
+   It is statically allocated - if it has any memory footprint at all.
+   The compiler can even optimize it away, where possible, by replacing
+   references to a **const** with its actual value.
+
+- **read only after init**
+   By tagging an otherwise ordinary statically allocated variable with
+   **__ro_after_init**, it is placed in a special segment that will
+   become write protected, at the end of the kernel init phase.
+   The compiler has no notion of this restriction and it will treat any
+   write operation on such variable as legal. However, assignments that
+   are attempted after the write protection is in place, will cause
+   exceptions.
+
+- **write rare after init**
+   This can be seen as variant of read only after init, which uses the
+   tag **__wr_after_init**. It is also limited to statically allocated
+   memory. It is still possible to alter this type of variables, after
+   the kernel init phase is complete, however it can be done exclusively
+   with special functions, instead of the assignment operator. Using the
+   assignment operator after conclusion of the init phase will still
+   trigger an exception. It is not possible to transition a certain
+   variable from __wr_ater_init to a permanent read-only status, at
+   runtime.
+
+- **dynamically allocated write-rare / read-only**
+   After defining a pool, memory can be obtained through it, primarily
+   through the **pmalloc()** allocator. The exact writability state of the
+   memory obtained from **pmalloc()** and friends can be configured when
+   creating the pool. At any point it is possible to transition to a less
+   permissive write status the memory currently associated to the pool.
+   Once memory has become read-only, it the only valid operation, beside
+   reading, is to released it, by destroying the pool it belongs to.
+
+
+Protecting dynamically allocated memory
+---------------------------------------
+
+When dealing with dynamically allocated memory, three options are
+ available for configuring its writability state:
+
+- **Options selected when creating a pool**
+   When creating the pool, it is possible to choose one of the following:
+    - **PMALLOC_MODE_RO**
+       - Writability at allocation time: *WRITABLE*
+       - Writability at protection time: *NONE*
+    - **PMALLOC_MODE_WR**
+       - Writability at allocation time: *WRITABLE*
+       - Writability at protection time: *WRITE-RARE*
+    - **PMALLOC_MODE_AUTO_RO**
+       - Writability at allocation time:
+           - the latest allocation: *WRITABLE*
+           - every other allocation: *NONE*
+       - Writability at protection time: *NONE*
+    - **PMALLOC_MODE_AUTO_WR**
+       - Writability at allocation time:
+           - the latest allocation: *WRITABLE*
+           - every other allocation: *WRITE-RARE*
+       - Writability at protection time: *WRITE-RARE*
+    - **PMALLOC_MODE_START_WR**
+       - Writability at allocation time: *WRITE-RARE*
+       - Writability at protection time: *WRITE-RARE*
+
+   **Remarks:**
+    - The "AUTO" modes perform automatic protection of the content, whenever
+       the current vmap_area is used up and a new one is allocated.
+        - At that point, the vmap_area being phased out is protected.
+        - The size of the vmap_area depends on various parameters.
+        - It might not be possible to know for sure *when* certain data will
+          be protected.
+        - The functionality is provided as tradeoff between hardening and speed.
+        - Its usefulness depends on the specific use case at hand
+    - The "START_WR" mode is the only one which provides immediate protection, at the cost of speed.
+
+- **Protecting the pool**
+   This is achieved with **pmalloc_protect_pool()**
+    - Any vmap_area currently in the pool is write-protected according to its initial configuration.
+    - Any residual space still available from the current vmap_area is lost, as the area is protected.
+    - **protecting a pool after every allocation will likely be very wasteful**
+    - Using PMALLOC_MODE_START_WR is likely a better choice.
+
+- **Upgrading the protection level**
+   This is achieved with **pmalloc_make_pool_ro()**
+    - it turns the present content of a write-rare pool into read-only
+    - can be useful when the content of the memory has settled
+
+
+Caveats
+-------
+- Freeing of memory is not supported. Pages will be returned to the
+  system upon destruction of their memory pool.
+
+- The address range available for vmalloc (and thus for pmalloc too) is
+  limited, on 32-bit systems. However it shouldn't be an issue, since not
+  much data is expected to be dynamically allocated and turned into
+  write-protected.
+
+- Regarding SMP systems, changing state of pages and altering mappings
+  requires performing cross-processor synchronizations of page tables.
+  This is an additional reason for limiting the use of write rare.
+
+- Not only the pmalloc memory must be protected, but also any reference to
+  it that might become the target for an attack. The attack would replace
+  a reference to the protected memory with a reference to some other,
+  unprotected, memory.
+
+- The users of rare write must take care of ensuring the atomicity of the
+  action, respect to the way they use the data being altered; for example,
+  take a lock before making a copy of the value to modify (if it's
+  relevant), then alter it, issue the call to rare write and finally
+  release the lock. Some special scenario might be exempt from the need
+  for locking, but in general rare-write must be treated as an operation
+  that can incur into races.
+
+- pmalloc relies on virtual memory areas and will therefore use more
+  tlb entries. It still does a better job of it, compared to invoking
+  vmalloc for each allocation, but it is undeniably less optimized wrt to
+  TLB use than using the physmap directly, through kmalloc or similar.
+
+
+Utilization
+-----------
+
+**add examples here**
+
+API
+---
+
+.. kernel-doc:: include/linux/prmem.h
+.. kernel-doc:: mm/prmem.c
+.. kernel-doc:: include/linux/prmemextra.h
diff --git a/MAINTAINERS b/MAINTAINERS
index ea979a5a9ec9..246b1a1cc8bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9463,6 +9463,7 @@ F:	include/linux/prmemextra.h
 F:	mm/prmem.c
 F:	mm/test_write_rare.c
 F:	mm/test_pmalloc.c
+F:	Documentation/core-api/prmem.rst
 
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
-- 
2.17.1

