Return-Path: <kernel-hardening-return-13092-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+JZJpGBbCXhdrTktV57TQ1U9jJs46B4hJKQpXFiHOylJEaZUCs+n8bjJCNzQwk88U+2bwS
ARC-Seal: i=1; a=rsa-sha256; t=1524488195; cv=none;
        d=google.com; s=arc-20160816;
        b=MJMzEeKppHQMM7IidL646aNDS3hG+NkpjJtX8sUydTZAMIOEryA49HVpQujjdSsocc
         3Gu5nn6DbRIn+6MCMgL5rqIVCEXV0BjysUwD/YGqKswG3huIxPOhd1zqgDHEwHShVBui
         cVOoMHAsxLPyfNIpKVAOY8pwNlTK/AykhBQl8hZHGl38XYD3TDGVNeq1GS4AsZ/acfQq
         9wiAR0AJ4Iq1tIuAKa8hJ4xPHLRkOFZ7DNgaMYQ8MVREHxrW7SRA7YFTSIuwjEJWZKc3
         5a9jQE6HsZgtaodFvNIku5pgIYiUKNKkB6M0458sGawRnur0Tz/WY5JjtrcSraLZQdBg
         6NjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=dCNRY2Iu1bn3fwXdvPbGe2hNbI9U/Cv85qV4aFnyQX8=;
        b=eHS8WFVdmXtIcu9CdCAOiXkSU4aRXGxrLkCIRruf57z82pS0O9thzVDM1T75egoObL
         kUgqQlLRJLd0q+QS7LmysJ4XqaegHZvedvy2FRjpvE8SwrWIsv/ELHkid1VI7tCIj4E9
         Stjb+8kWx6/ZdDiBekpyiUns7vdcmRjxTio55OO8Vow4QsWpgmXNXpBGdk6+pAJblpIi
         Y3oJM0vJYaDo9dM1PJXDFDS5rietxL+iLF79xK5zcLzHkcFH0vIrQtENvwWZIZkIup6C
         DoUbqjx2Ig2K3oyfYAqpgg38fcC2J8q/dSiNwiz37DqG/LTVOoUIyMmSlfc/0JL2WMfN
         9RuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TscoP/DU;
       spf=pass (google.com: domain of kernel-hardening-return-13092-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13092-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TscoP/DU;
       spf=pass (google.com: domain of kernel-hardening-return-13092-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13092-gregkh=linuxfoundation.org@lists.openwall.com;
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
	paul@paul-moore.com,
	sds@tycho.nsa.gov,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: labbott@redhat.com,
	linux-cc=david@fromorbit.com,
	--cc=rppt@linux.vnet.ibm.com,
	--security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	igor.stoppa@gmail.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 4/9] Documentation for Pmalloc
Date: Mon, 23 Apr 2018 16:54:53 +0400
Message-Id: <20180423125458.5338-5-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423125458.5338-1-igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541734122424671?=
X-GMAIL-MSGID: =?utf-8?q?1598541734122424671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Detailed documentation about the protectable memory allocator.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 161 +++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
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
index 000000000000..27eb7b3eafc4
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,161 @@
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
+advantage of the qualifier __ro_after_init, but it is in spirit
+write-once/read-only.
+At some point it might get teared down, however that doesn't affect how it
+is treated, while it's still relevant.
+Pmalloc protects data from both accidental and malicious overwrites.
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
+memory. When memory is requested from a pool, the requests are satisfied
+by reserving adequate amounts of memory from the active area of memory in
+that pool. A request can cross page boundaries, therefore an area is the
+minimum granularity that pmalloc allows to protect.
+
+There might be special cases where an area contains only one page, but
+they are still addressed as areas.
+
+Areas are allocated on-the-fly, when the space available is insufficient
+for satisfying the latest request received.
+
+To facilitate the conversion of existing code to pmalloc pools, several
+helper functions are provided, mirroring their k/vmalloc counterparts.
+
+However, there is no pfree(), because the memory protected by a pool is
+released exclusively when the pool is destroyed.
+
+
+When to use pmalloc
+-------------------
+
+- Pmalloc memory is intended to complement __ro_after_init.
+  __ro_after_init requires that the initialization value is applied before
+  init is completed. If this is not possible, then pmalloc can be used.
+
+- Pmalloc can be useful also when the amount of data to protect is not
+  known at compile time and the memory can only be allocated dynamically.
+
+- Finally, it can be useful also when it is desirable to control
+  dynamically (for example throguh the kernel command line) if some
+  specific data ought to be protected or not, without having to rebuild
+  the kernel, for toggling a "const" qualifier.
+  This can be used, for example, by a linux distro, to create a more
+  versatile binary kernel and allow its users to toggle between developer
+  (unprotected) or production (protected) modes by reconfiguring the
+  bootloader.
+
+
+When *not* to use pmalloc
+-------------------------
+
+Using pmalloc is not a good idea when optimizing TLB utilization is
+paramount: pmalloc relies on virtual memory areas and will therefore use
+more TLB entries. It still does a better job of it, compared to invoking
+vmalloc for each allocation, but it is undeniably less optimized wrt to
+TLB use than using the physmap directly, through kmalloc or similar.
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
+  belong to. For this reason, no pfree() function is provided
+
+- The address range available for vmalloc (and thus for pmalloc too) is
+  limited, on 32-bit systems. However it shouldn't be an issue, since not
+  much data is expected to be dynamically allocated and turned into
+  read-only.
+
+- Regarding SMP systems, the allocations are expected to happen mostly
+  during an initial transient, after which there should be no more need
+  to perform cross-processor synchronizations of page tables.
+  Loading of kernel modules is an exception to this, but it's not expected
+  to happen with such high frequency to become a problem.
+
+- While pmalloc memory can be protected, since it is allocated dynamically,
+  it is still subject to indirect attacks, where the memory itself is not
+  touched, but anything used as reference to the allocation can be altered.
+  In some cases the allocation from a pmalloc pool is referred to by another
+  allocation, from either the same or another pool, however at some point,
+  there will be a base reference which can be attacked, if it cannot be
+  protected.
+  This base reference, or "anchor" is suitable for protection using
+  __ro_after_init, since it only needs to store the *address* of the
+  pmalloc allocation that will be initialized and protected later on.
+  But the allocation can take place during init, and its address is known
+  and constant.
+
+
+Utilization
+-----------
+
+Typical sequence, when using pmalloc
+
+Steps to perforn during init:
+
+#. create an "anchor", with the modifier __ro_after_init
+
+#. create a pool
+
+   :c:func:`pmalloc_create_pool`
+
+#. issue an allocation requests to the pool with either
+
+   :c:func:`pmalloc`
+
+   or one of its variants, like
+
+   :c:func:`pzalloc`
+
+   assigning its address to the anchor
+
+#. iterate the previous points as needed
+
+The Following steps can be performed at any time, both during and after
+init, as long as they strictly come after the previous sequence.
+
+#. initialize with the desired value the memory obtained from the pool(s)
+
+#. write-protect the memory so far allocated
+
+   :c::func:`pmalloc_protect_pool`
+
+#. iterate over the last 2 points as needed
+
+#. [optional] destroy the pool
+
+   :c:func:`pmalloc_destroy_pool`
+
+
+API
+---
+
+.. kernel-doc:: include/linux/pmalloc.h
+.. kernel-doc:: mm/pmalloc.c
-- 
2.14.1
