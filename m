Return-Path: <kernel-hardening-return-12751-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsB3V9zFmJrRguuVxXFBN1wyMS2HJhJeDTjG0zd2Y4rUgcyu0tLQ9SCp8Bh2ryBzqgOucWU
ARC-Seal: i=1; a=rsa-sha256; t=1522115884; cv=none;
        d=google.com; s=arc-20160816;
        b=cQc8cpS/aAUsBkykzSyMxKRRKnIxnob/D/Wn/w6xhxwLLkZMgA1uDBotWB8bLek4X8
         BgUfTxjVYwIazObKs4CybrZXZv2z3B4wi0PSOOHCTVPZY5Esn7x72ClAytT9Aj98InJc
         OLx1orEYO7poBscZh3kcJQOmhAJB6mjDZ0fA2JRwPPZMkmu3Wah5TCcKTBaN6xruHs3h
         gZif+9BQCpyxfO7RJS/PzbYFGgNBiiBh2LuDNojFk0EJtJZSMEpplZ66wobF04CDV/rd
         oXgN9ra74mtnyLKy1l4FFa1FXuxkXeii+oOvj0ZGV0iDNJVSs2eURtaNlYGn+kDOx5va
         7RIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Fc5Lm7YUOMh4DCo/jnrI1z+TP9lpihDH3A9h5EqfzBo=;
        b=DNOmGzc4O5ORYONLvOBFt5aFiVES+egzodCHg2FfG5kEBhnMDAHIztJYsNeHpCZDRo
         SDI+hWZwJ+H0Sudk/dXwKfW/TEDVAcKhTMSDwhv8ocg/FOCvcZVM3C1GnTLrNXFXlRll
         +EZmUmTgvHyXP9NpwTU8QbC00hJlkf77mq9Pca/PSJX5MhSC8UB/473Rm0Mi0L4Ekpz+
         MICrxSKs/zXnxv8aRQDmTNkdbmfOm9CdDJ2rk++PupvlQGAFu2BoCp58xxMEe8xWIFPE
         kqXWaSxV82ATSj54dWyQyGbY8rk4M96CbJL0GqLjf5WcVjLHPEcVnfV23uW5ql3TxEAQ
         su7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12751-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12751-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12751-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12751-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>,
	<igor.stoppa@gmail.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 6/6] Documentation for Pmalloc
Date: Tue, 27 Mar 2018 04:55:24 +0300
Message-ID: <20180327015524.14318-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327015524.14318-1-igor.stoppa@huawei.com>
References: <20180327015524.14318-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596054185217940342?=
X-GMAIL-MSGID: =?utf-8?q?1596054185217940342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Detailed documentation about the protectable memory allocator.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 101 +++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
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
index 000000000000..3d2c19e5deaf
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,101 @@
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
+read-only in spirit.
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
+data, because it is typically interleaved with data that must stay
+writeable.
+
+pmalloc introduces the concept of protectable memory pools.
+Each pool contains a list of areas of virtually contiguous pages of
+memory. An area is the minimum amount of memory that pmalloc allows to
+protect, because the data it contains can be larger than a single page.
+
+When an allocation is performed, if there is not enough memory already
+available in the pool, a new area of suitable size is allocated.
+The size chosen is the largest between the roundup (to PAGE_SIZE) of
+the request from pmalloc and friends and the refill parameter specified
+when creating the pool.
+
+When a pool is created, it is possible to specify two parameters:
+- refill size: the minimum size of the memory area to allocate when needed
+- align_order: the default alignment to use when returning to pmalloc
+
+Caveats
+-------
+
+- To facilitate the conversion of existing code to pmalloc pools, several
+  helper functions are provided, mirroring their k/vmalloc counterparts.
+  In particular, pfree(), which is mostly meant for error paths, when one
+  or more previous allocations must be rolled back.
+
+- Whatever memory was still available in the previous area (where
+  applicable) is relinquished.
+
+- Freeing of memory is not supported. Pages will be returned to the
+  system upon destruction of the memory pool.
+
+- Considering that not much data is supposed to be dynamically allocated
+  and then marked as read-only, it shouldn't be an issue that the address
+  range for pmalloc is limited, on 32-bit systems.
+
+- Regarding SMP systems, the allocations are expected to happen mostly
+  during an initial transient, after which there should be no more need to
+  perform cross-processor synchronizations of page tables.
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
+#. [optional] pre-allocate some memory in the pool
+
+   :c:func:`pmalloc_prealloc`
+
+#. issue one or more allocation requests to the pool with locking as needed
+
+   :c:func:`pmalloc`
+
+   :c:func:`pzalloc`
+
+#. initialize the memory obtained with desired values
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
