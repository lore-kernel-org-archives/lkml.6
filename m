Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415391-2-18414357649579103549
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415390; b=i1ygxZ9HW+fCRNYjyFnZOVWGON40i9hmk/IcVauTl3L7vR8
    7CKdWBiuh2CcckEBoly7a4vDkaXfAk/JB8Z+TvxkijB2SXhgpGDCUZuav0BwYwP7
    70fD6rLwUC6ivStKrovPjWqGHPk14G0dAedCzkXU/yMNV/6lTWgQmp2xXBmH5DCa
    YZKaesfBQg7+c65eaG5PPdPMZSmXdZ0QeyOMa6rcJSIOvoxE6bmvNGff/hJHbWx1
    uZNgwGaxWL6m3D88T/myymb9BT6z5lsTQHkrD+hauPvFRDpMfffucji4IA9QkAMC
    22JQDQd5wU00bJBdZgHPtLJ0HSjYoOjlVJ6tI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415390; bh=+BgWrR6c0QURyueQyf+uZl+Iuv
    F6a/Mv9VcctJBoMgI=; b=r2X5QhYI1/l/hT721XRfI//OonJEqfORB+6cW6thqC
    e8LWwCMdKPEJacTcK7yzwV5wIAmheAI+SQm11wWRjnIgrWnJHImO9zF2YEaRal+n
    kBl0+6cDO2NRGjot6Po8HrdS3cJDJii+LNqCmXFNSl1jhuFefK97T5XRosRt+ZYr
    2SJyhs09wLDIkjZGTFFyy8jMcQbforDsfDqzMq8u4SKiXAo85KOOruR9nzL42FqC
    XqKRt2Ur/JtvuArzz3Bik5qTT8E2jiV4w0Sbmmd8CjVkE9aYIzHslWoe7ORYeRWL
    QSsKeajs4MJFSI/zz1vQzxd+oPRK7KmEBL4CQd0AuYEA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbeBWSqW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:46:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43686 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933989AbeBWSqT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 092/145] shmem: avoid maybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:26:38 +0100
Message-Id: <20180223170736.663120513@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 23f919d4ad0eb325595f10f55be4301b2965d6d6 upstream.

After enabling -Wmaybe-uninitialized warnings, we get a false-postive
warning for shmem:

  mm/shmem.c: In function `shmem_getpage_gfp':
  include/linux/spinlock.h:332:21: error: `info' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This can be easily avoided, since the correct 'info' pointer is known at
the time we first enter the function, so we can simply move the
initialization up.  Moving it before the first label avoids the warning
and lets us remove two later initializations.

Note that the function is so hard to read that it not only confuses the
compiler, but also most readers and without this patch it could\ easily
break if one of the 'goto's changed.

Link: https://www.spinics.net/lists/kernel/msg2368133.html
Link: http://lkml.kernel.org/r/20161024205725.786455-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1550,7 +1550,7 @@ static int shmem_getpage_gfp(struct inod
 	struct mm_struct *fault_mm, int *fault_type)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct shmem_inode_info *info;
+	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo;
 	struct mm_struct *charge_mm;
 	struct mem_cgroup *memcg;
@@ -1600,7 +1600,6 @@ repeat:
 	 * Fast cache lookup did not find it:
 	 * bring it back from swap or allocate.
 	 */
-	info = SHMEM_I(inode);
 	sbinfo = SHMEM_SB(inode->i_sb);
 	charge_mm = fault_mm ? : current->mm;
 
@@ -1852,7 +1851,6 @@ unlock:
 		put_page(page);
 	}
 	if (error == -ENOSPC && !once++) {
-		info = SHMEM_I(inode);
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
