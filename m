Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326540-2-18387943730691673616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326540; b=JPROcf1MQ2Ehzq1cK5vp+qXpW0nSnZAUizj2rLu4EGxx0mW
    8SvT+l8Hv7ffuAYRcEkaKZkOtfUgFkMrL56SUqU8n0bBh1I+PYBqGXdtDTEwlCWB
    IrkxFuKP7aZGhBHJEn5smAVhsbuwc5fz4+quhSO6KJQG2CsC+RHV5AUG7UzeAbJe
    c1ewJ6PkPO+sxU+CuIyJoKvr2lkBa6B3mLhzXzXKtfmX5x32hcO0RcZ8LwXlfAA/
    8q5q2yIRQ0G1jVi/GTlJjAEQoHHvl1q5uny+hFLmt4gHEesnIKfaTn8EWJY5xLcX
    skSjWfY1Q9gipzdv86UaVUmLtD2uE6fZfVkh4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326540; bh=xzFmbog7H8F6cwb+6BW
    wMuONJprVIvRxnfNWoZeixCM=; b=XmszGg4fDq2bctSinIM2f+b/KqzicC+mKLM
    pvIacg182fpMYj626dgSdFJ0Hh2c9pUi5gWkGP0Muk+OsMwzg/MP0NObvUWDyYcq
    LMH9PsDMwJspsbum5HQhcUcWTvlNgixxswUgJlHlSgCrG0PKUqv/au8c6CZQOYG1
    GdmLwZfOBMJTxRDN56Y4IAL3pomZLUN0lvyBsA5ShcnqpaqOHMHTpfO9n4xWxUrW
    YEzp3CUQ87mTy0rJtTNvxZ4zDcx56bJNPAlYSFOxYaMDbfeg7jyQcsvdRLu+D0+c
    AAR08S4KVVqeuC8wF0qQNHwv/K8QUitKSb3ltDmEL2ubHQCFPVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbeBKFSC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752547AbeBKFSA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:00 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Nicolas Pitre" <nico@linaro.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.431576021@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 020/136] elf_fdpic: fix unused variable warning
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 11e3e8d6d9274bf630859b4c47bc4e4d76f289db upstream.

The elf_fdpic code shows a harmless warning when built with MMU disabled,
I ran into this now that fdpic is available on ARM randconfig builds
since commit 50b2b2e691cd ("ARM: add ELF_FDPIC support").

fs/binfmt_elf_fdpic.c: In function 'elf_fdpic_dump_segments':
fs/binfmt_elf_fdpic.c:1501:17: error: unused variable 'addr' [-Werror=unused-variable]

This adds another #ifdef around the variable declaration to shut up
the warning.

Fixes: e6c1baa9b562 ("convert the rest of binfmt_elf_fdpic to dump_emit()")
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/binfmt_elf_fdpic.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1487,7 +1487,9 @@ static bool elf_fdpic_dump_segments(stru
 	struct vm_area_struct *vma;
 
 	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
+#ifdef CONFIG_MMU
 		unsigned long addr;
+#endif
 
 		if (!maydump(vma, cprm->mm_flags))
 			continue;
