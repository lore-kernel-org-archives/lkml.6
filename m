Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1799078-1527582455-2-11181751623205331180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527582455; b=LVDJpoRxbJukO+bTPyxdzb1/nfSnujx+U9RhddfUeQigUuux3T
    SrmiF60SSoTGr/uh19u8dAAK4VdMNVGLRUrmJu89zVjPg46PrCQKiITH264irnZA
    OyCVLLlIXgl6sX6IoXwTAHDs+66MlpvaQftABmdcLd2uazEgMZkZodLOgr1N4Fy1
    Sqm+2YzUmqfwOH38QYxatTYd8WX+TQoTR33fXIffIl25QPU6ujHjSF0BAIJADS89
    BYNx95vgJJHtpUcAW7l6EUyvBUCb5lXeVs0ROgkPCsRbaA9vEOAPYVrPW4iNkcfW
    vFAjV0MNl5+Es6mjFJVyO7sIyd2YwBiym8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527582455; bh=
    ETGOxHNGQsD3pSWCxQO9YVQdyJXjmo2PJERAa5Ozl2c=; b=T9ZP9ex8H12SFP6V
    oIs4Y9jz7PPOuXGfrChJFYsVunSTo9oLIp0ekZpazow95qKz1oFhbs2kuKhBzRFu
    fEiscYd5BNcUe7UROwYcISf04GWDfCX4rvC7jy7guX0xDhOsQBmHiM2rqxBOj3GE
    81k/QnlmW6tG039LpHG2k+8qZ1xSUgOkBj1tqK/Yx4/UmPee0YkwdVjUCmFbtMEM
    6YMI6M3RJ2L01QBKAjz11FOKUFsahAmGpPb2etKxPd7i3jFmQEPfx0j8pwT0GK1J
    xxVW9ycKxG3A+lIc8AqJ9RIg8ZlYajtaW6knPkkNE9qhTmyYmfk4M5q3OCPLmvyu
    Se7asA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Y+V5Yi+I;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Y+V5Yi+I;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJtNjwV54HkMkTzWoDPLDaGIvdwn1clO8PmYoAGJl4D5cLThvS71oM+aeMfv4A/azPzkZJ0DhfWjviH9/oG/g9+CbYQFfF0exmvBfjxW1QDbvXTfqgX7
    JFdrIrjjHhoHIe6ti2lbPXEsDJEJk62aUKrU+XbdP4X+aj9jL6AYWnipDFFwZv4xrH7p9XMaKFwYKoNcxRr8PzrBXfrV/Chre2FPMGyaLdGAuKmKgg3BsrWp
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=iox4zFpeAAAA:8
    a=VwQbUJbxAAAA:8 a=3KE3V3bagzTEO2pLPPsA:9 a=WzC6qhA0u3u7Ye7llzcV:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755235AbeE2I1b (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 04:27:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35599 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755183AbeE2I0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 04:26:54 -0400
X-Google-Smtp-Source: AB8JxZoPz0fJQstaPmF87Ydwd4CIU/xgUD7m52m15a8g/2SyVpTSY1Tpg3vYQCChJlF6J4WqZghBWg==
From: Michal Hocko <mhocko@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2] doc: document scope NOFS, NOIO APIs
Date: Tue, 29 May 2018 10:26:44 +0200
Message-Id: <20180529082644.26192-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524114341.1101-1-mhocko@kernel.org>
References: <20180524114341.1101-1-mhocko@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michal Hocko <mhocko@suse.com>

Although the api is documented in the source code Ted has pointed out
that there is no mention in the core-api Documentation and there are
people looking there to find answers how to use a specific API.

Changes since v1
- add kerneldoc for the api - suggested by Johnatan
- review feedback from Dave and Johnatan
- feedback from Dave about more general critical context rather than
  locking
- feedback from Mike
- typo fixed - Randy, Dave

Requested-by: "Theodore Y. Ts'o" <tytso@mit.edu>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 .../core-api/gfp_mask-from-fs-io.rst          | 61 +++++++++++++++++++
 Documentation/core-api/index.rst              |  1 +
 include/linux/sched/mm.h                      | 38 ++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 Documentation/core-api/gfp_mask-from-fs-io.rst

diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
new file mode 100644
index 000000000000..2dc442b04a77
--- /dev/null
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -0,0 +1,61 @@
+=================================
+GFP masks used from FS/IO context
+=================================
+
+:Date: May, 2018
+:Author: Michal Hocko <mhocko@kernel.org>
+
+Introduction
+============
+
+Code paths in the filesystem and IO stacks must be careful when
+allocating memory to prevent recursion deadlocks caused by direct
+memory reclaim calling back into the FS or IO paths and blocking on
+already held resources (e.g. locks - most commonly those used for the
+transaction context).
+
+The traditional way to avoid this deadlock problem is to clear __GFP_FS
+respectively __GFP_IO (note the latter implies clearing the first as well) in
+the gfp mask when calling an allocator. GFP_NOFS respectively GFP_NOIO can be
+used as shortcut. It turned out though that above approach has led to
+abuses when the restricted gfp mask is used "just in case" without a
+deeper consideration which leads to problems because an excessive use
+of GFP_NOFS/GFP_NOIO can lead to memory over-reclaim or other memory
+reclaim issues.
+
+New API
+========
+
+Since 4.12 we do have a generic scope API for both NOFS and NOIO context
+``memalloc_nofs_save``, ``memalloc_nofs_restore`` respectively ``memalloc_noio_save``,
+``memalloc_noio_restore`` which allow to mark a scope to be a critical
+section from a filesystem or I/O point of view. Any allocation from that
+scope will inherently drop __GFP_FS respectively __GFP_IO from the given
+mask so no memory allocation can recurse back in the FS/IO.
+
+FS/IO code then simply calls the appropriate save function before
+any critical section with respect to the reclaim is started - e.g.
+lock shared with the reclaim context or when a transaction context
+nesting would be possible via reclaim. The restore function should be
+called when the critical section ends. All that ideally along with an
+explanation what is the reclaim context for easier maintenance.
+
+Please note that the proper pairing of save/restore functions
+allows nesting so it is safe to call ``memalloc_noio_save`` or
+``memalloc_noio_restore`` respectively from an existing NOIO or NOFS
+scope.
+
+What about __vmalloc(GFP_NOFS)
+==============================
+
+vmalloc doesn't support GFP_NOFS semantic because there are hardcoded
+GFP_KERNEL allocations deep inside the allocator which are quite non-trivial
+to fix up. That means that calling ``vmalloc`` with GFP_NOFS/GFP_NOIO is
+almost always a bug. The good news is that the NOFS/NOIO semantic can be
+achieved by the scope API.
+
+In the ideal world, upper layers should already mark dangerous contexts
+and so no special care is required and vmalloc should be called without
+any problems. Sometimes if the context is not really clear or there are
+layering violations then the recommended way around that is to wrap ``vmalloc``
+by the scope API with a comment explaining the problem.
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index c670a8031786..8a5f48ef16f2 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -25,6 +25,7 @@ Core utilities
    genalloc
    errseq
    printk-formats
+   gfp_mask-from-fs-io
 
 Interfaces for kernel debugging
 ===============================
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e1f8411e6b80..af5ba077bbc4 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -166,6 +166,17 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
 static inline void fs_reclaim_release(gfp_t gfp_mask) { }
 #endif
 
+/**
+ * memalloc_noio_save - Marks implicit GFP_NOIO allocation scope.
+ *
+ * This functions marks the beginning of the GFP_NOIO allocation scope.
+ * All further allocations will implicitly drop __GFP_IO flag and so
+ * they are safe for the IO critical section from the allocation recursion
+ * point of view. Use memalloc_noio_restore to end the scope with flags
+ * returned by this function.
+ *
+ * This function is safe to be used from any context.
+ */
 static inline unsigned int memalloc_noio_save(void)
 {
 	unsigned int flags = current->flags & PF_MEMALLOC_NOIO;
@@ -173,11 +184,30 @@ static inline unsigned int memalloc_noio_save(void)
 	return flags;
 }
 
+/**
+ * memalloc_noio_restore - Ends the implicit GFP_NOIO scope.
+ * @flags: Flags to restore.
+ *
+ * Ends the implicit GFP_NOIO scope started by memalloc_noio_save function.
+ * Always make sure that that the given flags is the return value from the
+ * pairing memalloc_noio_save call.
+ */
 static inline void memalloc_noio_restore(unsigned int flags)
 {
 	current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
 }
 
+/**
+ * memalloc_nofs_save - Marks implicit GFP_NOFS allocation scope.
+ *
+ * This functions marks the beginning of the GFP_NOFS allocation scope.
+ * All further allocations will implicitly drop __GFP_FS flag and so
+ * they are safe for the FS critical section from the allocation recursion
+ * point of view. Use memalloc_nofs_restore to end the scope with flags
+ * returned by this function.
+ *
+ * This function is safe to be used from any context.
+ */
 static inline unsigned int memalloc_nofs_save(void)
 {
 	unsigned int flags = current->flags & PF_MEMALLOC_NOFS;
@@ -185,6 +215,14 @@ static inline unsigned int memalloc_nofs_save(void)
 	return flags;
 }
 
+/**
+ * memalloc_nofs_restore - Ends the implicit GFP_NOFS scope.
+ * @flags: Flags to restore.
+ *
+ * Ends the implicit GFP_NOFS scope started by memalloc_nofs_save function.
+ * Always make sure that that the given flags is the return value from the
+ * pairing memalloc_nofs_save call.
+ */
 static inline void memalloc_nofs_restore(unsigned int flags)
 {
 	current->flags = (current->flags & ~PF_MEMALLOC_NOFS) | flags;
-- 
2.17.0
