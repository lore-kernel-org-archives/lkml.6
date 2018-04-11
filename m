Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1888220-1523436366-2-656903536084295888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523436365; b=pc5yCwwzYBHoXXLqCtmHHMdUUJQFrtfIyO2k09/wibpFlMTn+e
    Uvq29UcHh0ettQ4uRKhtHvsFGKtcw0SYDkF38AjuYXACFJgAe3IHCGY+E1Kk5P8s
    Qw5x0R+nzfSADAGsDjoFGDtsn2mj1S59eBCY31JxeYF3ehdJt+OIz8RmJj0f45bZ
    xrRgt5wSESMSqlqpwvaGcxhrZ7sUdS3oW0N2trvmdM4l+oYKnnzJET6dVTllrOQA
    W0T6pVCR4lWFSojfyrtw9PPqZ26fJJAuhe4D66xnC/WBJCsc1EpjFnA1CbRIKX9O
    4cR3wJImVIzcJjqLnQ8Fq+1gjUZnSFnBVH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523436365; bh=
    +GLz96st5Jt87YCQ86+JTaLsI2X9kQJ1IQIE5CVyIQM=; b=gN+bnrnvCsoYp9MI
    jWgEci/vL+4OzIE3xgBaKPuc87Yv50FlDFH6ZVkyLaZaE0UFch9JoEsP8srkA2XL
    5pwsLV34kZllzydPXvPDwyz+fHZCHD7UNTRskmqqXueBPuJAX75uG3CnggLrqMIM
    Pnhzw4fq8YC6jaJAQlhnx9skJ2pY/qr6e72WNawDj4K4HAdt6mCHBBEB/ecgGWSq
    KZx2I00jgmu1kJmUbHgo3njIfSpv4NiFicbKTJXu0oB34Rl36ycYxqIRQYAyszyk
    EupqeCTYeuIVmf2gWDpXOrMsS+d4uaG6iafrRKW5UQGhDh6ZxCcOqaeiTW+WCcSe
    0DApMg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Vh+GW+Zy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W9ggBZsP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Vh+GW+Zy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W9ggBZsP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9D03msPnbrqKXhfUsyXqURyMpAiqgrM7vxUObo34zyTLsWqEBXbYcINHQ4iRusirqc4UkIT/nOqiFzu3H8yzlPkQIBBcuQeuEQka2ogxNg253wUr4m
    1rBWsyweUyhM8ekT1xlLUCF6Vzt67Kq17mW+PNBxPwHUA/wKxgx7bVKSPD5EUc+sNXtlNPPZa9lqfGHFrepl1uVrXX2cCL+zA02+LLSF+OCfuOmvBsguDP0g
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=9Pvjed8DAAAA:8 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8
    a=BU5DGWs0jwVbzpSWCkUA:9 a=0StY-kYHBcAkSsZb:21 a=gSP-cljb-eiz5aWY:21
    a=AjGcO6oz07-iQ99wixmX:22 a=98p92QZDbKytObK42HRb:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeDKIpq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 04:45:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42497 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeDKIpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 04:45:39 -0400
X-Google-Smtp-Source: AIpwx4+yLyBRWkl6s39Bt326JHCjZzeeD0fa8v/K94AVUg+TZu4S0pEO1Rprtpy6WKIHCXrLPx8k5w==
From: Greg Thelen <gthelen@google.com>
To: Wang Long <wanglong19@meituan.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Cc: npiggin@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Greg Thelen <gthelen@google.com>,
        stable@vger.kernel.org
Subject: [PATCH for-4.4] writeback: safer lock nesting
Date: Wed, 11 Apr 2018 01:45:21 -0700
Message-Id: <20180411084521.254006-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <CAHH2K0bcehi-OH3AQs-VK7+d4-THOVXARTXik2UxRhZOuDrHTQ@mail.gmail.com>
References: <CAHH2K0bcehi-OH3AQs-VK7+d4-THOVXARTXik2UxRhZOuDrHTQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lock_page_memcg()/unlock_page_memcg() use spin_lock_irqsave/restore() if
the page's memcg is undergoing move accounting, which occurs when a
process leaves its memcg for a new one that has
memory.move_charge_at_immigrate set.

unlocked_inode_to_wb_begin,end() use spin_lock_irq/spin_unlock_irq() if the
given inode is switching writeback domains.  Switches occur when enough
writes are issued from a new domain.

