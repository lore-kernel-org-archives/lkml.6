Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48038ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83E6206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW2/eNQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83E6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeGUMvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:51:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41599 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeGUMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:51:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so13530165wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 04:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+BDM8Sf6B4Sd2TjnRPoBApvD3i0DQzK3NAsuJuuXcu8=;
        b=VW2/eNQV1jNgrj3MUhjMm0vJJdcOz6Xnz8KWKWshZ6+y6oMcNU++3g53+UHu8yoxJb
         VNrkXJMHV2awKooRrnn77Zmhb5WrCLgube4pKWNGnE6Zy/5dm56vVkawFNeBSLsG4UZJ
         r9WlzTwDg68E4WcZTc0rcPp8yRkt+JDT0lBybphS5QYl5QkiePXcZFUB7Uv4tCx50TMq
         AT5nI0Vpa1vPHaM5vr4B44PQAm/JxP4+QT7qwkquOz5RXzpxX+54yssPcD5UK0eDwUcy
         9gZaaYGjFqIFocINsbOrHDiATs8u70Z8VTp3yEiQhf8JuZn41Q6ENqaCcqmGPlkDQd19
         WukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=+BDM8Sf6B4Sd2TjnRPoBApvD3i0DQzK3NAsuJuuXcu8=;
        b=iVE0nXcHHd3fAZIv6u0a7Fl4skdqOqCBxphq57BletnFCAHi91DVN6dNnNJhkJPbcs
         mG9vqGc7GwJPsMcfTTh7tOSk3/ps1YAnEawejxlUNr50rElaNEqPeNyVUUqmKHScARhK
         pN9JAYNJslctBSAFqtwvUhOP4MhXQhBJx6yD0TbDNxDCDlrBLYriLhq9VDyEJVmvoaHX
         u+0oIWnmcUmowJWihEVMJImQdBxMH5BCSl+YwAweopojut5m488CrYJm/4DcIyLq4U/e
         4HWOvywcT0CKvIuShkn/qkQNPSoYDMBuOWbOKv5fwnoPG5ueBR+mWp8vnEABONxHu9iP
         gBtw==
X-Gm-Message-State: AOUpUlEUY9tpmwDSgOrYfND5JnZTXhqalWC5mHYN8vdquaTfHw3c7HRi
        tL6WK/ZyyNQ1k03VRJ3aUFE=
X-Google-Smtp-Source: AAOMgpd7lMi0CBD0jetEZKO1N4SJXf0uPePPFvgqREfMyXzRGvVLIcPIOGkB9wiyS9ftk9JukoWmww==
X-Received: by 2002:adf:eb4c:: with SMTP id u12-v6mr4047715wrn.174.1532174319694;
        Sat, 21 Jul 2018 04:58:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s2-v6sm3140272wrn.75.2018.07.21.04.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 04:58:38 -0700 (PDT)
Date:   Sat, 21 Jul 2018 13:58:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core kernel fixes
Message-ID: <20180721115836.GA27764@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 092b31aa2048cf7561a39697974adcd147fbb27b x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe() exception handling

This is mostly the copy_to_user_mcsafe() related fixes from Dan Williams,
and an ORC fix for Clang.

 Thanks,

	Ingo

------------------>
Dan Williams (4):
      lib/iov_iter: Document _copy_to_iter_mcsafe()
      lib/iov_iter: Document _copy_to_iter_flushcache()
      lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe()
      x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe() exception handling

Simon Ser (1):
      objtool: Use '.strtab' if '.shstrtab' doesn't exist, to support ORC tables on Clang


 arch/x86/Kconfig                  |  2 +-
 arch/x86/include/asm/uaccess_64.h |  7 +++-
 lib/iov_iter.c                    | 77 +++++++++++++++++++++++++++++++++++++--
 tools/objtool/elf.c               |  6 ++-
 4 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..887d3a7bb646 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -63,7 +63,7 @@ config X86
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
-	select ARCH_HAS_UACCESS_MCSAFE		if X86_64
+	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 62acb613114b..a9d637bc301d 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -52,7 +52,12 @@ copy_to_user_mcsafe(void *to, const void *from, unsigned len)
 	unsigned long ret;
 
 	__uaccess_begin();
