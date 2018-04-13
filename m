Return-Path: <kernel-hardening-return-12989-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/keSi0nJ6GyB7i6w7wgtTjopZsoP0oAquT8BuOvm0Js/3XaySfuPD32My+XBS76i4n/KT5
ARC-Seal: i=1; a=rsa-sha256; t=1523627038; cv=none;
        d=google.com; s=arc-20160816;
        b=AAfuFlgcDxzyUH0+dHdWQg1O55COjWw0mEcROllb0QzqO+eicZTRG86bFsamNaeFpH
         Y1maMH1aEdK45tsXx/N7iTmODAOFUQs930N20/s7GwnzGsEnJusOJLoaLlJK03ejKYMF
         g0UjvNOK8G/NOIplyuXCgyD79tNBeumqodWwus+G/u41OgqDRyn5yb8wbLcuDHsyCOFq
         m/ySR4sJJ5t6ArQff1cHOT14e44ze+IdpRjo56gOY36bCp6VbmNMYA1USZ6b11cIGI+1
         4Wvl0sPs8LZME+hiUP97iYYSPEnPs5rVTAFVUwxc0w+L4mtDO4mc+WQgPlYZU8p0jGHn
         V73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=OqDmA1Fq5k4lm07oLpqfexf0+IOxtwlLE2Pn0Bzo5uQ=;
        b=Wi+ihRLpcek5SBLp5haYQ5plQAWpiY07JdsjIqru8b+xGIi4AquiL7TaIzuB2dx0hG
         kVsaNLTzebHHgEs9gM+6egwrUpKIzE+5lvnQCr+XbbY17Qm++Dtx4583keZBiwGzZt/3
         0e01A1cBAd4kb3+jhnQqiDEKWV/j7YZJyOMECPnBK06OM9jXS6cIGZQiTVn0HCQyby2i
         16vb5FFdE1QWlf+6r3g/1t1gmTc05X0F9Gyq3qPmkYe8Vr0ChwkXJ9cJi6iT1FHZ5RR1
         W5cpm+aiwPb4rk1BtT3bowsfQCouSH77MkgiweLpspsqVkZaLPckax+wCKalDSvXPhMU
         tofQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fgwGbizR;
       spf=pass (google.com: domain of kernel-hardening-return-12989-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12989-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fgwGbizR;
       spf=pass (google.com: domain of kernel-hardening-return-12989-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12989-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: willy@infradead.org,
	keescook@chromium.org,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: david@fromorbit.com,
	rppt@linux.vnet.ibm.com,
	labbott@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 4/6] Documentation for Pmalloc
Date: Fri, 13 Apr 2018 17:41:29 +0400
Message-Id: <20180413134131.4651-5-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180413134131.4651-1-igor.stoppa@huawei.com>
References: <20180413134131.4651-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638745542582881?=
X-GMAIL-MSGID: =?utf-8?q?1597638745542582881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Detailed documentation about the protectable memory allocator.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 107 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/core-api/pmalloc.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index c670a8031786..8f5de42d6571 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -25,6 +25,7 @@ Core utilities
    genalloc
    errseq
    printk-formats
+   pmalloc
 
 Interfaces for kernel debugging
 ===============================
diff --git a/Documentation/core-api/pmalloc.rst b/Documentation/core-api/pmalloc.rst
new file mode 100644
index 000000000000..c14907485137
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _pmalloc:
+
+Protectable memory allocator
+============================
+
+Purpose
+-------
+
+The pmalloc library is meant to provide read-only status to data that,
+for some reason, could neither be declared as constant, nor could it take
+advantage of the qualifier __ro_after_init, but is write-once and
+read-only in spirit. At least as long as it doesn't get teared down.
+It protects data from both accidental and malicious overwrites.
+
+Example: A policy that is loaded from userspace.
+
+
+Concept
+-------
+
+The MMU available in the system can be used to write protect memory pages.
+Unfortunately this feature cannot be used as-it-is, to protect sensitive
+data, because this potentially read-only data is typically interleaved
+with other data, which must stay writeable.
+
+pmalloc introduces the concept of protectable memory pools.
+A pool contains a list of areas of virtually contiguous pages of
+memory. An area is the minimum amount of memory that pmalloc allows to
+protect, because the user might have allocated a memory range that
+crosses the boundary between pages.
+
+When an allocation is performed, if there is not enough memory already
+available in the pool, a new area of suitable size is grabbed.
+The size chosen is the largest between the roundup (to PAGE_SIZE) of
+the request from pmalloc and friends and the refill parameter specified
+when creating the pool.
+
+When a pool is created, it is possible to specify two parameters:
+- refill size: the minimum size of the memory area to allocate when needed
+- align_order: the default alignment to use when reserving memory
+
+To facilitate the conversion of existing code to pmalloc pools, several
+helper functions are provided, mirroring their k/vmalloc counterparts.
+However one is missing. There is no pfree() because the memory protected
+by a pool will be released exclusively when the pool is destroyed.
+
+
+
+Caveats
+-------
+
+- When a pool is protected, whatever memory would be still available in
+  the current vmap_area (from which allocations are performed) is
+  relinquished.
+
+- As already explained, freeing of memory is not supported. Pages will be
+  returned to the system upon destruction of the memory pool that they
+  belong to.
+
+- The address range available for vmalloc (and thus for pmalloc too) is
+  limited, on 32-bit systems. However it shouldn't be an issue, since not
+  much data is expected tobe dynamically allocated and turned into
+  read-only.
+
+- Regarding SMP systems, the allocations are expected to happen mostly
+  during an initial transient, after which there should be no more need
+  to perform cross-processor synchronizations of page tables.
+  Loading of kernel modules is an exception to this, but it's not expected
+  to happen with such high frequency to become a problem.
+
+
+Use
+---
+
+The typical sequence, when using pmalloc, is:
+
+#. create a pool
+
+   :c:func:`pmalloc_create_pool`
+
+#. issue one or more allocation requests to the pool
+
+   :c:func:`pmalloc`
+
+   or
+
+   :c:func:`pzalloc`
+
+#. initialize the memory obtained, with the desired values
+
+#. write-protect the memory so far allocated
+
+   :c::func:`pmalloc_protect_pool`
+
+#. iterate over the last 3 points as needed
+
+#. [optional] destroy the pool
+
+   :c:func:`pmalloc_destroy_pool`
+
+API
+---
+
+.. kernel-doc:: include/linux/pmalloc.h
+.. kernel-doc:: mm/pmalloc.c
-- 
2.14.1