This existing pattern is thus suspicious:
    lock_page_memcg(page);
    unlocked_inode_to_wb_begin(inode, &locked);
    ...
    unlocked_inode_to_wb_end(inode, locked);
    unlock_page_memcg(page);

If both inode switch and process memcg migration are both in-flight then
unlocked_inode_to_wb_end() will unconditionally enable interrupts while
still holding the lock_page_memcg() irq spinlock.  This suggests the
possibility of deadlock if an interrupt occurs before
unlock_page_memcg().

    truncate
    __cancel_dirty_page
    lock_page_memcg
    unlocked_inode_to_wb_begin
    unlocked_inode_to_wb_end
    <interrupts mistakenly enabled>
                                    <interrupt>
                                    end_page_writeback
                                    test_clear_page_writeback
                                    lock_page_memcg
                                    <deadlock>
    unlock_page_memcg

Due to configuration limitations this deadlock is not currently possible
because we don't mix cgroup writeback (a cgroupv2 feature) and
memory.move_charge_at_immigrate (a cgroupv1 feature).

If the kernel is hacked to always claim inode switching and memcg
moving_account, then this script triggers lockup in less than a minute:
  cd /mnt/cgroup/memory
  mkdir a b
  echo 1 > a/memory.move_charge_at_immigrate
  echo 1 > b/memory.move_charge_at_immigrate
  (
    echo $BASHPID > a/cgroup.procs
    while true; do
      dd if=/dev/zero of=/mnt/big bs=1M count=256
    done
  ) &
  while true; do
    sync
  done &
  sleep 1h &
  SLEEP=$!
  while true; do
    echo $SLEEP > a/cgroup.procs
    echo $SLEEP > b/cgroup.procs
  done

The deadlock does not seem possible, so it's debatable if there's
any reason to modify the kernel.  I suggest we should to prevent future
surprises.  And Wang Long said "this deadlock occurs three times in our
environment", so there's more reason to apply this, even to stable.

[ This patch is only for 4.4 stable.  Newer stable kernels should use be able to
  cherry pick the upstream "writeback: safer lock nesting" patch. ]

Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Cc: stable@vger.kernel.org # v4.2+
Reported-by: Wang Long <wanglong19@meituan.com>
Signed-off-by: Greg Thelen <gthelen@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Wang Long <wanglong19@meituan.com>
---
 fs/fs-writeback.c                |  7 ++++---
 include/linux/backing-dev-defs.h |  5 +++++
 include/linux/backing-dev.h      | 31 +++++++++++++++++--------------
 mm/page-writeback.c              | 18 +++++++++---------
 4 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 22b30249fbcb..0fe667875852 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -747,11 +747,12 @@ int inode_congested(struct inode *inode, int cong_bits)
 	 */
 	if (inode && inode_to_wb_is_valid(inode)) {
 		struct bdi_writeback *wb;
-		bool locked, congested;
+		struct wb_lock_cookie lock_cookie = {};
+		bool congested;
 
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &lock_cookie);
 		congested = wb_congested(wb, cong_bits);
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &lock_cookie);
 		return congested;
 	}
 
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 140c29635069..a307c37c2e6c 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -191,6 +191,11 @@ static inline void set_bdi_congested(struct backing_dev_info *bdi, int sync)
 	set_wb_congested(bdi->wb.congested, sync);
 }
 
+struct wb_lock_cookie {
+	bool locked;
+	unsigned long flags;
+};
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 /**
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 89d3de3e096b..361274ce5815 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -366,7 +366,7 @@ static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 /**
  * unlocked_inode_to_wb_begin - begin unlocked inode wb access transaction
  * @inode: target inode
- * @lockedp: temp bool output param, to be passed to the end function
+ * @cookie: output param, to be passed to the end function
  *
  * The caller wants to access the wb associated with @inode but isn't
  * holding inode->i_lock, mapping->tree_lock or wb->list_lock.  This
@@ -374,12 +374,12 @@ static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
  * association doesn't change until the transaction is finished with
  * unlocked_inode_to_wb_end().
  *
- * The caller must call unlocked_inode_to_wb_end() with *@lockdep
- * afterwards and can't sleep during transaction.  IRQ may or may not be
- * disabled on return.
+ * The caller must call unlocked_inode_to_wb_end() with *@cookie afterwards and
+ * can't sleep during the transaction.  IRQs may or may not be disabled on
+ * return.
  */
 static inline struct bdi_writeback *
