Return-Path: <kernel-hardening-return-11577-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227i+o5O/M8yGseeutDOyJKMZrC+6IYuDZgq9iUJIcGWWyyjDvuFLBrk9KvHGOWdRvs2hnrJ
ARC-Seal: i=1; a=rsa-sha256; t=1517763719; cv=none;
        d=google.com; s=arc-20160816;
        b=hswG+pGXUYsvN5uSgPkFnKmPaRkARfQEMAhpPfbwP710tOwT08PMMoNQkPaBoEkRUi
         bvDtRwXbv4qC5/zZIiTmkEJsmC21wEgCzkVV9hnZVeLuiijQ+1kkM+M0UtdG6oPPYvq+
         o6AZRHE+L7IuqvmQJdLHX09hIo8mI6a842b0dSdA7c/Zu8GZpD69FIZKznFyvVhsvOgP
         igQR8p1GLw9WpHutTD94sgVbhedBgDrYLa9iBl3DbKCpLSW0sDJ+xDjRciu+cH/G7iyD
         pQjrkaYPrTSrqUghi2kjA6euy8GS/o0vGw0kVg7RVAbagDCcMePzlt+vrlVSMrPPcep5
         tCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=6KQUmEBmlgIrx7HL5HcHhET8RD1nzV5gyDzvn11bSt4=;
        b=ijwmHsbFZjOlxIvWNy4i8UnSLozvNUZjRg8rBjIXGmwnrnwJubeoWwfpGEAx+jfx8g
         lHK1ZyjacZLAHVOaYaog3BQUKg6eN8RkUfRnEHfR0qRhVQtg/ZxRyFohb7fTCMhJ34eW
         LGpjenuSpswLa0cyauChOOXMMV0FRpNED2xFRN5bKdOAqK+HPHjLPcWnhZGbzIcD/Ci6
         ecc/6rrxc0g9itQm+IestPcQplZdtYCnwO/+Gz04GR846S0bkL+Qo4Ytl2/mAzWhKqVc
         KRCFXntgaMO83dkgev+OcPqeWORtcmzOsDbf17DiL6NuXhvqQW5raZYZrMxtl0/d7cgK
         Tf0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11577-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11577-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11577-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11577-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 6/6] Documentation for Pmalloc
Date: Sun, 4 Feb 2018 19:00:56 +0200
Message-ID: <20180204170056.28772-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180204170056.28772-1-igor.stoppa@huawei.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204170056.28772-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490610128424562?=
X-GMAIL-MSGID: =?utf-8?q?1591490610128424562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Detailed documentation about the protectable memory allocator.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/pmalloc.rst | 114 +++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/core-api/pmalloc.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index d5bbe035316d..7244ddeb540f 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -21,6 +21,7 @@ Core utilities
    flexible-arrays
    librs
    genalloc
+   pmalloc
 
 Interfaces for kernel debugging
 ===============================
diff --git a/Documentation/core-api/pmalloc.rst b/Documentation/core-api/pmalloc.rst
new file mode 100644
index 000000000000..8dabb5e18d8f
--- /dev/null
+++ b/Documentation/core-api/pmalloc.rst
@@ -0,0 +1,114 @@
+SPDX-License-Identifier: GPL-2.0
+
+Protectable memory allocator
+============================
+
+Purpose
+-------
+
+The pmalloc library is meant to provide R/O status to data that, for some
+reason, could neither be declared as constant, nor it could take advantage
+of the qualifier __ro_after_init, but is write-once and read-only in spirit.
+It protects data from both accidental and malicious overwrites.
+
+Ex: A policy that is loaded from userspace.
+
+
+Concept
+-------
+
+pmalloc builds on top of genalloc, using the same concept of memory pools.
+
+The value added by pmalloc is that now the memory contained in a pool can
+become R/O, for the rest of the life of the pool.
+
+Different kernel idrivers and threads can use different pools, for finer
+control of what becomes R/O and when. And for improved lockless concurrency.
+
+
+Caveats
+-------
+
+- Memory freed while a pool is not yet protected will be reused.
+
+- Once a pool is protected, it's not possible to allocate any more memory
+  from it.
+
+- Memory "freed" from a protected pool indicates that such memory is not
+  in use anymore by the requestor, however it will not become avaiable for
+  further use, until the pool is destroyed.
+
+- Before destroying a pool, all the memory allocated from it must be
+  released.
+
+- pmalloc does not provide locking support wrt allocating vs protecting
+  an individual pool, for performance reason. It is recommended to not
+  share the same pool between unrelated functions. Should sharing be a
+  necessity, the user of the shared pool is expected to implement locking
+  for that pool.
+
+- pmalloc uses genalloc to optimize the use of the space it allocates
+  through vmalloc. Some more TLB entries will be used, however less than
+  in the case of using directly vmalloc. The exact number depends on size
+  of each allocation request and possible slack.
+
+- Considering that not much data is supposed to be dynamically allocated
+  and then marked as read-only, it shouldn't be an issue that the address
+  range for pmalloc is limited, on 32-bit systems.
+
+- Regarding SMP systems, the allocations are expected to happen mostly
+  during an initial transient, after which there should be no more need to
+  perform cross-processor synchronizations of page tables.
+
+- To facilitate the conversion of existing code to pmalloc pools, several
+  helper functions are provided, mirroring their kmalloc counterparts.
+
+
+Use
+---
+
+The typical sequence, when using pmalloc, is:
+
+1. create a pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_create_pool
+
+2. [optional] pre-allocate some memory in the pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_prealloc
+
+3. issue one or more allocation requests to the pool with locking as needed
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pzalloc
+
+4. initialize the memory obtained with desired values
+
+5. [optional] iterate over points 3 & 4 as needed
+
+6. write protect the pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_protect_pool
+
+7. use in read-only mode the handlers obtained through the allocations
+
+8. [optional] release all the memory allocated
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pfree
+
+9. [optional, but depends on point 8] destroy the pool
+
+.. kernel-doc:: include/linux/pmalloc.h
+   :functions: pmalloc_destroy_pool
+
+API
+---
+
+.. kernel-doc:: include/linux/pmalloc.h
-- 
2.16.0