-	ret = memcpy_mcsafe(to, from, len);
+	/*
+	 * Note, __memcpy_mcsafe() is explicitly used since it can
+	 * handle exceptions / faults.  memcpy_mcsafe() may fall back to
+	 * memcpy() which lacks this handling.
+	 */
+	ret = __memcpy_mcsafe(to, from, len);
 	__uaccess_end();
 	return ret;
 }
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7e43cd54c84c..8be175df3075 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -596,15 +596,70 @@ static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
 	return ret;
 }
 
+static size_t copy_pipe_to_iter_mcsafe(const void *addr, size_t bytes,
+				struct iov_iter *i)
+{
+	struct pipe_inode_info *pipe = i->pipe;
+	size_t n, off, xfer = 0;
+	int idx;
+
+	if (!sanity(i))
+		return 0;
+
+	bytes = n = push_pipe(i, bytes, &idx, &off);
+	if (unlikely(!n))
+		return 0;
+	for ( ; n; idx = next_idx(idx, pipe), off = 0) {
+		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
+		unsigned long rem;
+
+		rem = memcpy_mcsafe_to_page(pipe->bufs[idx].page, off, addr,
+				chunk);
+		i->idx = idx;
+		i->iov_offset = off + chunk - rem;
+		xfer += chunk - rem;
+		if (rem)
+			break;
+		n -= chunk;
+		addr += chunk;
+	}
+	i->count -= xfer;
+	return xfer;
+}
+
+/**
+ * _copy_to_iter_mcsafe - copy to user with source-read error exception handling
+ * @addr: source kernel address
+ * @bytes: total transfer length
+ * @iter: destination iterator
+ *
+ * The pmem driver arranges for filesystem-dax to use this facility via
+ * dax_copy_to_iter() for protecting read/write to persistent memory.
+ * Unless / until an architecture can guarantee identical performance
+ * between _copy_to_iter_mcsafe() and _copy_to_iter() it would be a
+ * performance regression to switch more users to the mcsafe version.
+ *
+ * Otherwise, the main differences between this and typical _copy_to_iter().
+ *
+ * * Typical tail/residue handling after a fault retries the copy
+ *   byte-by-byte until the fault happens again. Re-triggering machine
+ *   checks is potentially fatal so the implementation uses source
+ *   alignment and poison alignment assumptions to avoid re-triggering
+ *   hardware exceptions.
+ *
+ * * ITER_KVEC, ITER_PIPE, and ITER_BVEC can return short copies.
+ *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
+ *   a short copy.
+ *
+ * See MCSAFE_TEST for self-test.
+ */
 size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
 	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
 
-	if (unlikely(i->type & ITER_PIPE)) {
-		WARN_ON(1);
-		return 0;
-	}
+	if (unlikely(i->type & ITER_PIPE))
+		return copy_pipe_to_iter_mcsafe(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
 	iterate_and_advance(i, bytes, v,
@@ -701,6 +756,20 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL(_copy_from_iter_nocache);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+/**
+ * _copy_from_iter_flushcache - write destination through cpu cache
+ * @addr: destination kernel address
+ * @bytes: total transfer length
+ * @iter: source iterator
+ *
+ * The pmem driver arranges for filesystem-dax to use this facility via
+ * dax_copy_from_iter() for ensuring that writes to persistent memory
+ * are flushed through the CPU cache. It is differentiated from
+ * _copy_from_iter_nocache() in that guarantees all data is flushed for
+ * all iterator types. The _copy_from_iter_nocache() only attempts to
+ * bypass the cache for the ITER_IOVEC case, and on some archs may use
+ * instructions that strand dirty-data in the cache.
+ */
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 0d1acb704f64..7ec85d567598 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -519,10 +519,12 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	sec->sh.sh_flags = SHF_ALLOC;
 
 
-	/* Add section name to .shstrtab */
+	/* Add section name to .shstrtab (or .strtab for Clang) */
 	shstrtab = find_section_by_name(elf, ".shstrtab");
+	if (!shstrtab)
+		shstrtab = find_section_by_name(elf, ".strtab");
 	if (!shstrtab) {
-		WARN("can't find .shstrtab section");
+		WARN("can't find .shstrtab or .strtab section");
 		return NULL;
 	}
 
