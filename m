Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3104510-1527852324-2-3564235477651208641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527852324; b=b/tSZDrQcP5tPPeMnI9n24A9KcPMEj4mgwB49KlgrHNvwGJ/da
    Uno8aizYbpE7nCsIOsZm4GuUXvhPyRWoel14QZ16lW+VzY848LpLxKGGR2kPSLBL
    Rq1WTQUhkmhH6ft1oNbEFjKAnytQ+octpL/92CUe2j/eM5PhNHQ7oLJYfxUNZ9KH
    ywiWPdk/4dAP5p0ExGdY/tiBPiYq2t5wicUq2B0KCkc08BDIAcLecD33qL6ZpTcw
    pqnnD0HmzokZYQe9P9PI43D0Xbmy0dOfASwzqMM6JbWGjOtqp2L7L7ac7Qo6V1W/
    0KHwkwiZM3WQoLToKuZBWk/rJSq8O90GMjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527852324; bh=
    5esnfEHpxG6UbSVuzA3aJDrMybAxCpMjqaMHPcJ6UCM=; b=fAcrqkn6UDgLdl6Z
    aPRUTtUxWRie6OPxXmYMD78HZ5sSs8lJ031z7gEZwRGLOkADi1GG0Lbw15JwsdpM
    N1aD7YwljV+Jj+ILyBQtj5NVvknSUbWcnzu3wMtRRgYsK1IwslY8TkIoOin8pwEN
    hWjXAl3fXtFpQyJkoAi63XrQ4ZQg6FdTVv4FYPbvXztPl9BCk1v+KaNlDTxsYmwZ
    aQcbyrMvOaXSpFGobX6u/Fh2kKet6Gl0n/yDXMPwL9nUVAmOKUko7mETm6e3GZGK
    uhLcX9oGUa5XgQugKGLIqMDTDaYZ6VLZK7xgihtqGusfBA4S52fkbg3guK7VBs5G
    zg0kOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLP0S+CBXvYMQrfOoJhEo4kvKjiqxkAk3VvgGYgUI6VPvQ1etzhlq80oeWJEftQpZFEcHpEMmsHiY+/litVgpNJRMV835XHs3x/l/lFlYqENsZVdBa55
    yDauwiRZkh9zfrrNBPm6khxGSQzKVWmhAPyTJ924p6pGPzwCNwpJ53+SAcbhXRPj4Y/ozADP1T1zyDXQRR9mFoiYH89O7xJ9Y9AW516Qp11Pc7QpHFqmz9ms
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=7CQSdrXTAAAA:8
    a=b3QJYkDzAAAA:8 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=0h0w5FCYlkdkqHMkWK0A:9
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=ZYrClHXAzI6hOjfCDBRe:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFALZU (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 07:25:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50344 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752006AbeFALZQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:16 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHv2 14/19] kernel: add kcompat_sys_{f,}statfs64()
Date: Fri,  1 Jun 2018 12:24:36 +0100
Message-Id: <20180601112441.37810-15-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using this helper allows us to avoid the in-kernel calls to the
compat_sys_{f,}statfs64() sycalls, as are necessary for parameter
mangling in arm64's compat handling.

Following the example of ksys_* functions, kcompat_sys_* functions are
intended to be a drop-in replacement for their compat_sys_*
counterparts, with the same calling convention.

This is necessary to enable conversion of arm64's syscall handling to
use pt_regs wrappers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/statfs.c            | 14 ++++++++++++--
 include/linux/compat.h | 11 +++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..f0216629621d 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -335,7 +335,7 @@ static int put_compat_statfs64(struct compat_statfs64 __user *ubuf, struct kstat
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -349,7 +349,12 @@ COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, s
 	return error;
 }
 
-COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_statfs64(pathname, sz, buf);
+}
+
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -363,6 +368,11 @@ COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct co
 	return error;
 }
 
+COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_fstatfs64(fd, sz, buf);
+}
+
 /*
  * This is a copy of sys_ustat, just dealing with a structure layout.
  * Given how simple this syscall is that apporach is more maintainable
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 081281ad5772..6cecf9f11d6b 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -1013,6 +1013,17 @@ static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
 	return ctv;
 }
 
+/*
+ * Kernel code should not call compat syscalls (i.e., compat_sys_xyzyyz())
+ * directly.  Instead, use one of the functions which work equivalently, such
+ * as the kcompat_sys_xyzyyz() functions prototyped below.
+ */
+
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
+		     struct compat_statfs64 __user * buf);
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
+			  struct compat_statfs64 __user * buf);
+
 #else /* !CONFIG_COMPAT */
 
 #define is_compat_task() (0)
-- 
2.11.0