-unlocked_inode_to_wb_begin(struct inode *inode, bool *lockedp)
+unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 {
 	rcu_read_lock();
 
@@ -387,10 +387,10 @@ unlocked_inode_to_wb_begin(struct inode *inode, bool *lockedp)
 	 * Paired with store_release in inode_switch_wb_work_fn() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
-	*lockedp = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
+	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
 
-	if (unlikely(*lockedp))
-		spin_lock_irq(&inode->i_mapping->tree_lock);
+	if (unlikely(cookie->locked))
+		spin_lock_irqsave(&inode->i_mapping->tree_lock, cookie->flags);
 
 	/*
 	 * Protected by either !I_WB_SWITCH + rcu_read_lock() or tree_lock.
@@ -402,12 +402,14 @@ unlocked_inode_to_wb_begin(struct inode *inode, bool *lockedp)
 /**
  * unlocked_inode_to_wb_end - end inode wb access transaction
  * @inode: target inode
- * @locked: *@lockedp from unlocked_inode_to_wb_begin()
+ * @cookie: @cookie from unlocked_inode_to_wb_begin()
  */
-static inline void unlocked_inode_to_wb_end(struct inode *inode, bool locked)
+static inline void unlocked_inode_to_wb_end(struct inode *inode,
+					    struct wb_lock_cookie *cookie)
 {
-	if (unlikely(locked))
-		spin_unlock_irq(&inode->i_mapping->tree_lock);
+	if (unlikely(cookie->locked))
+		spin_unlock_irqrestore(&inode->i_mapping->tree_lock,
+				       cookie->flags);
 
 	rcu_read_unlock();
 }
@@ -454,12 +456,13 @@ static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 }
 
 static inline struct bdi_writeback *
-unlocked_inode_to_wb_begin(struct inode *inode, bool *lockedp)
+unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 {
 	return inode_to_wb(inode);
 }
 
-static inline void unlocked_inode_to_wb_end(struct inode *inode, bool locked)
+static inline void unlocked_inode_to_wb_end(struct inode *inode,
+					    struct wb_lock_cookie *cookie)
 {
 }
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6d0dbde4503b..3309dbda7ffa 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2510,13 +2510,13 @@ void account_page_redirty(struct page *page)
 	if (mapping && mapping_cap_account_dirty(mapping)) {
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
-		bool locked;
+		struct wb_lock_cookie cookie = {};
 
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		current->nr_dirtied--;
 		dec_zone_page_state(page, NR_DIRTIED);
 		dec_wb_stat(wb, WB_DIRTIED);
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &cookie);
 	}
 }
 EXPORT_SYMBOL(account_page_redirty);
@@ -2622,15 +2622,15 @@ void cancel_dirty_page(struct page *page)
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
 		struct mem_cgroup *memcg;
-		bool locked;
+		struct wb_lock_cookie cookie = {};
 
 		memcg = mem_cgroup_begin_page_stat(page);
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
 		if (TestClearPageDirty(page))
 			account_page_cleaned(page, mapping, memcg, wb);
 
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &cookie);
 		mem_cgroup_end_page_stat(memcg);
 	} else {
 		ClearPageDirty(page);
@@ -2663,7 +2663,7 @@ int clear_page_dirty_for_io(struct page *page)
 		struct inode *inode = mapping->host;
 		struct bdi_writeback *wb;
 		struct mem_cgroup *memcg;
-		bool locked;
+		struct wb_lock_cookie cookie = {};
 
 		/*
 		 * Yes, Virginia, this is indeed insane.
@@ -2701,14 +2701,14 @@ int clear_page_dirty_for_io(struct page *page)
 		 * exclusion.
 		 */
 		memcg = mem_cgroup_begin_page_stat(page);
-		wb = unlocked_inode_to_wb_begin(inode, &locked);
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		if (TestClearPageDirty(page)) {
 			mem_cgroup_dec_page_stat(memcg, MEM_CGROUP_STAT_DIRTY);
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 			dec_wb_stat(wb, WB_RECLAIMABLE);
 			ret = 1;
 		}
-		unlocked_inode_to_wb_end(inode, locked);
+		unlocked_inode_to_wb_end(inode, &cookie);
 		mem_cgroup_end_page_stat(memcg);
 		return ret;
 	}
-- 
2.17.0.484.g0c8726318c-goog
